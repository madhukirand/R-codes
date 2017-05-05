source("creds.R")
library("twitteR")
library("tm")
library("wordcloud")
library("shiny")
library("sentiment")

setup_twitter_oauth(CUSTOMER_KEY, CUSTOMER_SECRET, 
                    ACCESS_TOKEN, ACCESS_secret)

shinyServer(function(output,input){
  
  tweet_df <- reactive({
    r_search <- searchTwitter(input$search, 
                              n=100,lang = "en")
    r_text <- sapply(r_search, function(x) x$getText())
    class_emotion = classify_emotion(r_text, algorithm="bayes", prior=1.0)
    # get emotion best fit
    emotion = class_emotion[,7]
    # substitute NA's by "unknown"
    emotion[is.na(emotion)] = "unknown"
    
    # classify polarity
    class_polarity= classify_polarity(r_text, algorithm="bayes")
    # get polarity best fit
    polarity = class_polarity[,4]
    
    tweet_df = data.frame(text=r_text, emotion=emotion,
                          polarity=polarity, stringsAsFactors=FALSE)
    tweet_df = within(tweet_df,
                      emotion <- factor(emotion, levels=names(sort(table(emotion), decreasing=TRUE))))
    
  })
  
  
  
  output$bar <- renderPlot({
    tweet_df <- tweet_df()
    barplot(table(tweet_df$emotion)[-1])
  
    # barplot(table(tweet_df$polarity))
    # emo <- table(tweet_df$emotion)[-1]# removed unknown
    # por <- table(tweet_df$polarity)
    # pie(por,radius = 1,col=rainbow(length(emo)))
  })
  
  output$pie <- renderPlot({
    tweet_df <- tweet_df()
    emo <- table(tweet_df$emotion)[-1]
    pie(emo,radius = 1,col=rainbow(length(emo)))
  })

})