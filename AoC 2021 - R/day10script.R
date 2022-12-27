library(stringr)
library(stringi)

input10<-readLines("C:/Users/Zoe/Documents/R Scripts/Adventofcode2021/day10test.txt")

stringVector<-input10

#iteratively remove pairs (), [], {}, <> until no more pairs can be found
#need old and stringVector to be different for the loop, so start it outside the loop
old<-stringVector
stringVector<-str_replace_all(stringVector,"\\(\\)|\\[\\]|\\{\\}|<>","")

#This loops while there is a change after removing pairs (), [], {}, <>
while (!setequal(old, stringVector)){
  old<-stringVector
  stringVector<-str_replace_all(stringVector,"\\(\\)|\\[\\]|\\{\\}|<>","")
}

#remove opening brackets to reveal errors
find_corruptions<-str_replace_all(stringVector,"\\(|\\[|\\{|<","")

#then translate the errors into scores
#Count the first error for the score
scores<-c()

for (strings in 1:length(find_corruptions)){
  scores[strings]<-sum(
    str_starts(find_corruptions[strings],"\\)")*3,
    str_starts(find_corruptions[strings],"\\]")*57,
    str_starts(find_corruptions[strings],"\\}")*1197,
    str_starts(find_corruptions[strings],">")*25137
  )
}

answer1 <- sum(scores)

##Part 2
# Complete the uncorrupted strings which are incomplete

#First: Collect the strings with no closing brackets but at least one opening bracket
#these are the incomplete ones
incomplete_strings<-c()
for (strings in 1:length(stringVector)){
  if (!str_detect(stringVector[strings],"\\)|\\]|\\}|>") && stringVector[strings] != ""){
    incomplete_strings<-c(incomplete_strings,stringVector[strings])
  }
}

#Completing the string is just the mirror image
#reverse the string and score replacements
newscores <- c()
for (strings in 1:length(incomplete_strings)){
  incomplete_strings[strings] <- stri_reverse(incomplete_strings[strings])
  newscores[strings]<-0
  for (chars in 1:str_length(incomplete_strings[strings])){
    newscores[strings] <- 5*newscores[strings]
    if (substr(incomplete_strings[strings],chars,chars) == "(") {newscores[strings] <- newscores[strings] + 1}
    if (substr(incomplete_strings[strings],chars,chars) == "[") {newscores[strings] <- newscores[strings] + 2}
    if (substr(incomplete_strings[strings],chars,chars) == "{") {newscores[strings] <- newscores[strings] + 3}
    if (substr(incomplete_strings[strings],chars,chars) == "<") {newscores[strings] <- newscores[strings] + 4}
  }
}
answer2 <- median(newscores)

