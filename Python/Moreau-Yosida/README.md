# Moreau-Yosida Regularization

This folder contains code and tools related to the Moreau-Yosida regularization, used in optimization and analysis of non-smooth functions.

## 📚 What is Moreau-Yosida Regularization?

The Moreau-Yosida regularization is a mathematical technique that smooths a non-smooth (possibly non-differentiable) function.

Given a function \( g : \mathbb{R}^n \to \mathbb{R} \cup \{+\infty\} \) and a parameter \( \lambda > 0 \), the regularized function \( g_\lambda \) is defined by:

\[
g_\lambda(x) = \min_{y \in \mathbb{R}^n} \left\{ g(y) + \frac{1}{2\lambda} \| y - x \|^2 \right\}
\]

- **Small \( \lambda \)**: closer approximation to \( g(x) \).
- **Large \( \lambda \)**: smoother version of \( g(x) \).

The point that minimizes the expression is called the **proximal operator**:

\[
\text{prox}_{\lambda g}(x) = \arg\min_y \left\{ g(y) + \frac{1}{2\lambda} \| y - x \|^2 \right\}
\]

and the gradient of \( g_\lambda \) satisfies:

\[
\nabla g_\lambda(x) = \frac{1}{\lambda} (x - \text{prox}_{\lambda g}(x))
\]

---

## ✨ Properties

- \( g_\lambda(x) \) is **convex** if \( g(x) \) is convex.
- \( g_\lambda(x) \) is **differentiable** (even if \( g \) is not).
- The gradient \( \nabla g_\lambda(x) \) is **Lipschitz continuous** with constant \( 1/\lambda \).
- As \( \lambda \to 0 \), \( g_\lambda(x) \to g(x) \) (pointwise).

---

## 🎯 Why Use It?

- To **smooth** non-differentiable functions.
- To **apply gradient-based optimization** methods.
- To **analyze** non-smooth problems with smoother approximations.
- To **connect** optimization and proximal algorithms.
 
--- 
