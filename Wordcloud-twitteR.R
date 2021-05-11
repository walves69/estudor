# Instalando e Carregando o Pacote twitteR
install.packages("twitteR")
library(twitteR)



# Buscando as chaves de autenticação do Twitter
key <- Sys.getenv("TWITTER_KEY")
secret <- Sys.getenv("TWITTER_SECRET")
token <- Sys.getenv("TWITTER_TOKEN")
tokensecret <- Sys.getenv("TWITTER_TOKEN_SECRET")

setup_twitter_oauth(key, secret, token, tokensecret)



# Vamos buscar 200 tweets em português que contenham a palavra vacina no estado do Ceará
# Para busca por localidade é necessário latitude longitude e o raio de abrangência
# Peguei a latitude do estado em https://www.latlong.net/ e atribui o raio de 450 km
# Capturando os tweets:
tema <- "#Fantastico"
qtd_tweets <- 500
lingua <- "pt"
tweetdata = searchTwitter(tema, n = qtd_tweets, lang = lingua, geocode='-5.321160,-39.336788,450km')


# Exemplo de Nuvem de Palavras
install.packages("tm")
library(tm)


# Carregando funções de limpeza
source('C:\\r\\estudor\\DSA\\Mini-Projeto01\\utils.R')




# Tratamento (limpeza, organização e transformação) dos dados coletados
tweetlist <- sapply(tweetdata, function(x) x$getText())
tweetlist <- iconv(tweetlist, to = "utf-8", sub="")
tweetlist <- limpaTweets(tweetlist)
tweetcorpus <- Corpus(VectorSource(tweetlist))
tweetcorpus <- tm_map(tweetcorpus, removePunctuation)
tweetcorpus <- tm_map(tweetcorpus, content_transformer(tolower))
tweetcorpus <- tm_map(tweetcorpus, function(x)removeWords(x, stopwords(kind = "pt")))

# Convertendo o objeto Corpus para texto plano
# tweetcorpus <- tm_map(tweetcorpus, PlainTextDocument)
termo_por_documento = as.matrix(TermDocumentMatrix(tweetcorpus), control = list(stopwords = c(stopwords("portuguese"))))



# Instalando o pacote wordcloud
install.packages("RColorBrewer")
install.packages("wordcloud")
library(RColorBrewer)
library(wordcloud)

# Gerando uma nuvem palavras
pal2 <- brewer.pal(8,"Dark2")

wordcloud(tweetcorpus,
          min.freq = 2,
          scale = c(5,1),
          random.color = F,
          max.word = 60,
          random.order = F,
          colors = pal2)

