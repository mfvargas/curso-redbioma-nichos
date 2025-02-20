# Se utiliza la imagen rocker/geospatial:4.4.2 como base
FROM rocker/geospatial:4.4.2

# Definición de la variable de entorno PASSWORD
ENV PASSWORD=nichos

# Se expone el puerto por defecto de RStudio Server
EXPOSE 8787
