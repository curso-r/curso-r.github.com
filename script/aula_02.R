# Lendo arquivos com o R -------------------

setwd("script/")
























# Estatísticas básicas ----------------------

dados <- read.table(file = "dados/Abraoetal1997.txt", header = T, sep = "\t")
summary(dados)

table(dados$Grupo)
mean(dados$Idade)
summary(dados$Idade)
str(dados)
head(dados)
tail(dados)

# Gráficos ---------------------------------

x <- seq(1, 10, 0.1)
y <- exp(-x)

plot(x, y)
points(x = x, y = y^2)

plot(x, y, type = "l")
plot(x, y, type = "b")
plot(x, y, type = "h")
plot(x, y, type = "s")
plot(x, y, type = "n")


# argumento lwd -- espessura
plot(x,y, lwd = 10)
# argumendo cex -- tamanho
plot(x,y, cex = 0.2)
# argumento col -- cor
plot(x,y, col = "red")

# cores do R
# http://www.stat.columbia.edu/~tzheng/files/Rcolor.pdf

# mais gráficos
x <- seq(1, 10, 0.1)
y <- exp(-x)
plot(x, y)
points(x = x, y = y^2)

plot(x, y)
points(x = x, y = y^2, col="red", type = "l")

plot(x, y)
lines(x = x, y = y^2, col="red")


# boxxplots
x <- rnorm(100)
boxplot(x)

y <- sample(x = 1:4, size = 100, replace = T)
boxplot(x~y)

# histogramas
x <- rnorm(10)
hist(x)
x <- rnorm(100)
hist(x)
x <- rnorm(1000)
hist(x)
x <- rnorm(10000)
hist(x)

# grafico de pizza
pie(table(y))

# grafico de barras
barplot(table(y))


# plyr -------------------------

#install.packages("plyr")
library(plyr)

## Exemplos com plyr

### *dply - retorna um data.frame

#### ddply - geralmente faz o que o tapply deveria fazer. Quebra o bd e aplica coisas nele.

# cria tabela descritiva de um BD usando a função summarize e seus parâmetros

ddply(mtcars, .(cyl, gear), summarize, n=length(mpg), media=mean(mpg), mediana=median(mpg), dp=sd(mpg))

# pega uma quantidade de linhas de cada grupo de um BD
pega_linha_aleatoria <- function(obj_data_frame, num=1) {
  numero_aleat <- sample(1:nrow(obj_data_frame), num, replace=T)
  novo_obj_data_frame <- obj_data_frame[numero_aleat, ]
  novo_obj_data_frame
}

data(dados_muni, package='abjutils')
resultado1 <- ddply(dados_muni, .(uf), pega_linha_aleatoria)
resultado2 <- ddply(dados_muni, .(uf), pega_linha_aleatoria, num=3)

plot(dados_muni$long, dados_muni$lat)
points(resultado1$long, resultado1$lat, pch=16, col='red')
points(resultado2$long, resultado2$lat, pch=2, col='blue')

#### ldply - geralmente serve para empilhar uma conta que vem de uma lista e cria data.frames.

frutas <- list('laranja', 'banana', 'maçã', 'siriguela', 'graviola')

verifica_vogais <- function(x) {
  data.frame(x, a=grepl('a', x), e=grepl('e', x), i=grepl('i', x), o=grepl('o', x), u=grepl('u', x))
}

ldply(frutas, verifica_vogais)

## OBS: ldply também funciona se entrar com vetor
frutas <- c('laranja', 'banana', 'maçã', 'siriguela', 'graviola')

ldply(frutas, verifica_vogais)

#### adply - não é muito usado

# ozone é um array 24 x 24 x 72 (primeira dimensao=latitude, segunda dimensao=longitude,
# terceira dimensao=tempo)
data(ozone)
adply(ozone, 3, mean)

### *aply

#### daply - exemplo da aula

df <- data.frame(x = sample(1:4, size = 100, replace = T), y = rnorm(100))

