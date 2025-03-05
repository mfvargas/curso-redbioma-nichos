#' ---
#' title: "Práctica conceptos relacionados a la dualidad de Hutchinson y al BAM"
#' author: 
#'  - "Luis Osorio Olvera$^{1}$ y Rusby G. Contreras Díaz$^{2}$"
#'  - "$^{1}$Lab. Ecoinformática de la Biodiversidad, Instituto de Ecología UNAM" 
#'  - "$^{2}$ Departamento de Sistemas y Procesos Naturales, ENES Mérida, Yucatán, UNAM"
#' date: "`r Sys.Date()`"
#' output:
#'   prettydoc::html_pretty:
#'     theme: architect
#'     highlight: github
#' ---
#' 
#' ## Preparando la información espacial que usaremos
#' 
## ----include=FALSE-----------------------------------------------------------------------------------------------------------------
library(terra)
library(plotly)
library(leaflet)
library(ntbox)
library(rgl)
library(crosstalk)
library(dplyr)
library(geodata)
library(sf)

#' 
#' 
## ----eval=FALSE--------------------------------------------------------------------------------------------------------------------
## library(raster)
## library(plotly)
## library(leaflet)
## library(crosstalk)
## library(ntbox)
## library(rgl)
## library(geodata)
## library(sf)

#' 
#' 
#' ## La dualidad de Hutchinson
#' 
#' 
#' > La dualidad de Hutchinson se puede expresar como una función de $G$ en $E$ y se denota como $f:G\rightarrow E$ donde $G$ es un subconjunto $\mathbb{R}^2$ y $E$ es uno de $\mathbb{R}^n$, es decir,$G \subset \mathbb{R}^2$ y $E \subset \mathbb{R}^n$. 
#' 
#' >> - Denotaremos a esta función como $\eta(G)$.
#' 
#' > La definición de función $f$ de un conjunto $G$  en un conjunto $E$: *"es una regla de correspondencia $f$ entre $G$ y $E$, de modo que a cada elemento de $G$ le corresponde uno y sólo un elemento de $E$"*. 
#' 
#' > Una definición de función más precisa recurre al concepto de relación, el cual es:
#' 
#' >>    1) Un conjunto $G$
#' >>    2) Un conjunto $E$ 
#' >>    3) El producto cartesiano de $G$ y $E$ ($G \times E$); tal que $G \times E$ se define de la siguiente manera: 
#'  $$G \times E= \{ (g,e) | g \in G \text{ y } e \in E \}$$
#' 
#' >> Una función es un subconjunto de una relación donde **nunca** se repite el primer elemento de los pares ordenados $(g,e)$
#' 
#' <p style="text-align:center;"><img src="funcion_mat.png" align="middle" alt="drawing" width="400"/></p>
#' >> - **Nótese** que a un elemento de $E$ le pueden corresponder varios de $G$, pero a uno de $G$ no le pueden corresponder más de uno de $E$, además esto es válido para un determinado tiempo $t$. 
#' >> - Por ejemplo, no se puede tener al mismo tiempo en una coordenada dos temperaturas. 
#' 
#' 
#' A continuación se muestra la correspondencia entre espacio geográfico $G$ y el espacio ecológico $E$. 
#' 
#' #### Parte geográfica
#' 
#' - Primero tomamos puntos aleatorios ($n=811$) en la geografía.
#' 
## ----------------------------------------------------------------------------------------------------------------------------------
rpointsDF <- read.csv("puntos_aleatorios.csv")

#' - Los graficamos los puntos en un mapa
#' 
## ----------------------------------------------------------------------------------------------------------------------------------
mapa_base <- leaflet::leaflet(rpointsDF) |>
  leaflet::addTiles()
# Mapa con puntos aleatorio

mapa_base |> leaflet::addCircleMarkers(lng = ~longitud,
                                        lat = ~latitud,
                                        popup = as.character(1:nrow(rpointsDF)))

