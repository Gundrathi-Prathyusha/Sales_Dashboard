# Load library
library(tidyverse)

# Read the dataset
sales <- read.csv("data/samplesuperstore.csv")

# Display first 6 rows
head(sales)

# Display column names
colnames(sales)

# Display structure
str(sales)

# Display summary
summary(sales)