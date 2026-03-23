
# SHINY ggPlantmap beta test

## Introduction

This is a beta test for the ggPlantmap.shinyapp() function. For now, the
function is not included in the package, I will include them after doing
some tests Could you try it out, and if you find errors, could you
please report it? Thanks for the help!

``` r
library(shiny)
library(tidyverse)
#> ── Attaching core tidyverse packages ──────────────────────── tidyverse 2.0.0 ──
#> ✔ dplyr     1.1.4     ✔ readr     2.1.4
#> ✔ forcats   1.0.0     ✔ stringr   1.5.0
#> ✔ ggplot2   3.4.4     ✔ tibble    3.2.1
#> ✔ lubridate 1.9.3     ✔ tidyr     1.3.0
#> ✔ purrr     1.0.2     
#> ── Conflicts ────────────────────────────────────────── tidyverse_conflicts() ──
#> ✖ dplyr::filter() masks stats::filter()
#> ✖ dplyr::lag()    masks stats::lag()
#> ℹ Use the conflicted package (<http://conflicted.r-lib.org/>) to force all conflicts to become errors
library(ggPlantmap)
options(stringsAsFactors = F)
```

1)  The ggPlantmap.shinyapp() function:

``` r
ggPlantmap.shinyapp <-function(map,quant,variable="variable",value="value",mapping = "ROI.name") {
  for.shiny <- ggPlantmap.merge(map,quant,id.x={{mapping}})
  list.of.variables <- for.shiny %>%
    pull(!!sym(variable)) %>%
    unique()
  
  ui <- fluidPage(
    title = "Shiny ggPlantmap",
    sidebarLayout(
    sidebarPanel("Variable Selection",
                  selectInput(label="Variable", choices = list.of.variables,inputId = "variable"),
                  checkboxInput("checkbox", "Scaled", value = TRUE),
                 "If scaled, the heatmap will be scaled for the entire dataset"
                  ),
    mainPanel(
      div(id = "left-aligned",plotOutput("ggPlantmap.map")),
      div(id = "left-aligned",plotOutput("ggPlantmap.plot"))
  )
  )
  )
server <- shinyServer(function(input, output) {
    filtered_data <- reactive({
      filter(for.shiny,!!sym(variable) == input$variable)
    })
    
    formulaText <- reactive({
      paste(input$variable)
    })
    
    # Return the formula text for printing as a caption ----
    output$caption <- renderText({
      formulaText()
    })
    
    plot1 <- reactive({ggPlantmap.plot(map) +
      theme(legend.position = "right") +
        scale_fill_brewer(palette = "Paired")
    })
    
    max.v <- reactive({
      if (input$checkbox) {
        for.shiny %>%
          pull(!!sym(value)) %>%
          max()
      } else {
        filtered_data() %>%
          pull(!!sym(value)) %>%
          max()
      }
    })
    plot2 <- reactive({
    ggPlantmap.heatmap(filtered_data(),value.quant=!!sym(value)) +
    scale_fill_gradient(low="white",high="red",limits=c(0,max.v())) +
    labs(title=formulaText()) +
    theme(legend.position = "right",
          plot.title = element_text(size = 20, face = "bold",hjust = 0.5))
        
    })
    
    output$ggPlantmap.map <- renderPlot({plot1()})
    output$ggPlantmap.plot <- renderPlot({plot2()})
    
}
)
shinyApp(ui, server)
}
```

2)  Creating a fake expression data for the ggPm.At.roottip.crosssection
    map:

``` r
## Creating a fake expression data for the ggPm.At.roottip.crosssection map
expression <- NULL
for(k in 1:50) {
  foo <- tibble(ROI.name=unique(ggPm.At.roottip.crosssection$ROI.name),
         value=runif(length(unique(ggPm.At.roottip.crosssection$ROI.name)),min = 10,max=100)) %>%
    mutate(gene = paste0("gene",k),
           value=value^2)
  expression <- rbind(expression,foo)
}
expression
#> # A tibble: 400 × 3
#>    ROI.name   value gene 
#>    <chr>      <dbl> <chr>
#>  1 Epidermis  5078. gene1
#>  2 Columella  1758. gene1
#>  3 Cortex      730. gene1
#>  4 Endodermis 1828. gene1
#>  5 Pericycle  5652. gene1
#>  6 Phloem     3506. gene1
#>  7 Procambium  750. gene1
#>  8 Xylem      6681. gene1
#>  9 Epidermis  1449. gene2
#> 10 Columella  5558. gene2
#> # ℹ 390 more rows
```

3)  Running the function:

``` r
## Running the function
ggPlantmap.shinyapp(ggPm.At.roottip.crosssection, ## ggPlantmap
                    expression, ## Expression data
                    variable="gene", ## what is the column name that describes the different values of the drop-down variable
                    value="value") ## what is the name of the column that contains the values to be displayed in the heatmap
```
