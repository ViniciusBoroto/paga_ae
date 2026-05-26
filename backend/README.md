# Cash Flow Mock Backend

## Run

```bash
cd backend
python -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
uvicorn main:app --reload
```

## Endpoints

- `GET /`
- `GET /health`
- `GET /users`
- `GET /users/{user_id}`
- `GET /events`
- `GET /events/{event_id}`
- `GET /charges`
- `GET /charges/{charge_id}`
