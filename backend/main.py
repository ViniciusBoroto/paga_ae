from __future__ import annotations

from copy import deepcopy
from datetime import datetime

from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel

from mock_data import MOCK_CHARGES, MOCK_EVENTS, MOCK_USERS

app = FastAPI(
    title="Cash Flow Mock API",
    version="0.1.0",
    description="Simple mocked backend for the Flutter/Dart project.",
)

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

users = deepcopy(MOCK_USERS)
events = deepcopy(MOCK_EVENTS)
charges = deepcopy(MOCK_CHARGES)


class LoginRequest(BaseModel):
    email: str
    password: str


class RegisterRequest(BaseModel):
    name: str
    email: str
    password: str


class CreateEventRequest(BaseModel):
    title: str
    date: datetime
    creatorId: int | None = None


class AddExpenditureRequest(BaseModel):
    description: str
    amount: float


def sanitize_user(user: dict) -> dict:
    return {key: value for key, value in user.items() if key != "password"}


def next_id(items: list[dict]) -> int:
    return max((item["id"] for item in items), default=0) + 1


def find_user(user_id: int) -> dict:
    user = next((item for item in users if item["id"] == user_id), None)
    if user is None:
        raise HTTPException(status_code=404, detail="User not found")
    return user


def find_event(event_id: int) -> dict:
    event = next((item for item in events if item["id"] == event_id), None)
    if event is None:
        raise HTTPException(status_code=404, detail="Event not found")
    return event


def find_charge(charge_id: int) -> dict:
    charge = next((item for item in charges if item["id"] == charge_id), None)
    if charge is None:
        raise HTTPException(status_code=404, detail="Charge not found")
    return charge


@app.get("/")
def read_root() -> dict[str, str]:
    return {"message": "Cash Flow mock API is running"}


@app.get("/health")
def healthcheck() -> dict[str, str]:
    return {"status": "ok"}


@app.get("/users")
def list_users() -> list[dict]:
    return [sanitize_user(user) for user in users]


@app.get("/users/{user_id}")
def get_user(user_id: int) -> dict:
    return sanitize_user(find_user(user_id))


@app.post("/auth/login")
def login(payload: LoginRequest) -> dict:
    user = next(
        (
            item
            for item in users
            if item["email"].lower() == payload.email.lower()
            and item["password"] == payload.password
        ),
        None,
    )
    if user is None:
        raise HTTPException(status_code=401, detail="Invalid credentials")
    return sanitize_user(user)


@app.post("/auth/register")
def register(payload: RegisterRequest) -> dict:
    already_exists = any(
        item["email"].lower() == payload.email.lower() for item in users
    )
    if already_exists:
        raise HTTPException(status_code=409, detail="Email already registered")

    user = {
        "id": next_id(users),
        "name": payload.name,
        "email": payload.email,
        "password": payload.password,
    }
    users.append(user)
    return sanitize_user(user)


@app.get("/events")
def list_events() -> list[dict]:
    return events


@app.get("/events/{event_id}")
def get_event(event_id: int) -> dict:
    return find_event(event_id)


@app.post("/events")
def create_event(payload: CreateEventRequest) -> dict:
    participants = []
    if payload.creatorId is not None:
        participants.append(sanitize_user(find_user(payload.creatorId)))

    event = {
        "id": next_id(events),
        "title": payload.title,
        "date": payload.date.isoformat(),
        "status": "upcoming",
        "participants": participants,
        "expenditures": [],
        "createdAt": datetime.utcnow().isoformat(),
        "finalizedAt": None,
        "canceledAt": None,
    }
    events.insert(0, event)
    return event


@app.delete("/events/{event_id}")
def delete_event(event_id: int) -> dict[str, bool]:
    find_event(event_id)
    events[:] = [event for event in events if event["id"] != event_id]
    charges[:] = [charge for charge in charges if charge["eventId"] != event_id]
    return {"success": True}


@app.patch("/events/{event_id}/finalize")
def finalize_event(event_id: int) -> dict:
    event = find_event(event_id)
    event["status"] = "finalized"
    event["finalizedAt"] = datetime.utcnow().isoformat()
    return event


@app.post("/events/{event_id}/expenditures")
def add_expenditure(event_id: int, payload: AddExpenditureRequest) -> dict:
    event = find_event(event_id)
    all_expenditures = [
        expenditure
        for current_event in events
        for expenditure in current_event.get("expenditures", [])
    ]
    expenditure = {
        "id": next_id(all_expenditures),
        "description": payload.description,
        "amount": payload.amount,
        "eventId": event_id,
    }
    event.setdefault("expenditures", []).append(expenditure)
    return expenditure


@app.get("/charges")
def list_charges() -> list[dict]:
    return charges


@app.get("/charges/{charge_id}")
def get_charge(charge_id: int) -> dict:
    return find_charge(charge_id)


@app.patch("/charges/{charge_id}/pay")
def pay_charge(charge_id: int) -> dict:
    charge = find_charge(charge_id)
    charge["paidAt"] = datetime.utcnow().isoformat()
    return charge


if __name__ == "__main__":
    import uvicorn

    uvicorn.run(app, host="0.0.0.0", port=8000)
