#Retrieves precipitation data from NWIS using dataRetrieval package and NWIS web services

#Get the current date
currentdate <- Sys.Date()
currentday <- day(currentdate)
currentmonth <- month(currentdate)
currentyear <- as.character(year(currentdate))

if(currentmonth>=6 & currentday>8){
  ProvoPrecipJune <- ncdc(datasetid='GHCND',stationid='GHCND:USC00427064',datatypeid='PRCP',
                          startdate=paste(currentyear,"06-01",sep="-"),enddate=paste(currentyear,"06-30",sep="-"),limit=30)
  ProvoPrecipJune <- ProvoPrecipJune$data$value
  ProvoPrecipJune <- ProvoPrecipJune[(ProvoPrecipJune>=0)]
  ProvoPrecipJuneSum <- sum(ProvoPrecipJune)
  #Check if it is above or below the threshold for precipitation
  if(ProvoPrecipJuneSum < varthresholds[(varthresholds$Parameter=="JunePrecip"),"ThresholdValue"] & ProvoPrecipJuneSum>=0){
    utahlakeJunePrecip <- varthresholds[(varthresholds$Parameter=="JunePrecip"),"BelowThresholdValue"]
  }else if(ProvoPrecipJuneSum >= varthresholds[(varthresholds$Parameter=="JunePrecip"),"ThresholdValue"] & ProvoPrecipJuneSum>=0){
    utahlakeJunePrecip <- varthresholds[(varthresholds$Parameter=="JunePrecip"),"AboveThresholdValue"]
  }else {   utahlakeJunePrecip <- NULL
  }
}else{
  ProvoPrecipJuneSum <- NA
  utahlakeJunePrecip <- NULL
}
if(currentmonth>=7 & currentday>8){
  ProvoPrecipJuly <- (ncdc(datasetid='GHCND',stationid='GHCND:USC00427064',datatypeid='PRCP',
                              startdate=paste(currentyear,"06-01",sep="-"),enddate=paste(currentyear,"06-30",sep="-"),limit=30)$Value)
  ProvoPrecipJuly <- ProvoPrecipJuly$data$value
  ProvoPrecipJuly <- ProvoPrecipJuly[(ProvoPrecipJuly>=0)]
  ProvoPrecipJulySum <- sum(ProvoPrecipJuly)
  #Check if it is above or below the threshold for precipitation
  if(ProvoPrecipJulySum < varthresholds[(varthresholds$Parameter=="JulyPrecip"),"ThresholdValue"] & ProvoPrecipJulySum>=0){
    utahlakeJulyPrecip <- varthresholds[(varthresholds$Parameter=="JulyPrecip"),"BelowThresholdValue"]
  }else if(ProvoPrecipJulySum >= varthresholds[(varthresholds$Parameter=="JulyPrecip"),"ThresholdValue"] & ProvoPrecipJulySum>=0){
    utahlakeJulyPrecip <- varthresholds[(varthresholds$Parameter=="JulyPrecip"),"AboveThresholdValue"]
  }else {   utahlakeJulyPrecip <- NULL
  }
}else{
  ProvoPrecipJulySum <- NA
  utahlakeJulyPrecip <- NULL
}
if(currentmonth>=8 & currentday>8){
  ProvoPrecipAug <- (ncdc(datasetid='GHCND',stationid='GHCND:USC00427064',datatypeid='PRCP',
                              startdate=paste(currentyear,"06-01",sep="-"),enddate=paste(currentyear,"06-30",sep="-"),limit=30)$Value)
  ProvoPrecipAug <- ProvoPrecipAug$data$value
  ProvoPrecipAug <- ProvoPrecipAug[(ProvoPrecipAug>=0)]
  ProvoPrecipAugSum <- sum(ProvoPrecipAug)
  #Check if it is above or below the threshold for precipitation
  if(ProvoPrecipAugSum < varthresholds[(varthresholds$Parameter=="AugPrecip"),"ThresholdValue"] & ProvoPrecipAugSum>=0){
    utahlakeAugPrecip <- varthresholds[(varthresholds$Parameter=="AugPrecip"),"BelowThresholdValue"]
  }else if(ProvoPrecipAugSum >= varthresholds[(varthresholds$Parameter=="AugPrecip"),"ThresholdValue"] & ProvoPrecipAugSum>=0){
    utahlakeAugPrecip <- varthresholds[(varthresholds$Parameter=="AugPrecip"),"AboveThresholdValue"]
  }else {   utahlakeAugPrecip <- NULL
  }
}else{
  ProvoPrecipAugSum <- NA
  utahlakeAugPrecip <- NULL
}

