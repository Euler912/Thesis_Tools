Moreau-Yosida Regularization

This repository contains code and tools related to Moreau-Yosida regularization, a technique used in optimization and analysis of non-smooth functions.

📚 What is Moreau-Yosida Regularization?

Moreau-Yosida regularization smooths a non-smooth (possibly non-differentiable) function.

Given a function $g : \mathbb{R}^n \to \mathbb{R} \cup {+\infty}$ and a parameter $\lambda > 0$, the regularized function $g_\lambda$ is defined as:

$$ g_\lambda(x) = \min_{y \in \mathbb{R}^n} \left( g(y) + \frac{1}{2\lambda} |y - x|^2 \right) $$





Small $\lambda$: Closer approximation to $g(x)$.



Large $\lambda$: Smoother version of $g(x)$.

The point that minimizes the above expression is called the proximal operator:

$\text{prox}{\lambda g}(x) = \arg\min{y} g(y) + \frac{1}{2\lambda} |y - x|^2$

The gradient of $g_\lambda$ is given by:

$$\nabla g_\lambda(x) = \frac{1}{\lambda}(x - \text{prox}_{\lambda g}(x))$$

✨ Properties





$g_\lambda(x)$ is convex if $g(x)$ is convex.



$g_\lambda(x)$ is differentiable (even if $g$ is not).



The gradient $\nabla g_\lambda(x)$ is Lipschitz continuous with constant $1/\lambda$.



As $\lambda \to 0$, $g_\lambda(x) \to g(x)$ (pointwise).

🎯 Why Use It?





To smooth non-differentiable functions.



To enable gradient-based optimization methods.



To analyze non-smooth problems with smoother approximations.



To connect optimization and proximal algorithms.
