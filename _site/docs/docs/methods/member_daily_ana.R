## Membership Data
#rm(list = ls())
year <- c(2014, 2015, 2016)
quan <- c("Q1", "Q2", "Q3", "Q4")
names <- c("Date", 
           "Past24_trip",
           "Cumulative_trips_since_lunch",
           "Miles_traveled_past24",
           "Miles_to_date",
           "Total_Annual_Members_Sold")

Y2013Q4 <- read.csv("/Users/Hongbo/Desktop/DataVizProject/membership/2013Q4.csv")
for (i in year){
  for(j in quan){
    dataname <- paste(i, j, sep = "")
    data_location <- paste("/Users/Hongbo/Desktop/DataVizProject/membership/", 
                           dataname, 
                           ".csv", sep = "")
    temp_data_frame <- read.csv(data_location, stringsAsFactors = FALSE)[, c(1:6)]
    temp_data_frame
    colnames(temp_data_frame) <- names
    temp_data_frame$Miles_to_date <- as.numeric(as.character(temp_data_frame$Miles_to_date))
    temp_data_frame$Total_Annual_Members_Sold <- as.numeric(as.character(temp_data_frame$Total_Annual_Members_Sold))
    assign( paste("Y", dataname, sep = ""), temp_data_frame)
  }
}

Data2014 <- rbind(Y2014Q1, Y2014Q2, Y2014Q3, Y2014Q4)
Data2015 <- rbind(Y2015Q1, Y2015Q2, Y2015Q3, Y2015Q4)
Data2016 <- rbind(Y2016Q1, Y2016Q2, Y2016Q3, Y2016Q4)

Date_read <- c(NA)
j = 1
for (i in Data2014$Date){
  string_array <- strsplit(i, split = "/")
  Date_read[j] <- paste(string_array[[1]][1], "/",
                        string_array[[1]][2], "/", "2014",
                        sep = "")
  j <- j + 1
}
Data2014$Date <- Date_read

Date_read <- c(NA)
j = 1
for (i in Data2016$Date){
  string_array <- strsplit(i, split = "/")
  Date_read[j] <- paste(string_array[[1]][1], "/",
                     string_array[[1]][2], "/", "2016",
                     sep = "")
  j <- j + 1
}
Data2016$Date <- Date_read


Data2014$Date <- as.Date(Data2014$Date, "%m/%d/%Y")
Data2015$Date <- as.Date(Data2015$Date, "%m/%d/%Y")
Data2016$Date <- as.Date(Data2016$Date, "%m/%d/%Y")
Data_All <- rbind(Data2014, Data2015, Data2016)
#Data_All$Miles_to_date <- as.numeric(Data_All$Miles_to_date)
Data_All$Total_Annual_Members_Sold[627] <- mean(Data_All$Total_Annual_Members_Sold[-627])

library(ggplot2)
library(ggthemes)

ggplot(data = Data_All) + 
  geom_line(mapping = aes(x = Date, y = Past24_trip), 
            color = "red", alpha = 0.5) +
  ggtitle("Citi Bike Miles Per Day") +
  ylab("") + xlab("") +
  scale_y_continuous(name = "Miles") +
  annotate("text", x=as.Date("2014-12-31", "%Y-%m-%d"), y=2000, label= "Winter", size = 5) + 
  annotate("text", x=as.Date("2016-2-11", "%Y-%m-%d"), y=7000, label= "Winter", size = 5) + 
  annotate("text", x=as.Date("2014-8-01", "%Y-%m-%d"), y=43000, label= "Summer", size = 5) + 
  annotate("text", x=as.Date("2015-8-01", "%Y-%m-%d"), y=55000, label= "Summer", size = 5) +
  annotate("text", x=as.Date("2016-8-01", "%Y-%m-%d"), y=68000, label= "Summer", size = 5) +
  theme_tufte(base_size = 15) + 
  theme(text = element_text(color = "gray20"),
        legend.position = c("top"), # position the legend in the upper left 
        legend.direction = "horizontal",
        legend.justification = 0.05, # anchor point for legend.position.
        legend.text = element_text(size = 11, color = "gray10"),
        legend.key.height=unit(1,"line"),
        legend.key.width=unit(3,"line"),
        axis.text.y  = element_text(face = "italic"),
        axis.title.x = element_text(vjust = -1), # move title away from axis
        axis.title.y = element_text(vjust = 1), # move away for axis
        axis.ticks.y = element_blank(), # element_blank() is how we remove elements
        axis.line = element_line(color = "gray40", size = 0.5),
        #panel.grid.major = element_line(color = "gray50", size = 0.5),
        panel.grid.major.x = element_blank(),
        plot.margin = margin(t = 0, r = 0, b = 40, l = 5, unit = "pt"),
        plot.title = element_text(face = "bold", color = "black", size = 18)
  )

ggplot(data = Data_All) + 
  geom_area(mapping = aes(x = Date, y = Total_Annual_Members_Sold), 
            fill = "blue", alpha = 0.5) +
  ggtitle("Total Annual Members Sold ") +
  ylab("")
  

  
  
