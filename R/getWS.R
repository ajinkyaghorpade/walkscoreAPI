getWS <-
function(x,y,key){
    URL <- paste("http://api.walkscore.com/score?lat=",y,"&lon=",x,"&wsapikey=",key,sep="")
    X <- character(0)
    X <- c(X, scan(file = URL, what = "", sep = "\n", quiet = TRUE))

    string <- X[grep("<walkscore>",X)]
    string2 <- X[grep("<description>",X)]
    string3 <- X[grep("<updated>",X)]
    string4 <- X[grep("<snapped_lat>",X)]
    string5 <- X[grep("snapped_lon>",X)]

    if (length(string)> 0){
       if (grep("walk",string) == 1){
          walk <- strsplit(string,"<walkscore>")
          walk2 <- gsub("</walkscore>","",walk[[1]][2]) 
          wscore <- as.numeric(walk2)
          des <- strsplit(string2,"<description>")
          des2 <- gsub("</description>","",des[[1]][2])
          descr <- des2
          up <- strsplit(string3,"<updated>")
          up2 <- gsub("</updated>","",up[[1]][2])
          update <- up2
          snlat <- strsplit(string4,"<snapped_lat>")
          snlat2 <- gsub("</snapped_lat>","",snlat[[1]][2]) 
          snla <- as.numeric(snlat2)
          snlon <- strsplit(string5,"<snapped_lon>")
          snlon2 <- gsub("</snapped_lon>","",snlon[[1]][2]) 
          snlo <- as.numeric(snlon2)

       }
       else{
          wscore<--1
          descr <- "NA"
          update <- "NA"
          snla <- -1
          snlo <- -1
       }
     }
    else{
       wscore<--1
       descr <- "NA"
       update <- "NA"
       snla <- -1
       snlo <- -1

    }
     
    object <- list()
    class(object) <- "WalkScore"
    object$walkscore <- wscore
    object$description <- descr
    object$updated <- update
    object$snappedLong <- snlo
    object$snappedLat <- snla
    return(object)
}
