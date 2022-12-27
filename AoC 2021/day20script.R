library(stringr)
input20<-as.data.frame(readLines("day20.txt"))
# .=0,
# #=1.

IEA<-as.vector(input20[1,])
IEA<-str_replace_all(IEA,"#","1")
IEA<-str_replace_all(IEA,"\\.","0")

image<-as.data.frame(input20[3:nrow(input20),])
colnames(image)<-c("col1")
image$col1<-as.character(image$col1)
for (row in 1:nrow(image)){
  image[row,1]<-str_replace_all(image[row,1],"#","1")
  image[row,1]<-str_replace_all(image[row,1],"\\.","0")
  
}

for (enhance in 1:50){print("ENHANCE!")
  if (enhance%%2==0){
    padder="1" #every second iteration
  } else {
    padder="0"
  }
  #pad image with zeros!
  img_width<-str_length(image[1,1])
  #pad top & bottom
  image<-rbind(str_pad("",width=img_width,pad=padder),
               str_pad("",width=img_width,pad=padder),
               image,
               str_pad("",width=img_width,pad=padder),
               str_pad("",width=img_width,pad=padder))
  #pad sides
  for (row in 1:nrow(image)){
    image[row,1]<-str_pad(image[row,1],width=(img_width+4),pad=padder,side="both")
  }
  img_width<-str_length(image[1,1])
  
  
  #create new image
  new_image<-data.frame()
  for (row in 2:(nrow(image)-1)){
    new_string<-""
    for (char_pos in (2:(img_width-1))){
      pixel_dec<-strtoi(paste0(substr(image[(row-1),1],(char_pos-1),(char_pos+1)),
                               substr(image[ row   ,1],(char_pos-1),(char_pos+1)),
                               substr(image[(row+1),1],(char_pos-1),(char_pos+1))),
                        base=2)
      pixel<-substr(IEA,pixel_dec+1,pixel_dec+1)
      new_string<-paste0(new_string,pixel)
    }
    new_image[(row-1),1]<-new_string
  }
  image<-new_image
}

count_lit<-0
for (row in 1:nrow(image)){
  for (char in 1:str_length(image[1,1])){
    if (substr(image[row,1],char,char)=="1"){
      count_lit<-count_lit+1
    }
  }
}
