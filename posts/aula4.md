---
title: Aula 4 - Manipulação de dados
date : 2014-12-04
---



## Manipulação de dados com dplyr

A manipulação de dados é uma tarefa usualmente bastante
dolorosa e demorada, podendo muitas vezes tomar mais tempo do que desejaríamos. No entanto,
como nosso interesse geralmente é na modelagem dos dados, essa tarefa é muitas vezes negligenciada.

O `dplyr` é um dos pacotes mais úteis para realizar manipulação de dados, e procura aliar 
simplicidade e eficiência de uma forma bastante elegante. Os scripts em `R` que fazem uso 
inteligente dos verbos `dplyr` e as facilidades do operador _pipe_ tendem a ficar mais legíveis e 
organizados, sem perder velocidade de execução.

Por ser um pacote que se propõe a realizar um dos trabalhos mais árduos da análise estatística,
e por atingir esse objetivo de forma elegante, eficaz e eficiente, o `dplyr` pode ser considerado 
como uma revolução no `R`.

### Trabalhando com tbl e tbl_df


```r
pnud <- tbl_df(pnud)
```

```
## Error in is.data.frame(data): object 'pnud' not found
```

```r
pnud
```

```
## Error in eval(expr, envir, enclos): object 'pnud' not found
```

### Filosofia do Hadley para análise de dados

<img src="assets/fig/hadley_view.png" style="width: 800px;"/>

### As cinco funções principais do dplyr

- `filter`
- `mutate`
- `select`
- `arrange`
- `summarise`

#### Características

- O _input_  é sempre um `data.frame` (`tbl`), e o _output_  é sempre um `data.frame` (`tbl`).
- No primeiro argumento colocamos o `data.frame`, e nos outros argumentos colocamo o que queremos fazer.
- A utilização é facilitada com o emprego do operador `%>%`

#### Vantagens

- Utiliza `C` e `C++` por trás da maioria das funções, o que geralmente torna o código mais eficiente.
- Pode trabalhar com diferentes fontes de dados, como bases relacionais (SQL) e `data.table`.

### select

- Utilizar `starts_with(x)`, `contains(x)`, `matches(x)`, `one_of(x)`, etc.
- Possível colocar nomes, índices, e intervalos de variáveis com `:`.


```r
# por indice (nao recomendavel!)
pnud %>%
  select(1:10)
```

```
## Error in eval(expr, envir, enclos): object 'pnud' not found
```


```r
# especificando nomes (maneira mais usual)
pnud %>%
  select(ANO, UF, Município, IDHM)
```

```
## Error in eval(expr, envir, enclos): object 'pnud' not found
```


```r
# intervalos e funcoes auxiliares (para economizar trabalho)
pnud %>%
  select(ANO:Município, starts_with('IDHM'))
```

```
## Error in eval(expr, envir, enclos): object 'pnud' not found
```

### filter

- Parecido com `subset`.
- Condições separadas por vírgulas é o mesmo que separar por `&`.


```r
# somente estado de SP, com IDH municipal maior que 80% no ano 2010
pnud %>%
  select(ANO, UF, Município, IDHM) %>%
  filter(UF==35, IDHM > .8, ANO==2010)
```

```
## Error in eval(expr, envir, enclos): object 'pnud' not found
```


```r
# mesma coisa que o anterior
pnud %>%
  select(ANO, UF, Município, IDHM) %>%
  filter(UF==35 & IDHM > .8 & ANO==2010)
```

```
## Error in eval(expr, envir, enclos): object 'pnud' not found
```


```r
# !is.na(x)
pnud %>%
  select(ANO, UF, Município, IDHM, PEA) %>%
  filter(!is.na(PEA))
```

```
## Error in eval(expr, envir, enclos): object 'pnud' not found
```


```r
# %in%
pnud %>%
  select(ANO, UF, Município, IDHM) %>%
  filter(Município %in% c('CAMPINAS', 'SÃO PAULO'))
```

```
## Error in eval(expr, envir, enclos): object 'pnud' not found
```

### mutate

- Parecido com `transform`, mas aceita várias novas colunas iterativamente.
- Novas variáveis devem ter o mesmo `length` que o `nrow` do bd oridinal ou `1`.


