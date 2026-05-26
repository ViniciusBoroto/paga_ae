from __future__ import annotations

MOCK_USERS = [
    {"id": 1, "name": "Vinicius", "email": "vinicius@cashflow.dev"},
    {"id": 2, "name": "Ana", "email": "ana@cashflow.dev"},
    {"id": 3, "name": "Carlos", "email": "carlos@cashflow.dev"},
]

MOCK_EVENTS = [
    {
        "id": 1,
        "title": "Churrasco da turma",
        "date": "2026-06-05T18:30:00",
        "status": "upcoming",
        "participants": [MOCK_USERS[0], MOCK_USERS[1], MOCK_USERS[2]],
        "expenditures": [
            {
                "id": 1,
                "description": "Carnes e bebidas",
                "amount": 240.0,
                "eventId": 1,
            },
            {
                "id": 2,
                "description": "Carvao e gelo",
                "amount": 65.5,
                "eventId": 1,
            },
        ],
        "createdAt": "2026-05-20T10:00:00",
        "finalizedAt": None,
        "canceledAt": None,
    },
    {
        "id": 2,
        "title": "Viagem de fim de semana",
        "date": "2026-05-10T08:00:00",
        "status": "finalized",
        "participants": [MOCK_USERS[0], MOCK_USERS[2]],
        "expenditures": [
            {
                "id": 3,
                "description": "Combustivel",
                "amount": 180.0,
                "eventId": 2,
            },
            {
                "id": 4,
                "description": "Hospedagem",
                "amount": 320.0,
                "eventId": 2,
            },
        ],
        "createdAt": "2026-05-01T09:30:00",
        "finalizedAt": "2026-05-12T21:00:00",
        "canceledAt": None,
    },
]

MOCK_CHARGES = [
    {
        "id": 1,
        "amount": 101.83,
        "fromUserId": 2,
        "toUserId": 1,
        "eventId": 1,
        "createdAt": "2026-05-20T10:30:00",
        "paidAt": None,
    },
    {
        "id": 2,
        "amount": 101.83,
        "fromUserId": 3,
        "toUserId": 1,
        "eventId": 1,
        "createdAt": "2026-05-20T10:30:00",
        "paidAt": "2026-05-25T14:15:00",
    },
    {
        "id": 3,
        "amount": 250.0,
        "fromUserId": 3,
        "toUserId": 1,
        "eventId": 2,
        "createdAt": "2026-05-12T21:05:00",
        "paidAt": None,
    },
]
