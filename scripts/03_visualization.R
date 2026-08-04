library(tidyverse)

# Load dataset
sales <- read.csv("data/samplesuperstore.csv")

# Profit by Region
region_profit <- sales %>%
  group_by(Region) %>%
  summarise(TotalProfit = sum(Profit))

print(region_profit)

ggplot(region_profit,
       aes(x = Region,
           y = TotalProfit,
           fill = Region)) +
  geom_col() +
  labs(
    title = "Profit by Region",
    x = "Region",
    y = "Total Profit"
  ) +
  theme_minimal()

