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
 
# Start y-axis at zero
ggplot(by_year, aes(x = year, y = totalPop)) + 
  geom_point() + 
  expand_limits(y = 0)

# Summarize by year and continent
by_year_continent <- gapminder %>%
  group_by(year, continent) %>%
  summarize(totalPop = sum(pop),
            medianLifeExp= median(lifeExp))

by_year_continent

# Separate by color
ggplot(by_year_continent, aes(x = year, y = totalPop,
                              color = continent)) + 
  geom_point() + 
  expand_limits(y = 0)

# Plot the change in medianGdpPercap in each continent over time
ggplot(by_year_continent, aes(x = year, y = medianGdpPercap,
                              color = continent)) + 
  geom_point() + 
  expand_limits(y = 0)

# Summarize the median GDP and median life expectancy per continent in 2007
by_continent_2007 <- gapminder %>%
  filter(year == 2007) %>%
  group_by(continent) %>%
  summarize(medianLifeExp = median(lifeExp), 
            medianGdpPercap = median(gdpPercap))

# Use a scatter plot to compare the median GDP and median life expectancy
ggplot(by_continent_2007, aes(x = medianGdpPercap, y = medianLifeExp,
                              color = continent)) + 
  geom_point() 


# Scatter plots are useful to compare 2 variables
# Line plots are useful for change over time
# Barplots comparing statistics between categorical variables
# Histograms describe distribution
# Box plot, describe distribution over categorical variables

# Summarize the median gdpPercap by year, then save it as by_year
by_year <- gapminder %>%
  group_by(year) %>%
  summarize(medianGdpPercap = median(gdpPercap))

# Create a line plot showing the change in medianGdpPercap over time
ggplot(by_year, aes(x = year, y = medianGdpPercap)) +
  geom_line() +
  expand_limits(y = 0)

# Summarize the median gdpPercap by year & continent, save as by_year_continent
by_year_continent <- gapminder %>%
  group_by(year, continent) %>%
  summarize(medianGdpPercap = median(gdpPercap))

# Create a line plot showing the change in medianGdpPercap by continent over time
ggplot(by_year_continent, aes(x = year, y = medianGdpPercap, color = continent)) +
  geom_line() +
  expand_limits(y = 0)


# Barplots
by_continent <- gapminder %>%
  filter(year == 2007) %>%
  group_by(continent) %>%
  summarize(meanLifeExp = mean(lifeExp))

by_continent

ggplot(by_continent, aes(x = continent, y = meanLifeExp)) +
  geom_col()

# Create a bar plot showing medianGdp by continent
ggplot(by_continent, aes(x = continent, y = medianGdpPercap)) +
  geom_col()

# Summarize the median gdpPercap by continent in 1952
by_continent <- gapminder %>%
  filter(year == 1952) %>%
  group_by(continent) %>%
  summarize(medianGdpPercap = median(gdpPercap))

# Create a bar plot showing medianGdp by continent
ggplot(by_continent, aes(x = continent, y = medianGdpPercap)) +
  geom_col()

# Filter for observations in the Oceania continent in 1952
oceania_1952 <- gapminder %>%
  filter(continent == "Oceania", year == 1952)


# Create a bar plot of gdpPercap by country
ggplot(oceania_1952, aes(x = country, y = gdpPercap)) +
  geom_col()

# Histograms
gapminder_2007 <- gapminder %>%
  filter(year == 2007)

ggplot(gapminder_2007, aes(x = lifeExp)) +
  geom_histogram()

# Set bin width to change resolution/length of years per bin
# Helps with understanding general trends

# you can change the length of each bin
ggplot(gapminder_2007, aes(x = lifeExp)) +
  geom_histogram(binwidth = 5)

# you can change the number of bins
ggplot(gapminder_2007, aes(x = lifeExp)) +
  geom_histogram(bins = 5)

# Boxplots
ggplot(gapminder_2007, aes(x = continent, y = lifeExp)) +
  geom_boxplot()

ggplot(gapminder_2007, aes(x = continent, y = gdpPercap)) +
  geom_boxplot() +
  scale_y_log10() +
  ggtitle("Comparing GDP per capita across continents")



