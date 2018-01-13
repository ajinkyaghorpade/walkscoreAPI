scores_all <- read.csv('./data/score_all.csv',header = FALSE)
scores_missing <- read.csv('./data/score_missing.csv',header = FALSE)
for (i in 1:length(scores_missing[,1])) {
  scores_all[which(scores_all$V1 == scores_missing$V1[i]),]<-scores_missing[i,]
}
write.csv(scores_all,file="./data/score_all.csv",row.names = FALSE,col.names = FALSE)