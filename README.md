# Notas a tener en cuanta durante la instalación.

1. Ejecutar el .exe como administrador
2. Una vez instalado abre powershell como administrador y cambia las politicas para ejecución de script: 
   
        Set-ExecutionPolicy Unrestricted

3. Abre de nuevo una terminal y ejecuta el comando jvm, Debería funcionar.

## Si quieres modificar el .exe
Ejecuta el comando Win-PS2EXE  y en la ventana que se abre Desmarca compilar a grafico

Para adjuntar el manifest y te pida permisos de administrador:
    
    mt.exe -manifest instalar.exe.manifest -outputresource:instalar.exe;#1

Sino te reconoce el comando tienes que tener la ruta en el path

    C:\Program Files (x86)\Windows Kits\10\bin\<versión>\x86\

# Funciones y comandos

1. **jvm list**: Todas las jdk que tienes instadas
2. **jvm init**: Para iniciar el control sobre la jdk,
3. **jvm current**: La jdk que tiene en uso.
4. **jvm use jdk-23**.

