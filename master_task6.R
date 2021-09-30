#Task 6 - Applied Empirical Economics I
#Qinglin Ouyang
#qinglin.ouyang@sbs.su.se
#Sep 29, 2021

library(haven)
library(knitr)
library(caret)
library(dplyr)
library(tidyverse)
library(stargazer)
library(ggplot2)
library(miceadds)
library(psych)
library(sjlabelled)
library(ggrepel)
library(factoextra)
library(ggforce)
library(deldir)
library(countrycode)
library(leaps) # for best subset selection
library(glmnet) # for regularized linear regression
rm(list = ls())

rootdir <- "/Users/qiou3954/Library/Mobile Documents/com~apple~CloudDocs/Year 2/Applied Empirical Economics I/Qinglin_Ouyang/Task_6"
setwd(rootdir)
set.seed(0929) #set seed for replication
# Prepare for building
dir.create("./Analysis/Input")
dir.create("./Analysis/Output")
file.copy("./Raw/growthdata02_11.csv", "./Analysis/Input/growth02_11.csv")
file.copy("./Raw/growthdata92_02.csv", "./Analysis/Input/growth92_02.csv")

# Load datasets
input92_02 <- read_csv('./Analysis/Input/growth92_02.csv') %>% 
  select(-1) #remove first column
input02_11 <- read_csv('./Analysis/Input/growth02_11.csv') %>% 
  select(-1)

# Load functions
source('./Analysis/Code/Regression_functions.R') 

# Exercises
source('./Analysis/Code/Exercise1.R')
source('./Analysis/Code/Exercise2.R')
source('./Analysis/Code/Exercise3.R')
