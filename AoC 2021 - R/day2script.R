input<- read.table("C:/Users/Zoe/Documents/R Scripts/Adventofcode2021/day2.txt",              # TXT data file indicated as string or full path to the file
           header = FALSE,    # Whether to display the header (TRUE) or not (FALSE)
           sep = " ")          # Separator of the columns of the file

#depth, horizontal, multiply
depth<-0
horizontal<-0
for (i in 1:nrow(input)){
if (input[i,1]=="forward") horizontal<-horizontal+input[i,2]
else if (input[i,1]=="down") depth<-depth+input[i,2]
else if (input[i,1]=="up") depth<-depth-input[i,2]
}
# or I could have separated out the rows by category and done the calculation on the total in each table
depth*horizontal
#--------------
#down increases aim
#up decreases aim
#forward increases horizontal by X
#and increases depth by X*aim
depth<-0
horizontal<-0
aim<-0
for (i in 1:nrow(input)){
  if (input[i,1]=="forward") {
    horizontal <- horizontal + input[i,2]
    depth <- depth + aim * input[i,2]
    print(c("horizontal = ",horizontal,"depth = ",depth))
  }
  else if (input[i,1]=="down") {
    aim <- aim + input[i,2]
    print(c("aim = ",aim))
  }
  else if (input[i,1]=="up") {
    aim <- aim - input[i,2]
    print(c("aim = ",aim))
  }
}
horizontal*depth