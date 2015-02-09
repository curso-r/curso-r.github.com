library(shiny)
library(leaflet)

fluidPage(

  fluidRow(tags$h1('Exemplo leaflet!!')),

  sidebarLayout(

    sidebarPanel(
      selectInput('uf', 'UF', sort(unique(pnud_muni$ufn)), multiple=TRUE, selected=sort(unique(pnud_muni$ufn))),
      selectInput('ano', 'Ano', sort(unique(pnud_muni$ano))[2:3]),
      selectInput('variavel', 'Variável', names(pnud_muni)[6:237]),
      sliderInput('n', 'Número de municípios a mostrar', min=1, max=50, value=15, step=1)
    ),

    mainPanel(
      leafletOutput('map', width = '100%', height=500),
      dataTableOutput('dados')
    )

  )
)
