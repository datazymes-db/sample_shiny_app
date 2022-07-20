#List of packages required 
#please install the packages before running the application
library(shiny)
library(shinydashboard)
library(fontawesome)
library(DT)
library(ggplot2)
library(dplyr)

shinyUI(
  dashboardPage(title = "File Input Function",
                dashboardHeader(title = "File Input Function",titleWidth = "210px"),
                dashboardSidebar(width = "200px",collapsed = F,
                                 sidebarMenu(id="Side_Menu", 
                                             menuItem("File upload",tabName = "Fileupload", icon = icon("file-upload")),
                                             menuItem("Plot",tabName = "plot",icon = icon("chart-line"))
                                 )
                ),
                dashboardBody(
                  tabItems(
                    tabItem(tabName = "Fileupload",
                            fluidPage(
                              fluidRow(
                                box(width = 12,status = "primary",
                                    column(3,fileInput("file","Upload the file"))
                                ),
                                box(width = 12,status = "primary",height = "auto",
                                    column(12,DTOutput("tb"))
                                )
                              )
                            )
                            ),
                    tabItem(tabName = "plot",
                            box(width = 12,status = "primary",
                                fluidRow(
                                  column(4,uiOutput("selectInput_1")),
                                  column(4,uiOutput("selectInput_2")),
                                  column(4,radioButtons(inputId = 'plotstyle', label = 'Plot style', choices = c(LinePlot="LinePlot",BarPlot="BarPlot"),inline = T))
                                  
                                )
                            ),
                            box(width = 12,status = "primary",
                                plotOutput("p1")
                            )))
                )
  )
)
