# Notas a tener en cuanta durante la instalación.

1. Ejecutar el .exe como administrador
2. Una vez instalado abre powershell como administrador y cambia las politicas para ejecución de script: 
   
        Set-ExecutionPolicy Unrestricted

3. Abre de nuevo una terminal y ejecuta el comando jvm, Debería funcionar.

## Si quieres modificar el .exe
Ejecuta el comando Win-PS2EXE  y en la ventana que se abre Desmarca compilar a grafico

# Funciones y comandos

1. **jvm list**: Todas las jdk que tienes instadas
2. **jvm init**: Para iniciar el control sobre la jdk,
3. **jvm current**: La jdk que tiene en uso.
4. **jvm use jdk-23**.