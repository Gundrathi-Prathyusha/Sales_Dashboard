library(tidyverse)
library(lubridate)

# Load dataset
sales <- read.csv("data/samplesuperstore.csv")

# Convert Order Date to Date format
sales$Order.Date <- as.Date(sales$Order.Date,
                            format = "%m/%d/%Y")

# Create Month column
sales$Month <- floor_date(sales$Order.Date, "month")

# Monthly Sales
monthly_sales <- sales %>%
  group_by(Month) %>%
  summarise(TotalSales = sum(Sales))

print(monthly_sales)

# Line Chart
ggplot(monthly_sales,
       aes(x = Month,
           y = TotalSales)) +
  geom_line(linewidth = 1) +
  geom_point(size = 2) +
  labs(
    title = "Monthly Sales Trend",
    x = "Month",
    y = "Total Sales"
  ) +
  theme_minimal()