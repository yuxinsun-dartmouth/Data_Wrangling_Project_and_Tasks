library("RODBC")
library(dplyr)
myconn<-odbcConnect("dartmouthqbs181","yusun","yusun@qbs181")

# Q1. make name tolower
Dx <- sqlQuery(myconn, 'select * from dbo.[Dx]')

Dx$DX_NAME <- tolower(Dx$DX_NAME)

print(Dx$DX_NAME)

# Q2. remove all whitespace and comma
library(stringi)
Dx$DX_NAME <- str_replace_all(Dx$DX_NAME, " ", "")
Dx$DX_NAME <- str_replace_all(Dx$DX_NAME, ",", "")

print(Dx$DX_NAME)

# Q3. merge Inpatient and Outpatient tables based on NEW_PATIENT_DHMC_MRN by removing any hyphens. 

Inpatient_Outpatient <- sqlQuery(myconn,"select * from Outpatient A
                                 inner join Inpatient B
                                 on A.NEW_PATIENT_DHMC_MRN=B.NEW_PATIENT_DHMC_MRN
                                 ")

Inpatient_Outpatient$NEW_PATIENT_DHMC_MRN <- str_replace_all(Inpatient_Outpatient$NEW_PATIENT_DHMC_MRN,
                                                             "-", "")

Inpatient_Outpatient$NEW_PATIENT_DHMC_MRN.1 <- str_replace_all(Inpatient_Outpatient$NEW_PATIENT_DHMC_MRN.1,
                                                             "-", "")

print(Inpatient_Outpatient$NEW_PATIENT_DHMC_MRN)

# Q4. Do you see the same distinct NEW_PATIENT_DHMC_MRN when merged on NEW_PAT_ID
Inpatient_Outpatient.NEW_PATIENT_DHMC_MRN <- sqlQuery(myconn,"select * from Outpatient A
                                 inner join Inpatient B
                                 on A.NEW_PATIENT_DHMC_MRN=B.NEW_PATIENT_DHMC_MRN
                                 ")
Inpatient_Outpatient.NEW_PAT_ID <- sqlQuery(myconn,"select * from Outpatient A
                                 inner join Inpatient B
                                 on A.NEW_PAT_ID=B.NEW_PAT_ID
                                 ")
setdiff(Inpatient_Outpatient.NEW_PATIENT_DHMC_MRN$NEW_PATIENT_DHMC_MRN,Inpatient_Outpatient.NEW_PAT_ID$NEW_PATIENT_DHMC_MRN)
