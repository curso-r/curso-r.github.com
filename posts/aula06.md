---
title: Aula 06 - Laboratório II
date : 2015-01-30
--- 


# Questões iniciais

## Sobre dplyr e tidyr

Para estas questões usaremos a base de dados flights, ela está inserida no pacote `nycflights13` por isso é necessário utilizar o comando:


```r
library(nycflights13)
```

Se você não tiver o pacote instalado use o comando:


```r
install.packages("nycflighs13")
```

E em seguida use o `library(nycflights13)`.


```r
library(dplyr)
flights %>% tbl_df
```

```
## Source: local data frame [336,776 x 16]
## 
##    year month day dep_time dep_delay arr_time arr_delay carrier tailnum
## 1  2013     1   1      517         2      830        11      UA  N14228
## 2  2013     1   1      533         4      850        20      UA  N24211
## 3  2013     1   1      542         2      923        33      AA  N619AA
## 4  2013     1   1      544        -1     1004       -18      B6  N804JB
## 5  2013     1   1      554        -6      812       -25      DL  N668DN
## 6  2013     1   1      554        -4      740        12      UA  N39463
## 7  2013     1   1      555        -5      913        19      B6  N516JB
## 8  2013     1   1      557        -3      709       -14      EV  N829AS
## 9  2013     1   1      557        -3      838        -8      B6  N593JB
## 10 2013     1   1      558        -2      753         8      AA  N3ALAA
## ..  ...   ... ...      ...       ...      ...       ...     ...     ...
## Variables not shown: flight (int), origin (chr), dest (chr), air_time
##   (dbl), distance (dbl), hour (dbl), minute (dbl)
```

Com o comando `?flights` você pode ver o que significa cada uma das variáveis do banco de dados.

### filter

1. Atribua a uma tabela apenas os voos de janeiro de 2013.
2. Atribua a uma tabela apenas os voos de janeiro ou fevereiro de 2013.
3. Atribua a uma tabela apenas os vôos com distância maior do que 1000 milhas.

### select

1. Atribua a uma tabela apenas as colunas `month` e `dep_delay`.
2. Atribua a uma tabela apenas as colunas `month` e `dep_delay`, os nomes dessas colunas devem ser `mes`e `atraso`.
3. Retire da tabela as colunas `tailnum`, `origin` e `dest`

### mutate

1. Calcule as colunas `ganho_de_tempo` que é dado por `dep_delay - arr_delay` e `velocidade` dada por `distance / air_time * 60`.
2. Calcule o horário de chegada considerando as colunas `hour`, `minute` e `air_time`. A tabela deve conter duas colunas novas: `hour2` com a hora de chegada e `minute2` com o minuto de chegada.

### summarise

1. Calcule a média da distância de todos os vôos.
2. Calcule a média da distância dos vôos por mês
3. Calcule a média, mediana, primeiro quartil e terceiro quartil do tempo de viagem por mês.

### arrange

1. Ordene a base de dados pelo atraso na partida em ordem crescente.
2. Repita a questão anterior, porém na ordem decrescente.

### spread

1. Crie uma tabela em que cada linha é um dia e cada coluna é o atraso médio de partida por mês.

Resultado esperado:

```
## Source: local data frame [6 x 13]
## 
##   day      1      2      3      4      5      6      7      8       9
## 1   1 11.549 10.853 11.016 12.421  2.903  2.778 56.234 34.574  4.2329
## 2   2 13.859  5.422  8.027  8.260  6.389 34.013 19.285 13.254 53.0296
## 3   3 10.988  7.019  6.066  3.453 14.182 25.310 24.296 12.146  6.9799
## 4   4  8.952 10.924  4.754  6.963  8.820  4.112  4.341  9.390  0.6023
## 5   5  5.732  5.323  5.018  5.905  4.577  4.879  4.858  6.715 -0.3878
## 6   6  7.148  5.622 21.013  4.951  7.596  5.057  7.025  7.415 -0.3979
## Variables not shown: 10 (dbl), 11 (dbl), 12 (dbl)
```

Dica: você precisará usar `group_by`, `summarise`e `spread`. Lembre-se também do argumento `na.rm`.

2. Repita a mesma operação, mas dessa vez cada coluna será uma hora do dia.


Resultado esperado:

