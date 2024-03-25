
setwd(paste0(Sys.getenv('CS_HOME'),'/SimulationModels/Models/tests/Sobol'))

points <- read.csv('sobol.csv')

g=ggplot(points,aes(x=x1,y=x2))
g+geom_point(size=0.3)+facet_wrap(~sampling)+stdtheme
ggsave(file='sobol.png',width=20,height=20,units='cm')


###
# values of discrepancies


library(DiceDesign)

all <- read.csv('sobol_repets.csv')

#test = all %>% group_by(repet,samples,sampling) %>% summarize(count=n())

#discrs = all %>% group_by(repet,samples,sampling) %>% mutate(d=discrepancyCriteria(data.frame(x1,x2),type=c('all'))) %>% 
#  summarise(C2 = d$DisC2, L2 = d$DisL2, L2star = d$DisL2star, M2 = d$DisM2, S2 = d$DisS2, W2 = d$DisW2, Mix2 = d$DisMix2)
# ! mutate does not work with list output? 

res=data.frame()
for(rep in unique(all$repet)){
  for(n in unique(all$samples)){
    for(type in unique(all$sampling)){
      show(paste0("rep=",rep,", n=",n,",type=",type))
      d=discrepancyCriteria(all[all$repet==rep&all$samples==n&all$sampling==type,c("x1","x2")],type=c('all'))
      res=rbind(res,c("repet"=rep,"samples"=n,"sampling"=type,
                      "C2" = d$DisC2, "L2" = d$DisL2, "L2star" = d$DisL2star, "M2" = d$DisM2, "S2" = d$DisS2, "W2" = d$DisW2, "Mix2" = d$DisMix2)
                )
    }
  }
}

names(res) <- c("repet", "samples", "sampling", "C2", "L2", "L2star", "M2", "S2", "W2", "Mix2")
discrs = as_tibble(res)

dtypes = c("C2", "L2", "L2star", "M2", "S2", "W2", "Mix2")
for(dtype in dtypes){discrs[,dtype]=as.numeric(unlist(discrs[,dtype]))}
discrs[,"samples"]=as.numeric(unlist(discrs[,"samples"]))

save(discrs,file='discrs.RData')

#g=ggplot(discrs,aes(x=samples,y=d,group=sampling,color=sampling))
#g+geom_point(pch='.')+geom_smooth()
#g+geom_point()

sdiscrs = discrs %>% group_by(sampling,samples) %>% summarise(
  sdC2=sd(C2),C2=mean(C2),
  sdL2=sd(L2),L2=mean(L2),
  sdL2star=sd(L2star),L2star=mean(L2star),
  sdM2=sd(M2),M2=mean(M2),
  sdS2=sd(S2),S2=mean(S2),
  sdW2=sd(W2),W2=mean(W2),
  sdMix2=sd(Mix2),Mix2=mean(Mix2)
)

#g=ggplot(sdiscrs,aes(x=samples,y=L2,color=sampling,group=sampling))
#g+geom_point()+geom_line()+geom_errorbar(aes(ymin=discr-sdDiscr,ymax=discr+sdDiscr))
#ggsave(file='discrepancies.png',width=20,height=18,units='cm')



for(dtype in dtypes){
  g=ggplot(sdiscrs,aes_string(x="samples",y=dtype,color="sampling",group="sampling"))
  g+geom_point()+geom_line()+geom_errorbar(aes_string(ymin=paste0(dtype," - sd",dtype),ymax=paste0(dtype," + sd",dtype)))
  ggsave(file=paste0('discrepancies/',dtype,'.png'),width=20,height=18,units='cm')
}

