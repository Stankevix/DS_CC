library(tidyverse)

setwd('C:/Users/CS318041/Documents/Espec. Ciencia de Dados/Materias/Modulo 1/IABC1 - Intro analise e Ciencia de Dados/Prova')

suicidio <- read_csv2("datasets_222060_477759_dados_ipea.csv")

View(suicidio)

names(suicidio)[3] <- "periodo"

suicidio2 <- filter(suicidio, periodo == 2010 | periodo == 1998) %>%
  select(nome, periodo, valor) %>% 
  group_by(periodo) %>% 
  summarise(mediana = median(valor))


View(suicidio2)

ggplot(data = suicidio2) +
  geom_col(aes(x = as.factor(periodo), y = mediana),
           position = position_dodge(), linetype = "solid", colour = "black") +
  labs(x = "Ano", y = "Mediana", title = "Mediana de Suicidio 1998 e 2010")





suicidio3 <- filter(suicidio, nome %in% c('PR', 'RS', 'SC')) %>% select(nome, periodo, valor)

View(suicidio3)

ggplot(data = suicidio3) + 
  geom_line(aes(x=nome, y=valor, group= periodo,colour=nome))+
  facet_wrap(vars(periodo)) +
  labs(x = "UF", y = "Valor", title = "Suicidios nos Estados PR, RS e SC")



suicidio_brasil <- suicidio %>%
                    select(nome, periodo, valor) %>% 
                      group_by(periodo) %>% 
                          summarise(qtd_min= min(valor))


View(suicidio)
  

  
  
ggplot(data=suicidio) + 
  geom_histogram(aes(valor, bins=30,colour=nome),position = position_dodge())+
    labs(x = "Qtd", y = "Contagem", title = "Histogram - Suicidios Estados BR")




suicidio_norte  <- filter(suicidio, nome %in% c('MA', 'PI', 'CE', 'RN', 'PE', 'PB', 'SE', 'AL', 'BA') & periodo == 2014)

View(suicidio_norte)


ggplot(data = suicidio_norte) +
  geom_col(aes(x = nome, y = valor, fill = nome),
           position = position_dodge(), linetype = "solid", colour = "black") +
  labs(x = "UF", y = "valor", title = "Valor Suidicio nos Estados do Norte")

