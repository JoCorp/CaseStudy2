function [mu, X_0] = mu_determination(t,x)

    % linearize exponential data

    ln_x = log(x);

    % calculate μ from slope

    mu = (ln_x(end) - ln_x(1)) / (t(end) - t(1));

    % get X_0 from original data set

    X_0 = x(1);

end