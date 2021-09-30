# randomly order the data by row
N <- nrow(input02_11)
rows <- sample(N) # randomly order our dataset
df02_11 <- input02_11[rows, ] %>% 
  select(-1) #countrylist is unused in regression

#the best predictor from Exercise 1 is PCR
pcr.ex2 <- pc_regression(df92_02, df02_11) 
lasso.ex2 <- lasso_regression(df92_02, df02_11) #k is omitted as default is 10
ridge.ex2 <- ridge_regression(df92_02, df02_11)
subset.ex2 <- subset_selection(df92_02, df02_11)[1]
naive.ex2 <- naive_regression(df92_02, df02_11)
ols.ex2 <- kitchen_sink(df92_02, df02_11)

ex2.output <- cbind(subset.ex2, lasso.ex2, ridge.ex2, 
                    pcr.ex2, naive.ex2, ols.ex2) %>% 
  as.numeric() %>% 
  t() %>% 
  as.data.frame()
colnames(ex2.output) <- c("Subset selection", "Lasso", "Ridge", "PCR", "Mean", "OLS")
rownames(ex2.output) <- "RMSE"
stargazer(ex2.output, 
          type = "latex", 
          digits = 4, 
          summary = FALSE, 
          rownames = TRUE,
          out = './Analysis/Output/ex2.tex')
