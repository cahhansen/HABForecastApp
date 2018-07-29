#Retrieves streamflow data from NWIS using dataRetrieval package and NWIS web services
ProvoSpringFlow <- mean(readNWISdata(sites="10163000", service="iv", 
                                     parameterCd="00060", 
                                     startDate=paste(currentyear,"03-01",sep="-"),endDate=paste(currentyear,"06-01",sep="-"))$X_00060_00000,na.rm=T)

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
