---
title: Aula 04 - Manipulação de dados
date : 2015-01-26
---

<a href="http://curso-r.github.io/slides/aula_04_apresentacao.html" target="_blank">Slides dessa aula</a>

<a href="http://curso-r.github.io/script/aula_04.R" target="_blank">Script dessa aula</a>



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
pnud_muni <- tbl_df(pnud_muni)
pnud_muni
```

```
## Source: local data frame [16,695 x 238]
## 
##    uf  ano codmun6 codmun7             municipio espvida fectot mort1
## 1  11 1991  110001 1100015 ALTA FLORESTA D'OESTE   62.01   4.08 45.58
## 2  11 1991  110002 1100023             ARIQUEMES   66.02   3.72 32.39
## 3  11 1991  110003 1100031                CABIXI   63.16   3.89 41.52
## 4  11 1991  110004 1100049                CACOAL   65.03   3.81 35.37
## 5  11 1991  110005 1100056            CEREJEIRAS   62.73   3.55 43.00
## 6  11 1991  110006 1100064     COLORADO DO OESTE   64.46   3.38 37.19
## 7  11 1991  110007 1100072            CORUMBIARA   59.32   3.95 56.02
## 8  11 1991  110008 1100080         COSTA MARQUES   62.76   4.19 42.90
## 9  11 1991  110009 1100098       ESPIGÃO D'OESTE   64.18   3.84 38.09
## 10 11 1991  110010 1100106         GUAJARÁ-MIRIM   64.71   4.19 36.41
## .. ..  ...     ...     ...                   ...     ...    ...   ...
## Variables not shown: mort5 (dbl), razdep (dbl), sobre40 (dbl), sobre60
##   (dbl), t_env (dbl), e_anosestudo (dbl), t_analf11a14 (dbl), t_analf15a17
##   (dbl), t_analf15m (dbl), t_analf18a24 (dbl), t_analf18m (dbl),
##   t_analf25a29 (dbl), t_analf25m (dbl), t_atraso_0_basico (dbl),
##   t_atraso_0_fund (dbl), t_atraso_0_med (dbl), t_atraso_1_basico (dbl),
##   t_atraso_1_fund (dbl), t_atraso_1_med (dbl), t_atraso_2_basico (dbl),
##   t_atraso_2_fund (dbl), t_atraso_2_med (dbl), t_fbbas (dbl), t_fbfund
##   (dbl), t_fbmed (dbl), t_fbpre (dbl), t_fbsuper (dbl), t_flbas (dbl),
##   t_flfund (dbl), t_flmed (dbl), t_flpre (dbl), t_flsuper (dbl), t_freq0a3
##   (dbl), t_freq11a14 (dbl), t_freq15a17 (dbl), t_freq18a24 (dbl),
##   t_freq25a29 (dbl), t_freq4a5 (dbl), t_freq4a6 (dbl), t_freq5a6 (dbl),
##   t_freq6 (dbl), t_freq6a14 (dbl), t_freq6a17 (dbl), t_freqfund1517 (dbl),
##   t_freqfund1824 (dbl), t_freqfund45 (dbl), t_freqmed1824 (dbl),
##   t_freqmed614 (dbl), t_freqsuper1517 (dbl), t_fund11a13 (dbl),
##   t_fund12a14 (dbl), t_fund15a17 (dbl), t_fund16a18 (dbl), t_fund18a24
##   (dbl), t_fund18m (dbl), t_fund25m (dbl), t_med18a20 (dbl), t_med18a24
##   (dbl), t_med18m (dbl), t_med19a21 (dbl), t_med25m (dbl), t_super25m
##   (dbl), corte1 (dbl), corte2 (dbl), corte3 (dbl), corte4 (dbl), corte9
##   (dbl), gini (dbl), pind (dbl), pindcri (dbl), pmpob (dbl), pmpobcri
##   (dbl), ppob (dbl), ppobcri (dbl), pren10ricos (dbl), pren20 (dbl),
##   pren20ricos (dbl), pren40 (dbl), pren60 (dbl), pren80 (dbl), prentrab
##   (dbl), r1040 (dbl), r2040 (dbl), rdpc (dbl), rdpc1 (dbl), rdpc10 (dbl),
##   rdpc2 (dbl), rdpc3 (dbl), rdpc4 (dbl), rdpc5 (dbl), rdpct (dbl), rind
##   (dbl), rmpob (dbl), rpob (dbl), theil (dbl), cpr (dbl), emp (dbl),
##   p_agro (dbl), p_com (dbl), p_constr (dbl), p_extr (dbl), p_formal (dbl),
##   p_fund (dbl), p_med (dbl), p_serv (dbl), p_siup (dbl), p_super (dbl),
##   p_transf (dbl), ren0 (dbl), ren1 (dbl), ren2 (dbl), ren3 (dbl), ren5
##   (dbl), renocup (dbl), t_ativ (dbl), t_ativ1014 (dbl), t_ativ1517 (dbl),
##   t_ativ1824 (dbl), t_ativ18m (dbl), t_ativ2529 (dbl), t_des (dbl),
##   t_des1014 (dbl), t_des1517 (dbl), t_des1824 (dbl), t_des18m (dbl),
##   t_des2529 (dbl), theiltrab (dbl), trabcc (dbl), trabpub (dbl), trabsc
##   (dbl), t_agua (dbl), t_banagua (dbl), t_dens (dbl), t_lixo (dbl), t_luz
##   (dbl), agua_esgoto (dbl), parede (dbl), t_crifundin_todos (dbl),
##   t_fora4a5 (dbl), t_fora6a14 (dbl), t_fundin_todos (dbl),
##   t_fundin_todos_mmeio (dbl), t_fundin18minf (dbl), t_m10a14cf (dbl),
##   t_m15a17cf (dbl), t_mulchefefif014 (dbl), t_nestuda_ntrab_mmeio (dbl),
##   t_ocupdesloc_1 (dbl), t_rmaxidoso (dbl), t_sluz (dbl), homem0a4 (dbl),
##   homem10a14 (dbl), homem15a19 (dbl), homem20a24 (dbl), homem25a29 (dbl),
##   homem30a34 (dbl), homem35a39 (dbl), homem40a44 (dbl), homem45a49 (dbl),
##   homem50a54 (dbl), homem55a59 (dbl), homem5a9 (dbl), homem60a64 (dbl),
##   homem65a69 (dbl), homem70a74 (dbl), homem75a79 (dbl), homemtot (dbl),
##   homens80 (dbl), mulh0a4 (dbl), mulh10a14 (dbl), mulh15a19 (dbl),
##   mulh20a24 (dbl), mulh25a29 (dbl), mulh30a34 (dbl), mulh35a39 (dbl),
##   mulh40a44 (dbl), mulh45a49 (dbl), mulh50a54 (dbl), mulh55a59 (dbl),
##   mulh5a9 (dbl), mulh60a64 (dbl), mulh65a69 (dbl), mulh70a74 (dbl),
##   mulh75a79 (dbl), mulher80 (dbl), mulhertot (dbl), pea (dbl), pea1014
##   (dbl), pea1517 (dbl), pea18m (dbl), peso1 (dbl), peso1114 (dbl),
##   peso1113 (dbl), peso1214 (dbl), peso13 (dbl), peso15 (dbl), peso1517
##   (dbl), peso1524 (dbl), peso1618 (dbl), peso18 (dbl), peso1820 (dbl),
##   peso1824 (dbl), peso1921 (dbl), peso25 (dbl), peso4 (dbl), peso5 (dbl),
##   peso6 (dbl), peso610 (dbl), peso617 (dbl), peso65 (dbl), pesom1014
##   (dbl), pesom1517 (dbl), pesom15m (dbl), pesom25m (dbl), pesorur (dbl),
##   pesotot (dbl), pesourb (dbl), pia (dbl), pia1014 (dbl), pia1517 (dbl),
##   pia18m (dbl), pop (dbl), popt (dbl), i_escolaridade (dbl), i_freq_prop
##   (dbl), idhm (dbl), idhm_e (dbl), idhm_l (dbl), idhm_r (dbl), ufn (chr)
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

