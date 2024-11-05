###Bodie Spinner
##Data Viz
#04/10/23
library(tidyverse) #which includes ggplot2
library(tmap) # interactive and static maps
library(sf) # to manage spatial data to make maps
library(tigris) # to import census tract spatial data
census_data <- read_csv("data/larimer_census.csv")
view(census_data)
larimer_tracts <- tracts(state = "CO", county = "Larimer", progress_bar = FALSE) %>% 
  select(GEOID) # retrevies shapefiles with spaital info

#Join by attribute
census_spatial <- full_join(larimer_tracts, census_data, by = ("GEOID"))
view(census_spatial)


###Plots!
census_data %>% 
  ggplot(aes(x = median_age, y = non_white_percent))+
  geom_point(color = "black")

# customizations will vary depending on what geom_ you are using.
## geom_point
#specific color and size value
census_data %>% 
  ggplot(aes(x = median_age, y = non_white_percent))+
  geom_point(color = "red", size = 4, alpha = 0.5) #alpha 0-1 is transparency
#aes is used when sizing or coloring a point by a varible
# size by a variable
census_data %>% 
  ggplot(aes(x = median_age, y = non_white_percent))+
  geom_point(aes(size = median_income), color = "red")
# color by a variable
census_data %>% 
  ggplot(aes(x = median_age, y = non_white_percent))+
  geom_point(aes(color = median_income), size = 4)

#Titles and Limits
census_data %>% 
  ggplot(aes(x = median_age, y = non_white_percent))+
  geom_point(aes(size = median_income), color = "black")+
  ggtitle("Census Tract socioeconomic data for Larimer County")+
  xlab("Median Age")+ #lable axises
  ylab("People of Color (%)")+
  xlim(c(20, 70))+ #limits of x axis lables
  ylim(c(0, 35)) #limts of y axis lable
#xlim and ylim can ommit data
##mutiole lables can be put within labs
census_data %>% 
  ggplot(aes(x = median_age, y = non_white_percent))+
  geom_point(aes(size = median_income), color = "black")+
  labs(
    title = "Census Tract socioeconomic data for Larimer County",
    x = "Median Age",
    y = "People of Color (%)"
  ) +
  xlim(c(20, 70))+
  ylim(c(0, 35))


#chart componets with themes
census_data %>%
  ggplot(aes(x = median_age, y = non_white_percent)) +
  geom_point(aes(size = median_income), color = "black") +
  ggtitle("Census Tract socioeconomic data for Larimer County") +
  xlab("Median Age") +
  ylab("People of Color (%)") +
  theme(
    #edit plot title
    plot.title = element_text(size = 16, color = "blue"),
    # edit x axis title
    axis.title.x = element_text(face = "italic", color = "orange"),
    # edit y axis ticks
    axis.text.y = element_text(face = "bold"),
    # edit grid lines
    panel.grid.major = element_line(color = "black"),
    
  )

census_data %>%
  ggplot(aes(x = median_age, y = non_white_percent)) +
  geom_point(aes(size = median_income), color = "black") +
  ggtitle("Census Tract socioeconomic data for Larimer County") +
  xlab("Median Age") +
  ylab("People of Color (%)") +
  scale_x_continuous(breaks = seq(15, 90, 5))+ #sets xlim and scales by 5
  theme(
    # angle axis labels
    axis.text.x = element_text(angle = 45) #adjust text angle
  )

##Themes
census_data %>%
  ggplot(aes(x = median_age, y = non_white_percent)) +
  geom_point(aes(size = median_income), color = "black") +
  ggtitle("Census Tract socioeconomic data for Larimer County") +
  xlab("Median Age") +
  ylab("People of Color (%)")+
  theme_minimal() #built in theme

census_data %>%
  ggplot(aes(x = median_age, y = non_white_percent)) +
  geom_point(aes(size = median_income), color = "black") +
  ggtitle("Census Tract socioeconomic data for Larimer County") +
  xlab("Median Age") +
  ylab("People of Color (%)")+
  theme_classic()

