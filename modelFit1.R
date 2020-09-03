library(caret)
library(httr)
library(magrittr)
library(plumber)
library(tidyverse)

df <- mtcars %>% as_tibble()

#Create a simple linear model to predict mpg

set.seed(0)

x <- df %>% select(wt, qsec, am)
y <- df %>% pull(mpg) #transforms to a vector directly

partition <- createDataPartition(y = y, p = 0.75, list = F)

df.train <- df[partition, ]
df.test <- df[-partition, ]  

x.train <- df.train %>% select(wt, qsec, am)
y.train <- df.train %>% pull(mpg)

x.test <- df.test %>% select(wt, qsec, am)
y.test <- df.test %>% pull(mpg)

scaler <- preProcess(x = x.train, method = c("center", "scale"))

#scale the features
x.train.scale <- predict(object = scaler, newdata = x.train)
x.test.scale <- predict(object = scaler, newdata = x.test)

model <- train(x = x.train.scale,
               y = y.train, 
               method = 'ridge',
               trControl = trainControl(method = 'cv', number = 3),
               metric = 'RMSE')

model$results %>% select(RMSE)

y.pred <- predict(model, newdata = x.test.scale)
RMSE(pred = y.pred, obs = y.test)

#save the model
# x.new <- data.frame(wt = 1, 
#                     qsec = 12.4,
#                     am = 20) %>% as_tibble()

getNewPredictions <- function(model, transformer, newdata){
  newdata.transformed <- predict(object = transformer, newdata = newdata)
  new.predictions <- predict(object = model, newdata = newdata)
  return(new.predictions)
}

#getNewPredictions(model, scaler, x.new)

model.list <- vector(mode = 'list')
model.list$scaler.obj <- scaler
model.list$model.obj <- model
model.list$GetNewPredictions <- getNewPredictions

saveRDS(object = model.list, file = 'model_list.rds')
