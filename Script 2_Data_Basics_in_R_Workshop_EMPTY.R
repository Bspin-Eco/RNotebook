### Data Basics in R Workshop
### RMBL undergraduate program
### Modified from a workshop by Amy Iler & Josh Scholl
### 23 June 2022



######################
##                  ##
##  PRELIMINARIES   ##
##                  ##
######################

# install tidyverse package (subsequently loads multiple packages including dplyr, tidyr, ggplot2...)
# in the lower, right-hand quadrant of R Studio, click on the 'Packages' tab
# click on 'install': a window will pop up, and you will need to type 'tidyverse' into the 'Packages' line
# cake sure the 'install dependencies' box is checked
# click install!
# do the same thing for the 'car' package

# load packages: after you install this, you'll need to load it each time you open a new R session
library(tidyverse) # for data manipulation + plotting
library(car) # for ANOVAs

# load the starwars data set from the dplyr package
data(starwars)

# look at the starwars dataframe (will open up in a separate tab in the source window)
view(starwars)

# get information about the dataframe and variables
?starwars



#########################
##                     ##
##  DATA ORGANIZATION  ##
##                     ##
#########################

#################################
# dplyr::filter()
#################################

# filter is for rows; it allows you to 'filter' certain rows within a dataframe
# in other words, it filters based on information within each column

# filter the starwars dataframe to keep only humans
dplyr::filter(starwars, species == "Human")

# filter the starwars dataframe to keep only male humans
dplyr::filter(starwars, species=="Human", gender=="masculine")

# filter the starwars dataframe to keep humans and droids
# %in% means 'and' 
dplyr::filter(starwars, species %in% c("Human", "Droid")))

# filter the starwars dataframe to keep characters with a height less than 100
dplyr::filter(starwars, height < 100)

# filter the starwars dataframe to keep all characters that are non-human
# != means does not equal
dplyr::filter(starwars, species != "Human")

# filter the starwars dataframe to remove unknown species (i.e. species == NA)
# !is.na will remove NA values



#################################
# piping in tidyverse
#################################

# filter the starwars dataframe to keep only male humans
starwars %>% 
  dplyr::filter(species=="Human") %>% 
  dplyr::filter(gender=="male")

# %>% think of pipe as 'and then do this'


#################################
# dplyr::select()
#################################

# select is for columns; it allows you to 'select' certain columns in a dataframe

# select only name, species, and films variables from the starwars dataframe
dplyr::select(starwars, name, species, films)

# select all columns except the gender column


# select columns name through to skin color (name, height, mass, hair color, and skin color)


# select all columns except hair color, skin color, and eye color


# select columns name, mass, skin color, hair color, and height (in order)


# rename the "name" column to "character" and the "mass" column to "weight" using select()


# try your hand at using filter and select together:
# keep:  height greater than 100 &
# keep: humans &
# remove: brown hair color &
# remove: vehicles &
# keep: name, homeworld, height, species, hair color




#################################
# dplyr::rename()
#################################

# allows you to rename columns
# this differs from select because it does not select only those columns; you only rename and keep everything else

# Rename the "name" column to "character" 
dplyr::rename(starwars, character=name)

# Rename the "name" column to "character" and the "mass" column to "weight"




#################################
# dplyr::mutate()
#################################

# mutate() allows you to create, modify, and delete columns

# check out the starwars dataframe help page to see what the units are for mass and height
?starwars

# calculate the BMI of all starwars characters
# step 1: convert height in cm to height in m (save as new dataframe)
starwars_bmi <- dplyr::mutate(starwars, height_m = height/100)

# step 2: calculate BMI with formula: BMI = weight (kg) / [height (m)]^2


# select only name, height, mass, height_m, and bmi and view dataframe


# re-calculate the bmi by changing the height column to meters instead of creating a new column


# make a new column to find the average height (in meters) across all characters


# looks like we need to remove some NA values
# check the help page for mean


# use na.rm = TRUE in the mean() function




#################################
# dplyr::group_by()
#################################

# group_by() allows you to group by one or more variables
# often we want to perform an operation on groups defined by variables

# group starwars dataframe by sex
dplyr::group_by(starwars, sex)

# calculate average height PER SEX (hint: group by sex FIRST)




#################################
# dplyr::summarize()
# dplyr::summarise()
#################################

# use with group_by
# summarise() creates a new data frame. it will contain one column for each grouping variable and one column for each of the summary statistics that you specified.
# mutate keeps all the data; summarize only keeps the variables that are specified in the group (like a pivot table in Excel)

# summarize height by sex




#################################
# tidyr::gather()
#################################

# convert the starwars dataframe from wide to long, containing three columns: name, characteristic, value
starwars_long <- starwars %>% 
  tidyr::gather(characteristic, value, height:starships)

# gather height, mass, eye color, skin color, and gender




#################################
# tidyr::spread()
#################################

# un-gather (spread) the starwars dataframe


# spread the starwars dataframe by name, eye color and fill all missing values with '0'



#### TAKE A BREAK ####



##########################################
##                                      ##
##    DATA VISUALIZATION: FIGURES       ##
##                                      ##
##########################################

# simple plot theme; don't worry about the details now, just run the code...
plot_theme <- theme_bw(base_size = 20) +
              theme(panel.grid = element_blank(),
                    legend.position = "bottom",
                    strip.text = element_text(size = 12),
                    text = element_text(size=12))

# ggplot is a very powerful plotting function we will use to plot and visualize the data 
# it is in the tidyverse package, and it is also in its own package too, called ggplot2
data("iris")
?iris
view(iris)


#################################
# Scatter Plot: geom_point
#################################
?shape
# Useful when both your predictor (x) and response (y) variables are continuous

