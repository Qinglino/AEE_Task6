# randonmly order the data by row
N <- nrow(input92_02)
rows <- sample(N) # randomly order our dataset
df92_02 <- input92_02[rows, ] %>% 
  select(-1) #countrylist is unused in regression

#set training parameters
train_label <- sample(N, 0.8*N) # 80% as training data
train92_02 <- df92_02[train_label, ]
test92_02 <- df92_02[-train_label, ]

# normalization is optional after observing our dataset
# df92_02_norm <- scale(df92_02) %>% 
#   as.data.frame() #normalization
# colnames(df92_02_norm) <- colnames(df92_02)
# train92_02_norm <- df92_02_norm[train_label, ]
# test92_02_norm <- df92_02_norm[-train_label, ]

subset <- subset_selection(train92_02, test92_02, 10)[1] 
lasso <- lasso_regression(train92_02, test92_02, 10) 
ridge <- ridge_regression(train92_02, test92_02, 10) 
pcr <- pc_regression(train92_02, test92_02, 10) 
naive <- naive_regression(train92_02, test92_02) 
ols <- kitchen_sink(train92_02, test92_02) 

ex1.output <- cbind(subset, lasso, ridge, pcr, naive, ols) %>% 
  as.numeric() %>% 
  t() %>% 
  as.data.frame()
colnames(ex1.output) <- c("Subset selection", "Lasso", "Ridge", "PCR", "Mean", "OLS")
rownames(ex1.output) <- "RMSE"
stargazer(ex1.output, 
          type = "latex", 
          digits = 4, 
          summary = FALSE, 
          rownames = TRUE,
          out = './Analysis/Output/ex1.tex')