## select

- Utilizar `starts_with(x)`, `contains(x)`, `matches(x)`, `one_of(x)`, etc.
- Possível colocar nomes, índices, e intervalos de variáveis com `:`.


```r
# por indice (nao recomendavel!)
pnud_muni %>%
  select(1:10)
```

```
## Source: local data frame [16,695 x 10]
## 
##    uf  ano codmun6 codmun7             municipio espvida fectot mort1
## 1  11 1991  110001 1100015 ALTA FLORESTA D'OESTE   62.01   4.08 45.58
## 2  11 1991  110002 1100023             ARIQUEMES   66.02   3.72 32.39
## 3  11 1991  110003 1100031                CABIXI   63.16   3.89 41.52
## 4  11 1991  110004 1100049                CACOAL   65.03   3.81 35.37
## 5  11 1991  110005 1100056            CEREJEIRAS   62.73   3.55 43.00
## 6  11 1991  110006 1100064     COLORADO DO OESTE   64.46   3.38 37.19
## 7  11 1991  110007 1100072            CORUMBIARA   59.32   3.95 56.02
## 8  11 1991  110008 1100080         COSTA MARQUES   62.76   4.19 42.90
## 9  11 1991  110009 1100098       ESPIGÃO D'OESTE   64.18   3.84 38.09
## 10 11 1991  110010 1100106         GUAJARÁ-MIRIM   64.71   4.19 36.41
## .. ..  ...     ...     ...                   ...     ...    ...   ...
## Variables not shown: mort5 (dbl), razdep (dbl)
```


