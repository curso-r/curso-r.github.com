---
title: Aula 05 - Gráficos com estilo - ggplot2
date : 2015-01-28
output:
  html_document:
    number_sections: no
    toc: yes
---

<a href="http://curso-r.github.io/slides/aula_05_apresentacao.html" target="_blank">Slides dessa aula</a>

<a href="http://curso-r.github.io/script/aula_05.R" target="_blank">Script dessa aula</a>

# O pacote ggplot2

O `ggplot2` é um pacote do R voltado para a criação de gráficos estatísticos. Ele é baseado na Gramática dos Gráficos (*grammar of graphics*, em inglês), criado por Leland Wilkinson, que é uma resposta para a pergunta: o que é um gráfico estatístico? Resumidamente, a gramática diz que um gráfico estatístico é um mapeamento dos dados a partir de atributos estéticos (cores, formas, tamanho) de formas geométricas (pontos, linhas, barras).

Para mais informações sobre a Gramática dos Gráficos, você pode consultar o livro [*The Grammar of graphics*](http://www.springer.com/statistics/computational+statistics/book/978-0-387-24544-7), escrito pelo Leland Wilkinson, ou o livro [ggplot2: elegant graphics for data analysis](http://ggplot2.org/book/), do Hadley Wickham.

## Instalação

O `ggplot2` não faz parte dos pacotes base do R. Assim, antes de usá-lo, você precisa baixar e instalar o pacote. Para isso, é necessário ter pelo menos a versão 2.8 do R, pois o `ggplot2` não é compatível com versões anteriores.

Para baixar e instalar o pacote, utilize a seguitne linha de código:


```r
install.packages("ggplot2")
```
Não se esqueça de carregar o pacote antes de utilizá-lo:


```r
library(ggplot2)
```

# Construindo gráficos

A seguir, vamos discutir os aspcetos básicos para a construção de gráficos com o pacote `gglplot2`. Para isso, utilizaremos o banco de dados contido no objeto `mtcars`. Para visualizar as primeiras linhas deste banco, utilize o comando:


```r
head(mtcars)
```

```
##                    mpg cyl disp  hp drat    wt  qsec vs am gear carb
## Mazda RX4         21.0   6  160 110 3.90 2.620 16.46  0  1    4    4
## Mazda RX4 Wag     21.0   6  160 110 3.90 2.875 17.02  0  1    4    4
## Datsun 710        22.8   4  108  93 3.85 2.320 18.61  1  1    4    1
## Hornet 4 Drive    21.4   6  258 110 3.08 3.215 19.44  1  0    3    1
## Hornet Sportabout 18.7   8  360 175 3.15 3.440 17.02  0  0    3    2
## Valiant           18.1   6  225 105 2.76 3.460 20.22  1  0    3    1
```

## As camadas de um gráfico

No `ggplot2`, os gráficos são construídos camada por camada (ou, *layers*, em inglês), sendo que a primeira delas é dada pela função `ggplot` (não tem o "2"). Cada camada representa um tipo de mapeamento ou personalização do gráfico. O código abaixo é um exemplo de um gráfico bem simples, construído a partir das duas principais camadas. 



```r
ggplot(data = mtcars, aes(x = disp, y = mpg)) + 
  geom_point()
```

![plot of chunk aula05chunk03](assets/fig/aula05chunk03.png) 

Observe que o primeiro argumento da função `ggplot` é um data frame. A função `aes()` descreve como as variáveis são mapeadas em aspectos visuais de formas geométricas definidas pelos *geoms*. Aqui, essas formas geométricas são pontos, selecionados pela função `geom_point()`, gerando, assim, um gráfico de dispersão. A combinação dessas duas camadas define o tipo de gráfico que você deseja construir.

### Aesthetics

A primeira camada de um gráfico deve indicar a relação entre os dados e cada aspecto visual do gráfico, como qual variável será representada no eixo x, qual será representada no eixo y, a cor e o tamanho dos componentes geométricos etc. Os aspectos que podem ou devem ser mapeados depende do tipo de gráfico que você deseja fazer.

No exemplo acima, atribuímos aspectos de posição: ao eixo y mapeamos a variável `mpg` (milhas por galão) e ao eixo x a variável `disp` (cilindradas). Outro aspecto que pode ser mapeado nesse gráfico é a cor dos pontos



```r
ggplot(data = mtcars, aes(x = disp, y = mpg, colour = as.factor(am))) + 
  geom_point()
```

![plot of chunk aula05chunk04](assets/fig/aula05chunk04.png) 

Agora, a variável `am` (tipo de transmissão) foi mapeada à cor dos pontos, sendo que pontos vermelhos correspondem à transmissão automática (valor 0) e pontos azuis à transmissão manual (valor 1). Observe que inserimos a variável `am` como um fator, pois temos interesse apenas nos valores "0" e "1". No entanto, tambem podemos mapear uma variável contínua à cor dos pontos:


```r
ggplot(mtcars, aes(x = disp, y = mpg, colour = cyl)) + 
  geom_point()
```

![plot of chunk aula05chunk05](assets/fig/aula05chunk05.png) 

Aqui, o número de cilindros, `cyl`, é representado pela tonalidade da cor azul.

**Nota**: por *default*, a legenda é insirida no gráfico automaticamente.

Também podemos mapear o tamanho dos pontos à uma variável de interesse:


```r
ggplot(mtcars, aes(x = disp, y = mpg, colour = cyl, size = wt)) +
  geom_point()
```

![plot of chunk aula05chunk06](assets/fig/aula05chunk06.png) 

**Exercício**: pesquisar mais aspectos que podem ser alterados no gráfico de dispersão.

### Geoms

Os *geoms* definem qual forma geométrica será utilizada para a visualização dos dados no gráfico. Como já vimos, a função `geom_point()` gera gráficos de dispersão transformando pares (x,y) em pontos. Veja a seguir outros *geoms* bastante utilizados:

- geom_line: para retas definidas por pares (x,y)
- geom_abline: para retas definidas por um intercepto e uma inclinação
- geom_hline: para retas horizontais
- geom_boxplot: para boxplots
- geom_histogram: para histogramas
- geom_density: para densidades
- geom_area: para áreas
- geom_bar: para barras

Veja a seguir como é fácil gerar diversos gráficos diferentes utilizando a mesma estrutura do gráfico de dispersão acima:


```r
ggplot(mtcars, aes(x = as.factor(cyl), y = mpg)) + 
  geom_boxplot()
```

![plot of chunk aula05chunk07](assets/fig/aula05chunk07.png) 


```r
ggplot(mtcars, aes(x = mpg)) + 
  geom_histogram()
```

```
## stat_bin: binwidth defaulted to range/30. Use 'binwidth = x' to adjust this.
```

![plot of chunk aula05chunk08](assets/fig/aula05chunk08.png) 


```r
ggplot(mtcars, aes(x = as.factor(cyl))) + 
  geom_bar()
```

![plot of chunk aula05chunk09](assets/fig/aula05chunk09.png) 

Para fazer um boxplot para cada grupo, precisamos passar para o aspecto x do gráfico uma variável do tipo fator. 

## Personalizando os gráficos

### Cores

O aspecto colour do boxplot, muda a cor do contorno. Para mudar o preenchimento, basta usar o `fill`.


```r
ggplot(mtcars, aes(x = as.factor(cyl), y = mpg, colour = as.factor(cyl))) + 
  geom_boxplot()
```

![plot of chunk aula05chunk10](assets/fig/aula05chunk10.png) 



```r
ggplot(mtcars, aes(x = as.factor(cyl), y = mpg, fill = as.factor(cyl))) + geom_boxplot()
```

![plot of chunk aula05chunk11](assets/fig/aula05chunk11.png) 

Você pode também mudar a cor dos objetos sem mapeá-la a uma variável. Para isso, observe que os aspectos `colour` e `fill` são especificados fora do `aes()`.


```r
ggplot(mtcars, aes(x = as.factor(cyl), y = mpg)) + 
  geom_boxplot(color = "red", fill = "pink")
```

![plot of chunk aula05chunk12](assets/fig/aula05chunk12.png) 

### Eixos

Para alterar os labels dos eixos acrescentamos as funções `xlab()` ou `ylab()`.


```r
ggplot(mtcars, aes(x = mpg)) + 
  geom_histogram() +
  xlab("Milhas por galão") +
  ylab("Frequência")
```

```
## stat_bin: binwidth defaulted to range/30. Use 'binwidth = x' to adjust this.
```

![plot of chunk aula05chunk13](assets/fig/aula05chunk13.png) 


Para alterar os limites dos gráficos usamos as funções `xlim()` e `ylim()`.


```r
ggplot(mtcars, aes(x = mpg)) + 
  geom_histogram() +
  xlab("Milhas por galão") +
  ylab("Frequência") +
  xlim(c(0, 40)) +
  ylim(c(0,8))
```

```
## stat_bin: binwidth defaulted to range/30. Use 'binwidth = x' to adjust this.
```

![plot of chunk aula05chunk14](assets/fig/aula05chunk14.png) 


### Legendas

A legenda de um gráfico pode ser facilmente personalizada.

Para trocar o *label* da leganda:


```r
ggplot(mtcars, aes(x = as.factor(cyl), fill = as.factor(cyl))) + 
  geom_bar() +
  labs(fill = "cyl")
```

![plot of chunk aula05chunk15](assets/fig/aula05chunk15.png) 

Para trocar a posição da legenda:


```r
ggplot(mtcars, aes(x = as.factor(cyl), fill = as.factor(cyl))) + 
  geom_bar() +
  labs(fill = "cyl") +
  theme(legend.position="top")
```

![plot of chunk aula05chunk16](assets/fig/aula05chunk16.png) 

Para retirar a legenda:


```r
ggplot(mtcars, aes(x = as.factor(cyl), fill = as.factor(cyl))) + 
  geom_bar() +
  guides(fill=FALSE)
```

![plot of chunk aula05chunk17](assets/fig/aula05chunk17.png) 


Veja mais opções de personalização [aqui!](http://www.cookbook-r.com/Graphs/Legends_(ggplot2)/)

### Facets

Outra funcionalidade muito importante do ggplot é o uso de *facets*.


```r
ggplot(mtcars, aes(x = mpg, y = disp, colour = as.factor(cyl))) + 
  geom_point() + 
  facet_grid(am~.)
```

![plot of chunk aula05chunk18](assets/fig/aula05chunk18.png) 

Podemos colocar os graficos lado a lado também:


```r
ggplot(mtcars, aes(x = mpg, y = disp, colour = as.factor(cyl))) +
  geom_point() + 
  facet_grid(.~am)
```

![plot of chunk aula05chunk19](assets/fig/aula05chunk19.png) 

