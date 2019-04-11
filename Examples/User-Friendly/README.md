# About this example
It is helpful to be able to just double click a BAT file instead of running PowerShell.

But in this case we need to make sure your PowerShell includes these lines:

```
if ($psISE) { $scriptLocation = Split-Path -Path $psISE.CurrentFile.FullPath }
else { $scriptLocation = $PSScriptRoot }
Set-Location $scriptLocation
```

See example in the PowerShell file.