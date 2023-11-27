library(tidyverse)

lifetime_earn <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-02-09/lifetime_earn.csv')
student_debt <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-02-09/student_debt.csv')
retirement <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-02-09/retirement.csv')
home_owner <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-02-09/home_owner.csv')
race_wealth <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-02-09/race_wealth.csv')
income_time <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-02-09/income_time.csv')
income_limits <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-02-09/income_limits.csv')
income_aggregate <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-02-09/income_aggregate.csv')
income_distribution <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-02-09/income_distribution.csv')
income_mean <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-02-09/income_mean.csv')

view(lifetime_earn)

view(student_debt)

view(retirement)

view(home_owner)

view(race_wealth)

view(income_time)

view(income_limits)

view(income_aggregate)

view(income_distribution)

view(income_mean)

# Lets view the correlation between student debt and retirement

debt_retire <- merge(student_debt, retirement, by = c("year", "race"))

view(debt_retire)

write.csv(debt_retire, file = "debt_retire.csv", row.names = FALSE)

# Filter and find the unique values to see what we ar working with in he data in race

unique_race <- unique(income_distribution$race)
view(unique_race)

wbha_race <- c("White Alone", "Black Alone", "Hispanic (Any Race)", "Asian Alone")

income_distribution_wbha <- income_distribution %>% 
  filter(race %in% wbha_race )
view(income_distribution_wbha)

write.csv(income_distribution_wbha, file = "income_distribution_wbha.csv", row.names = FALSE)

rm(income_distribution_wbha)
rm(wbha_race)

write.csv(home_owner, file = "home_owner.csv", row.names = FALSE)