#' 
#' #### Extraer la información ambiental de los puntos aleatorios
#' 
#' - Leer la información ambiental
## ----------------------------------------------------------------------------------------------------------------------------------
pca_path <- list.files(".",pattern = "*.asc$",
                       full.names = T)

pca <- raster::stack(pca_path)

#' - Extracción de la información de  $\mathbf E$ en una tabla de datos
## ----------------------------------------------------------------------------------------------------------------------------------
randP_E <- data.frame(raster::extract(pca,rpointsDF))
randP_E$ID <- 1:nrow(randP_E)

#' - Graficar la información ambiental
## ----eval=FALSE--------------------------------------------------------------------------------------------------------------------
## rgl::plot3d(randP_E[,1:3],type="n",col=cols)
## with(randP_E,
##          rgl::text3d(randP_E[-c(112,481,504),1],
##                      randP_E[-c(112,481,504),2],
##                      randP_E[-c(112,481,504),3],
##                      ID,
##                      adj = c(0.5,0.5),
##                      #useFreeType=T,
##                      #family="mono",
##                      #font=1,
##                      cex=1))
## 
## with(randP_E,
##      rgl::text3d(randP_E[c(112,481,504),1],
##                  randP_E[c(112,481,504),2],
##                  randP_E[c(112,481,504),3],
##                  randP_E[c(112,481,504),4],
##                  adj = c(0.5,0.5),
##                  #useFreeType=T,
##                  col=c("red","blue","blue"),
##                  cex=1))
## 

#' 
## ----echo=FALSE--------------------------------------------------------------------------------------------------------------------
rgl::plot3d(randP_E[,1:3],type="n",col=cols)
with(randP_E,
     rgl::text3d(randP_E[-c(112,481,504),1],
                 randP_E[-c(112,481,504),2],
                 randP_E[-c(112,481,504),3],
                 ID,
                 adj = c(0.5,0.5),
                 #useFreeType=T,
                 #family="mono",
                 #font=1,
                 cex=1))

with(randP_E,
     rgl::text3d(randP_E[c(112,481,504),1],
                 randP_E[c(112,481,504),2],
                 randP_E[c(112,481,504),3],
                 randP_E[c(112,481,504),4],
                 adj = c(0.5,0.5),
                 #useFreeType=T,
                 col=c("red","blue","blue"),
                 cex=1))
 
rglwidget()

#' - **Nótese:** El punto 322 y 581 parecen estar muy cerca en el espacio $\mathbf E$, por otro lado, el punto 333 está lejos de ambos; veamos como se ve esto en la geografía...
## ----------------------------------------------------------------------------------------------------------------------------------
mapa_base |> 
  leaflet::addCircleMarkers(lng = rpointsDF[c(112,481,504),1],
                   lat = rpointsDF[c(112,481,504),2],
                   color = c("red","blue","blue"),
                   popup = as.character(c(112,481,504)))

#' 
#' 
#' 
#' ## Un ejemplo interactivo con datos de México 
#' 
#' 
#' La idea inicial será extraer de las capas de `WorldClim` información ambiental sobre temperatura y precipitación en México; para cada punto en $\mathbf G$ veremos su pryección en el espacio  $\mathbf E$
#' 
#' 
#' 
#' Obtenemos la información espacial para México 
#' 
## ----------------------------------------------------------------------------------------------------------------------------------
mex <- geodata::gadm("mexico",level = 0,path = ".") 
wc <- geodata::worldclim_global(var = "bio",res = 10,path = ".") 
names(wc) <- paste0("bio",1:19)
mex_r <- terra::mask(terra::crop(wc,mex),mex)
terra::plot(mex_r[[1]])

#' 
#' Tomamos una muestra aleatoria de los puntos en México
## ----------------------------------------------------------------------------------------------------------------------------------
# 
no_na <- which(!is.na(mex_r[[1]][]))
# Convertimos a puntos
mex_wc <- data.frame(terra::xyFromCell(mex_r,no_na),
                     terra::as.points(mex_r)) |> round(2)
# Sacamos 800 puntos para no saturar la imagen que graficaremos
mex_wc <- dplyr::sample_n(mex_wc,1800)

