### network - ggplot2

## style_string from map_style.R
library(ggplot2)
#Data <- read.csv("/Users/Hongbo/Desktop/DataVizProject/citi_data/201610.csv", stringsAsFactors = FALSE)
#nyc_map <- get_googlemap("east vallage", zoom = 12, style = style_string, maptype = "roadmap")

name <- c(NA)
long <- c(NA)
freq <- c(NA)
lat <- unique(Data$End.Station.Latitude)
for( i in 1:length(lat)){
  index <- which(Data$End.Station.Latitude == lat[i])[1]
  long[i] <- Data$End.Station.Longitude[index]
  name[i] <- Data$End.Station.Name[index]
}
station <- data.frame(name, long, lat)


A <- data.frame( matrix(0, nrow = nrow(station), ncol = nrow(station)))
colnames(A) <- station$name; rownames(A) <- station$name
count = 0
for (i in row.names(A)){
  stop_list <- Data[which(Data$Start.Station.Name == i), "End.Station.Name"]
  for (j in stop_list){
    A[i, j] <- A[i, j] + 1
  }
  count = count + 1
  cat("count: ", count, "\n")
}

name <- c(NA)
long <- c(NA)
freqS <- c(NA)
freqE <- c(NA)
diff <- c(NA)
lat <- unique(Data$End.Station.Latitude)
for( i in 1:length(lat)){
  index <- which(Data$End.Station.Latitude == lat[i])[1]
  long[i] <- Data$End.Station.Longitude[index]
  name[i] <- Data$End.Station.Name[index]
  freqS[i] <- sum(A[name[i], ])
  freqE[i] <- sum(A[, name[i]])
  diff[i] <- abs(freqS[i] - freqE[i])
}
station <- data.frame(name, long, lat, freqS, freqE, diff)



## plot network
ggmap(nyc_map) + 
  geom_point(data = station,
             mapping = aes(x = long, y = lat, alpha = freqS/6000, size = diff/80000),
             color = "blue") + 
  geom_point(data = station,
             mapping = aes(x = long, y = lat, alpha = freqE/10000, size = diff/80000),
             color = "red") 
  guides(alpha = FALSE, size = FALSE)

  

