# Especialiazacao em Ciencia de Dados - UFTPR
# Introducao Ciencia de Dados - IACC
# Professor
# Prof. Dr. Francisco C. Souza (franciscosouza@utfpr.edu.br)
# Prof. Dr. Anderson C. Carniel (accarniel@utfpr.edu.br)
# Tutor: Dr. Rodolfo A. Silva (rodolfoa@utfpr.edu.br)
# Aluno : Gabriel Stankevix Soares


# Resolva a seguinte lista de exercícios e submeta suas respostas no Moodle, conforme orientado na página
# da disciplina (em suma, existe uma questão no questionário aberto para você mandar as respostas desses exercícios como um arquivo .pdf).

# 1. Qual é a diferença entre os tipos de dados integer e double? 
#Dica: utilize o código abaixo para justificar sua resposta:

(a <- sqrt(2) ^ 2)
## [1] 2 < - integer
a - 2
## [1] 4.440892e-16 <- double
-1 / 0 
## [1] -Inf
0 / 0
## [1] NaN
1 / 0
## [1] Inf



# 2. Escreva um programa em R que processe a seguinte fórmula matemática abaixo 
#(declare as variáveis necessárias e valores para ela):

x1 = 2
x2 = 4
y1 = 3
y2 = 9

d = sqrt( ((x2-x1)^2)+((y2-y1)^2) )
d

# 3. Complete o código R abaixo, trocando os ?? , para calcular: 
#   (i) a soma dos valores do vetor x , 
#   (ii) a média de valores do vetor x , 
#   (iii) o desvio padrão dos valores do vetor x , e 
#   (iv) valores máximos e mínimos do vetor x .


x <- seq(1, 1000) #pesquise o que essa nova função faz
soma <- sum(x) # 500500
media <- mean(x) #500.5
desvio_padrao <- sd(x) #288.8194
maximo <- max(x) #1000
minimo <- min(x) # 1



#4. Qual é a ordem de execução dos operadores da expressão abaixo? E o seu resultado?
4 + 2 - 1 / 10 ^ 3
# R: A ordem é primeiro expoente,divisao, soma e subtração. 
# 10^3 -> 1000 
# 1/1000 - > 0.001
# 4 + 2 - > 6
# 6 - 0.001 -> 5.999 <-
# O Resultado é final 5.999















