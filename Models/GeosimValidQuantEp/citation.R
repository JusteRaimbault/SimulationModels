setwd(paste0(Sys.getenv('CS_HOME'),'/SimulationModels/Models/GeosimvalidQuantEp'))

library(dplyr,warn.conflicts = F)
library(igraph)
library(ggplot2)

source(paste0(Sys.getenv('CS_HOME'),'/Organisation/Models/Utils/R/plots.R'))
source('functions.R')

edge_file = 'data/corpus_links.csv'
node_file = 'data/corpus.csv'

edges <- read.csv(edge_file,sep=";",header=F,colClasses = c('character','character'))
nodes <- as_tibble(read.csv(node_file,sep=";",stringsAsFactors = F,quote = '"',colClasses = rep('character',6)))

nodes[,6]=as.numeric(unlist(nodes[,6]))
kws = names(nodes)[6]

citation <- graph_from_data_frame(edges,vertices = nodes)
citation = induced_subgraph(citation,which(components(citation)$membership==1))

citationcorehigher = induced_subgraph(citation,which(degree(citation)>1))
while(length(which(degree(citationcorehigher)==1))>0){citationcorehigher = induced_subgraph(citationcorehigher,which(degree(citationcorehigher)>1))}

export_gml(citationcorehigher,'data/core.gml')

