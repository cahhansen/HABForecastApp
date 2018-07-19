if(julygtprob > 50){
  popuptext <- paste("Liklihood of TSI > 60 for July: ",julygtprob,"%. Algal scums are likely, and sampling is highly recommended.",sep="")
}else{
  popuptext <- paste("Liklihood of TSI > 60 for July: ",julygtprob,"%. Sampling may be needed, but scums and cyanobacteria blooms are less likely.",sep="")
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
