#set training parameters
train_label <- sample(N, 0.8*N) # 80% as training data
train02_11 <- df02_11[train_label, ]
test02_11 <- df02_11[-train_label, ]

subset.ex3 <- subset_selection(train02_11, test02_11, 10)[1] 
lasso.ex3 <- lasso_regression(train02_11, test02_11, 10) 
ridge.ex3 <- ridge_regression(train02_11, test02_11, 10) 
pcr.ex3 <- pc_regression(train02_11, test02_11, 10) 
naive.ex3 <- naive_regression(train02_11, test02_11) 
ols.ex3 <- kitchen_sink(train02_11, test02_11) 

ex3.output <- cbind(subset.ex3, lasso.ex3, ridge.ex3, pcr.ex3, 
                    naive.ex3, ols.ex3) %>% as.data.frame()
colnames(ex1.output) <- c("Subset selection", "Lasso", "Ridge", "PCR", "Mean", "OLS")
rownames(ex1.output) <- "RMSE"
stargazer(ex1.output, 
          type = "latex", 
          digits = 4, 
          summary = FALSE, 
          rownames = TRUE,
          out = './Analysis/Output/ex3.tex')

print(subset_selection(train02_11, test02_11)[2])
print(subset_selection(train92_02, test92_02)[2])
