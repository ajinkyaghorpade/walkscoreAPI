setwd("~/Dropbox (MIT)/Learning/Courses/2017/11s946/project/walkscoreAPI")
missing_location_ids <- read.csv('./data/missing_walk_score.csv')
locations <- read.csv("./data/bos_vmt_grid_centroid_latlong.csv")
locations <- locations[locations$shapeid%in%missing_location_ids[,1],]
source('./R/getScoreJson.R')
for( i in seq(1,dim(locations)[1],1))
{
  if(i%%500==0)
    print(i)
  walkscore <- getScoreJson("",locations$latitude[i],locations$longitude[i],"")
  write.table(t(paste(c(locations$shapeid[i],walkscore))),file="./data/score_missing.csv", sep = ",", append = TRUE, quote = FALSE,
              col.names = FALSE, row.names = FALSE)
}
