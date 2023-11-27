library(tidyverse)

patient_risk_profiles <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-10-24/patient_risk_profiles.csv')

view(patient_risk_profiles)

head(patient_risk_profiles)

summary(patient_risk_profiles)

str(patient_risk_profiles)

is.na(patient_risk_profiles)

unique(patient_risk_profiles)

# Replace spaces with _ 
original_column_names <- colnames(patient_risk_profiles)
print("Original Column Names:")
print(original_column_names)

patient_profile <- gsub(" ", "_", original_column_names)

colnames(patient_risk_profiles) <-patient_profile

view(patient_risk_profiles)

# List Column Name
colnames(patient_risk_profiles)

# Grouping Old People Data 

old <- c("age_group:__10_-__14", 
         "age_group:___0_-___4",
         "age_group:___5_-___9",
         "age_group:__15_-__19",
         "age_group:__40_-__44",
         "age_group:__45_-__49",
         "age_group:__25_-__29",
         "age_group:__35_-__39",
         "age_group:__30_-__34",
         "age_group:__20_-__24")

old_patients <- patient_risk_profiles %>%
  select(-all_of(old))

view(old_patients)

# Calculate the average for each column
column_averages <- old_patients %>%
  summarise(across(everything(), mean, na.rm = TRUE))

rm(column_averages)

# Calculate the average for each column
column_averages <- colMeans(old_patients)

# Create a data frame with column names and averages
average_data <- data.frame(
  Column_Name = names(column_averages),
  Average = column_averages
)

# Sort the data frame by Average in descending order
sorted_data <- average_data[order(-average_data$Average), ]

view(sorted_data)


# Grouping Data

middle <- c("age_group:__10_-__14", 
         "age_group:___0_-___4",
         "age_group:___5_-___9",
         "age_group:__15_-__19",
         "age_group:__65_-__69",
         "age_group:__55_-__59",
         "age_group:__85_-__89",
         "age_group:__75_-__79",
         "age_group:__70_-__74",
         "age_group:__50_-__54",
         "age_group:__60_-__64",
         "age_group:__80_-__84",
         "age_group:__90_-__94")

middle_patients <- patient_risk_profiles %>%
  select(-all_of(middle))

# Calculate the average for each column
column_averages <- colMeans(middle_patients)

# Create a data frame with column names and averages
average_data <- data.frame(
  Column_Name = names(column_averages),
  Average = column_averages
)

# Sort the data frame by Average in descending order
middle_sorted_data <- average_data[order(-average_data$Average), ]

view(middle_sorted_data)

# Calculate frequency for multiple columns at once
frequency_data <- patient_risk_profiles %>%
  summarise(across(everything(), ~sum(. == 1)))

# Rename the columns for clarity
colnames(frequency_data) <- paste("Frequency_", colnames(frequency_data))

view(frequency_data)

# Transpose Data
transpose_data <- t(frequency_data)
transposed_data <- as.data.frame(transpose_data)

view(transposed_data)

correlation_matrix <- cor(patient_risk_profiles)

view(correlation_matrix)

# Convert the correlation matrix to a data frame
correlation_df <- as.data.frame(correlation_matrix)

# Create a plot of the correlation matrix using ggplot2
correlation_df %>%
  rownames_to_column(var = "var1") %>%
  pivot_longer(-var1, names_to = "var2", values_to = "correlation") %>%
  ggplot(aes(x = var1, y = var2, fill = correlation)) +
  geom_tile() +
  scale_fill_gradient(low = "blue", high = "red") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  labs(title = "Correlation Matrix Heatmap")

high_correlations <- which(correlation_matrix > 0.7 & correlation_matrix < 1, arr.ind = TRUE)

high_correlation_pairs <- data.frame(
  Variable1 = rownames(correlation_matrix)[high_correlations[, 1]],
  Variable2 = colnames(correlation_matrix)[high_correlations[, 2]],
  Correlation = correlation_matrix[high_correlations]
)

high_correlation_pairs <- high_correlation_pairs[high_correlation_pairs$Correlation > 0.7, ]
print(high_correlation_pairs)

