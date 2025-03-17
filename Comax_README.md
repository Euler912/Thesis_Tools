# Difference-of-Convex (DC) Optimization

This repository contains an implementation of an algorithm for solving **constrained difference-of-convex (DC) optimization problems** of the form:

```math
\max F(x) = g(x) - h(x)
```

subject to:

```math
D x \leq d, \quad x \geq 0
```

where \( g(x) \) and \( h(x) \) are convex functions. In our specific example, \( F(x) \) consists of two quadratic terms, while the constraints are defined by a matrix \( D \) and a vector \( d \), with all variables being non-negative.

## Objective Function

The optimization problem maximizes the function:

```math
\max_{x \in \mathbb{R}^n} \sum_{i=1}^{n} (n - 1 - 0.1i)x_i^2
```

This function can be expressed as the **difference of two quadratic functions**, making it suitable for **Difference-of-Convex (DC) optimization techniques**. Specifically, we represent it as:

```math
F(x) = g(x) - h(x),
```

where both \( g(x) \) and \( h(x) \) are convex quadratic functions.

## Usage

The provided algorithms are designed to run with **\( n = 20 \)** (i.e., 20 variables). Additionally, a PDF file is included, documenting the results of maximizing the function for different values of \( n \).
