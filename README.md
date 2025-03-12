# Difference-of-Convex (DC) Optimization

This repository contains an implementation of an algorithm for solving a **constrained difference-of-convex (DC) optimization problem** of the form:

max F(x) = g(x) – h(x)
subject to D x ≤ d, x ≥ 0,

where g(x) and h(x) are convex functions. In our specific example, F(x) includes 2 quadratic terms, and the constraint is given by a matrix D and a vector d.
