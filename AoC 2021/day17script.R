# example input: target area: x=20..30, y=-10..-5
# puzzle input: target area: x=137..171, y=-98..-73
target_x_min <- 137
target_x_max <- 171
target_y_min <- -98
target_y_max <- -73

#x = forward
#y = up/down
#y_velocity = y_mag*y_direction

#initial conditions
x_direction<-1
x_mag<-17
if (x_mag*(x_mag+1)/2<target_x_min){
  print("this will fall short")
} else {
  x_velocity = x_mag*x_direction
  u_0<-x_velocity
  
  y_velocity<-97
  v_0<-y_velocity
  max_height<-y_velocity*(y_velocity+1)/2
  #check if y_velocity is too fast when x=0
  if (y_velocity+1>abs(target_y_min)){
    print("too fast, try lower y-velocity")
  } else {
    
    x_pos<-0
    y_pos<-0
    
    #at each step:
    while (all(x_pos<target_x_max,
               y_pos>target_y_min)){
      x_pos <- x_pos + x_velocity
      y_pos <- y_pos + y_velocity
      print(c(x_pos,y_pos))
      if (all(x_pos >= target_x_min,
              x_pos <= target_x_max,
              y_pos >= target_y_min,
              y_pos <= target_y_max)){
        print("success!")
      }
      if (x_mag != 0){
        x_mag <- x_mag - 1
        x_velocity <- x_mag*x_direction
      }
      y_velocity <- y_velocity - 1
    }
  }
}
