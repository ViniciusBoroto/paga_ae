from __future__ import annotations

from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware

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


@app.get("/")
def read_root() -> dict[str, str]:
    return {"message": "Cash Flow mock API is running"}


@app.get("/health")
def healthcheck() -> dict[str, str]:
    return {"status": "ok"}


@app.get("/users")
def list_users() -> list[dict]:
    return MOCK_USERS


@app.get("/users/{user_id}")
def get_user(user_id: int) -> dict:
    user = next((item for item in MOCK_USERS if item["id"] == user_id), None)
    if user is None:
        raise HTTPException(status_code=404, detail="User not found")
    return user


@app.get("/events")
def list_events() -> list[dict]:
    return MOCK_EVENTS


@app.get("/events/{event_id}")
def get_event(event_id: int) -> dict:
    event = next((item for item in MOCK_EVENTS if item["id"] == event_id), None)
    if event is None:
        raise HTTPException(status_code=404, detail="Event not found")
    return event


@app.get("/charges")
def list_charges() -> list[dict]:
    return MOCK_CHARGES


@app.get("/charges/{charge_id}")
def get_charge(charge_id: int) -> dict:
    charge = next((item for item in MOCK_CHARGES if item["id"] == charge_id), None)
    if charge is None:
        raise HTTPException(status_code=404, detail="Charge not found")
    return charge


if __name__ == "__main__":
    import uvicorn

    uvicorn.run(app, host="0.0.0.0", port=8000)