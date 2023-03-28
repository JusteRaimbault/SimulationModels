
 - initial corpus java -jar bibliodata.jar --keywords --mongo query.csv digtwinsustdev 100 2 true

=> 95 initial refs
Rq: req does not work with "AND" (pb with html escaping?)

 - increase depth: twice java -jar bibliodata.jar --database --incrdepth digtwinsustdev

 - collect cit nw
java -jar bibliodata.jar --citation --mongo digtwinsustdev 10000 //2 true
// note: confusion with priority field -> does not use, neither conso (nothing for digtwin yet anyway)
! run the torpool in mongo mode, otherwise NullPointerException when try to get next port -> works at the beginning if remaining ports from a previous run
java -jar torpool.jar 50 9050 --mongo


