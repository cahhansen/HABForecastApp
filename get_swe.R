#Retrieves SNOTEL data via the AWDB (NRCS Air and Water Database) web services

ProvoSWE <- grabNRCS.data(network="SNTL",site_id = 820, timescale = "daily",
                         DayBgn=paste(as.numeric(currentyear)-1,"10-01",sep="-"), DayEnd=paste(as.numeric(currentyear),"03-31",sep="-"))[c("Date","Snow.Water.Equivalent..in..Start.of.Day.Values")]
colnames(ProvoSWE) <- c("Date","SWE")

ProvoSWESum <- sum(ProvoSWE$SWE)

SFSpringFlow <- mean(readNWISdata(sites="10150500", service="iv", 
                                  parameterCd="00060", 
                                  startDate="2018-03-01",endDate="2018-6-1")$X_00060_00000,na.rm=T)

TotalUtahLakeStreamFlow <- round(ProvoSpringFlow+SFSpringFlow,0)

#Categorize values to match the classes set in the model
if(TotalUtahLakeStreamFlow < varthresholds[(varthresholds$Parameter=="SpringQ"),"ThresholdValue"] & TotalUtahLakeStreamFlow>0){
  utahlakeSpringQ <- varthresholds[(varthresholds$Parameter=="SpringQ"),"BelowThresholdValue"]
}else if(TotalUtahLakeStreamFlow >= varthresholds[(varthresholds$Parameter=="SpringQ"),"ThresholdValue"] & TotalUtahLakeStreamFlow>0){
  utahlakeSpringQ<- varthresholds[(varthresholds$Parameter=="SpringQ"),"AboveThresholdValue"]
}else {
  utahlakeSpringQ <- NULL
}