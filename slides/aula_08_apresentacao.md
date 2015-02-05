# Aula 08 - Aula dos Alunos
Curso de R: Do casual ao avançado  
2015-01-04  




## Big Data no R? {.build}

O R não é uma ferramenta de Big Data. Mas o que podemos fazer?

- Usar linguagens de programação de baixo nível, principalmente C
- Usar pacotes que lêem as bases do disco rígido e não da memória RAM
- Tirar uma amostra
- Usar um computador com mais memória RAM

## Usar um computador com mais memória RAM

- Não tenho dinheiro para comprar um computador com muita memória RAM.
- Usar computador na Amazon

## Usando a memória RAM de forma mais eficiente

- Família de pacotes big*
- Exemplos: bigmemmory, bigglm

## Exemplo com o base R


```r
n <- 1e6
y <- rnorm(n)
d <- data.frame(y = y, x1 = 2*y + runif(n), x2 = 3*y + runif(n), x3 = rnorm(n), x4 = rnorm(n))
modelo <- lm(y ~ x1*x2*x3*x4, data = d)
```

## Exemplo usando biglm


```r
library(biglm)
n <- 1e6
y <- rnorm(n)
d <- data.frame(y = y, x1 = 2*y + runif(n), x2 = 3*y + runif(n), x3 = rnorm(n), x4 = rnorm(n))
modelo <- biglm(y ~ x1*x2*x3*x4, data = d)
```

- para glm é a mesma coisa!!

`biglm`gera um objeto com tamanho menor, além de ser mais efciente.

## Outras funções big


```r
library(biganalytics)
n <- 5*1e6
y <- rnorm(n)
m <- matrix(c(y, 2*y + runif(n), 3*y + runif(n), rnorm(n), rnorm(n)), ncol = 5)
modelo <- bigkmeans(x = m, centers = 2, iter.max = 100)
```


## Estratégias para ler bases grandes

[Estratégias para ler bases grandes](http://stackoverflow.com/questions/1727772/quickly-reading-very-large-tables-as-dataframes-in-r)

- função `fread` do pacote `data.table`

## `fread` é muito fácil de usar



```r
download.file("http://stat-computing.org/dataexpo/2009/2008.csv.bz2",
              destfile="2008.csv.bz2")
system("bunzip2 2008.csv.bz2")
library(data.table)
system.time(DT <- fread("2008.csv"))
```

## `fread`

- já aloca a memória necessária para ler o arquivo
- estabelece os tipos de colunas antes de ler o arquivo

## Paralelização

uso do pacote `parallel` junto com o `plyr`


## Criando um cluster (backend)


```r
library(parallel)
library(foreach)
library(doParallel)
c <- makePSOCKcluster(2)
registerDoParallel(c)
```

## Usando o cluster por meio do pacote plyr


```r
library(plyr)
system.time(l_ply(1:2, .fun = function(x) {Sys.sleep(1)}, .parallel = T))
system.time(l_ply(1:2, .fun = function(x) {Sys.sleep(1)}, .parallel = F))
stopCluster(c)
```

## htmlwidgets

- framework para criação de pacotes de visualizações em javascript
- é bem recente, mas todas as semanas surge um novo 



