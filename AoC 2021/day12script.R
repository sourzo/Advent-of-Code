library(stringr)
library(rje)
library(tibble)
library(tidyr)

input12<-as.data.frame(readLines("C:/Users/Zoe/Documents/R Scripts/Adventofcode2021/day12test2.txt"))
input12<-tidyr::separate(input12,1,sep="-",into=c("cave1","cave2"))

#get list of all caves and their neighbours----
#this will be a list of 3-lists 
#each 3-list contains a named cave; a vector of its neighbours; and whether it has been visited

#list of every cave in the system
list_caves<-unique(c(input12$cave1,input12$cave2))

#List of neighbours for each cave
cave_neighbours<-list()
for (cave in 1:length(list_caves)){
  neighbours<-c()
  for (rows in 1:nrow(input12)){
    if (input12[rows,1] == list_caves[[cave]]){
      neighbours <- c(neighbours,input12[rows,2])
    }
    if (input12[rows,2] == list_caves[[cave]]){
      neighbours <- c(neighbours,input12[rows,1])
    }
  }
  cave_neighbours[[list_caves[[cave]] ]] <- neighbours
}

#indicates whether a cave has been visited
#value of zero if unvisited
cave_visited<-list()
for (cave in 1:length(list_caves)){
    cave_visited[[list_caves[[cave]] ]] <- 0
}

#Path----
#identify current cave
current_cave<-"start"
#mark small cave as visited
if (str_detect(current_cave,"[[:lower:]]")){cave_visited[[current_cave]]<-1}
#record in path
path<-c(current_cave)
#identify next cave - not small cave already visited
if (cave_visited[[cave_neighbours[[current_cave]][1]]] == 1) {
  cave_neighbours[[current_cave]]<-cave_neighbours[[current_cave]][-1]
}
next_cave<-cave_neighbours[[current_cave]][1]

if (str_detect(next_cave,"[[:lower:]]") && cave_visited[[next_cave]] == 1){
  
}
#move to next cave

path<-c(path,cave_neighbours[[current_cave]][1])
cave_neighbours[[current_cave]]<-cave_neighbours[[current_cave]][-1]
cave_neighbours[[current_cave]]
#----

#lists whether a cave has been visited
visited<-c()

#This function checks if a small cave has been visited
checkVisited<-function(cavename){
  is.subset(cavename,visited) && str_detect(cavename,"[[:lower:]]")
}

current_cave<-"start"
#find next cave(s)
for (row in 1:nrow(input12)){
  if (input12[row,1] == current_cave){
    next_cave<-input12[row,2]}
  if (input12[row,2] == current_cave){
    next_cave<-input12[row,1]}
}




