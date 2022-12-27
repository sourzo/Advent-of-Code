library(stringr)
library(rje)
library(tibble)
library(tidyr)

input12<-as.data.frame(readLines("C:/Users/Zoe/Documents/R Scripts/Adventofcode2021/day12test2.txt"))
input12<-tidyr::separate(input12,1,sep="-",into=c("cave1","cave2"))

#setup----

#list of every cave in the system
list_caves<-unique(c(input12$cave1,input12$cave2))

#List of unvisited neighbours for each cave
#currently all neighbours
unvisited_neighbours<-list()
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
  unvisited_neighbours[[list_caves[[cave]] ]] <- neighbours
}

#List of visited neighbours for each cave
#currently no neighbours
visited_neighbours<-list()
for (cave in 1:length(list_caves)){
  visited_neighbours[[list_caves[[cave]] ]] <- c()
}

path<-list()
visited_small_caves<-c()
path_count<-0

#start the search----

#identify current cave
current_cave<-"start"
#if it is a small cave then cannot revisit
if (str_detect(current_cave,"[[:lower:]]")){
  visited_small_caves<-c(visited_small_caves,current_cave)
}

#add current cave to path
path<-c(path,current_cave)

#find a path to end
while (current_cave != "end"){
  #identify next available cave
  next_cave<-unvisited_neighbours[[current_cave]][1]
  
  #move into the next cave
  #small caves which have already been visited cannot be revisited
  #otherwise move into that cave
  if (next_cave%in%visited_small_caves){
    #add to visited neighbours
    visited_neighbours[[current_cave]]<-c(visited_neighbours[[current_cave]],
                                          next_cave)
    #remove from unvisited neighbours
    unvisited_neighbours[[current_cave]]<-unvisited_neighbours[[current_cave]][2:length(unvisited_neighbours[[current_cave]])]
  } else {
    #add to visited neighbours
    visited_neighbours[[current_cave]]<-c(visited_neighbours[[current_cave]],
                                          next_cave)
    #remove from unvisited neighbours
    unvisited_neighbours[[current_cave]]<-unvisited_neighbours[[current_cave]][2:length(unvisited_neighbours[[current_cave]])]
    
    #move to next cave
    current_cave<-next_cave
    #if it is a small cave then add to visited small caves list
    if (str_detect(current_cave,"[[:lower:]]")){
      visited_small_caves<-c(visited_small_caves,current_cave)
    }
    path<-c(path,current_cave)
    if (current_cave=="end"){
      path_count<-path_count+1
    }
  }
}

#Backtracking----
path<-path[1:(length(path)-1)]
#then continue path search