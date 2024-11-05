#Lab4
##Bodie Spinner
### 02/17/23
### create new theme, fairy floss base w/ synthwave 85 glow for functions, a green for ""
install.packages("remotes")
remotes::install_github("lter/lterdatasampler")
library(tidyverse)
library(lterdatasampler)
data("and_vertebrates")

# View the data structure
glimpse(and_vertebrates)
?and_vertebrates


####Chi-Square Test
#section = two forest sections, clear cut (CC) and old growth (OG)
#unittype = channel unit classification type (C = cascade, I = riffle, IP = isolated pool (not connected to channel), P = pool, R = rapid, S = step (small falls), SC = side channel, NA = not sampled by unit)

#filter and count
and_vertebrates %>% 
  filter(species == "Cutthroat trout") %>% 
  group_by(unittype) %>% 
  summarise(abundance = n())
#or
and_vertebrates %>% 
  filter(species == "Cutthroat trout") %>% 
  drop_na(unittype) %>% 
  count(unittype)

# First clean the dataset to create the contingency table from
trout_clean <- and_vertebrates %>% 
  #filter Cutthroat trout
  filter(species == "Cutthroat trout") %>% 
  # lets test using just the 3 most abundant unittypes
  filter(unittype %in% c("C", "P", "SC")) %>% 
  # drop NAs for both unittype and section
  drop_na(unittype, section)


cont_table <- table(trout_clean$section, trout_clean$unittype)

#Chi-square test
chisq.test(cont_table)

#Visualize
trout_clean %>% 
  count(unittype, section) %>% 
  ggplot(aes(x = unittype, y = n))+
  geom_col(aes(fill = section))+
  scale_fill_manual(values = c("orange", "darkgreen"))+
  theme_minimal()


#### t-test
trout_clean %>% 
  drop_na(weight_g) %>% 
  ggplot(aes(x = section, y = weight_g))+
  geom_boxplot()

#Turns columns to vectors
#test for equal variences
cc_weight <- trout_clean %>% 
  filter(section == "CC") %>% 
  pull(weight_g)

og_weight <- trout_clean %>% 
  filter(section == "OG") %>% 
  pull(weight_g)

var.test(cc_weight, og_weight) # Variences not equal

#View distrobution
hist(trout_clean$weight_g)

#log transformed Varience test
var.test(log(cc_weight), log(og_weight)) # high p-value indicates varience are equal

#t-test
t.test(log(trout_clean$weight_g) ~ trout_clean$section, var.equal = TRUE)

#Welch two sample t-test
t.test(trout_clean$weight_g ~ trout_clean$section, var.equal = FALSE)


####Correlation
####
sally_clean <- and_vertebrates %>% 
  filter(species == "Coastal giant salamander") %>% 
  drop_na(length_2_mm, weight_g)

hist(sally_clean$length_2_mm)
hist(sally_clean$weight_g)

#The null hypothesis of the Shapiro-Wilk normality test 
# is that the variable is normally distributed
shapiro.test(sally_clean$length_2_mm[1:5000])
shapiro.test(sally_clean$weight_g[1:5000])

hist(log(sally_clean$length_2_mm))
hist(log(sally_clean$weight_g))

###Log transformed correlation test
cor.test(log(sally_clean$length_2_mm), log(sally_clean$weight_g)) # indicates strong significant correlation
#visualization
sally_clean %>% 
  ggplot(aes(x = log(length_2_mm), y = log(weight_g)))+
  geom_point()
#linear regression line
sally_clean %>% 
  ggplot(aes(x = log(length_2_mm), y = log(weight_g)))+
  geom_point()+
  geom_smooth(method = "lm")

###Spearman correlation
cor.test(sally_clean$length_2_mm, sally_clean$weight_g, method = "spearman")



####
####Excercises
####

# 1
CostalGS_Clean <- and_vertebrates %>%
  filter(species == "Costal giant salamander") %>%
  drop_na(unittype, section)

cont_table <- table(CostalGS_Clean$section, CostalGS_Clean$unittype)
chisq.test(cont_table)

## Clean data - filter Coastal giant salamander and drop NAs 

#ex1_clean <- and_vertebrates %>%  
  
  #filter(species == "Coastal giant salamander") %>%  
  
 # drop_na(unittype, section) 


## convert to contingency table 

#cont_table <- table(ex1_clean$section, ex1_clean$unittype) 


## conduct the chi-square test 

#chisq.test(cont_table) 

Sys.setenv(R_REMOTES_NO_ERRORS_FROM_WARNINGS="true")

# 2
glimpse(and_vertebrates)

CGS_Clean <- and_vertebrates %>%
  filter(species == "Costal giant salamander") %>%
  drop_na(section, weight_g) %>%
  count(weight_g)

shapiro.test(CGS_Clean$weight_g)

