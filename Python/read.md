# KS (Kreisselmeier-Steinhauser) Function

The KS function is a popular approach in multi-objective optimization and constraint aggregation. It transforms sets of constraints or objectives into a single smooth function, simplifying optimization problems in fields like structural and aerospace engineering.

---

## 1. Purpose of the KS Function
The KS function is used for:
- **Constraint aggregation**: Replacing multiple constraints with a single smooth approximation.
- **Multi-objective optimization**: Combining multiple objectives into a single differentiable function.

This simplifies complex optimization problems while preserving the behavior of the original constraints or objectives.

---

## 2. Mathematical Formulation
The KS function is defined as:

\[
KS(\mathbf{x}) = \frac{1}{\rho} \ln \left( \sum_{i=1}^{m} \exp\left(\rho f_i(\mathbf{x})\right) \right)
\]

where:
- \( f_i(\mathbf{x}) \): Individual constraint violations or objective functions.
- \( \rho > 0 \): Tuning parameter controlling approximation accuracy.

---

## 3. How It Works
- **Small \( \rho \)** (e.g., \( \rho \to 0 \)):  
  Behaves like an average of all \( f_i(\mathbf{x}) \).
- **Large \( \rho \)** (e.g., \( \rho \to \infty \)):  
  Approximates the maximum value of \( f_i(\mathbf{x}) \):  
  \[
  \lim_{\rho \to \infty} KS(\mathbf{x}) = \max_i f_i(\mathbf{x})
  \]

This smooth differentiability makes the KS function ideal for gradient-based optimization while mimicking the "worst-case" constraint violation.

---

## 4. Key Advantages
- Smooth approximation of non-differentiable `max()` operations.
- Tune fidelity with \( \rho \): Balance between conservatism (large \( \rho \)) and global behavior (small \( \rho \)).
