function [Ts, smooth_y] = smooth_operator (t, x, alpha)

    % no place for beginners or sensitive heaaaarts ...

    % calculate k based on alpha and n

        % according to wikipedia k has to be rounded UP to the next largest
        % integer

        k = ceil(alpha*length(t));

    % calculate distance and select values

    % outer loop goes through al ts

    for ts = 1:1:length(t)
        
        % first inner loop determines the distance from neighbours

        for i = 1:1:length(t)

            distance(ts, i) = abs(t(ts) - t(i));

        end
        
        % determine if neighbourhood is symmetric

        if ts <= k 

            % second inner loops selects k values and calculates W(u)
        
            for i = 1:1:(ts + k)
            
                selected_y(i) = x(i);
                selected_t(i) = t(i);
                u = distance(ts,i)/max(distance(ts,:));
                W(i) = (1 - u^3)^3;

            end

        elseif length(t) - ts <= k

            for i = (ts - k):1:length(t)
                
                selected_y(i - ts + k + 1) = x(i);
                selected_t(i - ts + k + 1) = t(i);
                u = distance(ts, i - ts + k + 1)/max(distance(ts,:));
                W(i - ts + k + 1) = (1 - u^3)^3;

            end

        else

            for i = -k:1:k
                
                m = min(distance(ts, :));
                selected_y(i + k + 1) = x(find(distance(ts,:) == m) + i);
                selected_t(i + k + 1) = t(find(distance(ts,:) == m) + i);
                u = distance(ts, i + k + 1)/max(distance(ts,:));
                W(i + k + 1) = (1 - u^3)^3;

            end

        end

        selected_y = selected_y(:);
        selected_t = selected_t(:);
        W = W(:);
        
        % third step is to calculate the smoothed point

        % No need to ask he's a smooth operator - smooth operator - ...
        
        f = fit(selected_t, selected_y, 'poly2', 'Weights', W);
        smooth_y(ts) = f(t(ts));
       
    end

    % Coast to coast, LA to Chicago ...

    Ts = t;

end