library(caret)
library(httr)
library(magrittr)
library(plumber)
library(tidyverse)

# plumber.R

# Read model data.
# model.list <- readRDS(file = 'model_list.rds')

#* @param wt
#* @param qsec
#* @param am
#* @post /predict
# CalculatePrediction <- function(wt, qsec, am){
#   wt %<>% as.numeric
#   qsec %<>% as.numeric
#   am %<>% as.numeric
#   
#   x.new <- tibble(wt = wt, qsec = qsec, am = am)
#   y.pred <- model.list$GetNewPredictions(model = model.list$model.obj, 
#                                          transformer = model.list$scaler.obj,
#                                          newdata = x.new)
#   
#   return(y.pred)
# }

#* @param a
#* @param b
#* @param c
#* @post /sum
sumSantiago <- function(a, b, c){
  a %<>% as.numeric
  b %<>% as.numeric
  c %<>% as.numeric
  
  result <- a + b + c
  return(result)
}

#CalculatePrediction(1, 16.2, 23)


