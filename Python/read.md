# KS (Kreisselmeier-Steinhauser) Function

The KS function is a popular approach in multi-objective optimization and constraint aggregation. It is often used to transform a set of constraints or multiple objectives into a single smooth function, making optimization problems more tractable, especially in structural and aerospace engineering.

## 1. Purpose of the KS Function
The KS function is typically used for:
- **Constraint aggregation**: Replacing multiple constraints with a single smooth approximation.
- **Multi-objective optimization**: Combining multiple objectives into a single function.

This helps simplify complex optimization problems while maintaining a good approximation of the original objectives or constraints.

## 2. Mathematical Formulation
The KS function is defined as:

\[
KS(x) = \frac{1}{\rho} \ln \left( \sum_{i=1}^{m} \exp(\rho f_i(x)) \right)
\]

where:
- \( f_i(x) \) are the individual constraint functions or objectives.
- \( \rho > 0 \) is a tuning parameter controlling the approximation tightness.

## 3. How It Works
- When \( \rho \) is **small**, the KS function behaves like an average of the \( f_i(x) \) values.
- When \( \rho \) is **large**, the KS function approximates the maximum of the \( f_i(x) \), meaning:

\[
\lim_{\rho \to \infty} KS(x) = \max_i f_i(x)
\]

This property allows the KS function to approximate the worst constraint violation while maintaining smooth differentiability, making it suitable for gradient-based optimization.
