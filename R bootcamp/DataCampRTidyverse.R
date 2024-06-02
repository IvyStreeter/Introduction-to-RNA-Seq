# DataCamp R Tidyverse (https://www.datacamp.com/courses/introduction-to-the-tidyverse)

# Download libraries
install.packages('gapminder')
install.packages('dplyr')

# Load libraries
library(gapminder) # By Jenny Bryan
library(dplyr) # By Hadley Wickham

# view the gapminder dataset 
gapminder

# There are 1704 rows and 6 columns present in the dataset

# Filter verb grabs rows
gapminder %>% # Pipes are feed results into the next step 
  filter(year == 2007) # == is a logical equal to compare values

gapminder %>% 
  filter(country == "United States") # Quotes are necessary for strings

# You can filter upon 2 variables with 2 arguments
gapminder %>% 
  filter(year == 2007, country == "United States")

# Arrange verb sorts observation ascending or descending based on variable
gapminder %>%
  arrange(gdpPercap) # Default is ascending

gapminder %>%
  arrange(desc(gdpPercap)) 

# You can use filter and arrange
gapminder %>%
  filter(year == 2007) %>%
  arrange(desc(gdpPercap))

# Mutate verb to add new variables
gapminder %>%
  mutate(pop = pop/1000000) # replace pop with a smaller variable

# Add a new variable
gapminder %>%
  mutate(gdp = gdpPercap * pop)

# Combining verbs
gapminder %>%
  mutate(gdp = gdpPercap * pop) %>%
  filter(year == 2007) %>%
  arrange(desc(gdp))

# Visualizing with ggplot2

# Subset the dataset 
gapminder_2007 <- gapminder %>%
  filter(year == 2007)

gapminder_2007

#install.packages("ggplot2")
library(ggplot2)

# Wealth vs lifeExp
# 3 parts to graph:
# 1st is the data
# 2nd is the mapping of variables to the aesthetic to graph
# 3rd is specifying the graph by adding a layer
#   +, geom = geometric graph, point = scatterpoint
ggplot(gapminder_2007, aes(x = gdpPercap, y = lifeExp)) +
  geom_point()

# Log scales
ggplot(gapminder_2007, aes(x = gdpPercap, y = lifeExp)) +
  geom_point() +
  scale_x_log10()

# Adding color
ggplot(gapminder_2007, aes(x = gdpPercap, y = lifeExp, color = continent)) +
  geom_point() +
  scale_x_log10()

# Adding size
ggplot(gapminder_2007, aes(x = gdpPercap, y = lifeExp, color = continent, 
                           size = pop)) +
  geom_point() +
  scale_x_log10()

# Faceting, diving plots into subplots
ggplot(gapminder_2007, aes(x = gdpPercap, y = lifeExp)) +
  geom_point() +
  scale_x_log10() + 
  facet_wrap(~ continent)

ggplot(gapminder, aes(x = gdpPercap, y = lifeExp, color = continent, size = pop)) +
  geom_point() +
  scale_x_log10() + 
  facet_wrap(~ year)

# The summarize verb, turns many rows into 1
gapminder %>%
  summarize(meanLifeExp = mean(lifeExp))

# Of a particular year
gapminder %>%
  filter(year == 2007) %>%
  summarize(meanLifeExp = mean(lifeExp))

# Multiple columns
gapminder %>%
  filter(year == 2007) %>%
  summarize(meanLifeExp = mean(lifeExp), 
            totalPop = sum(pop))

# Mean, sum, median, min, max are other useful functions

# The group_by verb to summarize in groups
gapminder %>%
  group_by(year) %>%
  summarize(meanLifeExp = mean(lifeExp),
            totalPop = sum(pop))

gapminder %>%
  filter(year == 2007) %>%
  group_by(continent) %>%
  summarize(meanLifeExp = mean(lifeExp),
            totalPop = sum(pop))

gapminder %>%
  group_by(year, continent) %>%
  summarize(meanLifeExp = mean(lifeExp),
            totalPop = sum(pop))

gapminder %>%
  group_by(year) %>%
  summarize(medianLifeExp = median(lifeExp),
            maxGdpPercap = max(gdpPercap))

gapminder %>%
  filter(year == 1957) %>%
  group_by(continent) %>%
  summarize(medianLifeExp = median(lifeExp),
            maxGdpPercap = max(gdpPercap))

# Visualizng summarized data
by_year <- gapminder %>%
  group_by(year) %>%
  summarize(totalPop = sum(pop),
            meanLifeExp = mean(lifeExp))

by_year

ggplot(by_year, aes(x = year, y = totalPop)) + 
  geom_point()
 




























