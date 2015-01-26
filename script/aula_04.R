require(dplyr)
require(tidyr)

data(pnud_muni, package = 'abjutils')
data(pnud_uf, package = 'abjutils')
data(pnud_siglas, package = 'abjutils')

# TBL_DF____________________________________________________________________________________________

pnud_muni

pnud_muni <- tbl_df(pnud_muni)

pnud_muni

# SELECT____________________________________________________________________________________________

# por indice (nao recomendavel!)
pnud_muni %>%
  select(1:10)

pnud_muni %>%
  select(ano, ufn, municipio, idhm)
# intervalos e funcoes auxiliares (para economizar trabalho)

pnud_muni %>%
  select(ano:municipio, ufn, starts_with('idhm'))

# FILTER____________________________________________________________________________________________

# somente estado de SP, com IDH municipal maior que 80% no ano 2010
pnud_muni %>%
  select(ano, ufn, municipio, idhm) %>%
  filter(uf==35, idhm > .8, ano==2010)

# mesma coisa que o anterior
pnud_muni %>%
  select(ano, ufn, municipio, idhm) %>%
  filter(uf==35 & idhm > .8 & ano == 2010)

# !is.na(x)
pnud_muni %>%
  select(ano, ufn, municipio, idhm, pea) %>%
  filter(!is.na(pea))

# %in%
pnud_muni %>%
  select(ano, ufn, municipio, idhm) %>%
  filter(municipio %in% c('CAMPINAS', 'SÃO PAULO'))

# MUTATE____________________________________________________________________________________________

pnud_muni %>%
  select(ano, ufn, municipio, idhm) %>%
  filter(ano==2010) %>%
  mutate(idhm_porc = idhm * 100,
         idhm_porc_txt = paste(idhm_porc, '%'))

# media de idhm_l e idhm_e
pnud_muni %>%
  select(ano, ufn, municipio, starts_with('idhm')) %>%
  filter(ano==2010) %>%
  mutate(idhm2 = (idhm_e + idhm_l)/2)

## errado
pnud_muni %>%
  select(ano, ufn, municipio, starts_with('idhm')) %>%
  filter(ano==2010) %>%
  mutate(idhm2 = mean(c(idhm_e, idhm_l)))

## uma alternativa (+ demorada)
pnud_muni %>%
  select(ano, ufn, municipio, starts_with('idhm')) %>%
  filter(ano == 2010) %>%
  rowwise() %>%
  mutate(idhm2 = mean(c(idhm_e, idhm_l)))

# ARRANGE___________________________________________________________________________________________

pnud_muni %>%
  select(ano, ufn, municipio, idhm) %>%
  filter(ano==2010) %>%
  mutate(idhm_porc = idhm * 100,
         idhm_porc_txt = paste(idhm_porc, '%')) %>%
  arrange(idhm)

pnud_muni %>%
  select(ano, ufn, municipio, idhm) %>%
  filter(ano==2010) %>%
  mutate(idhm_porc = idhm * 100,
         idhm_porc_txt = paste(idhm_porc, '%')) %>%
  arrange(desc(idhm))

# SUMMARISE_________________________________________________________________________________________

pnud_muni %>%
  filter(ano==2010) %>%
  group_by(uf) %>%
  summarise(n=n(),
            idhm_medio=mean(idhm),
            populacao_total=sum(popt)) %>%
  arrange(desc(idhm_medio))

pnud_muni %>%
  filter(ano==2010) %>%
  count(uf)

pnud_muni %>%
  group_by(ano, uf) %>%
  tally() %>%
  head # nao precisa de parenteses!

# SPREAD____________________________________________________________________________________________

pnud_muni %>%
  group_by(ano, uf) %>%
  summarise(populacao=sum(popt)) %>%
  ungroup() %>%
  spread(ano, populacao)

# GATHER____________________________________________________________________________________________

pnud_muni %>%
  filter(ano==2010) %>%
  select(ufn, municipio, starts_with('idhm_')) %>%
  gather(tipo_idh, idh, starts_with('idhm_'))

# UNITE_____________________________________________________________________________________________

pnud_muni %>%
  select(municipio, ufn, ano) %>%
  unite(municipio_uf, municipio, ufn, sep='_')

# SEPARATE__________________________________________________________________________________________

pnud_muni %>%
  select(municipio, ufn, ano, starts_with('idhm')) %>%
  filter(ano==2010) %>%
  gather(tipo_idh, idh, starts_with('idhm')) %>%
  separate(tipo_idh, c('nada', 'tipo_idh'), sep='_') %>%
  select(-nada)

# JOIN______________________________________________________________________________________________

pnud_muni %>%
  distinct(ufn, ano) %>%
  select(ufn, ano, municipio, starts_with('idhm')) %>%
  inner_join(pnud_estado, c('ufn', 'ano')) %>%
  select(ufn, ano, municipio, starts_with('idhm'))

# STR_DETECT________________________________________________________________________________________

pnud_muni %>%
  filter(ano==2010, str_detect(municipio, 'SÃO P')) %>%
  select(municipio, ano, ufn, idhm)

# DMY/YMD/MDY_______________________________________________________________________________________

temp <- pnud_muni %>%
  select(ufn, municipio, idhm, ano) %>%
  mutate(aux1='01', aux2='01') %>%
  unite(ano_date, ano, aux1, aux2, sep='-') %>%
  select(-aux1, -aux2) %>%
  mutate(ano_date=ymd(ano_date))

str(temp)
rm(temp)
