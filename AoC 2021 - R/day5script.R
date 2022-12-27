##Get data and tidy
input5<- read.table("C:/Users/Zoe/Documents/R Scripts/Adventofcode2021/day5.txt",              # TXT data file indicated as string or full path to the file
                   header = FALSE,    # Whether to display the header (TRUE) or not (FALSE)
                   sep = " ")          # Separator of the columns of the file
library("tidyr")
#separate first coordinates
input5<-separate(input5, V1, sep = ",",  
         into = c("x1", "y1"))
#separate second coordinates
input5<-separate(input5, V3, sep = ",",  
         into = c("x2", "y2"))
#remove useless column
input5 <- subset(input5, select = -c(V2))
#convert values to numeric
input5[,1:4] <- apply(input5[,1:4], 2,            # Specify own function within apply
                    function(x) as.numeric(as.character(x)))
#add 1 to everything to make it easier
for (table_row in 1:nrow(input5)){
  for (table_col in 1:ncol(input5)){
    input5[table_row, table_col] <- input5[table_row, table_col] + 1
  }
}

#Work out size of area
x_min <- min(input5$x1, input5$x2)
y_min <- min(input5$y1, input5$y2)
x_max <- max(input5$x1, input5$x2)
y_max <- max(input5$y1, input5$y2)

#need an array/matrix/something
map <- matrix(0, nrow=x_max, ncol=y_max)

##horizontal lines
horizontal <- input5[input5$x1==input5$x2,]
#Create vectors etc
horizontal_xlist<-list()
horizontal_ylist<-list()
for (table_row in 1:nrow(horizontal)){
  horizontal_xlist[table_row]<-horizontal[table_row,"x1"]
  horizontal_ylist[[table_row]]<-c(horizontal[table_row,"y1"]:horizontal[table_row,"y2"])
}

#Apply to map
for (line_num in 1:length(horizontal_xlist)){
  for (col_num in 1:length(horizontal_ylist[[line_num]])){
    map[horizontal_xlist[[line_num]],horizontal_ylist[[line_num]][col_num]] <- map[horizontal_xlist[[line_num]],horizontal_ylist[[line_num]][col_num]] + 1
  }
}

##vertical lines
vertical <- input5[input5$y1==input5$y2,]

#Create vectors etc
vertical_xlist<-list()
vertical_ylist<-list()
for (table_row in 1:nrow(vertical)){
  vertical_ylist[table_row]<-vertical[table_row,"y1"]
  vertical_xlist[[table_row]]<-c(vertical[table_row,"x1"]:vertical[table_row,"x2"])
}

#Apply to map
for (line_num in 1:length(vertical_ylist)){
  for (row_num in 1:length(vertical_xlist[[line_num]])){
    map[vertical_xlist[[line_num]][row_num],vertical_ylist[[line_num]]] <- map[vertical_xlist[[line_num]][row_num],vertical_ylist[[line_num]]] + 1
  }
}

##Count number of spaces where lines overlap
count_overlap<-0
for (map_row in 1: nrow(map)){
  for (map_col in 1:ncol(map)){
    if (map[map_row,map_col]>1){
      count_overlap <- count_overlap + 1
    }
  }
}

##Part 2: Diagonal lines
#diagonal lines
diagonal <- input5[input5$x1!=input5$x2,]
diagonal <- diagonal[diagonal$y1!=diagonal$y2,]

#Create vectors etc
diagonal_xlist<-list()
diagonal_ylist<-list()
for (table_row in 1:nrow(diagonal)){
  diagonal_xlist[[table_row]]<-c(diagonal[table_row,"x1"]:diagonal[table_row,"x2"])
  diagonal_ylist[[table_row]]<-c(diagonal[table_row,"y1"]:diagonal[table_row,"y2"])
}
map2<-map
#Apply to map
for (line_num in 1:length(diagonal_ylist)){
  for (line_point in 1:length(diagonal_xlist[[line_num]])){
      map2[diagonal_xlist[[line_num]][line_point],diagonal_ylist[[line_num]][line_point]] <- map2[diagonal_xlist[[line_num]][line_point],diagonal_ylist[[line_num]][line_point]] + 1
  }
}

##Count number of spaces where lines overlap
count_all_overlap<-0
for (map_row in 1: nrow(map)){
  for (map_col in 1:ncol(map)){
    if (map2[map_row,map_col]>1){
      count_all_overlap <- count_all_overlap + 1
    }
  }
}
