## citi bike expanding - data
## this file is to create a data frame of the citi bike expanding

data_name_list <- read.csv("/Users/Hongbo/Desktop/DataVizProject/citiDataName.csv", header = FALSE)[, 1]
citi_expanding_data <- list()

for (index in 1:length(data_name_list)){
  print(data_name_list[index])                                   ## Load Data
  data_location <- paste("/Users/Hongbo/Desktop/DataVizProject/citi_data/", 
                         data_name_list[index], 
                         ".csv", sep = "")
  Data <- read.csv(data_location, stringsAsFactors = FALSE) 
  names(Data) <- tolower(names(Data))
  
  long <- c(NA)                                                  ## initial values 
  lat <- unique(Data$end.station.latitude)
  newS <- c(NA)
  name <- c(NA)
  date <- c(NA)
  
  for( i in 1:length(lat)){                                      ## find unique stations
    index_lat <- which(Data$end.station.latitude == lat[i])
    long[i] <- Data$end.station.longitude[index_lat]
    name[i] <- Data$end.station.name[index_lat]
    
    date[i] <- paste(substring(data_name_list[index], 1, 4),
                     substring(data_name_list[index], 5, 6),
                     "01",
                     sep = "/")
    
    if (index == 1){                                             ## contained variable
      newS <- rep(TRUE, length(lat))
    } else{
      if (length(which(citi_expanding_data[[data_name_list[index - 1]]]$long == long[i])) != 0){      
        newS[i] <- FALSE
      } else{
        newS[i] <- TRUE
      }
    }
  }
  cat(length(name), " | ", length(long), " | ", length(lat), " | ", length(newS), " \n")
  citi_expanding_data[[data_name_list[index]]] <- data.frame(name, date, long, lat, newS)
}
write.table(citi_expanding_data, "citi_expanding_data.csv")

#for (i in data_name_list){
#  citi_expanding_data[[i]]$date <- as.Date(citi_expanding_data[[i]]$date, "%Y/%m/%b")
#  citi_expanding_data_json[[i]] <- geojson_json(citi_expanding_data[[i]], 
#                                           lat="lat",
#                                           lon="long")
#}

#citi_expending_combine <- NA
#for (i in data_name_list){
#  if (i == 201307){
#    citi_expending_combine <- citi_expanding_data[[i]]
#  } else{
#    citi_expanding_combine <- rbind(citi_expending_combine, citi_expanding_data[[i]])
#  }
#}


library(plotly)
time <- c(NA)
total_station_number <- c(NA)
index <- 1

for (i in data_name_list){
  if (substring(i, 1, 4) == "2013"){
    time[index] <- paste("2013", substring(i, 5, 6), sep = "/")
  } else if (substring(i, 1, 4) == "2014"){
    time[index] <- paste("2014", substring(i, 5, 6), sep = "/")
  } else if (substring(i, 1, 4) == "2015"){
    time[index] <- paste("2015", substring(i, 5, 6), sep = "/")
  } else if (substring(i, 1, 4) == "2016"){
    time[index] <- paste("2016", substring(i, 5, 6), sep = "/")
  }
  
  total_station_number[index] <- nrow(citi_expanding_data[[i]])
  index <- index + 1
}

expanding_num <- data.frame(time, total_station_number)
colnames(expanding_num) <- c("Date", "Total Station Number")
write.table(expanding_num, "expanding_num.csv")

plot_ly(expanding_num, y = ~`Total Station Number`, x = ~Date, 
        type = "scatter", mode='lines')





