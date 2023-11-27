library(tidyverse)

horror_articles <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-10-31/horror_articles.csv')

view(horror_articles)

#Which Author produces True stories

# Look at column of ratings
unique_rating <- unique(horror_articles$rating)

view(unique_rating)

#filtering for true articles

# Define the values to filter for
true <- c("true", "legend", "partly true", "was true; now outdated
")

# Filter the data frame for rows where the "column_name" matches the specified values
true_articles <- horror_articles %>%
  filter(rating %in% true)

# View the filtered data
View(true_articles)

### Just by looking at oberservations we see that from the dataset,there is half of the data missing

# list of authors that write true articles

unique_true_authors <- unique(true_articles$author)

view(unique_true_authors)

# Fruquency of author that writes true articles

freq_true_authors <- table(true_articles$author)

view(freq_true_authors)

### here we see that the author that creates the most true articles is Barara Mikkelson

ggplot(true_articles, aes( x = author))+
  geom_bar(color = "black",
           fill="lightblue")+
  labs(x = "Author",
       y = "Frequency",
       title = "Frequency of Author with True Horror Articles")

