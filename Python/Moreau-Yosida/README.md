Moreau-Yosida Regularization

This repository contains code and tools related to Moreau-Yosida regularization, a technique used in optimization and analysis of non-smooth functions.

📚 What is Moreau-Yosida Regularization?

Moreau-Yosida regularization is a mathematical method that smooths a non-smooth (possibly non-differentiable) function.

Given a function $g : \mathbb{R}^n \to \mathbb{R} \cup {+\infty}$ and a parameter $\lambda > 0$, the regularized function $g_\lambda$ is defined as:

g_\lambda(x) = \min_{y \in \mathbb{R}^n} \left\{ g(y) + \frac{1}{2\lambda} \| y - x \|^2 \right\}
