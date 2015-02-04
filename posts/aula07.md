---
title: "Aula 07 - Modelando"
output:
  html_document:
    number_sections: yes
    toc_depth: 2
    toc: yes
date : 2015-02-02
---

<a href="http://curso-r.github.io/slides/aula_07_apresentacao.html" target="_blank">Slides dessa aula</a>

<a href="http://curso-r.github.io/script/aula_07.R" target="_blank">Script dessa aula</a>




# Regressão Linear e ANOVA

O R tem todo o ferramentário necessário para fazer modelos lineares, a começar pelo modelo de regressão linear normal.

Para ilustrar, vamos utilizar a base de dados `mtcars` que vem no R.

Cada uma das 32 linhas da base `mtcars` representa um carro. A variável `mpg` é o consumo de combustível em milhas por galão (~3.76 Litros) e iremos tentar explicá-la pelas demais características dos veículos. 

## Um pouco de descritiva

### Univariada


```r
# os dados
head(mtcars)
```

```
##                    mpg cyl disp  hp drat    wt  qsec vs am gear carb
## Mazda RX4         21.0   6  160 110 3.90 2.620 16.46  0  1    4    4
## Mazda RX4 Wag     21.0   6  160 110 3.90 2.875 17.02  0  1    4    4
## Datsun 710        22.8   4  108  93 3.85 2.320 18.61  1  1    4    1
## Hornet 4 Drive    21.4   6  258 110 3.08 3.215 19.44  1  0    3    1
## Hornet Sportabout 18.7   8  360 175 3.15 3.440 17.02  0  0    3    2
## Valiant           18.1   6  225 105 2.76 3.460 20.22  1  0    3    1
```

```r
# banco de dados das variáveis contínuas no formato "longo"
mtcars_long <- mtcars %>%  
  select(mpg, disp:qsec) %>%
  gather(var_continuas) 
```

```
## Error in select(., mpg, disp:qsec): unused arguments (mpg, disp:qsec)
```

```r
# medidas resumo para variáveis contínuas
mtcars_long %>%
  group_by(var_continuas) %>%
  summarise("N" = n(),
            "Missing" = sum(is.na(value)),
            "Media" = mean(value),
            "DesvPad" = sd(value),
            "Minimo" = min(value),
            "Q1" = quantile(value, 0.25),
            "Mediana" = quantile(value, 0.50),
            "Q3" = quantile(value, 0.75),
            "Maximo" = max(value)) %>%
  mutate_each(funs(round(.,1)), -var_continuas)
```

```
## Error in eval(expr, envir, enclos): object 'mtcars_long' not found
```

```r
# boxplots
mtcars_long %>%
  ggplot() +
  geom_boxplot(aes(x=1, y = value)) +
  facet_wrap(~var_continuas, scales = "free") 
```

```
## Error in eval(expr, envir, enclos): object 'mtcars_long' not found
```

```r
# frequencias de variáveis categóricas
mtcars_freq <- mtcars %>%
  select(cyl, vs:carb) %>%
  gather(vars_categoricas) %>%
  rename(categoria = value) %>%
  group_by(vars_categoricas, categoria) %>%
  summarise(freq = n()) %>%
  group_by(vars_categoricas) %>%
  mutate(prop = freq/sum(freq),
         prop_txt = (prop*100) %>% round(0) %>% paste0("%"))
```

```
## Error in select(., cyl, vs:carb): unused arguments (cyl, vs:carb)
```

```r
mtcars_freq
```

```
## Error in eval(expr, envir, enclos): object 'mtcars_freq' not found
```

```r
# Gráfico de barras
mtcars_freq %>%
  ggplot() +
  geom_bar(aes(x=categoria, y = freq), position = "dodge", stat = "identity") +
  facet_wrap(~vars_categoricas, scales="free")  
```

```
## Error in eval(expr, envir, enclos): object 'mtcars_freq' not found
```

### Versus `mpg`


```r
# Matriz de correlação linear
mtcars %>%  
  select(mpg, disp:qsec) %>%
  cor %>%
  round(2) 
```

```
## Error in select(., mpg, disp:qsec): unused arguments (mpg, disp:qsec)
```

```r
# Matriz de dispersão
pairs(mtcars %>%  
  select(mpg, disp:qsec))
```

```
## Error in select(., mpg, disp:qsec): unused arguments (mpg, disp:qsec)
```


## Regressão linear
A função que ajusta modelo linear normal no R é `lm()`. Você especifica o banco de dados e a fórmula com as variáveis que você deseja associar.


```r
ajuste <- lm(resposta ~ explicativas, data = meus_dados)
```

O objeto `ajuste` contém todos os resultados e com a ajuda de alguns comandos, você extrai tudo o que é interessante.

Exemplo:

```r
ajuste_lm <- lm(mpg ~ wt, data = mtcars)

ajuste_lm
```

```
## 
## Call:
## lm(formula = mpg ~ wt, data = mtcars)
## 
## Coefficients:
## (Intercept)           wt  
##   37.285126    -5.344472
```

No código acima temos `mpg` explicado por `wt`. A saída do `lm()` mostra qual foi a chamada do modelo e os coeficientes ajustados. Como visto na análise descritiva, há uma clara associação linear e negativa entre as variáveis, justificando o parâmetro negativo `wt = -5.344`. A função `coeficients()` ou `coef()` nos fornece os coeficientes ajustados.

Gráfico da reta ajustada:

```r
# extrai os coeficientes ajustados
coeficientes <- coef(ajuste_lm)

ggplot(mtcars) +
  geom_point(aes(x = wt, y = mpg)) +
  geom_abline(intercept = coeficientes[1], slope = coeficientes[2])
```

![plot of chunk unnamed-chunk-6](assets/fig/unnamed-chunk-6-1.png) 

**summary()**

A função `summary()` é uma função genérica que geralmente devolve um resumo de informações úteis de praticamente qualquer classe de objetos. Para objetos `lm()` ela devolve:

1. Chamada do modelo
2. Medidas resumo dos resíduos
3. Tabela de coeficientes, desvios padrão e testes T para hipótese nula de parâmetros iguais a zero.
4. Média dos quadrados do resíduo e os respectivos graus de liberdade; $R^2$ e $R^2$ ajustado da regressão; Estatística F para qualidade do ajuste (comparação com o modelo com apenas o intercepto).


```r
summary(ajuste_lm)
```

![summary lm](assets/fig/summary_lm.png)

**plot()**

A função `plot()` constrói gráficos úteis para diagnóstico do modelo.


```r
# opção para mostrar 4 gráficos em uma mesma figura
par(mfrow = c(2,2))

# gráficos de diagnóstico do modelo ajuste_lm
plot(ajuste_lm)
```

![plot of chunk unnamed-chunk-8](assets/fig/unnamed-chunk-8-1.png) 

```r
# retorna ao normal
par(mfrow = c(1,1))
```

**anova()**

Uma parte importante da modelagem é a redução de modelos. A função `anova()` compara dois (ou mais) modelos encaixados por meio da estatística F (por padrão), especialmente indicadas para modelos lineares normais. Caso seja passada apenas um ajuste à função, ela devolve a tabela de ANOVA (termos testados sequencialmente).