library(ggthemes)

census_data %>%
  ggplot(aes(x = median_age, y = non_white_percent)) +
  geom_point(aes(size = median_income), color = "black") +
  ggtitle("Socioeconomic data for Larimer County") +
  xlab("Median Age") +
  ylab("People of Color (%)")+
  ggthemes::theme_wsj()+
  # make the text smaller
  theme(text = element_text(size = 8))

census_data %>%
  ggplot(aes(x = median_age, y = non_white_percent)) +
  geom_point(aes(size = median_income), color = "black") +
  ggtitle("Census Tract socioeconomic data for Larimer County") +
  xlab("Median Age") +
  ylab("People of Color (%)")+
  ggthemes::theme_economist()

census_data %>%
  ggplot(aes(x = median_age, y = non_white_percent)) +
  geom_point(aes(size = median_income), color = "black") +
  ggtitle("Census Tract socioeconomic data for Larimer County") +
  xlab("Median Age") +
  ylab("People of Color (%)")+
  ggthemes::theme_economist()+
  theme(
    legend.position = "bottom" #apply any elements from theme() afterwards to clean it up. For example, change the legend position:
  )


##Color, Size, Legends
library(RColorBrewer)
library(viridis)

census_data %>%
  ggplot(aes(x = median_age, y = non_white_percent)) +
  geom_point(aes(size = median_income, color = median_income)) +
  ggtitle("Census Tract socioeconomic data for Larimer County") +
  xlab("Median Age") +
  ylab("People of Color (%)")+
  viridis::scale_colour_viridis()#set viridis color scheme

census_data %>%
  ggplot(aes(x = median_age, y = non_white_percent)) +
  geom_point(aes(size = median_income, color = median_income)) +
  ggtitle("Census Tract socioeconomic data for Larimer County") +
  xlab("Median Age") +
  ylab("People of Color (%)")+
  scale_color_distiller(palette = "Greens", direction = 1) #sets scale for green

census_data %>%
  ggplot(aes(x = median_age, y = non_white_percent)) +
  geom_point(aes(size = median_income, color = median_income)) +
  ggtitle("Census Tract socioeconomic data for Larimer County") +
  xlab("Median Age") +
  ylab("People of Color (%)")+
  scale_color_distiller(palette = "Greens", direction = 1)+
  scale_radius(range = c(0.5, 6)) #sets range of point size

census_data %>%
  ggplot(aes(x = median_age, y = non_white_percent)) +
  geom_point(aes(size = median_income, color = median_income)) +
  ggtitle("Census Tract socioeconomic data for Larimer County") +
  xlab("Median Age") +
  ylab("People of Color (%)")+
  scale_color_distiller(palette = "BuGn", direction = 1)+
  scale_radius(range = c(2, 6))+
  theme_minimal()+
  #customize legend, creates 1 legened for size and color
  guides(color= guide_legend(title = "Median Income"), size=guide_legend(title = "Median Income"))

##Annotations
census_data %>%
  ggplot(aes(x = median_age, y = non_white_percent)) +
  geom_point(aes(size = median_income, color = median_income)) +
  ggtitle("Census Tract socioeconomic data for Larimer County") +
  xlab("Median Age") +
  ylab("People of Color (%)")+
  scale_color_distiller(palette = "BuGn", direction = 1)+
  scale_radius(range = c(2, 6))+
  theme_minimal()+
  guides(color= guide_legend(title = "Median Income"), size=guide_legend(title = "Median Income"))+
  # add annotation
  annotate(geom = "text", x=76, y = 62,
           label = "Rocky Mountain National Park region \n Total Populaion: 53")
#geom: type of annotation, most often text
#x: position on the x axis to put the annotation
#y: position on the y axis to put the annotation
#label: what you want the annotation to say
#Optional: color, size, angle, and more.

