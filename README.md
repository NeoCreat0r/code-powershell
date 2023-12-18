# code-powershell
```
function Detect-Encoding {
    param (
        [Parameter(Mandatory=$true)]
        [string]$inputString
    )

    # Проверяем, содержит ли строка только символы ASCII
    if ($inputString -match '^[\x00-\x7F]+$') {
        Write-Output "ASCII"
        return
    }

    # Проверяем, является ли строка HEX-кодированной
    try {
        [byte[]] $hexBytes = $inputString -split "(?<=\G..)(?!$)"
        [System.Text.Encoding]::ASCII.GetString($hexBytes)
        Write-Output "HEX"
        return
    }
    catch {}

    # Проверяем, является ли строка OCTAL-кодированной
    try {
        $octalBytes = [System.Text.Encoding]::ASCII.GetBytes(([regex]::Replace($inputString, '(\d{3})', { [char][int]$args[0].Value })))
        [System.Text.Encoding]::ASCII.GetString($octalBytes)
        Write-Output "OCTAL"
        return
    }
    catch {}

    # Проверяем, является ли строка BINARY-кодированной
    try {
        $binaryBytes = [System.Text.Encoding]::ASCII.GetBytes(([regex]::Replace($inputString, '(\d{8})', { [char][Convert]::ToByte($args[0].Value, 2) })))
        [System.Text.Encoding]::ASCII.GetString($binaryBytes)
        Write-Output "BINARY"
        return
    }
    catch {}

    # Проверяем, является ли строка BXOR-кодированной
    try {
        $bxorBytes = [System.Text.Encoding]::ASCII.GetBytes(([regex]::Replace($inputString, '(\w{2})', { [char][Convert]::ToByte($args[0].Value, 16) })))
        [System.Text.Encoding]::ASCII.GetString($bxorBytes)
        Write-Output "BXOR"
        return
    }
    catch {}

    Write-Output "Unknown encoding"
}
```
