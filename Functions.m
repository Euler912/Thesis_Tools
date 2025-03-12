classdef Functions
    methods(Static)
        function g = compute_gradient(func, x)
            % compute_gradient  Computes the gradient of f at x using central finite differences.
            %
            %   g = compute_gradient(f, x) returns an approximation of the gradient of the 
            %   scalar function f at the point x.
            %
            %   This function uses central differences and requires O(n) evaluations of f.
            
            n = length(x);
            g = zeros(n, 1);
            delta = 1e-6;
            for i = 1:n
                e = zeros(n, 1);
                e(i) = delta;
                g(i) = (func(x + e) - func(x - e)) / (2 * delta);
            end
        end
        
 function H = barrier_hessian_symmetric(x, A_list, b_list)
    % barrier_hessian_symmetric  Computes the Hessian of the log barrier function.
    %
    %   H = barrier_hessian_symmetric(x, A_list, b_list)
    %
    %   For each block of constraints in A_list and b_list, where the j-th
    %   constraint is given by:
    %       A_list{i}(j,:) * x <= b_list{i}(j),
    %   the contribution to the Hessian is computed as:
    %       A_list{i}' * diag(1./( (b_list{i} - A_list{i}*x).^2 )) * A_list{i}.
    %
    %   The overall Hessian of the log barrier function:
    %       phi(x) = - sum_{i} sum_{j} log( b_list{i}(j) - A_list{i}(j,:) * x )
    %   is then the sum of the contributions from all constraints.
    
    n = length(x);
    H = zeros(n, n);
    
    for i = 1:length(A_list)
        Ai = A_list{i};
        bi = b_list{i};
        s = bi - Ai * x;  % vector of slacks (m_i x 1)
        if any(s <= 0)
            error('Constraint block %d is not strictly feasible (some slack <= 0)', i);
        end
        H = H + Ai' * diag(1./(s.^2)) * Ai;
    end
