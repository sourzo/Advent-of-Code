#Progress on this: I need to code in parent packets, and then apply the operators
#suggestion: Could put the child packet/substring counters inline with the parent packets

library(stringr)
input16test<-readLines("day16test.txt") # this has seven components
input16<-readLines("day16.txt")# this has one component

translation<-as.data.frame(readLines("day16hexbin.txt"))
translation<-tidyr::separate(translation,1,c("hex","bin"))

master<-input16

translated<-c()
for (char in 1:str_length(master)){
  for (hex in 1:nrow(translation)){
    if (substr(master,char,char) == translation[hex,1]){
      translated<-paste0(translated,translation[hex,2])
    }
  }
}

record<-data.frame(
  ID=integer(), #for part 2
  parent=integer(), #for part 2
  version=integer(), #for part 1&2
  type=integer(), #for part 1&2
  uncoded_num=integer(), #for part 2
  subpacketlength=integer(), #for part 2
  numberofsubpackets=integer() #for part 2
)

remainder<-translated

ID<-0
parent<-0

while (str_detect(remainder, "1") == TRUE){
  ID<-ID+1
  type<-strtoi(substr(remainder,4,6),base=2)
  remainder<-substr(remainder,7,str_length(remainder))
  
  record[ID,"version"]<-strtoi(substr(remainder,1,3),base=2)
  record[ID,"type"]<-type
  record[ID,"ID"]<-ID
  
  #operator packet
  if (type != 4){
    ltID<-substr(remainder,1,1)
    remainder<-substr(remainder,2,str_length(remainder))
    if (ltID == 0){
      record[ID,"subpacketlength"]<-strtoi(substr(remainder,1,15),base=2)
      record[ID,"parent"]<-parent
      remainder<-substr(remainder,16,str_length(remainder))
    }
    else{
      record[ID,"numberofsubpackets"]<-strtoi(substr(remainder,1,11),base=2)
      record[ID,"parent"]<-parent
      remainder<-substr(remainder,12,str_length(remainder))
    }
  }
  
  #Type 4 packet----
  #parse a character
  else if (type == 4){
    indicator<-"1"
    bin_num<-""
    while (indicator != "0"){
      indicator<-substr(remainder,1,1)
      bin_num<-paste0(bin_num, substr(remainder,2,5))
      remainder<-substr(remainder,6,str_length(remainder))
    }
    record[ID,"uncoded_num"]<-strtoi(bin_num,base=2)
    record[ID,"parent"]<-parent
    #... and then there is a bit at the end which 
    #needs to be removed from the remainder
  }
}
total<-sum(record$version)