scores_final <- read.csv('./data/score_final.csv',stringsAsFactors = FALSE)
locations <- read.csv("./data/bos_vmt_grid_centroid_latlong.csv")
# scores_final$Walkscore.Desc <- unlist(scores_final$Walkscore.Desc);
for( i in seq(1,dim(locations)[1],1))
{
  if(i%%500==0)
    print(i)
  write.table(t(paste(c(locations$G250M_ID[which(locations$shapeid == scores_final$Shape.ID[i])],scores_final[i,]))),file="./data/score_mapped.csv", sep = ",", append = TRUE, quote = FALSE,
              col.names = FALSE, row.names = FALSE)
}