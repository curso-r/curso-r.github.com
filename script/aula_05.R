### Script --- Aula 5 --- ggplot2

library(ggplot2)
library(magrittr)
library(dplyr)
library(tidyr)

### Banco de dados: Flow of the River Nile
#################################################

Nile

class(Nile)

# Fazer um gráfico da série
x <- data.frame(flow=Nile)

data.frame(flow=Nile) %>%
  mutate(ano=(1871:1970)) %>%
  ggplot() +
  geom_line(aes(x=ano, y=flow)) +
  geom_point(aes(x=ano, y=flow), alpha=.2)


# ESTUDE!!! (mas nao use)
###qplot(Nile)


### Banco de dados: Accidental Deaths in the US 1973-1978
###########################################################
library(lubridate)

data.frame(USAccDeaths) %>%
  mutate(data_date=ymd('1973-01-01') + months(0:71),
         data_date=as.Date(data_date)) %>%
  ggplot() +
  geom_line(aes(x=month(data_date),
                y=USAccDeaths,
                colour=factor(year(data_date))))

data.frame(USAccDeaths) %>%
  mutate(data_date=ymd('1973-01-01') + months(0:71),
         data_date=as.Date(data_date),
         ano=factor(year(data_date))) %>%
  ggplot() +
  geom_line(aes(x=month(data_date),
                y=USAccDeaths)) +
  facet_wrap(~ano)

data.frame(USAccDeaths) %>%
  mutate(data_date=ymd('1973-01-01') + months(0:71),
         data_date=as.Date(data_date),
         ano=factor(year(data_date))) %>%
  ggplot() +
  geom_boxplot(aes(x=factor(month(data_date)),
                y=USAccDeaths))

# 1) Fazer um gráfico da série

# 2) Fazer um gráfico do número médio de mortes por mês no período


### Banco de dados: Survival of passengers on the Titanic
###########################################################


# Fazer um gráfico de barras do número de sobreviventes/mortos dividindo
# por classe, gênero e idade.

data.frame(Titanic) %>%
  ggplot() +
  geom_bar(aes(x=Age, y=Freq, fill=Survived),
           stat='identity',
           position='dodge') +
  facet_wrap(~Class + Sex, scales='free_y')

data.frame(Titanic) %>%
  ggplot() +
  geom_bar(aes(x=Age))


### Banco de dados: New York Air Quality Measurements
###########################################################

airquality %>% head

# 1) Fazer um gráfico pela concentração de ozônio diária para cada mês considerado.

airquality %>%
  ggplot() +
  geom_histogram(aes(x=Ozone, y=..density..), fill='white', colour='black', binwidth=20) +
  geom_density(aes(x=Ozone), fill='blue', alpha=0.2, adjust=1) +
  facet_wrap(~Month)

# 2) Investigar indícios de associação entre o ozôniote a temperatura e ozônio
#    e a velocidade do vento.


### Banco de dados: Locations of Earthquakes off Fiji
###########################################################

quakes

# 1) Fazer um histograma da magnitude

# 2) Fazer um mapa das ocorrências

