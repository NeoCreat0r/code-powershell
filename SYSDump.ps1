# ������� ����� Temp, ���� ��� �� ����������
$tempFolder = "$env:TEMP\SystemInfo"
if (-not (Test-Path $tempFolder)) {
    New-Item -ItemType Directory -Path $tempFolder
}

# 1. ���� ���������� � ������� � ������� Get-ComputerInfo
$computerInfo = Get-ComputerInfo
$computerInfo | Out-File "$tempFolder\Get-ComputerInfo.txt"

# 2. ���� ���������� � ����������
$cpuInfo = Get-WmiObject Win32_Processor
$cpuInfo | Out-File "$tempFolder\Get-WmiObject_Win32_Processor.txt"

# 3. ���� ���������� � ����������� ������
$memoryInfo = Get-WmiObject Win32_PhysicalMemory
$memoryInfo | Out-File "$tempFolder\Get-WmiObject_Win32_PhysicalMemory.txt"

# 4. ���� ���������� � ������
$diskInfo = Get-WmiObject Win32_DiskDrive
$diskInfo | Out-File "$tempFolder\Get-WmiObject_Win32_DiskDrive.txt"

# 5. ���� ���������� � ������� ���������
$networkInfo = Get-WmiObject Win32_NetworkAdapterConfiguration | Where-Object { $_.IPEnabled -eq $true }
$networkInfo | Out-File "$tempFolder\Get-WmiObject_Win32_NetworkAdapterConfiguration.txt"

# 6. ���� ���������� � ������������ �������
$osInfo = Get-WmiObject Win32_OperatingSystem
$osInfo | Out-File "$tempFolder\Get-WmiObject_Win32_OperatingSystem.txt"

# 7. ���� ���������� � ������������� �����������
$updatesInfo = Get-HotFix
$updatesInfo | Out-File "$tempFolder\Get-HotFix.txt"

# 8. ���� ���������� � ���������� ���������
$processInfo = Get-Process
$processInfo | Out-File "$tempFolder\Get-Process.txt"

# 9. ���� ���������� � �������
$servicesInfo = Get-Service
$servicesInfo | Out-File "$tempFolder\Get-Service.txt"

# 10. ���� ���������� � ���������� ���������
$envInfo = Get-ChildItem Env:
$envInfo | Out-File "$tempFolder\Get-ChildItem_Env.txt"

Write-Host "���������� � ������� ��������� � �����: $tempFolder"