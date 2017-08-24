hhgeo = read.csv('household_income_kaggle.csv')
hhgeo.small = hhgeo[sample(nrow(hhgeo), 1000),]
library(leaflet)
library(dplyr)

points <- cbind(hhgeo.small$Lon,hhgeo.small$Lat)

leaflet() %>% 
    addProviderTiles('OpenStreetMap.Mapnik',
                     options = providerTileOptions(noWrap = TRUE)
                     ) %>%
    addMarkers(data = points,
               popup = paste0("<strong>State: </strong>",
                              hhgeo.small$State_Name,                 
                              "<br><strong>County: </strong>", 
                              hhgeo.small$County, 
                              "<br><strong>City: </strong>", 
                              hhgeo.small$City,
                              "<br><strong>Type: </strong>",
                              hhgeo.small$Type,
                              "<br><strong>Mean Income: </strong><br>",
                              hhgeo.small$Mean,
                              "<br><strong>Median Income: </strong><br>",
                              hhgeo.small$Median,
                              "<br><strong>Number Households: </strong><br>",
                              hhgeo.small$Households
               ),
               clusterOptions = markerClusterOptions())
    
county.stats = hhgeo.small %>%
    select(County, Mean, Median, Stdev, Households) %>%
    group_by(County) %>%
    summarise(Avg_Mean = mean(Mean),
           Avg_Median = mean(Median),
           Avg_StdDev = mean(Stdev),
           Num_Households = sum(Households)) 
