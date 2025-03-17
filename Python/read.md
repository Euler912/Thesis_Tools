# KS Aggregation Function

This repository contains an implementation of the **KS aggregation function**, which is used to approximate the maximum of a set of functions in a smooth manner. The KS function is particularly useful in optimization and numerical methods where differentiability is required.

## **KS Function Definition**
The KS function for a set of functions \( f_1, f_2, ..., f_n \) and a parameter \( p \) is defined as:

\[
KS(x) = \frac{1}{p} \log \sum_{i=1}^{n} \exp(p \cdot f_i(x))
\]

where:
- \( f_i(x) \) are the input functions.
- \( p \) is a parameter that controls the approximation smoothness (higher \( p \) makes it closer to the true maximum).

## **Example Implementation**
In this implementation, we use the KS function on a set of **convex functions**, including:

- **Quadratic function**: \( f_1(x) = x^2 \)
- **Exponential function**: \( f_2(x) = e^x \)
- **Absolute value**: \( f_3(x) = |x| \)
- **Log-squared function**: \( f_4(x) = \log(1 + x^2) \)

We compute and plot:

1. The **KS aggregation** of these functions.
2. The **maximum function** (pointwise maximum of all input functions) for comparison.

## **Usage**
The Python script computes and visualizes the KS function using **Matplotlib**. To run it:

```bash
python ks_script.py
```

The plot will show:
- **KS Aggregation** (smooth approximation of max function)
- **Max Function** (exact pointwise maximum)
- **Individual convex functions** (for reference)

## **Interpretation**
- As **p increases**, the KS function gets closer to the actual maximum.
- The KS function ensures **differentiability**, making it useful in **gradient-based optimization**.
- This method is widely used in **optimization, machine learning, and control theory** to approximate non-smooth functions smoothly.

---

This implementation is useful for testing KS aggregation behavior in various numerical settings. Feel free to modify the function list and experiment with different values of \( p \)! 🚀
