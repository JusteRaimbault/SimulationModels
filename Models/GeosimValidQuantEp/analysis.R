
setwd(paste0(Sys.getenv('CS_HOME'),'/SimulationModels/Models/GeosimValidQuantEp'))

library(dplyr,warn.conflicts = F)
library(readr)

corpus <- read_delim('data/screened_corpus.csv',quote = "\"", delim=";")

table(corpus$discipline)

#            archeology               biology       climate science      computer science               ecology 
#1                     1                     4                     8                    28 
#environmental science         geosimulation             hydrology       land-use change        social science 
#15                    26                    11                    18                     1 
#sustainability         urban science 
#6                    11 



sort(table(corpus$method),decreasing=T)

#    prediction            SA   uncertainty      multiple     benchmark   calibration  optimisation 
#24            19            18            13            12            11             9 
#visualisation           POM participatory   exploration         mixed     surrogate 
#8             6             4             3             2             1

maindisc = c('ecology','geosimulation','land-use change','environmental science','urban science','hydrology','computer science','sustainability')
mainmeth = c('prediction','SA','uncertainty','multiple','benchmark','calibration','optimisation','visualisation','POM')

main = corpus[corpus$discipline%in%maindisc&corpus$method%in%mainmeth,]

table(main[,c("discipline","method'")])
