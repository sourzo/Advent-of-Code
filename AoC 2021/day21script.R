#Dirac dice

#Example input:
#Player 1 starting position: 4
#Player 2 starting position: 8

#Input:
#Player 1 starting position: 7
#Player 2 starting position: 8

#Turn:
#Roll the die 3 times and add the results ; Move the pawn that far round the track
#Points = stopping space (cumulative)

#Deterministic die: D100, rolls 1,2,3,...,100
#Winner = first to at least 1000

#Output: Losing player score x Number of times die rolled

#Part 1----
die_max<-100
board_size<-10
value<-0
die<-c()
for (repeats in 1:board_size){
  die<-c(die,
         ((value)%%die_max +
           (value+1)%%die_max +
           (value+2)%%die_max +
           3)%%board_size
  )
  value<-(value+3)
}
die
p1_position <- 7
p2_position <- 8
p1_score<-0
p2_score<-0
max_score<-0
count_rolls<-0 # number of times die rolled
roll_point<-0 # where the die is in its rolls (minus 1 because R counts from 1)
while (max_score < 1000){
  
  #player 1
  count_rolls <- count_rolls+1                      # count number of times die rolled
  p1_position <- (p1_position+die[roll_point+1])%%10  # move pawn on board
  if (p1_position==0){p1_position <- 10}
  p1_score <- p1_score + p1_position            # add to score
  roll_point <- (roll_point+1)%%10              # set die to next roll
  if (p1_score >= 1000) break
  
  #player 2
  count_rolls <- count_rolls+1                      # count number of times die rolled
  p2_position <- (p2_position+die[roll_point+1])%%10  # move pawn on board
  if (p1_position==0){p1_position <- 10}
  p2_score <- p2_score + p2_position            # add to score
  
  roll_point <- (roll_point+1)%%10              # set die to next roll
  
  max_score<-max(p1_score,p2_score)
}
count_rolls<-count_rolls*3
output<-count_rolls*min(p1_score,p2_score)

#Part 2----
#Each turn is 3 rolls, creating 27 realities
quantum_die<-data.frame(Outcome = c(3:9),
                        Realities = c(1,3,6,7,6,3,1))

