library(survival)
library(ggplot2)

## SURVIVAL

fit <- survfit(Surv(futime, fustat) ~ rx, data = ovarian)

plot(fit)
m <- length(fit$strata)

df <- data.frame(time = c(rep(0, m), fit$time),
                 surv = c(rep(1, m), fit$surv),
                 group = c(names(fit$strata),
                           rep(names(fit$strata), fit$strata)))

ggplot(data = df) +
  geom_step(aes(x = time, y = surv, colour = as.factor(group))) +
  ylim(0, 1) +
  labs(colour = "Curvas", y = "Proporção de sobreviventes",
       x = "Tempo")

survdiff(Surv(futime, fustat) ~ rx, data = ovarian)
fit <- survreg(Surv(futime, fustat) ~ rx + age, data = ovarian,
               dist = "exponential")

summary(fit)
fit <- coxph(Surv(futime, fustat) ~ age + rx, data = ovarian)
summary(fit)

## Generalized Additive Model (GAM)

data(pnud_muni, package='abjutils')

library(mgcv)
fit_model <- gam(espvida ~ ano + s(rdpc) + s(i_escolaridade), data=pnud_muni, family=Gamma)

summary(fit_model)

par(mfrow=c(1, 2))
plot(fit_model, scheme=1)

### Pacote gamlss

library(gamlss)

# Cuidado! O pacote gamlss carrega MASS, que por sua vez mascara a função select do dplyr.

dados <- pnud_muni %>%
  dplyr::select(rdpc, i_escolaridade, espvida, ano) %>%
  na.omit %>%
  mutate(ano=factor(ano))

fit_model <- gamlss(formula=espvida ~ cs(rdpc) + cs(i_escolaridade),
                    sigma.formula = ~ ano,
                    data=dados,
                    family=NET())
summary(fit_model)
plot(fit_model)

## Modelos Bayesianos

vignette('Examples', package = 'LaplacesDemon')
N <- 29

y <- c(1.12, 1.12, 0.99, 1.03, 0.92, 0.90, 0.81, 0.83, 0.65, 0.67, 0.60,
       0.59, 0.51, 0.44, 0.43, 0.43, 0.33, 0.30, 0.25, 0.24, 0.13, -0.01,
       -0.13, -0.14, -0.30, -0.33, -0.46, -0.43, -0.65)

x <- c(-1.39, -1.39, -1.08, -1.08, -0.94, -0.80, -0.63, -0.63, -0.25, -0.25,
       -0.12, -0.12, 0.01, 0.11, 0.11, 0.11, 0.25, 0.25, 0.34, 0.34, 0.44,
       0.59, 0.70, 0.70, 0.85, 0.85, 0.99, 0.99, 1.19)

data_frame(x, y) %>% ggplot() + geom_point(aes(x=x, y=y))

#### Dados

mon.names <- "LP" # variáveis para monitoramento. No caso, Log Posterior
parm.names <- as.parm.names(list(alpha=0, beta=rep(0,2), sigma=0, theta=0)) # nomes dos parâmetros

pos.alpha <- grep("alpha", parm.names) # posição do parâmetro alpha
pos.beta <- grep("beta", parm.names)   # posição dos parâmetros beta
pos.sigma <- grep("sigma", parm.names) # posição do parâmetro sigma
pos.theta <- grep("theta", parm.names) # posição do parâmetro theta

# Função que gera valores iniciais para os parâmetros. No caso, sem muito critério.
PGF <- function(Data) return(c(rnorm(1), rnorm(2), runif(1), runif(1)))

MyData <- list(N=N,
               PGF=PGF,
               mon.names=mon.names,
               parm.names=parm.names,
               pos.alpha=pos.alpha,
               pos.beta=pos.beta,
               pos.sigma=pos.sigma,
               pos.theta=pos.theta,
               x=x,
               y=y)

#### Modelo

