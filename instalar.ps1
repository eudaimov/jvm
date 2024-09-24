function instalar{
    $rutaActual = Get-Location
    Write-Host $rutaActual
    $pathVariable = [System.Environment]::GetEnvironmentVariable("PATH", "Machine")
    $pathList = $pathVariable -split ';'

    if($pathList -contains $rutaActual ){
        Write-Host "Ya esta instalado" -ForegroundColor Green
    }else{
        $newVariablePath = "$rutaActual;$pathVariable";
        Write-Host $newVariablePath
        Read-Host "Se va a pedir permisos para instalar la variable de entorno en el Path: ${rutaActual}`nPulse cualquier tecla para continuar"
        Read-Host "Pulse tecla para continuar"

        Start-Process -FilePath "powershell.exe" -ArgumentList @(
            "-NoProfile",
            "-Command",
            "& {",
            "`$newVariablePath = '$newVariablePath';",
            "[System.Environment]::SetEnvironmentVariable('PATH', `$newVariablePath ,'Machine')",
            "}"
        ) -Verb RunAs
        Write-Host "Variable de entorno instalada correctamente, ya puedes utilizar en la Termina jvm"
    }
}
instalar;