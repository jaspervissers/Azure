#IIS 10.0 Server Installation (Role)
Install-WindowsFeature -Name Web-Server -ComputerName $ServerName –IncludeManagementTools | Out-File $LogFile -Append -Force
Install-WindowsFeature -Name Web-Http-Redirect -ComputerName $ServerName –IncludeManagementTools | Out-File $LogFile -Append -Force
#Health and diagnostics (Services)
Install-WindowsFeature -Name Web-Request-Monitor -ComputerName $ServerName | Out-File $LogFile -Append -Force
#Application Development Section (Services)
Install-WindowsFeature -Name Web-Net-Ext -ComputerName $ServerName | Out-File $LogFile -Append -Force
Install-WindowsFeature -Name Web-Asp-Net -ComputerName $ServerName | Out-File $LogFile -Append -Force
Install-WindowsFeature -Name Web-Asp-Net45 -ComputerName $ServerName | Out-File $LogFile -Append -Force
Install-WindowsFeature -Name Web-CGI -ComputerName $ServerName | Out-File $LogFile -Append -Force
Install-WindowsFeature -Name Web-ISAPI-Ext -ComputerName $ServerName | Out-File $LogFile -Append -Force
Install-WindowsFeature -Name Web-ISAPI-Filter -ComputerName $ServerName | Out-File $LogFile -Append -Force
