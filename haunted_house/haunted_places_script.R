library(tidytuesdayR)

install.packages("tidyverse")

library(tidyverse)

haunted_places <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-10-10/haunted_places.csv')

View(haunted_places)

glimpse(haunted_places)

?filter

michigan_hp <- filter(haunted_places, state == "Michigan")
view(michigan_hp)

michigan_hp <- michigan_hp %>% 
  group_by(city)
view(michigan_hp)

michigan_hp %>% 
  count(city, sort = TRUE) %>% 
  head(michigan_hp,n=5)

# Top 5 states that is hauted

# Finding top 5 States
topst <- haunted_places %>% 
  group_by(state) %>% 
  count(state, sort = TRUE) %>% 
  head(topst, n=5)

view(topst)

# Filtering for top 5 state and creating separte variable
st_data <- filter(haunted_places, state == "California" |
                    state == "Texas" |
                    state == "Pennsylvania" |
                    state == "Michigan" |
                    state == "Ohio")
view(st_data) 


# Finding top 5 cities in each state

top_cty <- st_data %>% 
  group_by(state) %>% 
  arrange(city, .by_group = TRUE) %>% 
  count(city, sort = TRUE) %>% 
  arrange(desc(n)) %>% 
  group_by(state) %>%
  slice(1:5)

view(top_cty)

#Filtering for top 5 city from top 5 state and creating separate variable

cty_data <- filter(haunted_places, city == "Los Angeles" |
                    city == "San Diego" |
                    city == "Riverside" |
                    city == "San Francisco" |
                    city == "Hollywood" |
                    city == "Detroit" |
                    city == "Grand Rapids" |
                    city == "Mackinac Island" |
                    city == "Dearborn" |
                    city == "Marquette" |
                    city == "Cincinnati" |
                    city == "Columbus" |
                    city == "Toledo" |
                    city == "Dayton" |
                    city == "Cleveland" |
                    city == "Pittsburgh" |
                    city == "Philadelphia" |
                    city == "Gettysburg" |
                    city == "Johnstown" |
                    city == "Allentown" |
                    city == "San Antonio" |
                    city == "El Paso" |
                    city == "Houston" |
                    city == "Laredo" |
                    city == "Austin")
view(cty_data)

clean_cty_data <- cty_data %>% 
  select(city,
         description,
         location,
         state,
         state_abbrev)

view(clean_cty_data)

clean_st_data <- st_data %>% 
  select(city,
         description,
         location,
         state,
         state_abbrev)

view(clean_st_data)

# Data Visualization of top 5 states using ggplot2

ggplot(clean_cty_data, aes( x = city,
                     color = state)) + 
  geom_bar() +
  ggtitle ("Number of haunted places in top 5 cities from the top 5 states") +
  xlab("cities") +
  ylab("Total count") +
  labs(fill = "state")

# Data Visualization of top 5 states using ggplot2

ggplot(clean_st_data, aes(x = state)+
  geom_bar()+
  ggtitle("Total Count of Top 5 states with haunted places") +
  labs(x= "State",
       y= "Total Count")
  
  
#Searching amount of schools

school_5 <- filter(clean_cty_data, grepl('University|School|school|college|College|university',
                                         location))

view(school_5)

# Searching for Hospital

hospital_5 <- filter(clean_cty_data, grepl('Hospital|hospital', 
                                           location))

view(hospital_5)

hotel_5 <- filter(clean_cty_data, grepl('hotel|Hotel|Inn|inn', 
                                        location))

view(hotel_5)

# Which state has the most haunted schools?
school_5 %>%
  group_by(state) %>% 
  count(state, sort = TRUE) %>% 
  head(school_5, n=5)

## Texas has the most at 45 -> cali 36 -> Pennsylvania 30 -> Ohio 21 -> Michigan 15



