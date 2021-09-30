#set training parameters
train_label <- sample(N, 0.8*N) # 80% as training data
train02_11 <- df02_11[train_label, ]
test02_11 <- df02_11[-train_label, ]

subset.ex3 <- subset_selection(train02_11, test02_11, 10)[1] 
lasso.ex3 <- lasso_regression(train02_11, test02_11, 10) [1]
ridge.ex3 <- ridge_regression(train02_11, test02_11, 10) 
pcr.ex3 <- pc_regression(train02_11, test02_11, 10) 
naive.ex3 <- naive_regression(train02_11, test02_11) 
ols.ex3 <- kitchen_sink(train02_11, test02_11) 

ex3.output <- cbind(subset.ex3, lasso.ex3, ridge.ex3, pcr.ex3, 
                    naive.ex3, ols.ex3) %>% 
  as.numeric() %>% 
  t() %>% 
  as.data.frame()
colnames(ex3.output) <- c("Subset selection", "Lasso", "Ridge", "PCR", "Mean", "OLS")
rownames(ex3.output) <- "RMSE"
stargazer(ex3.output, 
          type = "latex", 
          digits = 4, 
          summary = FALSE, 
          rownames = TRUE,
          out = './Analysis/Output/ex3.tex')

print("Best model of subset selection (02_11) is :")
print(subset_selection(train02_11, test02_11)[2])

print("Best model of subset selection (92_02) is :")
print(subset_selection(train92_02, test92_02)[2])
#use 92_02 best model to fit 02_11 dataset
reg1 <- lm(subset_selection(train92_02, test92_02)[2][[1]], data = df02_11)
reg2 <- lm(subset_selection(train92_02, test92_02)[2][[1]], data = df92_02)
stargazer(reg1, reg2, type = "latex", summary = FALSE, digits = 3, 
          out = './Analysis/Output/comparison.tex')
