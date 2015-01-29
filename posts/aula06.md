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

```
## Error in library(nycflights13): there is no package called 'nycflights13'
```

Se você não tiver o pacote instalado use o comando:


```r
install.packages("nycflighs13")
```

E em seguida use o `library(nycflights13)`.


```r
library(dplyr)
```

```
## Error in library(dplyr): there is no package called 'dplyr'
```

```r
flights %>% tbl_df
```

```
## Error in eval(expr, envir, enclos): could not find function "%>%"
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
## Error in library(tidyr): there is no package called 'tidyr'
```

```
## Error in eval(expr, envir, enclos): could not find function "%>%"
```

Dica: você precisará usar `group_by`, `summarise`e `spread`. Lembre-se também do argumento `na.rm`.

2. Repita a mesma operação, mas dessa vez cada coluna será uma hora do dia.


Resultado esperado:

```
## Error in eval(expr, envir, enclos): could not find function "%>%"
```

### gather

Considerando as tabelas criadas nas perguntas sobre o `spread`:

1. Transforme-as em um formato tidy.

Resultado esperado:

```
## Error in eval(expr, envir, enclos): could not find function "%>%"
```


### desafios (opcional)

1. Sumarise em uma tabela qual foi a média de atraso total (`dep_delay + arr_delay`) e seu intervalo de confiança por mês, apenas considerando os vôos que atrasaram (tempos negativos não são atrasos).
Dica: o intervalo de confiança pode ser calculado por $média \pm 1,96*\sqrt{\frac{var(x)}{n}}$

2. Summarise em uma tabela quais foram os 10 destinos com mais viagens com atraso superior a 60 minutos. Considere o atraso total definido na pergunta anterior.

---

## Sobre ggplot2

Nestes exercícios você utilizará a base de dados `diamonds`, do pacote `ggplot2`.

Instalação do pacote `ggplot2`:


```r
install.packages("ggplot2")
```

Para carregar o pacote `ggplot2`:


```r
library(ggplot2)
```

Enfim, os dados:


```r
head(diamonds, 10)
```

```
##    carat       cut color clarity depth table price    x    y    z
## 1   0.23     Ideal     E     SI2  61.5    55   326 3.95 3.98 2.43
## 2   0.21   Premium     E     SI1  59.8    61   326 3.89 3.84 2.31
## 3   0.23      Good     E     VS1  56.9    65   327 4.05 4.07 2.31
## 4   0.29   Premium     I     VS2  62.4    58   334 4.20 4.23 2.63
## 5   0.31      Good     J     SI2  63.3    58   335 4.34 4.35 2.75
## 6   0.24 Very Good     J    VVS2  62.8    57   336 3.94 3.96 2.48
## 7   0.24 Very Good     I    VVS1  62.3    57   336 3.95 3.98 2.47
## 8   0.26 Very Good     H     SI1  61.9    55   337 4.07 4.11 2.53
## 9   0.22      Fair     E     VS2  65.1    61   337 3.87 3.78 2.49
## 10  0.23 Very Good     H     VS1  59.4    61   338 4.00 4.05 2.39
```

Para ver uma descrição das variáveis deste banco de dados, utilize a função `help()`:


```r
help(diamonds)
```


## Geral

**1.** Segundo a *Grammar of Graphics*, o que é um gráfico estatístico? Responda de forma sucinta.

**2.** Qual operador é usado para acrescentar *camadas* em um gráfico no ggplot?

### geom_point

**3.** Quais são os aspectos estéticos (*aesthetics*) exigidos (obrigatórios) da função `geom_point()`?

Dica: utilizar a função `help()`.

**4.** Faça um gráfico de dispersão do preço (*price*) pela variável quilates (*carat*). Utilize as funções `xlab()` e `ylab()` para trocar os *labels* dos eixos x e y, respectivamente.

**5.** Utilize a função `facet_grid()` ou `facet_wrap()` para fazer gráficos de dispersão do preço pela variável quilate (o mesmo gráfico do exercício 1) para cada nível da variável claridade (*clarity*).

### geom_line

**6.** Quais são os aspectos estéticos (*aesthetics*) exigidos (obrigatórios) da função `geom_line()`?

Dica: visitar o [a](www.google.com).

### geom_histogram

**.** Faça um histograma da variável preço. 

**.** Utilize a função `geom_density()` para **adicionar** ao gráfico anterior uma estimativa suavizada da densidade. Por que, neste caso, é preciso especificar o argumento `y = ` como `..density..`?


### geom_boxplot

) Faça boxplots da variável preço pela variável corte.

### geom_bar


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
