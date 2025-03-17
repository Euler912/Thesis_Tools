classdef enbaht
    properties(Constant)
        n =20;  % Fixed dimension
    end
    methods(Static)
        function y = NAME()
            % Just a label or identifier for your data
            y = "Enbaht problem data";
        end
     
        function A = A1()
            % A1 enforces x_i <= 1 + 5i
            % For n = 150, simply return the 150x150 identity matrix.
            A = eye(enbaht.n);
        end
        
        function b = b1()
            % b1 has entries b(i) = 1 + 5*i for i = 1,...,150.
            n = enbaht.n;
            b = zeros(n,1);
            for i = 1:n
                b(i) = (1 + 5*i)/21;
            end
        end
        
        function A = A2()
            % A2 enforces -x_i <= 1 + i, i.e., x_i >= -1 - i.
            A = -eye(enbaht.n);
        end
        
        function b = b2()
            % b2 has entries b(i) = 1 + i for i = 1,...,150.
            n = enbaht.n;
            b = zeros(n,1);
            for i = 1:n
                b(i) = (1 + i)/21;
            end
        end
    end
end
