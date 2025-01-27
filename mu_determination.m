function [mu] = mu_determination(t,x)

    % linearize exponential data 

    ln_x = log(x);
    X_0 = x(1);
  

    % calculate μ from slope
for i = 1:length(x)-1
    for j = 1:length(t)-1
    mu(i+1) = (ln_x(i+1) - ln_x(i)) / (t(j+1) - t(j));
    end
end
end