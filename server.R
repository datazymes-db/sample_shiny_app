shinyServer(function(input,output,session){
  #Code piece for storing the uploaded dataset as reactive and call the same whenever required 
  #Code storing in reactive value starts here#
  data <- reactive({
    file1 <- input$file
    if(is.null(file1)){return()}
    read.csv(file=file1$datapath, header = T, stringsAsFactors = T)
  })
  df<- reactive({
    req(input$xcol,input$ycol)
    file1 <- input$file
    if(is.null(file1)){return()}
    read.csv(file=file1$datapath, header = T, stringsAsFactors = T)

  })
  #Code storing in reactive value ends here#
  
  #Rendering the Dataset 
  #Rendering dataset code piece starts here
  output$tb <- renderDT({
      if(is.null(data())){return ()}
    data()
    })
  #Rendering dataset code ends starts here
  
  #Code belows gives dropdowns depending on the dataset loaded in the file uplaod tab
  #Rendering the dropdown code piece starts here
  output$selectInput_1 <- renderUI({
    selectInput("xcol","X variable",choices = c(colnames(select_if(data(),is.factor)),colnames(select_if(data(),is.character))))
  })
  output$selectInput_2 <- renderUI({
    selectInput("ycol","Y variable",choices = colnames(select_if(data(),is.numeric)))
  })
  #Rendering the dropdown code piece starts here
  
  #Code piece for plotting either box/bar plot 
  #Plot code starts here 
  output$p1 <- renderPlot({
    req(input$plotstyle)
    
    if(input$plotstyle == "BarPlot"){
      ggplot(data = df(),aes(x = df()[,c(input$xcol)],y = df()[,c(input$ycol)],group = 1))+geom_bar(stat = "identity")+labs(y=input$ycol,x = input$xcol)
    }
    else if(input$plotstyle == "LinePlot"){
      ggplot(data = df(),aes(x = df()[,c(input$xcol)],y = df()[,c(input$ycol)],group = 1))+geom_line()+geom_point()+labs(y=input$ycol,x = input$xcol)
    }
  })
  #Plot code ends here
  
  
})
