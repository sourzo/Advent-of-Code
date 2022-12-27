heightmap<- read.table("C:/Users/Zoe/Documents/R Scripts/Adventofcode2021/day9.txt",              # TXT data file indicated as string or full path to the file
                    header = FALSE,    # Whether to display the header (TRUE) or not (FALSE)
                    sep = ",")          # Separator of the columns of the file

nrows<-nrow(heightmap)
ncols<-ncol(heightmap)
risk<-c()

#find and list the low points
low_points<-data.frame("x"=numeric(),
                       "y"=numeric(),
                       "Basin_Size"=numeric())
#the inside bits
for (table_row in 2:(nrows-1)){
  for (table_col in 2:(ncols-1)){
    if (all(heightmap[table_row,table_col] < heightmap[table_row+1,table_col]
            ,heightmap[table_row,table_col] < heightmap[table_row-1,table_col]
            ,heightmap[table_row,table_col] < heightmap[table_row,table_col+1]
            ,heightmap[table_row,table_col] < heightmap[table_row,table_col-1])){
      risk<-c(risk, heightmap[table_row,table_col]+1)
      low_points[nrow(low_points)+1,"x"]<-table_row
      low_points[nrow(low_points),"y"]<-table_col
      #print(paste("row=",table_row,"col=",table_col,"value=",heightmap[table_row,table_col]))
    }
  }
}
#top row
for (table_col in 2:(ncols-1)){
  if (all(heightmap[1,table_col] < heightmap[2,table_col]
          ,heightmap[1,table_col] < heightmap[1,table_col+1]
          ,heightmap[1,table_col] < heightmap[1,table_col-1])){
    risk<-c(risk, heightmap[1,table_col]+1)
    low_points[nrow(low_points)+1,"x"]<-1
    low_points[nrow(low_points),"y"]<-table_col
  }
}
#bottom row
for (table_col in 2:(ncols-1)){
  if (all(heightmap[nrows,table_col] < heightmap[(nrows-1),table_col]
          ,heightmap[nrows,table_col] < heightmap[nrows,table_col+1]
          ,heightmap[nrows,table_col] < heightmap[nrows,table_col-1])){
    risk<-c(risk, heightmap[nrows,table_col]+1)
    low_points[nrow(low_points)+1,"x"]<-nrows
    low_points[nrow(low_points),"y"]<-table_col
  }
}
#left side
for (table_row in 2:(nrows-1)){
  if (all(heightmap[table_row,1] < heightmap[table_row+1,1]
          ,heightmap[table_row,1] < heightmap[table_row-1,1]
          ,heightmap[table_row,1] < heightmap[table_row,2])){
    risk<-c(risk, heightmap[table_row,1]+1)
    low_points[nrow(low_points)+1,"x"]<-table_row
    low_points[nrow(low_points),"y"]<-1
  }
}
#right side
for (table_row in 2:(nrows-1)){
  if (all(heightmap[table_row,ncols] < heightmap[table_row+1,ncols]
          ,heightmap[table_row,ncols] < heightmap[table_row-1,ncols]
          ,heightmap[table_row,ncols] < heightmap[table_row,(ncols-1)])){
    risk<-c(risk, heightmap[table_row,ncols]+1)
    low_points[nrow(low_points)+1,"x"]<-table_row
    low_points[nrow(low_points),"y"]<-ncols
  }
}
#corners
if (heightmap[1,1] < heightmap[1,2]
    && heightmap[1,1] < heightmap[2,1]){
  risk<-c(risk, heightmap[1,1]+1)
  low_points[nrow(low_points)+1,"x"]<-1
  low_points[nrow(low_points),"y"]<-1
}
if (heightmap[1,ncols] < heightmap[1,(ncols-1)]
    && heightmap[1,ncols] < heightmap[2,ncols]){
  risk<-c(risk, heightmap[1,ncols]+1)
  low_points[nrow(low_points)+1,"x"]<-1
  low_points[nrow(low_points),"y"]<-ncols
}
if (heightmap[nrows,1] < heightmap[(nrows-1),1]
    && heightmap[nrows,1] < heightmap[nrows,2]){
  risk<-c(risk, heightmap[nrows,1]+1)
  low_points[nrow(low_points)+1,"x"]<-nrows
  low_points[nrow(low_points),"y"]<-1
}
if (heightmap[nrows,ncols] < heightmap[(nrows-1),ncols]
    && heightmap[nrows,ncols] < heightmap[nrows,(ncols-1)]){
  risk<-c(risk, heightmap[nrows,ncols]+1)
  low_points[nrow(low_points)+1,"x"]<-nrows
  low_points[nrow(low_points),"y"]<-ncols
}
sum(risk)

#part 2 - basins----

x=2
y=16
#create a stack for points to check
to_check<-data.frame("x"=numeric(),
                       "y"=numeric())
if (x>1){ #everything except top row - add the point above
  if (heightmap[x-1,y])
  to_check[nrow(to_check)+1,"x"] <- x-1
  to_check[nrow(to_check),"y"] <- y
}
if (x<nrow(heightmap)){ #everything except bottom row - add the point below
  to_check[nrow(to_check)+1,"x"] <- x+1
  to_check[nrow(to_check),"y"] <- y
}
if (y>1){ #everything except left row - add the point to the left
  to_check[nrow(to_check)+1,"x"] <- x
  to_check[nrow(to_check),"y"] <- y-1
}
if (y<ncol(heightmap)){ #everything except right row - add the point to the right
  to_check[nrow(to_check)+1,"x"] <- x
  to_check[nrow(to_check),"y"] <- y+1
}
