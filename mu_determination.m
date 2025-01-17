function [mu, x1] = mu_determination(t,x)

    % linearize bacterial growth

    ln_x = log(x);

    mu = (ln_x(end) - ln_x(1)) / (t(end) - t(1));

    x1 = x(1);

end