```r
# especificando nomes (maneira mais usual)
pnud_muni %>%
  select(ano, ufn, municipio, idhm)
```

```
## Source: local data frame [16,695 x 4]
## 
##     ano      ufn             municipio  idhm
## 1  1991 Rondônia ALTA FLORESTA D'OESTE 0.329
## 2  1991 Rondônia             ARIQUEMES 0.432
## 3  1991 Rondônia                CABIXI 0.309
## 4  1991 Rondônia                CACOAL 0.407
## 5  1991 Rondônia            CEREJEIRAS 0.386
## 6  1991 Rondônia     COLORADO DO OESTE 0.376
## 7  1991 Rondônia            CORUMBIARA 0.203
## 8  1991 Rondônia         COSTA MARQUES 0.425
## 9  1991 Rondônia       ESPIGÃO D'OESTE 0.388
## 10 1991 Rondônia         GUAJARÁ-MIRIM 0.468
## ..  ...      ...                   ...   ...
```


```r
# intervalos e funcoes auxiliares (para economizar trabalho)
pnud_muni %>%
  select(ano:municipio, starts_with('idhm'))
```

```
## Source: local data frame [16,695 x 8]
## 
##     ano codmun6 codmun7             municipio  idhm idhm_e idhm_l idhm_r
## 1  1991  110001 1100015 ALTA FLORESTA D'OESTE 0.329  0.112  0.617  0.516
## 2  1991  110002 1100023             ARIQUEMES 0.432  0.199  0.684  0.593
## 3  1991  110003 1100031                CABIXI 0.309  0.108  0.636  0.430
## 4  1991  110004 1100049                CACOAL 0.407  0.171  0.667  0.593
## 5  1991  110005 1100056            CEREJEIRAS 0.386  0.167  0.629  0.547
## 6  1991  110006 1100064     COLORADO DO OESTE 0.376  0.151  0.658  0.536
## 7  1991  110007 1100072            CORUMBIARA 0.203  0.039  0.572  0.373
## 8  1991  110008 1100080         COSTA MARQUES 0.425  0.220  0.629  0.553
## 9  1991  110009 1100098       ESPIGÃO D'OESTE 0.388  0.159  0.653  0.561
## 10 1991  110010 1100106         GUAJARÁ-MIRIM 0.468  0.247  0.662  0.625
## ..  ...     ...     ...                   ...   ...    ...    ...    ...
```

## filter

- Parecido com `subset`.
- Condições separadas por vírgulas é o mesmo que separar por `&`.


```r
# somente estado de SP, com IDH municipal maior que 80% no ano 2010
pnud_muni %>%
  select(ano, ufn, municipio, idhm) %>%
  filter(ufn=='São Paulo', idhm > .8, ano==2010)
```

