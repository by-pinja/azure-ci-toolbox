FROM mcr.microsoft.com/powershell:7.0.0-preview.6-ubuntu-18.04

COPY ./Login.ps1 /etc/util-scripts/Login.ps1

RUN pwsh -command 'Install-Module -Name Az -AllowClobber -Scope CurrentUser -Force' && \
    chmod +x /etc/util-scripts/Login.ps1
