
setwd(paste0(Sys.getenv('CS_HOME'),'/SimulationModels/Models/tests/Sobol'))

points <- read.csv('sobol.csv')

g=ggplot(points,aes(x=x1,y=x2))
g+geom_point()+facet_wrap(~sampling)+stdtheme
ggsave(file='sobol.png',width=58,height=20,units='cm')
