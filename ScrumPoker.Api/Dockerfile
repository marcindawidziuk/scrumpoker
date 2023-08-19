FROM mcr.microsoft.com/dotnet/aspnet:7.0 AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
WORKDIR /src
COPY ["ScrumPoker.Api/ScrumPoker.Api.csproj", "ScrumPoker.Api/"]
RUN dotnet restore "ScrumPoker.Api/ScrumPoker.Api.csproj"
COPY . .
WORKDIR "/src/ScrumPoker.Api"
RUN dotnet build "ScrumPoker.Api.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "ScrumPoker.Api.csproj" -c Release -o /app/publish /p:UseAppHost=false

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "ScrumPoker.Api.dll"]
