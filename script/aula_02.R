# Lendo arquivos com o R -------------------

setwd("script/")
























# Estatísticas básicas ----------------------

dados <- read.table(file = "dados/Abraoetal1997.txt", header = T, sep = "\t")
summary(dados)

table(dados$Grupo)
mean(dados$Idade)
summary(dados$Idade)

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


# grafico de pizza
pie(table(y))

# grafico de barras
barplot(table(y))


# plyr -------------------------

#install.packages("plyr")
library(plyr)





