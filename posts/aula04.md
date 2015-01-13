---
title: Aula 04 - Manipulação de dados
date : 2015-01-26
# output: ioslides_presentation
---



## Manipulação de dados com dplyr

A manipulação de dados é uma tarefa usualmente bastante
dolorosa e demorada, podendo muitas vezes tomar mais tempo do que desejaríamos. No entanto,
como nosso interesse geralmente é na modelagem dos dados, essa tarefa é muitas vezes negligenciada.

---

O `dplyr` é um dos pacotes mais úteis para realizar manipulação de dados, e procura aliar 
simplicidade e eficiência de uma forma bastante elegante. Os scripts em `R` que fazem uso 
inteligente dos verbos `dplyr` e as facilidades do operador _pipe_ tendem a ficar mais legíveis e 
organizados, sem perder velocidade de execução.

---

Por ser um pacote que se propõe a realizar um dos trabalhos mais árduos da análise estatística,
e por atingir esse objetivo de forma elegante, eficaz e eficiente, o `dplyr` pode ser considerado 
como uma revolução no `R`.

---

### Trabalhando com tbl e tbl_df


```r
pnud <- tbl_df(pnud)
pnud
```

```
## Source: local data frame [16,695 x 237]
## 
##     ANO UF Codmun6 Codmun7             Município ESPVIDA FECTOT MORT1
## 1  1991 11  110001 1100015 ALTA FLORESTA D'OESTE   62.01   4.08 45.58
## 2  1991 11  110002 1100023             ARIQUEMES   66.02   3.72 32.39
## 3  1991 11  110003 1100031                CABIXI   63.16   3.89 41.52
## 4  1991 11  110004 1100049                CACOAL   65.03   3.81 35.37
## 5  1991 11  110005 1100056            CEREJEIRAS   62.73   3.55 43.00
## 6  1991 11  110006 1100064     COLORADO DO OESTE   64.46   3.38 37.19
## 7  1991 11  110007 1100072            CORUMBIARA   59.32   3.95 56.02
## 8  1991 11  110008 1100080         COSTA MARQUES   62.76   4.19 42.90
## 9  1991 11  110009 1100098       ESPIGÃO D'OESTE   64.18   3.84 38.09
## 10 1991 11  110010 1100106         GUAJARÁ-MIRIM   64.71   4.19 36.41
## ..  ... ..     ...     ...                   ...     ...    ...   ...
## Variables not shown: MORT5 (dbl), RAZDEP (dbl), SOBRE40 (dbl), SOBRE60
##   (dbl), T_ENV (dbl), E_ANOSESTUDO (dbl), T_ANALF11A14 (dbl), T_ANALF15A17
##   (dbl), T_ANALF15M (dbl), T_ANALF18A24 (dbl), T_ANALF18M (dbl),
##   T_ANALF25A29 (dbl), T_ANALF25M (dbl), T_ATRASO_0_BASICO (dbl),
##   T_ATRASO_0_FUND (dbl), T_ATRASO_0_MED (dbl), T_ATRASO_1_BASICO (dbl),
##   T_ATRASO_1_FUND (dbl), T_ATRASO_1_MED (dbl), T_ATRASO_2_BASICO (dbl),
##   T_ATRASO_2_FUND (dbl), T_ATRASO_2_MED (dbl), T_FBBAS (dbl), T_FBFUND
##   (dbl), T_FBMED (dbl), T_FBPRE (dbl), T_FBSUPER (dbl), T_FLBAS (dbl),
##   T_FLFUND (dbl), T_FLMED (dbl), T_FLPRE (dbl), T_FLSUPER (dbl), T_FREQ0A3
##   (dbl), T_FREQ11A14 (dbl), T_FREQ15A17 (dbl), T_FREQ18A24 (dbl),
##   T_FREQ25A29 (dbl), T_FREQ4A5 (dbl), T_FREQ4A6 (dbl), T_FREQ5A6 (dbl),
##   T_FREQ6 (dbl), T_FREQ6A14 (dbl), T_FREQ6A17 (dbl), T_FREQFUND1517 (dbl),
##   T_FREQFUND1824 (dbl), T_FREQFUND45 (dbl), T_FREQMED1824 (dbl),
##   T_FREQMED614 (dbl), T_FREQSUPER1517 (dbl), T_FUND11A13 (dbl),
##   T_FUND12A14 (dbl), T_FUND15A17 (dbl), T_FUND16A18 (dbl), T_FUND18A24
##   (dbl), T_FUND18M (dbl), T_FUND25M (dbl), T_MED18A20 (dbl), T_MED18A24
##   (dbl), T_MED18M (dbl), T_MED19A21 (dbl), T_MED25M (dbl), T_SUPER25M
##   (dbl), CORTE1 (dbl), CORTE2 (dbl), CORTE3 (dbl), CORTE4 (dbl), CORTE9
##   (dbl), GINI (dbl), PIND (dbl), PINDCRI (dbl), PMPOB (dbl), PMPOBCRI
##   (dbl), PPOB (dbl), PPOBCRI (dbl), PREN10RICOS (dbl), PREN20 (dbl),
##   PREN20RICOS (dbl), PREN40 (dbl), PREN60 (dbl), PREN80 (dbl), PRENTRAB
##   (dbl), R1040 (dbl), R2040 (dbl), RDPC (dbl), RDPC1 (dbl), RDPC10 (dbl),
##   RDPC2 (dbl), RDPC3 (dbl), RDPC4 (dbl), RDPC5 (dbl), RDPCT (dbl), RIND
##   (dbl), RMPOB (dbl), RPOB (dbl), THEIL (dbl), CPR (dbl), EMP (dbl),
##   P_AGRO (dbl), P_COM (dbl), P_CONSTR (dbl), P_EXTR (dbl), P_FORMAL (dbl),
##   P_FUND (dbl), P_MED (dbl), P_SERV (dbl), P_SIUP (dbl), P_SUPER (dbl),
##   P_TRANSF (dbl), REN0 (dbl), REN1 (dbl), REN2 (dbl), REN3 (dbl), REN5
##   (dbl), RENOCUP (dbl), T_ATIV (dbl), T_ATIV1014 (dbl), T_ATIV1517 (dbl),
##   T_ATIV1824 (dbl), T_ATIV18M (dbl), T_ATIV2529 (dbl), T_DES (dbl),
##   T_DES1014 (dbl), T_DES1517 (dbl), T_DES1824 (dbl), T_DES18M (dbl),
##   T_DES2529 (dbl), THEILtrab (dbl), TRABCC (dbl), TRABPUB (dbl), TRABSC
##   (dbl), T_AGUA (dbl), T_BANAGUA (dbl), T_DENS (dbl), T_LIXO (dbl), T_LUZ
##   (dbl), AGUA_ESGOTO (dbl), PAREDE (dbl), T_CRIFUNDIN_TODOS (dbl),
##   T_FORA4A5 (dbl), T_FORA6A14 (dbl), T_FUNDIN_TODOS (dbl),
##   T_FUNDIN_TODOS_MMEIO (dbl), T_FUNDIN18MINF (dbl), T_M10A14CF (dbl),
##   T_M15A17CF (dbl), T_MULCHEFEFIF014 (dbl), T_NESTUDA_NTRAB_MMEIO (dbl),
##   T_OCUPDESLOC_1 (dbl), T_RMAXIDOSO (dbl), T_SLUZ (dbl), HOMEM0A4 (int),
##   HOMEM10A14 (int), HOMEM15A19 (int), HOMEM20A24 (int), HOMEM25A29 (int),
##   HOMEM30A34 (int), HOMEM35A39 (int), HOMEM40A44 (int), HOMEM45A49 (int),
##   HOMEM50A54 (int), HOMEM55A59 (int), HOMEM5A9 (int), HOMEM60A64 (int),
##   HOMEM65A69 (int), HOMEM70A74 (int), HOMEM75A79 (int), HOMEMTOT (int),
##   HOMENS80 (int), MULH0A4 (int), MULH10A14 (int), MULH15A19 (int),
##   MULH20A24 (int), MULH25A29 (int), MULH30A34 (int), MULH35A39 (int),
##   MULH40A44 (int), MULH45A49 (int), MULH50A54 (int), MULH55A59 (int),
##   MULH5A9 (int), MULH60A64 (int), MULH65A69 (int), MULH70A74 (int),
##   MULH75A79 (int), MULHER80 (int), MULHERTOT (int), PEA (int), PEA1014
##   (int), PEA1517 (int), PEA18M (int), peso1 (int), PESO1114 (int),
##   PESO1113 (int), PESO1214 (int), peso13 (int), PESO15 (int), peso1517
##   (int), PESO1524 (int), PESO1618 (int), PESO18 (int), Peso1820 (int),
##   PESO1824 (int), Peso1921 (int), PESO25 (int), peso4 (int), peso5 (int),
##   peso6 (int), PESO610 (int), Peso617 (int), PESO65 (int), PESOM1014
##   (int), PESOM1517 (int), PESOM15M (int), PESOM25M (int), pesoRUR (int),
##   pesotot (int), pesourb (int), PIA (int), PIA1014 (int), PIA1517 (int),
##   PIA18M (int), POP (int), POPT (int), I_ESCOLARIDADE (dbl), I_FREQ_PROP
##   (dbl), IDHM (dbl), IDHM_E (dbl), IDHM_L (dbl), IDHM_R (dbl)
```

