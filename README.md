# Curso Modelado de nichos ecológicos y distribuciones de especies

Este curso es impartido por Enrique Martínez Meyer y Luis A. Osorio Olvera, de la UNAM, como parte de las actividades de la [redbioma](https://redbioma.github.io/).

## Instalación de software

Para instalar el software que se utiliza en el curso:

1. Generar la imagen Docker especificada en `Dockerfile`.
2. Ejecutar el contenedor Docker.
3. Ejecutar el script `instalar_paquetes_RedBioma.R`.

## Manejo del contenedor Docker

### Generación de la imagen a partir del archivo Dockerfile

```shell
# Generación de la imagen Docker a partir del archivo Dockerfile
docker build -t curso-redbioma-nichos-r-442 .
```

### Ejecución del contenedor

```shell
# Ejecución del contenedor Docker
# (el directorio local debe especificarse en la opción -v)
# (el archivo con variables de ambiente debe especificarse en la opción --env-file)
docker run -d --name curso-redbioma-nichos-r-442 \
  -p 8787:8787 \
  -v /home/mfvargas/curso-redbioma-nichos:/home/rstudio \
  --env-file /home/mfvargas/curso-redbioma-nichos-r-442.env \
  curso-redbioma-nichos-r-442
```
  
### Acceso al contenedor (username=rstudio, password=nichos)
[http://localhost:8787](http://localhost:8787)

### Detención, inicio y borrado del contenedor

```shell
# Detención del contenedor Docker
docker stop curso-redbioma-nichos-r-442

# Inicio del contenedor Docker
docker start curso-redbioma-nichos-r-442

# Borrado del contenedor Docker
docker rm curso-redbioma-nichos-r-442
```

### Ejemplo de contenido del archivo `curso-redbioma-nichos-r-442.env`

(Deben asignarse valores adecuados a las variables)

```shell
# Clave para ingresar a RStudio
PASSWORD=nichos
```
