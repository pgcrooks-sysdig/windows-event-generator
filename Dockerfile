ARG SERVER_VERSION

FROM mcr.microsoft.com/powershell:7.4-windowsservercore-ltsc${SERVER_VERSION}

LABEL maintainer="Paul Crooks <paul.crooks@sysdig.com>"

RUN mkdir EventGen

COPY Entrypoint.ps1 EventGen/

ENTRYPOINT ["powershell", "C:/EventGen/Entrypoint.ps1"]