---

### Filosofia do Hadley para análise de dados

<img src="assets/fig/hadley_view.png" style="width: 800px;"/>

---

### As cinco funções principais do dplyr

- `filter`
- `mutate`
- `select`
- `arrange`
- `summarise`

---

#### Características

- O _input_  é sempre um `data.frame` (`tbl`), e o _output_  é sempre um `data.frame` (`tbl`).
- No primeiro argumento colocamos o `data.frame`, e nos outros argumentos colocamo o que queremos fazer.
- A utilização é facilitada com o emprego do operador `%>%`

#### Vantagens

- Utiliza `C` e `C++` por trás da maioria das funções, o que geralmente torna o código mais eficiente.
- Pode trabalhar com diferentes fontes de dados, como bases relacionais (SQL) e `data.table`.

## select

- Utilizar `starts_with(x)`, `contains(x)`, `matches(x)`, `one_of(x)`, etc.
- Possível colocar nomes, índices, e intervalos de variáveis com `:`.

---


```r
# por indice (nao recomendavel!)
pnud %>%
  select(1:10)
```

```
## Source: local data frame [16,695 x 10]
## 
##     ANO UF Codmun6 Codmun7             Município ESPVIDA FECTOT MORT1
## 1  1991 11  110001 1100015 ALTA FLORESTA D'OESTE   62.01   4.08 45.58
## 2  1991 11  110002 1100023             ARIQUEMES   66.02   3.72 32.39
## 3  1991 11  110003 1100031                CABIXI   63.16   3.89 41.52
## 4  1991 11  110004 1100049                CACOAL   65.03   3.81 35.37
## 5  1991 11  110005 1100056            CEREJEIRAS   62.73   3.55 43.00
## 6  1991 11  110006 1100064     COLORADO DO OESTE   64.46   3.38 37.19
## 7  1991 11  110007 1100072            CORUMBIARA   59.32   3.95 56.02
## 8  1991 11  110008 1100080         COSTA MARQUES   62.76   4.19 42.90
## 9  1991 11  110009 1100098       ESPIGÃO D'OESTE   64.18   3.84 38.09
## 10 1991 11  110010 1100106         GUAJARÁ-MIRIM   64.71   4.19 36.41
## ..  ... ..     ...     ...                   ...     ...    ...   ...
## Variables not shown: MORT5 (dbl), RAZDEP (dbl)
```

