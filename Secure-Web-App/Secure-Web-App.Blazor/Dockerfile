FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
USER $APP_UID
WORKDIR /app
EXPOSE 8080
EXPOSE 8081

FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
ARG BUILD_CONFIGURATION=Release
WORKDIR /src
COPY ["Secure-Web-App.Blazor/Secure-Web-App.Blazor.csproj", "Secure-Web-App.Blazor/"]
RUN dotnet restore "Secure-Web-App.Blazor/Secure-Web-App.Blazor.csproj"
COPY . .
WORKDIR "/src/Secure-Web-App.Blazor"
RUN dotnet build "Secure-Web-App.Blazor.csproj" -c $BUILD_CONFIGURATION -o /app/build

FROM build AS publish
ARG BUILD_CONFIGURATION=Release
RUN dotnet publish "Secure-Web-App.Blazor.csproj" -c $BUILD_CONFIGURATION -o /app/publish /p:UseAppHost=false

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "Secure-Web-App.Blazor.dll"]
