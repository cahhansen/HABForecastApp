#Retrieves SNOTEL data via the AWDB (NRCS Air and Water Database) web services

ProvoSWE <- grabNRCS.data(network="SNTL",site_id = 820, timescale = "daily",
                         DayBgn=paste(as.numeric(currentyear)-1,"10-01",sep="-"), DayEnd=paste(as.numeric(currentyear),"03-31",sep="-"))[c("Date","Snow.Water.Equivalent..in..Start.of.Day.Values")]
colnames(ProvoSWE) <- c("Date","SWE")

ProvoSWESum <- sum(ProvoSWE$SWE)

#Categorize values to match the classes set in the model
if(ProvoSWESum < varthresholds[(varthresholds$Parameter=="TotalSWE"),"ThresholdValue"] & ProvoSWESum>0){
  utahlakeTotalSWE <- varthresholds[(varthresholds$Parameter=="TotalSWE"),"BelowThresholdValue"]
}else if(ProvoSWESum >= varthresholds[(varthresholds$Parameter=="TotalSWE"),"ThresholdValue"] & ProvoSWESum>0){
  utahlakeTotalSWE<- varthresholds[(varthresholds$Parameter=="TotalSWE"),"AboveThresholdValue"]
}else {
  ProvoSWESum <- NA
  utahlakeTotalSWE <- NULL
}

