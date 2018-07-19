shinyUI(navbarPage(theme = shinytheme("flatly"),
 
                   title = "Algal Bloom Vulnerability in Utah Lake",
                   
                   
                   
                   tabPanel(title="Seasonal HAB Forecasting Tool",
                            sidebarLayout(
                              sidebarPanel(helpText('This tool uses hydrologic and meteorological factors to estimate the liklihood of future bloom conditions for the current summer. Measurements of these factors are obtained from the USGS NWIS and NOAA NCDC databases via web services.'),
                                           h4("User Input:"),
                                           selectInput("habmeasure",label="Select measure of bloom conditions to forecast",
                                                       choices=c("Trophic State Index",
                                                                 "Bloom Coverage (%)"),
                                                       selected=""),
                                           h4("Measured Streamflow and Precipitation Data:"),
                                           textOutput('springflowtext'),
                                           textOutput('junepreciptext'),
                                           textOutput('julypreciptext'),
                                           textOutput('augpreciptext')
                                           ),
                                            
                              mainPanel(leafletOutput('mymap')
                              )
                            )
                   ),
                   tabPanel(title="HAB Scenario Explorer",
                            sidebarLayout(
                              sidebarPanel(helpText('Explore scenarios of future HAB conditions with user-defined hydrologic and meteorological conditions. Probabilities of conditions are calculated using the same underlying model and probabilities as the forecasting tool.'),
                                           h4("User Input:"),
                                           selectInput("habmeasure",label="Select measure of bloom conditions to forecast",
                                                       choices=c("Trophic State Index",
                                                                 "Bloom Coverage (%)"),
                                                       selected=""),
                                           helpText('Specify values for the following factors to explore "what-if" scenarios:'),
                                           selectInput("customswe",label="SWE for Oct-May of the current Water Year:",
                                                       choices=c("Not Specified","Above Avg","Below Avg"),
                                                       selected="Not Specified"),
                                           selectInput("customstreamflow",label="Spring streamflow (cfs):",
                                                       choices=c("Not Specified","Above Avg","Below Avg"),
                                                       selected="Not Specified"),
                                           selectInput("customjuneprecip",label="June precipitation (mm):",
                                                       choices=c("Not Specified","Low","High"),
                                                       selected="Not Specified"),
                                           selectInput("customjulyprecip",label="July precipitation (mm):",
                                                       choices=c("Not Specified","Low","High"),
                                                       selected="Not Specified"),
                                           selectInput("customaugprecip",label="August precipitation (mm):",
                                                       choices=c("Not Specified","Low","High"),
                                                       selected="Not Specified")
                                           
                              ),
                              
                              mainPanel(
                              )
                            )
                   ),
                   tabPanel(title="Historical Algal Blooms in GSL System",
                            sidebarLayout(
                              sidebarPanel(helpText('This collection of chl a maps was produced using seasonal, lake-specific empirical remote sensing models and Landsat 5/7 imagery. This complete spatial coverage of the lakes greatly enhances the information obtained through traditional field sampling or buoys at fixed locations. '),
                                           h4("User Input"),
                                           selectInput("year",label="Select year range",
                                                       choices=c("1984-1989","1990-1995","1996-2001","2002-2007","2008-2013","2014-2016"),
                                                       selected=""),
                                           selectInput("lake",label="Select Lake",
                                                       choices=c("Utah Lake","GSL","Farmington Bay"),
                                                       selected="")
                              ),
                              
                              mainPanel(imageOutput('lakechlmap',height = 200))
                            )),
                   navbarMenu("Additional Resources",
                              tabPanel(title=a("Utah Division of Water Quality HAB Information",
                                               href="https://deq.utah.gov/legacy/divisions/water-quality/health-advisory/harmful-algal-blooms/index.htm",
                                               target="_blank")),
                              tabPanel(title=a("Cyanobacteria Assessment Network (CyaN) Project",
                                               href="https://www.epa.gov/water-research/cyanobacteria-assessment-network-cyan",
                                               target="_blank")),
                              tabPanel(title=a("EPA Info on Harmful Algal Blooms",
                                       href="https://www.epa.gov/nutrientpollution/harmful-algal-blooms",
                                       target="_blank"))
                   )
))
