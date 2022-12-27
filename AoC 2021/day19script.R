library(dplyr)
input19<-as.data.frame(readLines("day19test.txt"))
names(input19)<-c("col1")

input19$scanner<-0
scanner<- 0
for (row in 1:nrow(input19)){
  if (substr(input19[row,"col1"],1,3)=="---"){
    scanner<-scanner+1
  }
  input19[row,"scanner"]<-scanner
}


#remove blank lines and scanner numbers
input19<-filter(input19,col1 != "")
input19<-filter(input19,substr(col1,1,3) != "---")


#separate 1st column
input19<-tidyr::separate(input19,col1,sep=",",into=c("x","y","z"))

#split into separate scanner things?
scanner_list<-list()
for (s in 1:scanner){
  scanner_list[[s]]<-input19[input19$scanner == s,]
}