```r
# modelo nulo, com apenas o intercepto
ajuste_lm_nulo <- lm(mpg ~ 1, data = mtcars)

# modelo com wt e cyl
ajuste_lm2 <- lm(mpg ~ wt + factor(cyl), data = mtcars)

# compara o modelo com wt com o modelo nulo
anova(ajuste_lm_nulo, ajuste_lm)
```

```
## Analysis of Variance Table
## 
## Model 1: mpg ~ 1
## Model 2: mpg ~ wt
##   Res.Df        RSS Df Sum of Sq        F          Pr(>F)    
## 1     31 1126.04719                                          
## 2     30  278.32194  1 847.72525 91.37533 0.0000000001294 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
```

```r
# Tabela de ANOVA, testa os termos sequencialmente
anova(ajuste_lm2)
```

```
## Analysis of Variance Table
## 
## Response: mpg
##             Df    Sum Sq   Mean Sq   F value            Pr(>F)    
## wt           1 847.72525 847.72525 129.66504 0.000000000005079 ***
## factor(cyl)  2  95.26329  47.63164   7.28557         0.0028353 ** 
## Residuals   28 183.05865   6.53781                                
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
```

A o valor-p = 0.001064 indica que o modelo com `wt + cyl` trás melhorias significantes no poder explicativo do modelo quando comparado ao modelo com apenas `wt`. 

**demais comandos**

Outros comandos úteis são:


|      Função       |                   Descrição                    |
|:-----------------:|:----------------------------------------------:|
|     confint()     |   Intervalo de confiança para os parâmetros    |
|      resid()      |               Resíduos do modelo               |
|     fitted()      |               Valores ajustados                |
|       AIC()       |        Critério de informação de Akaike        |
|  model.matrix()   |  Matriz de planejamento (matriz X) do modelo   |
| linearHypotesis() |  Teste de combinações lineares de parâmetros   |
|      vcov()       | Matriz de variância-covariância dos parâmetros |

## Fórmulas

Objetos de classe `formula` possuem sintaxe muito conveniente para especificar o modelo estatístico que desejamos ajustar. O símbolo que define esses objetos é o `~`.

Estrutura:

```r
ajuste <- lm(resposta ~ explicativas)
```

Então se o objetivo fosse ajustar o modelo

$$
Y_i = \beta_0 + \beta_1X_i + \epsilon_i,
$$

passaríamos ao R a seguinte fórmula


```r
ajuste <- lm(Y ~ X)
```

Para incorporar mais variáveis usamos o símbolo `+`. O modelo

$$
Y_i = \beta_0 + \beta_1X_i + \beta_2Z_i + \epsilon_i,
$$

ficaria traduzido como


```r
ajuste <- lm(Y ~ X + Z)
```

Utilizamos o símbolo `*` para introduzir os componentes de interação, além dos componentes aditivos.


```r
ajuste <- lm(Y ~ X * Z)
```

Teoricamente teríamos, para Z **contínua**, o modelo de regressão

$$
Y_i = \beta_0 + \beta_1X_i + \beta_2Z_i + \beta_3X_i*Z_i + \epsilon_i,
$$

Ou, para Z **categórica**, o modelo de ANCOVA

$$
Y_{ij} = \alpha_j + \beta_jX_{ij} + \epsilon_{ij},
$$

O operador `:` faz com que apenas o componente de interação seja incluído no modelo. Para ilustrar, observe que o modelo


```r
ajuste <- lm(Y ~ X * Z)
```

é a mesma coisa que


```r
ajuste <- lm(Y ~ X + Z + X:Z)
```

Os operadores aritméticos exercem função diferente em fórmulas. O sinal de `+` no exemplo induziu em um modelo aditivo em vez de somar X com Z. Para fazer com que eles assumam seus significados aritméticos temos que utilizar a função `I()`. Exemplo:


```r
ajuste <- lm(Y ~ I(X + Z))
```

Agora sim o componente `I(X + Z)` representa a soma de X com Z. Outros exemplos: `I(X^2)`, `I(log(X + 1))`, `I(sqrt(X+Z*5))`.

**Tabela de simbolos para utilizar em fórmulas**


|    Símbolo    |
|:-------------:|
|      + X      |
|      - X      |
|     X * Z     |
|     X : Z     |
| (X + Z + W)^2 |
|   I(X + Z)    |
|     X - 1     |
|       .       |

Table: Table continues below

 

|                               Descrição                                |
|:----------------------------------------------------------------------:|
|                          inclui a variável X                           |
|                          retira a variável X                           |
|                  inclui X, Z e a interação entre elas                  |
|          inclui apenas o componente de interação entre X e Z           |
|                  inclui X, Z, W e as interações 2 a 2                  |
| Função identidade. Inclui uma variável construída pela soma de X com Z |
|          Remove o intercepto (regressão passando pela origem)          |
|             O ponto representa 'todas as demais variáveis'             |

## Seleção de variáveis

### linearHypothesis

Frequentemente temos interesse em saber se parâmetros são diferentes de zero ou se são diferentes entre si. Para isto, costumamos efetuar testes do tipo Wald para combinações lineares dos parâmetros.

Para este fim, a função `linearHypothesis()` do pacote `car` faz o trabalho.


```r
library(car)

linearHypothesis(ajuste_lm, c(0,1))
```

```
## Linear hypothesis test
## 
## Hypothesis:
## wt = 0
## 
## Model 1: restricted model
## Model 2: mpg ~ wt
## 
##   Res.Df        RSS Df Sum of Sq        F          Pr(>F)    
## 1     31 1126.04719                                          
## 2     30  278.32194  1 847.72525 91.37533 0.0000000001294 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
```

### stepwise

Stepwise no R se faz com as funções `step()` do pacote `stats` ou `stepAIC()` do pacote `MASS`. Escolher entre `forward`, `backward` ou `both` (ambos) basta passar um desses nomes ao parâmetro `direction` da função.


```r
# modelo aditivo completo
ajuste_lm_completo <- lm(mpg ~ ., data = mtcars)

# modelo forward
step(ajuste_lm_completo, direction = "forward")
```

```
## Start:  AIC=70.9
## mpg ~ cyl + disp + hp + drat + wt + qsec + vs + am + gear + carb
```

```
## 
## Call:
## lm(formula = mpg ~ cyl + disp + hp + drat + wt + qsec + vs + 
##     am + gear + carb, data = mtcars)
## 
## Coefficients:
## (Intercept)          cyl         disp           hp         drat           wt         qsec           vs           am         gear         carb  
## 12.30337416  -0.11144048   0.01333524  -0.02148212   0.78711097  -3.71530393   0.82104075   0.31776281   2.52022689   0.65541302  -0.19941925
```

```r
# modelo backward
step(ajuste_lm_completo, direction = "backward")
```

