function [et, ex] = exponential_selector(t,x,window, precision, allowed_outliers)

    % attempt to linearize potentially exponential data

    ln_x = log(x);

    % inititiate vector for μ

    mu = [];
    
    % calculate μ from slope between every two points

    for i = 1:1:(length(t) - 1)

    mu(i, 1) = (ln_x(i + 1) - ln_x(i)) / (t(i + 1) - t(i));

    end

    % check if μ is constant in the data set

    hit_position = [];

    hit_counter = 1;

    % first loop shifts the window

    for z = 0:1:window-1
    
        % outer loop runs through the complete set of μs

        for i = ((1 + round(window/2, TieBreaker="tozero"))+z):window:(length(ln_x) - 2) 

            % counter reset to 0 after checking each μ

            counter = 0;
            
            % when z is 4 loop has to be stopped when i is length(ln_x) - 6

            if z == window-1 & i <= (length(ln_x) - window+1)

                break

            end

            % inner loop checks the previous and the next two μs
            
            for j = -round(window/2, TieBreaker="tozero"):1:round(window/2, TieBreaker="tozero") 

                if j ~= 0

                    if abs(mu(i + j) - mu(i)) < abs(mu(i) * (1 - precision)) % this allows for x % deviation

                        counter = counter + 1;

                    end

                end

            end

            % check the amount of data points with approximately the same μ

            if counter >= allowed_outliers % this allows for x outliers
        
            % save mu

                for j = -round(window/2, TieBreaker="tozero"):1:round(window/2, TieBreaker="tozero") 
        
                    hits(hit_counter) = i - j;
                    hit_counter = hit_counter + 1;

                end

            end

        end

    end
 
    % sort hits

    hits = unique(sort(hits));

    % initialize counter, et & ex

    et{1}(1) = t(hits(1));
    ex{1}(1) = x(hits(1));
    exponential_segments_counter = 1;
    exponential_entry_counter = 2;

    % select hits
    
    for i = 2:1:(length(hits))

        % selects different exponential segments in different cell entries
        
        if hits(i - 1) + 1 ~= (hits(i))

            exponential_segments_counter = exponential_segments_counter + 1;
            exponential_entry_counter = 1;

        end

        et{exponential_segments_counter}(exponential_entry_counter) = t(hits(i));
        ex{exponential_segments_counter}(exponential_entry_counter) = x(hits(i));
        exponential_entry_counter = exponential_entry_counter + 1;

    end

end