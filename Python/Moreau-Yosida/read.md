# Moreau-Yosida Regularization and Proximal Mapping

## Overview
This repository provides an implementation of the **Moreau-Yosida regularization**, a fundamental concept in convex optimization used to smooth non-smooth functions. The Moreau envelope serves as a smooth approximation to a given function, and the proximal operator plays a crucial role in its definition. This approach is widely used in optimization, particularly in proximal algorithms and variational analysis.

## Concept of Moreau-Yosida Regularization
The **Moreau-Yosida envelope** of a function \( f(x) \) is given by:
\[
f_{\mu}(x) = \min_y \left( f(y) + \frac{1}{2\mu} \|x - y\|^2 \right)
\]
where \( \mu > 0 \) is a smoothing parameter.

- This transformation results in a **smooth** function even when \( f(x) \) is non-smooth.
- The **proximal mapping** associated with \( f(x) \) is:
\[
\text{prox}_{\mu f}(x) = \arg\min_y \left( f(y) + \frac{1}{2\mu} \|x - y\|^2 \right)
\]
- The **gradient of the Moreau envelope** satisfies:
\[
\nabla f_{\mu}(x) = \frac{1}{\mu} (x - \text{prox}_{\mu f}(x))
\]

This means that performing gradient descent on the Moreau envelope is equivalent to applying **proximal gradient descent** on the original function.

## Code Explanation
The implementation consists of defining a non-smooth function \( f(x) \), its proximal mappings, and computing its Moreau envelope. It also explores the gradient and Hessian approximations.

### Functions Defined:
1. **Objective Function**:
```python
# Define the function f(x)
def f(x):
    return np.maximum((x - 2/3) ** 2, (1 + (2/3) * x) ** 2)
```
This function is piecewise-defined and has non-smooth points, making it a good candidate for Moreau-Yosida regularization.

2. **Proximal Mappings**:
```python
# Proximal mappings
def g_1(x):
    return (3 * x + 4) / 9

def g_2(x):
    return -0.2 + x - x

def g_3(x):
    return (9 * x - 12) / 17
```
Each of these functions represents different regions of the proximal mapping for \( f(x) \).

3. **Moreau Envelope Computation**:
```python
# Compute the Moreau envelope
def Moreau(x, y):  # y is the proximal mapping
    return f(y) + (1 / 2) * (x - y) ** 2
```
This function calculates the Moreau envelope using the given proximal mapping.

4. **Gradient and Hessian Approximations**:
```python
def grad_F(x):
    return x - g_2(x)

def diff_ks_prox(x, h, p):
    return (ks_prox(x + h, p) - ks_prox(x - h, p)) / (2 * h)

def hessian(x):
    return 1 * (1 - diff_ks_prox(x, 0.1, 10))
```
The gradient of the Moreau envelope helps understand the behavior of proximal gradient descent, while the Hessian provides an approximation of the second derivative.

5. **Plotting the Results**:
The script plots:
- The original function \( f(x) \)
- The different proximal mappings \( g_1(x), g_2(x), g_3(x) \)
- The Moreau envelope approximations
- The second-order Taylor approximation for a selected point

```python
plt.figure(figsize=(10, 6))
plt.plot(x, f(x), label='f(x)', color='black')
plt.plot(x_1, y_1, label='Moreau envelope (g_1)', color='blue')
plt.plot(x_2, y_2, label='Moreau envelope (g_2)', color='green')
plt.plot(x_3, y_3, label='Moreau envelope (g_3)', color='red')
plt.grid(True)
plt.legend(fontsize='small')
plt.xlabel("x")
plt.ylabel("Function value")
plt.show()
```

## Summary
This implementation provides an **intuitive and computational approach** to the Moreau-Yosida regularization, demonstrating:
- How **non-smooth functions** can be **smoothed** using the Moreau envelope.
- How the **proximal operator** relates to the **gradient of the Moreau envelope**.
- The significance of **gradient descent on the Moreau envelope** in solving optimization problems.

This technique is widely used in **machine learning, optimization, and signal processing** for handling non-smooth functions in numerical computations.

