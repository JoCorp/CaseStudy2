function [x_polint, y_polint] = polynomialInterpolation(x, y, stepsize)

    % initialize counter

    counter = 1;

    % calculation of x_polint and y_polint

    for m = 1:1:(length(x) - 1)

        for n = 0:1:(stepsize - 1)  % innerloop for interpolation points
        
            % calculation of x_polint 
        
            x_polint(counter) = ((x(m+1)-x(m))/stepsize) * n + x(m);

            % initialization of y_polint(counter)

            y_polint(counter) = 0;

            % calculation of L

            for i = 1:1:length(x)

                % initialize L as 1 (because of multiplication)
    
                L = 1;

                for k = 1:1:length(x)

                    % skip if k = i

                    if k ~= i

                        L = L * ((x_polint(counter) - x(k))/(x(i) - x(k)));

                    end

                end

                % calculation of y_polint
        
                y_polint(counter) = y_polint(counter) + y(i) * L;

            end

            % update counter

            counter = counter + 1;

        end

    end

    % add last point directly from data set

    x_polint(length(x_polint) + 1) = x(end);
    y_polint(length(y_polint) + 1) = y(end);
    
end
