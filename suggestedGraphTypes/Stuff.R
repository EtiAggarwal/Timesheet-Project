rm(list = ls())
setwd("/Users/stephenkinser/Timesheet-Project/suggestedGraphTypes")
#library(gdata) 
#install.packages("gridSVG")
#install.packages("rjson")
#library("rjson")
#install.packages("XML")
library("XML")
library(ggplot2)
library(gridSVG)
mydata = read.csv("jira-cleaner.csv")
#View(mydata)
#subset(mydata, as.character(Project)== "DOT Next" )
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

ggplot(data=subset(mydata, as.character(Project)== "DOT Next" ),aes(x=Updated,color=Assignee))+geom_histogram()+ coord_polar()
ggplot(data=subset(mydata, as.character(Project)== "DOT Next" ),aes(x=factor(1),fill=Assignee))+geom_bar(width=1)+coord_polar()
ggplot(data=subset(mydata, as.character(Project)== "DREAMaps Online" ),aes(x=factor(1),fill=Assignee))+geom_bar(width=1)+coord_polar()


testingraph<-ggplot(data= subset(mydata, as.character(Assignee)!= "Unassigned" ), aes(x=Updated, color=Project))+geom_histogram()+facet_wrap(~Assignee, ncol = 1)
ggsave("ignoreUnassigned.png")
ggplot(data= subset(mydata, as.character(Assignee)!= "Unassigned" ), aes(x=factor(1),fill=Assignee))+
  geom_bar(width=1)+ coord_polar(theta = "y")+ coord_polar()+facet_wrap(~Project)

ggplot(data=subset(mydata, as.character(Assignee)!= "Unassigned" ) , 
       aes(x=""))+
  geom_bar(width=1,aes(y=length(..count..)/sum(..count..),fill=Assignee))+coord_polar() +facet_wrap(~Project)

#table(subset(mydata, as.character(Assignee)!= "Unassigned" ), )
#View(mydata)
#with(subset(mydata, as.character(Assignee)!= "Unassigned"),table(Updated))
#mytable=with(subset(mydata, as.character(Assignee)!= "Unassigned"),table(Updated,Assignee,Project))
#finalcsv =subset(as.data.frame(mytable),Freq !=0)
#write.csv(finalcsv, file= "freq.csv")
#write (apply(finalcsv,1, function(x){toJSON(x)}), "freq.json")
htmlhead <- 
  '<!DOCTYPE html>
<head>
<meta charset = "utf-8">
<script src = "http://d3js.org/d3.v3.js"></script>
</head>

<body>'
mysvg <- grid.export("panzoom1.svg"  )
?grid.export
panzoomScript <-
  '  <script>
    var svg = d3.selectAll("#gridSVG");
    svg.call(d3.behavior.zoom().scaleExtent([1, 8]).on("zoom", zoom))
    
    function zoom() {
      svg.attr("transform", "translate(" + d3.event.translate + ")scale(" + d3.event.scale + ")");
    } 
  </script>
</body>
'
sink("panzoom_ggplot2.html")
cat(htmlhead,saveXML(mysvg$svg),panzoomScript)
