function [x_opolint, y_opolint] = polynomialInterpolation(x, y, stepsize)

    % initialize counter

    counter = 1;

    for m = 1:1:(length(x) - 1)

        for n = 0:1:(stepsize - 1)  % innerloop for interpolation points
        
            % calculation of x_opolint 
        
            x_opolint(counter) = ((x(m+1)-x(m))/stepsize) * n + x(m);

            % initialization of y_opolint(counter)

            y_opolint(counter) = 0;

            % calculation of L

            for i = 1:1:length(x)

                % initialize L as 1 (because of multiplication)
    
                L = 1;

                for k = 1:1:length(x)

                    % skip if k = i

                    if k ~= i

                        L = L * ((x_opolint(counter) - x(k))/(x(i) - x(k)));

                    end

                end

                % calculation of y_opolint
        
                y_opolint(counter) = y_opolint(counter) + y(i) * L;

            end

            % update counter

            counter = counter + 1;

        end

    end

end
