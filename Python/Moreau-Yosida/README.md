# Moreau-Yosida Regularization

This repository contains code and tools related to Moreau-Yosida regularization, a technique used in optimization and analysis of non-smooth functions.

## 📚 What is Moreau-Yosida Regularization?

Moreau-Yosida regularization smooths a non-smooth (possibly non-differentiable) function.

Given a function $g : \mathbb{R}^n \to \mathbb{R} \cup \{+\infty\}$ and a parameter $\lambda > 0$, the regularized function $g_\lambda$ is defined as:

$$g_\lambda(x) = \min_{y \in \mathbb{R}^n} g(y) + \frac{1}{2\lambda} \|y - x\|^2$$

* **Small $\lambda$**: Closer approximation to $g(x)$.
* **Large $\lambda$**: Smoother version of $g(x)$.

The point that minimizes the above expression is called the **proximal operator**:

$$\text{prox}_{\lambda g}(x) = \arg\min_{y} \{ g(y) + \frac{1}{2\lambda} \|y - x\|^2 \}$$

The gradient of $g_\lambda$ is given by:

$$\nabla g_\lambda(x) = \frac{1}{\lambda}(x - \text{prox}_{\lambda g}(x))$$

## ✨ Properties

* $g_\lambda(x)$ is **convex** if $g(x)$ is convex.
* $g_\lambda(x)$ is **differentiable** (even if $g$ is not).
* The gradient $\nabla g_\lambda(x)$ is **Lipschitz continuous** with constant $1/\lambda$.
* As $\lambda \to 0$, $g_\lambda(x) \to g(x)$ (pointwise).

## 🎯 Why Use It?

* To **smooth** non-differentiable functions.
* To enable **gradient-based optimization** methods.
* To **analyze** non-smooth problems with smoother approximations.
* To **connect** optimization and proximal algorithms.

<!-- If GitHub Markdown doesn't render the equations properly, here are image versions -->
<!-- 
Main equation:
![Moreau-Yosida regularization](https://latex.codecogs.com/svg.latex?g_%5Clambda(x)%20%3D%20%5Cmin_%7By%20%5Cin%20%5Cmathbb%7BR%7D%5En%7D%20%5C%7B%20g(y)%20%2B%20%5Cfrac%7B1%7D%7B2%5Clambda%7D%20%5C%7C%20y%20-%20x%20%5C%7C%5E2%20%5C%7D)

Proximal operator:
![Proximal operator](https://latex.codecogs.com/svg.latex?%5Ctext%7Bprox%7D_%7B%5Clambda%20g%7D(x)%20%3D%20%5Carg%5Cmin_%7By%7D%20%5C%7B%20g(y)%20%2B%20%5Cfrac%7B1%7D%7B2%5Clambda%7D%20%5C%7C%20y%20-%20x%20%5C%7C%5E2%20%5C%7D)

Gradient:
![Gradient](https://latex.codecogs.com/svg.latex?%5Cnabla%20g_%5Clambda(x)%20%3D%20%5Cfrac%7B1%7D%7B%5Clambda%7D%20(x%20-%20%5Ctext%7Bprox%7D_%7B%5Clambda%20g%7D(x)))
-->
