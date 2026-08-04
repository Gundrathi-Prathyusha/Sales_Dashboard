library(shiny)
library(tidyverse)
library(lubridate)

# Load dataset
sales <- read.csv("data/samplesuperstore.csv")

# Convert date
sales$Order.Date <- as.Date(sales$Order.Date, format = "%m/%d/%Y")
sales$Month <- floor_date(sales$Order.Date, "month")

# KPI Values
total_sales <- sum(sales$Sales)
total_profit <- sum(sales$Profit)
total_orders <- nrow(sales)

# Category Sales
category_sales <- sales %>%
  group_by(Category) %>%
  summarise(TotalSales = sum(Sales), .groups = "drop")

# Region Profit
region_profit <- sales %>%
  group_by(Region) %>%
  summarise(TotalProfit = sum(Profit), .groups = "drop")

# Monthly Sales
monthly_sales <- sales %>%
  group_by(Month) %>%
  summarise(TotalSales = sum(Sales), .groups = "drop")

ui <- fluidPage(
  
  titlePanel("Sales Dashboard"),
  
  fluidRow(
    
    column(
      4,
      wellPanel(
        h3("Total Sales"),
        h2(round(total_sales,2))
      )
    ),
    
    column(
      4,
      wellPanel(
        h3("Total Profit"),
        h2(round(total_profit,2))
      )
    ),
    
    column(
      4,
      wellPanel(
        h3("Total Orders"),
        h2(total_orders)
      )
    )
    
  ),
  
  hr(),
  
  h3("Sales by Category"),
  plotOutput("categoryPlot", height = "350px"),
  
  hr(),
  
  h3("Profit by Region"),
  plotOutput("regionPlot", height = "350px"),
  
  hr(),
  
  h3("Monthly Sales Trend"),
  plotOutput("trendPlot", height = "350px")
)

server <- function(input, output) {
  
  output$categoryPlot <- renderPlot({
    
    ggplot(category_sales,
           aes(Category, TotalSales, fill = Category)) +
      geom_col() +
      theme_minimal()
    
  })
  
  output$regionPlot <- renderPlot({
    
    ggplot(region_profit,
           aes(Region, TotalProfit, fill = Region)) +
      geom_col() +
      theme_minimal()
    
  })
  
  output$trendPlot <- renderPlot({
    
    ggplot(monthly_sales,
           aes(Month, TotalSales)) +
      geom_line(linewidth = 1) +
      geom_point(size = 2) +
      theme_minimal()
    
  })
  
}

shinyApp(ui, server)