
setwd(paste0(Sys.getenv('CS_HOME'),'/SimulationModels/Models/QuantEpistemo'))

#kws<-read.csv('data/kws_now.csv',header=F)

# already custom kws
kws <-read.csv('data/kws_reqs.csv',header=F)

list.files('data')

corpus=data.frame()
for(kwfile in gsub(' ','+',kws$V1,fixed=T)){
  currentkws = read.csv(paste0('data/corpusreq_',kwfile,'.csv'),sep=';',header=T,colClasses = rep('character',4))
  #show(currentkws)
  corpus=rbind(corpus,currentkws)
}

# export consolidated raw corpus
write.table(corpus,sep=";",row.names = F,col.names = T,file = 'data/corpusreq_raw.csv')

#### load filtered corpus and remove duplicates

filtcorpus = read.csv(file='data/corpusreq_raw_handfiltered.csv',sep=";",header=T,colClasses = rep('character',4))
#inds=c();for(i in 1:nrow(filtcorpus)){}
filtcorpus = filtcorpus[!duplicated(filtcorpus$id),]

write.table(filtcorpus[,2:4],sep=";",row.names = F,col.names = T,file = 'data/corpusreq_filt.csv')


### oml specific corpus

omlcorpus=data.frame()
for(kwfile in gsub(' ','+',kws$V1,fixed=T)){
  currentkws = read.csv(paste0('data/corpusreq_withopenmole_',kwfile,'+openmole.csv'),sep=';',header=T,colClasses = rep('character',4))
  #show(currentkws)
  omlcorpus=rbind(omlcorpus,currentkws)
}

# remove filtcorpus
removedids = setdiff(corpus$id,filtcorpus$id)
#which(omlcorpus$id%in%removedids)
#intersect(omlcorpus$id,removedids)
# -> nothing to remove

# remove duplicates
omlcorpus=omlcorpus[!duplicated(omlcorpus$id),]

# export
write.table(omlcorpus,sep=";",row.names = F,col.names = T,file = 'data/corpusreq_openmole_prefilt.csv')

## hand filtered
# reload
omlfiltered = read.csv(file='data/corpusreq_openmole_prefilt_handfilt.csv',sep=";",header=T,colClasses = rep('character',4))

# can be exported directly
write.table(omlfiltered[,2:4],sep=";",row.names = F,col.names = T,file = 'data/corpusreq_openmole_filt.csv')

##
# --> two "basis corpuses" are : corpusreq_openmole_filt.csv, corpusreq_filt.csv


# check intersections of obtained corpuses
for(kwfile in gsub(' ','+',kws$V1,fixed=T)){
  show(kwfile)
  refs = read.csv(paste0('data/corpusreq_',kwfile,'.csv'),sep=';',header=T,colClasses = rep('character',4))
  omlrefs = read.csv(paste0('data/corpusreq_withopenmole_',kwfile,'+openmole.csv'),sep=';',header=T,colClasses = rep('character',4))
  refs = refs[refs$id%in%filtcorpus$id,]
  omlrefs = omlrefs[omlrefs$id%in%omlfiltered$id,]
  show(paste0(length(intersect(refs$id,omlrefs$id))," in ",nrow(refs)," ; ",nrow(omlrefs)))
  show(omlrefs[omlrefs$id%in%intersect(refs$id,omlrefs$id),])
}

#"model+exploration"
#[1] "1 in 14 ; 40"
#[1] "model+exploration+platform"
#[1] "1 in 21 ; 40"
#[1] "simulation+model+exploration"
#[1] "1 in 10 ; 41"
#[1] "numerical+experiment+workflow"
#[1] "1 in 21 ; 39"
# -> each time 11665166017377686868











