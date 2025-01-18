function [fbar_y] = differentiator(t, y)

    % calculate one-sided-difference at starting point

    fbar_y(1) = (y(2) - y(1))/(t(2) - t(1));
    
    % calculate every other point except N
    
    for i = 2:1:(length(t) - 1)

        fbar_y(i) = (y(i+1) - y(i-1))/(t(i+1)-t(i-1));

    end

     % calculate one-sided-difference at ending point

    fbar_y(length(t)) = (y(length(t)) - y(length(t) - 1))/(t(length(t)) - t(length(t) - 1));

end