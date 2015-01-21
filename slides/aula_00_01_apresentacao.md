---
title: "Aula 1 - Noções básicas"
author: "Curso de R: Do casual ao avançado"
date: "19 de janeiro de 2015"
output: 
  ioslides_presentation:
    mathjax: "//cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML"
    logo: logo.png
    keep_md: true
    self_contained: true
---



## Agenda do curso {.smaller}

<div class="red2">
* Aula 00 - Sobre o curso e porque usar R
* Aula 01 - Noções básicas
* Aula 02 - Estruturas de Dados e Vocabulário
* Aula 03 - Laboratório I
</div>
<div class="yellow3">
* Aula 04 - Manipulação de dados
* Aula 05 - Gráficos com estilo - ggplot2
* Aula 06 - Laboratório II
</div>
<div class="blue2">
* Aula 07 - Modelando
* Aula 08 - Aula dos alunos
* Aula 09 - Laboratório III
</div>
<div class="green2">
* Aula 10 - Shiny
* Aula 11 - Pacotes e tópicos extras
* Aula 12 - Laboratório IV
</div>

## Por que R? {.build}

- De graça
- Escrito por estatísticos, para estatísticos
- Uma linguagem de programação
- Atualizado e com grande gama de funções analíticas
- Comunidade ativa e crescente

## Prós e contras do R vs. outros pacotes estatísticos

<div class="red2">
<strong>Por que SAS/SPSS é preferido pelas empresas?</strong>
</div>

- SAS é mais preparado para grandes bases de dados. o R guarda tudo na memória
- SAS/SPSS tem suporte dedicado e garantia das suas rotinas e ferramentas. O R não tem suporte oficial e não trás garantias.
- SAS/SPSS está na praça há muito mais tempo do que o R
- No SAS/SPSS não há necessidade de grandes investimentos em treinamento de pessoal para operar
- SAS é um "canivete suíço". Ele é ferramenta analítica, governança corporativa, gestão e serviços de TI e etc.

## Prós e contras do R vs. outros pacotes estatísticos

<div class="red2">
<strong>Para análise estatística, o R...</strong>
</div>

- permite analisar, manusear e limpar dados com mais facilidade e agilidade
- possui sistema e pacotes de visualização de dados que é referência
- tem, potencialmente, capacidade de interagir com qualquer software e linguagem de programação, inclusive com o SAS e Excel
- facilita a análise de dados colaborativa

## Prós e contras do R vs. outras linguagens

- Das linguagens de programação, as mais populares para análise de dados são Python, Matlab/Octave e Java.
- Python é o mais parecido com o R e também o com maior aderência entre os estatísticos
- Métodos estatísticos básicos e consagrados podem ser feitos em todas essas linguagens. No Python, há mais opções

## Prós e contras do R vs. Python

<div class="green2">
<strong>Vantagens do R</strong>
</div>

- O R é a única linguagem cujo foco de desenvolvimento é análise de dados
- De um tempo para cá, TODOS os novos métodos estatísticos são escritos primeiro em R
- Menor curva de aprendizado
- Fácil assimilação entre a matemática e a implementação

<div class="red2">
<strong>Desvantagens do R</strong>
</div>

- Velocidade
- Eficiência (uso da memória)

## Prós e contras do R vs. Python

<div class="green2">
<strong>Vantagens do Python</strong>
</div>

- Mais desenvolvido na área de processamento de texto
- Linguagem de programação completa de uso geral, própria para produção
- Eficiente (não aloca dados na memória)

<div class="red2">
<strong>Desvantagens do Python</strong>
</div>

- Velocidade
- Maior curva de aprendizado. Exige mais programação
- O foco de desenvolvimento não é análise de dados

## Prós e contras do R vs. Python

<div>
<strong>Considerações</strong>
</div>

- Via de regra, se você já tem destreza em alguma dessas linguagens de programação, continue nela... até bater em uma barreira.
- Principal barreira do <span class="red2">R</span> é 
eficiência
- Principal barreira do <span class="blue2">Python</span> é disponibilidade de funções
- Geralmente, bate-se na barreira do <span class="blue2">Python</span> antes da barreira do <span class="red2">R</span>

## Motivação

