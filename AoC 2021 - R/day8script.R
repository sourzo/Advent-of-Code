library(stringr)
input8<- read.table("C:/Users/Zoe/Documents/R Scripts/Adventofcode2021/day8.txt",              # TXT data file indicated as string or full path to the file
                    header = FALSE,    # Whether to display the header (TRUE) or not (FALSE)
                    sep = " ")          # Separator of the columns of the file

names(input8)<-c("pat1", "pat2", "pat3", "pat4", "pat5", 
                 "pat6", "pat7", "pat8", "pat9", "pat10", 
                 "sep", "out1", "out2", "out3", "out4")

#convert factor columns to character
input8a <- input8                                              # Duplicate data
fac_cols <- sapply(input8a, is.factor)                           # Identify all factor columns
input8a[fac_cols] <- lapply(input8a[fac_cols], as.character)  # Convert all factors to characters

input8a$find1478<-0
#count number of times 1,4,7,8 appear in output
for (table_row in 1:nrow(input8a)){
  for (table_col in 12:15){
    if (str_length(input8a[table_row,table_col]) == 2) {
      input8a[table_row,16] <- input8a[table_row,16] + 1
    }
    if (str_length(input8a[table_row,table_col]) == 4) {
      input8a[table_row,16] <- input8a[table_row,16] + 1
    }
    if (str_length(input8a[table_row,table_col]) == 3) {
      input8a[table_row,16] <- input8a[table_row,16] + 1
    }
    if (str_length(input8a[table_row,table_col]) == 7) {
      input8a[table_row,16] <- input8a[table_row,16] + 1
    }
  }
}
sum(input8a$find1478)
str_order(input8a[1,1])

#----
#Part 2

#Change elements of data frame to vectors

vectorise_string <- function(str_input){
  str_input<-t(sort(strsplit(str_input,"")[[1]]))
}
for (table_row in 1:nrow(input8a)){
  
  signal_patterns<-c()
  signal_translation<-c(11,11,11,11,11,11,11,11,11,11)
  for (table_col in 1:10){
    signal_patterns[[table_col]] <-  vectorise_string(input8a[table_row, table_col])
  }
  
  library(rje)
  #sweep 1: using only lengths of strings
  for (pattern in 1:10){
    if (length(signal_patterns[[pattern]]) == 2){
      signal_translation[[pattern]]<-1
      pos_1<-pattern
    }
    else if (length(signal_patterns[[pattern]]) == 3){
      signal_translation[[pattern]]<-7
    }
    else if (length(signal_patterns[[pattern]]) == 4){
      signal_translation[[pattern]]<-4
      pos_4<-pattern
    }
    else if (length(signal_patterns[[pattern]]) == 7){
      signal_translation[[pattern]]<-8
    }
  }
  
  #sweep 2
  for (pattern in 1:10){
    if (length(signal_patterns[[pattern]]) == 6){
      if(!is.subset(signal_patterns[[pos_1]],signal_patterns[[pattern]])){
        signal_translation[[pattern]]<-6
        pos_6<-pattern
      }
      else if(is.subset(signal_patterns[[pos_4]],signal_patterns[[pattern]])){
        signal_translation[[pattern]]<-9
      }
      else signal_translation[[pattern]]<-0
    }
    else if (length(signal_patterns[[pattern]]) == 5){
      if(is.subset(signal_patterns[[pos_1]],signal_patterns[[pattern]])){
        signal_translation[[pattern]]<-3
      }
    }
  }
  
  for (pattern in 1:10){
    if (length(signal_patterns[[pattern]]) == 5){
      if(is.subset(signal_patterns[[pattern]],signal_patterns[[pos_6]])){
        signal_translation[[pattern]]<-5
      }
    }
    if (signal_translation[[pattern]] == 11){
      signal_translation[[pattern]]<-2
    }
  }
   # now we have a translation between the letters and the numbers
  
  output_patterns<-c()
  output_translation<-c(11,11,11,11)
  for (table_col in 12:15){
    output_patterns[[table_col-11]] <-  vectorise_string(input8a[table_row, table_col])
    for (translation in 1:10){
      #check which word matches each character and output in digits
      if(is.subset(output_patterns[[table_col-11]],signal_patterns[[translation]])){
        if (is.subset(signal_patterns[[translation]],output_patterns[[table_col-11]])){
          output_translation[table_col-11] <- signal_translation[[translation]]
        }
      } #match
    } #translation
  } #table_col
  
  input8a[table_row,"digits"]<-
    1000*output_translation[[1]] +
    100*output_translation[[2]] +
    10*output_translation[[3]] +
    output_translation[[4]] 
}
sum(input8a$digits)