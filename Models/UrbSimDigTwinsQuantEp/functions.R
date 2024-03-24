library(Matrix)



getLogCitationFlows <- function(g,com,comindices,comnames){
  A=as_adjacency_matrix(g,sparse = T)
  citprops = matrix(0,length(comindices),length(comindices))
  for(i in 1:length(comindices)){
    alloutcits = sum(A[com$membership==comindices[i],])
    for(j in 1:length(comindices)){
      show(paste0(i,",",j))
      citprops[i,j] = sum(A[com$membership==comindices[i],com$membership==comindices[j]])/alloutcits
    }
  }
  show(max(citprops))
  show(min(citprops[citprops>0]))
    
  lp=log(citprops)
  lp[is.infinite(lp)]=NA
  lp= (lp - min(lp,na.rm = T)) / (max(lp,na.rm = T) - min(lp,na.rm = T))
  lp[is.na(lp)]=0 # not super clean
  rownames(lp)<-unlist(comnames[as.character(comindices)])
  colnames(lp)<-unlist(comnames[as.character(comindices)])
  return(lp)
}



nwProperties <- function(citnw){
  A=as_adjacency_matrix(citnw,sparse = T)
  M = A+t(A)
  undir_citnw = graph_from_adjacency_matrix(M,mode="undirected")
  coms = cluster_louvain(undir_citnw)
  return(c(
    modularity = modularity(coms),
    #directedModularity = directedmodularity(membership(coms),A), # long to compute and very close to undir
    communitiesnumber = length(unique(membership(coms))),
    avgDegree = mean(degree(citnw,mode = 'all')),
    avgInDegree = mean(degree(citnw,mode = 'in')),
    avgOutDegree = mean(degree(citnw,mode = 'in')),
    alphaDegree = hierarchy(degree(citnw,mode = 'all')),
    alphaInDegree = hierarchy(degree(citnw,mode = 'in')),
    alphaOutDegree = hierarchy(degree(citnw,mode = 'out')),
    ecount = ecount(citnw),
    vcount = vcount(citnw)
  ))
}

export_gml <- function(citnw,exportfile){
  V(citnw)$reduced_title = sapply(V(citnw)$title,function(s){paste0(substr(s,1,50),"...")})
  V(citnw)$reduced_title = ifelse(degree(citnw)>20,V(citnw)$reduced_title,rep("",vcount(citnw)))
  # remove empty attributes
  for(attr in c('depth','citingFilled',kws)){
    citnw = remove.vertex.attribute(citnw,attr)
  }
  write_graph(citnw,file=exportfile,format = 'gml')
}

#'
#' specific export for citnw
export_csv<- function(citation,filedges,filenodes,hdepth){
  write.csv(data.frame(
    from = tail_of(citation,E(citation))$name,
    to = head_of(citation,E(citation))$name
  ),file=filedges
    ,row.names = F,quote=F
  )
  
  nodesdf = data.frame(
    id=V(citation)$name,title=V(citation)$title,lang=V(citation)$lang,year=V(citation)$year,
    depth=V(citation)$depth,horizontalDepth=hdepth
    #priority=V(citation)$priority,
    #horizontalDepth=V(citation)$horizontalDepth, # not needed - temporary variable
    #,citingFilled=V(citation)$citingFilled
  )
  for(kw in kws){nodesdf = cbind(nodesdf,get.vertex.attribute(citation,kw))}
  names(nodesdf)[7:length(nodesdf)]=kws
  
  write.csv(
    nodesdf
    ,file=filenodes,row.names = F
  )
  
}



hierarchy <- function(x){
  xx = x[!is.na(x)&x>0]
  reg = lm(data = data.frame(rank = log(1:length(xx)),val=log(sort(xx,decreasing = T))),val~rank)
  return(-reg$coefficients[2])
}

communities_louvain<-function(citnw){
  A=as_adjacency_matrix(citnw,sparse = T)
  M = A+t(A)
  undir_citnw = graph_from_adjacency_matrix(M,mode="undirected")
  return(cluster_louvain(undir_citnw))
}


