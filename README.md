# Windows Event Generator

Very basic Event Generator for Windows. This is intended only for Agent developers to make some event noise.

## Versions
- Windows Server 2022

## Build
```powershell
PS > docker build -t win-event-gen:latest-2022 -f .\Dockerfile.2022 .
```

## Run
```powershell
PS > docker run -t --rm win-event-gen:latest-2022
```
