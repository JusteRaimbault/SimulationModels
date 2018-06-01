
# Positioning OpenMOLE in its scientific environment

## Context

Objective : situate OpenMOLE regarding the different related scientific communities
- which visibility ?
- which patterns of relation with the different domains ?
- enhance reflexivity for a better positioning strategy

## Methods and Data

### General workflow

keywords/articles -> citation networks -> semantic networks -> scientific communities

### Data collection

- run a torpool : `java -jar torpool.jar $NBWORKERS $PORT`
- collect a citation network from a csv corpus : `java -jar citationNetwork.jar $INFILE $OUTFILE $DEPTH`
- collect a corpus from a list of requests (text file with one request per line) : `java -jar keywordsRequests.jar $REQUESTFILE $NBREFS`


### Methods

- *Citing OML* OpenMOLE papers as initial corpus (file `data/corpus.csv`) => backward citation network at depth 3
- *Keywords positioning*
    - Brainstorming : keywords for current positioning (file `data/kws_now.csv`) ; keywords for future positioning (file `data/kws_future.csv`) ; keywords for risks (file `data/kws_bad.csv`)
    - From positioning keywords : requests list (file `data/kws_reqs.csv`), raw corpuses from keyword requests (keep 50 references for each request), with raw requests and adding `openmole` for each -> files prefixed `data/corpusreq` and `data/corpusreq_withopenmole`
    - manual screening of corpuses, removing of duplicates (script `requests.R`) -> basis corpuses : files `data/corpusreq_filt.csv` and `data/corpusreq_openmole_filt.csv`
    - construction of citation networks from these basis corpuses


## Results

*WIP*
