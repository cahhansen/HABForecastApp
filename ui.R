shinyUI(navbarPage(theme = shinytheme("flatly"),
 
                   title = "Algal Bloom Vulnerability in Utah Lake",
                   
                   
                   
                   tabPanel(title="Seasonal HAB Forecasting Tool",
                            sidebarLayout(
                              sidebarPanel(helpText('This tool uses hydrologic and meteorological factors to estimate the 
                                                    likelihood of future bloom conditions for the current summer. 
                                                    Measurements of these factors are obtained from various databases, including the USGS NWIS, NOAA NCDC, and NRCS SNOTEL Network via web services.'),
                                           selectInput(inputId='habevent',
                                                       label='HAB Event',
                                                       choices=c("Average Chl-a above 20 ug/L",
                                                                 "Maximum Chl-a above 90th percentile"),
                                                       selected="Average Chl-a above 20 ug/L"),
                                           sliderInput(inputId='riskthreshold',
                                                       label='Risk Threshold',
                                                       min=1,
                                                       max=99,
                                                       value=50,
                                                       step=1)
                                          
                                           ),
                                            
                              mainPanel(leafletOutput('mymap'),
                                        h4("Observed Hydrologic and Climate Data:"),
                                         fluidRow(
                                           column(3,
                                                  h5('Observed SWE'),
                                                  plotOutput('obssweplot')
                                           ),
                                           column(3,
                                                  h5('Observed Spring Temperature'),
                                                  plotOutput('obstempplot')
                                                  
                                           ),
                                           column(3,
                                                  h5('Observed Streamflow'),
                                                  plotOutput('obsstreamflow')
                                                  
                                           ),
                                           column(3,
                                                  h5('Observed Precipitation'),
                                                  plotOutput('obsprecip')
                                                  
                                           )
                                         )
                                         
                              )
                            )
                   ),
                   tabPanel(title="HAB Scenario Explorer",
                            sidebarLayout(
                              sidebarPanel(helpText('Explore scenarios of future HAB conditions with user-defined hydrologic and meteorological conditions. Probabilities of conditions are calculated using the same underlying model and probabilities as the forecasting tool.'),
                                           h4("User Input:"),
                                           selectInput("habmeasure",label="Select measure of bloom conditions to forecast",
                                                       choices=c("Average Chl",
                                                                 "Maximum Chl"),
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