```
## Start:  AIC=70.9
## mpg ~ cyl + disp + hp + drat + wt + qsec + vs + am + gear + carb
## 
##        Df  Sum of Sq       RSS       AIC
## - cyl   1  0.0798712 147.57430 68.915068
## - vs    1  0.1601257 147.65456 68.932466
## - carb  1  0.4066688 147.90110 68.985853
## - gear  1  1.3530555 148.84749 69.189961
## - drat  1  1.6270263 149.12146 69.248807
## - disp  1  3.9166671 151.41110 69.736407
## - hp    1  6.8399100 154.33434 70.348332
## - qsec  1  8.8641160 156.35855 70.765307
## <none>               147.49443 70.897744
## - am    1 10.5466514 158.04108 71.107811
## - wt    1 27.0143855 174.50881 74.279659
## 
## Step:  AIC=68.92
## mpg ~ disp + hp + drat + wt + qsec + vs + am + gear + carb
## 
##        Df  Sum of Sq       RSS       AIC
## - vs    1  0.2685228 147.84282 66.973242
## - carb  1  0.5201418 148.09444 67.027657
## - gear  1  1.8211468 149.39545 67.307549
## - drat  1  1.9826232 149.55692 67.342118
## - disp  1  3.9009393 151.47524 67.749961
## - hp    1  7.3631648 154.93747 68.473142
## <none>               147.57430 68.915068
## - qsec  1 10.0932561 157.66756 69.032091
## - am    1 11.8359442 159.41025 69.383844
## - wt    1 27.0280449 174.60235 72.296806
## 
## Step:  AIC=66.97
## mpg ~ disp + hp + drat + wt + qsec + am + gear + carb
## 
##        Df  Sum of Sq       RSS       AIC
## - carb  1  0.6854608 148.52829 65.121264
## - gear  1  2.1436837 149.98651 65.433902
## - drat  1  2.2138988 150.05672 65.448879
## - disp  1  3.6466512 151.48947 65.752968
## - hp    1  7.1059603 154.94878 66.475480
## <none>               147.84282 66.973242
## - am    1 11.5693808 159.41221 67.384238
## - qsec  1 15.6830478 163.52587 68.199530
## - wt    1 27.3799421 175.22277 70.410311
## 
## Step:  AIC=65.12
## mpg ~ disp + hp + drat + wt + qsec + am + gear
## 
##        Df Sum of Sq       RSS       AIC
## - gear  1  1.564971 150.09325 63.456669
## - drat  1  1.932127 150.46041 63.534851
## <none>              148.52829 65.121264
## - disp  1 10.110262 158.63855 65.228558
## - am    1 12.323215 160.85150 65.671862
## - hp    1 14.825636 163.35392 66.165864
## - qsec  1 26.408059 174.93634 68.357960
## - wt    1 69.126924 217.65521 75.349641
## 
## Step:  AIC=63.46
## mpg ~ disp + hp + drat + wt + qsec + am
## 
##        Df Sum of Sq       RSS       AIC
## - drat  1  3.344551 153.43781 62.161901
## - disp  1  8.545358 158.63861 63.228571
## <none>              150.09325 63.456669
## - hp    1 13.284651 163.37791 64.170562
## - am    1 20.035878 170.12913 65.466299
## - qsec  1 25.574406 175.66766 66.491457
## - wt    1 67.571960 217.66522 73.351113
## 
## Step:  AIC=62.16
## mpg ~ disp + hp + wt + qsec + am
## 
##        Df Sum of Sq       RSS       AIC
## - disp  1  6.628654 160.06646 61.515302
## <none>              153.43781 62.161901
## - hp    1 12.572053 166.00986 62.681961
## - qsec  1 26.469795 179.90760 65.254640
## - am    1 32.197518 185.63532 66.257543
## - wt    1 69.043043 222.48085 72.051364
## 
## Step:  AIC=61.52
## mpg ~ hp + wt + qsec + am
## 
##        Df Sum of Sq       RSS       AIC
## - hp    1  9.219469 169.28593 61.307305
## <none>              160.06646 61.515302
## - qsec  1 20.224611 180.29107 63.322775
## - am    1 25.992837 186.05930 64.330545
## - wt    1 78.493773 238.56023 72.284350
## 
## Step:  AIC=61.31
## mpg ~ wt + qsec + am
## 
##        Df  Sum of Sq       RSS       AIC
## <none>               169.28593 61.307305
## - am    1  26.177702 195.46363 63.908430
## - qsec  1 109.033768 278.31970 75.217105
## - wt    1 183.347261 352.63319 82.790160
```

```
## 
## Call:
## lm(formula = mpg ~ wt + qsec + am, data = mtcars)
## 
## Coefficients:
## (Intercept)           wt         qsec           am  
##    9.617781    -3.916504     1.225886     2.935837
```

```r
# modelo both
step(ajuste_lm_completo, direction = "both")
```

```
## Start:  AIC=70.9
## mpg ~ cyl + disp + hp + drat + wt + qsec + vs + am + gear + carb
## 
##        Df  Sum of Sq       RSS       AIC
## - cyl   1  0.0798712 147.57430 68.915068
## - vs    1  0.1601257 147.65456 68.932466
## - carb  1  0.4066688 147.90110 68.985853
## - gear  1  1.3530555 148.84749 69.189961
## - drat  1  1.6270263 149.12146 69.248807
## - disp  1  3.9166671 151.41110 69.736407
## - hp    1  6.8399100 154.33434 70.348332
## - qsec  1  8.8641160 156.35855 70.765307
## <none>               147.49443 70.897744
## - am    1 10.5466514 158.04108 71.107811
## - wt    1 27.0143855 174.50881 74.279659
## 
## Step:  AIC=68.92
## mpg ~ disp + hp + drat + wt + qsec + vs + am + gear + carb
## 
##        Df  Sum of Sq       RSS       AIC
## - vs    1  0.2685228 147.84282 66.973242
## - carb  1  0.5201418 148.09444 67.027657
## - gear  1  1.8211468 149.39545 67.307549
## - drat  1  1.9826232 149.55692 67.342118
## - disp  1  3.9009393 151.47524 67.749961
## - hp    1  7.3631648 154.93747 68.473142
## <none>               147.57430 68.915068
## - qsec  1 10.0932561 157.66756 69.032091
## - am    1 11.8359442 159.41025 69.383844
## + cyl   1  0.0798712 147.49443 70.897744
## - wt    1 27.0280449 174.60235 72.296806
## 
## Step:  AIC=66.97
## mpg ~ disp + hp + drat + wt + qsec + am + gear + carb
## 
##        Df  Sum of Sq       RSS       AIC
## - carb  1  0.6854608 148.52829 65.121264
## - gear  1  2.1436837 149.98651 65.433902
## - drat  1  2.2138988 150.05672 65.448879
## - disp  1  3.6466512 151.48947 65.752968
## - hp    1  7.1059603 154.94878 66.475480
## <none>               147.84282 66.973242
## - am    1 11.5693808 159.41221 67.384238
## - qsec  1 15.6830478 163.52587 68.199530
## + vs    1  0.2685228 147.57430 68.915068
## + cyl   1  0.1882683 147.65456 68.932466
## - wt    1 27.3799421 175.22277 70.410311
## 
## Step:  AIC=65.12
## mpg ~ disp + hp + drat + wt + qsec + am + gear
## 
##        Df Sum of Sq       RSS       AIC
## - gear  1  1.564971 150.09325 63.456669
## - drat  1  1.932127 150.46041 63.534851
## <none>              148.52829 65.121264
## - disp  1 10.110262 158.63855 65.228558
## - am    1 12.323215 160.85150 65.671862
## - hp    1 14.825636 163.35392 66.165864
## + carb  1  0.685461 147.84282 66.973242
## + vs    1  0.433842 148.09444 67.027657
## + cyl   1  0.414429 148.11386 67.031852
## - qsec  1 26.408059 174.93634 68.357960
## - wt    1 69.126924 217.65521 75.349641
## 
## Step:  AIC=63.46
## mpg ~ disp + hp + drat + wt + qsec + am
## 
##        Df Sum of Sq       RSS       AIC
## - drat  1  3.344551 153.43781 62.161901
## - disp  1  8.545358 158.63861 63.228571
## <none>              150.09325 63.456669
## - hp    1 13.284651 163.37791 64.170562
## + gear  1  1.564971 148.52829 65.121264
## + cyl   1  1.003399 149.08986 65.242025
## + vs    1  0.645486 149.44777 65.318754
## + carb  1  0.106748 149.98651 65.433902
## - am    1 20.035878 170.12913 65.466299
## - qsec  1 25.574406 175.66766 66.491457
## - wt    1 67.571960 217.66522 73.351113
## 
## Step:  AIC=62.16
## mpg ~ disp + hp + wt + qsec + am
## 
##        Df Sum of Sq       RSS       AIC
## - disp  1  6.628654 160.06646 61.515302
## <none>              153.43781 62.161901
## - hp    1 12.572053 166.00986 62.681961
## + drat  1  3.344551 150.09325 63.456669
## + gear  1  2.977394 150.46041 63.534851
## + cyl   1  2.446693 150.99111 63.647523
## + vs    1  1.120807 152.31700 63.927295
## + carb  1  0.011427 153.42638 64.159518
## - qsec  1 26.469795 179.90760 65.254640
## - am    1 32.197518 185.63532 66.257543
## - wt    1 69.043043 222.48085 72.051364
## 
## Step:  AIC=61.52
## mpg ~ hp + wt + qsec + am
## 
##        Df Sum of Sq       RSS       AIC
## - hp    1  9.219469 169.28593 61.307305
## <none>              160.06646 61.515302
## + disp  1  6.628654 153.43781 62.161901
## + carb  1  3.227190 156.83927 62.863540
## + drat  1  1.427847 158.63861 63.228571
## - qsec  1 20.224611 180.29107 63.322775
## + cyl   1  0.248979 159.81748 63.465489
## + vs    1  0.248550 159.81791 63.465574
## + gear  1  0.171123 159.89534 63.481074
## - am    1 25.992837 186.05930 64.330545
## - wt    1 78.493773 238.56023 72.284350
## 
## Step:  AIC=61.31
## mpg ~ wt + qsec + am
## 
##        Df  Sum of Sq       RSS       AIC
## <none>               169.28593 61.307305
## + hp    1   9.219469 160.06646 61.515302
## + carb  1   8.035944 161.24999 61.751039
## + disp  1   3.276070 166.00986 62.681961
## + cyl   1   1.501058 167.78487 63.022295
## + drat  1   1.399618 167.88631 63.041636
## + gear  1   0.122716 169.16321 63.284099
## + vs    1   0.000466 169.28546 63.307217
## - am    1  26.177702 195.46363 63.908430
## - qsec  1 109.033768 278.31970 75.217105
## - wt    1 183.347261 352.63319 82.790160
```

