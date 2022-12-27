library(stringr)
input18<-readLines("day18test.txt")

addnumbers<-function(x,y){
  paste0("[",x,",",y,"]")
}

#reduction

#nested inside 4 pairs - pair on left "explodes"
#if any regular number is >=10, then the leftmost such one "splits"

#To explode a pair, the pair's left value is added to the first regular number 
#to the left of the exploding pair (if any), and the pair's right value is added 
#to the first regular number to the right of the exploding pair (if any). Exploding 
#pairs will always consist of two regular numbers. Then, the entire exploding pair 
#is replaced with the regular number 0.