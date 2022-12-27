library(stringr)
input13 <- as.data.frame(readLines("C:/Users/Zoe/Documents/R Scripts/Adventofcode2021/day13.txt"))
num_coords<-974
#num_coords<-18

coordinates <- as.data.frame(input13[1:num_coords,])
coordinates <- tidyr::separate(coordinates,1,sep=",",into=c("x","y"))
coordinates$x <- as.numeric(coordinates$x)
coordinates$y <- as.numeric(coordinates$y)
#r counts from 1, this counts from zero. Add one to everything
#warning - folds will also have to be adjusted
for (rows in 1:nrow(coordinates)){
  for (cols in 1:ncol(coordinates)){
    coordinates[rows,cols]<-coordinates[rows,cols] + 1
  }
}
xmax<-max(coordinates$x)
ymax<-max(coordinates$y)

#warning - folds will also have to be adjusted
instructions <- as.data.frame(input13[-c(0:num_coords+1),])
for (rows in 1:nrow(instructions)){
  instructions[rows,"xy"]<-substr(instructions[rows,1],
                                  12,
                                  12)
  instructions[rows,"foldline"]<-substr(instructions[rows,1],
                                        14,
                                        str_length(instructions[rows,1]))
}

#create paper
paper<-data.frame(V1=c(rep(0,xmax)))
for (papercol in 1:ymax){
  paper[,papercol]<-c(rep(0,xmax))
  paper[,papercol]<-as.numeric(paper[,papercol])
}

#add "dots"
for (coords in 1:nrow(coordinates)){
  paper[coordinates[coords,"x"],coordinates[coords,"y"]]<-1
}

fold<-function(direction,number){
  if(direction == "y"){
    #fold along y=number(=number+1)
    for (cols in 1:number){
      for (rows in 1:nrow(paper)){
        if (paper[rows,ncol(paper)-cols + 1] == 1)
          paper[rows,cols]<-1
      }
    }
    print(c("Folding along ",direction," = ",number))
    print(c("rows = ", nrow(paper), "cols = ", ncol(paper)))
    paper<-paper[,1:number]
    print(c("rows = ", nrow(paper), "cols = ", ncol(paper)))
  }
  if(direction == "x"){
    #fold along x=number(=number+1)
    for (cols in 1:ncol(paper)){
      for (rows in 1:number){
        if (paper[nrow(paper)-rows+1,cols] == 1){
          paper[rows,cols]<-1
        }
      }
    }
    print(c("Folding along ",direction," = ",number))
    print(c("rows = ", nrow(paper), "cols = ", ncol(paper)))
    paper<-paper[1:number,]
    print(c("rows = ", nrow(paper), "cols = ", ncol(paper)))
  }
  return(paper)
}

for (inst_rows in 1:nrow(instructions)){
  paper<-fold(instructions[inst_rows,"xy"],instructions[inst_rows,"foldline"])
}

write.csv(paper,"paper.csv")
#count dots
dots<-0
for (rows in 1:nrow(paper)){
  for (cols in 1:ncol(paper)){
    if (paper[rows,cols] == 1){dots<-dots + 1}
  }
}
