
# Instalando e Carregando o Pacote twitteR
install.packages("twitteR")
#install.packages("httr")
library(twitteR)
#library(httr)


# Buscando as chaves de autenticação do Twitter
# Autenticando
key <- Sys.getenv("TWITTER_KEY")
secret <- Sys.getenv("TWITTER_SECRET")
token <- Sys.getenv("TWITTER_TOKEN")
tokensecret <- Sys.getenv("TWITTER_TOKEN_SECRET")

setup_twitter_oauth(key, secret, token, tokensecret)


# Buscando tweets - neste caso 50 postagens com a hashtag rstats
tweets<-searchTwitter('#rstats',n=10)
tweets
  

# Sendo mais específico na busca.
# Vamos buscar 200 tweets em português que contenham a palavra vacina no estado do Ceará
# Para busca por localidade é necessário latitude longitude e o raio de abrangência
# Peguei a latitude do estado em https://www.latlong.net/ e atribui o raio de 450 km
# Capturando os tweets:
tema <- "vacina"
qtd_tweets <- 500
lingua <- "pt"
tweetdata = searchTwitter(tema, n = qtd_tweets, lang = lingua, geocode='-5.321160,-39.336788,450km')


# Salvando os dados para que não seja necessário buscar constantemente
save(tweetdata,file="tweetdata.Rda")
# Para recarregar
tweetdata <- load("tweetdata.Rda")


# Visualizando as primeiras linhas do objeto tweetdata
head(tweetdata)


# Não ficou claro pra mim qual o uso
# tweetdata_strip <- strip_retweets(tweetdata,strip_manual=TRUE,strip_mt=TRUE)
# head()


# Transformando os dados em dataframe
df<-twListToDF(tweetdata)


# Salvando os dados para que não seja necessário buscar constantemente
save(tweetdata,file="tweetdata.Rda")
# Para recarregar
tweetdata <- load("tweetdata.Rda")


# Olhando o dataframe
head(df)


# Buscando Trends de forma geral
avail_trends=availableTrendLocations()
head(avail_trends)


# Quais os canais de trends disponíveis para o Ceará ?
close_trends=closestTrendLocations(-5.321160,-39.336788,450)


# Vemos que está disponível trends apenas para Fortaleza
head(close_trends)


# Vamos usar o woeid 455830 para buscar as tendências dessa região
trends=getTrends(455830)
head(trends)


# Buscando informações de usuários
# Verificando a timeline do usuário
userTimeline("dsacademybr")


# Buscando dados de usuário
# O retorno é um objeto com inúmeros dados do usuário
crantastic<-getUser('crantastic')
crantastic$getDescription()
crantastic$getFollowersCount()
crantastic$getFriends(n=5)
crantastic$getFavorites(n=5)


# Buscando a timeline do usuário
cran_tweets<-userTimeline('cranatic')
cran_tweets[1:5]


# cran_tweets_large<-userTimeline('cranatic',n=100)


# Exemplo
# Quais foram os dispositivos usados para twittar a hasgtag covid19 ?
r_tweets<-searchTwitter("#covid19",n=100)
sources<-sapply(r_tweets,function(x)x$getStatusSource())
sources<-gsub("</a>","",sources)


# Quebrou o que sobrou da linha no sinal de maior que fecha o link.
# Assim temos no primeiro elemento do vetor o link e no segundo o conteúdo do link
# Conteúdo da tag <a>
sources<-strsplit(sources,">")


# Se para cada elemento do vetor eu tiver mais de um elemento pegar o segundo (conteúdo do link)
# caso contrário pegar o primeiro visto que quando foi feito o split só devia ter um
sources<-sapply(sources,function(x)ifelse(length(x)>1,x[2],x[1]))

# Criando uma tabelas com a contagem dos fatores
source_table=table(sources)
source_table
pie(source_table[source_table>=10])
#plot(source_table[source_table>=10])




# Referências
# http://geoffjentry.hexdump.org/twitteR.pdf





# Próximo Estudos
# usando a outra api rtweet
# https://www.earthdatascience.org/courses/earth-analytics/get-data-using-apis/use-twitter-api-r/
# https://abraji.org.br/help-desk/veja-como-monitorar-em-tempo-real-ataques-coordenados-no-twitter
# https://github.com/ropensci/rtweet



# sobr eo r blogdown
# https://stackoverflow.com/questions/51881967/blogdown-post-not-rendering-after-build-site-and-serve-site
# https://alison.rbind.io/post/2017-06-12-up-and-running-with-blogdown/
# https://www.datacamp.com/courses/data-manipulation-with-dplyr
# https://amber.rbind.io/2016/12/19/website/
# https://medium.com/@traffordDataLab/exploring-tweets-in-r-54f6011a193d