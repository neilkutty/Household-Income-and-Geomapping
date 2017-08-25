hhgeo = read.csv('household_income_kaggle.csv')
hhgeo.small = hhgeo[sample(nrow(hhgeo), 1000),]
library(leaflet)
library(dplyr)
library(ggplot2)



## Create leaflet map
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


## Group and Count

#   County Stats
county.stats = hhgeo.small %>%
    select(County, Mean, Median, Stdev, Households) %>%
    group_by(County) %>%
    summarise(Avg_Mean = mean(Mean),
           Avg_Median = mean(Median),
           Avg_StdDev = mean(Stdev),
           Num_Households = sum(Households)) 

#   State Stats
state.stats = hhgeo.small %>%
    select(State_Name, Mean, Median, Stdev, Households) %>%
    group_by(State_Name) %>%
    summarise(Avg_Mean = mean(Mean),
              Avg_Median = mean(Median),
              Avg_StdDev = mean(Stdev),
              Num_Households = sum(Households)) 

# Type Stats
type.stats = hhgeo.small %>%
    select(Type, Mean, Median, Stdev, Households) %>%
    group_by(Type) %>%
    summarize(Avg_Mean = mean(Mean),
              Avg_Median = mean(Median),
              Avg_Stdev = mean(Stdev),
              Num_Households = sum(Households))


# Plot State-grouped 

p1 = ggplot(data = state.stats, aes(x=reorder(State_Name,Num_Households), y=Num_Households, fill=Avg_Median)) +
    geom_bar(stat='identity') +
    coord_flip()


p2 = ggplot(data = county.stats, aes(x=reorder(County,Num_Households), y=Num_Households, fill=Avg_Median)) +
    geom_bar(stat='identity') +
    coord_flip()
    
p3 =  ggplot(data = type.stats, aes(x=reorder(Type,Num_Households), y=Num_Households, fill=Avg_Median)) +
    geom_bar(stat='identity') +
    coord_flip()

multiplot(p1,p3)
# p4 =  ggplot(data = type.stats, aes(x=reorder(Type,Num_Households), y=Num_Households, fill=Avg_Median)) +
#     geom_bar(stat='identity') +
#     coord_flip()