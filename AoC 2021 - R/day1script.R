library("dplyr")
library("readr")
depthdata<-read_csv("C:/Users/Zoe/Documents/R Scripts/Adventofcode2021/day1.csv")

depthdataframe<-data.frame(depthdata)

for(i in 2:nrow(depthdataframe)){
  if (depthdataframe[i,1] > depthdataframe[i-1,1]) depthdataframe[i,2]<-"increase"
  else if (depthdataframe[i,1] < depthdataframe[i-1,1]) depthdataframe[i,2]<-"decrease"
  else if (depthdataframe[i,1] == depthdataframe[i-1,1]) depthdataframe[i,2]<-"no change"
}
table(unlist(depthdataframe[,2]))

#----------
for(i in 3:nrow(depthdataframe)){
  depthdataframe[i,3]<-depthdataframe[i,1]+depthdataframe[i-1,1]+depthdataframe[i-2,1]
}
for(i in 4:nrow(depthdataframe)){
  if (depthdataframe[i,3] > depthdataframe[i-1,3]) depthdataframe[i,4]<-"increase"
  else if (depthdataframe[i,3] < depthdataframe[i-1,3]) depthdataframe[i,4]<-"decrease"
  else if (depthdataframe[i,3] == depthdataframe[i-1,3]) depthdataframe[i,4]<-"no change"
}
depthdataframe[1:200,]
table(unlist(depthdataframe[,4]))
