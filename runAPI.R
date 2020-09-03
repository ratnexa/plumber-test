library(plumber)
r <- plumb(file = 'plumber.R')
r$run(port = 40)

#POST(url = 'http://127.0.0.1:8000/predict?am=1&qsec=16.46&wt=2.62') %>% content()