```
## 
## Call:
## lm(formula = mpg ~ wt + qsec + am, data = mtcars)
## 
## Coefficients:
## (Intercept)           wt         qsec           am  
##    9.617781    -3.916504     1.225886     2.935837
```


---
## Regressão Linear Generalizada

A regressão linear normal pode ser inadequada quando a distribuição de $Y_i$ é assimétrica, representa
dados de contagens ou então dados binários. Para lidar com esse problema, McCulagh e Nelder estenderam
a família de distribuições para ajuste da regressão para distribuições da _família exponencial_. Tal
família inclui as distribuições `normal`, `poisson`, `gama`, `normal inversa` e `binomial` (incluindo
`bernoulli`), entre outras. Também existe uma forma de adaptar os MLG para a distribuição `binomial negativa`.

A definição dos MLG é dada por

$$
Y_i \sim F(\mu_i, \phi)
$$

$$
\mu_i = g^{-1}(\alpha + \beta_1 x_{i1} + \beta_p x_{ip})
$$

O parâmetro $\phi$ é o parâmetro de precisão (inverso do parâmetro de dispersão) e $g$ é a _função de ligação_, que geralmente tem o papel de jogar o intervalo de vação de $\mu_i$ (espaço paramétrico) no intervalo $(-\inf, \inf)$.

Para ajustar um modelo linear generalizado, basta utilizar a função `glm` e informar, além da fórmula, a família de distribuições da resposta.

### Famílias de distribuições


|      Family      |          Link          |
|:----------------:|:----------------------:|
|     gaussian     |        identity        |
|     binomial     | logit, probit, cloglog |
|     poisson      |  log, identity, sqrt   |
|      Gamma       | inverse, identity, log |
| inverse.gaussian |         1/mu^2         |
|      quasi       | definido pelo usuário  |

### Ajuste do modelo


```r
ajuste_glm <- glm(resposta ~ explicativas, data = dados, family = distribuicao)
```

Para ver a lista de distribuições que podem ser passadas ao parâmetro `family`, rode `?family` no R.

Outro componente importante em modelos lineares generalizados é a função de ligação. De modo mais geral, o código para ajsutar um MLG fica assim:


```r
ajuste_glm <- glm(resposta ~ explicativas, data = dados, family = distribuicao(link = funcao_de_ligacao))
```

Repare que agora existe a parte `(link = funcao_de_ligacao)` depois do nome da distribuição escolhida. É comum trocar a ligação `inversa` de uma regressão Gama para uma ligação `log`, por exemplo. Em R, ficaria:


```r
ajuste_gama <- glm(Y ~ X + I(X^2) + Z, data = dados, family = Gamma(link = "log"))
```

Todas as funções úteis para `lm()` continuam sendo úteis para `glm()`.

### Exemplo: Regressão logística

A regressão logística se caracteriza por assumir distribuição binomial à variável resposta. Para exemplificar um ajuste de regressão logística, vamos aproveitar o mesmo banco `mtcars`, mas agora vamos modelar `am` em vez de `mpg`.

#### Breve descritiva


```r
mtcars %>%
  group_by(am) %>%
  summarise("N" = n(),
            "Missing" = sum(is.na(wt)),
            "Media" = mean(wt),
            "DesvPad" = sd(wt),
            "Minimo" = min(wt),
            "Q1" = quantile(wt, 0.25),
            "Mediana" = quantile(wt, 0.50),
            "Q3" = quantile(wt, 0.75),
            "Maximo" = max(wt)) %>%
  mutate_each(funs(round(.,1)), -am)
```

```
## Error in n(): This function should not be called directly
```

```r
ggplot(mtcars) +
  geom_boxplot(aes(x = factor(am), y = wt))
```

![plot of chunk unnamed-chunk-25](assets/fig/unnamed-chunk-25-1.png) 

#### Ajuste


```r
# Ligação logit
ajuste_glm <- glm(am ~ wt, data = mtcars, family = binomial)
summary(ajuste_glm)
```

```
## 
## Call:
## glm(formula = am ~ wt, family = binomial, data = mtcars)
## 
## Deviance Residuals: 
##         Min           1Q       Median           3Q          Max  
## -2.11400245  -0.53737523  -0.08811338   0.26054663   2.19930809  
## 
## Coefficients:
##              Estimate Std. Error  z value  Pr(>|z|)   
## (Intercept) 12.040370   4.509706  2.66988 0.0075879 **
## wt          -4.023970   1.436416 -2.80140 0.0050882 **
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## (Dispersion parameter for binomial family taken to be 1)
## 
##     Null deviance: 43.229733  on 31  degrees of freedom
## Residual deviance: 19.176085  on 30  degrees of freedom
## AIC: 23.176085
## 
## Number of Fisher Scoring iterations: 6
```

