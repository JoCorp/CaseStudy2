function [Ts, smooth_y] = smooth_operator(t, x, alpha)
  
% according to wikipedia k has to be rounded UP to the next largest
% integer
    k = ceil(alpha * length(t));
    smooth_y =[];
    Ts = t;

    for ts = 1:length(t)
        distances = abs(t - t(ts));
        % we get the index in output for easvh of the sorted normalised distances 
        [~, sorted_indices] = sort(distances); 
        select_indices = sorted_indices(1:k);
        
        selected_distances = distances(select_indices);
        selected_t = t(select_indices);
        X_s = x(select_indices);
        
        
        % Calculate tricube weights
        u = selected_distances / max(selected_distances); 
        W = (1 - u.^3).^3; 
        f = fit(selected_t, X_s, 'poly2', 'Weights', W); 
        % smoothened y values is the fitted value of y at t=ts
        smooth_y(ts) = f(t(ts));
    end
end
