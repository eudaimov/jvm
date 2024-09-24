




# Verificar si se está ejecutando con permisos de administrador
If (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))
{
    # Relanzar el script con permisos de administrador
    Start-Process powershell "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs -WindowStyle Hidden
#    -WindowStyle Hidden
    Exit
}


$directorioDescarga = "C:\Program Files\jvm"
# Crear el directorio si no existe
if (-not (Test-Path -Path $directorioDescarga)) {
    New-Item -ItemType Directory -Path $directorioDescarga
}

# Descargar archivos con -UseBasicParsing
Invoke-WebRequest 'https://raw.githubusercontent.com/eudaimov/jvm/refs/heads/main/jvm.ps1' -OutFile "$directorioDescarga\jvm.ps1" -UseBasicParsing
Invoke-WebRequest 'https://raw.githubusercontent.com/eudaimov/jvm/refs/heads/main/jvm.bat' -OutFile "$directorioDescarga\jvm.bat" -UseBasicParsing
Invoke-WebRequest 'https://raw.githubusercontent.com/eudaimov/jvm/refs/heads/main/instalar.exe' -OutFile "$directorioDescarga\instalar.exe" -UseBasicParsing
Invoke-WebRequest 'https://raw.githubusercontent.com/eudaimov/jvm/refs/heads/main/instalar.ps1' -OutFile "$directorioDescarga\instalar.ps1" -UseBasicParsing
Invoke-WebRequest 'https://raw.githubusercontent.com/eudaimov/jvm/refs/heads/main/README.md' -OutFile "$directorioDescarga\README.md" -UseBasicParsing
Invoke-WebRequest 'https://raw.githubusercontent.com/eudaimov/jvm/refs/heads/main/variablesEntorno.ps1' -OutFile "$directorioDescarga\variablesEntorno.ps1" -UseBasicParsing
Write-Host "Archivos descargados en C:\Program Files\jvm" -ForegroundColor Green
function instalar{
    $pathVariable = [System.Environment]::GetEnvironmentVariable("PATH", "Machine")
    Write-Host $rutaActual
    $pathList = $pathVariable -split ';'

    if($pathList -contains $directorioDescarga ){
        Write-Host "Ya esta instalado`n" -ForegroundColor Blue
    }else{
        $newVariablePath = "$directorioDescarga;$pathVariable";
        [System.Environment]::SetEnvironmentVariable('PATH', $newVariablePath ,'Machine')
        Write-Host "Instalacion realizada correctamente`n" -ForegroundColor Green
    }
}
instalar -UseBasicParsing
Read-Host "Pulsa una tecla para continuar"



#-WindowStyle Hidden