```r
table(mtcars$am, predict(ajuste_glm) > 0.5)
```

```
##    
##     FALSE TRUE
##   0    18    1
##   1     3   10
```

Por padrão, a função de ligação da distribuição `binomial` é a `logit`. Se quisermos usar a função `probit`, precisamos especificar isto no parâmetro `family`.


```r
# Ligaçao probit
ajuste_glm_probit <- glm(am ~ wt, data = mtcars, family = binomial(link = "probit"))
summary(ajuste_glm_probit)
```

```
## 
## Call:
## glm(formula = am ~ wt, family = binomial(link = "probit"), data = mtcars)
## 
## Deviance Residuals: 
##         Min           1Q       Median           3Q          Max  
## -2.04795707  -0.55217121  -0.05908839   0.25290155   2.18880234  
## 
## Coefficients:
##               Estimate Std. Error  z value  Pr(>|z|)   
## (Intercept)  6.7264081  2.2684171  2.96524 0.0030244 **
## wt          -2.2577631  0.7197233 -3.13699 0.0017069 **
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## (Dispersion parameter for binomial family taken to be 1)
## 
##     Null deviance: 43.229733  on 31  degrees of freedom
## Residual deviance: 19.198730  on 30  degrees of freedom
## AIC: 23.19873
## 
## Number of Fisher Scoring iterations: 7
```

Gráfico das curvas ajustadas:

```r
ggplot(mtcars, aes(x=wt, y=am)) + 
  geom_point() + 
  stat_smooth(aes(colour = "Logit"), method="glm", family=binomial, se=FALSE) +
  stat_smooth(aes(colour = "Probit"), method="glm", family=binomial(link = "probit"), se=FALSE) +
  stat_smooth(aes(colour = "Complementar Log-Log"), method="glm", family=binomial(link = "cloglog"), se=FALSE) +
  labs(colour = "Função de ligação")
```

![plot of chunk unnamed-chunk-28](assets/fig/unnamed-chunk-28-1.png) 

O teste Chi quadrado pode ser mais indicado para regressão logística.


```r
anova(ajuste_glm, test="Chisq")
```

```
## Analysis of Deviance Table
## 
## Model: binomial, link: logit
## 
## Response: am
## 
## Terms added sequentially (first to last)
## 
## 
##      Df  Deviance Resid. Df Resid. Dev      Pr(>Chi)    
## NULL                     31  43.229733                  
## wt    1 24.053649        30  19.176085 0.00000093689 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
```

### Análise de diagnóstico

