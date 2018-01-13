library(jsonlite)
getScoreJson <-
  function(address,x,y,key){
    # ?format=xml&
    #   address=1119%8th%20Avenue%20Seattle%20WA%2098101&lat=47.6085&
    #     lon=-122.3295&wsapikey=<YOUR-WSAPIKEY>
    address <- gsub(" ",'-',address)  
    URL <- paste("http://api.walkscore.com/score?address=",address,"&lat=",x,"&lon=",y,"&wsapikey=",key,"&transit=1&bike=1&format=json",sep="")
    X <- character(0)
    X <- c(X, scan(file = URL, what = "", sep = "\n", quiet = TRUE))
    X <- fromJSON(X);
    
    if (X$status == 1){
      wscore <- X$walkscore
      wdescr <- X$description
      update <- X$updated
      snla <- X$snapped_lat
      snlo <- X$snapped_lon
      if (length(X$transit)==0 || (length(X$transit)!=0 && is.null(X$transit$score)))
      {
        tscore <- "NA"
      tdescr <- "NA"
      tnearbyroutes <- "NA"
      tbus <- "NA"
      trail <- "NA"
      tother <- "NA"
      }else{
      tscore <- X$transit$score
      tdescr <- X$transit$description
      temp <- strsplit(X$transit$summary,":")
      tnearbyroutes <- strsplit(temp[[1]][1]," ")[[1]][1]
      tbus <- strsplit(temp[[1]][2]," ")[[1]][2]
      trail <- strsplit(temp[[1]][2]," ")[[1]][4]
      tother <- strsplit(temp[[1]][2]," ")[[1]][6]
      }
      if(length(X$bike)==0  || (length(X$bike)!=0 && is.null(X$bike)))
      {
        bscore <- "NA"
        bdescr <- "NA"
      }else{
        bscore <- X$bike$score
        bdescr <- X$bike$description
      }
    }else {
      wscore <- "NA"
      wdescr <- "NA"
      update <- "NA"
      snlo <- "NA"
      snla <- "NA"
      tscore <- "NA"
      tdescr <- "NA"
      tnearbyroutes <- "NA"
      tbus <- "NA"
      trail <- "NA"
      tother <- "NA"
      bscore <- "NA"
      bdescr <- "NA"
    }
    
    object <- list()
    class(object) <- "WalkScore"
    object$status <- X$status
    object$walkscore <- wscore
    object$wdescr <- wdescr
    object$updated <- update
    object$snappedLong <- snlo
    object$snappedLat <- snla
    object$tscore <- tscore
    object$tdescr <- tdescr
    object$tnearbyroutes <- tnearbyroutes
    object$tbus <- tbus
    object$trail <- trail
    object$tother <- tother
    object$bscore <- bscore
    object$bdescr <- bdescr
    return(object)
  }

