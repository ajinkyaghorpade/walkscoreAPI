#updated the table of walkscore with the values from scores_missing_transit.csv
scores_missing_transit <- read.csv('./data/score_final.csv',stringsAsFactors = FALSE)

library("DBI")
library("RPostgreSQL")
library("dbplyr")
# Connect to Postgres database
db <- dbConnect("PostgreSQL", dbname = "ajinkyaghorpade",
                host = "localhost", port = 5432,
                user = 'ajinkyaghorpade', password = '')


# for (i in 1:dim(scores_missing_transit)[1]) {
#   dbExecute(db, paste0("update public.walkscore_bos_grid set \"_Walkscore\"=",scores_missing_transit$X_Walkscore[i], 
# ", \"_Walkscore Desc\"=", escape(scores_missing_transit$X_Walkscore.Desc[i]) ,
# ", \"_Snapped Lon\"=", scores_missing_transit$X_Snapped.Lon[i],",\"_Snapped Lat\"=", scores_missing_transit$X_Snapped.Lat[i] ,
# ", \"_Transitscore\"=", scores_missing_transit$X_Transitscore[i] ,", \"_Transitscore Desc\"=", escape(scores_missing_transit$X_Transitscore.Desc[i]) ,
# ",\"_Nearby Routes\"=", scores_missing_transit$X_Nearby.Routes[i] ,", \"_Nearby Bus Routes\"=",scores_missing_transit$X_Nearby.Bus.Routes[i],
# ", \"_Nearby Rail Routes\"=", scores_missing_transit$X_Nearby.Rail.Routes[i],",\"_Nearby Routes_1\"=", scores_missing_transit$X_Nearby.Routes_1[i],
# ", \"_Bikescore\"=",scores_missing_transit$X_Bikescore[i],", \"_Bikescore Desc\"=", escape(scores_missing_transit$X_Bikescore.Desc[i]),
# " where \"_Shape ID\" = ", scores_missing_transit$X_Shape.ID[i]) ) 
# }

for (i in 1:dim(scores_missing_transit)[1]) {
  dbExecute(db, paste0("update public.walkscore_bos_grid set \"_Walkscore\"=",scores_missing_transit$Walkscore[i], 
                       ", \"_Walkscore Desc\"=", escape(scores_missing_transit$Walkscore.Desc[i]) ,
                       ", \"_Snapped Lon\"=", scores_missing_transit$Snapped.Lon[i],",\"_Snapped Lat\"=", scores_missing_transit$Snapped.Lat[i] ,
                       ", \"_Transitscore\"=", scores_missing_transit$Transitscore[i] ,", \"_Transitscore Desc\"=", escape(scores_missing_transit$Transitscore.Desc[i]) ,
                       ",\"_Nearby Routes\"=", scores_missing_transit$Nearby.Routes[i] ,", \"_Nearby Bus Routes\"=",scores_missing_transit$Nearby.Bus.Routes[i],
                       ", \"_Nearby Rail Routes\"=", scores_missing_transit$Nearby.Rail.Routes[i],",\"_Nearby Routes_1\"=", scores_missing_transit$Nearby.Routes.1[i],
                       ", \"_Bikescore\"=",scores_missing_transit$Bikescore[i],", \"_Bikescore Desc\"=", escape(scores_missing_transit$Bikescore.Desc[i]),
                       " where \"_Shape ID\" = ", scores_missing_transit$Shape.ID[i]) ) 
}

dbDisconnect(db)