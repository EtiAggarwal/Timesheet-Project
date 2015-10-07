#setwd("/Users/stephenkinser/jiraGraph")
#library(gdata) 
library(ggplot2)

#mydata = read.xls("jira.xlsx")

mydata = read.csv("jira-cleaner.csv")
View(mydata)
subset(mydata, as.character(Project)== "DOT Next" )
mydata$Updated=strptime(as.character(mydata$Updated) , "%m/%d/%y %H:%M")
ggplot(data= mydata, aes(x=Updated))+geom_histogram()+facet_wrap(~Project)
ggsave("basicHistogram.png")
ggplot(data= mydata, aes(x=Updated, color=Assignee))+geom_histogram()+facet_wrap(~Project)
ggsave("colorHistogram.png")
ggplot(data= mydata, aes(x=Updated, color=Project))+geom_histogram()+facet_wrap(~Assignee)
ggsave("unassigned.png")
ggplot(data= mydata, aes(x=factor(1),fill=Assignee))+
  geom_bar(width=1)+ coord_polar(theta = "y")+facet_wrap(~Project)
ggsave("pigraph.png")
ggplot(data= mydata, aes(x=factor(1),fill=Assignee))+
  geom_bar(width=1)+ coord_polar(theta = "y")+ coord_polar()+facet_wrap(~Project)
ggsave("bullseye.png")
mydata$Project
ggplot(data=subset(mydata, as.character(Project)== "DOT Next" ),aes(x=Updated,color=Assignee))+geom_histogram()+ coord_polar()
ggplot(data=subset(mydata, as.character(Project)== "DOT Next" ),aes(x=factor(1),fill=Assignee))+geom_bar(width=1)+coord_polar()
ggplot(data=subset(mydata, as.character(Project)== "DREAMaps Online" ),aes(x=factor(1),fill=Assignee))+geom_bar(width=1)+coord_polar()


ggplot(data= subset(mydata, as.character(Assignee)!= "Unassigned" ), aes(x=Updated, color=Project))+geom_histogram()+facet_wrap(~Assignee)
ggsave("ignoreUnassigned.png")
ggplot(data= subset(mydata, as.character(Assignee)!= "Unassigned" ), aes(x=factor(1),fill=Assignee))+
  geom_bar(width=1)+ coord_polar(theta = "y")+ coord_polar()+facet_wrap(~Project)
ggplot(data=subset(mydata, as.character(Assignee)!= "Unassigned" ) , 
       aes(x=""))+
  geom_bar(width=1,aes(y=length(..count..)/sum(..count..),fill=Assignee))+coord_polar() +facet_wrap(~Project)

