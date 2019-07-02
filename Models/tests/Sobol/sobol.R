
setwd(paste0(Sys.getenv('CS_HOME'),'/SimulationModels/Models/tests/Sobol'))

points <- read.csv('sobol.csv')

g=ggplot(points,aes(x=x1,y=x2))
g+geom_point(size=0.3)+facet_wrap(~sampling)+stdtheme
ggsave(file='sobol.png',width=20,height=20,units='cm')


###
# values of discrepancies


library(DiceDesign)

all <- read.csv('sobol_repets.csv')

discrs = all %>% group_by(repet,samples,sampling) %>% summarize(d=discrepancyCriteria(data.frame(x1,x2),type=c('L2'))$DisL2)
#test = all %>% group_by(repet,samples,sampling) %>% summarize(count=n())
save(discrs,file='discrs.RData')

#g=ggplot(discrs,aes(x=samples,y=d,group=sampling,color=sampling))
#g+geom_point(pch='.')+geom_smooth()
#g+geom_point()

sdiscrs = discrs %>% group_by(sampling,samples) %>% summarize(sdDiscr=sd(d),discr=mean(d))

g=ggplot(sdiscrs,aes(x=samples,y=discr,color=sampling,group=sampling))
g+geom_point()+geom_line()+geom_errorbar(aes(ymin=discr-sdDiscr,ymax=discr+sdDiscr))
ggsave(file='discrepancies.png',width=20,height=18,units='cm')


