# PagaAE

Aplicativo Flutter para gerenciar eventos, gastos compartilhados e cobrancas entre participantes.

## Como rodar para teste

### 1. Subir a API mockada

```bash
cd /Users/kaua/Desktop/paga_ae/backend
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
uvicorn main:app --reload
```

A API vai ficar disponivel em `http://127.0.0.1:8000`.

### 2. Rodar o app Flutter

Em outro terminal:

```bash
cd /Users/kaua/Desktop/paga_ae
source ~/.zshrc
flutter pub get
flutter run -d "iPhone"
```

Se o Flutter pedir para escolher o dispositivo, selecione o simulador listado.

## Usuario para teste

Use qualquer uma destas credenciais mockadas:

- Email: `vinicius@cashflow.dev`
  Senha: `123456`
- Email: `ana@cashflow.dev`
  Senha: `123456`
- Email: `carlos@cashflow.dev`
  Senha: `123456`

## Observacoes

- O app agora consome a API mockada local em `http://127.0.0.1:8000`.
- Em simulador iOS, `127.0.0.1` funciona normalmente.
- Em dispositivo fisico, sera preciso trocar a URL da API para o IP da maquina na mesma rede.
