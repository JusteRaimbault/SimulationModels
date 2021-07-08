
setwd(paste0(Sys.getenv('CS_HOME'),'/SimulationModels/Models/OSE'))

library(ggplot2)
library(dplyr)

res <- as.tbl(read.csv(paste0(Sys.getenv('CS_HOME'),'/NoisyEA/Models/mgo/test/ose.csv'),header = F))


#ggplot(res,aes(x=V1,y=V2,color=V3))+geom_point()

ggplot(res,aes(x=V1,y=V2))+geom_point()


f <- function(x){
x1= x[1];x2 = x[2]
a = 5 / 2 * (x1 + 1 / 5)^2.0 + 5 / 4 * x2 * x2
b = 5 * (x1 - 3 / 5)^2.0 + (x2 + 3 / 20)^2.0
c = 1 / 100 * (x1 * x1 + (x2 - 11 / 10)^2.0)
d = (x1 - 1.0)^2.0 + 10 * (x2 - 1.0)^2.0
e = 5 * (50 * (x2 - x1 * x1)^2.0 + (1 - x1)^2.0)
h = (x1 + 7 / 10)^2.0
l = 5 * (x2 - 0.5)^2.0
f0loc = c * d * (e * h + l)
return(a * b * log(1 + f0loc))
}

apply(res[,1:2],1,f)
