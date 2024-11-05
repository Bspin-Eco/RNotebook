library(tidyverse)
library(tidytext)
library(wordcloud)

data <- readxl::read_excel("data/Qual Methods Survey (1).xlsx", 
                           sheet = "Form1")
data %>% 
  ggplot(aes(x = `Do you think science is objective?`))+
  geom_bar()+
  #adds the actual count value to the chart
  geom_text(aes(label = after_stat(count)), stat = "count", vjust = 1.5, size = 12, color = "white")

#sperate data into Y and N dataframes for "Do you think science is objective?"
yes <- data %>% 
  filter(`Do you think science is objective?` == "Yes")


no <- data %>% 
  filter(`Do you think science is objective?` == "No")

#tokenize creates a row for every word in response
#do not want to include: "a, in, the, of, for, ect.
#stop_words is a set list of words to exclude
yes_why <- yes %>%
  #keep just our column of interest
  select(`Why or why not?`) %>% 
  unnest_tokens(output = word, #the new column name to put the text in
                input = "Why or why not?")  %>%
  anti_join(stop_words, by = "word") # remove any stop words. Anti_join keeps everything not in the specficed dataset, "stop_word
