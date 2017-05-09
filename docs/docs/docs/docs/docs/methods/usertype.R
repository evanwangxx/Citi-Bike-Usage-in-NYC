
data_name_list <- read.csv("/Users/Hongbo/Desktop/DataVizProject/citiDataName.csv", header = FALSE)[, 1]
citi_expanding_data <- list()

#usertype <- matrix(0, nrow = length(data_name_list), ncol = 3)
k <- 2
for (index in 28:(length(data_name_list)-k)){
  print(data_name_list[index])                                   ## Load Data
  data_location <- paste("/Users/Hongbo/Desktop/DataVizProject/citi_data/", 
                         data_name_list[index], 
                         ".csv", sep = "")
  Data <- read.csv(data_location, stringsAsFactors = FALSE) 
  names(Data) <- tolower(names(Data))
  
  sub <- 0; cos <- 0;
  for (i in 1:nrow(Data)){
    if (Data$usertype[i] == "Subscriber"){
      sub <- sub + 1
    } else {
      cos <- cos + 1
    }
  }
  cat("sub: ", sub, " cos: ", cos, "\n")
  
  usertype[index, 1] <- paste(substring(data_name_list[index], 1, 4),
                              substring(data_name_list[index], 5, 6),
                              "01",
                              sep = "/")
  usertype[index, 2] <- sub
  usertype[index, 3] <- cos
}

for (index in (length(data_name_list) - 2):length(data_name_list)){
  print(data_name_list[index])                                   ## Load Data
  data_location <- paste("/Users/Hongbo/Desktop/DataVizProject/citi_data/", 
                         data_name_list[index], 
                         ".csv", sep = "")
  Data <- read.csv(data_location, stringsAsFactors = FALSE) 
  names(Data) <- tolower(names(Data))
  
  sub <- 0; cos <- 0;
  for (i in 1:row(Data)){
    if (Data$`User Type`[i] == "Subscriber"){
      sub <- sub + 1
    } else {
      cos <- cos + 1
    }
  }
  
  usertype[index, 1] <- paste(substring(data_name_list[index], 1, 4),
                              substring(data_name_list[index], 5, 6),
                              "01",
                              sep = "/")
  usertype[index, 2] <- sub
  usertype[index, 3] <- cos
}

write.csv(usertype, "usertype.csv")
