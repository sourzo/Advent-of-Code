##Get data and tidy
input6<- read.table("C:/Users/Zoe/Documents/R Scripts/Adventofcode2021/day6.txt",              # TXT data file indicated as string or full path to the file
                    header = FALSE,    # Whether to display the header (TRUE) or not (FALSE)
                    sep = ",")          # Separator of the columns of the file

fish_database<-as.data.frame(t(input6))

fish_counters<-t(input6)

#how many fish after 80 days
for (day in 1:80){
  for (fish in 1:length(fish_counters)){
    if (fish_counters[fish]>0) {
      fish_counters[fish]<-fish_counters[fish]-1
    }
    else {
      fish_counters[fish]<-6
      fish_counters[length(fish_counters)+1]<-8
    }
  }
}
length(fish_counters)

#for 256 days this takes too long to compute

get_day0<-as.data.frame(table(t(input6)))
names(get_day0)<-c("phase", "number_of_fish")

#CHECK ROWS FIRST
all_phases<-as.data.frame(c(0:8))
names(all_phases)<-c("phase")
#put all data frames into list
df_list <- list(all_phases, get_day0) 
#merge all data frames together
fish_database<- Reduce(function(x, y) merge(x, y, all=TRUE), df_list) 
fish_database[is.na(fish_database$number_of_fish),2]<-0

#Iterate
for (day in 1:256){
  #renumber
  fish_database[1,1]<-8 #make baby fish (do doo do doo do do)
  fish_database[2,1]<-0
  fish_database[3,1]<-1
  fish_database[4,1]<-2
  fish_database[5,1]<-3
  fish_database[6,1]<-4
  fish_database[7,1]<-5
  fish_database[8,1]<-6
  fish_database[9,1]<-7
  #move post-pregnant fish
  fish_database[8,2]<-fish_database[8,2] + fish_database[1,2]
  #Get rows in correct order, 0-8
  fish_database<-fish_database[order(fish_database$phase), ]
}
total<-sum(fish_database$number_of_fish)
total
