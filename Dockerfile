# Use the official ASP.NET 8.0 runtime as the base image for running the application
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
WORKDIR /app
EXPOSE 80
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

# Install OpenSSL for certificate generation
RUN apt-get update && apt-get install -y openssl

# Create the directory where the certificate will be stored
RUN mkdir -p /app/https

# Generate a self-signed certificate (private key and cert)
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /app/https/aspnetapp.key \
    -out /app/https/aspnetapp.crt \
    -subj "/CN=localhost"

# Combine the certificate and the key into a PFX file (which is required by ASP.NET Core)
# Warning: Not Secure for Production, only used for local development purposes.
RUN openssl pkcs12 -export -out /app/https/aspnetapp.pfx \
    -inkey /app/https/aspnetapp.key -in /app/https/aspnetapp.crt -password pass:yourpassword

# Copy the published app
COPY --from=publish /app/publish .

# Set environment variables for the certificate location and password
ENV ASPNETCORE_Kestrel__Certificates__Default__Path=/app/https/aspnetapp.pfx
# Warning: Not Secure for Production, only used for local development purposes.
ENV ASPNETCORE_Kestrel__Certificates__Default__Password=yourpassword


# Set the entry point for the Docker container
ENTRYPOINT ["dotnet", "Secure-Web-App.Blazor.dll"]