```r
pnud %>%
  select(ANO, UF, Município, IDHM) %>%
  filter(ANO==2010) %>%
  mutate(idhm_porc = IDHM * 100,
         idhm_porc_txt = paste(idhm_porc, '%'))
```

```
## Error in eval(expr, envir, enclos): object 'pnud' not found
```


```r
# media de idhm_l e idhm_e
pnud %>%
  select(ANO, UF, Município, starts_with('IDHM')) %>%
  filter(ANO==2010) %>%
  mutate(idhm2 = (IDHM_E + IDHM_L)/2)
```

```
## Error in eval(expr, envir, enclos): object 'pnud' not found
```

```r
## errado
# pnud %>%
#   select(ANO, UF, Município, starts_with('IDHM')) %>%
#   filter(ANO==2010) %>%
#   mutate(idhm2 = mean(c(IDHM_E, IDHM_L)))

## uma alternativa (+ demorada)
# pnud %>%
#   select(ANO, UF, Município, starts_with('IDHM')) %>%
#   filter(ANO==2010) %>%
#   rowwise() %>%
#   mutate(idhm2 = mean(c(IDHM_E, IDHM_L)))
```

### arrange

- Simplesmente ordena de acordo com as opções.
- Utilizar `desc` para ordem decrescente.


```r
pnud %>%
  select(ANO, UF, Município, IDHM) %>%
  filter(ANO==2010) %>%
  mutate(idhm_porc = IDHM * 100,
         idhm_porc_txt = paste(idhm_porc, '%')) %>%
  arrange(IDHM)
```

```
## Error in eval(expr, envir, enclos): object 'pnud' not found
```


```r
pnud %>%
  select(ANO, UF, Município, IDHM) %>%
  filter(ANO==2010) %>%
  mutate(idhm_porc = IDHM * 100,
         idhm_porc_txt = paste(idhm_porc, '%')) %>%
  arrange(desc(IDHM))
```

```
## Error in eval(expr, envir, enclos): object 'pnud' not found
```

### summarise

- Retorna um vetor de tamanho `1` a partir de uma conta com as variáveis.
- Geralmente é utilizado em conjunto com `group_by`.
- Algumas funções importantes: `n()`, `n_distinct()`.


```r
pnud %>%
  filter(ANO==2010) %>%  
  group_by(UF) %>%
  summarise(n=n(), 
            idhm_medio=mean(IDHM),
            populacao_total=sum(POPT)) %>%
  arrange(desc(idhm_medio))
```

```
## Source: local data frame [27 x 4]
## 
##    UF   n idhm_medio populacao_total
## 1  53   1  0.8240000         2541714
## 2  35 645  0.7395271        40915379
## 3  42 293  0.7316485         6199947
## 4  43 496  0.7135302        10593371
## 5  33  92  0.7089130        15871447
## 6  41 399  0.7019599        10348247
## 7  52 246  0.6949837         5934769
## 8  32  78  0.6921923         3477471
## 9  51 141  0.6842908         2961982
## 10 50  78  0.6797051         2404631
## 11 31 853  0.6678781        19383599
## 12 11  52  0.6440385         1515023
## 13 16  16  0.6428125          652768
## 14 17 139  0.6399281         1349774
## 15 23 184  0.6166304         8317603
## 16 24 167  0.6108503         3127816
## 17 14  15  0.6102000          421159
## 18 28  75  0.5969333         2038462
## 19 26 185  0.5962486         8646411
## 20 29 417  0.5939041        13755196
## 21 25 223  0.5876547         3706988
## 22 12  22  0.5860909          690774
## 23 15 143  0.5815455         7247981
## 24 21 217  0.5761843         6317986
## 25 22 224  0.5710491         3050831
## 26 13  62  0.5651129         3301220
## 27 27 102  0.5635000         3045853
```



```r
pnud %>%
  filter(ANO==2010) %>%  
  count(UF)
```

```
## Source: local data frame [27 x 2]
## 
##    UF   n
## 1  11  52
## 2  12  22
## 3  13  62
## 4  14  15
## 5  15 143
## 6  16  16
## 7  17 139
## 8  21 217
## 9  22 224
## 10 23 184
## 11 24 167
## 12 25 223
## 13 26 185
## 14 27 102
## 15 28  75
## 16 29 417
## 17 31 853
## 18 32  78
## 19 33  92
## 20 35 645
## 21 41 399
## 22 42 293
## 23 43 496
## 24 50  78
## 25 51 141
## 26 52 246
## 27 53   1
```


