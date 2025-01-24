% function [Ts, smooth_y] = smooth_operator (t, x, alpha)
% 
%     % no place for beginners or sensitive heaaaarts ...
% 
%     % calculate k based on alpha and n
% 
%         % according to wikipedia k has to be rounded UP to the next largest
%         % integer
% 
%         k = ceil(alpha*length(t));
% 
%     % calculate distance and select values
% 
%     % outer loop goes through al ts
% 
%     for ts = 1:1:length(t)
% 
%         % first inner loop determines the distance from neighbours
% 
%         for i = 1:1:length(t)
% 
%             distance(ts, i) = abs(t(ts) - t(i));
% 
%         end
% 
%         % determine if neighbourhood is symmetric
% 
%         if ts <= k 
% 
%             % second inner loops selects k values and calculates W(u)
% 
%             for i = 1:1:(ts + k)
% 
%                 selected_y(i) = x(i);
%                 selected_t(i) = t(i);
%                 u = distance(ts,i)/max(distance(ts,:));
%                 W(i) = (1 - u^3)^3;
% 
%             end
% 
%         elseif length(t) - ts <= k
% 
%             for i = (ts - k):1:length(t)
% 
%                 selected_y(i - ts + k + 1) = x(i);
%                 selected_t(i - ts + k + 1) = t(i);
%                 u = distance(ts, i - ts + k + 1)/max(distance(ts,:));
%                 W(i - ts + k + 1) = (1 - u^3)^3;
% 
%             end
% 
%         else
% 
%             for i = -k:1:k
% 
%                 m = min(distance(ts, :));
%                 selected_y(i + k + 1) = x(find(distance(ts,:) == m) + i);
%                 selected_t(i + k + 1) = t(find(distance(ts,:) == m) + i);
%                 u = distance(ts, i + k + 1)/max(distance(ts,:));
%                 W(i + k + 1) = (1 - u^3)^3;
% 
%             end
% 
%         end
% 
%         selected_y = selected_y(:);
%         selected_t = selected_t(:);
%         W = W(:);
% 
%         % third step is to calculate the smoothed point
% 
%         % No need to ask he's a smooth operator - smooth operator - ...
% 
%         f = fit(selected_t, selected_y, 'poly2', 'Weights', W);
%         smooth_y(ts) = f(t(ts));
% 
%     end
% 
%     % Coast to coast, LA to Chicago ...
% 
%     Ts = t;
% 
% end

function [Ts, smooth_y] = smooth_operator(t, x, alpha)
    % SMOOTH_OPERATOR applies tricube-weighted smoothing using the `fit` function.
    % INPUTS:
    %   t     - time values
    %   x     - observed values (biomass)
    %   alpha - smoothing parameter (fraction of neighbors to consider)
    %
    % OUTPUTS:
    %   Ts       - same as input time `t`
    %   smooth_y - smoothed values corresponding to `t`

    % Calculate the number of neighbors (k)
    k = ceil(alpha * length(t));

    % Initialize the output
    smooth_y = zeros(size(x));
    Ts = t; % Smoothed time matches input time

    % Loop over each time point to calculate smoothed value
    for ts = 1:length(t)
        % Calculate distances for all points from the current time point
        distances = abs(t - t(ts));
        
        % Sort distances and get indices of the k nearest neighbors
        [~, sorted_indices] = sort(distances);
        selected_indices = sorted_indices(1:min(k, length(t))); % Handle edge cases
        
        % Select corresponding time, values, and distances
        selected_t = t(selected_indices);
        selected_y = x(selected_indices);
        selected_distances = distances(selected_indices);
        
        % Calculate tricube weights
        u = selected_distances / max(selected_distances); % Normalize distances
        W = (1 - u.^3).^3; % Tricube weight function
        
        % Use `fit` for weighted quadratic polynomial fitting
        f = fit(selected_t, selected_y, 'poly2', 'Weights', W); % Fit quadratic
        
        % Evaluate the fitted model at the current time point
        smooth_y(ts) = f(t(ts));
    end
end
