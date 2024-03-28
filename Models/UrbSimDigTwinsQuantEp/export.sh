
# generic export script

# auth params
#USER=`cat user`
#PWD=`cat psswd`
#AUTHDB=`cat authdb`
#PORT=`cat port`

DB='urbsimdigtwins'
COLLECTION='references'

#QUERYFILE=$1
FIELDS="id,title,year,depth,horizontalDepth,author,doi,keywords,source,type"

#mongoexport -u $USER -p $PWD --authenticationDatabase $AUTHDB --port $PORT --db $DB --collection $COLLECTION -f $FIELDS --queryFile $QUERYFILE --limit 2
#mongoexport -u $USER -p $PWD --authenticationDatabase $AUTHDB --port $PORT --db $DB --collection $COLLECTION -f $FIELDS --type=csv -o $1

#mongoexport --db $DB --collection $COLLECTION -f $FIELDS --limit 20 -o $1
mongoexport --db $DB --collection $COLLECTION -f $FIELDS -o $1


