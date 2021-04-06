Import-Module WebAdministration
Rename-Item 'IIS:\Sites\Default Web Site' 'OTCS'
Rename-Item 'IIS:\AppPools\DefaultAppPool' 'OTCS'
New-WebSite -Name OTCSws -Port 80 -HostHeader OTCSws -PhysicalPath "%SystemDrive%\inetpub\wwwroot"
New-WebAppPool OTCSws
Set-ItemProperty IIS:\AppPools\OTCSws managedRuntimeVersion v2.0
Set-ItemProperty 'IIS:\Sites\OTCSws' applicationPool OTCSws
Set-ItemProperty 'IIS:\Sites\OTCS' applicationPool OTCS
Set-ItemProperty "IIS:\Sites\OTCS" -name logFile.directory -value "C:\IIS-Logs"
Set-ItemProperty "IIS:\Sites\OTCSws" -name logFile.directory -value "C:\IIS-LogsWS"
Set-ItemProperty "IIS:\AppPools\OTCS" -Name processModel.idleTimeout -value ( [TimeSpan]::FromMinutes(0))
Set-ItemProperty "IIS:\AppPools\OTCS" -Name recycling.periodicRestart.time -Value 0.00:00:00
Set-ItemProperty "IIS:\AppPools\OTCS" -Name Recycling.periodicRestart.schedule -Value @{value="00:00"}
Remove-WebConfigurationProperty -PSPath 'MACHINE/WEBROOT/APPHOST' -Filter system.webServer/httpProtocol/customHeaders -Name . -AtElement @{name='X-Powered-By'}