census_data %>%
  ggplot(aes(x = median_age, y = non_white_percent)) +
  geom_point(aes(size = median_income, color = median_income)) +
  ggtitle("Census Tract socioeconomic data for Larimer County") +
  xlab("Median Age") +
  ylab("People of Color (%)") +
  scale_color_distiller(palette = "BuGn", direction = 1) +
  scale_radius(range = c(2, 6)) +
  theme_minimal() +
  guides(color = guide_legend(title = "Median Income"),
         size = guide_legend(title = "Median Income")) +
  annotate(geom = "text",
           x = 74,
           y = 62,
           label = "Rocky Mountain National Park region \n Total Populaion: 53") +
  # add arrow
  geom_curve(
    aes(
      x = 84,
      xend = 88,
      y = 60,
      yend = 57.5
    ),
    arrow = arrow(length = unit(0.2, "cm")),
    size = 0.5,
    curvature = -0.3
  )

census_data %>%
  ggplot(aes(x = median_age, y = non_white_percent)) +
  geom_point(aes(size = median_income, color = median_income), alpha = 0.9) +
  labs(
    title = "Socioeconomic data for Larimer County",
    subtitle = "Median age, median income, and percentage of people of color for each census tract",
    x = "Median Age",
    y = "People of Color (%)",
    caption = "Data obtained from the U.S. Census 5-year American Community Survey Samples for 2017-2021"
  )+
  scale_radius(range = c(2, 6)) +
  theme_classic() +
  scale_color_viridis() + #use the Viridis palette
  guides(color = guide_legend(title = "Median Income"),
         size = guide_legend(title = "Median Income")) +
  theme(
    axis.title = element_text(face = "bold", size = 10),
    plot.title = element_text(face = "bold",size = 15, margin = unit(c(1,1,1,1), "cm")),
    plot.subtitle = element_text(size = 10, margin = unit(c(-0.5,0.5,0.5,0.5), "cm")),
    plot.caption = element_text(face = "italic", hjust = -0.2),
    plot.title.position = "plot", #sets the title to the left
    legend.position = "bottom",
    legend.text = element_text(size = 8)
  ) +
  annotate(geom = "text",
           x = 74,
           y = 62,
           label = "Rocky Mountain National Park region \n Total Populaion: 53",
           size = 3,
           color = "black") +
  geom_curve(
    aes(
      x = 82,
      xend = 88,
      y = 60,
      yend = 57.5
    ),
    arrow = arrow(length = unit(0.2, "cm")),
    size = 0.5,
    color = "black",
    curvature = -0.3
  )

library(ggdark)
census_data %>%
  ggplot(aes(x = median_age, y = non_white_percent)) +
  geom_point(aes(size = median_income, color = median_income), alpha = 0.9) +
  labs(
    title = "Socioeconomic data for Larimer County",
    subtitle = "Median age, median income, and percentage of people of color for each census tract",
    x = "Median Age",
    y = "People of Color (%)",
    caption = "Data obtained from the U.S. Census 5-year American Community Survey Samples for 2017-2021"
  )+
  scale_radius(range = c(2, 6)) +
  dark_theme_classic() +#add ggdark
  scale_color_viridis() + #use the Viridis palette
  guides(color = guide_legend(title = "Median Income"),
         size = guide_legend(title = "Median Income")) +
  theme(
    axis.title = element_text(face = "bold", size = 10),
    plot.title = element_text(face = "bold",size = 15, margin = unit(c(1,1,1,1), "cm")),
    plot.subtitle = element_text(size = 10, margin = unit(c(-0.5,0.5,0.5,0.5), "cm")),
    plot.caption = element_text(face = "italic", hjust = -0.2),
    plot.title.position = "plot", #sets the title to the left
    legend.position = "bottom",
    legend.text = element_text(size = 8)
  ) +
  annotate(geom = "text",
           x = 74,
           y = 62,
           label = "Rocky Mountain National Park region \n Total Populaion: 53",
           size = 3) +
  geom_curve(
    aes(
      x = 82,
      xend = 88,
      y = 60,
      yend = 57.5
    ),
    arrow = arrow(length = unit(0.2, "cm")),
    size = 0.5,
    curvature = -0.3
  )

