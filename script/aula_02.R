# Lendo arquivos com o R -------------------

setwd("script/")
























# Estatísticas básicas ----------------------

dados <- read.table(file = "dados/Abraoetal1997.txt", header = T, sep = "\t")
summary(dados)

table(dados$Grupo)
mean(dados$Idade)
summary(dados$Idade)


