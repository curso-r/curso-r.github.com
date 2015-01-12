---
title: Aula 05 - Gráficos com estilo - ggplot2
date : 2015-01-28
---

# O pacote ggplot2

O `ggplot2` é um pacote do R voltado para a criação de gráficos estatísticos. Ele é baseado na Gramática dos Gráficos (*grammar of graphics*, em inglês), criado por Leland Wilkinson, que é uma resposta para a pergunta: o que é um gráfico estatístico? Resumidamente, a gramática diz que um gráfico estatístico é um mapeamento dos dados a partir de atributos estéticos (cores, formas, tamanho) de formas geométricas (pontos, linhas, barras).

Para mais informações sobre a Gramática dos Gráficos, você pode consultar o livro [*The Grammar of graphics*](http://www.springer.com/statistics/computational+statistics/book/978-0-387-24544-7), escrito pelo Leland Wilkinson, ou o livro [ggplot2: elegant graphics for data analysis](http://ggplot2.org/book/), do Hadley Wickham.

## Instalação

O `ggplot2` não faz parte dos pacotes básico do R. Assim, antes de usá-lo, você precisa baixar e instalar o pacote. Para isso, é necessário ter pelo menos a versão 2.8 do R, pois o `ggplot2` não é compatível com versões anteriores.

Para baixar e instalar o pacote, utilize a seguitne linha de código:

```{}
install.packages("ggplot2")
```
Não se esqueça de carregar o pacote antes de utilizá-lo:


```r
library(ggplot2)
```

## Como fazer um gráfico no `ggplot`


```r
head(mtcars) # banco de dados
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

```r
ggplot(mtcars, aes(x = mpg, y = disp)) + geom_point()
```

![plot of chunk unnamed-chunk-2](assets/fig/unnamed-chunk-2.png) 

* O primeiro argumento da função é um `data.frame` com todas as variáveis do gráfico.
* A função `aes` mapeia as variáveis para cada aspecto do gráfico. Dependendo do tipo de gráfico que você deseja fazer os aspectos são diferentes, mas na maior parte das vezes, é obrigatório ter um `x`e um `y`.
* `+ geom_point` indica que você quer fazer um gráfico de pontos (cada combinação de `x` e `y`é um ponto)

## O que mais dá pra fazer?

Fizemos um gráfico de dispersão da variável mpg ( Milhas por galão) pela variável Disp (distância percorrida) pelos carros em 1972. Agora, gostariamos que a cor dos pontos variasse de acordo com  variável cyl (número de cilindros).


```r
ggplot(mtcars, aes(x = mpg, y = disp, colour = cyl)) + geom_point()
```

![plot of chunk unnamed-chunk-3](assets/fig/unnamed-chunk-3.png) 

Adicionamos mais um aspecto ao gráfico: a cor. Neste caso estamos considerando o número de cilindros como uma variável contínnua, mas eventualmente gostariamos de considerá-la como uma variável categórica.


```r
ggplot(mtcars, aes(x = mpg, y = disp, colour = as.factor(cyl))) + geom_point()
```

![plot of chunk unnamed-chunk-4](assets/fig/unnamed-chunk-4.png) 

Agora, gostariamos que o tamanho dos pontos fosse proporcional ao peso do carro. Para isso temos que adicionar mais um aspecto ao gráfico.


```r
ggplot(mtcars, aes(x = mpg, y = disp, colour = as.factor(cyl), size = wt)) + geom_point()
```

![plot of chunk unnamed-chunk-5](assets/fig/unnamed-chunk-5.png) 

Exercício: pesquisar mais aspectos que podem ser alterados no gráfico de dispersão.

Outra funcionalidade muito importante do ggplot é o uso de facets (?) Já temos bastante informação no gráfico acima não é? Se quiséssemos ver as diferenças entre os carros automaticos e manuais (variável am) poderiamos usar ainda o aspecto de formato do ponto. Mas também podemos usar o facet:


```r
ggplot(mtcars, aes(x = mpg, y = disp, colour = as.factor(cyl), size = wt)) + geom_point() + facet_grid(.~am)
```

![plot of chunk unnamed-chunk-6](assets/fig/unnamed-chunk-6.png) 

Podemos empilhar os dois gráficos também:


```r
ggplot(mtcars, aes(x = mpg, y = disp, colour = as.factor(cyl), size = wt)) + geom_point() + facet_grid(am~.)
```

![plot of chunk unnamed-chunk-7](assets/fig/unnamed-chunk-7.png) 



# Aesthetics

# Tipos de gráficos

# Personalizando o seu gráfico: 'theme()' 
