FROM mcr.microsoft.com/dotnet/sdk:9.0@sha256:3fcf6f1e809c0553f9feb222369f58749af314af6f063f389cbd2f913b4ad556 AS build
WORKDIR /app

COPY . ./
# Restore dependencies separately for laying optimizations
RUN dotnet restore GagSpeakServerCollection/GagSpeakServer/GagSpeakServer.csproj

RUN dotnet publish GagSpeakServerCollection/GagSpeakServer/GagSpeakServer.csproj -o out/server
RUN dotnet publish GagSpeakServerCollection/GagSpeakAuthentication/GagSpeakAuthentication.csproj -o out/auth
RUN dotnet publish GagSpeakServerCollection/GagSpeakDiscord/GagSpeakDiscord.csproj -o out/discord

# Use the actual runtime image to lose the SDK cruft for al ighter image.
FROM mcr.microsoft.com/dotnet/aspnet:9.0@sha256:b4bea3a52a0a77317fa93c5bbdb076623f81e3e2f201078d89914da71318b5d8 AS server

WORKDIR /app

COPY --from=build /app/out/server .

ENTRYPOINT ["dotnet", "GagSpeakServer.dll"]

FROM mcr.microsoft.com/dotnet/aspnet:9.0@sha256:b4bea3a52a0a77317fa93c5bbdb076623f81e3e2f201078d89914da71318b5d8 AS auth

WORKDIR /app

COPY --from=build /app/out/auth .

ENTRYPOINT ["dotnet", "GagSpeakAuthentication.dll"]

FROM mcr.microsoft.com/dotnet/aspnet:9.0@sha256:b4bea3a52a0a77317fa93c5bbdb076623f81e3e2f201078d89914da71318b5d8 AS discord

WORKDIR /app

COPY --from=build /app/out/discord .

ENTRYPOINT ["dotnet", "GagSpeakDiscord.dll"]
