#install packages
install.packages('tidyverse')
install.packages("janitor") 
install.packages("lubridate")
install.packages("devtools")

install.packages('https://cran.r-project.org/src/contrib/Archive/hrbrthemes/hrbrthemes_0.1.0.tar.gz', type='source', repos=NULL)

#load packages

library(tidyverse)
library(lubridate)
library(janitor)

getwd()
setwd("D:/Elections data set")

Budgetdata<-read.csv("budget-allocation.csv")
colnames(Budgetdata)
summary(Budgetdata)


colSums(is.na(Budgetdata))
drop_na(Budgetdata)
budgetdatafinal <- Budgetdata[complete.cases(Budgetdata), ]


view(head(budgetdatafinal))
summary(budgetdatafinal)

colSums(is.na(budgetdatafinal))

budgetdatafinal<-distinct(budgetdatafinal)

budgetdatafinal<-separate(budgetdatafinal,
        col=Year,
        into=c("year",NA),sep="-")


write.csv(budgetdatafinal,file = "budgetdatafinal.csv",row.names = FALSE)
budgetdatafinal <- read_csv("budgetdatafinal.csv")


budgetdatafinal$year <- ordered(budgetdatafinal$year)
view(head(budgetdatafinal))
summary(budgetdatafinal)
names(budgetdatafinal)

budget_data_final<-budgetdatafinal%>% select(Province,year,Allocated.Budget..Rs..In.Millions.,Sector.Sub.Sector,Population)
write.csv(budget_data_final,file = "budget_data_final.csv",row.names = FALSE)

punjab_budget<-budget_data_final%>%filter(budget_data_final$Province=="Punjab")
write.csv(punjab_budget,file = "punjab_budget.csv",row.names = FALSE)
punjab_budget$Allocated.Budget..Rs..In.Millions.<-punjab_budget$Allocated.Budget..Rs..In.Millions.%>% as.numeric(as.character(punjab_budget$Allocated.Budget..Rs..In.Millions.))


Sindh_budget<-budget_data_final%>%filter(budget_data_final$Province=="Sindh")
write.csv(Sindh_budget,file = "Sindh_budget.csv",row.names = FALSE)

Balochistan_budget<-budget_data_final%>%filter(budget_data_final$Province=="Balochistan")
write.csv(Balochistan_budget,file = "Balochistan_budget.csv",row.names = FALSE)

khyber_budget<-budget_data_final%>%filter(budget_data_final$Province=="Khyber Pakhtunkhwa")
write.csv(khyber_budget,file = "khyber_budget.csv",row.names = FALSE)

view(budgetdatafinal)
view(punjab_budget)
