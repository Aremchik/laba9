FROM python:3.11-slim

WORKDIR /app

# Копируем requirements.txt и устанавливаем зависимости
COPY requirements.txt .

RUN pip install --upgrade pip && pip install -r requirements.txt

# Копируем весь код в контейнер
COPY . .

# Открываем порт для доступа
EXPOSE 8000

# Запускаем приложение через python -m uvicorn
CMD ["python", "-m", "uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
