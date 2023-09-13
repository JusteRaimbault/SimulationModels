mongo geosimvalid --quiet --eval "db.references.find({\"citingFilled\":false,\"depth\":{\$gt:0}}).count()"