---


```r
# especificando nomes (maneira mais usual)
pnud %>%
  select(ANO, UF, Municipio, IDHM)
```

```
## Error: object 'Municipio' not found
```

---


```r
# intervalos e funcoes auxiliares (para economizar trabalho)
pnud %>%
  select(ANO:Municipio, starts_with('IDHM'))
```

```
## Error: object 'Municipio' not found
```

---

### Exercício

## filter

- Parecido com `subset`.
- Condições separadas por vírgulas é o mesmo que separar por `&`.

---


```r
# somente estado de SP, com IDH municipal maior que 80% no ano 2010
pnud %>%
  select(ANO, UF, Municipio, IDHM) %>%
  filter(UF==35, IDHM > .8, ANO==2010)
```

```
## Error: object 'Municipio' not found
```

---


```r
# mesma coisa que o anterior
pnud %>%
  select(ANO, UF, Municipio, IDHM) %>%
  filter(UF==35 & IDHM > .8 & ANO==2010)
```

```
## Error: object 'Municipio' not found
```

---


```r
# !is.na(x)
pnud %>%
  select(ANO, UF, Municipio, IDHM, PEA) %>%
  filter(!is.na(PEA))
```

```
## Error: object 'Municipio' not found
```

---


```r
# %in%
pnud %>%
  select(ANO, UF, Municipio, IDHM) %>%
  filter(Municipio %in% c('CAMPINAS', 'SÃO PAULO'))
```

