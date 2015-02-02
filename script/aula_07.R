library(lme4)
library(FactoMineR)
library(ggplot2)
library(tidyr)
library(MASS)
library(tree)
library(dplyr)

###########################################################################################################
# Regressão Linear e ANOVA -------------------------------------------------------------------------------#
# os dados
head(mtcars)

# banco de dados das variáveis contínuas no formato "longo"
mtcars_long <- mtcars %>%
  select(mpg, disp:qsec) %>%
  gather(var_continuas)

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

# boxplots
mtcars_long %>%
  ggplot() +
  geom_boxplot(aes(x=1, y = value)) +
  facet_wrap(~var_continuas, scales = "free")

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

mtcars_freq

# Gráfico de barras
mtcars_freq %>%
  ggplot() +
  geom_bar(aes(x=categoria, y = freq), position = "dodge", stat = "identity") +
  facet_wrap(~vars_categoricas, scales="free")

# Matriz de correlação linear
mtcars %>%
  select(mpg, disp:qsec) %>%
  cor %>%
  round(2)

# Matriz de dispersão
pairs(mtcars %>%
        select(mpg, disp:qsec))


# AJUSTE DO MODELO
ajuste_lm <- lm(mpg ~ wt, data = mtcars)

ajuste_lm

# extrai os coeficientes ajustados
coeficientes <- coef(ajuste_lm)

ggplot(mtcars) +
  geom_point(aes(x = wt, y = mpg)) +
  geom_abline(intercept = coeficientes[1], slope = coeficientes[2])

# Sumário
summary(ajuste_lm)

# gráficos de diagnóstico do modelo ajuste_lm
plot(ajuste_lm)

# ANOVA() ----------------------------------------------#
# modelo nulo, com apenas o intercepto
ajuste_lm_nulo <- lm(mpg ~ 1, data = mtcars)

# modelo com wt e cyl
ajuste_lm2 <- lm(mpg ~ wt + factor(cyl), data = mtcars)

# compara o modelo com wt com o modelo nulo
anova(ajuste_lm_nulo, ajuste_lm)

# Tabela de ANOVA, testa os termos sequencialmente
anova(ajuste_lm2)
#------------------------------------------------------#

# teste de hipótese linear
library(car)

# (http://sfb649.wiwi.hu-berlin.de/fedc_homepage/xplore/tutorials/xegbohtmlnode17.html)
# manual --------#

n <- nrow(mtcars) # tamanho da amostra
coefs <- coef(ajuste_lm2) # estimativas dos parâmetros
p <- coefs %>% length # número de parâmetros ajustados
X <- model.matrix(ajuste_lm2) # matriz de planejamento
s <- sqrt(sum((mtcars$mpg - fitted(ajuste_lm2))^2)/(n - p)) # variância estimada; s <- summary(ajuste_lm2)$sigma

covs <- s^2 * solve(t(X) %*% X) # matriz de covariância dos parâmetros; covs <- vcov(ajuste_lm2)

# Combinação linear (contraste) que representa a hipótese de interesse
# no caso, a hipótese é de que os parâmetros factor(cyl)6 = factor(cyl)8.
c <- as.matrix(c(0, 0, 1, -1))
cB <- t(c)%*%as.matrix(coefs)

# estatística F
estatistica <- (t(cB)) %*% solve((t(c) %*% covs %*% c)) %*% (cB)

# valor-p
(1 - pf(estatistica, ncol(c), n - p)) %>% round(3)

# utlizando o linearHypothesis --------#
linearHypothesis(ajuste_lm2, c(0,0,1,-1))


# ajustando os dois modelos separadamente --------#
ajuste_lm3 <- lm(mpg ~ wt + I(factor(cyl %in% c(6, 8))), data = mtcars)

# o mesmo teste
anova(ajuste_lm2, ajuste_lm3)


###########################################################################################################
# Regressão Linear Generalizada --------------------------------------------------------------------------#

# Modelo GAMA --------#
mtcars_filtro <- mtcars %>% filter(wt < 5)

ggplot(mtcars_filtro, aes(x = wt, y = disp)) +
  geom_point() +
  stat_smooth(method = "glm", se = FALSE, family = Gamma) +
  stat_smooth(method = "glm", se = FALSE, family = gaussian(link = "inverse"))


ajuste_glm <- glm(disp ~ wt, data = mtcars_filtro, family = Gamma)
ajuste_glm2 <- glm(disp ~ wt, data = mtcars_filtro, family = gaussian)