# scatter plot with default settings: x = sepal length, y = petal length
ggplot(data = iris, aes(x = Sepal.Length, y = Petal.Length)) +
  geom_point(shape = 19, size = 1.5) +
  ylab("Petal Length") +
  xlab("Sepal Length") 

# scatter plot with the simple theme (from above)


# let's make the points larger (geom_point; size =)


# let's make the points semi-transparent (geom_point; alpha =)


# let's change the style of point (geom_point; shape =)




#################################
# Box Plot: geom_boxplot
#################################

# box and whisker plots are really nice and simple ways to show a good amount of information visually
# useful when you have a categorical predictor (x) and a continuous response (y)

# basic box plot, x = species, y = petal length
ggplot(data = iris, aes(x = Species, y = Petal.Length)) +
  geom_boxplot()

# add the simple plot theme (from above), and make own axis labels
ggplot(data = iris, aes(x = Species, y = Petal.Length)) +
  geom_boxplot() +
  scale_y_continuous(name = "Petal length (cm)") +
  scale_x_discrete(labels =c ("I. setosa", "I. versicolor", "I. virginica"))+
  plot_theme

# let's add some color (fill =)


# let's change those colors


# check out all those colors in R...
colors()

# let's change the range of the y-axis (limits = c())
# and let's also change the width of the box plot (width =)




####################################
# Dot & Error Plot: geom_pointrange
####################################

# dot and error bar plots are rather common
# they show similar, but less information compared to a box and whisker plot (instead of the entire range, you just plot the mean and standard deviation (or standard error))
# and in ggplot, you have to summarize the data to get this to work...

# let's generate a dot and error bar plot whereby each dot represents the mean height of all the characters in each sex category


# first we must summarize the data so we have plot means and plot standard deviations
summary_iris <- iris %>% 
  dplyr::group_by(Species) %>% 
  dplyr::summarize(plot_mean = mean(Petal.Length, na.rm = T), 
                   plot_sd = sd(Petal.Length, na.rm = T),
                   sd_min = (plot_mean - plot_sd),
                   sd_max = (plot_mean + plot_sd))


# plot dot with sd error bars
ggplot(data = summary_iris, aes(x = Species, y = plot_mean)) +
  geom_pointrange(aes(ymin = sd_min, ymax = sd_max)) +
  scale_y_continuous(name = "Mean petal length (cm)") +
  plot_theme

# change colors of dots and error bars
ggplot(data = summary_iris, aes(x = Species, y = plot_mean)) +
  geom_pointrange(aes(ymin = sd_min, ymax = sd_max), color = c("slateblue1", "blueviolet", "lavender")) +
  scale_y_continuous(name = "Mean petal length (cm)") +
  plot_theme



#### TAKE A BREAK ####



###########################
##                       ##
##    DATA ANALYSIS      ##
##                       ##
###########################

## *** NOTE:  For this section, I include some information and code for checking the assumptions of each kind of statistical test. 
##            You should check what the assumptions are for statistical tests before you use them for your data, 
##            and check whether your data meet the assumptions.


#################################
# Linear Regression
#################################
data(iris)
?iris
view(iris)

# use this when you have a continuous predictor and a continuous response

# does sepal length predict petal length? (Does X predict Y?)
ggplot(data = iris, aes(x = Sepal.Length, y = Petal.Length)) +
  geom_point(shape = 20, size = 2.5, alpha = 1) +
  ylab("Petal Length") +
  xlab("Sepal Length") +
  plot_theme

# the general format of a linear model is: lm(Y ~ X, data = dataframe)
linear_model <- lm(Petal.Length ~ Sepal.Length, data = iris)
summary(linear_model) # the main things to pay attention to here are: R2-value, p-value, and slope
  # R2-value tells you how much variation in Y variable X is explaining; R2 = 0.76 means X explains 76% of
  # the variation in Y
  # p-value tells you whether the relationship is 'significant' (p < 0.05 is significant)
  # slope tells you, for every one unit increase in X, how much Y increases or decreases 

# plot the line of fit, using function 'geom_smooth'
ggplot(data = iris, aes(x = Sepal.Length, y = Petal.Length)) +
  geom_point(shape = 20, size = 2.5, alpha = 1) +
  geom_smooth(method=lm) +
  ylab("Petal Length") +
  xlab("Sepal Length") +
  plot_theme




#################################
# t-test
#################################

# use this when you have two categories in a categorical predictor and a continuous response
# we need to create a dataset with only two categories in one of the categorial predictors, so we'll just filter out two of the three species
iris2 <- dplyr::filter(iris, Species %in% c("setosa", "versicolor"))

# does petal width differ between Iris setosa and Iris versicolor?
# general formula is t.test(Y ~ X, data = dataframe)
t.test(Petal.Width ~ Species, data = iris2, var.equal = T)




#################################
# ANOVA
#################################

# use this when you have more than two categories in a categorical predictor and a continuous response

# the general formula for an ANOVA (Analysis of Variance) is Anova(lm(Y ~ X, data = dataframe))
# note that it is still a linear model! The difference from regression is that you have a categorical predictor.

# does petal length differ among all three species?
ggplot(data = iris, aes(x = Species, y = Petal.Length, fill = Species)) +
  geom_boxplot(fill = c("slateblue1", "blueviolet", "lavender")) +
  scale_y_continuous(name = "Petal length (cm)") +
  scale_x_discrete(labels =c ("I. setosa", "I. versicolor", "I. virginica"))+
  plot_theme

anova_model <- lm(Petal.Length ~ Species, data = iris)
Anova(anova_model, type = 2) # (use type = 3 if you have interactions between two predictor variables)

# OK, but which species are different from one another? Can use Tukey's Honest Significant Difference Test
petal_av <- aov(anova_model)
TukeyHSD(petal_av) # they are all different from one another because p < 0.05



