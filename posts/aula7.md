---
title: Aula 7 - Shiny
date : 2014-12-04
---

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
- Quando surfamos na web, nos comunicamos com servidores do mundo inteiro, geralmente através
do protocolo HTTP.

### Server side
- Processa requisições e dados do cliente, estrutura e envia páginas web, interage com banco de 
dados, etc.
- Linguagens: PHP, C#, Java, R, etc (virtualmente qualquer linguagem de programação).

### User side
- Cria interfaces bonitas e dinâmicas a partir dos códigos recebidos pelo servidor, envia e recebe
informações do servidor, etc.
- "Linguagens" mais usuais: HTML, CSS e JavaScript.

### Onde está o Shiny nisso tudo?

- O código de uma aplicação shiny fica no _server side_.
- O shiny permite que um computador (servidor) envie páginas web, receba informações do usuário e 
processe dados, utilizando apenas o R.
- Para rodar aplicativos shiny, geralmente estruturamos a parte relacionada ao HTML, JavaScript e 
CSS no arquivo `ui.R`, e a parte relacionada com processamento de dados e geração de gráficos e 
análises no arquivo `server.R`. 
- Os arquivos `ui.R` e `server.R` ficam no servidor!

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

### Adicionando widgets!

Acesse [neste link](http://shiny.rstudio.com/gallery/widget-gallery.html 'widgets') ou rode


```r
shiny::runGitHub('garrettgman/shinyWidgets')
```

## Outras informações



### Construindo inputs e outputs personalizados

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

