. .\PS-Forms.ps1
Connect-PnPOnline -Url https://zergs.sharepoint.com
$lists = Get-PnPList
$list = Get-FormArrayItem $lists -key "Title"

Write-Host Selected list: $list.Title