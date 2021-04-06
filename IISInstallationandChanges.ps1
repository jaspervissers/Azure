#  Log file time stamp:
$LogTime = Get-Date -Format "MM-dd-yyyy_hh-mm-ss"
#  Log file name:
$LogPath = "D:\ScriptLogging\"
if([IO.Directory]::Exists($LogPath))
{
#Do Nothing!!
}
else
{
New-Item -ItemType directory -Path D:\ScriptLogging\
}
$LogFile = 'D:\ScriptLogging\'+$ser+$LogTime+" IIS10.0 Installation.txt"
"Servername: $env:computername" | Out-File $LogFile -Append -Force
"UserName: $env:username" | Out-File $LogFile -Append -Force

$ServerName = "$env:computername"

#IIS 10.0 Server Installation (Role)
"Installation of Web Server (IIS)" | Out-File $LogFile -Append -Force
Install-WindowsFeature -Name Web-Server -ComputerName $ServerName –IncludeManagementTools | Out-File $LogFile -Append -Force

"Installation of HTTP Redirection" | Out-File $LogFile -Append -Force
Install-WindowsFeature -Name Web-Http-Redirect -ComputerName $ServerName –IncludeManagementTools | Out-File $LogFile -Append -Force

#Health and diagnostics (Services)
"Installation of Request Monitor" | Out-File $LogFile -Append -Force
Install-WindowsFeature -Name Web-Request-Monitor -ComputerName $ServerName | Out-File $LogFile -Append -Force

#Application Development Section (Services)
"Installation of .NET Extensibility 4.6" | Out-File $LogFile -Append -Force
Install-WindowsFeature -Name Web-Net-Ext -ComputerName $ServerName | Out-File $LogFile -Append -Force

"Installation of .NET ASP 3.5" | Out-File $LogFile -Append -Force
Install-WindowsFeature -Name Web-Asp-Net -ComputerName $ServerName | Out-File $LogFile -Append -Force

"Installation of .NET ASP 4.6" | Out-File $LogFile -Append -Force
Install-WindowsFeature -Name Web-Asp-Net45 -ComputerName $ServerName | Out-File $LogFile -Append -Force

"Installation of CGI" | Out-File $LogFile -Append -Force
Install-WindowsFeature -Name Web-CGI -ComputerName $ServerName | Out-File $LogFile -Append -Force

"Installation of ISAPI Extentions" | Out-File $LogFile -Append -Force
Install-WindowsFeature -Name Web-ISAPI-Ext -ComputerName $ServerName | Out-File $LogFile -Append -Force

"Installation of ISAPI Filters" | Out-File $LogFile -Append -Force
Install-WindowsFeature -Name Web-ISAPI-Filter -ComputerName $ServerName | Out-File $LogFile -Append -Force

Import-Module WebAdministration
Rename-Item 'IIS:\Sites\Default Web Site' 'OTCS'
Rename-Item 'IIS:\AppPools\DefaultAppPool' 'OTCS'
New-WebSite -Name OTCSws -Port 80 -HostHeader OTCSws -PhysicalPath "%SystemDrive%\inetpub\wwwroot"
New-WebAppPool OTCSws
Set-ItemProperty IIS:\AppPools\OTCSws managedRuntimeVersion v2.0
Set-ItemProperty 'IIS:\Sites\OTCSws' applicationPool OTCSws
Set-ItemProperty 'IIS:\Sites\OTCS' applicationPool OTCS
Set-ItemProperty "IIS:\Sites\OTCS" -name logFile.directory -value "D:\IIS-Logs"
Set-ItemProperty "IIS:\Sites\OTCSws" -name logFile.directory -value "D:\IIS-LogsWS"
Set-ItemProperty "IIS:\AppPools\OTCS" -Name processModel.idleTimeout -value ( [TimeSpan]::FromMinutes(0))
Set-ItemProperty "IIS:\AppPools\OTCS" -Name recycling.periodicRestart.time -Value 0.00:00:00
Set-ItemProperty "IIS:\AppPools\OTCS" -Name Recycling.periodicRestart.schedule -Value @{value="00:00"}
Remove-WebConfigurationProperty -PSPath 'MACHINE/WEBROOT/APPHOST' -Filter system.webServer/httpProtocol/customHeaders -Name . -AtElement @{name='X-Powered-By'}
