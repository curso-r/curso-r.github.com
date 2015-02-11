# Aula 10 - Pacotes e +
Curso de R: Do casual ao avançado  
2015-02-11  

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

## Estrutura

- 
- 

## Exemplo

<!-- ___________________________________________________________________________________________ -->

## Código R

<!-- ___________________________________________________________________________________________ -->

## Documentação

<!-- ___________________________________________________________________________________________ -->

## Vignettes

<!-- ___________________________________________________________________________________________ -->

## Testes

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



