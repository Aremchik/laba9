FROM python:3.11-slim as builder
WORKDIR /app
COPY app.py .

FROM python:3.11-alpine
WORKDIR /app
COPY --from=builder /app/app.py .
CMD ["python", "app.py"]
