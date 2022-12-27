#this whole thing is a complete mess, and will probably not run properly. May I never see it again.

caller<-c(57,9,8,30,40,62,24,70,54,73,12,3,71,95,58,88,23,81,53,80,22,45,98,37,18,72,14,20,66,0,19,31,82,34,55,29,27,96,48,28,87,83,36,26,63,21,5,46,33,86,32,56,6,38,52,16,41,74,99,77,13,35,65,4,78,91,90,43,1,2,64,60,94,85,61,84,42,76,68,10,49,89,11,17,79,69,39,50,25,51,47,93,44,92,59,75,7,97,67,15)

input4<- read.csv("day4.csv", header=FALSE)
# could remove NA rows and then take out top 5 rows again and again until we have our boards
# or look at columns and rows separately - see when the first of each wins?

#----
#method two
allboards<-input4[!is.na(input4$V1),]
names(allboards)[1]<-"c1"
names(allboards)[2]<-"c2"
names(allboards)[3]<-"c3"
names(allboards)[4]<-"c4"
names(allboards)[5]<-"c5"

#add column to identify boards 
for (board_num in 1:100){
  for (board_row in 1:5){
    allboards[(board_num-1)*5+board_row,6]<-board_num
    allboards[(board_num-1)*5+board_row,7]<-paste("r",board_row,sep="")
  }
}
names(allboards)[6]<-"board"
names(allboards)[7]<-"board_row"

#now loop through the bingo calls on each row
allboards[,8]<-0
names(allboards)[8]<-"matches"
allboards[,9]<-0
names(allboards)[9]<-"winning_ball_position_rows"

# look at rows to see who wins
#rows_winning_board=200
#rows_winning_ball_pos=200

for (bingo_ball in 1:length(caller)){
    for (table_row in 1:nrow(allboards)){
        for (table_col in 1:5){
          if (allboards[table_row, table_col] == caller[bingo_ball]){
            allboards[table_row,8]<-allboards[table_row,8]+1
            if (allboards[table_row,8] == 5) allboards[table_row,9]<-bingo_ball
          }#if condition
        }#table_col loop
    }#table_row loop
}#bingo_ball loop

#now need to transpose boards
listboards<-list()
copy_allboards<-input4[!is.na(input4$V1),]

#extract top 5 rows, remove them from the list
#each element of listboards is a bingo card
for (i in 1:100){
  len=length(listboards)
  listboards[[len+1]]<-copy_allboards[1:5,]
  copy_allboards<-copy_allboards[6:nrow(copy_allboards),]
}

library(data.table) #for transpose function
#transpose the bingo boards 
transposed_listboards<-list()
for (i in 1:100){
  len=length(transposed_listboards)
  transposed_listboards[[len+1]]<-transpose(listboards[[i]])
}

allboards_transposed<-as.data.frame(rbindlist(transposed_listboards))

#now repeat what we did before!
names(allboards_transposed)[1]<-"r1"
names(allboards_transposed)[2]<-"r2"
names(allboards_transposed)[3]<-"r3"
names(allboards_transposed)[4]<-"r4"
names(allboards_transposed)[5]<-"r5"

#add column to identify boards 
for (board_num in 1:100){
  for (board_col in 1:5){
    allboards_transposed[(board_num-1)*5+board_col,6]<-board_num
    allboards_transposed[(board_num-1)*5+board_col,7]<-paste("c",board_col,sep="")
  }
}
names(allboards_transposed)[6]<-"board"
names(allboards_transposed)[7]<-"board_col"

#now loop through the bingo calls on each row
allboards_transposed[,8]<-0
names(allboards_transposed)[8]<-"matches"
allboards_transposed[,9]<-0
names(allboards_transposed)[9]<-"winning_ball_position_cols"

# look at rows to see who wins
#cols_winning_board=200
#cols_winning_ball_pos=200

for (bingo_ball in 1:length(caller)){
    for (table_row in 1:nrow(allboards_transposed)){
        for (table_col in 1:5){
          if (allboards_transposed[table_row, table_col] == caller[bingo_ball]){
            allboards_transposed[table_row,8]<-allboards_transposed[table_row,8]+1
            if (allboards_transposed[table_row,8] == 5) allboards_transposed[table_row,9]<-bingo_ball
          }#if condition
        }#table_col loop
    }#table_row loop
}#bingo_ball loop

#OK.... now what is the winning board and what is the score
#score = sum of all unmarked numbers multiplied by last number called

winning_ball_position <- min(cols_winning_ball_pos, rows_winning_ball_pos)
winning_number <- caller[winning_ball_position]

#cheating and looking that it is the rows which won - so board 89

winning_board<-allboards[allboards$board==89,]
uncalled_numbers<-caller[(winning_ball_position+1):100]
myvector<-c(winning_board$c1,
            winning_board$c2,
            winning_board$c3,
            winning_board$c4,
            winning_board$c5)
matches <- c()
for (i in 1:length(myvector)){
  for (j in 1:length(uncalled_numbers)){
    if (myvector[i] == uncalled_numbers[j])
      matches <- c(matches,myvector[i])
  }
}

sum(matches)*caller[winning_ball_position]

#----

# find the winning board
winning_board<-200
winning_ball_position<-200
list_winners<-list()
for (i in 1:nrow(allboards)){
  if (allboards[i,9]<winning_ball_position){
    winning_board<-allboards[i,6]
    winning_ball_position<-allboards[i,9]
    winner<-allboards[i,7]
    list_winners<-append(list_winners, winning_board)
  }
}
for (i in 1:nrow(allboards_transposed)){
  if (allboards[i,9]<winning_ball_position){
    winning_board<-allboards_transposed[i,6]
    winning_ball_position<-allboards_transposed[i,9]
    winner<-allboards_transposed[i,7]
  }
}

winning_board<-allboards[allboards$board==89,]
uncalled_numbers<-caller[(winning_ball_position+1):100]

myvector<-c(winning_board$c1,
            winning_board$c2,
            winning_board$c3,
            winning_board$c4,
            winning_board$c5)
matches <- c()
for (i in 1:length(myvector)){
  for (j in 1:length(uncalled_numbers)){
    if (myvector[i] == uncalled_numbers[j])
      matches <- c(matches,myvector[i])
  }
}
#board 89, 27th ball
sum(matches)*caller[winning_ball_position]

#----
#Part Two: same, but last board to finish
library("tidyr")
extract_cols1<-allboards[c(6,7,9)]
test1 <- pivot_wider(
  extract_cols1,
  names_from="board_row",
  values_from="winning_ball_position_rows"
)
extract_cols2<-allboards_transposed[c(6,7,9)]
test2 <- pivot_wider(
  extract_cols2,
  names_from="board_col",
  values_from="winning_ball_position_cols"
)
jointdataset <- merge(test1, test2, by = 'board')
jointdataset[1]<-NULL
jointdataset$Min <- apply(jointdataset,1,FUN=min)
jointdataset$board <- rnum
max(jointdataset$Min)
#board 69, with 82nd ball
winning_ball_position<-82
winning_board_position<-69
winning_board<-allboards[allboards$board==69,]
uncalled_numbers<-caller[(winning_ball_position+1):100]

myvector<-c(winning_board$c1,
            winning_board$c2,
            winning_board$c3,
            winning_board$c4,
            winning_board$c5)
matches <- c()
for (i in 1:length(myvector)){
  for (j in 1:length(uncalled_numbers)){
    if (myvector[i] == uncalled_numbers[j])
      matches <- c(matches,myvector[i])
  }
}
sum(matches)*caller[winning_ball_position]
