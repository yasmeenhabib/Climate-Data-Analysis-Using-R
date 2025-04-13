install.packages("readxl")
library(readxl)

data <- read_excel("GHG.xlsx")
head(data)

train <- subset(data, year <= 2004)
test <- subset(data, year > 2004)

model1 <- lm(Temperature ~ MEI + CO2 + CH4 + N2O + CFC11 + CFC12 + TSI + Aerosols, data = train)
summary(model1)

install.packages("corrplot")
library(corrplot)

install.packages("dplyr")
library(dplyr)

vars <- train %>% select(Temperature, MEI, CO2, CH4, N2O, CFC11, CFC12, TSI, Aerosols)
cor_matrix <- cor(vars, use = "complete.obs")

corrplot(cor_matrix, method = "circle")

cor_n2o <- cor_matrix["N2O", ]
high_cor_n2o <- names(which(abs(cor_n2o) > 0.7))
print(high_cor_n2o)

cor_cfc11 <- cor_matrix["CFC11", ]
high_cor_cfc11 <- names(which(abs(cor_cfc11) > 0.7))
print(high_cor_cfc11)

model2 <- lm(Temperature ~ Aerosols + N2O + MEI + TSI, data = train)
summary(model2)