Model <- function(parm, Data) {

  ### Parameters
  alpha <- parm[Data$pos.alpha]
  beta <- parm[Data$pos.beta]
  sigma <- interval(parm[Data$pos.sigma], 1e-100, Inf)
  parm[Data$pos.sigma] <- sigma # atualiza o valor para retornar depois
  theta <- interval(parm[Data$pos.theta], -1.3, 1.1)
  parm[Data$pos.theta] <- theta # atualiza o valor para retornar depois

  ### Log-Prior (calcula com base nas funções das prioris predefinidas)
  alpha.prior <- dnormv(alpha, 0, 1000, log=TRUE)
  beta.prior <- sum(dnormv(beta, 0, 1000, log=TRUE))
  sigma.prior <- dhalfcauchy(sigma, 25, log=TRUE)
  theta.prior <- dunif(theta, -1.3, 1.1, log=TRUE)

  ### Log-Likelihood (calcula a log-verossimilhança com base no modelo concebido)
  mu <- alpha + beta[1]*x + beta[2]*(x - theta)*((x - theta) > 0)
  LL <- sum(dnorm(Data$y, mu, sigma, log=TRUE))

  ### Log-Posterior (calcula a log posteriori)
  LP <- LL + alpha.prior + beta.prior + sigma.prior + theta.prior

  Modelout <- list(LP=LP,
                   Dev=-2*LL,
                   Monitor=LP,
                   yhat=rnorm(length(mu), mu, sigma),
                   parm=parm)

  return(Modelout)
}

#### Atualização ("ajuste")

set.seed(666) # reprodutibilidade

Initial.Values <- c(0.5, -0.4, -0.6, 0.02, 0.04) # valores iniciais da cadeia

Fit <- LaplacesDemon(Model, MyData, Initial.Values,
                     Iterations = 1000000,
                     Status = 100000,
                     Thinning = 1000,
                     Algorithm="HARM")
print(Fit)
Consort(Fit)

#### Plotando resultado

plot(Fit, BurnIn=100000, MyData, PDF=FALSE, Parms=NULL)
caterpillar.plot(Fit, Parms=c("beta", 'theta'))
Pred <- predict(Fit, Model, MyData)
plot(Pred, Style="Fitted")

m <- Fit$Posterior2 %>% data.frame %>% summarise_each(funs(median))

data_frame(x, y) %>%
  ggplot() +
  geom_point(aes(x=x, y=y)) +
  geom_segment(x=-1.5, xend=m$theta, y=m$alpha + m$beta.1. * (-1.5),
               yend=m$alpha + m$beta.1. * (m$theta)) +
  geom_segment(x=m$theta, xend=1.2, y=m$alpha + m$beta.1. * (m$theta),
               yend=m$alpha + m$beta.1. * (1.2) + m$beta.2.*(1.2-m$theta)) +
  geom_point(aes(x=theta, y=alpha + beta.1. * theta),
             data=data.frame(Fit$Posterior2), alpha=.05,
             colour='red')

data_frame(x, y) %>%
  ggplot() +
  geom_point(aes(x=x, y=y)) +
  geom_segment(x=-1.5, xend=m$theta, y=m$alpha + m$beta.1. * (-1.5),
               yend=m$alpha + m$beta.1. * (m$theta)) +
  geom_segment(x=m$theta, xend=1.2, y=m$alpha + m$beta.1. * (m$theta),
               yend=m$alpha + m$beta.1. * (1.2) + m$beta.2.*(1.2-m$theta)) +
  geom_density2d(aes(x=theta, y=alpha + beta.1. * theta),
                 data=data.frame(Fit$Posterior2),
                 colour='red') +
  scale_x_continuous(limits=c(-.25,.25)) +
  scale_y_continuous(limits=c(.25,.75))


## Sobre redes neurais

library(neuralnet)

trainningdata <- data_frame(Input=runif(50, min=0, max=100), Output=sqrt(Input))

# Train the neural network
# Going to have 10 hidden layers
# Threshold is a numeric value specifying the threshold for the partial
# derivatives of the error function as stopping criteria.

net.sqrt <- neuralnet(Output ~ Input, data = trainingdata, hidden=10, threshold=0.01)
print(net.sqrt)
plot(net.sqrt)

testdata <- data.frame(test=(1:10)^2)
net.results <- compute(net.sqrt, testdata)

cleanoutput <- data_frame(value=testdata$test,
                          real_resp=sqrt(value),
                          estimate=as.vector(net.results$net.result))
print(cleanoutput)
