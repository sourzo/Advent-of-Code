library(stringr)
input14 <- as.data.frame(readLines("C:/Users/Zoe/Documents/R Scripts/Adventofcode2021/day14.txt"))
polymer_template<-as.vector(input14[1,])

#pair insertion rules
pir <- as.data.frame(input14[3:nrow(input14),])
pir <- tidyr::separate(pir,1,sep=" -> ",into=c("pair","insert"))
pir$p1 <- substr(pir$pair,1,1)
pir$p2 <- substr(pir$pair,2,2)
pir$outcome <- paste0(pir$p1,pir$insert,pir$p2)
pir$o1<-substr(pir$outcome,1,2)
pir$o2<-substr(pir$outcome,2,3)

pir$p1<-NULL
pir$p2<-NULL
pir$insert<-NULL

#part 1----
apply_rules<-function(stringg){
  for (letterpos in (str_length(polymer_template)-1):1){
    for (rule in 1:nrow(pir)){
      if (substr(polymer_template,letterpos, letterpos+1) == pir[rule,"pair"]){
        new_template<-paste0(substr(polymer_template,1, letterpos-1),pir[rule,"outcome"],substr(polymer_template,letterpos+2,str_length(polymer_template)))
        polymer_template<-new_template
        break
      }
    }
  }
  return(polymer_template)
}
for (repeats in 1:4){
  polymer_template<-apply_rules(polymer_template)
}
counts<-table(unlist(strsplit(polymer_template, ""), use.names=FALSE))
max(counts)-min(counts)

#part 2----
polymer_template<-as.vector(input14[1,])

#pair insertion rules
pir <- as.data.frame(input14[3:nrow(input14),])
pir <- tidyr::separate(pir,1,sep=" -> ",into=c("pair","insert"))
pir$p1 <- substr(pir$pair,1,1)
pir$p2 <- substr(pir$pair,2,2)
pir$outcome <- paste0(pir$p1,pir$insert,pir$p2)
pir$o1<-substr(pir$outcome,1,2)
pir$o2<-substr(pir$outcome,2,3)

pir$p1<-NULL
pir$p2<-NULL
pir$insert<-NULL
pir$outcome<-NULL

#initial count of bigrams
pir$count<-0
for (letterpos in (str_length(polymer_template)-1):1){
  for (rule in 1:nrow(pir)){
    if (substr(polymer_template,letterpos, letterpos+1) == pir[rule,"pair"]){
      pir[rule,"count"]<-pir[rule,"count"]+1
    }
  }
}

#multiply the bigrams
for (repeats in 1:40){
  pir$newcount <- 0
  #each bigram in "pairs"
  for (bigram in 1:nrow(pir)){
    bicount <- 0
    for (row in 1:nrow(pir)){
      if (pir[row,"o1"]==pir[bigram,"pair"]){
        bicount <- bicount + pir[row,"count"]
      }
      if (pir[row,"o2"]==pir[bigram,"pair"]){
        bicount <- bicount + pir[row,"count"]
      }
    }
    pir[bigram,"newcount"]<-bicount
  }
  pir$count <- pir$newcount
}

#need to count the letters, not the bigrams
pir$l1<-substr(pir$pair,1,1)
pir$l2<-substr(pir$pair,2,2)
letters<-unique(c(pir$l1,pir$l2))
count_letters<-list()
for (each in 1:length(letters)){
  lettercount<-0
  for (rows in 1:nrow(pir)){
    if (pir[rows,"l1"]==letters[each]){
      lettercount <- lettercount + pir[rows,"count"]
    }
    if (pir[rows,"l2"]==letters[each]){
      lettercount <- lettercount + pir[rows,"count"]
    }
  }
  count_letters[letters[each]]<-lettercount
}
#count_letters$S<-count_letters$S + 1
#count_letters$V<-count_letters$V + 1
count_letters$N<-count_letters$N + 1
count_letters$B<-count_letters$B + 1
list_values<-c()
for (things in 1:length(count_letters)){
  list_values<-c(list_values,count_letters[[things]]<-(count_letters[[things]])/2)
  print(count_letters)[things]
}
print(max(list_values)-min(list_values),digits=20)
