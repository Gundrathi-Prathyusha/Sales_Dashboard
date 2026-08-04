library(tidyverse)

# Load the dataset
sales <- read.csv("data/samplesuperstore.csv")

# Business Summary
total_sales <- sum(sales$Sales)
total_profit <- sum(sales$Profit)
total_orders <- nrow(sales)
average_sales <- mean(sales$Sales)

cat("Total Sales :", total_sales, "\n")
cat("Total Profit :", total_profit, "\n")
cat("Total Orders :", total_orders, "\n")
cat("Average Sales :", average_sales, "\n")

# Sales by Category
category_sales <- sales %>%
  group_by(Category) %>%
  summarise(TotalSales = sum(Sales))

print(category_sales)

# Bar Chart
ggplot(category_sales,
       aes(x = Category,
           y = TotalSales,
           fill = Category)) +
  geom_col() +
  geom_text(aes(label = round(TotalSales, 0)),
            vjust = -0.3,
            size = 4) +
  labs(
    title = "Sales by Category",
    x = "Category",
    y = "Total Sales"
  ) +
  theme_minimal()