```
## Source: local data frame [21 x 4]
## 
##     ano       ufn           municipio  idhm
## 1  2010 São Paulo  ÁGUAS DE SÃO PEDRO 0.854
## 2  2010 São Paulo           AMERICANA 0.811
## 3  2010 São Paulo          ARARAQUARA 0.815
## 4  2010 São Paulo               ASSIS 0.805
## 5  2010 São Paulo               BAURU 0.801
## 6  2010 São Paulo            CAMPINAS 0.805
## 7  2010 São Paulo       ILHA SOLTEIRA 0.812
## 8  2010 São Paulo             JUNDIAÍ 0.822
## 9  2010 São Paulo        PIRASSUNUNGA 0.801
## 10 2010 São Paulo PRESIDENTE PRUDENTE 0.806
## ..  ...       ...                 ...   ...
```


```r
# mesma coisa que o anterior
pnud_muni %>%
  select(ano, ufn, municipio, idhm) %>%
  filter(ufn=='São Paulo' & idhm > .8 & ano==2010)
```

```
## Source: local data frame [21 x 4]
## 
##     ano       ufn           municipio  idhm
## 1  2010 São Paulo  ÁGUAS DE SÃO PEDRO 0.854
## 2  2010 São Paulo           AMERICANA 0.811
## 3  2010 São Paulo          ARARAQUARA 0.815
## 4  2010 São Paulo               ASSIS 0.805
## 5  2010 São Paulo               BAURU 0.801
## 6  2010 São Paulo            CAMPINAS 0.805
## 7  2010 São Paulo       ILHA SOLTEIRA 0.812
## 8  2010 São Paulo             JUNDIAÍ 0.822
## 9  2010 São Paulo        PIRASSUNUNGA 0.801
## 10 2010 São Paulo PRESIDENTE PRUDENTE 0.806
## ..  ...       ...                 ...   ...
```


```r
# !is.na(x)
pnud_muni %>%
  select(ano, ufn, municipio, idhm, PEA) %>%
  filter(!is.na(PEA))
```

```
## Error in eval(expr, envir, enclos): object 'PEA' not found
```


```r
# %in%
pnud_muni %>%
  select(ano, ufn, municipio, idhm) %>%
  filter(municipio %in% c('CAMPINAS', 'SÃO PAULO'))
```

```
## Source: local data frame [6 x 4]
## 
##    ano       ufn municipio  idhm
## 1 1991 São Paulo  CAMPINAS 0.618
## 2 1991 São Paulo SÃO PAULO 0.626
## 3 2000 São Paulo  CAMPINAS 0.735
## 4 2000 São Paulo SÃO PAULO 0.733
## 5 2010 São Paulo  CAMPINAS 0.805
## 6 2010 São Paulo SÃO PAULO 0.805
```

## mutate

- Parecido com `transform`, mas aceita várias novas colunas iterativamente.
- Novas variáveis devem ter o mesmo `length` que o `nrow` do bd oridinal ou `1`.


```r
pnud_muni %>%
  select(ano, ufn, municipio, idhm) %>%
  filter(ano==2010) %>%
  mutate(idhm_porc = idhm * 100,
         idhm_porc_txt = paste(idhm_porc, '%'))
```

```
## Source: local data frame [5,565 x 6]
## 
##     ano      ufn             municipio  idhm idhm_porc idhm_porc_txt
## 1  2010 Rondônia ALTA FLORESTA D'OESTE 0.641      64.1        64.1 %
## 2  2010 Rondônia             ARIQUEMES 0.702      70.2        70.2 %
## 3  2010 Rondônia                CABIXI 0.650      65.0          65 %
## 4  2010 Rondônia                CACOAL 0.718      71.8        71.8 %
## 5  2010 Rondônia            CEREJEIRAS 0.692      69.2        69.2 %
## 6  2010 Rondônia     COLORADO DO OESTE 0.685      68.5        68.5 %
## 7  2010 Rondônia            CORUMBIARA 0.613      61.3        61.3 %
## 8  2010 Rondônia         COSTA MARQUES 0.611      61.1        61.1 %
## 9  2010 Rondônia       ESPIGÃO D'OESTE 0.672      67.2        67.2 %
## 10 2010 Rondônia         GUAJARÁ-MIRIM 0.657      65.7        65.7 %
## ..  ...      ...                   ...   ...       ...           ...
```


