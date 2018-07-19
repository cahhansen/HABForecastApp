shinyServer(function(input, output,session) {

  source('approx_infer.R')
  
  prob_text <- reactive({
    if(julygtprob > input$riskthreshold){
      julypopuptext <- paste("<b>Probability of TSI > 60 for July: ",julygtprob,"% </b>. Algal scums are likely, and sampling is highly recommended.",sep="")
    }else{
      julypopuptext <- paste("<b>Probability of TSI > 60 for July: ",julygtprob,"% </b>. Sampling may be needed, but scums and cyanobacteria blooms are less likely.",sep="")
    }  
    if(auggtprob > input$riskthreshold){
      augpopuptext <- paste("<b>Probability of TSI > 60 for August: ",auggtprob,"% </b>. Algal scums are likely, and sampling is highly recommended.",sep="")
    }else{
      augpopuptext <- paste("<b>Probability of TSI > 60 for August: ",auggtprob,"% </b>. Sampling may be needed, but scums and cyanobacteria blooms are less likely.",sep="")
    }  
    if(septgtprob > input$riskthreshold){
      septpopuptext <- paste("<b>Probability of TSI > 60 for September: ",septgtprob,"% </b>. Algal scums are likely, and sampling is highly recommended.",sep="")
    }else{
      septpopuptext <- paste("<b>Probability of TSI > 60 for September: ",septgtprob,"% </b>. Sampling may be needed, but scums and cyanobacteria blooms are less likely.",sep="")
    }
    
    
    popuptext <- paste(julypopuptext,augpopuptext,septpopuptext,sep='<br/>')

  })
  
  checkprob_color <- reactive({
    if(julygtprob > input$riskthreshold | auggtprob > input$riskthreshold | septgtprob > input$riskthreshold){
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
  })

  #Map showing the result
  output$mymap <- renderLeaflet({
    leaflet() %>%
      setView(-112, 40.5, zoom = 8) %>%
      addTiles() %>%
      addAwesomeMarkers(lng=-111.8,lat=40.2,icon=checkprob_color(),popup = prob_text())
    
  })
  
  #Precip
  source('get_precip.R') #Get available precipitation data
  
  precipdata <- historicalfactors[,c("Year","JunePrecip","JulyPrecip","AugPrecip")]
  colnames(precipdata) <- c("Year","June","July","August")
  historicalprecip <- melt(data=precipdata,id.vars="Year")
  
  output$obsprecip <- renderPlot(
    
    ggplot()+
      geom_boxplot(data=historicalprecip,
                   aes(x=variable, y=value))+
      geom_point(data=data.frame(x=factor(c("June","July","August")),
                                 y=c(ProvoPrecipJuneSum,ProvoPrecipJulySum,ProvoPrecipAugSum)),
                 aes(x=x,y=y),color='red')+
      theme_bw()+
      xlab("Month")+
      ylab("Precipitation Total (mm)")
    
  )

  #Streamflow
  source('get_streamflow.R') #Get available streamflow data
  
  historicalqdata <- historicalfactors[,c("Year","SpringQ")]
  
  output$obsstreamflow <- renderPlot(
    
    ggplot()+
      geom_boxplot(data=historicalqdata,
                   aes(y=SpringQ,x=""))+
      geom_point(aes(y=TotalUtahLakeStreamFlow,x=""),color='red')+
      theme_bw()+
      xlab("Combined Provo River \n & Spanish Fork River")+
      ylab("Spring Streamflow (cfs)")
  )
  
  #SWE
  
  #Temperature
})
