#### Preamble ####
# Purpose: Prepare and clean the survey data downloaded from:
# https://www.voterstudygroup.org/publication/nationscape-data-set
# Author: Zikun Lei
# Data: 22 December 2020
# Contact: zikun.lei@mail.utoronto.ca
# License: MIT
# Pre-requisites: 
# - Need to have downloaded the data from X and save the folder that you're 
# interested in to inputs/data 
# - Don't forget to gitignore it!


#### Workspace setup ####
library(haven)
library(tidyverse)
setwd("D:/ps 3")
# Read in the raw data (You might need to change this if you use a different dataset)
raw_data <- read_dta("ns20200625/ns20200625.dta")
# Add the labels
raw_data <- labelled::to_factor(raw_data)
# Just keep some variables
reduced_data <- 
  raw_data %>% 
  select(household_gun_owner,
         employment, gender,
         census_region,
         race_ethnicity,
         age)
colnames(reduced_data)[3]<-"sex"


#### What else???? ####
# Maybe make some age-groups?
# Maybe check the values?
# Is vote a binary? If not, what are you going to do?
levels(reduced_data$household_gun_owner)[match("I don't, but a member of my household owns a gun",levels(reduced_data$household_gun_owner))] <- "Yes, I personally own a gun"
reduced_data <- 
  reduced_data %>%
  filter(household_gun_owner != "Not sure") %>%
  filter(household_gun_owner != "NA")


reduced_data<-
  reduced_data %>%
  mutate(household_gun_owner = 
           ifelse(household_gun_owner=="Yes, I personally own a gun", 1, 0))


levels(reduced_data$sex)[match("Female",levels(reduced_data$sex))] <- "female"
levels(reduced_data$sex)[match("Male",levels(reduced_data$sex))] <- "male"
levels(reduced_data$employment)[match("Full-time employed",levels(reduced_data$employment))] <- "employed"
levels(reduced_data$employment)[match("Part-time employed",levels(reduced_data$employment))] <- "employed"
levels(reduced_data$employment)[match("Self-employed",levels(reduced_data$employment))] <- "employed"
levels(reduced_data$employment)[match("Student",levels(reduced_data$employment))] <- "not in labor force"
levels(reduced_data$employment)[match("Retired",levels(reduced_data$employment))] <- "not in labor force"
levels(reduced_data$employment)[match("Unemployed or temporarily on layoff",levels(reduced_data$employment))] <- "unemployed"
levels(reduced_data$employment)[match("Homemaker",levels(reduced_data$employment))] <- "unemployed"
levels(reduced_data$employment)[match("Other:",levels(reduced_data$employment))] <- "n/a"
levels(reduced_data$employment)[match("Permanently disabled",levels(reduced_data$employment))] <- "unemployed"

levels(reduced_data$race_ethnicity)[match("Asian (Asian Indian)",levels(reduced_data$race_ethnicity))] <- "Asian or pacific islander"
levels(reduced_data$race_ethnicity)[match("Asian (Japanese)",levels(reduced_data$race_ethnicity))] <- "Asian or pacific islander"
levels(reduced_data$race_ethnicity)[match("Asian (Other)",levels(reduced_data$race_ethnicity))] <- "Asian or pacific islander"
levels(reduced_data$race_ethnicity)[match("Pacific Islander (Samoan)",levels(reduced_data$race_ethnicity))] <- "Asian or pacific islander"
levels(reduced_data$race_ethnicity)[match("Asian (Chinese)",levels(reduced_data$race_ethnicity))] <- "Asian or pacific islander"
levels(reduced_data$race_ethnicity)[match("Asian (Korean)",levels(reduced_data$race_ethnicity))] <- "Asian or pacific islander"
levels(reduced_data$race_ethnicity)[match("Pacific Islander (Native Hawaiian)",levels(reduced_data$race_ethnicity))] <- "Asian or pacific islander"
levels(reduced_data$race_ethnicity)[match("Pacific Islander (Other)",levels(reduced_data$race_ethnicity))] <- "Asian or pacific islander"
levels(reduced_data$race_ethnicity)[match("Asian (Filipino)",levels(reduced_data$race_ethnicity))] <- "Asian or pacific islander"
levels(reduced_data$race_ethnicity)[match("Asian (Vietnamese)",levels(reduced_data$race_ethnicity))] <- "Asian or pacific islander"
levels(reduced_data$race_ethnicity)[match("Pacific Islander (Guamanian)",levels(reduced_data$race_ethnicity))] <- "Asian or pacific islander"
levels(reduced_data$race_ethnicity)[match("Some other race",levels(reduced_data$race_ethnicity))] <- "Some other race or multiraces"





# Saving the survey/sample data as a csv file in my
# working directory
write_csv(reduced_data, "survey_data_final.csv")

