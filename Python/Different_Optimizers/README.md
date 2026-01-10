 # Optimization Algorithms Comparison on California Housing Dataset

This project performs a comparative analysis of three different optimization algorithms—**L-BFGS**, **Stochastic Gradient Descent (SGD)**, and **Manual Gradient Descent**—applied to a Linear Regression model. The goal is to predict housing prices using the California Housing dataset after performing statistical data cleaning and feature engineering.

## 📄 Project Overview

The workflow of the project is as follows:
1.  **Data Loading**: Importing the California Housing dataset.
2.  **Preprocessing**: Statistical outlier removal using Z-Scores and data standardization.
3.  **Feature Selection**: Using Mutual Information to select relevant features.
4.  **Model Training**: Training a Linear Regression model using three different optimization strategies.
5.  **Evaluation**: Comparing Mean Squared Error (MSE) and convergence speeds.

## 📊 Dataset & Preprocessing

The project uses the **California Housing dataset** loaded via `sklearn`.

### Outlier Removal (Z-Score)
To ensure the model is robust, outliers were removed using statistical analysis:
* **Z-Score Calculation**: The Z-score was computed for numerical columns to measure how many standard deviations a data point is from the mean.
* **Thresholding**: A threshold of **1.5** was applied. Any row containing a value with a Z-score greater than 1.5 was considered an outlier and dropped from the dataset.

### Feature Engineering
* **Mutual Information**: `mutual_info_regression` was used to determine feature importance.
* **Feature Dropping**: Based on the analysis, the "AveRooms" and "Population" columns were dropped to reduce noise.
* **Scaling**: The data was standardized using `StandardScaler` to ensure efficient convergence for the optimization algorithms.

## 🧠 Optimization Algorithms Implemented

### 1. L-BFGS (Limited-memory BFGS)
* **Type**: Quasi-Newton Method (Second-order optimization).
* **Implementation**: PyTorch `optim.LBFGS`.
* **Performance**: This optimizer demonstrated extremely fast convergence.
    * **Iterations**: Converged significantly within 10-20 iterations.
    * **Test MSE**: Approximately **0.3667**.

### 2. Stochastic Gradient Descent (SGD)
* **Type**: First-order optimization.
* **Implementation**: PyTorch `optim.SGD` with a learning rate of 0.1.
* **Performance**: Required more iterations to converge compared to L-BFGS.
    * **Iterations**: Run for 41 iterations.
    * **Test MSE**: Approximately **0.3673**.

### 3. Manual Gradient Descent
* **Type**: First-order optimization (implemented from scratch using NumPy).
* **Implementation**: Calculated gradients manually using matrix multiplication:
    * Gradient w.r.t weights: $\frac{\partial J}{\partial w} = \frac{2}{N} X^T (Xw + b - y)$
    * Gradient w.r.t bias: $\frac{\partial J}{\partial b} = \frac{2}{N} \sum (Xw + b - y)$
* **Performance**:
    * **Epochs**: 401 epochs.
    * **Final Loss**: **0.3505**.

## 🚀 Dependencies

To run this notebook, you will need the following Python libraries:

```python
import numpy
import pandas
import torch
import sklearn
import matplotlib.pyplot
import scipy
