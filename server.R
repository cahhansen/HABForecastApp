shinyServer(function(input, output,session) {

  source('approx_infer.R')
  
  #Change the color and popup depending on the result of the input variables
  if(julygtprob > 50){
    popuptext <- paste("Probability of TSI > 60 for July: ",julygtprob,"%. Algal scums are likely, and sampling is highly recommended.",sep="")
  }else{
    popuptext <- paste("Probability of TSI > 60 for July: ",julygtprob,"%. Sampling may be needed, but scums and cyanobacteria blooms are less likely.",sep="")
  }
  
  if(julygtprob>50){
    icons <- awesomeIcons(
      iconColor = 'black',
      library = 'glyphicon',
      icon = 'glyphicon-alert',
      markerColor = 'red')
  }else{
    icons <- awesomeIcons(
      iconColor = 'black',
      library = 'glyphicon',
      icon = 'glyphicon-option-horizontal',
      markerColor = 'blue')
  }
  
  output$mymap <- renderLeaflet({
    leaflet() %>%
      setView(-112, 40.5, zoom = 8) %>%
      addTiles() %>%
      addAwesomeMarkers(lng=-111.8,lat=40.2, icon=icons,popup = popuptext)
    
  })
  
  #Precip
  source('get_precip.R')
  output$junepreciptext <- renderText(
    if(currentmonth>=6 & currentday>8){
      paste("The June precipitation total so far is: ",ProvoPrecipJune,"mm")
    }else{
      "June precipitation is not yet available for this year. It is not used as evidence in the model."
    }
  )
  output$julypreciptext <- renderText(
    if(currentmonth>=7 & currentday>8){
      paste("The July precipitation total so far is:",ProvoPrecipJuly,"mm")
    } else{
      "July precipitation is not yet available for this year. It is not used as evidence in the model."
    }
  )
  output$augpreciptext <- renderText(
    if(currentmonth>=8 & currentday>8){
      paste("The August precipitation total so far is:",ProvoPrecipAug,"mm")
    } else{
      "August precipitation is not yet available for this year. It is not used as evidence in the model."
    }
  )
  #Plot of streamflow against normal
  
  #Streamflow
  source('get_streamflow.R')
  output$springflowtext <- renderText(paste("The total spring streamflow for March-May of this year was:",TotalUtahLakeStreamFlow,"cfs. (",utahlakeSpringQ,")"))
  #Plot of streamflow against normal
  
  #Display Historical Imagery
  output$lakechlmap <- renderImage({
    if (is.null(input$year))
      return(NULL)
    if (is.null(input$lake))
      return(NULL)
    if (input$year == "1984-1989") {
      return(list(
        src = "data/UtahLakePublicationPlot/UtahLake1984-1989.png",
        contentType = "image/png",
        alt = "Collection of chl a color maps from 1984-1989."
      ))}
      if (input$year == "1990-1995") {
        return(list(
          src = "data/UtahLakePublicationPlot/UtahLake1990-1995.png",
          contentType = "image/png",
          alt = "Collection of chl a color maps from 1990-1995."
        ))}
      if (input$year == "1996-2001") {
        return(list(
          src = "data/UtahLakePublicationPlot/UtahLake1996-2001.png",
          contentType = "image/png",
          alt = "Collection of chl a color maps from 1996-2001."
        ))}
      if (input$year == "2002-2007") {
        return(list(
          src = "data/UtahLakePublicationPlot/UtahLake2002-2007.png",
          contentType = "image/png",
          alt = "Collection of chl a color maps from 2002-2007."
        ))}
      if (input$year == "2008-2013") {
        return(list(
          src = "data/UtahLakePublicationPlot/UtahLake2008-2013.png",
          contentType = "image/png",
          alt = "Collection of chl a color maps from 2008-2013."
        ))}
      if (input$year == "2014-2016") {
        return(list(
          src = "data/UtahLakePublicationPlot/UtahLake2014-2016.png",
          contentType = "image/png",
          alt = "Collection of chl a color maps from 2014-2016."
        ))}
    }, deleteFile = FALSE)
  
    utahlakeclimatedata <- ncdc(datasetid='GHCND', stationid = "GHCND:USC00427064", datatypeid='PRCP', startdate = '2018-02-01', enddate = '2018-06-01')$data
})
