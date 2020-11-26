library("RODBC")
library(dplyr)
library(lubridate)
myconn<-odbcConnect("dartmouthqbs181","yusun","yusun@qbs181")

data <- read.csv("IC_BP_v2.csv")

data.demographics <- sqlQuery(myconn, 'select * from Demographics')

data <- merge(data, data.demographics, by.x = "ID", by.y = "contactid")

write.csv(data, "IC_BP_v2_merged.csv")


data.conditions <- sqlQuery(myconn, 'select * from Conditions')

data.text <- sqlQuery(myconn, "select * from Text")

data.demographics.conditions <- merge(data.demographics, data.conditions, by.x = "contactid", by.y = "tri_patientid", how='left')

data.combined <- merge(data.demographics.conditions, data.text, by.x = "contactid", by.y = "tri_contactId", how='left')

data.lastsent.text <- data.combined %>% group_by(contactid) %>% slice(which.max(TextSentDate))

write.csv(data.conditions, "conditions.csv")

write.csv(data.text, "text.csv")

write.csv(data.demographics, "demographics.csv")

write.csv(data.lastsent.text, "data_combined.csv")



z <- 1472562988
# ways to convert this
as.POSIXct(z, origin = "1960-01-01")                # local
as.POSIXct(z, origin = "1960-01-01", tz = "GMT")    # in UTC

## SPSS dates (R-help 2006-02-16)
z <- c(10485849600, 10477641600, 10561104000, 10562745600)
as.Date(as.POSIXct(z, origin = "1582-10-14", tz = "GMT"))






