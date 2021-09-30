# AEE 2021 Fall, Task6
This task aims at comparing different supervised machine learning algorithms including best subset selection, ridge regression, lasso regression and principal component regression in both contexts of in-sample and out-of-sample performance.

Exercise 1
------------------
In this exercise, I use only 1992-2002 data set in which 80% is used as training set and the rest 20% is test set. A 10-fold cross-validation is implemented within the training set, splitting the training set further into training subset and validation subset. With these settings, I compare the following methods based on their root mean squared errors (RMSE), see table below. 
![image text](https://github.com/Qinglino/AEE_Task6/blob/main/Analysis/Output/ex1.png)

In lasso regression, the best model is given as `growth ~ ln_y + ext_bal + inflation + fem_emp + tot_emp + competitiveness_leg + presidential + regulation`

In best subset selection, the best model is presented as `growth ~ ln_y + ext_bal + inflation + fem_emp + inf_mort + lexp + tfr + urban + presidential + regulation`

These two models are more or less similar in the sense that they have 6 variables in common, however, Lasso model performs clearly better in terms of RMSE. Actually, the best within-period prediction model is PCR, the second is Ridge regression. Note that the naive estimator is performing surprisingly well in this exercise, while the kitchen-sink model is the worst. 

Exercise 2
------------------
In this exercise, I use the whole 92-02 dataset as the training set while the whole 02-11 dataset as the test set. Similar process is conducted as the exercise 1, and the performance is documented in the table below.
![image text](https://github.com/Qinglino/AEE_Task6/blob/main/Analysis/Output/ex2.png)

The best out-of-sample lasso regression model turns to `growth ~ ln_y + gvmnt_c + ext_bal + inflation + fem_emp + inf_mort + lexp + urban + competitiveness_leg + competitiveness_exec + presidential + stability + effectiveness + regulation`

while the best out-of-sample subset selection model is `ln_y + ext_bal + inflation + fem_emp + inf_mort + tfr + urban + presidential + effectiveness`.

Clearly we can notice that the best subset selection models across two exercises do not alter much, however, it is not the case with lasso regression. In fact, RMSE of the two subset selection models are very close and show that this model is a mediocre one. But PCR becomes the worst model from the best in previous exercise, which implies a poor ability of generalization. Again, the naive estimator is still doing great.

Exercise 3
------------------
Redoing the exercise 1 with 02-11 data gives us the best subset selection model as `growth ~ ln_y + hc + gcf + ext_bal + trade + inflation + fem_emp + tot_emp + lexp + military + competitiveness_exec + parliamentary + stability + corruption`, which shows a great change from the one in exercise 1, both in the number of selected variables and what variables to include. Again, I follow the same procedure as in exercise 1 to compapre different methods' performance, and present them in table below.
![image text](https://github.com/Qinglino/AEE_Task6/blob/main/Analysis/Output/ex3.png)

The method of interest, subset selection, is again the mediocre choice in terms of RMSE. And the naive method is failing as well, while lasso and ridge regression stay robust.

If we use the subset selection model designated in exercise 1, the estimated coefficients will be different across time periods. Some variations are ignorable but some are involved with change of sign. See table below.
![image text](https://github.com/Qinglino/AEE_Task6/blob/main/Analysis/Output/comparison.png)
