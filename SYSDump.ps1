# Создаем папку Temp, если она не существует
$tempFolder = "$env:TEMP\SystemInfo"
if (-not (Test-Path $tempFolder)) {
    New-Item -ItemType Directory -Path $tempFolder
}

# 1. Сбор информации о системе с помощью Get-ComputerInfo
$computerInfo = Get-ComputerInfo
$computerInfo | Out-File "$tempFolder\Get-ComputerInfo.txt"

# 2. Сбор информации о процессоре
$cpuInfo = Get-WmiObject Win32_Processor
$cpuInfo | Out-File "$tempFolder\Get-WmiObject_Win32_Processor.txt"

# 3. Сбор информации о оперативной памяти
$memoryInfo = Get-WmiObject Win32_PhysicalMemory
$memoryInfo | Out-File "$tempFolder\Get-WmiObject_Win32_PhysicalMemory.txt"

# 4. Сбор информации о дисках
$diskInfo = Get-WmiObject Win32_DiskDrive
$diskInfo | Out-File "$tempFolder\Get-WmiObject_Win32_DiskDrive.txt"

# 5. Сбор информации о сетевых адаптерах
$networkInfo = Get-WmiObject Win32_NetworkAdapterConfiguration | Where-Object { $_.IPEnabled -eq $true }
$networkInfo | Out-File "$tempFolder\Get-WmiObject_Win32_NetworkAdapterConfiguration.txt"

# 6. Сбор информации о операционной системе
$osInfo = Get-WmiObject Win32_OperatingSystem
$osInfo | Out-File "$tempFolder\Get-WmiObject_Win32_OperatingSystem.txt"

# 7. Сбор информации о установленных обновлениях
$updatesInfo = Get-HotFix
$updatesInfo | Out-File "$tempFolder\Get-HotFix.txt"

# 8. Сбор информации о запущенных процессах
$processInfo = Get-Process
$processInfo | Out-File "$tempFolder\Get-Process.txt"

# 9. Сбор информации о службах
$servicesInfo = Get-Service
$servicesInfo | Out-File "$tempFolder\Get-Service.txt"

# 10. Сбор информации о переменных окружения
$envInfo = Get-ChildItem Env:
$envInfo | Out-File "$tempFolder\Get-ChildItem_Env.txt"

Write-Host "Информация о системе сохранена в папку: $tempFolder"