- R está no Google, Facebook, Bank of America, Pfizer, [New York Times](http://www.nytimes.com/interactive/2013/03/29/sports/baseball/Strikeouts-Are-Still-Soaring.html?ref=baseball). Está no IBOPE, Itaú, IBGE, DIEESE
- Relatórios estatísticos profissionais e em vários formatos
- Aplicativos interativos ([TJSP](http://23.21.159.27:3838/shinyABJ/tjsp))
- Modelagem e técnicas estatísticas básicas e avançadas

## Instalação do R e do RStudio

- [R CRAN](http://cran.r-project.org/)
- [RStudio](http://www.rstudio.com/)

## Reconhecimento do RStudio

<img src="http://www.rstudio.com/wp-content/uploads/2014/06/RStudio-Ball.png" style="width:200px; margin-left:290px; margin-top:100px"></img>

## Primeiro contato com o R

- `getwd()`: consulta qual é o diretório de trabalho atual (`working directory`)
- `setwd()`: altera o diretório de trabalho
- Caminhos de pasta no R pode ter **apenas** `\\` ou `/` 
- Projetos do RStudio (`.RProj`) guardam essa informação
- `install.packages("<nome_do_pacote>")`: instala pacotes
- `library(<nome_do_pacote>)`: carrega pacote e disponibiliza suas funções e bases de dados para serem usados

## Pedindo ajuda

- Help / documentação
- [Google it](http://bit.ly/1u7tlv1)
- [Stack Overflow](http://stackoverflow.com/).
- [Melhores práticas para postar no Stack Overflow](http://stackoverflow.com/help/how-to-ask).
- Vamos utilizar o Stack Overflow para dúvidas durante o curso.

## R como calculadora

<div>
<strong>Operadores aritméticos</strong>
</div>


```r
pi
```

```
## [1] 3.142
```

```r
sin(pi/2) + 2*3 - 4^2
```

```
## [1] -9
```

```r
(sin(pi/2) + 2)*3 + (-4)^2
```

```
## [1] 25
```

## R como calculadora

<div>
<strong>Valores especiais</strong>
</div>
<br/>

|  Valor   |                  Quando.ocorre                  |
|:--------:|:-----------------------------------------------:|
| Inf/-Inf |  Divisões por zero, valores da ordem de 10^308  |
|   NaN    | Indeterminações matemáticas, como 0/0 e log(-1) |

## R como calculadora {.smaller}

<div>
<strong>Operadores aritméticos</strong>
</div>
<br/>

|   Operador    |              Descrição               |
|:-------------:|:------------------------------------:|
|     x + y     |          Adição de x com y           |
|     x - y     |         Subtração de y em x          |
|    x \* y     |        Multiplicação de x e y        |
|     x / y     |          Divisão de x por y          |
| x^y ou x\*\*y |     x elevado a y-ésima potência     |
|     x%%y      | Resto da divisão de x por y (módulo) |
|     x%/%y     | Parte inteira da divisão de x por y  |

## R como calculadora {.smaller}

<div>
<strong>Operadores lógicos</strong>
</div>

|  operador  |                 descricao                 |
|:----------:|:-----------------------------------------:|
|   x < y    |              x menor que y?               |
|   x <= y   |           x menor ou igual a y?           |
|   x > y    |              x maior que y?               |
|   x >= y   |           x maior ou igual a y?           |
|   x == y   |               x igual a y?                |
|   x != y   |             x diferente de y?             |
|     !x     |               Negativa de x               |
|   x \| y   |          x ou y são verdadeiros?          |
|   x & y    |          x e y são verdadeiros?           |
| xor(x, y)  | x ou y são verdadeiros (apenas um deles)? |

## R como calculadora

<div>
<strong>Números complexos</strong>
</div>

```r
z <- -8 + 0i

# verifica se z é um número commplexo
class(z)
```

```
## [1] "complex"
```

```r
is.complex(z)
```

```
## [1] TRUE
```

## R como calculadora {.smaller}

<div>
<strong>Números complexos</strong>
</div>


|  Função  |        Descrição        |
|:--------:|:-----------------------:|
|  Re(z)   |     Parte real de z     |
|  Im(z)   |  Parte imaginária de z  |
|  Mod(z)  |       Módulo de z       |
|  Arg(z)  |     Argumento de z      |
| Conj(z)  | Complexo conjugado de z |

## if, else e else if {.build}

**Estrutura**


```r
if(<condição1>) {
  # se a condição1 for verdadeira...
  # faz coisas interessantes.
} else if (<condição2>) {
  # caso a condição1 seja falsa e a condição2 seja verdadeira...
  # faz coisas legais para este caso.
} else {
  # faz coisas necessárias caso todas as condições
  # anteriores falharem
}
```

## if, else e else if

**Cuidado!** O `else` e o `else if` têm que estar na mesma linha do `}` da expressão anterior, senão não rodará!


```r
# Certo
if(1 == 2) {
  "Um resultado muito interessante!"
} else { # <----- Mesma linha que o "}"
  "1 é diferente de 2"
}

# ERRADO!!! Não rodará
if(1 == 2) {
  "Um resultado muito interessante!"
### <b>
}
else { # <----- Na linha abaixo do "}"
  "1 é diferente de 2"
### </b>
}
```

## if, else e else if

- Além de `TRUE` e `FALSE`, o R aceita `1` e `0`, respectivamente
- Objetos `character`, `NA`, `NaN` e `list` não são interpretáveis como lógicos
- Caso seja passado um `array`, `vector` ou `matrix`, será utilizado apenas o primeiro elemento (evitar!)
- `else` e `else if` são opcionais.

## for {.build}

O `for` é um tipo "laço" (*loop*, em inglês) que aplica um bloco de código para um número fixo de iterações. Geralmente, um `for` percorre um vetor e utiliza um elemento diferente deste vetor em cada iteração.

**Estrutura**


```r
for(iterador in <sequencia>) {
  # Fazer algo para cada item da <sequencia>
  # pode ter outros for's aqui dentro!
}
```

## for
Exemplo simples: iterar numa sequência de inteiros

```r
for(i in 1:5) {
  print(i)
}
```

```
## [1] 1
## [1] 2
## [1] 3
## [1] 4
## [1] 5
```

## for
Exemplo simples: iterar num vetor de palavras

```r
frutas <- c("banana", "uva", "abacaxi")

# Brincadeira da <fruta> + "guei"
for(fruta in frutas) {
  print(paste(fruta, "guei", sep = ""))
}
```

```
## [1] "bananaguei"
## [1] "uvaguei"
## [1] "abacaxiguei"
```

## for

**Considerações**

- Frequentemente é vantagem iterar sobre índices do vetor em vez dos valores propriamente ditos
- O **for** é especialmente ineficiente no R. O seu uso, ao contrário das outras linguagens de programação, se tornará cada vez menos frequente conforme você for se aprimorando no R

## *ifelse()*: *for* com *if else* {.build}


```r
frutas1 <- c("banana", "uva", "abacaxi")
frutas2 <- c("kiwi", "uva", "laranja")
pessoas <- c("Amanda", "Bruno", "Caio")

frutas1 <- ifelse(frutas1 == frutas2, "manga", frutas1)
data.frame(pessoas, frutas1, frutas2)
```

```
##   pessoas frutas1 frutas2
## 1  Amanda  banana    kiwi
## 2   Bruno   manga     uva
## 3    Caio abacaxi laranja
```

OBS: esse é um exemplo de aplicação do conceito de **vetorização** (que veremos mais adiante)

## while {.build}

O laço `while` é especialmente útil quando não sabemos quando iremos parar (a condição para o laço deixar de rodar pode envolver o **acaso** ou **convergência**, por exemplo). 

### Estrutura:

Similar ao `if`.


```r
while(<condições>) {
  # coisas para fazzer enquanto as <condições> forem TRUE
}
```

## while

Exemplo: Variável aleatória Geométrica. 


```r
set.seed(123) # para reprodução
p <- 0.2 # probabilidade de cair "cara"
lances <- 0 # contador de lançamentos
### <b>
while(runif(1) > p) {
### </b>
  lances <- lances + 1
}

lances
```

```
## [1] 5
```

OBS: Condição depende do **acaso**

## Vetorização {.build}

- Vetores no R são cadeias ordenadas de elementos, geralmente números ou palavras
- Vetores são objetos que guardam dados
- R aceita vetores em quase todas as suas funções
- Para lembrar: *loops* no R são sofrivelmente ineficientes

## Vetorização

$$
  f([x_1, \dots, x_n]) = [f(x_1), \dots, f(x_n)]
$$

Exemplo:

```r
nums <- 1:5
log10(nums)
```

```
## [1] 0.0000 0.3010 0.4771 0.6021 0.6990
```

```r
2^nums
```

```
## [1]  2  4  8 16 32
```

## Vetorização

Funções vetorizadas...

- são (muito) mais velozes
- estão implementadas em lingaguens de baixo nível (FORTRAN, C ou C++)
- são algoritmos testados e feitos por especialistas
- funcionam para diferentes tipos de objetos passados à elas

## Reciclagem {.build}

Exemplo: soma de vetores de tamanhos diferentes.


```r
x <- c(1,5)
y <- c(1,10,100,1000)
x + y
```

```
## [1]    2   15  101 1005
```

## Funções {.build}

**Estrutura**


```r
nome_da_funcao <- function(<parâmetros>) {
  # faz coisas com os parâmetros
  resultado
}

# uso da função
nome_da_funcao(param1, param2, ...)
```

## Funções

- Funções também são objetos! (tudo à esquerda de `<-` vira objeto no R)
- Funções podem ser passadas como argumentos de outras funções
- Use suas funções como se tivessem vindas com o R: `nome_da_funcao(...)`
- Crie uma função sempre que for repetir o código e for mudar poucas coisas entre essas repetições
- Crie funções se esta puder ser generalizada para a tarefa específica em que sua implementação foi motivada

## Funções

**Parâmetros**


```r
### <b>
nome_da_funcao <- function(<parâmetros>) {
### </b>
  # faz coisas com os parâmetros
  resultado
}
```

- Parâmetros são objetos cujos valores devem ser atribuídos pelo usuário
- Funções aceitam quantos parâmetros precisar, e de qualquer tipo, inclusive nada (`NULL`)
- Os nomes dos parâmetros se tornarão objetos que só poderão ser usados dentro da função

## Funções

**Parâmetros opcionais**

Podemos definir parâmetros que possuem valores "padrão".


```r
# função que ecoa uma palavra
ecoar <- function(palavra, n_ecos = 3) {
    paste(c(rep(palavra, n_ecos), "!"), collapse = " ")
}

ecoar("eco")
```

```
## [1] "eco eco eco !"
```

```r
ecoar("eco", 5)
```

```
## [1] "eco eco eco eco eco !"
```

## Funções

**Parâmetros relativos**

Um parâmetro pode usar outro parâmetro como valor padrão.


```r
# Função que desenha um histograma
### <b>
histograma <- function(numeros, xlab = "x", titulo = paste("Histograma de", xlab)) {
### </b>
  hist(numeros, xlab = xlab, main = titulo)
}
```

O parâmetro `titulo` usa o parâmetro `xlab` para compor seu valor padrão.


## Funções

**Ordem ou nome dos parâmetros**

Funções entenderão os parâmetros passados...

- se forem passados com o nome, mesmo que fora da ordem
- se forem passados na ordem, mesmo que sem o nome
- se não houver ambiguidade, o R aceita parte do nome do parâmetro


```r
# As quatro linhas abaixo resultam no mesmo gráfico
histograma(altura, "altura")                  # na ordem
histograma(numeros = altura, xlab = "altura") # pelo nome
histograma(xlab = "altura", altura)           # pelo nome e depois na ordem
histograma(altura, xl = "altura")             # parte do nome
```

## Funções

**Parâmetro '...'**

- Utilidade 1: o número de argumentos é indefinido


```r
args(paste)
```

```
## function (..., sep = " ", collapse = NULL) 
## NULL
```

```r
# poderíamos passar qualquer quantidade de palavras
paste("Eu", "sou", "o", "capitão", "planeta")
```

```
## [1] "Eu sou o capitão planeta"
```

## Funções

**Parâmetro '...'**

- Utilidade 2: os parâmetros extras serão passados a uma terceira função que tem muitos parâmetros


```r
histograma <- function(numeros, xlab = "x", 
                       titulo = paste("Histograma de", xlab), ...) {
  hist(numeros, xlab = xlab, main = titulo, ...)
}

# parâmetros extras para hist()
histograma(altura, breaks = 100, col = 2)
```

Passamos `breaks` e `col` à função `histograma()` que repassou à função `hist()`.

## Funções

**Funções anônimas**


```r
nums <- 1:4

eh_par <- sapply(nums,
### <b>
                 function(numero) {numero %% 2 == 0})
### </b>
cbind(nums, eh_par) 
```

```
##      nums eh_par
## [1,]    1      0
## [2,]    2      1
## [3,]    3      0
## [4,]    4      1
```

O objeto `function(numero) {numero %% 2 == 0}` define uma função, mas essa função não tem nome!

## Funções

**Escopo**


```r
(x <- exp(1))
```

```
## [1] 2.718
```

```r
f <- function(x) print(x)
f(2)
```

```
## [1] 2
```

```r
g <- function(y) print(x)
g(2)
```

```
## [1] 2.718
```

## Funções

**Escopo**

- Objetos moram em **ambientes** (*environments*)
- As funções as procuram os objetos que precisam usar nesses *environments*
- A ordem de procura segue a regra do mais específico até o ambiente global (`.GlobalEnv`)
- Se nada for encontrado, retorna um erro
- Se houver dois objetos com o mesmo nome, prevalece o mais específico (o primeiro que for encontrado)

## Variáveis aleatórias {.build}


```r
dnorm(x, mean = 0, sd = 1, log = FALSE)
pnorm(q, mean = 0, sd = 1, lower.tail = TRUE, log.p = FALSE)
qnorm(p, mean = 0, sd = 1, lower.tail = TRUE, log.p = FALSE)
rnorm(n, mean = 0, sd = 1)
```

## Variáveis aleatórias

- **d** ("density") Densidade da Normal, ou f.d.p da Normal
- **p** ("probability") Função de distribuição acumulada (f.d.a) da Normal
- **q** ("quantile") Quantil da Normal
- **r** ("random") Gera um número vindo de uma Normal

## Variáveis aleatórias {.smaller}

No lugar de `norm`, você pode trocar por outra distribuição de probabilidade.


|  Distribuição  |  Apelido  |
|:--------------:|:---------:|
|     Normal     |   norm    |
|    Uniforme    |   unif    |
|      Beta      |   beta    |
|  Chi Quadrado  |   chisq   |
|  Exponencial   |    exp    |
| F de Snedecor  |     f     |
|      Gama      |   gamma   |
|    Poisson     |   pois    |


## Vocabulário



**Trigonometria**


|           Função            |            Descrição            |
|:---------------------------:|:-------------------------------:|
|  cos(x) / sin(x) / tan(x)   |   seno/cosseno/tangente de x    |
| acos(x) / asin(x) / atan(x) | arco-seno/cosseno/tangente de x |

## Vocabulário {.smaller}

**Matemática**


|    Função    |        Descrição        |
|:------------:|:-----------------------:|
|    log(x)    | Logaritmo natural de x  |
|    exp(x)    |      e elevado a x      |
|    abs(x)    |   valor absoluto de x   |
|   sign(x)    |  sinal de x (1 ou -1)   |
|   sqrt(x)    |   raiz quadrada de x    |
| choose(n, k) | combinações de n, k a k |
| factorial(x) |      fatorial de x      |

## Vocabulário

**Estatística**


|        Função         |                  Descrição                  |
|:---------------------:|:-------------------------------------------:|
|        mean(x)        |                 Média de x                  |
|    var(x) / sd(x)     |   Variância / Desvio Padrão amostral de x   |
|      quantile(x)      |                Quantis de x                 |
| cov(x, y) / cor(x, y) | Covariância / Correlação linear entre x e y |

## Vocabulário

**Diversos**


|  Função  |                 Descrição                  |
|:--------:|:------------------------------------------:|
|   x:y    |            Sequencia de x até y            |
|   x=y    |          x recebe y (atribuição)           |
|    ?x    |             documentação de x              |
|   x$y    |         extração de y do objeto x          |
|  x%\*%y  | Multiplicação matricial das matrizes x e y |


## Referências

[R Inferno](http://www.burns-stat.com/pages/Tutor/R_inferno.pdf)