```r
# media de idhm_l e idhm_e
pnud_muni %>%
  select(ano, ufn, municipio, starts_with('idhm')) %>%
  filter(ano==2010) %>%
  mutate(idhm2 = (idhm_e + idhm_l)/2)
```

```
## Source: local data frame [5,565 x 8]
## 
##     ano      ufn             municipio  idhm idhm_e idhm_l idhm_r  idhm2
## 1  2010 Rondônia ALTA FLORESTA D'OESTE 0.641  0.526  0.763  0.657 0.6445
## 2  2010 Rondônia             ARIQUEMES 0.702  0.600  0.806  0.716 0.7030
## 3  2010 Rondônia                CABIXI 0.650  0.559  0.757  0.650 0.6580
## 4  2010 Rondônia                CACOAL 0.718  0.620  0.821  0.727 0.7205
## 5  2010 Rondônia            CEREJEIRAS 0.692  0.602  0.799  0.688 0.7005
## 6  2010 Rondônia     COLORADO DO OESTE 0.685  0.584  0.814  0.676 0.6990
## 7  2010 Rondônia            CORUMBIARA 0.613  0.473  0.774  0.630 0.6235
## 8  2010 Rondônia         COSTA MARQUES 0.611  0.493  0.751  0.616 0.6220
## 9  2010 Rondônia       ESPIGÃO D'OESTE 0.672  0.536  0.819  0.691 0.6775
## 10 2010 Rondônia         GUAJARÁ-MIRIM 0.657  0.519  0.823  0.663 0.6710
## ..  ...      ...                   ...   ...    ...    ...    ...    ...
```


```r
## errado
# pnud_muni %>%
#   select(ano, ufn, municipio, starts_with('idhm')) %>%
#   filter(ano==2010) %>%
#   mutate(idhm2 = mean(c(idhm_e, idhm_l)))

## uma alternativa (+ demorada)
# pnud_muni %>%
#   select(ano, ufn, municipio, starts_with('idhm')) %>%
#   filter(ano==2010) %>%
#   rowwise() %>%
#   mutate(idhm2 = mean(c(idhm_e, idhm_l)))
```

## arrange

- Simplesmente ordena de acordo com as opções.
- Utilizar `desc` para ordem decrescente.


```r
pnud_muni %>%
  select(ano, ufn, municipio, idhm) %>%
  filter(ano==2010) %>%
  mutate(idhm_porc = idhm * 100,
         idhm_porc_txt = paste(idhm_porc, '%')) %>%
  arrange(idhm)
```

```
## Source: local data frame [5,565 x 6]
## 
##     ano      ufn          municipio  idhm idhm_porc idhm_porc_txt
## 1  2010     Pará            MELGAÇO 0.418      41.8        41.8 %
## 2  2010 Maranhão    FERNANDO FALCÃO 0.443      44.3        44.3 %
## 3  2010 Amazonas   ATALAIA DO NORTE 0.450      45.0          45 %
## 4  2010 Maranhão     MARAJÁ DO SENA 0.452      45.2        45.2 %
## 5  2010  Roraima           UIRAMUTÃ 0.453      45.3        45.3 %
## 6  2010     Pará             CHAVES 0.453      45.3        45.3 %
## 7  2010     Acre             JORDÃO 0.469      46.9        46.9 %
## 8  2010     Pará              BAGRE 0.471      47.1        47.1 %
## 9  2010     Pará CACHOEIRA DO PIRIÁ 0.473      47.3        47.3 %
## 10 2010 Amazonas          ITAMARATI 0.477      47.7        47.7 %
## ..  ...      ...                ...   ...       ...           ...
```


```r
pnud_muni %>%
  select(ano, ufn, municipio, idhm) %>%
  filter(ano==2010) %>%
  mutate(idhm_porc = idhm * 100,
         idhm_porc_txt = paste(idhm_porc, '%')) %>%
  arrange(desc(idhm))
```

