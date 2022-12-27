#----
#part 1
octomap<- read.table("C:/Users/Zoe/Documents/R Scripts/Adventofcode2021/day11.txt",              # TXT data file indicated as string or full path to the file
                     header = FALSE,    # Whether to display the header (TRUE) or not (FALSE)
                     sep = ",")          # Separator of the columns of the file


#want to count all flashes over all steps
flashcount<- 0

#Step
for (step in 1:100){
  #increase all energy values by 1
  for (octorow in 1:10){
    for (octocol in 1:10){
      octomap[octorow,octocol]<-octomap[octorow,octocol]+1
    }
  }
  
  #if octomap is bigger than 9 then it flashes ONCE
  #- increase surrounding octopuses' energy by 1
  
  #create map of flashes to make sure each octopus flashes at most once
  flashmap<-data.frame(V1=c(rep(0,10)))
  for (flashcol in 1:10){flashmap[,flashcol]<-c(rep(0,10))}
  
  #keep looking for new flashes while there is flash activity
  activity <- 1
  while (activity == 1){
    activity <- 0
    #check each octopus for a flash
    for (octorow in 1:10){
      for (octocol in 1:10){
        if(all(octomap[octorow, octocol]>9, flashmap[octorow, octocol] == 0)){
          # mark flash on flashmap, mark activity
          flashmap[octorow, octocol] <- 1 
          flashcount <- flashcount + 1
          activity <- 1
          #above
          if (octorow>1){
            octomap[(octorow-1),octocol]<-(octomap[(octorow-1),octocol]) + 1
            #above left
            if (octocol>1){
              octomap[(octorow-1),octocol-1]<-(octomap[(octorow-1),octocol-1]) + 1
            }
            #above right
            if (octocol<10){
              octomap[(octorow-1),octocol+1]<-(octomap[(octorow-1),octocol+1]) + 1
            }
          }
          #below
          if (octorow<10){
            octomap[(octorow+1),octocol]<-(octomap[(octorow+1),octocol]) + 1
            #below left
            if (octocol>1){
              octomap[(octorow+1),octocol-1]<-(octomap[(octorow+1),octocol-1]) + 1
            }
            #below right
            if (octocol<10){
              octomap[(octorow+1),octocol+1]<-(octomap[(octorow+1),octocol+1]) + 1
            }
          }
          #left
          if (octocol>1){
            octomap[octorow,octocol-1]<-(octomap[octorow,octocol-1]) + 1
          }
          #right
          if (octocol<10){
            octomap[octorow,octocol+1]<-(octomap[octorow,octocol+1]) + 1
          }
        }#flash activity
      }#octocol
    }#octorow
  }#while loop
  
  #reset flashed octopuses to zero
  for (octorow in 1:10){
    for (octocol in 1:10){
      if (flashmap[octorow, octocol] == 1){
        octomap[octorow, octocol] <- 0
      }
    }
  }
}

#----
#Part 2
octomap<- read.table("C:/Users/Zoe/Documents/R Scripts/Adventofcode2021/day11.txt",              # TXT data file indicated as string or full path to the file
                     header = FALSE,    # Whether to display the header (TRUE) or not (FALSE)
                     sep = ",")          # Separator of the columns of the file


#want to find first step where all octopiddles flash
stepflashcount <- 0
step <- 0

#Step
while (stepflashcount != 100){
  stepflashcount <- 0
  step <- step + 1
  #increase all energy values by 1
  for (octorow in 1:10){
    for (octocol in 1:10){
      octomap[octorow,octocol]<-octomap[octorow,octocol]+1
    }
  }
  
  #if octomap is bigger than 9 then it flashes ONCE
  #- increase surrounding octopuses' energy by 1
  
  #create map of flashes to make sure each octopus flashes at most once
  flashmap<-data.frame(V1=c(rep(0,10)))
  for (flashcol in 1:10){flashmap[,flashcol]<-c(rep(0,10))}
  
  #keep looking for new flashes while there is flash activity
  activity <- 1
  while (activity == 1){
    activity <- 0
    #check each octopus for a flash
    for (octorow in 1:10){
      for (octocol in 1:10){
        if(all(octomap[octorow, octocol]>9, flashmap[octorow, octocol] == 0)){
          # mark flash on flashmap, mark activity
          flashmap[octorow, octocol] <- 1 
          stepflashcount <- stepflashcount + 1
          activity <- 1
          #above
          if (octorow>1){
            octomap[(octorow-1),octocol]<-(octomap[(octorow-1),octocol]) + 1
            #above left
            if (octocol>1){
              octomap[(octorow-1),octocol-1]<-(octomap[(octorow-1),octocol-1]) + 1
            }
            #above right
            if (octocol<10){
              octomap[(octorow-1),octocol+1]<-(octomap[(octorow-1),octocol+1]) + 1
            }
          }
          #below
          if (octorow<10){
            octomap[(octorow+1),octocol]<-(octomap[(octorow+1),octocol]) + 1
            #below left
            if (octocol>1){
              octomap[(octorow+1),octocol-1]<-(octomap[(octorow+1),octocol-1]) + 1
            }
            #below right
            if (octocol<10){
              octomap[(octorow+1),octocol+1]<-(octomap[(octorow+1),octocol+1]) + 1
            }
          }
          #left
          if (octocol>1){
            octomap[octorow,octocol-1]<-(octomap[octorow,octocol-1]) + 1
          }
          #right
          if (octocol<10){
            octomap[octorow,octocol+1]<-(octomap[octorow,octocol+1]) + 1
          }
        }#flash activity
      }#octocol
    }#octorow
  }#while loop
  
  #reset flashed octopuses to zero
  for (octorow in 1:10){
    for (octocol in 1:10){
      if (flashmap[octorow, octocol] == 1){
        octomap[octorow, octocol] <- 0
      }
    }
  }
}