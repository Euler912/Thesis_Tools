This repository contains an implementation of an algorithm for solving constrained difference-of-convex (DC) optimization problems of the form:

max
⁡
𝐹
(
𝑥
)
=
𝑔
(
𝑥
)
−
ℎ
(
𝑥
)
maxF(x)=g(x)−h(x)
subject to:

𝐷
𝑥
≤
𝑑
,
𝑥
≥
0
Dx≤d,x≥0
where 
𝑔
(
𝑥
)
g(x) and 
ℎ
(
𝑥
)
h(x) are convex functions. In our specific example, 
𝐹
(
𝑥
)
F(x) consists of two quadratic terms, while the constraints are defined by a matrix 
𝐷
D and a vector 
𝑑
d, with all variables being non-negative.

Objective Function
The optimization problem maximizes the function:

max
⁡
𝑥
∈
𝑅
𝑛
∑
𝑖
=
1
𝑛
(
𝑛
−
1
−
0.1
𝑖
)
𝑥
𝑖
2
x∈R 
n
 
max
​
  
i=1
∑
n
​
 (n−1−0.1i)x 
i
2
​
 
This function can be expressed as the difference of two quadratic functions, making it suitable for Difference-of-Convex (DC) optimization techniques. Specifically, we represent it as:

𝐹
(
𝑥
)
=
𝑔
(
𝑥
)
−
ℎ
(
𝑥
)
,
F(x)=g(x)−h(x),
where both 
𝑔
(
𝑥
)
g(x) and 
ℎ
(
𝑥
)
h(x) are convex quadratic functions.

Usage
The provided algorithms are designed to run with 
𝑛
=
20
n=20 (i.e., 20 variables). Additionally, a PDF file is included, documenting the results of maximizing the function for different values of 
𝑛
n.