```
## Source: local data frame [5,565 x 6]
## 
##     ano              ufn          municipio  idhm idhm_porc idhm_porc_txt
## 1  2010        São Paulo SÃO CAETANO DO SUL 0.862      86.2        86.2 %
## 2  2010        São Paulo ÁGUAS DE SÃO PEDRO 0.854      85.4        85.4 %
## 3  2010   Santa Catarina      FLORIANÓPOLIS 0.847      84.7        84.7 %
## 4  2010   Espírito Santo            VITÓRIA 0.845      84.5        84.5 %
## 5  2010   Santa Catarina BALNEÁRIO CAMBORIÚ 0.845      84.5        84.5 %
## 6  2010        São Paulo             SANTOS 0.840      84.0          84 %
## 7  2010   Rio de Janeiro            NITERÓI 0.837      83.7        83.7 %
## 8  2010   Santa Catarina            JOAÇABA 0.827      82.7        82.7 %
## 9  2010 Distrito Federal           BRASÍLIA 0.824      82.4        82.4 %
## 10 2010           Paraná           CURITIBA 0.823      82.3        82.3 %
## ..  ...              ...                ...   ...       ...           ...
```

## summarise

- Retorna um vetor de tamanho `1` a partir de uma conta com as variáveis.
- Geralmente é utilizado em conjunto com `group_by`.
- Algumas funções importantes: `n()`, `n_distinct()`.


```r
pnud_muni %>%
  filter(ano==2010) %>%  
  group_by(ufn) %>%
  summarise(n=n(), 
            idhm_medio=mean(idhm),
            populacao_total=sum(popt)) %>%
  arrange(desc(idhm_medio))
```

```
## Error in n(): This function should not be called directly
```


```r
pnud_muni %>%
  filter(ano==2010) %>%  
  count(ufn)
```

```
## Error in count(., ufn): object 'ufn' not found
```


```r
pnud_muni %>%
  group_by(ano, ufn) %>%
  tally() %>%
  head # nao precisa de parenteses!
```

```
## Source: local data frame [6 x 3]
## Groups: ano
## 
##    ano      ufn   n
## 1 1991     Acre  22
## 2 1991  Alagoas 102
## 3 1991    Amapá  16
## 4 1991 Amazonas  62
## 5 1991    Bahia 417
## 6 1991    Ceará 184
```

## Data Tidying com tidyr

### Sobre tidy data

- Cada observação é uma linha do bd.
- Cada variável é uma coluna do bd.
- Para cada unidade observacional temos um bd separado (possivelmente com chaves de associacao).

### spread

- "Joga" uma variável nas colunas


```r
pnud_muni %>%
  group_by(ano, ufn) %>%
  summarise(populacao=sum(popt)) %>%
  ungroup() %>%
  spread(ano, populacao)
```

```
## Error in `[.data.frame`(data, key_col): undefined columns selected
```

### gather

- "Empilha" o banco de dados


```r
pnud_muni %>%
  filter(ano==2010) %>%
  select(ufn, municipio, starts_with('idhm_')) %>%
  gather(tipo_idh, idh, starts_with('idhm_'))
```

```
## Source: local data frame [16,695 x 4]
## 
##         ufn             municipio tipo_idh   idh
## 1  Rondônia ALTA FLORESTA D'OESTE   idhm_e 0.526
## 2  Rondônia             ARIQUEMES   idhm_e 0.600
## 3  Rondônia                CABIXI   idhm_e 0.559
## 4  Rondônia                CACOAL   idhm_e 0.620
## 5  Rondônia            CEREJEIRAS   idhm_e 0.602
## 6  Rondônia     COLORADO DO OESTE   idhm_e 0.584
## 7  Rondônia            CORUMBIARA   idhm_e 0.473
## 8  Rondônia         COSTA MARQUES   idhm_e 0.493
## 9  Rondônia       ESPIGÃO D'OESTE   idhm_e 0.536
## 10 Rondônia         GUAJARÁ-MIRIM   idhm_e 0.519
## ..      ...                   ...      ...   ...
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
