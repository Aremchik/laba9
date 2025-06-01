# Этап сборки
FROM mcr.microsoft.com/dotnet/sdk:9.0-preview AS build
WORKDIR /src
COPY HelloNet/*.csproj ./HelloNet/
WORKDIR /src/HelloNet
RUN dotnet restore
COPY HelloNet/. .
RUN dotnet publish -c Release -o /app/out

# Этап выполнения
FROM mcr.microsoft.com/dotnet/runtime:9.0-preview
WORKDIR /app
COPY --from=build /app/out .
ENTRYPOINT ["dotnet", "HelloNet.dll"]
