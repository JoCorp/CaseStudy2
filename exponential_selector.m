function [et, ex, hits] = exponential_selector(t,x)

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

    for z = 0:1:4
    
        % outer loop runs through the complete set of μs

        for i = 3+z:5:(length(ln_x) - 2) 

            % counter reset to 0 after checking each μ

            counter = 0;
            
            % when z is 4 loop has to be stopped when i is length(ln_x) - 6

            if z == 4 & i <= (length(ln_x) - 6)

                break

            end

            % inner loop checks the previous and the next two μs
            
            for j = -2:1:2 

                if j ~= 0

                    if abs(mu(i + j) - mu(i)) < abs(mu(i) * 0.66) % this allows for 66% deviation

                        counter = counter + 1;

                    end

                end

            end

            % check the amount of data points with approximately the same μ

            if counter >= 2 % this allows for two outliers
        
            % save mu

                for j = -2:1:2 
        
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