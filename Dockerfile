# Этап сборки
FROM mcr.microsoft.com/dotnet/sdk:9.0-preview AS build
WORKDIR /src

# Копируем только проект
COPY HelloNet/*.csproj ./HelloNet/
WORKDIR /src/HelloNet

# Восстанавливаем зависимости
RUN dotnet restore

# Копируем остальные файлы
COPY HelloNet/. .

# Публикуем приложение
RUN dotnet publish -c Release -o /app/out

# Этап выполнения
FROM mcr.microsoft.com/dotnet/runtime:8.0
WORKDIR /app
COPY --from=build /app/out .
ENTRYPOINT ["dotnet", "HelloNet.dll"]
