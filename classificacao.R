# Introdução à Ciência de Dados - Fernando Amaral
# Vizinho mais próximo - K nearest neighboors
# funciona apenas com atrubutos númericos
# a classe deve ser nominal

library(class)
amostra = sample(2, 150, replace = T, prob = c(0.7 , 0.3))
amostra
iristreino = iris[amostra==1,]
iristreino
classificar = iris[amostra==2,]
classificar
# passando o iristreino todas as linhas as quatro colunas
# passando o classificar todas as linhas as quatro colunas
# passsando os níveis de classificação
#
previsao = knn(iristreino[,1:4] , classificar[,1:4] , iristreino[,5], k = 1)
previsao

# a quinta coluna estava com a mesma classificação iris, então iremos compará-las
# com a da previsão pra vermos a precisão da previsão
confusao = table(classificar[,5] , previsao)
confusao

taxa_acerto = (confusao[1,1] + confusao[2,2] + confusao[3,3])/sum(confusao)
taxa_acerto


taxa_erro = (sum(confusao)-(confusao[1,1] + confusao[2,2] + confusao[3,3]))/sum(confusao)
taxa_erro


# http://computacaointeligente.com.br/algoritmos/k-vizinhos-mais-proximos/

# Cálculo da distãncia
