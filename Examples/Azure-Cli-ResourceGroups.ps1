
# -------------------------------------------------------------------------------
# Prerequisites: Azure Cli
# Download from here: https://docs.microsoft.com/en-us/cli/azure/install-azure-cli-windows?view=azure-cli-latest
# -------------------------------------------------------------------------------

# -------------------------------------------------------------------------------
# Updates the Azure Function App via ZIP Deployment.
# You will be asked to select your existing Subscription and a Resource Group
# The script assumes that ..\FunctionApp.zip file is present
# -------------------------------------------------------------------------------

$ErrorActionPreference = "Stop"

if ($psISE) { $scriptLocation = Split-Path -Path $psISE.CurrentFile.FullPath }
else { $scriptLocation = $PSScriptRoot }
Set-Location $scriptLocation
Write-Host $PSScriptRoot


try {

    $loginResult = az login
    $accounts = az account list | ConvertFrom-Json
    . ..\PS-Forms.ps1
    $subscription = Get-FormArrayItem -items $accounts -key "name" -dialogTitle "Choose subscription"
 
    $createNewResourceGroup = Get-FormBinaryAnswer "Do you want to create a new Resource Group?"
    if ($createNewResourceGroup) {
        # -------------------------------------------------------------------------------
        # Display a dialog box that asks to enter a new Resource group name
        # -------------------------------------------------------------------------------
        $resourceGroupName = Get-FormStringInput "Enter new resource group name" -defaultValue "Comments-Notification"
        $locations = az account list-locations | ConvertFrom-Json
        $location = Get-FormArrayItem -items $locations -key "displayName" -dialogTitle "Choose location" -defaultValue "Canada Central"
    
    }
    else {
        $resourceGroups = az group list --subscription $subscription.id | ConvertFrom-Json
        # -------------------------------------------------------------------------------
        # Display a dialog box that lists all resource groups within the current subscription.
        # User will be asked to select one resource group to continue deployment. 
        # -------------------------------------------------------------------------------
        $resourceGroup = Get-FormArrayItem -items $resourceGroups -key "name" -dialogTitle "Choose resource group"   
        $resourceGroupName = $resourceGroup.name
        $location = $resourceGroup.location
    }
    $locationName = $location.displayName

    
    
    # TODO: do something with the selected resource group
}
catch {
    $Error
    Read-Host
}

Write-Host "[Success] Application updated. You can close this window." -ForegroundColor Green
Read-Host 