

library(tidyverse)
dat <- read_csv("https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-counties.csv")


# Question 1. The first date reported in the data is January 21, 2020. Find the latest available date reported in these data.

dat %>%
  arrange(desc(date))


# Question 2. Find the cumulative number of deaths reported in the U.S. to date.

dat %>%
  summarize(total_deaths = sum(deaths))


# Question 3. Find the cumulative number of cases reported in the U.S. to date.

dat %>%
  summarize(total_cases = sum(cases))


# Question 4. Which state reported the most total cases on the most recent date available?

dat %>%
  group_by(state,date) %>% 
  summarize(total_cases = sum(cases)) %>% 
  filter(date =="2020-04-27") %>% 
  arrange(desc(total_cases))


# Question 5. Which county(ies) in the U.S. has/have the fewest cumulative confirmed cases to date?

dat %>%
  group_by(county) %>%
  summarize(total_cases = sum(cases)) %>%
  arrange(total_cases)


# Question 6. Which county in Pennsylvania has the most total cases reported, to date? How many cases have they identified?

dat %>%
  group_by(county,state) %>%
  summarize(total_cases = sum(cases)) %>%
  filter(state =="Pennsylvania") %>% 
  arrange(desc(total_cases))


# Question 7. Make a plot of the number of cases over time in Westmoreland County-where St. Vincent College is located.

dat %>%
  group_by(county, state, date) %>%
  summarize(total_cases = sum(cases)) %>%
  filter(county == "Westmoreland", state == "Pennsylvania") %>%
  ggplot(aes(x = date, y = total_cases, col = county)) +
  geom_line() +
  geom_point() +
  scale_y_log10() +
  labs(y = "Total Cases (log scale)",
       x = "Date",
       title = "Total COVID-19 Cases in Westmoreland County, PA") +
  guides(color = FALSE) +
  theme(plot.title = element_text(hjust = 0.5)) # centers title
