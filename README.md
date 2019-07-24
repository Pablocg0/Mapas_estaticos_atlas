# Mapas_estaticos_atlas
Scripts para la creación de mapas estáticos a partir de archivos netcdfs

## Primeros pasos
Para obtener la copia del proyecto solo es necesario clonar el proyecto usando la instrucción:

`git clone https://github.com/grupoioa/Mapas_estaticos_atlas.git`

### Prerrequisitos

Se requiere tener instalado [NCL](https://www.ncl.ucar.edu/)

## Probando

Se pueden generar mapas de informacion meteorologica y mapas de derrame de petroleo.

Para la generacion de mapas con informacion meteorologica se ejecuta:

`./genera_map.sh`

Para la generacion de mapas de derrame de petroleo se ejecuta:

`./genera.sh`

Como resultado de ejecutar cualquiera de los scripts en la carpeta out_mapas se generan las carpetas con los mapas estacticos

## Deployment

Para cada tipo de mapa se cuenta con un archivo de configuracion **datosEntrada_pet.ncl** y **datosEntrada.ncl**.
En los archivos de configuracion se puede modificar el titulo de los mapas, la paleta de colores, valores maximos y minimos, variable que se grafica y nombre de los archivos.

## Construido con

* [NCL](https://www.ncl.ucar.edu/)

## Autores
* **Pablo Camacho Gonzalez** -[GitHub](https://github.com/Pablocg0)
