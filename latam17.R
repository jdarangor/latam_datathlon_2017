#// Project - Visualizing HealthQuality in Colombia
#%>%
rm(list=ls(all=TRUE))
options(encoding = "UTF-8")

library(sp)
library(RColorBrewer)
library(ggplot2)
library(maptools)
library(scales)

# read the shapes of your map
setwd('~/Documents/Work/Data Science/Datathlon/')
#Set up map
#COL_admin1 -> states and COL_Admin2 municipalities
# source: 
ohsCol2 <- readShapeSpatial('~/Documents/Work/Data Science/Datathlon/COL_adm/COL_adm2.shp')
ohsColI2 <- fortify(ohsCol2)

grupo2 <- data.frame(id = unique(ohsColI2[ , c("id")]))
grupo2[ , "Porcentaje"] <- runif(nrow(grupo2), 0, 1)

ohsColI2 <- merge(ohsColI2, grupo2, by = "id")
mapColDep <- ggplot() +
  geom_polygon(data=ohsColI2, 
               aes(x=long, y=lat,group = group, fill = Porcentaje), 
               colour ="black", size = 0.1) +
  labs(title = "Colombia", fill = "") +
  labs(x="",y="",title="Colombia") +
  scale_x_continuous(limits=c(-80,-65))+
  scale_y_continuous(limits=c(-5,13) )

mapColDep

ggsave(mapColDep, file = "mapColDep.png", 
       width = 5, height = 4.5, type = "cairo-png")