```r
pnud %>%
  group_by(ANO, UF) %>%
  tally() %>%
  head # nao precisa de parenteses!
```

```
## Source: local data frame [6 x 3]
## Groups: ANO
## 
##    ANO UF   n
## 1 1991 11  52
## 2 1991 12  22
## 3 1991 13  62
## 4 1991 14  15
## 5 1991 15 143
## 6 1991 16  16
```

## Data Tidying com tidyr

### Sobre tidy data

- Cada observação é uma linha do bd.
- Cada variável é uma coluna do bd.
- Para cada unidade observacional temos um bd separado (possivelmente com chaves de associacao).

### spread

- "Joga" uma variável nas colunas


```r
pnud %>%
  group_by(ANO, UF) %>%
  summarise(populacao=sum(POPT)) %>%
  ungroup() %>%
  spread(ANO, populacao)
```

```
## Source: local data frame [27 x 4]
## 
##    UF     1991     2000     2010
## 1  11  1082711  1306213  1515023
## 2  12   414609   519639   690774
## 3  13  1977073  2543710  3301220
## 4  14   172314   296263   421159
## 5  15  4798976  5817542  7247981
## 6  16   280599   453547   652768
## 7  17   891051  1066193  1349774
## 8  21  4803825  5258529  6317986
## 9  22  2519184  2699084  3050831
## 10 23  6255097  6995427  8317603
## 11 24  2356168  2613636  3127816
## 12 25  3126315  3290779  3706988
## 13 26  6993504  7527891  8646411
## 14 27  2448544  2611271  3045853
## 15 28  1462008  1710603  2038462
## 16 29 11522516 12286822 13755196
## 17 31 15466865 17468072 19383599
## 18 32  2562362  3048681  3477471
## 19 33 12614621 14207409 15871447
## 20 35 31053551 36529439 40915379
## 21 41  8297807  9364063 10348247
## 22 42  4459708  5268781  6199947
## 23 43  8978875 10022774 10593371
## 24 50  1739157  2018872  2404631
## 25 51  1951174  2380431  2961982
## 26 52  3931474  4887131  5934769
## 27 53  1551869  2001728  2541714
```

### gather

- "Empilha" o banco de dados


```r
pnud %>%
  filter(ANO==2010) %>%
  select(UF, Município, starts_with('IDHM_')) %>%
  gather(tipo_idh, idh, starts_with('IDHM_'))
```

```
## Source: local data frame [16,695 x 4]
## 
##    UF             Município tipo_idh   idh
## 1  11 ALTA FLORESTA D'OESTE   IDHM_E 0.526
## 2  11             ARIQUEMES   IDHM_E 0.600
## 3  11                CABIXI   IDHM_E 0.559
## 4  11                CACOAL   IDHM_E 0.620
## 5  11            CEREJEIRAS   IDHM_E 0.602
## 6  11     COLORADO DO OESTE   IDHM_E 0.584
## 7  11            CORUMBIARA   IDHM_E 0.473
## 8  11         COSTA MARQUES   IDHM_E 0.493
## 9  11       ESPIGÃO D'OESTE   IDHM_E 0.536
## 10 11         GUAJARÁ-MIRIM   IDHM_E 0.519
## .. ..                   ...      ...   ...
```

### Funções auxiliares

- `unite` junta duas ou mais colunas usando algum separador (`_`, por exemplo).
- `separate` faz o inverso de `unite`, e uma coluna em várias usando um separador.

## Um pouco mais de manipulação de dados

- Para juntar tabelas, usar `inner_join`, `left_join`, `anti_join`, etc.
- Para realizar operações mais gerais, usar `do`.
- Para retirar duplicatas, utilizar `distinct`.

### Outros pacotes úteis para limpar bases de dados

- `stringr` para trabalhar com textos.
- `lubridate` para trabalhar com datas.
- `rvest` para trabalhar com arquivos HTML.

<hr/ >