m <- numeric(length = length(unique(df$x)))
for(i in unique(df$x)){
  m[i] <- mean(df$y[df$x == i])
}
m

library(magrittr)
daply(df, .(x), colwise(mean)) %>% as.numeric()

#### laply - geralmente para sumarizar as colunas de um data.frame

# verificar o tipo de cada variavel de um data.frame
laply(dados_muni, class)

# média de cada variável
laply(mtcars, mean)

data(baseball)

# proporção de NA's em cada variável
laply(baseball, function(x) sum(is.na(x))/length(x))

#### aaply - para resumir for's aninhados

# ozone é um array 24 x 24 x 72 (primeira dimensao=latitude, segunda dimensao=longitude, terceira dimensao=tempo)
data(ozone)
aaply(ozone, c(1,2), mean)

# quero pegar uma matriz, e somar 1, 2, ..., 10 em cada linha
m <- matrix(runif(100), ncol=10)
y <- matrix(numeric(100), ncol=10)
k <- 1
for(i in 1:10) {
  for(j in 1:10) {
    y[i,j] <- m[i,j] + k
    k <- k + 1
  }
  k <- 1
}
# com aaply
aaply(m, 1, function(x, k) x + k, k=1:10)

# Exercício: descubra uma forma muito mais fácil de fazer isso.
# R: t(t(m) + 1:10)

### *lply

#### dlply - geralmente se usa quando uma funcao aplicada a pedaços de um data.frame não são empilháveis num data.frame

# retorna os municípios com z de cada uf
municipios_com_z <- function(x) {
  x[grepl('z', x$municipio), 'municipio']
}
dlply(dados_muni, .(uf), municipios_com_z)

# ajuste de modelos
dlply(iris, .(Species), function(x) lm(Sepal.Length ~ Sepal.Width, data=x))


# obs: nesse caso um
# ddply(dados_muni, .(uf), function(x) x[grepl('z', x$municipio), ])
# poderia ser mais util, pois preserva a estrutura de data.frame

#### alply - não é muito usado

#### llply - igual lapply

funcao_que_demora <- function(x) {
  Sys.sleep(1)
  x^2
}

lapply(1:10, funcao_que_demora)
llply(1:10, funcao_que_demora, .progress='text')

### *_ply

#### d_ply
# salvar um arquivo por estado

escreve <- function(x) {
  write.csv(x, file=paste0('script/temp/', x$uf[1], '.csv'))
}

d_ply(dados_muni, .(uf), escreve)

#### a_ply - geralmente usamos o l_ply
# imprimir coisas
a_ply(m, 1, function(x) {cat(x, '\n\n')})

#### l_ply
# imprimir coisas

l_ply(rep('bla ', 10), cat)

## Fim dos exemplos com plyr

## COISAS SOBRE PERFORMANCE COM FUNCOES **PLY

n <- 50000
# alocacao dinamica, com for
system.time({
  x <- c()
  for(i in 1:n) {
    x[i] <- log(i)
  }
})

# vetor ja alocado, com for
system.time({
  x <- integer(n)
  for(i in 1:n) {
    x[i] <- log(i)
  }
})

# alocacao dinamica, com sapply
system.time({
  x <- c()
  invisible(sapply(1:n, function(i) x[i] <<- log(i)))
})

# vetor ja alocado, com sapply
system.time({
  x <- integer(n)
  invisible(sapply(1:n, function(i) x[i] <<- log(i)))
  ## equivalente a
})

# vetor ja alocado, com sapply: outra forma
system.time({l
  x <- sapply(1:n, log)
})

# maneira mais rápida de todas
system.time({
  x <- log(1:n)
})

## OBS: Comparando loop_apply, lapply e vetorização
# require(plyr)
# system.time({
#   plyr:::loop_apply(n, log)
# })
#
# system.time({
#   x <- 1:n
#   lapply(x, log)
# })
#
# system.time({
#   x <- 1:n
#   log(x)
# })



