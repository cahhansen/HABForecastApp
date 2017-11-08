
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

shinyUI(navbarPage(
                   title = "Algal Bloom Vulnerability in Central Utah",
                   
                   tabPanel(title="Vulnerability Forecasting Tool",
                            leafletOutput('vulMap'),
                            hr(),
                            fluidRow(
                              column(4,
                                     h4("User Input"),
                                     selectInput('lakeSelect', 'Select Lake', 
                                                 c('Utah Lake','Deer Creek Reservoir','Scofield Reservoir','Great Salt Lake (South of Causeway)','Farmington Bay','GSL System','Central Utah'),
                                                 selected='Central Utah')
                              ),
                              column(4, 
                                     h4(),
                                     offset = 1,
                                     radioButtons('timeScale', 'Forecasting Time Scale', c('Short Range (7 day)','Long Range (30 day)','Seasonal'))
                              ),
                              column(4, 
                                     h4(),
                                     offset =1,
                                     plotOutput('vulPlot')
                              )
                            )
                   ),
                   tabPanel(title="History of Algal Blooms in GSL System"),
                   navbarMenu("Additional Resources",
                              tabPanel(title="NOAA CyaN Project"),
                              tabPanel(title="EPA")
                   )
))
