setwd("C:/r")
getwd()

install.packages("RColorBrewer")
library(RColorBrewer)


indi_1 <- read.csv("C:/r/9494_indicadores.csv", sep=",")
indi_1

indi_1 <- indi_1[order(indi_1$CD_DEPE_UOR),]
indi_1


row.names(indi_1) <- indi_1$NM_UOR_RDZ
indi_1


indi_2 <- indi_1[,3:15]
indi_2


indi_matrix <- data.matrix(indi_2)
indi_matrix

#indi_matrix <- t(indi_matrix)
indi_matrix

indi_heatmap <- heatmap(indi_matrix, Rowv=NA, Colv=NA, col = heat.colors(256), scale="column", margins=c(20,10))

indi_heatmap <- heatmap(indi_matrix, Rowv=NA, Colv=NA, col = brewer.pal(9, "Blues"), scale="column", margins=c(20,10))


?heatmap


install.packages('pheatmap') # if not installed already
library(pheatmap)
pheatmap(indi_matrix, display_numbers = T, cluster_row = FALSE, cluster_cols = FALSE, cellheight = 16)
