shinyUI(navbarPage(theme = "bootstrap.css",
                   title = "Algal Bloom Vulnerability in the Great Salt Lake System",
                   
                   tabPanel(title="Vulnerability Forecasting Tool",
                            leafletOutput('vul_map'),
                            hr(),
                            fluidRow(
                              column(4,
                                     h4("User Input"),
                                     selectInput('lake_select', 'Select Lake', 
                                                 c('Utah Lake','Deer Creek Reservoir','Scofield Reservoir','Great Salt Lake (South of Causeway)','Farmington Bay','GSL System')),
                                     br(),
                                     actionButton('zoom_to_lake', 'Zoom to Lake', icon = NULL, width = NULL)
                              ),
                              column(4, 
                                     h4(),
                                     offset = 1,
                                     radioButtons('time_scale', 'Forecasting Time Scale', c('Short Range (7 day)','Long Range (30 day)','Seasonal'))
                              ),
                              column(4, 
                                     h4(),
                                     offset =1,
                                     plotOutput('vul_plot')
                              )
                            )
                   ),
                   tabPanel(title="Harmful Algal Blooms"),
                   navbarMenu("Resources",
                              tabPanel(title="NOAA CyaN Project"),
                              tabPanel(title="EPA")
                   )
))