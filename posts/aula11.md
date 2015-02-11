---
title: "Aula 11 - Pacotes e tópicos extras"
date : 2015-02-11
# output: ioslides_presentation
---

<a href="http://curso-r.github.io/slides/aula_11_apresentacao.html" target="_blank">Slides dessa aula</a>

# Criação de pacotes

## Criação de pacotes

Baseado no livro [r-pkgs](http://r-pkgs.had.co.nz/description.html) do Hadley

<!-- ___________________________________________________________________________________________ -->

## Vantagens {.build}

- Economia de tempo para tarefas futuras
- Forma de organização pré-estabelecida
- Contribuir e aproveitar contribuições da comunidade

## Filosofia {.build}

- Tudo que pode ser automatizado, deve ser automatizado
- Utilização do pacote `devtools` como base para criação de pacotes
- Trabalhar menos com os detalhes (estrutura, etc.) e mais com funcionalidades (funções úteis, etc).
- Se for necessário trabalhar com coisas mais complexas, ler [Writing R extensions](cran.r-project.org/doc/manuals/R-exts.html#Creating-R-packages)

## Pré-requisitos

- Pacotes `devtools`, `roxygen2`, `testthat`, `knitr`
- **R** e **RStudio** atualizados (recomenda-se preview version do RStudio)
- Instalar versão `dev` do `devtools`


```r
devtools::install_github('hadley/devtools')
```

## Pré-requisitos

- No Windows, instalar o [Rtools](cran.r-project.org/bin/windows/Rtools)
- No Mac, instalar o [XCode](developer.apple.com/downloads)
- No linux, instalar o pacote de desenvolvimento `r-base-dev`. No Ubuntu, basta digitar


```r
sudo apt-get install r-base-dev
```

- Verifique se está tudo certo digitando `devtools::has_devel()`.

<!-- ___________________________________________________________________________________________ -->

## Exemplo

- Crie um projeto pelo RStudio e selecione "R project".

## Estrutura {.build}

Essa é a estrutura mínima para criar um pacote.

- Tudo dentro de uma pasta
- `DESCRIPTION`: Metadados do pacote.
- `NAMESPACE`: ...
- `R/`
- `man/`
- `xxx.Rproj`

## Tipos / estados dos pacotes

- Source (código fonte)
- Bundled (`.tar.gz`)
- Binary (binário, compactado)
- Installed (binário, descompactado numa pasta)
- In memory (depois de dar `library()` ou `require()`)

<!-- ___________________________________________________________________________________________ -->

## Código R {.build}

- Todo o código em `R` fica aqui
- Tudo é baseado em funções. Crie objetos, principalmente funções, e não use coisas como `View()`
- Melhor _workflow_: Editar R -> Ctrl+Shift+L -> Teste no console -> Editar R -> ...
- Organizando funções: dividir arquivos por temas, e manter um padrão de títulos e conteúdos
- Não use `library()`, `require()` nem `source()`, `setwd()`, etc. Ao invés disso, coloque dependências na documentação.

<!-- ___________________________________________________________________________________________ -->

## Documentação

### Arquivo `DESCRIPTION`

- Definir `Imports`, `Suggests`, e usar o `::`.
- `devtools::use_package()`
- Versões `(>= 0.3)`, `devtools::numeric_version()`
- `Depends` (versões de R).
- `Authors@R`
- [Licensas](https://choosealicense.com)

## Documentação

### Documentação dos objetos

- Ensina o usuário a usar o pacote
- Facilmente construído, colocando headers nas funções do R e usando `devtools::document()`
- Começar com `#'`
- _workflow_: Adicionar documentação em `roxygen` -> chamar `devtools::document()` -> visualizar documentação com `?` -> Adicionar documentação em `roxygen` -> ...
- Tags com `@tag` (ex: `@param`).
- Primeira sentença é o título. Segundo parágrafo é uma descrição. Os outos parágrafos vão para _Details_.

<!-- ___________________________________________________________________________________________ -->

## Vignettes

- Útil para dar uma explicação geral de um pacote
- Facilmente construído usando RMarkdown
- Geralmente usado para pacotes mais complexos

<!-- ___________________________________________________________________________________________ -->

## Testes

- Pacote `testthat`, do Hadley.
- `devtools::use_testthat()`
- Defina o que você quer testar (função e parâmetros), e o que você espera de resultado
- _workflow_: mude códigos -> `devtools::test()` -> repita. 


```r
library(stringr)
context("String Length")
test_that("str_length is a number of characters", {
  expect_equal(str_length('a'), 1)
  expect_equal(str_length('ab'), 2)
  expect_equal(str_length('abc'), 3)
})
```

<!-- ___________________________________________________________________________________________ -->

## Namespace

<!-- ___________________________________________________________________________________________ -->

## Dados externos

<!-- ___________________________________________________________________________________________ -->

## Código compulado (C, C++, etc)

<!-- ___________________________________________________________________________________________ -->

## Melhores práticas

<!-- ___________________________________________________________________________________________ -->

## Git e GitHub

## Checagem automática

## CRAN vs GitHub

<!-- ___________________________________________________________________________________________ -->

# Tópico extra: web crawling

## Filosofia

<!-- ___________________________________________________________________________________________ -->

## Pré-requisitos

## Requisições GET e POST

## Cookies, viewstate, etc.

## Exemplo: Sabesp