Na página [do professor Gilberto](http://www.ime.usp.br/~giapaula/textoregressao.htm) pode-se obter o livro dele sobre GLM e também vários comandos para realizar análises de diagnóstico dos modelos ajustados.

## Modelos mistos

Quando uma mesma unidade observacional é medida várias vezes em diferentes contextos, temos em mãos um problema de medidas repetidas. Em particular, quando essas medidas são realizadas ao longo do tempo, temos um problema de dados longitudinais.

A dificuldade desses tipos de estudo está no fato de que, como o mesmo indivíduo é observado em vários momentos, nem sempre é razoável considerar essas medidas como independentes. Por exemplo, se estou acompanhando o crescimento da massa de ovelhas ao longo do tempo, esperamos que a ovelha mais "gordinha" tende a ser sempre a mais gordinha.

Para resolver isso, geralmente impomos uma _estrutura de correlação_ para observações de um mesmo indivíduo, e uma maneira de impor essa estrutura de correlação é realizar uma análise com efeitos mistos.

A grande diferença de um modelo de regressão comum e um modelo misto é que parte dos parâmetros são na verdade variáveis aleatórias. Não vamos entrar em detalhe na parte teórica, mas se quiser, dê uma lida no [livro do professor Singer](http://www.ime.usp.br/~jmsinger/Textos/Singer&Nobre&Rocha2012mar.pdf), que está em andamento.

Para ajustar modelos mistos geralmente utilizamos os pacotes `nlme` e `lme4`. O pacote `nlme` faz algumas coisas a mais na parte de modelos não lineares, mas o pacote `lme4` é muito melhor desenvolvido atualmente e recomendamos seu uso.

### Exemplo: Teste t pareado

Geralmente utilizamos o teste t pareado quando queremos comparar médias, mas os indivíduos foram medidos em diferentes situações ou momentos.

Vamos ilustrar com os seguintes dados. Na base de dados `sleep`, temos medido o efeito de duas diferentes drogas aplicadas a 10 indivíduos (as duas drogas foram aplicadas nos 10 indivíduos) no tempo de sono. Queremos verificar se as drogas tiveram efeitos distintos.


```r
sleep %>%
  mutate(group=paste0('droga_', group)) %>%
  spread(group, extra)
```

```
##    ID droga_1 droga_2
## 1   1     0.7     1.9
## 2   2    -1.6     0.8
## 3   3    -0.2     1.1
## 4   4    -1.2     0.1
## 5   5    -0.1    -0.1
## 6   6     3.4     4.4
## 7   7     3.7     5.5
## 8   8     0.8     1.6
## 9   9     0.0     4.6
## 10 10     2.0     3.4
```

```r
sleep %>%
  ggplot() +
  geom_line(aes(x=group, y=extra, group=ID)) +
  geom_text(aes(x=group, y=extra, label=ID)) +
  theme_bw()
```

![plot of chunk unnamed-chunk-30](assets/fig/unnamed-chunk-30-1.png) 

Teste t pareado

```r
aux <- sleep %>%
  mutate(group=paste0('droga_', group)) %>%
  spread(group, extra)

t.test(aux$droga_1, aux$droga_2, paired=TRUE)
```

```
## 
## 	Paired t-test
## 
## data:  aux$droga_1 and aux$droga_2
## t = -4.0621, df = 9, p-value = 0.002833
## alternative hypothesis: true difference in means is not equal to 0
## 95 percent confidence interval:
##  -2.4598857633 -0.7001142367
## sample estimates:
## mean of the differences 
##                   -1.58
```

Paralelo do modelo misto


```r
library(lme4)
modelo <- lmer(extra ~ group + 1|ID, data=sleep)
```

```
## Error: number of observations (=20) <= number of random effects (=20) for term (group + 1 | ID); the random-effects parameters and the residual variance (or scale parameter) are probably unidentifiable
```

```r
summary(modelo)
```

```
## Error in summary(modelo): object 'modelo' not found
```

A parte `1|ID` indica que o indivíduo é ID e que estamos incluindo um efeito aleatório para ele.


# Árvore de Decisão

Outra tipo de modelo muito utilizado que também une simplicidade com eficiência é o de árvore de decisão. No R, seu ajuste é tão simples quanto ajustar um modelo de regressão e possui um conjunto de funções igualmente convenientes para extrair resultados.

Vamos apresentar como ajustar árvore de decisão usando o pacote `tree`, mas, como tudo no R, existem inúmeros pacotes e jeitos de ajustar uma árvore de decisão (ver este [link](http://statistical-research.com/a-brief-tour-of-the-trees-and-forests/?utm_source=rss&utm_medium=rss&utm_campaign=a-brief-tour-of-the-trees-and-forests) para uma lista interessante de alternativas).

## Ajuste


```r
library(tree)
ajuste_tree <- tree(factor(am) ~ wt, data = mtcars)
summary(ajuste_tree)
```

```
## 
## Classification tree:
## tree(formula = factor(am) ~ wt, data = mtcars)
## Number of terminal nodes:  5 
## Residual mean deviance:  0.4955481 = 13.3798 / 27 
## Misclassification error rate: 0.09375 = 3 / 32
```

```r
plot(ajuste_tree)
text(ajuste_tree, pretty = 0)
```

![plot of chunk unnamed-chunk-33](assets/fig/unnamed-chunk-33-1.png) 

Tabelas de observado versus predito: comparação entre os modelos logístico e árvore.

```r
# Logistico
table(mtcars$am, predict(ajuste_glm) > 0.5)

# Árvore
table(mtcars$am, predict(ajuste_tree)[,"1"] > 0.5)
```

## Cross-validation

Árvores tendem a "super-ajustar" (*overfit*) o modelo. Para este problema, *cross-validation* é uma boa prática. Essa técnica consiste em reservar parte da base separada para depois ser usada como régua para o poder preditivo do modelo.

Para fazer isso é muito fácil com a função `cv.tree()`. Basta passar seu modelo ajustado para ela:


```r
set.seed(123)
cv_tree <- cv.tree(ajuste_tree)
plot(cv_tree)
```

![plot of chunk unnamed-chunk-35](assets/fig/unnamed-chunk-35-1.png) 

O gráfico mostra qual tamanho da árvore que apresentou o menor erro de predição. No nosso caso foi tamanho `2`.

Para recuperar esse ajuste de tamanho `2`, chamamos a função `prune.tree()` da seguinte forma:


```r
# seleciona a árvoore com 2 nós
melhor_tree <- prune.tree(ajuste_tree, best = 2)
# Gráfico que representa a árvore `melhor_tree`
plot(melhor_tree)
text(melhor_tree, pretty = 0)
```

![plot of chunk unnamed-chunk-36](assets/fig/unnamed-chunk-36-1.png) 

```r
# oservado versus predito
table(mtcars$am, predict(melhor_tree)[,"1"] > 0.5)
```

```
## Error in eval(expr, envir, enclos): object 'ajuste_tree' not found
```

O modelo `melhor_tree` coincidiu com o `ajuste_tree` (que tinha tamanho `5`) quanto ao seu desempenho em prever, porém é muito mais simples. De fato ele é mais simples do que qualquer modelo feito até aqui.

## Parâmetros de controle

Árvores de decisão são ajustadas sob alguns critérios que às vezes precisamos reconfigurar. Por exemplo, no `ajuste_tree` vimos que havia muito mais galhos do que o necessário. Isso se deveu a critérios de divisão/parada desregulado. 

No caso dos objetos `tree`, temos dois parâmetros importantes: `split` e `control`.

**split**

O parâmetro `split` define qual o critério para decidir se divide o "galho" ou não. Por padrão, a função utiliza o critério "deviance", que tem a mesma definição do MLG. Uma segunda opção seria **Gini**.

**control**

O parâmetro `control` recebe um objeto retornado pela função `tree.control()`.

Esta função permite você configurar:

- `nobs` Número de observações na base de treino. Isso será efetivo no `cv.tree()`, quando uma base de treino e outra de teste é utilizada para calcular o erro de predição por meio de *cross-validation*.
- `mincut` Número mínimo de observações a serem incluídas em cada nó.
- `minsize` O menor tamanho de nó permitido.
- `mindev` Fração mínima do deviance do nó raiz.

Como passar à função:

```r
controles <- tree.control(nobs = 32, mincut = 10)
ajuste_tree <- ajuste_tree <- tree(factor(am) ~ wt, data = mtcars, control = controles)
plot(ajuste_tree);text(ajuste_tree, pretty = 0)
```

![plot of chunk unnamed-chunk-37](assets/fig/unnamed-chunk-37-1.png) 

# Análise multivariada

## Análise de Agrupamento

Análise de agrupamento geralmente é uma ótima maneira de realizar estudos preliminares em uma base de dados, e algumas vezes pode trazer resultados muito úteis.

Como o próprio nome diz, geralmente a análise de agrupamento serve para formar grupos de indivíduos a partir da comparação das suas medidas em relação à diversas variáveis. Não confunda aqui com árvores de decisão, pois nesse caso não há uma variável "resposta".

Existem dois tipos principais de análise de agrupamento: _hierárquico_ e _k-means_. 

### K-means
No modelo k-means, selecionamos previamente o número de grupos e o modelo calcula, com base em algum critério, qual a melhor forma de alocar os indivíduos nesses grupos. 

Para ajustar essa análise utilizaremos a função `kmeans` do pacote `stats`. Existem mais pacotes que fazem essa análise no R.


```r
kms <- kmeans(mtcars, centers=2)
kms
```

```
## K-means clustering with 2 clusters of sizes 18, 14
## 
## Cluster means:
##           mpg         cyl        disp           hp        drat          wt        qsec           vs           am        gear        carb
## 1 23.97222222 4.777777778 135.5388889  98.05555556 3.882222222 2.609055556 18.68611111 0.7777777778 0.6111111111 4.000000000 2.277777778
## 2 15.10000000 8.000000000 353.1000000 209.21428571 3.229285714 3.999214286 16.77214286 0.0000000000 0.1428571429 3.285714286 3.500000000
## 
## Clustering vector:
##           Mazda RX4       Mazda RX4 Wag          Datsun 710      Hornet 4 Drive   Hornet Sportabout             Valiant          Duster 360 
##                   1                   1                   1                   1                   2                   1                   2 
##           Merc 240D            Merc 230            Merc 280           Merc 280C          Merc 450SE          Merc 450SL         Merc 450SLC 
##                   1                   1                   1                   1                   2                   2                   2 
##  Cadillac Fleetwood Lincoln Continental   Chrysler Imperial            Fiat 128         Honda Civic      Toyota Corolla       Toyota Corona 
##                   2                   2                   2                   1                   1                   1                   1 
##    Dodge Challenger         AMC Javelin          Camaro Z28    Pontiac Firebird           Fiat X1-9       Porsche 914-2        Lotus Europa 
##                   2                   2                   2                   2                   1                   1                   1 
##      Ford Pantera L        Ferrari Dino       Maserati Bora          Volvo 142E 
##                   2                   1                   2                   1 
## 
## Within cluster sum of squares by cluster:
## [1] 58920.54393 93643.90394
##  (between_SS / total_SS =  75.5 %)
## 
## Available components:
## 
## [1] "cluster"      "centers"      "totss"        "withinss"     "tot.withinss" "betweenss"    "size"         "iter"         "ifault"
```

### Hierárquico

No modelo hierárquico, contudo, não selecionamos previamente o número de grupos, e o resultado da análise é um gráfico chamado _dendrograma_, que cria uma ordem de agrupamento dos indivíduos, desde o nível mais fragmentado (número de grupos igual ao número de indivíduos) até um agrupamento único.

Para ajustar o modelo hierárquico, utilizaremos a função `hclust`, do pacote `stats`. Existem vários métodos para ordenação dos ordenamentos. Utilizaremos aqui o método `ward.D`.

Diferentemente do método K-means, os métodos hierárquicos partem de uma matriz de distâncias ou, mais genericamente, matriz de dissimilaridades. A matrix de distâncias é uma matriz `d` com `dim(d) = c(n, n)`, onde `n` é o número de indivíduos. Geralmente é uma matriz simétrica, e na diagonal vale zero. 


```r
d <- dist(mtcars) # calcula matriz de distâncias euclidianas.
str(d)
```

```
## Class 'dist'  atomic [1:496] 0.615 54.909 98.113 210.337 65.472 ...
##   ..- attr(*, "Size")= int 32
##   ..- attr(*, "Labels")= chr [1:32] "Mazda RX4" "Mazda RX4 Wag" "Datsun 710" "Hornet 4 Drive" ...
##   ..- attr(*, "Diag")= logi FALSE
##   ..- attr(*, "Upper")= logi FALSE
##   ..- attr(*, "method")= chr "euclidean"
##   ..- attr(*, "call")= language dist(x = mtcars)
```

```r
hc <- hclust(d, method='ward.D')
hc
```

```
## 
## Call:
## hclust(d = d, method = "ward.D")
## 
## Cluster method   : ward.D 
## Distance         : euclidean 
## Number of objects: 32
```

```r
plot(hc)
```

![plot of chunk unnamed-chunk-39](assets/fig/unnamed-chunk-39-1.png) 

No método hierárquico, portanto, geralmente precisamos tomar 2 decisões para rodar a análise e construir o dendrograma: i) o método para obtenção da matriz de distâncias e o método para ordenação das aglomerações.

__OBS:__ Na análise de agrupamento, muitas vezes a escala das variáveis faz diferença, e variáveis que assumem valores muito altos podem ter uma influência maior do que outras no resultado da análise. Por isso, muitas vezes temos interesse em re-escalar as variáveis, geralmente subtraindo a média e dividindo pelo desvio padrão (normalização). Para isso, veja `?scale`.

## Análise Fatorial

Outra análise multivariada muito comum é a _análise fatorial_. Nesse tipo de estudo, geralmente estamos interessados em obter combinações de variáveis que estejam associadas a alguma variável latente não observável. Em palavras mais simples, estamos interessados em obter alguns _fatores_ que expliquem a variabilidade dos nossos dados, e depois interpretar esses fatores de alguma forma.

Para realizar análise fatorial, vamos utilizar a função `factanal` do pacote `stats`. Essa função realiza análise fatorial usando método de máxima verossimilhança. Podemos utilizar outros métodos, como decomposição espectral (autovalor e autovetor), geralmente utilizada em _análise de componentes principais_.


```r
fa <- factanal(mtcars, factors=3, rotation='none')
fa
```

```
## 
## Call:
## factanal(x = mtcars, factors = 3, rotation = "none")
## 
## Uniquenesses:
##   mpg   cyl  disp    hp  drat    wt  qsec    vs    am  gear  carb 
## 0.135 0.055 0.090 0.127 0.290 0.060 0.051 0.223 0.208 0.125 0.158 
## 
## Loadings:
##      Factor1 Factor2 Factor3
## mpg  -0.910   0.137  -0.136 
## cyl   0.962          -0.135 
## disp  0.937  -0.174         
## hp    0.875   0.292   0.147 
## drat -0.689   0.453   0.175 
## wt    0.858  -0.382   0.242 
## qsec -0.591  -0.754   0.177 
## vs   -0.809  -0.309   0.164 
## am   -0.522   0.719         
## gear -0.459   0.729   0.365 
## carb  0.594   0.517   0.471 
## 
##                Factor1 Factor2 Factor3
## SS loadings      6.448   2.465   0.565
## Proportion Var   0.586   0.224   0.051
## Cumulative Var   0.586   0.810   0.862
## 
## Test of the hypothesis that 3 factors are sufficient.
## The chi square statistic is 30.53 on 25 degrees of freedom.
## The p-value is 0.205
```

```r
pesos <- fa$loadings[,1:3] %>% data.frame %>% mutate(nomes=rownames(.))
ggplot(pesos, aes(x=Factor1, y=Factor2)) +
  geom_text(aes(label=nomes)) +
  geom_vline(xintercept=0) +
  geom_hline(yintercept=0) +
  coord_equal()
```

![plot of chunk unnamed-chunk-40](assets/fig/unnamed-chunk-40-1.png) 

Na análise fatorial, podemos realizar também a _rotação_ dos fatores obtidos, para tentar isolar os componentes de cada fator, facilitando a interpretação dos fatores. O método mais comum para realizar a rotação é pelo método `varimax`.


```r
fa <- factanal(mtcars, factors=3, rotation='varimax')

pesos <- fa$loadings[,1:3] %>% data.frame %>% mutate(nomes=rownames(.))
ggplot(pesos, aes(x=Factor1, y=Factor2)) +
  geom_text(aes(label=nomes)) +
  geom_vline(xintercept=0) +
  geom_hline(yintercept=0) +
  coord_equal()
```

![plot of chunk unnamed-chunk-41](assets/fig/unnamed-chunk-41-1.png) 

A análise fatorial tem muito mais detalhes que foram omitidos. Para um tutorial rápido, ver no [Quick-R](http://www.statmethods.net/advstats/factor.html).

## Análise de correspondência múltipla

Quando temos uma base de dados com muitas variáveis categóticas, geralmente é difícil analisá-las em conjunto, e muitas vezes ficamos fazendo um monte de tabelas de contingência, o que pode ser doloroso.

A análise de correspondência múltipla pode ser considerada como uma espécie de _análise de componentes principais_ para dados categóricos. Ela serve para dar uma "visão geral" da base de dados, reduzindo a dimensionalidade da base e visualizando as associações das variáveis em apenas um gráfico.

Para realizar a análise, vamos utilizar a função `MCA` do pacote `FactoMineR`. Esse pacote, aliás, contém diversos métodos para realização de análises multivariadas.

Como base de dados, utilizaremos `tea` do pacote `FactoMiner`, que é basicamente um questionário aplicado a 300 pessoas sobre como elas tomam chá.


```r
library(FactoMiner)
```

```
## Error in library(FactoMiner): there is no package called 'FactoMiner'
```

```r
data(tea)

# Vamos trabalhas só com essas colunas
newtea <- tea %>% select(Tea, How, how, sugar, where, always) %>% tbl_df
```

```
## Error in select(., Tea, How, how, sugar, where, always): unused arguments (Tea, How, how, sugar, where, always)
```

```r
newtea
```

```
## Error in eval(expr, envir, enclos): object 'newtea' not found
```

```r
# numero de niveis de cada variavel
cats <- newtea %>% summarise_each(funs(length(unique(.))))
```

```
## Error in eval(expr, envir, enclos): object 'newtea' not found
```

```r
cats
```

```
##     Sex Bwt  Hwt
## 1     F 2.0  7.0
## 2     F 2.0  7.4
## 3     F 2.0  9.5
## 4     F 2.1  7.2
## 5     F 2.1  7.3
## 6     F 2.1  7.6
## 7     F 2.1  8.1
## 8     F 2.1  8.2
## 9     F 2.1  8.3
## 10    F 2.1  8.5
## 11    F 2.1  8.7
## 12    F 2.1  9.8
## 13    F 2.2  7.1
## 14    F 2.2  8.7
## 15    F 2.2  9.1
## 16    F 2.2  9.7
## 17    F 2.2 10.9
## 18    F 2.2 11.0
## 19    F 2.3  7.3
## 20    F 2.3  7.9
## 21    F 2.3  8.4
## 22    F 2.3  9.0
## 23    F 2.3  9.0
## 24    F 2.3  9.5
## 25    F 2.3  9.6
## 26    F 2.3  9.7
## 27    F 2.3 10.1
## 28    F 2.3 10.1
## 29    F 2.3 10.6
## 30    F 2.3 11.2
## 31    F 2.4  6.3
## 32    F 2.4  8.7
## 33    F 2.4  8.8
## 34    F 2.4 10.2
## 35    F 2.5  9.0
## 36    F 2.5 10.9
## 37    F 2.6  8.7
## 38    F 2.6 10.1
## 39    F 2.6 10.1
## 40    F 2.7  8.5
## 41    F 2.7 10.2
## 42    F 2.7 10.8
## 43    F 2.9  9.9
## 44    F 2.9 10.1
## 45    F 2.9 10.1
## 46    F 3.0 10.6
## 47    F 3.0 13.0
## 48    M 2.0  6.5
## 49    M 2.0  6.5
## 50    M 2.1 10.1
## 51    M 2.2  7.2
## 52    M 2.2  7.6
## 53    M 2.2  7.9
## 54    M 2.2  8.5
## 55    M 2.2  9.1
## 56    M 2.2  9.6
## 57    M 2.2  9.6
## 58    M 2.2 10.7
## 59    M 2.3  9.6
## 60    M 2.4  7.3
## 61    M 2.4  7.9
## 62    M 2.4  7.9
## 63    M 2.4  9.1
## 64    M 2.4  9.3
## 65    M 2.5  7.9
## 66    M 2.5  8.6
## 67    M 2.5  8.8
## 68    M 2.5  8.8
## 69    M 2.5  9.3
## 70    M 2.5 11.0
## 71    M 2.5 12.7
## 72    M 2.5 12.7
## 73    M 2.6  7.7
## 74    M 2.6  8.3
## 75    M 2.6  9.4
## 76    M 2.6  9.4
## 77    M 2.6 10.5
## 78    M 2.6 11.5
## 79    M 2.7  8.0
## 80    M 2.7  9.0
## 81    M 2.7  9.6
## 82    M 2.7  9.6
## 83    M 2.7  9.8
## 84    M 2.7 10.4
## 85    M 2.7 11.1
## 86    M 2.7 12.0
## 87    M 2.7 12.5
## 88    M 2.8  9.1
## 89    M 2.8 10.0
## 90    M 2.8 10.2
## 91    M 2.8 11.4
## 92    M 2.8 12.0
## 93    M 2.8 13.3
## 94    M 2.8 13.5
## 95    M 2.9  9.4
## 96    M 2.9 10.1
## 97    M 2.9 10.6
## 98    M 2.9 11.3
## 99    M 2.9 11.8
## 100   M 3.0 10.0
## 101   M 3.0 10.4
## 102   M 3.0 10.6
## 103   M 3.0 11.6
## 104   M 3.0 12.2
## 105   M 3.0 12.4
## 106   M 3.0 12.7
## 107   M 3.0 13.3
## 108   M 3.0 13.8
## 109   M 3.1  9.9
## 110   M 3.1 11.5
## 111   M 3.1 12.1
## 112   M 3.1 12.5
## 113   M 3.1 13.0
## 114   M 3.1 14.3
## 115   M 3.2 11.6
## 116   M 3.2 11.9
## 117   M 3.2 12.3
## 118   M 3.2 13.0
## 119   M 3.2 13.5
## 120   M 3.2 13.6
## 121   M 3.3 11.5
## 122   M 3.3 12.0
## 123   M 3.3 14.1
## 124   M 3.3 14.9
## 125   M 3.3 15.4
## 126   M 3.4 11.2
## 127   M 3.4 12.2
## 128   M 3.4 12.4
## 129   M 3.4 12.8
## 130   M 3.4 14.4
## 131   M 3.5 11.7
## 132   M 3.5 12.9
## 133   M 3.5 15.6
## 134   M 3.5 15.7
## 135   M 3.5 17.2
## 136   M 3.6 11.8
## 137   M 3.6 13.3
## 138   M 3.6 14.8
## 139   M 3.6 15.0
## 140   M 3.7 11.0
## 141   M 3.8 14.8
## 142   M 3.8 16.8
## 143   M 3.9 14.4
## 144   M 3.9 20.5
```


```r
# MCA
mca <- MCA(newtea, graph = FALSE)
```

```
## Error in as.data.frame(X): object 'newtea' not found
```

```r
# Coordenadas das variaveis
mca1_vars_df <- data.frame(mca$var$coord, variavel=rep(names(cats), cats), stringsAsFactors=F) %>%
  mutate(rnames=row.names(.))
```

```
## Error in mca$var: object of type 'closure' is not subsettable
```

```r
# Coordenadas das observacoes
mca1_obs_df <- data.frame(mca$ind$coord)
```

```
## Error in mca$ind: object of type 'closure' is not subsettable
```

```r
# Um gráfico bonito
ggplot() +
  geom_hline(yintercept = 0, colour = "gray70") +
  geom_vline(xintercept = 0, colour = "gray70") +
  geom_text(aes(x=Dim.1, y=Dim.2, colour=variavel, label=rnames), data=mca1_vars_df) +
  geom_point(aes(x=Dim.1, y=Dim.2), colour = "gray50", alpha = 0.7, data=mca1_obs_df) +
  geom_density2d(aes(x=Dim.1, y=Dim.2), colour = "gray80", data=mca1_obs_df)
```

```
## Error in do.call("layer", list(mapping = mapping, data = data, stat = stat, : object 'mca1_vars_df' not found
```

O gráfico mostra várias coisas de uma vez só. 

- A dispersão mostra as dimensões calculadas pelo método de análise de correspondência múltipla. 
- As curvas de nível mostram a concentração dos dados.
- Os textos são os níveis das variáveis, identificados pela cor.

Nesse caso, verificamos, por exemplo, que pode existir uma associação entre `how` e `where`, pois "tea bag" está muito próximo de "chain store".

__OBS:__ Baseado no excelente post de [Gaston Sanchez](http://gastonsanchez.com/blog/how-to/2012/10/13/MCA-in-R.html).

# Demais tópicos

- Séries temporais
- Dados categorizados
- GAM/GAMLSS
- Inferência Bayesiana
- Processos estocásticos
- Reamostragem
- Muito mais!

# Referências

http://www-bcf.usc.edu/~gareth/ISL/ISLR%20First%20Printing.pdf

http://web.stanford.edu/~hastie/local.ftp/Springer/OLD/ESLII_print4.pdf

http://www.ime.usp.br/~giapaula/texto_2013.pdf

Colosimo, E.A. e Giolo, S.R. (2006) Análise de sobrevivência aplicada. ABE - Projeto Fisher, Blucher.

http://adv-r.had.co.nz/Functions.html

http://www.burns-stat.com/pages/Tutor/R_inferno.pdf