#' 
#' 
#' Usamos el paquete `crosstalk` que utiliza la API de `mapbox`para realizar graficos interactivos. 
#' 
#' >>> **Nota:** Para poder usar  `mapbox` será necesario registrarse, obtener un token y cargarlo en nuestra sesión de R
#' 
## ----echo=FALSE--------------------------------------------------------------------------------------------------------------------
Sys.setenv('MAPBOX_TOKEN' = "pk.eyJ1IjoibHVpc211cmFvIiwiYSI6ImNrMW9kdnNxcTBsZXAzb3BzNHJhZjNraGgifQ.mSFwikDAf-bbHDYX32vs6g")

#' 
## ----------------------------------------------------------------------------------------------------------------------------------
Sys.setenv('MAPBOX_TOKEN' = "pk.SU_TOKEN")

#' 
#' 
#' Ahora si el gráfico
#' 
## ----------------------------------------------------------------------------------------------------------------------------------
library(crosstalk)
# Convertir nuestro data.frame a un objeto que se comunica con mapbox
mex_hutchinson <- SharedData$new(mex_wc)

g <- list(
  scope = 'north america',
   showlakes = TRUE,
  lakecolor = plotly::toRGB('white')
)

crosstalk::bscols(widths = c(6,6,6),
  plotly::plot_ly(mex_hutchinson,lon=~x,lat=~y,
                  hovertext = ~paste(paste("bio5:",bio5),
                           paste("bio6",bio6), 
                           paste("bio12", bio12),
                           sep = "<br />"),
                      type = 'scattermapbox') %>%
    plotly::layout(mapbox = list(zoom = 2,
                                 style = 'open-street-map',
                                 center = list(lat = ~median(y), 
                                               lon = ~median(x)))
    ) |>
    plotly::highlight("plotly_hover", 
                      off = 'plotly_doubleclick',
                      dynamic = T,persistent = F),
  plotly::plot_ly(mex_hutchinson, x = ~bio5,
          y = ~bio12 ) |>
    plotly::highlight("plotly_selected",opacityDim = 0.05,
                      off = 'plotly_deselect',
                      dynamic = T, persistent = F),
  plotly::plot_ly(mex_hutchinson, x = ~bio5,
                  y = ~bio6 ,z = ~bio12,
                  type="scatter3d") %>%
    plotly::highlight("plotly_selected",
                      opacityDim = 0.05,
                      off = 'plotly_deselect',
                      dynamic = F, 
                      persistent = F)
) 


#' 
#' 
#' 
#' ## Sobre la importancia de M en E (volúmenes de M)
#' 
#' A continuación veremos cómo $\mathbf M$ también debe contextualizarse en términos de $\mathbf E$
#' 
#' - Comenzamos lendo 3 polígonos de aproximadamente el mismo tamaño (cuadrados) 
#' 
## ----------------------------------------------------------------------------------------------------------------------------------
# En R los polígonos se leen de la siguiente manera
pol1 <- sf::st_read("pol1.shp") |> as("Spatial")
pol2 <- sf::st_read("pol2.shp") |> as("Spatial")
pol3 <- sf::st_read("pol3.shp") |> as("Spatial")
p12  <- terra::union(pol1,pol2)
p123 <- terra::union(p12,pol3) |> sf::st_as_sf()

#' - Visualizamos la información geográfica
#' 
## ----------------------------------------------------------------------------------------------------------------------------------
leaflet::leaflet(p123) |> leaflet::addTiles() |>
  leaflet::addPolygons(color = "#444444", weight = 1,
                       fillColor = c("#ff4848",
                                     "#3662ff",
                                     "#417c24"),
                       opacity = 1.0, fillOpacity = 0.5) 

#' 
#' 
#' - Extraeremos la información ambiental que cae dentro de cada polígono
## ----------------------------------------------------------------------------------------------------------------------------------
p1_e <- terra::extract(pca,pol1)[[1]]
p2_e <- terra::extract(pca,pol2)[[1]]
p3_e <- terra::extract(pca,pol3)[[1]]

