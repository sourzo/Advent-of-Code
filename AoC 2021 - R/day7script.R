##Get data and tidy
input7<- read.table("C:/Users/Zoe/Documents/R Scripts/Adventofcode2021/day7.txt",              # TXT data file indicated as string or full path to the file
                    header = FALSE,    # Whether to display the header (TRUE) or not (FALSE)
                    sep = ",")          # Separator of the columns of the file

input7<-as.data.frame(t(input7))
names(input7)<-c("hpos")
input7$fuel<-0

#----
#start at the median
median_fuel<-median(input7$hpos)

#total fuel with median value
for (table_row in 1:nrow(input7)){
  input7[table_row,2]<-abs(input7[table_row,1]-median_fuel)
}
total_fuel<-sum(input7$fuel)
best<-total_fuel

#try increasing the line position
guess<-median_fuel+1
for (table_row in 1:nrow(input7)){
  input7[table_row,2]<-abs(input7[table_row,1]-guess)
}
new_total<-sum(input7$fuel)

while (new_total<best){
  best<-new_total
  guess<-guess+1
  for (table_row in 1:nrow(input7)){
    input7[table_row,2]<-abs(input7[table_row,1]-guess)
  }
  new_total<-sum(input7$fuel)
}
#try decreasing the line position
guess<-median_fuel-1
for (table_row in 1:nrow(input7)){
  input7[table_row,2]<-abs(input7[table_row,1]-guess)
}
new_total<-sum(input7$fuel)

while (new_total<best){
  best<-new_total
  guess<-guess-1
  for (table_row in 1:nrow(input7)){
    input7[table_row,2]<-abs(input7[table_row,1]-guess)
  }
  new_total<-sum(input7$fuel)
}

#----

## Part 2: New rules - triang numbers

triang<-function(N) N*(N+1)/2


#start at the median
mean_fuel<-round(mean(input7$hpos))

#total fuel with median value
for (table_row in 1:nrow(input7)){
  input7[table_row,2]<-triang(abs(input7[table_row,1]-mean_fuel))
}
total_fuel<-sum(input7$fuel)
best<-total_fuel

#try increasing the line position
guess<-mean_fuel+1
for (table_row in 1:nrow(input7)){
  input7[table_row,2]<-triang(abs(input7[table_row,1]-guess))
}
new_total<-sum(input7$fuel)

while (new_total<best){
  best<-new_total
  guess<-guess+1
  for (table_row in 1:nrow(input7)){
    input7[table_row,2]<-triang(abs(input7[table_row,1]-guess))
  }
  new_total<-sum(input7$fuel)
}
#try decreasing the line position
guess<-mean_fuel-1
for (table_row in 1:nrow(input7)){
  input7[table_row,2]<-triang(abs(input7[table_row,1]-guess))
}
new_total<-sum(input7$fuel)

while (new_total<best){
  best<-new_total
  guess<-guess-1
  for (table_row in 1:nrow(input7)){
    input7[table_row,2]<-triang(abs(input7[table_row,1]-guess))
  }
  new_total<-sum(input7$fuel)
}