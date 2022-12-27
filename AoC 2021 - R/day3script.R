input3<- read.csv("day3.csv", header=TRUE)

#We need to know for each column whether there are more zeros or ones
#If we find the total value of each column, this gives us the number of ones
#The number of rows divided by 2 gives us the mid-point. 
#Lower than this and there are more zeros than ones and vice-versa.

Most<-""

for (i in colnames(input3)){
  if (sum(input3[[i]])*2 > nrow(input3))
    Most<-paste(Most, "1", sep="")
  else
    Most<-paste(Most, "0", sep="")
  #dont know what to do if there are same number of each
}

#The binary string and its complement will add up to
#2^(ncols)-1 (as it will create a string 111111111111)
#and since we want an answer in decimal we might as well calculate it that way

library(compositions)

unbinary(Most) * ((2^ncol(input3)-1)-unbinary(Most))

#-----

#This looks like it will be recursive
oxygen<-input3
o2_key<-""

for (i in colnames(oxygen)){
  if (nrow(oxygen)==1) break
  if (sum(oxygen[[i]])*2 >= nrow(oxygen))
    keep<-1
  else keep<-0
  o2_key<-paste(o2_key,keep, sep="")
  oxygen <- oxygen[oxygen[[i]]==keep,]
  print(oxygen[1:3,])
}
oxygen
o2_key

co2gen<-input3
co2_key<-""
for (i in colnames(co2gen)){
  #where there are still lines to be removed
  if (nrow(co2gen)!=1){
    if (sum(co2gen[[i]])*2 >= nrow(co2gen))
    keep<-0
  else keep<-1
    co2_key<-paste(co2_key,keep, sep="")
    co2gen <- co2gen[co2gen[[i]]==keep,]
  }
  #no more lines to be removed: take remaining digits
  else {
    co2_key<-paste(co2_key,co2gen[[i]], sep="")
  }
}
co2_key
unbinary(o2_key)*unbinary(co2_key)