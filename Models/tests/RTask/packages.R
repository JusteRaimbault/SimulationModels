
library(igraph)

packs <- available.packages()
#p = packs[packs[,1]%in%c("igraph","knitr","A3","abc"),c(1,4)]
p=packs[,c(1,4)]

deps = strsplit(p[,2],', ',fixed=T)

edgelist=c()
for(pack in names(deps)){
  if(!is.na(deps[[pack]])){
  for(d in deps[[pack]]){
    edgelist=append(edgelist,c(pack,d))
   }
  }
}

g=graph_from_edgelist(el= matrix(data = edgelist,ncol = 2,byrow = T),directed=T)
plot(g,layout = layout_as_tree)
