---
title: "Aula 10 - Shiny"
date : 2015-02-09
# output: ioslides_presentation
---

<a href="http://curso-r.github.io/slides/aula_10_apresentacao.html" target="_blank">Slides dessa aula</a>

## Informações gerais

### O que é?

- Sistema para desenvolvimento de aplicações web usando o R
- Um pacote do R (`shiny`)
- Um servidor web (`shiny server`)

### O que não é

- Uma página web
- Um substituto para sistemas mais gerais, como Ruby on Rails e Django
- Uma ferramenta gerencial, como o Tableau

## Desenvolvimento web

- [Server side _versus_ user side](http://programmers.stackexchange.com/a/171210 "diferencas").
- Quando surfamos na web, nos _comunicamos_ com servidores do mundo inteiro, geralmente através
do protocolo HTTP.

### Server side
- Processa requisições e dados do cliente, estrutura e envia páginas web, interage com banco de 
dados, etc.
- Linguagens: PHP, C#, Java, R, etc (virtualmente qualquer linguagem de programação).

### User side
- Cria interfaces gráfica a partir dos códigos recebidos pelo servidor, envia e recebe
informações do servidor, etc.
- "Linguagens" mais usuais: HTML, CSS e JavaScript.

---

### Onde está o Shiny nisso tudo?

- O código de uma aplicação shiny fica no _server side_.
- O shiny permite que um computador (servidor) envie páginas web, receba informações do usuário e 
processe dados, utilizando apenas o R.
- Para rodar aplicativos shiny, geralmente estruturamos a parte relacionada ao HTML, JavaScript e 
CSS no arquivo `ui.R`, e a parte relacionada com processamento de dados e geração de gráficos e 
análises no arquivo `server.R`. 
- Os arquivos `ui.R` e `server.R` ficam no servidor!
- Atualmente é possível construir 
[aplicativos em um arquivo só](http://shiny.rstudio.com/articles/single-file.html), mas vamos manter 
a estrutura de `ui.R` e `server.R`.

---

#### E pra que serve o shiny server?

- O pacote `shiny` do R possui internamente um servidor web básico, geralmente utilizado para
aplicações locais, permitindo somente uma aplicação por vez. 
- O `shiny server` é um programa que roda somente em Linux que permite o acesso a múltiplas
aplicações simultaneamente.

## Como funciona

- Baseado no [tutorial do Shiny pelo RStudio](http://shiny.rstudio.com/tutorial "tutorial")

### Começando com um exemplo


```r
shiny::runGitHub('abjur/vistemplate', subdir='exemplo_01_helloworld')
```

### Construindo uma interface no user side

- Shiny utiliza como padrão o [bootstrap css](http://getbootstrap.com/css/) do [Twitter](https://twitter.com), que é bonito e responsivo (lida bem com várias plataformas).
- Criar páginas básicas com `pageWithSidebar`.
- Páginas mais trabalhadas com `fluidPage`, `fluidRow`, `column`.
- Pesquisar outros tipos de layouts no shiny.
- Criar páginas web customizadas direto no HTML.

--- 

### Adicionando widgets!

Acesse [neste link](http://shiny.rstudio.com/gallery/widget-gallery.html 'widgets') ou rode


```r
shiny::runGitHub('garrettgman/shinyWidgets')
```

---

#### Exercício

- Criar um `pageWithSideBar` com dois `wellPanel`, um `dateInput`, um `checkboxGroup` e um `textInput`. 
- Aprender `fluidRow` e `column`.

---

### Criando outputs

- Imagine que para cada função `xxOutput('foo', ...)` do `ui.R` você pode colocar um código do tipo 
`output$foo <- renderXX(...)` no `server.R`.
- A função no arquivo `ui.R` determina a localização e identificação do elemento
- Criando gráficos com `plotOutput` e `renderPlot`.
- Exibindo dados com `dataTableOutput` e `renderDataTable`.

---

#### Exercício

- Criar um output de gráfico contento `pairs(mtcars[1:3])` e um output de dados contendo `cor(mtcars[1:3])`.

---

### Escopo
- `server.R`, dentro e fora
- `global.R`
- Sessões

### Modelo de Reatividade

- Determina o quê vai rodar e em que ordem no arquivo `server.R`, dependendo das ações do usuário.
- É uma tentativa de resolver a falta de tratamento de eventos no R.
- É importante pois impede que cálculos desnecessários sejam repetidos.
- Só funciona se for programado adequadamente.

---

### Objetos reativos

- Fonte (source): geralmente acessível no objeto `input`.
- Ponto final (endpoint): geralmente acessível no objeto `output`. Implementado através de 
`observers`.
- Condutores: geralmente implementado através da função `reactive`.

## Construindo grafo de invalidação

![Invalidacao1](assets/fig/faithful.png)

![Invalidacao2](assets/fig/conductor.png)

---

#### Exercício

Construa o grafo de invalidação do aplicativo construído nos exercícios anteriores.

---

#### Mais informações

- `reactive`: Utilizar para realizar computações pesadas ou cálculos utilizados em várias partes da
aplicação.
- `observe`: Utilizar para guardar dados internamente, arquivos de log, etc. Também pode ser útil
para trabalhar com widgets personalizados.
- `isolate`: Utilizar para cancelar a dependência de um valor reativo em um condutor ou ponto 
final, para poupar computações ou executar lógicas mais complexas.


```r
shiny::runGitHub('rstudio/shiny-examples', subdir='055-observer-demo')
```

## Fazendo mais com o shiny

### Construindo inputs e outputs personalizados

- Geralmente necessita de implementações de _bindings_ em R, HTML e JavaScript.
- Dependendo do caso, a criação de bindings pode ser "pulada" utilizando funções que injetam
JavaScript na página e a função `renderUI` (geralmente menos eficiente).
- Não dá tempo de abordar no curso. Ler 
[aqui](http://shiny.rstudio.com/articles/building-inputs.html) e 
[aqui](http://shiny.rstudio.com/articles/building-outputs.html).

---

### Shiny Server Pro

- Licensa comercial do Shiny-server
- Possui algumas características a mais, como autenticação e suporte.

### shinyapps.io

- Para compartilhar um aplicativo shiny, geralmente precisamos ter um servidor Linux (geralmente
utilizando algum serviço na cloud como AWS ou DigitalOcean) com o shiny server instalado.
- Isso pode ser doloroso.
- O shinyapps.io é um sistema (que envolve tanto pacote do R como uma página web) que permite que o 
usuário coloque sua aplicação shiny na web sem muito esforço.
- O serviço está sendo desenvolvido pela RStudio Inc. e terá contas grátis e pagas.

---

### Ainda mais!

- Ferramenta em amplo desenvolvimento.
- Grande oportunidade na área acadêmica e profissional.
- Potencial de revolucionar as formas atuais de comunicação.
