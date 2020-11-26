library(Hmisc)

data <- sasxport.get("DIQ_I.xpt")

head(data)

describe(data$diq172)


library(rvest)
 
scraping_website <-  read_html("https://geiselmed.dartmouth.edu/qbs/2019-cohort/")
student_img = scraping_website %>% html_nodes("body") %>% html_nodes("img") %>% html_attr('src')
 
student_img[grep('(p|P)ortrait', sdutent_imag)]