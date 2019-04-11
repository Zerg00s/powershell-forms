# -------------------------------------------------------------------------------
# This script logs you in to Azure via Azure Cli and adds SendGrid API Key to the 
# App settings. Refer to the deployment guide for more details
# -------------------------------------------------------------------------------
$ErrorActionPreference = "Stop"

if ($psISE) { $scriptLocation = Split-Path -Path $psISE.CurrentFile.FullPath }
else { $scriptLocation = $PSScriptRoot }
Set-Location $scriptLocation


try {

    $loginResult = az login
    $accounts = az account list | ConvertFrom-Json
    . ..\..\PS-Forms.ps1
    $subscription = Get-FormsArrayItem -items $accounts -key "name" -dialogTitle "Choose subscription"
    $resourceGroups = az group list --subscription $subscription.id | ConvertFrom-Json
    $resourceGroup = Get-FormsArrayItem -items $resourceGroups -key "name" -dialogTitle "Choose resource group"       
    $preDeployInputs = Get-FormsItemProperties -item $preDeployInputs -dialogTitle "Fill these required fields"

}
catch {
    $Error
    Read-Host
}

Write-Host "[Success] You can close this window." -ForegroundColor Green
Read-Host 