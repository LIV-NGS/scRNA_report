shinyApp(
  
    ui <- fluidPage(
    titlePanel("Gene expression"),
    
    sidebarPanel(
      selectInput("genes", "Gene:", seurat_genes, multiple = TRUE), width = 2
    ),
    
    mainPanel(splitLayout(cellWidths = 400,
                          uiOutput('out_umap'),
                          uiOutput('out_vln')),
                          DT::dataTableOutput("out_dt")
    )
    )
  ,
  
  
  # Define server logic required to draw a histogram
  server <- function(input, output) {
     output$out_umap = renderUI({
      out = list()
      
      if (length(input$genes)==0){return(NULL)}
      for (i in 1:length(input$genes)){
        out[[i]] <-  plotOutput(outputId = paste0("plot_umap",i))
      }  
      return(out) 
    })
    observe({  
      for (i in 1:length(input$genes)){  
        local({  #because expressions are evaluated at app init
          ii <- i 
          output[[paste0('plot_umap',ii)]] <- renderPlot({ 
            return(FeaturePlot(sc, features=input$genes[[ii]], combine=FALSE))
          })
        })
      }                                  
    })
    
    output$out_vln = renderUI({
      out = list()
      
      if (length(input$genes)==0){return(NULL)}
      for (i in 1:length(input$genes)){
        out[[i]] <-  plotOutput(outputId = paste0("plot",i))
      }  
      return(out) 
    })
    observe({  
      for (i in 1:length(input$genes)){  
        local({  #because expressions are evaluated at app init
          ii <- i 
          output[[paste0('plot',ii)]] <- renderPlot({ 
            return(VlnPlot(sc, features=input$genes[[ii]], combine=FALSE))
          })
        })
      }                                  
    })
   output$out_dt <- DT::renderDataTable(df,
                        extensions = 'Buttons', filter = 'top', 
                        options = list(pageLength = 100, scrollX = TRUE, scrollY = "600px", autoWidth = TRUE, dom = 'Bfrtip',
                                       buttons = list('copy', 'print', list(extend = 'collection',buttons = c('csv', 'excel'),text = 'Download'))))
 
    
    
    }
)