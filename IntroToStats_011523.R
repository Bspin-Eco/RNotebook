#In Class Intro to Stats
##02/15/23
###Bodie Spinner
library(tidyverse)
library(palmerpenguins)
view(penguins)
library(lterdatasampler)
library(tidyverse)
glimpse(and_vertebrates)
summary(and_vertebrates)
view(and_vertebrates)
str(and_vertebrates)
#flipperlength
penguins %>%
  ggplot(aes(x = flipper_length_mm))+
  geom_histogram(aes(fill = species))
?ggplot


#species counts
penguins %>%
  group_by(species) %>%
  summarise(abundance = n())
#or
penguins %>%  #gives count of 1 variable
  count(species)


##Does flipper length vary by sex in gentoos
#Box plot of flipper length
penguins %>%
  filter(species == "Gentoo") %>%
  drop_na(sex, flipper_length_mm) %>% #removes rows with NA values
  ggplot(aes(x=sex, y = flipper_length_mm))+
  geom_boxplot()
  

#testing for variences

gentoo <- penguins %>%
  filter(species == "Gentoo") %>%
  drop_na(sex, flipper_length_mm)

male <- filter(gentoo, sex == "male") %>% pull(flipper_length_mm) #pull gives values for a specfic column

female <- filter(gentoo, sex == "female") %>% pull(flipper_length_mm)

var.test(male, female) #this variences are not equal

hist(male)
hist(female)

#Shapiro-Wilk normality test - not use non-parametric test or transfom data set.
shapiro.test(male)
shapiro.test(female)

#t-test
t.test(gentoo$flipper_length_mm ~ gentoo$sex, var.equal = FALSE)
#results males have longer flipper length


###Correlation Test
###

#visualize species diff
penguins %>%
  ggplot(aes(x = bill_depth_mm, y = bill_length_mm))+
  geom_point((aes(color = species)))

adelie <- penguins %>%
  filter(species == "Adelie") %>%
  drop_na(bill_depth_mm, bill_length_mm)

hist(adelie$bill_length_mm)
hist(adelie$bill_depth_mm)

shapiro.test(adelie$bill_depth_mm) #normal dist
shapiro.test(adelie$bill_length_mm) #normal dist


#ex logtransform - changes scale
hist(log(adelie$bill_length_mm))

#correlation test
cor.test(adelie$bill_length_mm, adelie$bill_depth_mm)

#visualization
adelie %>%
  ggplot(aes(x=bill_length_mm, y = bill_depth_mm)) +
  geom_point()+
  geom_smooth(method = "lm") #calcualtes regression and show best for line
