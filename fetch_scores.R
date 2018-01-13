# Read locations
locations <- read.csv("./data/bos_vmt_grid_centroid_latlong.csv")
# locations <- locations[39001:44000,]
missing_transit_locations <- read.csv("./data/missing_transit.csv", stringsAsFactors = FALSE)
locations <- locations[which(locations$shapeid%in%missing_transit_locations$X_Shape.ID),]
source('./R/getScoreJson.R')
write.table(t(colnames(missing_transit_locations)),file="./data/score_missing_transit.csv", sep = ",", append = FALSE, quote = FALSE,
            col.names = FALSE, row.names = FALSE)
for( i in 4991:9008)
{
  if(i%%500==0)
    print(i)
  # Add key as third parameter to get Score Json
  walkscore <- getScoreJson("",locations$latitude[i],locations$longitude[i],"")
  missing_transit_locations$X_Walkscore.Status[i] <- walkscore$status
  missing_transit_locations$X_Walkscore[i] <- walkscore$walkscore
  missing_transit_locations$X_Walkscore.Desc[i] <- walkscore$wdescr
  missing_transit_locations$X_Updated[i] <- walkscore$updated
  missing_transit_locations$X_Snapped.Lon[i] <- walkscore$snappedLong
  missing_transit_locations$X_Snapped.Lat[i] <- walkscore$snappedLat
  missing_transit_locations$X_Transitscore[i] <- walkscore$tscore
  missing_transit_locations$X_Transitscore.Desc[i] <- walkscore$tdescr
  missing_transit_locations$X_Nearby.Routes[i] <- walkscore$tnearbyroutes
  missing_transit_locations$X_Nearby.Bus.Routes[i] <- walkscore$tbus
  missing_transit_locations$X_Nearby.Rail.Routes[i] <- walkscore$trail
  missing_transit_locations$X_Nearby.Routes_1[i] <- walkscore$tother
  missing_transit_locations$X_Bikescore[i] <- walkscore$bscore
  missing_transit_locations$X_Bikescore.Desc[i] <- walkscore$bdescr
  write.table(missing_transit_locations[i,],file="./data/score_missing_transit.csv", sep = ",", append = TRUE, quote = FALSE,
              col.names = FALSE, row.names = FALSE)
}
