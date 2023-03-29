setwd(paste0(Sys.getenv('CS_HOME'),'/QuantEpistemo/Models/UKMigration'))

library(dplyr)
library(igraph)
library(glue)
library(reshape2)
library(ggplot2)
library(heatmaply)

source(paste0(Sys.getenv('CS_HOME'),'/Organisation/Models/Utils/R/plots.R'))
source('functions.R')


edge_file = 'export/corpus_filteredNonExcl_links.csv'
node_file = 'export/corpus_filteredNonExcl.csv'

edges <- read.csv(edge_file,sep=";",header=F,colClasses = c('character','character'))
nodes <- as.tbl(read.csv(node_file,sep=";",stringsAsFactors = F,quote = '"',colClasses = rep('character',9)))


# numeric hdepth values (incl. NA)
nodes = nodes[,-18] # remove filtered column
for(j in 6:20){nodes[,j]=as.numeric(unlist(nodes[,j]))}
kws = names(nodes)[6:20]

# remove edges which have been filtered
edges = edges[edges$V1%in%nodes$id&edges$V2%in%nodes$id,]

nodes = cbind(nodes,numHorizontalDepth=apply(nodes[,6:20],1,function(r){min(r,na.rm=T)}))
nodes = nodes[is.finite(nodes$numHorizontalDepth),]

citation <- graph_from_data_frame(edges,vertices = nodes)

# connected components
components(citation)$csize

for(kw in kws){show(summary(attr(V(citation),kw)))}

citation = induced_subgraph(citation,which(components(citation)$membership==1))

#V(citation)$reduced_title = sapply(V(citation)$title,function(s){paste0(substr(s,1,30),"...")})
#V(citation)$reduced_title = ifelse(degree(citation)>50,V(citation)$reduced_title,rep("",vcount(citation)))

citationcorehigher = induced_subgraph(citation,which(degree(citation)>1))
while(length(which(degree(citationcorehigher)==1))>0){citationcorehigher = induced_subgraph(citationcorehigher,which(degree(citationcorehigher)>1))}

# csv export
export_gml(citationcorehigher,'processed/core.gml')
save(citationcorehigher,file='processed/core.RData')
save(citation,file='processed/full.RData')

# export subgraphs ?
#coreai = induced_subgraph(citationcorehigher,!is.na(V(citationcorehigher)$ai))
#corealife = induced_subgraph(citationcorehigher,!is.na(V(citationcorehigher)$artificial_life))
#export_gml(coreai,'processed/coreai.gml')
#export_gml(corealife,'processed/corealife.gml')

#########
load('processed/core.RData')

#######
## modularity / communities

A=as_adjacency_matrix(citationcorehigher,sparse = T)
M = A+t(A)
undirected_core = graph_from_adjacency_matrix(M,mode="undirected")

# communities
set.seed(666)

com = cluster_louvain(undirected_core)
directedmodularity(com$membership,A)

save(com,file='processed/core_coms.RData')

d=degree(citationcorehigher,mode='in')
for(c in unique(com$membership)){
  show(paste0("Community ",c, " ; corpus prop ",length(which(com$membership==c))/vcount(undirected_core)))
  currentd=d[com$membership==c];dth=sort(currentd,decreasing = T)[10]
  show(data.frame(titles=V(citationcorehigher)$title[com$membership==c&d>dth],degree=d[com$membership==c&d>dth]))
  #show(V(rawcore)$title[com$membership==c])
}

# expert knowledge naming

citcomnames = list('31'='Real-time mapping','15'='Traffic control','9'='Flying UAV',
                   '12'='Remote sensing','10'='Traffic forecasting','11'='Traffic safety',
                   '30'='Transit planning','1'='Fuzzy cognitive maps',
                   '22'='Rescue robots','24'='Autonomous vehicles','26'='Complexity/ABM',
                   '20'='Art/Culture','3'='Natural hazards', # landslides
                   '23'='Computer vision','29'='Lidar mapping','7'='Rainfall',
                   '18'='Smart cities','6'='Game theory','5'='Living architecture',
                   '8'='3D Modeling','17'='Urbanism','13'='Air pollution',
                   '14'='Urban growth/CA','32'='Crowd simulation','21'='GIS',
                   '27'='Social intelligence','28'='Image capture', # noise
                   '4'='Flooding','33'='Biology', # noise
                   '16'='Self-organization','25'='Bio-inspired computing',
                   '19'='Power line detection',
                   '2'='Computer vision' # noise
                   )

# size distrib
comsizes=list()
for(k in names(citcomnames)){comsizes[k]=length(which(com$membership==as.numeric(k)))}
comsizes=unlist(comsizes)
#table(unlist(comsizes))
length(which(comsizes>500))

#library(poweRlaw)
#d = displ$new(comsizes)
#d$setXmin(estimate_xmin(d))
#estimate_pars(d)

