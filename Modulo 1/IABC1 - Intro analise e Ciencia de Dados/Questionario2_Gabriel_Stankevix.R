library(tidyverse)
library(dplyr)
library(ggplot2)
require(scales)


# 1. Faça uma função que calcule e mostre na tela o e da fórmula de Bhaskara.
#Exiba a mensagem: “Um dos coeficientes é inexistente” se algum coeficiente é NA .
# Dica: reutilize o código da Seção 2.3.1 e defina uma função que recebe como parâmetro os coeficientes .

bhaskara <- function(a, b, c){
  
  if(is.na(a)| is.na(b) | is.na(c)){
    print("Um dos coeficientes é inexistente")
  }else{
    delta <- b ^ 2 - 4 * a * c
    if(delta > 0) {
      x1 <- (-b - sqrt(delta)) / (2 * a)
      x2 <- (-b + sqrt(delta)) / (2 * a)
      
      print(paste0("O valor de x1 é ", x1, " e o valor de x2 é ", x2))
    } else {
      print(paste0("Delta retornou um valor negativo: ", delta))
    }
  }
}

a <- 8
b <- 2
c <- 4

bhaskara(a, b, c)
bhaskara(NA, b, c)
bhaskara(a, NA, c)
bhaskara(a, b, NA)
bhaskara(4, 6, 1)




#2. Considerando o arquivo .csv usado nessa aula, faça as seguintes manipulações para gerar novos
#dados tabulares:

circulacao_dinheiro <- read_csv2("C:/Users/CS318041/Documents/Espec. Ciencia de Dados/Materias/Modulo 1/IABC1 - Intro analise e Ciencia de Dados/MeioCirculante_DadosAbertos.csv",
                                 col_names = c("Data","Familia","Denominacao","Quantidade"))

circulacao_dinheiro
circulacao_dinheiro$Denominacao <- as.numeric(circulacao_dinheiro$Denominacao)

#a. Todas as moedas de 1 real em circulação no ano de 2019

moeda_1_2019 <- filter(circulacao_dinheiro,
                       as.numeric(format(Data,"%Y"))==2019 &
                        Denominacao == 1.00 &
                         str_detect(Familia,"Moedas"))

moeda_1_2019

#b. Todas as moedas comemorativas em circulação no ano de 2020
moedas_comem_2020 <-filter(circulacao_dinheiro,
                           as.numeric(format(Data,"%Y"))==2020 &
                           str_detect(Familia, "Moedas comemorativas"))
moedas_comem_2020

#c. Todas as cédulas de 2 reais em circulação no mês de Fevereiro de 2019
cedulas_2_2019 <- filter(circulacao_dinheiro,
                         Data >= '2020/02/01' & Data <= '2020/02/28' &
                         Denominacao == 2.00 &
                         str_detect(Familia,"Cédulas")) 

cedulas_2_2019

#3. Proponha gráficos de linhas e de barras para os conjuntos de dados gerados no exercício anterior.
#O que seus gráficos indicam? descreva-os. Dica: exporte os gráficos gerados por meio RStudio (no                                                                                             painel inferior direito, em plots e depois Export) após executar o comando de geração de 1 gráfico
#apenas (do mesmo modo usado para mostrar o conteúdo de uma variável)

circulacao_dinheiro_detalhado <- mutate(circulacao_dinheiro,
                                        Dia = as.numeric(format(Data, "%d")),
                                        Mes = as.numeric(format(Data, "%m")),
                                        Ano = as.numeric(format(Data, "%Y")))
circulacao_dinheiro_detalhado

#A - Grafico de Barras moeda_1_2019 -> Quantidade de Moedas comemorativas Ayrton Senna

moeda_1_2019_detalhado <- mutate(moeda_1_2019,
                              Dia = as.numeric(format(Data, "%d")),
                              Mes = as.numeric(format(Data, "%m")),
                              Ano = as.numeric(format(Data, "%Y")))

moeda_1_2019_detalhado <- mutate(moeda_1_2019_detalhado,
                                        ValorCirculado = Quantidade * Denominacao,
                                        ValorCirculadoDolar = ValorCirculado* 0.179)

por_mes_familia <- group_by(moeda_1_2019_detalhado, Mes, Familia)


moeda_1_media_quantidade <- summarise(por_mes_familia,
                              media = mean(Quantidade, na.rm = TRUE),
                              maximo = max(Quantidade, na.rm = TRUE),
                              minimo = min(Quantidade, na.rm = TRUE))

Esportes <- filter(moeda_1_2019_detalhado,str_detect(Familia,c("Boxe","Futebol","Basquete")))

df <- arrange(Esportes,Mes, Familia)
df

grafico_moedas_barra <- ggplot(data = Esportes) +
  geom_bar(stat = "identity",
           position = position_dodge(),
           mapping = aes(x=as.factor(Mes), y = Quantidade, fill=Familia))+
  scale_y_continuous(trans = 'log2')+
  labs(x = "Familia", y = "Quantidade") +
  theme(axis.title = element_text(size=10), plot.title = element_text(size=12, face="bold")) +
  ggtitle("Quantidade por mês moedas de Esporte - 2019")

grafico_moedas_barra




#B

moedas_comem_2020_detalhado <- mutate(moedas_comem_2020,
                            Dia = as.numeric(format(Data, "%d")),
                            Mes = as.numeric(format(Data, "%m")),
                            Ano = as.numeric(format(Data, "%Y")))


moedas_comem_2020_detalhado <- mutate(moedas_comem_2020_detalhado,
                                 ValorCirculado = Quantidade * Denominacao,
                                 ValorCirculadoDolar = ValorCirculado* 0.179)

Personalidades <- filter(moedas_comem_2020_detalhado,str_detect(Familia,c("Ary Barroso","Ayrton Senna")))
 


grafico_personalidades_barra <- ggplot(data = Personalidades) +
  geom_bar(stat = "identity",
           position = position_dodge(),
    mapping = aes(x = as.factor(Mes), y = Quantidade, fill = Familia)) +
  scale_y_continuous(n.breaks = 8) +
  labs(x = "Mes", y = "Quantidade em circulação") +
  theme(axis.title = element_text(size=10), plot.title = element_text(size=12, face="bold")) +
  ggtitle("Qtd de moedas durante 2020")

grafico_personalidades_barra

#C

cedulas_2_2019
cedulas_2_2019_detalhado <- mutate(cedulas_2_2019,
                                      Dia = as.numeric(format(Data, "%d")),
                                      Mes = as.numeric(format(Data, "%m")),
                                      Ano = as.numeric(format(Data, "%Y")))

grafico_cedulas_linha <- ggplot(data = cedulas_2_2019_detalhado) +
  geom_line(mapping = aes(x = as.factor(Dia), 
                          y = Quantidade, 
                          group = Familia, 
                          colour = Familia)) +
  scale_y_continuous(trans = 'log2')+
  labs(x = "Ano", y = "Quantidade em Circulação") +
  theme(axis.title = element_text(size=10), plot.title = element_text(size=12, face="bold")) +
  ggtitle("Quantidade de cedulas de 2 reais em fevereiro 2020")
  
grafico_cedulas_linha



