param (
    [string]$Variable,
    [string]$Valor
)

# Verificar si se está ejecutando con permisos de administrador
If (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))
{
    # Relanzar el script con permisos de administrador
    Start-Process powershell "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"  -Variable `"$Variable`" -Valor `"$Valor`"" -Verb RunAs -WindowStyle Hidden
    Exit
}

Write-Output "El script se está ejecutando con permisos de administrador."
[System.Environment]::SetEnvironmentVariable($Variable, $Valor ,'Machine')

