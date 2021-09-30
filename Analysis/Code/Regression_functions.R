require(pls)
subset_selection <- function(training, testing, k = 10){
  # Find the best subset selection for the give set of variables.
  #
  # Args:
  #   training: the dataset used for training, variables are in columns 
  #             and obs are in rows.
  #   testing: the dataset used for testing, variables are in columns 
  #             and obs are in rows.
  #   k: the number of folds you want to use in k-fold cross validation
  # Returns:
  #   A list containing minimum root mean squared error and corresponding formula.
  n_training <- nrow(training)
  # this part is about splitting training data into k folds
  start <- rep(NULL, k)
  end <- rep(NULL, k)
  start[1] <- 1
  end[k] <- n_training
  for (i in 1:(k-1)){
    end[i] <- round(n_training * i/k)
    start[i+1] <- end[i] + 1
  }
  
  formula <- rep(NULL, k)
  RMSE <- rep(NULL, k)
  for (i in 1:k){
    #for each fold i, validation and training sets are defined
    valid_k_folds <- training[start[i]:end[i], ] # 10% is validation
    train_k_folds <- training[-c(start[i]:end[i]), ] # the rest 90% is training
    
    model <- regsubsets(growth~., data = train_k_folds, 
                          nvmax = 27, method = "backward")
    reg.summary <- summary(model)
    best_n_var <- which.max(reg.summary$adjr2) # choose optimal #variabls by adjR2
    best_model <- reg.summary$which[best_n_var,-1] # extract variables
    predictors <- names(which(best_model == TRUE)) %>% 
        paste(collapse = " + ")
    formula[i] <- paste("growth ~ ", predictors, sep = "")
    fit <- lm(formula[i], data = train_k_folds)
    predictions <- predict(fit, valid_k_folds)
    RMSE[i] <- sqrt(t(predictions - valid_k_folds$growth) %*% 
      (predictions - valid_k_folds$growth) / nrow(valid_k_folds))
  }
  
  best.formula <- formula[which.min(RMSE)]
  best.fit <- lm(best.formula, data = training)
  best.predict <- predict(best.fit, testing)
  best.RMSE <- sqrt(t(best.predict - testing$growth) %*% 
    (best.predict - testing$growth)/ nrow(testing))
  
  return(list(best.RMSE, best.formula))
}

ridge_regression <- function(training, testing, k = 10){
  lambdas <- 10^seq(-3, 2, by = .1)
  x <- as.matrix(training[, -2]) #because glmnet() can only take matrixs
  y <- training$growth
  x_test <- as.matrix(testing[, -2])
  y_test <- testing$growth
  
  reg <- cv.glmnet(x, y, alpha = 0, lambda = lambdas, nfolds = k)
  best.reg <- glmnet(x, y, alpha = 0, lambda = reg$lambda.min)
  beta.hat <- as.matrix(coef(best.reg))
  RMSE <- sqrt(t(cbind(1, x_test) %*% beta.hat - y_test) %*% 
    (cbind(1, x_test) %*% beta.hat - y_test) / length(y_test))
  
  return(RMSE)
}

lasso_regression <- function(training, testing, k = 10){

  lambdas <- 10^seq(-3, 2, by = .1)
  x <- as.matrix(training[, -2]) #because glmnet() can only take matrixs
  y <- training$growth
  x_test <- as.matrix(testing[, -2])
  y_test <- testing$growth
  
  reg <- cv.glmnet(x, y, alpha = 1, lambda = lambdas, nfolds = k)
  best.reg <- glmnet(x, y, alpha = 1, lambda = reg$lambda.min)
  beta.hat <- as.matrix(coef(best.reg))
  RMSE <- sqrt(t(cbind(1, x_test) %*% beta.hat - y_test) %*% 
                 (cbind(1, x_test) %*% beta.hat - y_test) / length(y_test))
  return(RMSE)
}

pc_regression <- function(training, testing, k = 10){
  pcr.fit <- pcr(growth~., data = training, validation = "CV")
  rmseCV <- RMSEP(pcr.fit, estimate = "CV")
  best_n_pc <- which.min(rmseCV$val) - 1 #exclude intercept term
  test.fit <- predict(pcr.fit, testing, ncomp = best_n_pc)[, 1, ] %>% 
    as.vector()
  RMSE <- sqrt(t(test.fit - testing$growth) %*% (test.fit - testing$growth) 
               / length(test.fit))
  return(RMSE)
}

naive_regression <- function(training, testing){
  pred <- mean(training$growth)
  RMSE <- sqrt(t(pred - testing$growth) %*% (pred - testing$growth) 
               / length(testing$growth))
  return(RMSE)
}

kitchen_sink <- function(training, testing){
  reg <- lm(growth~., data = training)
  beta.hat <- reg$coefficients
  pred <- as.matrix(cbind(1, testing[, -2])) %*% as.matrix(beta.hat)
  RMSE <- sqrt(t(pred - testing$growth) %*% (pred - testing$growth) 
               / length(testing$growth))
  return(RMSE)
}