#specify the file path and name, and height/width (if necessary)
#by default it will save the last plot in the “Plots” pane.
ggsave(filename = "data/census_plot.png", width = 6, height = 5, units = "in")

###Interactive Plot
library(plotly)
ggplotly(census_data %>%
           ggplot(aes(x = median_age, y = non_white_percent)) +
           geom_point(aes(size = median_income, color = median_income), alpha = 0.9) +
           labs(
             title = "Socioeconomic data for Larimer County",
             subtitle = "Median age, median income, and percentage of people of color for each census tract",
             x = "Median Age",
             y = "People of Color (%)",
             caption = "Data obtained from the U.S. Census 5-year American Community Survey Samples for 2017-2021"
           )+
           scale_radius(range = c(2, 6)) +
           dark_theme_classic() +
           scale_color_viridis() + #use the Viridis palette
           guides(color = guide_legend(title = "Median Income"),
                  size = guide_legend(title = "Median Income")) +
           theme(
             axis.title = element_text(face = "bold", size = 10),
             plot.title = element_text(face = "bold",size = 15, margin = unit(c(1,1,1,1), "cm")),
             plot.subtitle = element_text(size = 10, margin = unit(c(-0.5,0.5,0.5,0.5), "cm")),
             plot.caption = element_text(face = "italic", hjust = -0.2),
             plot.title.position = "plot", #sets the title to the left
             legend.position = "bottom",
             legend.text = element_text(size = 8)
           ))

####
####Maps
####
#set the tmap mode to static
tmap_mode("plot")
tm_shape(census_spatial)+
  tm_polygons(col = "median_income",
              style = "quantile",
              title = "Median Income")
##edit layot
tm_shape(census_spatial)+
  tm_polygons(col = "median_income",
              style = "quantile",
              title = "Median Income")+
  tm_layout(frame = FALSE,
            legend.outside = TRUE)
# scale bar compass, ect
tm_shape(census_spatial)+
  tm_polygons(col = "median_income",
              style = "quantile",
              title = "Median Income")+
  tm_layout(frame = FALSE,
            legend.outside = TRUE)+
  tm_scale_bar(position = c("left", "bottom")) +
  tm_compass(position = c("right", "top")) +
  tm_credits("Map credit goes here", position = c("left", "bottom"))
##faceting
tm_shape(census_spatial, bbox = "Fort Collins") +#bbox sets extent to a predefined area
  tm_polygons(
    c("median_income", "median_age", "non_white_percent"),
    title = c("Median Income", "Median Age", "People of Color (%)"),
    style = "quantile",
    n = 5
  ) +
  tm_facets(ncol = 3) +
  tm_layout(frame = FALSE,
            legend.position = c("left", "bottom"),
            legend.width = 0.5)
### Colors and themes
tm_shape(census_spatial, bbox = "Fort Collins") +
  tm_borders(col = "lightgray")+
  tm_fill(
    col = "non_white_percent",
    title = "People of Color (%)",
    style = "quantile",
    n = 6,
    palette = "PuBu",
    legend.hist = TRUE #adds a histogram of the data to the map
  ) +
  tm_style("classic")+
  tm_layout(frame = FALSE,
            legend.outside = TRUE,
            legend.hist.width = 5)

map <- tm_shape(census_spatial, bbox = "Fort Collins") +
  tm_borders(col = "lightgray")+
  tm_fill(
    col = "non_white_percent",
    title = "People of Color (%)",
    style = "quantile",
    n = 6,
    palette = "PuBu",
    legend.hist = TRUE
  ) +
  tm_style("classic")+
  tm_layout(frame = FALSE,
            legend.outside = TRUE,
            legend.hist.width = 5)

tmap_save(map, filename = "data/census_map.png")

#flextable
library(flextable)
census_data %>% 
  arrange(-median_income) %>% 
  filter(median_income > 145000) %>% 
  select(NAME, White:Hispanic) %>% 
  # round values to 2 decimal places
  mutate(across(White:Hispanic, ~round(.x, digits = 2))) %>% 
  flextable()


