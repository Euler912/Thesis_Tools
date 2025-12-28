classdef BoxConstraints
    properties (Constant)
        n = 8;
    end

    methods (Static)

        function y = NAME()
            y = "BoxConstraints problem with wide box constraints (statistical recovery)";
        end

        % -------- Upper bounds --------
        function A = A1()
            A = zeros(BoxConstraints.n, BoxConstraints.n);

            % Intercept: x1 <= 20
            A(1,1) = 1;

            % Coefficients: x2..x8 <= 5
            A(2:end,2:end) = eye(BoxConstraints.n - 1);
        end

        function b = b1()
            b = [2; 2 * ones(BoxConstraints.n - 1, 1)];
        end

        % -------- Lower bounds --------
        function A = A2()
            A = zeros(BoxConstraints.n, BoxConstraints.n);

            % Intercept: -x1 <= 20  -> x1 >= -20
            A(1,1) = -1;

            % Coefficients: -x2..-x8 <= 5  -> xj >= -5
            A(2:end,2:end) = -eye(BoxConstraints.n - 1);
        end

        function b = b2()
            b = [2; 2 * ones(BoxConstraints.n - 1, 1)];
        end

    end
end
