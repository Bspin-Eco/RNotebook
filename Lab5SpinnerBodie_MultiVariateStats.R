#install the car package
install.packages("car")
#load in packages
library(tidyverse)
library(lterdatasampler)
library(car)

# data set
data("pie_crab")
glimpse(pie_crab)
?pie_crab

# sample size per site
pie_crab %>% 
  group_by(site) %>% 
  count()
summary(pie_crab)

pie_crab %>% 
  ggplot(aes(x = reorder(site, latitude), y = size, color = site)) + #reorder orders site along x axis by latitude
  geom_jitter()+ #visualization, add small amount of variation on x axis to each point so they are not on top of each other
  # edit y axis label
  labs(x = "", y = "Carapace width (mm)")+
  # remove the legend and x axis label
  theme(legend.position = "none",
        axis.title.x = element_blank())
###
###ANOVA
###
##Assumptions
#ANOVA assumes normal distributions within each group
## to test normality of all group ->
# ->  calculate the residuals for all groups and test for normal distribution on the single set of residuals
# ->  residual value is computed for each observation as the difference between that value and the mean of all values for that group
res_aov <- aov(size ~ site, data = pie_crab) #Note that the aov() function won’t work the %>% pipe.
hist(res_aov$residuals)

shapiro.test(res_aov$residuals) #p > 0.05, is normal
#ANOVA assumes equal variences
leveneTest(size ~ site, data = pie_crab) #Levene’s Test.
#small p value -variences are not equal

##Welch ANOVA
oneway.test(size ~ site, data = pie_crab, var.equal = FALSE)
#small p value - at least 1 group is diff

##Filter before post-hoc Tukey's HSD
#13 groups that is a lot of pairwise comparisons to perform.
#check for differences among 3 sites, choosing sites at the two extremes in latitude and one in the middle of the range.
pie_sites <- pie_crab %>% 
  filter(site %in% c("GTM", "DB", "PIE"))
#varience test
leveneTest(size ~ site, data = pie_sites)
#large p value, equal variences
pie_anova <- aov(size ~ site, data = pie_sites)
summary(pie_anova)
#sig diff

##Post-hoc Tukey’s HSD test
TukeyHSD(pie_anova)
#GTM is sig diff from DB
#and PIE is sig diff from DB

###
### Simple Linear Reggression
###
pie_lm <- lm(size ~ latitude, data = pie_crab)
#view the results of the linear model
summary(pie_lm)

#visualization
pie_crab %>% 
  ggplot(aes(x = latitude, y = size))+
  geom_point()+
  geom_smooth(method = "lm")

#predict
new_lat <- data.frame(latitude = c(32, 36, 38))
predict(pie_lm, newdata = new_lat)

###
###Multiple Linear Regression
###
pie_mlm <- lm(size ~ latitude + air_temp + water_temp, data = pie_crab)
summary(pie_mlm)
#Multiple Linear Reggession Assumes no correlation between predictor variable
pie_crab %>% 
  select(latitude, air_temp, water_temp) %>% 
  cor()
#Normally tests remove variables that have a correlation coefficient greater than 0.7/-0.7


###
###Exercise
###
#1
?pie_crab
pie_sites %>%
  ggplot(aes(x = reorder(site, latitude), y = size, color = site))+
  geom_boxplot()
#2
cor(pie_crab$size, pie_crab$water_temp_sd)
Pie_water_sd<- lm(size ~ water_temp_sd, data = pie_crab)
summary(Pie_water_sd)
pie_crab %>%
  ggplot(aes(x = water_temp_sd, y = size)) +
  geom_point()+
  geom_smooth(method = lm)
#3
pie_crab %>% 
  select(latitude, air_temp_sd, water_temp_sd) %>% 
  cor()

CrabLm <- lm(size ~ latitude + air_temp_sd + water_temp_sd, data = pie_crab)
summary(CrabLm)
