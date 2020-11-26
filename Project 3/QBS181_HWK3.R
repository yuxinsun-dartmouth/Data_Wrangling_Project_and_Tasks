library(tidyr)

table1
table2
table3
table4a
table4b

table4a%>%gather(`1999`,`2000`,key="year",value="cases")

table2
spread(table2,key=type,value=count)

table3
separate(table3,rate,into=c("cases","population"))

table5
unite(table5,new,century,year)

# rate for table2
table2 %>% 
  spread(key=type, value=count) %>% 
  mutate('rate' = cases/population *10000)

# rate for table4a + table4b
merge(gather(table4a, `1999`,`2000`, key='year', value='cases'),
      gather(table4b, `1999`,`2000`, key='year', value='population'),
      by=c("country", "year")) %>%
      mutate('rate' = cases/population *10000)

library(nycflights13)
flights_jan1<-filter(flights,month == 1, day == 1)
dplyr::select(flights,month,year,day)

dplyr::select(flights, year:day,ends_with("delay"))

flights%>%dplyr::select(year:day,ends_with("delay"),air_time,distance)%>%
  mutate(gain=arr_delay-dep_delay,speed=distance/air_time*60)
flights%>%count(year,month,day)%>%filter(n>1)

by_day <- group_by(nycflights13::flights,year,month,day)
dplyr::summarize(by_day,delay=mean(dep_delay,na.rm=TRUE))

by_dest <- group_by(nycflights13::flights,dest)
dplyr::summarize(by_dest,count=n(),delay=mean(arr_delay,na.rm=TRUE),distance=mean(distance,na.rm=TRUE))

flights%<>%mutate(flight_times=arr_time-dep_time)

flights %>% group_by(year, month, day) %>% 
  dplyr::summarize(mean_flight_times=mean(flight_times,na.rm=TRUE))

flights %<>% mutate(diff_in_dep_delay = dep_delay-(dep_time-sched_dep_time))

flights %>% group_by(year, month, day) %>% 
  dplyr::summarize(diff_in_dep_delay=max(diff_in_dep_delay,na.rm=TRUE))

flights %<>% mutate(is_delayed = (dep_time-sched_dep_time) > 0)

flights %>% dplyr::select(year:day, is_delayed, dep_delay) %>%
        filter((dep_delay>=20 & dep_delay<=30) | (dep_delay>=50 & dep_delay<=60)) %>%
        filter(is_delayed==F)









