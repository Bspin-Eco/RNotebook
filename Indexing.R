### Introduction to R and RStudio
## Bodie Spinner
# 02/03/23
library(tidyverse)
library(palmerpenguins)
data("penguins")
class(penguins) #tbl stands for tibble
str(penguins)
class(penguins$species) # What does this mean? | Factor w/ 3 levels "Adelie","Chinstrap",..: 1 1 1 1 1 1 |
str(penguins$species) # one variable has a one data type

#Lists can hold mixed data types and structures
myList <- list("apple", 1993, FALSE, penguins)
str(myList)
list(myList, list("more stuff here", list("and more")))
names(myList) <- c("fruit", "year", "logic", "data")
names(myList)
# for lists we use double brackes [[]]
myList[[1]]
myList[["data"]]

# for vectors we use single brackets []
myVector <- c("apple", "banana", "pear")
myVector[2]

##Indexing
# dataframe[row(s), columns()]
penguins[1:5, 2]

penguins[1:5, "island"]

penguins[1, 1:5]

penguins[1:5, c("species","sex")]

penguins[penguins$sex=='female',]

# $ for a single column
penguins$species

survey_data <- read_csv("Data/Lab1/survey_sorting_exercise.csv")
class(survey_data)
str(survey_data)
myList[["year"]]
penguins$flipper_length_mm
penguins[penguins$island=='Dream',]

#unique function
unique(penguins$island)
unique(penguins$species)
#indexing
df <- penguins[c("species", "island", "flipper_length_mm")]
str(df)

penguins[c("species", "flipper_length_mm")]

mean(penguins$flipper_length_mm[penguins$species=="Adelie"], na.rm = TRUE)
?mean

AdelieOnly <- penguins[penguins$species == 'Adelie',]
mean(AdelieOnly$flipper_length_mm, na.rm = TRUE)


#3.3.4 example
# mathematical functions with numbers
log(10)

# average a range of numbers
mean(1:5)

# nested functions for a string of numbers, using the concatenate function 'c'
mean(c(1,2,3,4,5)) #c means "concatenate" or combine


# functions with characters
print("Hello World")

paste("Hello", "World", sep = "-")

#Assignment operators
x <- log(10)
x + 5