```
## Error: object 'Municipio' not found
```

---

### Exercício

## mutate

- Parecido com `transform`, mas aceita várias novas colunas iterativamente.
- Novas variáveis devem ter o mesmo `length` que o `nrow` do bd oridinal ou `1`.

---


```r
pnud %>%
  select(ANO, UF, Municipio, IDHM) %>%
  filter(ANO==2010) %>%
  mutate(idhm_porc = IDHM * 100,
         idhm_porc_txt = paste(idhm_porc, '%'))
```

```
## Error: object 'Municipio' not found
```

---


```r
# media de idhm_l e idhm_e
pnud %>%
  select(ANO, UF, Municipio, starts_with('IDHM')) %>%
  filter(ANO==2010) %>%
  mutate(idhm2 = (IDHM_E + IDHM_L)/2)
```

```
## Error: object 'Municipio' not found
```

---


```r
## errado
# pnud %>%
#   select(ANO, UF, Municipio, starts_with('IDHM')) %>%
#   filter(ANO==2010) %>%
#   mutate(idhm2 = mean(c(IDHM_E, IDHM_L)))

## uma alternativa (+ demorada)
# pnud %>%
#   select(ANO, UF, Municipio, starts_with('IDHM')) %>%
#   filter(ANO==2010) %>%
#   rowwise() %>%
#   mutate(idhm2 = mean(c(IDHM_E, IDHM_L)))
```

---

### Exercício

## arrange

- Simplesmente ordena de acordo com as opções.
- Utilizar `desc` para ordem decrescente.

---


```r
pnud %>%
  select(ANO, UF, Municipio, IDHM) %>%
  filter(ANO==2010) %>%
  mutate(idhm_porc = IDHM * 100,
         idhm_porc_txt = paste(idhm_porc, '%')) %>%
  arrange(IDHM)
```

```
## Error: object 'Municipio' not found
```

---


```r
pnud %>%
  select(ANO, UF, Municipio, IDHM) %>%
  filter(ANO==2010) %>%
  mutate(idhm_porc = IDHM * 100,
         idhm_porc_txt = paste(idhm_porc, '%')) %>%
  arrange(desc(IDHM))
```

```
## Error: object 'Municipio' not found
```

---

### Exercício

## summarise

- Retorna um vetor de tamanho `1` a partir de uma conta com as variáveis.
- Geralmente é utilizado em conjunto com `group_by`.
- Algumas funções importantes: `n()`, `n_distinct()`.

---


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
## 1  53   1     0.8240         2541714
## 2  35 645     0.7395        40915379
## 3  42 293     0.7316         6199947
## 4  43 496     0.7135        10593371
## 5  33  92     0.7089        15871447
## 6  41 399     0.7020        10348247
## 7  52 246     0.6950         5934769
## 8  32  78     0.6922         3477471
## 9  51 141     0.6843         2961982
## 10 50  78     0.6797         2404631
## 11 31 853     0.6679        19383599
## 12 11  52     0.6440         1515023
## 13 16  16     0.6428          652768
## 14 17 139     0.6399         1349774
## 15 23 184     0.6166         8317603
## 16 24 167     0.6109         3127816
## 17 14  15     0.6102          421159
## 18 28  75     0.5969         2038462
## 19 26 185     0.5962         8646411
## 20 29 417     0.5939        13755196
## 21 25 223     0.5877         3706988
## 22 12  22     0.5861          690774
## 23 15 143     0.5815         7247981
## 24 21 217     0.5762         6317986
## 25 22 224     0.5710         3050831
## 26 13  62     0.5651         3301220
## 27 27 102     0.5635         3045853
```

---


```r
pnud %>%
  filter(ANO==2010) %>%  
  count(UF)
```

```
## Error: could not find function "count"
```

----


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

---

### Exercício

## Data Tidying com tidyr

### Sobre tidy data

- Cada observação é uma linha do bd.
- Cada variável é uma coluna do bd.
- Para cada unidade observacional temos um bd separado (possivelmente com chaves de associacao).

---

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

---

### gather

- "Empilha" o banco de dados


```r
pnud %>%
  filter(ANO==2010) %>%
  select(UF, Municipio, starts_with('IDHM_')) %>%
  gather(tipo_idh, idh, starts_with('IDHM_'))
```

```
## Error: object 'Municipio' not found
```

---

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
