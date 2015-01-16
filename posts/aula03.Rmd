---
title: Aula 03 - Laboratório I
date : 2015-01-23
--- 

## Relatórios dinâmicos com RMarkdown

- Utilização da linguagem de marcação _markdown_.
- Possibilidade de incluir código R nos arquivos.
- Roda com o pacote `knitr` e o programa `pandoc`.
- Possibilidade de criar relatórios em html, docx, pdf, latex, entre outros.
- Possibilidade de criar apresentações e relatórios com gráficos dinãmicos.
- Possibilidade de inserir sintaxe matemática, como $e^{i\pi}=-1$, nos documentos.
- Documentos interativos com o `shiny`.

---

### Como utilizar

- Mais fácil com RStudio
- Conceitos básicos de Markdown [nesse link](http://daringfireball.net/projects/markdown/).
- RMarkdown com exemplos [nesse link](http://rmarkdown.rstudio.com/).
- Sobre YAML.

#### Exemplo: código que gerou estas aulas.

---

### Gráficos dinâmicos

- Somente para output em HTML.
- É possível criar gráficos baseados em javascript e gerar documentos que funcionam "sozinhos".
- Se exigir interação, o shiny é utilizado, e o documento precisa ficar em um servidor.
- É possível utilizar o shiny server e o serviço shinyapps.io para publicar documentos interativos.

#### Exemplo: Apresentação no ioslides

## Exercício

A base de dados pnud.xlsx foi construida pelo Programa das Nações Unidas para o Desenvolvimento e contém informações demográficas e socioeconômicas de cada município brasileiro nos anos de 1991, 2000 e 2010.
Essas informações são baseadas nos censos e são utilizadas para o cálculo do IDH.

Queremos que vocês descubram:

- Qual é o município com o maior IDH em 2010.
- Qual é a unidade federativa com menor expectativa de vida média ponderada pela população dos municípios em 2000.
- Encontre quais são os municípios _outliers_ com relação ao índice de Gini em 1991 e em 2010.

Visualize como está distribuida a população dos municípios no Brasil. Quantos municípios concentram 25% da população?

Categorize a renda per capita e associe com a expectativa de vida.

Você acha que o Brasil está melhorando? Justifique utlizando dados de pelo menos 3 variáveis.

No nordeste o aummento de distribuição de renda foi maior do que no sudeste?

Insira mais pelo menos 3 estudos que você ache interessante.
