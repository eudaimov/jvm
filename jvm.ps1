param (
    [Parameter(Position=0)]
    [string]$FirstParam,
    [Parameter(Position=1)]
    [string]$SecondParam
)
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8


function list {
    $directorio = "C:/Program Files/Java"
    $directorioEnlaceSimbolico = $directorio+"/current";
    $enlaceObjecto = Get-Item -Path $directorioEnlaceSimbolico
    $enlace = $enlaceObjecto.Target
    $versionCurrent = Split-Path -Path $enlace -Leaf

    # Obtén todas las carpetas en el directorio actual
    $carpetas = Get-ChildItem -Directory -Path $directorio -Name | Where-Object { $_ -ne 'current' }
    $contador = 1;
    # Muestra los nombres de las carpetas
    foreach ($carpeta in $carpetas) {
        if($carpeta -eq $versionCurrent){
            Write-Host "`t$contador.- $carpeta *" -ForegroundColor Green
        }else{
            Write-Host "`t$contador.- $carpeta"
        }
        $contador++;
    }
}

function current{
    $archivoRelease = "C:/Program Files/Java/current/release"

    # Lee el contenido del archivo
    $contenido = Get-Content -Path $archivoRelease

    # Busca la línea que contiene JAVA_VERSION

    foreach ($linea in $contenido) {
        if ($linea -match 'JAVA_RUNTIME_VERSION="(.+)"') {
            # Extrae y muestra la versión de Java
            $versionJava = $matches[1]
            Write-Host "`tLa versión de Java es: $versionJava" -ForegroundColor Red -BackgroundColor White

        }
    }
}
function use{
    $directorio = "C:/Program Files/Java"
    # Obtén todas las carpetas en el directorio actual
    $carpetas = Get-ChildItem -Directory -Path $directorio -Name | Where-Object { $_ -ne 'current' }

    # Muestra los nombres de las carpetas
    foreach ($carpeta in $carpetas) {
        if($carpeta -eq $SecondParam){
            Write-Host "Asignando jdk";
            $rutaCurrent = $directorio + "/current"
            $rutaChosen = $directorio + "/" + $SecondParam
            Write-Host $rutaCurrent
            Write-Host $rutaChosen
            Start-Process -FilePath "powershell.exe" -ArgumentList @(
                "-NoProfile",
                "-Command",
                "& {",
                "`$rutaCurrent = '$rutaCurrent';",
                "`$rutaChosen = '$rutaChosen';",
                "try {",
                    "if (Test-Path -Path `$rutaCurrent) {",
                    "    Remove-Item -Path `$rutaCurrent -Recurse -Force -ErrorAction Stop;",
                    "}",
                    "New-Item -ItemType SymbolicLink -Path `$rutaCurrent -Target `$rutaChosen -ErrorAction Stop;",
                "} catch {",
                "    Write-Host `$_ -ForegroundColor Red;",
                "    Read-Host 'Espera ...'",
                "    exit 1;",
                "}",
                "}"
            ) -Verb RunAs
            exit;
        }
    }
    Write-Host "`t No existe jdk indicada." -ForegroundColor red
}

function init{
    Write-Host "Entrando en Path"
    # Obtener la variable de entorno PATH
    $pathVariable = [System.Environment]::GetEnvironmentVariable("PATH", "Machine")
    $pathCurrent = "C:\Program Files\Java\current\bin"
    $javaHome = "C:\Program Files\Java\current"

    # Dividir las rutas en una lista
    $pathList = $pathVariable -split ";"

    # Imprimir la lista de rutas
    $pattern = "C:\\Program Files\\Java\\[^/]+\\bin"

    $nuevoArrayPath = @();

    foreach ($route in $pathList){
        if($route -match $pattern -or $route -eq $pathCurrent){
            #Write-Host Eliminado -ForegroundColor Red
        }
        else{
            $nuevoArrayPath += $route
            #Write-Host $route
        }
    }
    $unionArray = $nuevoArrayPath -join";"
    $newVariablePath =$pathCurrent+";"+$unionArray;
    #Introduce las variables de entorno.
    Read-Host "Se va a pedir permiso para modificar el PATH"
    Start-Process -FilePath "powershell.exe" -ArgumentList @(
        "-NoProfile",
        "-Command",
        "& {",
        "`$newVariablePath = '$newVariablePath';",
        "setx Path `$newVariablePath /M",
        "}"
    ) -Verb RunAs

    Read-Host "Se va a pedir permiso para modificar el JAVA_HOME"
    Start-Process -FilePath "powershell.exe" -ArgumentList @(
        "-NoProfile",
        "-Command",
        "& {",
        "`$javaHome = '$javaHome';",
        "setx JAVA_HOME `$javaHome /M",
        "}"
    ) -Verb RunAs


}
function comandos{
    Write-Host "Los parametros que se pueden usar son:"
    Write-Host "`t- jvn init Comando necesario para iniciar el jvm"
    Write-Host "`t- jvn current version actual"
    Write-Host "`t- jvn list Listado de todas las versiones de java que tienes instaladas"
    Write-Host "`t- jvn use jdk-1.8 Dependiendo de las versiones que te aparecen en jvn list"
}
function default{
    Write-Host "Parametro no reconocido:" -ForegroundColor Red
    comandos
}


switch($FirstParam){
    {$_ -eq "use"}{
        use -version
    }
    {$_ -eq "current"}{
        current
    }
    {$_ -eq "list"}{
        list
    }
    {$_ -eq "init"}{
        init
    }
    {$_ -eq "help"}{
        comandos
    }
    default{
        default
    }
}



# C:\Program Files\Common Files\Oracle\Java\javapath
exit