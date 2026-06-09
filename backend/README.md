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
- `POST /auth/login`
- `POST /auth/register`
- `GET /users`
- `GET /users/{user_id}`
- `GET /events`
- `GET /events/{event_id}`
- `POST /events`
- `DELETE /events/{event_id}`
- `PATCH /events/{event_id}/finalize`
- `POST /events/{event_id}/expenditures`
- `GET /charges`
- `GET /charges/{charge_id}`
- `PATCH /charges/{charge_id}/pay`

## Credenciais mockadas

- `vinicius@cashflow.dev` / `123456`
- `ana@cashflow.dev` / `123456`
- `carlos@cashflow.dev` / `123456`
