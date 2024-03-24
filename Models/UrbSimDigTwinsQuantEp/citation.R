setwd(paste0(Sys.getenv('CS_HOME'),'/SimulationModels/Models/DigTwinsQuantEp'))

library(dplyr)
library(igraph)
library(glue)
library(reshape2)
library(ggplot2)
library(heatmaply)

source(paste0(Sys.getenv('CS_HOME'),'/Organisation/Models/Utils/R/plots.R'))
source('functions.R')


edge_file = 'data/corpus_links.csv'
node_file = 'data/corpus.csv'

edges <- read.csv(edge_file,sep=";",header=F,colClasses = c('character','character'))
nodes <- as_tibble(read.csv(node_file,sep=";",stringsAsFactors = F,quote = '"',colClasses = rep('character',6)))

nodes[,6]=as.numeric(unlist(nodes[,6]))
kws = names(nodes)[6]

# remove edges which have been filtered
#edges = edges[edges$V1%in%nodes$id&edges$V2%in%nodes$id,]
# -> not needed, no filter here

# horiz depth, not needed (only one origin)
#nodes = cbind(nodes,numHorizontalDepth=apply(nodes[,6:20],1,function(r){min(r,na.rm=T)}))
#nodes = nodes[is.finite(nodes$numHorizontalDepth),]

citation <- graph_from_data_frame(edges,vertices = nodes)

# connected components
components(citation)$csize

#for(kw in kws){show(summary(attr(V(citation),kw)))}

citation = induced_subgraph(citation,which(components(citation)$membership==1))

#V(citation)$reduced_title = sapply(V(citation)$title,function(s){paste0(substr(s,1,30),"...")})
#V(citation)$reduced_title = ifelse(degree(citation)>50,V(citation)$reduced_title,rep("",vcount(citation)))

citationcorehigher = induced_subgraph(citation,which(degree(citation)>1))
while(length(which(degree(citationcorehigher)==1))>0){citationcorehigher = induced_subgraph(citationcorehigher,which(degree(citationcorehigher)>1))}

# csv export
export_gml(citationcorehigher,'processed/core.gml')
save(citationcorehigher,file='processed/core.RData')
save(citation,file='processed/full.RData')



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

#save(com,file='processed/core_coms.RData')

d=degree(citationcorehigher,mode='in')
for(c in unique(com$membership)){
  show(paste0("Community ",c, " ; corpus prop ",100*length(which(com$membership==c))/vcount(undirected_core)))
  currentd=d[com$membership==c];dth=sort(currentd,decreasing = T)[10]
  show(data.frame(titles=V(citationcorehigher)$title[com$membership==c&d>dth],degree=d[com$membership==c&d>dth]))
  #show(V(rawcore)$title[com$membership==c])
}

# expert knowledge naming

citcomnames = list(''='')

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








