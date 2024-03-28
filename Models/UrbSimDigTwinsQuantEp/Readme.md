
- initial corpus:
   * torpool java -jar torpool.jar 50 9050 --mongo
   * request: (urban OR city) digital twin ; (urban OR city) simulation
   * collect initial corpus java -jar bibliodata.jar --keywords --mongo query.csv urbsimdigtwins 100 2 true
     =>  200 refs
   * ! bug, initial depth not taken into account -> increase depth: twice: java -jar bibliodata.jar --database --incrdepth urbsimdigtwins  
   * quick screening: everything seemms reasonable - and should not introduce bias by manually removing fields [ex: SUMO mobility simu: part of urb sim in some sense - maybe more links with twins]

- collect citation network
   * same torpool running
   * java -jar bibliodata.jar --citation --mongo urbsimdigtwins 10000
     => start on 2024/03/24 (aprem), stop on 2024/03/28 (http://scholar.google.com/scholar?cites=7314636670702590424&lookup=0&start=0 en cours ; not proc: java -jar bibliodata.jar --database --notproc urbsimdigtwins) ; remaining: 18814 ; refs: 99562, links: 182479 [not that sparse!]
   * prov export : java -jar bibliodata.jar --database --export urbsimdigtwins data/corpus_prov20240328 -1 -1 2 false "" -1



