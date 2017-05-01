## Network
#rm(list = ls())
Data <- read.csv("/Users/Hongbo/Desktop/DataVizProject/citi_data/201608.csv", stringsAsFactors = FALSE)
library(network)
library(ggplot2)
## Unique Stations
long <- c(NA)
lat <- unique(Data$end.station.latitude)
name <- c(NA)
for( i in 1:length(lat)){
  index <- which(Data$end.station.latitude == lat[i])[1]
  long[i] <- Data$end.station.longitude[index]
  name[i] <- Data$end.station.name[index]
}
citi_station_end <- data.frame(name, long, lat)


## Connection Matrix
A <- data.frame( matrix(0, nrow = nrow(citi_station_end), ncol = nrow(citi_station_end)))
colnames(A) <- citi_station_end$name; rownames(A) <- citi_station_end$name

b <- data.frame( matrix(0, nrow = nrow(citi_station_end)^2, ncol = 7) )

count = 0
for (i in row.names(A)){
  stop_list <- Data[which(Data$start.station.name == i), "end.station.name"]
  for (j in stop_list){
    A[i, j] <- A[i, j] + 1
  }
  count = count + 1
  cat("count: ", count, "\n")
}

# Making a network data object
citi_station <- network(A, directed = FALSE)
network.size(citi_station)
network.edgecount(citi_station)
network.density(citi_station)

summary(citi_station)

# Fortify() the data for ggplot
library(ggnetwork)
library(ggmap)

nyc_map <- get_map("roosevelt island", zoom = 12, source = 'stamen', maptype = 'toner')
flo_df <- ggnetwork(A, 
                    layout = "fruchtermanreingold", 
                    cell.jitter = 0.75)

ggplot(flo_df, aes(x, y, xend = xend, yend = yend)) +
  geom_edges(alpha = 0.1, color = "gold") +
  geom_nodes(size = 0.1, color = "red") +
  theme_blank()

nyc_map <- get_googlemap("east vallage", zoom = 12, style = style_string, maptype = "roadmap")

ggmap(nyc_map) + 
  geom_point(data = citi_station_end, 
             mapping = aes(x = long, y = lat), color = "red", size = 0.01)



