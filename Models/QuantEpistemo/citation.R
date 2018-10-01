setwd(paste0(Sys.getenv('CS_HOME'),'/SimulationModels/Models/QuantEpistemo'))

library(dplyr)
library(igraph)


source('functions.R')

#edges <- read.csv('data/citnwdepth3_links.csv',sep=";",header=F,colClasses = c('character','character'))
#nodes <- as.tbl(read.csv('data/citnwdepth3.csv',sep=";",header=F,stringsAsFactors = F,colClasses = c('character','character','character')))
#edges <- read.csv('data/corpusreq_openmole_citnw_links.csv',sep=";",header=F,colClasses = c('character','character'))
#nodes <- as.tbl(read.csv('data/corpusreq_openmole_citnw.csv',sep=";",header=F,stringsAsFactors = F,colClasses = c('character','character','character')))
edges <- read.csv('data/corpusreq_citnw_links.csv',sep=";",header=F,colClasses = c('character','character'))
nodes <- as.tbl(read.csv('data/corpusreq_citnw.csv',sep=";",header=F,stringsAsFactors = F,colClasses = c('character','character','character')))


names(nodes)<-c("title","id","year")

elabels = unique(c(edges$V1,edges$V2))
empty=rep("",length(which(!elabels%in%nodes$id)))
nodes=rbind(nodes,data.frame(title=empty,id=elabels[!elabels%in%nodes$id],year=empty))#,abstract=empty,authors=empty))

citation <- graph_from_data_frame(edges,vertices = nodes[,c(2,1,3)])#3:7)])
components(citation)$csize

citation = induced_subgraph(citation,which(components(citation)$membership==1))

V(citation)$reduced_title = sapply(V(citation)$title,function(s){paste0(substr(s,1,50),"...")})
V(citation)$reduced_title = ifelse(degree(citation)>20,V(citation)$reduced_title,rep("",vcount(citation)))

citationcore = induced_subgraph(citation,which(degree(citation)>1))

citationcorehigher = citationcore
while(length(which(degree(citationcorehigher)==1))>0){citationcorehigher = induced_subgraph(citationcorehigher,which(degree(citationcorehigher)>1))}

# sample
set.seed(0)
sampled = induced.subgraph(citationcorehigher,vids = sample(1:length(V(citationcorehigher)),50000))
comps = components(sampled)
sampled = induced_subgraph(sampled,which(comps$membership==which(comps$csize==max(comps$csize))))

#write_graph(citationcore,file='data/core.gml',format = 'gml')
#write_graph(citationcore,file='data/corpusreq_openmole_core.gml',format = 'gml')
#write_graph(citationcorehigher,file='data/corehigher.gml',format = 'gml')
#write_graph(citationcore,file='data/corpusreq_core.gml',format = 'gml')
#write_graph(citationcorehigher,file='data/corpusreq_corehigher.gml',format = 'gml')
write_graph(sampled,file='data/corpusreq_corehigher_sampled.gml',format = 'gml')


# density
ecount(citationcore)/(vcount(citationcore)*(vcount(citationcore)-1))

# mean degrees
mean(degree(citation))
mean(degree(citation,mode = 'in'))
mean(degree(citationcore,mode = 'in'))



# modularity / vs null model
A=as_adjacency_matrix(citationcore,sparse = T)
M = A+t(A)
undirected_rawcore = graph_from_adjacency_matrix(M,mode="undirected")

# communities
com = cluster_louvain(undirected_rawcore)

directedmodularity(com$membership,A)

nreps = 100
mods = c()
for(i in 1:nreps){
  show(i)
  mods=append(mods,directedmodularity(com$membership,A[sample.int(nrow(A),nrow(A),replace = F),sample.int(ncol(A),ncol(A),replace = F)]))
}

show(paste0(mean(mods)," +- ",sd(mods)))


d=degree(citationcore,mode='in')
for(c in unique(com$membership)){
  show(paste0("Community ",c, " ; corpus prop ",length(which(com$membership==c))/vcount(undirected_rawcore)))
  #show(paste0("Size ",length(which(com$membership==c))))
  currentd=d[com$membership==c];dth=sort(currentd,decreasing = T)[10]
  show(data.frame(titles=V(citationcore)$title[com$membership==c&d>dth],degree=d[com$membership==c&d>dth]))
  #show(V(rawcore)$title[com$membership==c])
}


