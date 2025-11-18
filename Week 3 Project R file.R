# Load Required Packages
library(tidyverse)
library(ggplot2)
library(dplyr)
library(readr)

file_path <- "C:\\Users\\Prakhar Khandelwal\\final_dataset.csv"
df <- read.csv(file_path)

# VISUALIZATIONS (EDA)

# Avg WQI by Water Body
avg_wqi <- df %>%
  group_by(type_water_body) %>%
  summarise(avg_wqi = mean(wqi))

ggplot(avg_wqi, aes(x = "", y = avg_wqi, fill = type_water_body)) +
  geom_col(width = 1) +
  coord_polar("y") +
  labs(title = "Average WQI by Water Body") +
  theme_void()

# Distribution of WQI Categories 
ggplot(df, aes(x = wqi_category, fill = wqi_category)) +
  geom_bar() +
  ggtitle("Distribution of WQI Categories") +
  xlab("WQI Category") +
  ylab("Count")


# Top 10 Water Sources (Worst to Best)
top10 <- df %>%
  arrange(wqi) %>%
  slice(1:10)

ggplot(top10, aes(x = reorder(monitoring_location, wqi), y = wqi, fill = wqi)) +
  geom_col() +
  coord_flip() +
  labs(title = "Top 10 Worst Water Sources by WQI", x = "Monitoring Location", y = "WQI")

# Heatmap of Correlations
library(reshape2)

corr_data <- df %>%
  select(avg_temperature,avg_dissolved,avg_ph,avg_conductivity,avg_bod,avg_nitraten,avg_fecal_coliform,wqi)

heatmap_data <- cor(corr_data, use = "complete.obs")

melted_corr <- melt(heatmap_data)

ggplot(melted_corr, aes(Var1, Var2, fill = value)) +
  geom_tile() +
  geom_text(aes(label = round(value, 2)), size = 3) +
  scale_fill_gradient2(low = "blue", high = "red", mid = "white", midpoint = 0) +
  labs(title = "Correlation Heatmap", x = "", y = "") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

