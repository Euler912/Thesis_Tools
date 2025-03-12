This repository contains an implementation of an algorithm for solving a constrained difference-of-convex (DC) optimization problem of the form:

max
⁡
𝑥
∈
𝑅
𝑛
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
subject to 
𝐷
𝑥
≤
𝑑
,
  
𝑥
≥
0
,
​
  
x∈R 
n
 
max
​
 F(x)=g(x)−h(x),
subject to Dx≤d,x≥0,
​
 
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
F(x) includes 2 quadratics terms, and the constraint is given by a matrix 
𝐷
D and a vector 
𝑑
d.
