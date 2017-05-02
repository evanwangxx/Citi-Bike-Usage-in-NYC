library(RJSONIO)
library(tidyverse)

style<-'[
  {
"elementType": "geometry",
"stylers": [
{
  "color": "#212121"
}
]
},
{
  "elementType": "labels",
  "stylers": [
  {
  "visibility": "off"
  }
  ]
},
  {
  "elementType": "labels.icon",
  "stylers": [
  {
  "visibility": "off"
  }
  ]
  },
  {
  "elementType": "labels.text.fill",
  "stylers": [
  {
  "color": "#757575"
  }
  ]
  },
  {
  "elementType": "labels.text.stroke",
  "stylers": [
  {
  "color": "#212121"
  }
  ]
  },
  {
  "featureType": "administrative",
  "elementType": "geometry",
  "stylers": [
  {
  "color": "#757575"
  }
  ]
  },
  {
  "featureType": "administrative.country",
  "elementType": "labels.text.fill",
  "stylers": [
  {
  "color": "#9e9e9e"
  }
  ]
  },
  {
  "featureType": "administrative.land_parcel",
  "stylers": [
  {
  "visibility": "off"
  }
  ]
  },
  {
  "featureType": "administrative.locality",
  "elementType": "labels.text.fill",
  "stylers": [
  {
  "color": "#bdbdbd"
  }
  ]
  },
  {
  "featureType": "administrative.neighborhood",
  "stylers": [
  {
  "visibility": "off"
  }
  ]
  },
  {
  "featureType": "poi",
  "elementType": "labels.text.fill",
  "stylers": [
  {
  "color": "#757575"
  }
  ]
  },
  {
  "featureType": "poi.park",
  "elementType": "geometry",
  "stylers": [
  {
  "color": "#181818"
  }
  ]
  },
  {
  "featureType": "poi.park",
  "elementType": "labels.text.fill",
  "stylers": [
  {
  "color": "#616161"
  }
  ]
  },
  {
  "featureType": "poi.park",
  "elementType": "labels.text.stroke",
  "stylers": [
  {
  "color": "#1b1b1b"
  }
  ]
  },
  {
  "featureType": "road",
  "elementType": "geometry.fill",
  "stylers": [
  {
  "color": "#2c2c2c"
  }
  ]
  },
  {
  "featureType": "road",
  "elementType": "labels.text.fill",
  "stylers": [
  {
  "color": "#8a8a8a"
  }
  ]
  },
  {
  "featureType": "road.arterial",
  "elementType": "geometry",
  "stylers": [
  {
  "color": "#373737"
  }
  ]
  },
  {
  "featureType": "road.highway",
  "elementType": "geometry",
  "stylers": [
  {
  "color": "#3c3c3c"
  }
  ]
  },
  {
  "featureType": "road.highway.controlled_access",
  "elementType": "geometry",
  "stylers": [
  {
  "color": "#4e4e4e"
  }
  ]
  },
  {
  "featureType": "road.local",
  "elementType": "labels.text.fill",
  "stylers": [
  {
  "color": "#616161"
  }
  ]
  },
  {
  "featureType": "transit",
  "elementType": "labels.text.fill",
  "stylers": [
  {
  "color": "#757575"
  }
  ]
  },
  {
  "featureType": "water",
  "elementType": "geometry",
  "stylers": [
  {
  "color": "#000000"
  }
  ]
  },
  {
  "featureType": "water",
  "elementType": "labels.text.fill",
  "stylers": [
  {
  "color": "#3d3d3d"
  }
  ]
  }
  ]'
style_list<- fromJSON(style, asText = TRUE)

create_style_string<- function(style_list){
  style_string <- ""
  for(i in 1:length(style_list)){
    if("featureType" %in% names(style_list[[i]])){
      style_string <- paste0(style_string, "feature:", 
                             style_list[[i]]$featureType, "|")      
    }
    elements <- style_list[[i]]$stylers
    style_string<-paste0(style_string,"element:",style_list[[i]]$elementType,"|")
    a <- lapply(elements, function(x)paste0(names(x), ":", x)) %>%
      unlist() %>%
      paste0(collapse="|")
    style_string <- paste0(style_string, a)
    if(i < length(style_list)){
      style_string <- paste0(style_string, "&style=")       
    }
  }  
  # google wants 0xff0000 not #ff0000
  style_string <- gsub("#", "0x", style_string)
  return(style_string)
}

style_string<- create_style_string(style_list)

