function [x_olinint, y_olinint] = linearInterpolation(x,y, stepsize)

    % calculation of x_olinint and y_olinit

    for i = 1:1:(length(x) - 1) % this loop runs through the values of data_set_1

        for j = 0:1:stepsize-1 % this loop is used to calculate the new y and between y(i) and y(i+1) using Equation(1)

            x_olinint((i*10) - (stepsize - (j + 1))) = ((x(i+1)-x(i))/stepsize) * j + x(i);
            y_olinint((i*10) - (stepsize - (j + 1))) = y(i) + ...
                ((y(i + 1) - y(i)) * ((x_olinint((i*10) - (stepsize - (j + 1))) - x(i)) / (x(i+1) - x(i))));
            
        end

    end

end