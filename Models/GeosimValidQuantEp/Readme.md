
 - initial corpus java -jar bibliodata.jar --keywords --mongo query.csv geosimvalid $MAXSIZE=10500 2 true
req does not work with "AND"? -> yes, remove spaces

! run the torpool in mongo mode, otherwise NullPointerException when try to get next port -> works at the beginning if remaining ports from a previous run
java -jar torpool.jar 50 9050 --mongo> 

-> stalled at 9800 (scholar error 500): stop, relaunch with 9700
 : in fact 970! -> finally corpus 852 with 850 (stop at 960-970 ~)
1840 results (gs front) with no spaces

 - increase depth: twice java -jar bibliodata.jar --database --incrdepth geosimvalid

 - export java -jar bibliodata.jar --database --export geosimvalid data/base_corpus -1 -1 2 false "" -1

 - collect citnw:
    java -jar bibliodata.jar --citation --mongo geosimvalid 10000

 - PROV export [still running]:
 java -jar bibliodata.jar --database --export geosimvalid data/corpus -1 -1 2 false "" -1
[15/09, 14h35: 154302, 220535], remaining 19830~

  - gephi vis: from core.gml file
     * communities (res 1, randomise)
     * force atlas 2 spatialisation- tune params : ~ default: echelle 2, gravity 1, dissuader hubs
     * taille degre entrant, spline most exag, taille min 1 max 10
     * ajust labels / dilat / size label: eigen centrality
     * visu: lab size, color ; export png 2048x2048 (will crop in slide)


