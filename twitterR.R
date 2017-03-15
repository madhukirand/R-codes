
source("creds.R")
library("twitteR")
library("tm")
library("wordcloud")

setup_twitter_oauth(CUSTOMER_KEY, CUSTOMER_SECRET, 
                    ACCESS_TOKEN, ACCESS_secret)

loc <- availableTrendLocations()
trendsIn <- loc[loc$country=="India","woeid"]
trends <- getTrends(woeid = trendsIn)
View(trends)

r_search <- searchTwitter("bjp+election+modi+up+2017", 
                          n=500,lang = "en",since = "2017-03-10",until = "2017-03-13")

class(r_search)
r_text <- sapply(r_search,function(x) x$getText())
class(r_text)
r_text <- gsub("[^[:alnum:]///' ]", " ", r_text)
str(r_text)
ele_corpus <- Corpus(VectorSource(r_text))
inspect(ele_corpus[1])

####clean corpus
ele_clean <- tm_map(ele_corpus,removePunctuation)
ele_clean <- tm_map(ele_clean,tolower)
ele_clean <- tm_map(ele_clean,removeWords,stopwords("english"))
ele_clean <- tm_map(ele_clean,removeNumbers)
ele_clean <- tm_map(ele_clean,stripWhitespace)
ele_clean <- tm_map(ele_clean,removeWords,
                    c("2017","election","up",
                      "results","uttarpradesh","will","indianexpress",
                      "electionresults","indiatoday","speech",
                      "reach","politics","seats","poll","live",
                      "httpstcohbprhoradt","writemeenal","https",
                      "cobugxvwfcvv","cohbprhoradt","htt"))#optional
inspect(ele_clean[1])
tdm <- TermDocumentMatrix(ele_clean)
mat <- as.matrix(tdm)
mat.freq <- rowSums(mat)
mat.freq <- subset(mat.freq,mat.freq>=10)
head(sort(mat.freq,decreasing = T),100)
barplot(sort(mat.freq),col = rainbow(100),las=2)

pdf("wordcloud.pdf")
wordcloud(names(mat.freq), freq = mat.freq,random.order=FALSE,colors=rainbow(50),
          rot.per=0.35,scale =c(5,1))
dev.off()





