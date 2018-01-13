source('R/getWS.R')

key = "eb181411f7ab03d5fc7a3a66f9bb7bc2"

directory_path <- '~/Desktop'
file_name <- '/Data_50m.csv';
locations <- read.csv(paste0(directory_path,file_name))

walkscore = vector(mode = "numeric", length = dim(locations)[1]);
for (i in 1:dim(locations)[1])
{
  temp <- getWS(locations[i,8],locations[i,3],locations[i,4],key);
  # print(locations[i,8])
  # print(locations[i,3])
  # print(locations[i,4])
  if(is.na(temp$walkscore))
  {
    walkscore[i] <- -100;
  }else
  {
    walkscore[i] <- temp$walkscore; 
  }
}
locations <- cbind(locations,walkscore);
write.csv(file=paste0(directory_path,"/walkscore.csv"),locations)

