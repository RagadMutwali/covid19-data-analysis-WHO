rm(list=ls()) #removes previously loaded data 
library(Hmisc)

data <- read.csv("C:/Users/ASUS/Desktop/analysis/COVID19_line_list_data.csv")


data$death_outcome <-  as.integer(data$death !=0) # cleaned up column making values only 0 or 1 S

#death rate 
sum(data$death_outcome)/ nrow(data)

#Age of infected
#claim: people who passed away from covid where older in age than those who survived

deceased = subset(data, death_outcome == 1)
survived = subset(data, death_outcome == 0 )

mean(deceased$age, na.rm= TRUE) #we ignore any NA
mean(survived$age, na.rm = TRUE)

#age difference between deceased and survived is 20 years
#is this statistically significant ?
t.test(survived$age, deceased$age, alternative="two.sided", conf.level=0.99)
# when p value <0.05 we reject null hypothesis
#our p value here is around 0 so we an conclude that the age difference is statistically significant

#Gender
#Claim: gender has an effect on death rate
female= subset(data, gender=="female")
male= subset(data, gender=="male")

mean(female$death_outcome, na.rm=TRUE) # 3.7% of women passed away after infection
mean(male$death_outcome, na.rm=TRUE) # 8.5% of men passed away after infection
#is this statistically significant ?
t.test(female$death_outcome, male$death_outcome, alternative="two.sided", conf.level=0.99 )
# 99% confidence that men have from 0.8% to 8.8% higher chance of death 
# p value  is 0.02 which is p<0.5 
# so difference in death rate according to gender
# is statistically significant 

unique(data$country) #how many countries are included in data set

#covid cases per country
country_casesNo <- aggregate(death_outcome ~ country, data=data, FUN=length)
colnames(country_casesNo) <- c("Country","Number_of_cases")


# death rates per country
country_deathrates <- aggregate(death_outcome ~ country, data=data, FUN=mean, na.rm=TRUE)
colnames(country_deathrates) <- c("Country","Death_Rate")

country_deathrates$Death_Rate <- country_deathrates$Death_Rate * 100 #percentage

#number of deaths
country_deathNo <- aggregate(death_outcome ~ country, data=data,FUN=sum, na.rm=TRUE)
colnames(country_deathNo) <- c("Country", "Number_Of_Deaths")

#merging all tables to be printed at once
merge1 <- merge(country_casesNo, country_deathrates, by= "Country")
country_summary <- merge(merge1,country_deathNo, by="Country")

#ordering from highest death rate to lowest
country_summary <- country_summary[order(-country_deathrates$Death_Rate), ]

print(country_summary)

#we will plot a barchart for the 5 countries with highest number of cases
country_casesNo <- country_casesNo[order(-country_casesNo$Number_of_cases), ]
# extracts the 5 countries
highest_cases <- head(country_casesNo,5)

print(highest_cases)

#generate png of graph
png("topCases.png",width=800 , height=600)

par(mar = c(6,5,4,2))

#bar chart creation
barplot(
  height = highest_cases$Number_of_cases,
  names.arg= highest_cases$Country,
  main= "Top five countries wwith highest Number of Reported Covid 19 cases",
  xlab="Country",
  ylab="Number of Cases",
  las=1,
  yaxt="n",
)

#plot y axis in intervals of 20
axis(
  side=2,
  at= seq(0, 195, by=15),
  las=1,
  
)
dev.off()
