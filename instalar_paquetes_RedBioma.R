# Script: 
# Instala los paquetes que usaremos en el curso.
# Autor: Luis Osorio Olvera y Enrique Martinez Meyer
# Fecha: Febrero, 2025
# luis.osorio@iecologia.unam.mx
# Curso: "Modelado de nicho ecologico RedBioma, 2025"


# ----------------------------------------------------------
# Nota muy importante a los usarios de Windows 
# INSTALEN RTools en
# https://cran.r-project.org/bin/windows/Rtools/

# ----------------------------------------------------------
# Nota muy importante a los usarios de Mac instalen 
# las herramientas de desarrollador desde su terminal
# "sudo xcode-select --install"
# Escribir el pwd del usuario

# Para una guia completa de instalcion de las herramientas 
# de desarrollador visitar el siguiente link:
#
# https://luismurao.github.io/ntbox_installation_notes.html
# 
# ----------------------------------------------------------

# Una vez que tengan instaldos RTools (usarios de windows) 
# o xcode (usuarios mac) continue con lo de abajo


# Paquetes que se intalan desde CRAN

# Instrucciones: copiar, pegar y correr el siguiente texto de instrucciones 
# en la consola de R o bien desde R-Studio como un script.

pkgs_curso <- c("devtools", # herramientas para desarrolladores
                "raster","terra", "leaflet","wicket", # Analisis espacial
                "rasterVis","crosstalk",# Analisis espacial
                "maptools","sp","sf","elevatr", # Analisis espacial
                "GISTools","tmap", "spatstat","spdep", # Analisis espacial
                "tmaptools","gstat", # Analisis espacial
                "geodata", # Datos geoespaciales
                "spocc","dismo", # Distribucion de especies
                "ggplot2","rgl","car","plotly", # Graficacion
                "dplyr","stringr","zoo", # manejo de datos
                "readxl","rio", # Lectura de datos 
                "animation", # Para hacer animaciones
                "purrr", # Programacion funcional
                "crosstalk", # comunicar mapas, tablas y graficos interactivos
                "tidyverse") # Paquetes para ciencia de datos 
# (purrr,ggplot2, dplyr,readr...)



install.packages(pkgs_curso, 
                 repos = "https://cloud.r-project.org/")

#-------------------------------------------------------------------------------
# Intalacion de paquetes que no estan en CRAN
#-------------------------------------------------------------------------------
# Modelos basados en proceso
install.packages("http://download.r-forge.r-project.org/src/contrib/demoniche_1.0.tar.gz",
                 repos=NULL,type="source")
devtools::install_github("luismurao/tenm")
# Modelado de nicho
devtools::install_github("luismurao/ntbox") # Para este mejor vean el HTML llamado
# Instalacion_ntbox
devtools::install_github("marlonecobos/kuenm")