# modularity
directedmodularity<-function(membership,adjacency){
  m=sum(adjacency)
  kout=rowSums(adjacency);kin=colSums(adjacency)
  res = 0;k=length(unique(membership))
  for(c in unique(membership)){
    #if(c%%100==0){show(c/k)}
    inds=which(membership==c)
    res = res + sum(adjacency[inds,inds]) - sum(kin[inds])*sum(kout[inds])/m 
    gc()
  }
  return(res/m)
}



overlappingmodularity <- function(probas,adjacency){#,linkfun=function(p1,p2){return(p1*p2)}){
  show(paste0('Computing overlapping modularity : dim(probas)=',dim(probas)[1],' ',dim(probas)[2],' ; dim(adjacency)=',dim(adjacency)[1],' ',dim(adjacency)[2]))
  m = sum(adjacency)
  n=nrow(probas)
  kout=rowSums(adjacency)
  kin=colSums(adjacency)
  res=0
  for(c in 1:ncol(probas)){
    if(sum(probas[,c])>0){
      if(c%%100==0){show(c/ncol(probas))}
      a1 = Diagonal(x=probas[,c])%*%adjacency%*%Diagonal(x=probas[,c])
      a2 = sum(kout*probas[,c])*sum(kin*probas[,c])*((sum(probas[,c])/n)^2)/m
      res = res + sum(a1) - a2
      rm(a1);gc() # loose time to call gc at each step ?
    }
  }
  return(res/m)
}


corrMat <- function(p1,p2){
  ids = intersect(rownames(p1),rownames(p2))
  d1 <- p1[ids,];d2<-p2[ids,]
  d1 = Matrix(apply(d1,2,function(col){(col-mean(col))/sd(col)}))
  d2 = Matrix(apply(d2,2,function(col){(col-mean(col))/sd(col)}))
  return(t(d1)%*%d2/nrow(d1))
}



bootstrapped<-function(p1,p2){
  minrho=c();maxrho=c();meanabsrho=c()
  minrhosup=c();maxrhosup=c();meanabsrhosup=c()
  for(b in 1:1000){
    if(b%%100==0){show(b)}
    shuffled=p2;rownames(shuffled)<-sample(rownames(p2),size=nrow(p2),replace = F)
    cors = corrMat(p1,shuffled)
    minrho=append(minrho,min(cors));maxrho=append(maxrho,max(cors));meanabsrho=append(meanabsrho,mean(abs(cors)))
    shuffled=p1;rownames(shuffled)<-sample(rownames(p1),size=nrow(p1),replace = F)
    cors = corrMat(p2,shuffled)
    minrho=append(minrho,min(cors));maxrho=append(maxrho,max(cors));meanabsrho=append(meanabsrho,mean(abs(cors)))
    shuffled=p1;rows=sample.int(n=nrow(p1),size=0.5*nrow(p1),replace = FALSE)
    rownames(shuffled)[rows]<-sample(rownames(shuffled)[rows],size=length(rows),replace=F)
    cors = corrMat(p1,shuffled)
    minrhosup=append(minrhosup,min(cors));maxrhosup=append(maxrhosup,max(cors));meanabsrhosup=append(meanabsrhosup,mean(abs(cors)))
    shuffled=p2;rows=sample.int(n=nrow(p2),size=0.5*nrow(p2),replace = FALSE)
    rownames(shuffled)[rows]<-sample(rownames(shuffled)[rows],size=length(rows),replace=F)
    cors = corrMat(p2,shuffled)
    minrhosup=append(minrhosup,min(cors));maxrhosup=append(maxrhosup,max(cors));meanabsrhosup=append(meanabsrhosup,mean(abs(cors)))
  }
  return(data.frame(minrho,maxrho,meanabsrho,minrhosup,maxrhosup,meanabsrhosup))
}