plot(log(1:length(comsizes)),log(sort(comsizes,decreasing = T)))
cumsum(sort(comsizes/sum(comsizes)))
summary(lm(data=data.frame(y=log(sort(comsizes[comsizes>500],decreasing = T)),x=log(1:length(comsizes[comsizes>500]))),y~x))


# most important communities
# 2000 -> 10 largest communities

d=degree(citationcorehigher,mode='in')
for(k in names(sort(comsizes[comsizes>2000],decreasing = T))){
  show(paste0(k," ; ",citcomnames[k]," ; ",100*length(which(com$membership==k))/vcount(undirected_core)))
  currentd=d[com$membership==k];dth=sort(currentd,decreasing = T)[10]
  show(data.frame(titles=V(citationcorehigher)$title[com$membership==k&d>dth],degree=d[com$membership==k&d>dth]))
}

largestcoms = names(sort(comsizes[comsizes>2000],decreasing = T))



#####
# same for alife only

A=as_adjacency_matrix(corealife,sparse = T)
M = A+t(A)
undirected_corealife = graph_from_adjacency_matrix(M,mode="undirected")

# communities
set.seed(666)
comalife = cluster_louvain(undirected_corealife)
directedmodularity(comalife$membership,A)

save(comalife,file='processed/coms_alilfe.RData')

d=degree(corealife,mode='in')
for(c in unique(comalife$membership)){
  show(paste0("Community ",c, " ; corpus prop ",length(which(comalife$membership==c))/vcount(undirected_corealife)))
  currentd=d[comalife$membership==c];dth=sort(currentd,decreasing = T)[min(5,length(currentd))]
  show(data.frame(titles=V(corealife)$title[comalife$membership==c&d>=dth],degree=d[comalife$membership==c&d>=dth]))
  #show(V(rawcore)$title[com$membership==c])
}

# expert knowledge naming

citcomnames_alife = list('7'='Flying UAV','30'='Autonomous vehicles','20'='Complexity',
                   '26'='Culture','10'='Rescue robots','31'='Remote sensing',
                   '11'='Living architecture','6'='Urban desing',
                   '15'='Cellular automata','12'='Crowd behavior','42'='Traffic control',
                   '24'='Urbanism','38'='Social intelligence',
                   '14'='Traffic forecasting','4'='Art',
                   '37'='Climate modeling','36'='Transportation/Ant Colony Optimization',
                   '43'='GIS','44'='Transport geography',
                   '27'='Urban planning','39'='Augmented reality',
                   '8'='Smart cities','40'='Agriculture',
                   '22'='Spatial analysis','23'='Organic computing',
                   '32'='Power line detection','16'='Traffic modeling',
                   '35'='Planning history','33'='Artificial societies',
                   '17'='Bio-inspired computing','21'='Road mapping',
                   '18'='Chinese','25'='Health','28'='Rainfall',
                   '34'='ABM','41'='Flooding','2'='VGI',
                   '29'='Pedestrian crossing',#noise
                   '19'='AV-pedestrian interaction',#noise
                   '9'='Procedural modeling',
                   '3'='Fractals','1'='Noise','5'='Noise','13'='Noise'
)

comsizes_alife=list()
for(k in names(citcomnames_alife)){comsizes_alife[k]=length(which(comalife$membership==as.numeric(k)))}
comsizes_alife=unlist(comsizes_alife)

plot(log(1:length(comsizes_alife)),log(sort(comsizes_alife,decreasing = T)))
cumsum(sort(comsizes_alife/sum(comsizes_alife)))
summary(lm(data=data.frame(y=log(sort(comsizes_alife[comsizes_alife>400],decreasing = T)),x=log(1:length(comsizes_alife[comsizes_alife>400]))),y~x))

d=degree(corealife)
for(k in names(sort(comsizes_alife[comsizes_alife>400],decreasing = T))){
  show(paste0(k," ; ",citcomnames_alife[k]," ; ",100*length(which(comalife$membership==k))/vcount(corealife)))
  currentd=d[comalife$membership==k];dth=sort(currentd,decreasing = T)[min(5,length(currentd))]#max(currentd)
  #show(data.frame(titles=V(corealife)$title[comalife$membership==k&d>=dth],degree=d[comalife$membership==k&d>=dth]))
  show(data.frame(titles=V(corealife)$title[comalife$membership==k&d>=dth],degree=d[comalife$membership==k&d>=dth]))
}

largestcoms_alife = names(sort(comsizes_alife[comsizes_alife>700],decreasing = T))


resdir=paste0(Sys.getenv('CS_HOME'),'/UrbanEvolution/Results/QuantEpistemo/')

#####
## relation matrix between communities

# proportion of outlinks in each other com

lp = getLogCitationFlows(citationcorehigher,com,largestcoms,citcomnames)

heatmaply(lp,plot_method = "ggplot"#,
          #file='../../Results/QuantEpistemo/citation_all.png'
          )
# export by hand - does plotly export does not work
# -> screen

######
# same for alife

lp = getLogCitationFlows(corealife,comalife,largestcoms_alife,citcomnames_alife)
heatmaply(lp,plot_method = "ggplot")
# idem








