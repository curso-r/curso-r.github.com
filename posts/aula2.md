---
output: html_document
---
---
title: Aula 2
date : 2014-12-02
--- &lead

# Estruturas de dados

Tipos básicos de estrutura no R:

- **Atomic vector**: homogêneo e unidimensional
- **Matriz**: homogêneo e bidimensional
- **Array**: homogêneo e multidimensional
- **Lista**: heterogêneo e unidimensional
- **Data frame**: heterogêneo bidimensional


**Nota**: em sua implementação, atomic vectors e matrizes são também arrays e data frames são listas. :wink:


## Atomic Vectors

Atomic vectors são a estrutura de objetos mais simples do R, caracterizados por "não terem dimensão".

Tipos de atomic vectos:

- lógico
- integer
- double
- complexo
- character

Exemplos:


```r
dbl_var <- c(1, 2.5, 4.5) #DOUBLE
# Com o sufixo L temos números inteiros em vez de double
int_var <- c(1L, 6L, 10L)
# Use TRUE ou FALSE (T ou F) para vetores lógicos
log_var <- c(TRUE, FALSE, T, F)
chr_var <- c("essas são", "algumas strings")
```

**Curiosidade**: na função `c()`, o *c* é de *concatenate*.

Para saber qual é o tipo de um objeto, utilizamos a função `typeof`.


```r
typeof(dbl_var)
```

```
## [1] "double"
```

```r
typeof(int_var)
```

```
## [1] "integer"
```

```r
typeof(log_var)
```

```
## [1] "logical"
```

```r
typeof(chr_var)
```

```
## [1] "character"
```

As funções `is.integer`, `is.double`, `is.logical`, `is.character` são usadas para testar se um objeto é de um determinado tipo.


```r
is.integer(dbl_var)
```

```
## [1] FALSE
```

```r
is.double(dbl_var)
```

```
## [1] TRUE
```

```r
is.numeric(dbl_var)
```

```
## [1] TRUE
```

```r
is.logical(log_var)
```

```
## [1] TRUE
```

```r
is.character(chr_var)
```

```
## [1] TRUE
```

Note a função `is.numeric`, ela retorna `TRUE` tanto para objetos double quanto para integer.

### Coerção

Quando dois tipos de objetos são inseridos em um atomic vector o R converte o vetor para o tipo mais flexível, na ordem:

- logical
- integer
- double
- character


```r
c("a", 1)
```

```
## [1] "a" "1"
```

```r
c(T, 1)
```

```
## [1] 1 1
```

Isso pode ser útil, por exemplo para contar o número de TRUES em um vetor lógico


```r
sum(c(T, F, T, F, T))
```

```
## [1] 3
```

### Factors

- Vetor que pode conter apenas valores pré-definidos.
- Utilizado para armazenar dados categóricos
- Implementado baseado num vetor de inteiros



```r
f <- factor(c("oi", "tudo", "bem", "?"))
f
```

```
## [1] oi   tudo bem  ?   
## Levels: ? bem oi tudo
```

```r
levels(f)
```

```
## [1] "?"    "bem"  "oi"   "tudo"
```

Sempre tome cuidado ao converter objetos factor em numericos:


```r
f <- factor(c("2", "3", "1", "10"))
as.numeric(f)
```

```
## [1] 3 4 1 2
```

```r
as.numeric(as.character(f))
```

```
## [1]  2  3  1 10
```


## Matrizes e Arrays

Matrizes e arrays são definidos usando as funções `matrix` e `array`.


```r
# Dois argumentos para determinar o número de linahs e colunas
a <- matrix(1:6, ncol = 3, nrow = 2)
# Um vetor para descrever todas as dimensões
b <- array(1:12, c(3,2,2))
```

### Dimensões

As funções `length`, `dim`, `nrow`, `ncol` são usadas para determinar as o número de elementos em cada dimensão de um objeto.


```r
length(c(1,2,3))
```

```
## [1] 3
```

```r
dim(c(1,2,3))
```

```
## NULL
```

```r
nrow(c(1,2,3))
```

```
## NULL
```

```r
length(a)
```

```
## [1] 6
```

```r
nrow(a)
```

```
## [1] 2
```

```r
ncol(a)
```

```
## [1] 3
```

```r
dim(a)
```

```
## [1] 2 3
```

```r
length(b)
```

```
## [1] 12
```

```r
nrow(b)
```

```
## [1] 3
```

```r
ncol(b)
```

```
## [1] 2
```

```r
dim(b)
```

```
## [1] 3 2 2
```

## Listas e Data.Frames

Listas são definidas usando a função `list`


```r
list(
  c(1:5),
  c("oi", "tchau"),
  c(T, F, T),
  list(c(1,2,3), "oi")
  )
```

```
## [[1]]
## [1] 1 2 3 4 5
## 
## [[2]]
## [1] "oi"    "tchau"
## 
## [[3]]
## [1]  TRUE FALSE  TRUE
## 
## [[4]]
## [[4]][[1]]
## [1] 1 2 3
## 
## [[4]][[2]]
## [1] "oi"
```

data.frames são listas em que todos os elementos são vetores do mesmo tamanho. São definidos usando a função `data.frame`.


```r
df <- data.frame(x = 1:4, y = c("oi", "oi", "oi", "oi"), z = T)
df
```

```
##   x  y    z
## 1 1 oi TRUE
## 2 2 oi TRUE
## 3 3 oi TRUE
## 4 4 oi TRUE
```

```r
str(df)
```

```
## 'data.frame':	4 obs. of  3 variables:
##  $ x: int  1 2 3 4
##  $ y: Factor w/ 1 level "oi": 1 1 1 1
##  $ z: logi  TRUE TRUE TRUE TRUE
```

data.frame converte os vetores de caracteres em factors!! se não quiser utilizar este comportamento, use o argumento `stringAsFactors = F`


```r
df <- data.frame(x = 1:4, y = c("oi", "oi", "oi", "oi"), z = T, stringsAsFactors = F)
str(df)
```

```
## 'data.frame':	4 obs. of  3 variables:
##  $ x: int  1 2 3 4
##  $ y: chr  "oi" "oi" "oi" "oi"
##  $ z: logi  TRUE TRUE TRUE TRUE
```

Se usarmos a função `names` obtemos o nome das colunas do `data.frame`. Também é possível mudar o nome das colunas dessa forma:


```r
names(df)
```

```
## [1] "x" "y" "z"
```

```r
names(df) <- c("a", "b", "c")
names(df)
```

```
## [1] "a" "b" "c"
```

### Combinando data.frames

É possível combinar data.frames usando as funções `cbind` e `rbind`:


```r
df1 <- data.frame(x = 1:4, y = c("oi", "oi", "oi", "oi"), z = T)
df2 <- data.frame(x = 1:4, y = c("oi", "oi", "oi", "oi"), z = T)

rbind(df1, df2)
```

```
##   x  y    z
## 1 1 oi TRUE
## 2 2 oi TRUE
## 3 3 oi TRUE
## 4 4 oi TRUE
## 5 1 oi TRUE
## 6 2 oi TRUE
## 7 3 oi TRUE
## 8 4 oi TRUE
```

```r
cbind(df1, df2)
```

```
##   x  y    z x  y    z
## 1 1 oi TRUE 1 oi TRUE
## 2 2 oi TRUE 2 oi TRUE
## 3 3 oi TRUE 3 oi TRUE
## 4 4 oi TRUE 4 oi TRUE
```



