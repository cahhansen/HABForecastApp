library(shiny)
library(bnlearn)
library(dataRetrieval)
library(rnoaa)
library(RNRCS)
library(leaflet)
library(magrittr)
library(lubridate)
library(shinythemes)
library(reshape)
library(ggplot2)


load('data/historicalfactors.Rdata')
load('data/precipdata.Rdata')
load('data/LakeAvgChlBN.Rdata')
load('data/varthresholds.Rdata')
load('data/lakeavgchlmodeldata.Rdata')

#Get the current date
currentdate <- Sys.Date()
currentday <- day(currentdate)
currentmonth <- month(currentdate)
currentyear <- as.character(year(currentdate))

apikey <- 'oHzpSzCmInMhEdklKCOlSdxRjylSwKkS'
options(noaakey = apikey)
