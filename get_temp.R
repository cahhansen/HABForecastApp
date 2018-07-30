#Retrieves temperature data from NOAA using ncdc package and AWDB web services

if(currentmonth>=3 & currentday>8){
  ProvoTemp <- ncdc(datasetid='GHCND',stationid='GHCND:USC00427064',datatypeid='TMAX',
                          startdate=paste(currentyear,"03-01",sep="-"),enddate=paste(currentyear,"05-31",sep="-"),limit=100)
  ProvoTemp <- ProvoTemp$data$value/10
  ProvoTemp <- ProvoTemp[(ProvoTemp>=0)]
  ProvoTempAvg <- mean(ProvoTemp,na.rm=T)
  #Check if it is above or below the threshold for temperature
  if(ProvoTempAvg < varthresholds[(varthresholds$Parameter=="SpringTemp"),"ThresholdValue"] & ProvoTempAvg>=0){
    utahlakeSpringTemp <- varthresholds[(varthresholds$Parameter=="SpringTemp"),"BelowThresholdValue"]
  }else if(ProvoTempAvg >= varthresholds[(varthresholds$Parameter=="SpringTemp"),"ThresholdValue"] & ProvoTempAvg>=0){
    utahlakeSpringTemp <- varthresholds[(varthresholds$Parameter=="SpringTemp"),"AboveThresholdValue"]
  }else {   utahlakeSpringTemp <- NULL
  }
}else{
  ProvoTempAvg <- NA
  utahlakeSpringTemp <- NULL
}
