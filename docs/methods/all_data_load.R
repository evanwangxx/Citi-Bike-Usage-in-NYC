# Citi Bike 
#rm(list = ls())

### Load Data
data_name_list <- read.csv("/Users/Hongbo/Desktop/DataVizProject/citiDataName.csv", header = FALSE)[, 1]
for (i in 1:length(data_name_list)){
  print(data_name_list[i])
  data_location <- paste("/Users/Hongbo/Desktop/DataVizProject/citi_data/", 
                     data_name_list[i], 
                     ".csv", sep = "")
  assign( paste("citi", data_name_list[i], sep = ""), read.csv(data_location) )
}


### 

