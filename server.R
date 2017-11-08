
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

lakeinfo <- read.csv('data/LakeInfo.csv',stringsAsFactors = FALSE)

shinyServer(function(input, output, session) {
  
  output$vulMap <- renderLeaflet({
    
    selectlakeinfo <- as.list(lakeinfo[(lakeinfo$Name==input$lakeSelect),])
    
    leaflet() %>%
      setView(lng = selectlakeinfo$Longitude, lat = selectlakeinfo$Latitude, zoom = selectlakeinfo$Zoom) %>% 
      addProviderTiles(providers$Esri.NatGeoWorldMap,
                       options = providerTileOptions(noWrap = TRUE)
      )
  })


})
