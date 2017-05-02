## citi - expanding - plot

nyc_map <- get_googlemap("east vallage", zoom = 12, style = style_string, maptype = "roadmap")

plot <- ggmap(nyc_map)
color_count <- 2
for (i in data_name_list){
  print(i)
  if ( nrow(citi_expanding_data[[i]][citi_expanding_data[[i]]$newS == TRUE, ]) == 0){
    print("ha")
    # do nothing
  } else{
    plot <- plot + geom_point(data = citi_expanding_data[[i]][citi_expanding_data[[i]]$newS == TRUE, ],
                              mapping = aes(x = long, y = lat),
                              color = color_count)
    color_count <- color_count + 1
  }
}

plot
