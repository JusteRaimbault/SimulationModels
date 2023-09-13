
 - initial corpus java -jar bibliodata.jar --keywords --mongo query.csv digtwinsustdev 100 2 true

=> 95 initial refs
Rq: req does not work with "AND" (pb with html escaping?)

 - increase depth: twice java -jar bibliodata.jar --database --incrdepth digtwinsustdev

 - collect cit nw
java -jar bibliodata.jar --citation --mongo digtwinsustdev 10000 //2 true
// note: confusion with priority field -> does not use, neither conso (nothing for digtwin yet anyway)
! run the torpool in mongo mode, otherwise NullPointerException when try to get next port -> works at the beginning if remaining ports from a previous run
java -jar torpool.jar 50 9050 --mongo

 - export java -jar bibliodata.jar --database --export digtwinsustdev data/corpus -1 -1 2 false "" -1

 - gephi vis: from core.gml file
     * fruchterman reingold spatialisation (area 10000, gravity 10, speed 1)
     * communities (res 1, randomise)
     * force atlas bien mieux - tune params : ~ default: echelle 2, gravity 1, dissuader hubs
     * taille degre entrant, spline most exag, taille min 1 max 10
     * ajust labels / dilat / size label: eigen centrality
     * visu: lab size, color ; export png 2048x2048 (will crop in slide)