end

        
        function x_bar = theorem3_transform(x_star, y_star, alpha, beta, epsilonn, tol)
            % theorem3_transform  Performs a rounding transformation based on provided parameters.
            %
            %   x_bar = theorem3_transform(x_star, y_star, alpha, beta, epsilonn, tol)
            %
            %   If tol is not provided, it defaults to 1e-8.
            
            if nargin < 6
                tol = 1e-8;
            end
            
            n_local = length(x_star);
            x_bar = zeros(n_local, 1);
            J = find(0.5 * (x_star.^2) < y_star - tol);
            
            for i = 1:n_local
                if ~ismember(i, J) || (ismember(i, J) && (abs(alpha(i)) < tol) && ~(abs(beta(i)) < tol))
                    x_bar(i) = x_star(i);
                elseif (abs(alpha(i)) < tol) && (abs(beta(i)) < tol) && (abs(epsilonn(i)) < tol)
                    x_bar(i) = sqrt(2 * y_star(i));
                elseif ~(abs(alpha(i)) < tol)
                    theta_star = alpha(i) * y_star(i) + beta(i) * x_star(i);
                    disc = beta(i)^2 + 2 * alpha(i) * theta_star;
                    if disc < 0
                        error('Negative discriminant at index %d: disc = %g', i, disc);
                    end
                    sol1 = (-beta(i) + sqrt(disc)) / alpha(i);
                    sol2 = (-beta(i) - sqrt(disc)) / alpha(i);
                    if abs(sol1 - x_star(i)) < abs(sol2 - x_star(i))
                        x_bar(i) = sol1;
                    else
                        x_bar(i) = sol2;
                    end
                else
                    x_bar(i) = x_star(i);
                end
            end
        end
        
        function finding_x_start = iterative_argmax_fg(A_list, b_list, x_mid, f, g, x_g)
            % iterative_argmax_fg  Finds an approximate argmax via an iterative sequence.
            %
            %   finding_x_start = iterative_argmax_fg(A_list, b_list, x_mid, f, g, x_g)
            %
            %   This function uses CVX to solve an iterative convex subproblem:
            %       maximize dot(grad_f - grad_g, x)
            %   subject to linear constraints of the form:
            %       A_list{i} * x <= b_list{i}
            %
            %   f and g are function handles and x_g is used to compute the gradient of g.
            %
            %   The iteration starts at x_mid and stops when the change is below tol.
            
            max_iter = 50;
            tol = 1e-6;
            n = length(x_mid);
            x_old = x_mid;
            % Compute the gradient of g at x_g
            grad_g = Functions.compute_gradient(g, x_g);
            
            for k = 1:max_iter
                % Compute gradient of f at x_old
                grad_f = Functions.compute_gradient(f, x_old);
                
                cvx_begin quiet
                    variable x(n)
                    maximize(dot((grad_f - grad_g), x))
                    subject to
                        for i = 1:length(A_list)
                            Ai = A_list{i};
                            bi = b_list{i};
                            Ai * x <= bi;
                        end
                cvx_end
                
                x_new = x;
                if norm(x_new - x_old) < tol
                    x_old = x_new;
                    break;
                end
                x_old = x_new;
            end
            finding_x_start = x_old;
        end
        
        function isFeasible = checkFeasibility(x, A_list, b_list)
            % checkFeasibility  Checks if x satisfies A_i * x <= b_i for all i.
            %
            %   isFeasible = checkFeasibility(x, A_list, b_list)
            %
            %   INPUTS:
            %     x       : n x 1 vector (the point to check)
            %     A_list  : cell array of matrices {A1, A2, ..., Am}, each A_i is (p_i x n)
            %     b_list  : cell array of vectors {b1, b2, ..., bm}, each b_i is p_i x 1
            %
            %   OUTPUT:
            %     isFeasible : logical (true if x satisfies all constraints A_i*x <= b_i, false otherwise)
            
            % Initialize as feasible; we'll change to false if we find a violation.
            isFeasible = true;
            
            % Loop through each constraint block
            for i = 1:length(A_list)
                Ai = A_list{i};  % p_i x n
                bi = b_list{i};  % p_i x 1
                
                % Check if Ai*x <= bi (elementwise)
                if any(Ai * x > bi+10e-7)
                    % If any component of Ai*x > bi, x violates the constraint
                    isFeasible = false;
                    return;  % No need to check further constraints
                end
            end
        end
        
        function [x, val_x] = hidden_convex(D, x1, e, Q, q)
            % hidden_convex  Solves a hidden convex optimization subproblem.
            %
            %   [x, val_x] = hidden_convex(D, x1, e, Q, q)
            %
            %   The problem solved is:
            %       minimize 0.5*(x-x1)'*D*(x-x1) + e'*(x-x1)
            %       subject to (x-q)'*Q*(x-q) <= 1
            %
            %   This function uses CVX and additional post-processing.
            
            n1 = size(D, 1);
            n2 = size(Q, 1);
            L = chol(Q)';
            A = inv(L) * D * inv(L');
            [U, T] = schur(A);
            S = inv(L') * U;
            alfa = diag(T);
            beta = S' * (D * x1 - e);
            gamma = q' * Q * q;
            delta = -2 * S' * Q * q;
            
            cvx_begin 
                variables y(n1) z(n1)
                minimize(-alfa' * y + beta' * z)
                subject to
                    2 * sum(y) + delta' * z + gamma <= 1
                    z.^2 <= 2 * y
            cvx_end
            
            if max(abs(z.^2 - 2 * y)) > 1e-7
                J = find(2 * y - z.^2 > 1e-7);
                teta = 2 * y(J) + delta(J) .* z(J);
                z(J) = 0.5 * (-delta(J) + sqrt(delta(J).^2 + 4 * teta));
                y = 0.5 * z.^2;
            end
            
            x = S * z;
            val_x = 0.5 * (x - x1)' * D * (x - x1) + e' * (x - x1);
        end
        
        function grad = calculate_gradient(func, point)
            % calculate_gradient Computes the gradient of a function at a specific point.
            %
            % Inputs:
            %   func  - Function handle of the form f(x) where x is a vector.
            %   point - Vector specifying the point at which to calculate the gradient.
            %
            % Output:
            %   grad  - Gradient vector at the specified point.
            
            % Set default step size if not provided
            h = 1e-6;
            
            % Get dimension of the input
            n = length(point);
            
            % Initialize gradient vector
            grad = zeros(size(point));
            
            % Calculate the function value at the given point
            f0 = func(point);
            
            % Calculate partial derivatives using central difference
            for i = 1:n
                % Create step vector (zeros with h at position i)
                step = zeros(size(point));
                step(i) = h;
                
                % Forward step
                forward_point = point + step;
                f_forward = func(forward_point);
                
                % Backward step
                backward_point = point - step;
                f_backward = func(backward_point);
                
                % Central difference formula
                grad(i) = (f_forward - f_backward) / (2 * h);
            end
        end
        
        function H = hessian_fd(func, x)
            % hessian_fd  Computes the Hessian matrix of a scalar function f at point x.
            %
            % INPUTS:
            %   f - function handle that maps a vector x to a scalar, e.g., f = @(x) x(1)^2 + sin(x(2));
            %   x - column vector at which to evaluate the Hessian.
            %
            % OUTPUT:
            %   H - Hessian matrix evaluated at x.
            %
            % This function uses central finite differences to approximate the second partial derivatives.
            %
            % Example:
            %   f = @(x) x(1)^2 + sin(x(2));
            %   x0 = [1; 0.5];
            %   H = hessian_fd(f, x0);
            
            n = length(x);
            H = zeros(n, n);
            h = 1e-5;
            
            for i = 1:n
                for j = i:n  % Use symmetry: H(i,j) = H(j,i)
                    x_ij1 = x; x_ij1(i) = x_ij1(i) + h; x_ij1(j) = x_ij1(j) + h;
                    x_ij2 = x; x_ij2(i) = x_ij2(i) + h; x_ij2(j) = x_ij2(j) - h;
                    x_ij3 = x; x_ij3(i) = x_ij3(i) - h; x_ij3(j) = x_ij3(j) + h;
                    x_ij4 = x; x_ij4(i) = x_ij4(i) - h; x_ij4(j) = x_ij4(j) - h;
                    
                    H(i, j) = (func(x_ij1) - func(x_ij2) - func(x_ij3) + func(x_ij4)) / (4 * h^2);
                    H(j, i) = H(i, j);
                end
            end
        end
        
        function [t_min, t_max, x_int] = intersect_hyperplane(p, d, A_list, b_list)
            % intersect_hyperplane  Computes the intersection of a hyperplane with a feasible set.
            %
            %   [t_min, t_max, x_int] = intersect_hyperplane(p, d, A_list, b_list)
            %
            %   Inputs:
            %       p      - An n-dimensional point on the hyperplane (n x 1 vector).
            %       d      - An n-dimensional direction vector defining the hyperplane (n x 1 vector).
            %       A_list - Cell array of constraint matrices. Each A_list{i} is of size r_i x n.
            %       b_list - Cell array of corresponding right-hand side vectors. Each b_list{i} is of length r_i.
            %
            %   Outputs:
            %       t_min  - The maximum lower bound on the parameter t.
            %       t_max  - The minimum upper bound on the parameter t.
            %       x_int  - An n x 2 matrix where the first column is p + t_min*d and the second is p + t_max*d.
            %
            %   The function computes, for each constraint row:
            %       A_i(j,:) * (p + t*d) <= b_i(j)
            %   and deduces bounds on t.
            
            t_lower = -inf;
            t_upper = inf;
            
            for i = 1:length(A_list)
                A_i = A_list{i};
                b_i = b_list{i};
                [r_i, ~] = size(A_i);
                
                for j = 1:r_i
                    Ai_row = A_i(j, :);
                    bi_val = b_i(j);
                    
                    Ad = Ai_row * d;
                    Ap = Ai_row * p;
                    
                    if Ad > 0
                        t_upper = min(t_upper, (bi_val - Ap) / Ad);
                    elseif Ad < 0
                        t_lower = max(t_lower, (bi_val - Ap) / Ad);
                    else
                        if Ap > bi_val
                            error('Constraint %d, row %d is infeasible for the given p; no intersection exists.', i, j);
                        end
                    end
                end
            end
            
            if t_lower > t_upper
                warning('No intersection between the hyperplane and the feasible set.');
                t_min = [];
                t_max = [];
                x_int = [];
            else
                t_min = t_lower;
                t_max = t_upper;
                x_int = [p + t_min * d, p + t_max * d];
            end
        end
        function g = robust_compute_gradient(func, x)
        % robust_compute_gradient  Computes the gradient of func at x in a robust manner.
        %
        % It first attempts to use the complex-step differentiation method,
        % and if that fails (e.g. if func does not accept complex inputs),
        % it falls back to central finite differences with an adaptive step size.
        
        n = length(x);
        g = zeros(n, 1);
        try
            % Use complex-step differentiation
            h = 1e-8;  % A small step size
            for i = 1:n
                e = zeros(n,1);
                e(i) = h;
                % Note: This assumes func can accept complex arguments.
                g(i) = imag(func(x + 1i * e)) / h;
            end
        catch
            % Fall back to central differences with adaptive step sizes
            for i = 1:n
                h_i = 1e-8 * max(1, abs(x(i)));
                e = zeros(n,1);
                e(i) = h_i;
                g(i) = (func(x + e) - func(x - e)) / (2 * h_i);
            end
        end
        end

        function extreme = isExtreme(x, A_list, b_list, tol)
% isExtreme Checks whether the point x is an extreme point (vertex) of the polytope
% defined by A_list and b_list.
%
%   extreme = isExtreme(x, A_list, b_list, tol) returns true if x is an extreme
%   point of the feasible set:
%
%       { x in R^n : A_list{i} * x <= b_list{i}, for all i },
%
%   and false otherwise.
%
%   tol is an optional tolerance (default: 1e-6) to decide when a constraint is
%   active (i.e. A*x is close enough to b).
%
%   The function works by:
%     1. Stacking all the constraints into a single matrix A_total and vector b_total.
%     2. Determining which constraints are active at x (|A_total*x - b_total| < tol).
%     3. Checking if the matrix of active constraints has full rank (i.e., equals length(x)).
%
% Example:
%   A1 = [1 0; 0 1; -1 0];
%   b1 = [5; 5; 0];
%   A2 = [-1 0; 0 -1];
%   b2 = [0; 0];
%   A_list = {A1, A2};
%   b_list = {b1, b2};
%   x = [0; 0];
%   extreme = isExtreme(x, A_list, b_list);
%
% Author: [Your Name]
% Date: [Today's Date]

    if nargin < 4
        tol = 1e-6;
    end

    % Determine the dimension of x
    n = length(x);
    
    % Stack all constraints into a single matrix and vector
    A_total = [];
    b_total = [];
    for i = 1:length(A_list)
        A_total = [A_total; A_list{i}];
        b_total = [b_total; b_list{i}];
    end
    
    % Evaluate the constraints at x
    residuals = A_total * x - b_total;
    
    % Identify active constraints (within tolerance)
    active_idx = find(abs(residuals) < tol);
    A_active = A_total(active_idx, :);
    
    % Check the rank of the active constraint matrix
    % x is an extreme point if the active constraints span R^n (i.e., rank = n)
    if rank(A_active) == n
        extreme = true;
    else
        extreme = false;
    end
end





    end
end
