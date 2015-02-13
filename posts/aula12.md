---
title: "Aula 12 - Laboratório IV"
date : 2015-02-13
# output: ioslides_presentation
---

O objetivo deste laboratório é criar um aplicativo no Shiny para ajuste de um 
modelo de regressão linear ao banco de dados `diamonds` do R.


```r
library(ggplot2)
head(diamonds)
```

```
##   carat       cut color clarity depth table price    x    y    z
## 1  0.23     Ideal     E     SI2  61.5    55   326 3.95 3.98 2.43
## 2  0.21   Premium     E     SI1  59.8    61   326 3.89 3.84 2.31
## 3  0.23      Good     E     VS1  56.9    65   327 4.05 4.07 2.31
## 4  0.29   Premium     I     VS2  62.4    58   334 4.20 4.23 2.63
## 5  0.31      Good     J     SI2  63.3    58   335 4.34 4.35 2.75
## 6  0.24 Very Good     J    VVS2  62.8    57   336 3.94 3.96 2.48
```

Digite `?diamonds` para entender o que cada variável significa.

O aplicativo deverá conter:

* Um seletor da variável resposta que será considerada pelo modelo.
* Um seletor de todas as covariáveis do modelo
* Um gráfico da variável resposta (eixo y) por uma das variáveis utilizadas no modelo
incluindo a reta ajustada.

Para a reta ajustada, o usuário fornecerá valores fixos para as demais variáveis que estão no modelo, usando
inputs do tipo slider.

Utilize o [repositório do lab04 no github](https://github.com/curso-r/lab04) como template para o seu trabalho. 


