install.packages("rtweet")
library (rtweet)



install.packages("wordcloud")
library(wordcloud)
install.packages("RColorBrewer")
library(RColorBrewer)



twitter_token <- create_token(
  app = "ulima69devapp",
  consumer_key = Sys.getenv("TWITTER_KEY"),
  consumer_secret = Sys.getenv("TWITTER_SECRET"),
  access_token = Sys.getenv("TWITTER_TOKEN"),
  access_secret = Sys.getenv("TWITTER_TOKEN_SECRET"),
  set_renv = TRUE)


climate <- search_tweets("climate", n=1000, include_rts=FALSE, lang="en")



install.packages("tm")
library(tm)
#Create a vector containing only the text
text <- climate$text

text <- gsub("https\\S*", "", text) 
head(text)

text <- gsub("@\\S*", "", text) 
head(text)

text <- gsub("amp", "", text) 

text <- gsub("[\r\n]", "", text)
text <- gsub("[[:punct:]]", "", text)


head(text)  
  
  
# Create a corpus  
docs <- Corpus(VectorSource(text))


docs <- docs %>%
  tm_map(removeNumbers) %>%
  tm_map(removePunctuation) %>%
  tm_map(stripWhitespace)
docs <- tm_map(docs, content_transformer(tolower))
docs <- tm_map(docs, removeWords, stopwords("english"))



dtm <- TermDocumentMatrix(docs) 

matrix <- as.matrix(dtm) 
words <- sort(rowSums(matrix),decreasing=TRUE) 
df <- data.frame(word = names(words),freq=words)



set.seed(1234) # for reproducibility 
wordcloud(
  words = df$word, 
  freq = df$freq, 
  min.freq = 1,           
  max.words=200, 
  random.order=FALSE, 
  rot.per=0.35,            
  colors=brewer.pal(8, "Dark2")
)


install.packages("wordcloud2")
library(wordcloud2)

wordcloud2(data=df, size=1.6, color='random-dark')

# Referências
# Amaral, Fernando - Introdução a Ciência de Dados: Mineração de dados e Big Data
# https://towardsdatascience.com/create-a-word-cloud-with-r-bde3e7422e8a
# https://towardsdatascience.com/a-guide-to-mining-and-analysing-tweets-with-r-2f56818fdd16
# https://cran.r-project.org/web/packages/rtweet/vignettes/auth.html
# Tem dois tipos de autorização
# com consumer key and secret e com as quatros chaves
# 