```
## Source: local data frame [6 x 32]
## 
##   hour       1       2       3      4       5       6       7       8
## 1    0 120.143 127.387  91.600  34.50 102.882  39.556 168.977 159.240
## 2    1 150.875 185.714 202.000 218.50 159.333 257.000 174.000 166.053
## 3    2      NA 324.000 156.000     NA      NA      NA 216.500 220.500
## 4    3      NA 348.000      NA     NA      NA      NA      NA 273.000
## 5    4  -6.100  -6.500  -4.571  -6.00  -7.300  -6.182  -5.909  -6.000
## 6    5  -4.565  -4.621  -4.427  -4.68  -4.734  -4.593  -4.705  -3.537
## Variables not shown: 9 (dbl), 10 (dbl), 11 (dbl), 12 (dbl), 13 (dbl), 14
##   (dbl), 15 (dbl), 16 (dbl), 17 (dbl), 18 (dbl), 19 (dbl), 20 (dbl), 21
##   (dbl), 22 (dbl), 23 (dbl), 24 (dbl), 25 (dbl), 26 (dbl), 27 (dbl), 28
##   (dbl), 29 (dbl), 30 (dbl), 31 (dbl)
```

### gather

Considerando as tabelas criadas nas perguntas sobre o `spread`:

1. Transforme-as em um formato tidy.

Resultado esperado:

```
## Source: local data frame [6 x 3]
## 
##   day mes  delay
## 1   1   1 11.549
## 2   2   1 13.859
## 3   3   1 10.988
## 4   4   1  8.952
## 5   5   1  5.732
## 6   6   1  7.148
```


### desafios (opcional)

1. Sumarise em uma tabela qual foi a média de atraso total (`dep_delay + arr_delay`) e seu intervalo de confiança por mês, apenas considerando os vôos que atrasaram (tempos negativos não são atrasos).
Dica: o intervalo de confiança pode ser calculado por $média \pm 1,96*\sqrt{\frac{var(x)}{n}}$

2. Summarise em uma tabela quais foram os 10 destinos com mais viagens com atraso superior a 60 minutos. Considere o atraso total definido na pergunta anterior.

---

## Sobre ggplot2

Nestes exercícios você utilizará a base de dados `diamonds`


```r
data(diamonds)
```

### geom_point

### geom_line

### geom_histogram

### geom_boxplot

### geom_bar

### facet_wrap

### facet_grid

### desafios (opcional)

---

# Desafios com bases de dados reais

Primeiro, instale o pacote `abjutils`. Para isso, instale primeiro o pacote `devtools`.


```r
# verifica se o pacote devtools já está instalado e instala se não estiver
if(!require(devtools)) install.packages('devtools')

# verifica se o pacote abjutils já está instalado e instala se não estiver
# Como o pacote não está no CRAN, instalamos via github usando o comando do pacote devtools
if(!require(abjutils)) devtools::install_github('abjur/abjutils')

# OBS: O pacote abjutils já vai carregar as bibliotecas dplyr, stringr e lubridate
```


## PNUD

Vamos começar com a base de dados do PNUD do lab 1, para aquecer :)

Você pode carregar o banco de dados do PNUD rodando


```r
data(pnud_muni , package='abjutils')
```

**1** Refaça todas as análises do laboratório 1 usando `dplyr` e `ggplot2`.

## Coalitions

Essa base de dados contém informações de países que fazem parte da Organização Mundial do Comércio (OMC, em inglês World Trade Organization - WTO). Para melhorar e facilitar o comércio internacional, muitas vezes os países que fazem parte da OMC realizam acordos, que chamamos de _coalizões_. Geralmente uma coalizão
envolve muitos países ao mesmo tempo.


```r
data(wto_data , package='abjutils')
data(wto_dyad_sample, package='abjutils')
```

A base de dados `wto_data` contém informações básicas de cada país, como PIB, PIB _per capita_, latitude, longitude, hemisfério, identificador de regime político, etc. O código do país é dado na variável `ccode`

A base de dados `wto_dyad_sample` contém, em cada linha, uma coalizão ocorrida ou não na Organização Mundial do Comércio, entre dois países (uma "díade" ou, em inglês, _dyad_). 