summary(ajuste_glm)
summary(ajuste_glm2)

plot(ajuste_glm)
plot(ajuste_glm2)

# regressão logística ---------------------------------------------------------------------#

# breve descritiva
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

ggplot(mtcars) +
  geom_boxplot(aes(x = factor(am), y = wt))

# Ligação logit
ajuste_glm <- glm(am ~ wt, data = mtcars, family = binomial)
summary(ajuste_glm)
table(mtcars$am, predict(ajuste_glm) > 0.5)

# Ligaçao probit
ajuste_glm_probit <- glm(am ~ wt, data = mtcars, family = binomial(link = "probit"))
summary(ajuste_glm_probit)

# Gráfico das curvas ajustadas + cloglog
ggplot(mtcars, aes(x=wt, y=am)) +
  geom_point() +
  stat_smooth(aes(colour = "Logit"), method="glm", family=binomial, se=FALSE) +
  stat_smooth(aes(colour = "Probit"), method="glm", family=binomial(link = "probit"), se=FALSE) +
  stat_smooth(aes(colour = "Complementar Log-Log"), method="glm", family=binomial(link = "cloglog"), se=FALSE) +
  labs(colour = "Função de ligação")

# qualidade do ajuste
anova(ajuste_glm, test="Chisq")

###########################################################################################################
# Árvore de decisão --------------------------------------------------------------------------------------#

library(tree)
ajuste_tree <- tree(factor(am) ~ wt, data = mtcars)
summary(ajuste_tree)
plot(ajuste_tree)
text(ajuste_tree, pretty = 0)


# Logistico
table(mtcars$am, predict(ajuste_glm) > 0.5)

# Árvore
table(mtcars$am, predict(ajuste_tree)[,"1"] > 0.5)


# tamanho da árvore

set.seed(123)
cv_tree <- cv.tree(ajuste_tree)
plot(cv_tree)


# seleciona a árvore com 2 nós
melhor_tree <- prune.tree(ajuste_tree, best = 2)
# Gráfico que representa a árvore `melhor_tree`
plot(melhor_tree)
text(melhor_tree, pretty = 0)
# oservado versus predito
table(mtcars$am, predict(melhor_tree)[,"1"] > 0.5)

###########################################################################################################
# Modelo misto -------------------------------------------------------------------------------------------#

modelo <- lmer(extra ~ group + 1|ID, data=sleep)
summary(modelo)



###########################################################################################################
# Cluster ------------------------------------------------------------------------------------------------#

## Kmeans
kms <- kmeans(mtcars, centers=2)
kms

## Hierárquico
d <- dist(mtcars) # calcula matriz de distâncias euclidianas.
str(d)
hc <- hclust(d, method='ward.D')
hc
plot(hc)

###########################################################################################################
# Fatorial -----------------------------------------------------------------------------------------------#

fa <- factanal(mtcars, factors=3, rotation='varimax')

pesos <- fa$loadings[,1:3] %>% data.frame %>% mutate(nomes=rownames(.))
ggplot(pesos, aes(x=Factor1, y=Factor2)) +
  geom_text(aes(label=nomes)) +
  geom_vline(xintercept=0) +
  geom_hline(yintercept=0) +
  coord_equal()

###########################################################################################################
# Correspondência múltipla -------------------------------------------------------------------------------#

data(tea)

# Vamos trabalhar só com essas colunas
newtea <- tea %>% select(Tea, How, how, sugar, where, always) %>% tbl_df
newtea

# numero de niveis de cada variavel
cats <- newtea %>% summarise_each(funs(length(unique(.))))
cats

# MCA
mca1 <- MCA(newtea, graph = FALSE)
# list of results
str(mca1)

# Coordenadas das variaveis
mca1_vars_df <- data.frame(mca1$var$coord, Variable = rep(names(cats), cats))

# Coordenadas das observacoes
mca1_obs_df <- data.frame(mca1$ind$coord)

# Grafico bonito
ggplot() +
  geom_hline(yintercept = 0, colour = "gray70") +
  geom_vline(xintercept = 0, colour = "gray70") +
  geom_text(aes(x=Dim.1, y=Dim.2, colour=variavel, label=rnames), data=mca1_vars_df) +
  geom_point(aes(x=Dim.1, y=Dim.2), colour = "gray50", alpha = 0.7, data=mca1_obs_df) +
  geom_density2d(aes(x=Dim.1, y=Dim.2), colour = "gray80", data=mca1_obs_df)

###########################################################################################################

