library(readxl)
library(xlsx)
library(ggplot2)
library(dplyr)
library(tidyverse)
library(ggmap)
install.packages("ggrepel")
library(ggrepel) #repel overlapping text labels

#load study site data first
getwd()
setwd("D:/R_work/Data")
getwd()

Study.site <- read_xlsx("Studysites_20190725.xlsx")
str(Study.site)



#Google requires a registered API key.
#?register_google

register_google(key = "AIzaSyCsT9QbXhL9chOPEPdaJL3s4CbbWZguy0E ")

map.Korea <-ggmap(get_googlemap("south korea", zoom=5))
map.Korea

basemap <- get_map(location = 'South korea', zoom=7, color = 'bw')
ggmap(basemap)

S.Korea.Base <-get_googlemap("Chilgok", zoom = 8, maptype = "terrain")
S.Korea.Base <-get_googlemap("Chilgok", zoom = 9, maptype = "roadmap")
S.Korea.Base <-get_googlemap("Chilgok", zoom = 8)
ggmap(S.Korea.Base)


testmap <- ggmap(basemap)+geom_point(data=Study.site, aes(x=Lon, y=Lat))

#Mind that below image (map) deosn't have one place in display due to the boundary issue
studysite.map <- ggmap(S.Korea.Base)+
  geom_point(data=Study.site, aes(x=Lon, y=Lat, colour=River.Type), size=4)+
  geom_text(data=Study.site, aes(x=Lon, y=Lat, label=New.Code.Name), size=4)+
  labs(title = "Study Area", x="Longitude", y="Latitude")
studysite.map
  

studysite.map.label <- ggmap(S.Korea.Base)+
  geom_point(data=Study.site, aes(x=Lon, y=Lat, colour=River.Type), size=4)+
  geom_label_repel(data=Study.site, aes(x=Lon, y=Lat, label=New.Code.Name), alpha=0.8)+
  labs(title = "Study Area", x="Longitude", y="Latitude")
studysite.map.label


