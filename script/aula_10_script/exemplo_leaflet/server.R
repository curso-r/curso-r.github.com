library(shiny)
library(leaflet)
library(dplyr)

shinyServer(function(input, output, session) {

  dados_filtro <- reactive({
    d <- pnud_muni %>%
      filter(ano==input$ano, ufn %in% input$uf) %>%
      mutate_(variavel=input$variavel) %>%
      select(municipio, ufn, variavel, lon, lat) %>%
      arrange(desc(variavel)) %>%
      slice(1:input$n) %>%
      mutate(radius=(variavel - min(variavel, na.rm=T)) / (diff(range(variavel, na.rm = T))) * 1e2,
             cores=topo.colors(n_distinct(ufn), alpha = NULL)[as.numeric(as.factor(ufn))])
    return(d)
  })

  m <- reactive({

    d <- dados_filtro()
    lon_range <- range(d$lon)
    lat_range <- range(d$lat)

    m <- leaflet(d) %>%
      addTiles() %>%
      fitBounds(lon_range[1], lat_range[1], lon_range[2], lat_range[2])

    return(m)
  })

  output$map <- renderLeaflet({
    d <- dados_filtro()
    m() %>%
      addCircleMarkers(lng=~lon, lat=~lat, radius = ~radius,
                 fill=TRUE, fillColor=~cores, fillOpacity=.2, stroke=TRUE, color=~cores,
                 popup = paste(d$ufn, d$municipio, d$variavel, sep='<br/>'))
  })

  output$dados <- renderDataTable({
    dados_filtro()
  })

})
