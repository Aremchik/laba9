# Этап сборки - устанавливаем зависимости
FROM python:3.11-slim AS build

WORKDIR /app

# Копируем файл зависимостей
COPY requirements.txt .

# Устанавливаем gcc и другие зависимости для сборки пакетов
RUN apt-get update && apt-get install -y gcc && \
    pip install --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# Копируем приложение
COPY . .

# Этап запуска - минимальный образ
FROM python:3.11-alpine

WORKDIR /app

# Копируем зависимости из build
COPY --from=build /usr/local/lib/python3.11/site-packages /usr/local/lib/python3.11/site-packages
COPY --from=build /app .

# Пробрасываем порт
EXPOSE 8000

# Запускаем приложение
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
