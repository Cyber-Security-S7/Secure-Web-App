# Use the official ASP.NET 8.0 runtime as the base image for running the application
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
WORKDIR /app
EXPOSE 8080
EXPOSE 443

# Use the official .NET 8.0 SDK image to build the application
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# Copy the entire solution folder
COPY ./Secure-Web-App ./Secure-Web-App

# Restore dependencies
WORKDIR /src/Secure-Web-App
RUN dotnet restore "Secure-Web-App.sln"

# Build the application
RUN dotnet build "Secure-Web-App.Blazor/Secure-Web-App.Blazor.csproj" -c Release -o /app/build

# Publish the application to a folder called 'publish'
FROM build AS publish
RUN dotnet publish "Secure-Web-App.Blazor/Secure-Web-App.Blazor.csproj" -c Release /p:EnvironmentName=Production -o /app/publish --no-restore

# Final stage: Use the ASP.NET runtime to run the published Blazor Server application
FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .

# Set the entry point for the Docker container
ENTRYPOINT ["dotnet", "Secure-Web-App.Blazor.dll"]