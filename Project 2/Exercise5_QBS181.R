#install.packages("stringr")               # Install stringr package
library("RODBC")
library(dplyr)
library(stringi)
library(stringr)
myconn<-odbcConnect("dartmouthqbs181","yusun","yusun@qbs181")

# Q1. In the Flowsheet table, extract the cc/kg in disp_name and convert it to CC-Kg
data <- sqlQuery(myconn, 'select * from Flowsheets')

data$DISP_NAME <- str_replace_all(data$DISP_NAME, "cc/kg", "CC-Kg")

data[grepl('CC-Kg',data$DISP_NAME), "DISP_NAME"]


## Q2.	In the flowsheets table, find any alphanumeric character and replace them with spaces
data <- sqlQuery(myconn, 'select * from Flowsheets')

data$DISP_NAME <- gsub('[0-9]|[A-z]', ' ', data$DISP_NAME)

data$DISP_NAME

# Q3.	In the provider table, split and create a new column which  reflects first and last names. Extract all the providers whose last name starts with "Wa"
data <- sqlQuery(myconn, 'select * from Provider')

l <- str_split(data$NEW_PROV_NAME, ',')

data[c('LastName', 'FirstName')] <- matrix(unlist(l), nrow=length(l), byrow=T)

data[grepl('^Wa',data$LastName), ]