Os países estão identificados pelas colunas `ccode1` e `ccode2` (analogamente à base `wto_data`). A coalizão é identificada `coalition`, que vale `1` se houve coalizão e `0` caso contrário. A coluna `ccoalition` é um identificador de qual foi a coalizão que aconteceu (Mercosul, acordos da Europa, etc).

**1** Faça um mapa com as posições geográficas dos países, com um mapa múndi no fundo.

Dica: Leia o script da aula 05.

**2**. Qual é a unidade observacional (o que identifica uma observação) na base `wto_data`?

**3**. Quantas coalizões tivemos em cada ano?

**4**. Qual é o código do país que entrou mais vezes em alguma coalizão?

**5**. Construa uma matriz de adjacências usando `dplyr` e `tidyr`. Queremos um `data.frame` `wto_adj` com número de linhas igual ao número de colunas, e o conteúdo da célula `wto_adj[i, j]` é `1` se o país da linha entra em coalizão com o país da coluna em dado ano e dada coalizão, e `0` caso contrário. Utilize a função `row.names()` para atribuir os nomes às linhas.

## CARF

A base de dados do Conselho Administrativo de Recursos Fiscais (CARF) é uma das muitas bases que geralmente temos de lidar na área de jurimetria (estatística aplicada ao direito). Trata-se de uma base de dados sobre processos tributários.

Montamos uma base de dados com todas as decisões encontradas no conselho. Nosso banco de dados tem, inicialmente, 264594 linhas e somente 9 colunas. As variáveis estão descritas abaixo:

- `id`: número sequencial único para identificar cada acórdão.
- `n_processo`: número do processo. 
- `n_decisao`: número da decisão.
- `ano`: ano em que o acórdão foi proferido (de acordo com o site do CARF).
- `tipo_recurso`: identifica se a decisão é sobre um recurso voluntário, recurso de ofício, recurso especial, etc.
- `contribuinte`: identifica o nome do contribuinte, em texto livre.
- `relator`: identifica o nome do relator, em texto livre.
- `txt_ementa`: texto completo da ementa, em texto livre. Geralmente esse texto contém informações do tributo discutido, fundamentação da decisão e decisão.
- `txt_decisao`: texto completo da decisão, em texto livre. Geralmente é uma parte da ementa, contendo apenas a parte relacionada à decisão, mas não é uma regra.

**1** Quantos processos temos na base de dados?

**2** Construa um gráfico contendo o volume de acórdãos em cada ano. Você nota algum ano com comportamento estranho?

**3** Agora retire da base os acórdãos que contêm texto da decisão e texto da ementa vazios. Refaça o gráfico e interprete.

**4** Utilizando a função `str_detect()`, crie colunas (que valem `TRUE` ou `FALSE`) na base de dados de acordo com as expressões regulares abaixo.


```r
negar_provimento <- 'negar?(do)? (o )?provimento|negou se (o )?provimento|recurso nao provido'
dar_provimento <- 'dar?(do)? (o )?provimento|deu se (o )?provimento|recurso provido'
em_parte <- 'em parte|parcial'
diligencia <- 'diligencia'
nao_conhecer <- 'conhec'
anular <- 'nul(a|o|i)'
```

**5** Faça um gráfico de barras mostrando a quantidade de acórdãos em que foi dado provimento, negado provimento, etc. Considere somente os casos em que `tipo_recurso` é recurso voluntário.

## SABESP

Usando um _web crawler_ desenvolvido em R, fizemos o download da base de dados da SABESP. Quem tiver interesse nesses dados, acesse [aqui](https://github.com/jtrecenti/sabesp).


```r
data(sabesp, package='abjutils')
```

**1** Descreva a base de dados.

**2** Crie um boxplot por mês, mostrando os lugares separadamente.

**3** Tente montar um gráfico parecido com esse (inclusive as cores e as labels inclinadas do eixo x). Não vale olhar o código do repositório no github!

<img src="https://raw.githubusercontent.com/jtrecenti/sabesp/master/sabesp_files/figure-html/unnamed-chunk-2-2.png"> </img>

**4** Construa uma tabela descritiva contendo a média, mediana, desvio padrão, primeiro e terceiro quartis em relação à pluviometria, agrupando por ano e por lugar.

**5** Comente sobre a crise hídrica em São Paulo com base em conhecimentos próprios e usando os dados da sabesp.
