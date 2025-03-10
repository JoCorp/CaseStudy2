function [Ts, Xs] = smoother (t, x, k)

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
            
                selected_y(ts, i) = x(i);
                selected_t(ts, i) = t(i);
                u = distance(ts,i)/max(distance(ts,:));
                W(ts,i) = (1 - u^3)^3;

            end

        elseif length(t) - ts <= k

            for i = (ts - k):1:length(t)
                
                selected_y(ts, i - ts + k + 1) = x(i);
                selected_t(ts, i - ts + k + 1) = t(i);
                u = distance(ts, i - ts + k + 1)/max(distance(ts,:));
                W(ts, i - ts + k + 1) = (1 - u^3)^3;

            end

        else

            for i = -k:1:k
                
                m = min(distance(ts, :));
                selected_y(ts, i + k + 1) = x(find(distance(ts,:) == m) + i);
                selected_t(ts, i + k + 1) = t(find(distance(ts,:) == m) + i);
                u = distance(ts, i + k + 1)/max(distance(ts,:));
                W(ts, i + k + 1) = (1 - u^3)^3;

            end

        end

    end

    % flatten arrays
    
    flat_t = selected_t(:);
    flat_y = selected_y(:);
    flat_W = W(:);

    % call fit

    f = fit(flat_t, flat_y, 'poly2', 'Weights', flat_W); % I know we were told to use a polynomial fit  of order 2 but that does not make any sense with this dataset

    % get coefficients

    p = coeffvalues(f);

    % calculate Xs

    Ts = linspace(1,12,100);
    
    for ts = 1:1:length(Ts)
    
        Xs(ts) = p(1) * exp(p(2) * Ts(ts));
 
    end

end