#' - Graficamos la información en el espacio $\mathbf E$
## ----------------------------------------------------------------------------------------------------------------------------------
rgl::plot3d(p1_e,col="#ff4848")
rgl::points3d(p2_e,col="#3662ff")
rgl::points3d(p3_e,col="#417c24")

#' - Calculamos los volumenes de nicho usando un modelo de elipsoide
## ----------------------------------------------------------------------------------------------------------------------------------
p1_elips_mdata <- ntbox::cov_center(data =p1_e,
                                  mve = TRUE,
                                  level = 0.9999,
                                  vars = 1:3 )
p2_elips_mdata <- ntbox::cov_center(data =p2_e,
                                  mve = TRUE,
                                  level = 0.9999,
                                  vars = 1:3 )
p3_elips_mdata <- ntbox::cov_center(data =p3_e,
                                  mve = TRUE,
                                  level = 0.9999,
                                  vars = 1:3 )

#' 
#' - Grafiquemos
## ----eval=F------------------------------------------------------------------------------------------------------------------------
## p1_elipse <- rgl::ellipse3d(p1_elips_mdata$covariance,
##                             centre = p1_elips_mdata$centroid)
## p2_elipse <- rgl::ellipse3d(p2_elips_mdata$covariance,
##                             centre =p2_elips_mdata$centroid)
## p3_elipse <- rgl::ellipse3d(p3_elips_mdata$covariance,
##                             centre =p3_elips_mdata$centroid)
## 
## rgl::wire3d(p1_elipse,col="#ff4848")
## rgl::wire3d(p2_elipse,col="#3662ff")
## rgl::wire3d(p3_elipse,col="#417c24")

#' 
## ----echo=F------------------------------------------------------------------------------------------------------------------------
p1_elipse <- rgl::ellipse3d(p1_elips_mdata$covariance,
                            centre = p1_elips_mdata$centroid)
p2_elipse <- rgl::ellipse3d(p2_elips_mdata$covariance,
                            centre =p2_elips_mdata$centroid)
p3_elipse <- rgl::ellipse3d(p3_elips_mdata$covariance,
                            centre =p3_elips_mdata$centroid)

rgl::wire3d(p1_elipse,col="#ff4848")
rgl::wire3d(p2_elipse,col="#3662ff")
rgl::wire3d(p3_elipse,col="#417c24")
rgl::rglwidget()

#' - Dentro de los resultados que `cov_center` calcula, está el volumen del elipsoide
#' 
## ----echo=TRUE, eval=FALSE---------------------------------------------------------------------------------------------------------
## cat("El volumen del primer polígono (Colombia) en E es:",
##     p1_elips_mdata$niche_volume)
## cat("El volumen del primer polígono (México) en E es:",
##     p2_elips_mdata$niche_volume)
## cat("El volumen del primer polígono (Canadá) en E es:",
##     p3_elips_mdata$niche_volume)

#' 
## ----results="asis",echo=FALSE-----------------------------------------------------------------------------------------------------
cat(paste0("El volumen del primer polígono (Colombia) en $\\mathbf E$ es: **",
    p1_elips_mdata$niche_volume,"**\n\n"))
cat(paste0("El volumen del segundo polígono (México) en $\\mathbf E$ es: **",
    p2_elips_mdata$niche_volume,"**\n\n"))
cat(paste0("El volumen del tercer polígono (Canadá) en $\\mathbf E$ es: **",
    p3_elips_mdata$niche_volume,"**\n\n"))

#' 
#' 
#' ## Agradecimientos
#' 
#'  - Lázaro Guevara López (Instituto de Biología, UNAM)
#'  - Enrique Martínez Meyer (Instituto de Biología, UNAM)
#'  - Townsend Peterson (Biodiversity Institute, KU)
#'  - Manuel Falconi (Facultad de Ciencias, UNAM)
#'  - Jorge Soberón (Biodiversity Institute, KU)
#' 
