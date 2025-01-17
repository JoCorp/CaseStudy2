% main script

% Task 1.

%% Task 1.1.

clear all
close all
clc

% import data_set_1

load('data_set_1.mat');

% linear interpolation using own function

stepsize1_1 = 10;

[x_olinint, y_olinint] = linearInterpolation(x,y, stepsize1_1);

% linear interpolation using matlab function 

x_mlinint = linspace(x(1),x(end), length(x)*stepsize1_1);
y_mlinint = interp1(x,y,x_mlinint);

figure(1)
plot(x_mlinint, y_mlinint, '-g', x_olinint, y_olinint, '--b', x,y, '.r', 'MarkerSize', 10)
set(gca, 'color', 'w') % this is only necessary if you're using the dark mode...
title('Linear interpolation')
legend('interp1', 'own function', 'Original data')
xlabel('x')
ylabel('y')

%% Task 1.2.

% create test data set tx and ty

tx = [0 1 3];
ty = [1 3 2];

% test function with test data

stepsize1_2 = 20;

[x_tpolint, y_tpolint] = polynomialInterpolation(tx, ty, stepsize1_2);

% plot the results

figure(2)
plot(x_tpolint, y_tpolint, '-b',  tx, ty, '.r', 'MarkerSize', 10)
set(gca, 'color', 'w') % this is only necessary if you're using the dark mode...
title('Polynomial interpolation')
legend('Lagrange polynomial', 'Test data set')
xlabel('x')
ylabel('y')

% testing with data set 1

% setting specified limit

xpol = x(1:1:21);
ypol = y(1:1:21);

[x_opolint, y_opolint] = polynomialInterpolation(xpol, ypol, stepsize1_2);

% plot the results

figure(3)
plot(x_opolint, y_opolint, '--b', xpol, ypol, '.r', 'MarkerSize', 10)
set(gca, 'color', 'w') % this is only necessary if you're using the dark mode...
title('Polynomial interpolation')
legend('Lagrange polynomial', 'data set 1')
xlim([-2 0])
ylim([-15 15])
xlabel('x')
ylabel('y')

%% Task 2.1.

% create test_data_set

tt = [0 1 2 3 4 5];
tx = [2];

for i = 2:1:length(tt)
    
    tx(i) = tx(1)*exp(0.5 * tt(i));

end

% Give time dependent function

sprintf('X(t) = X_0 * e(μ*t) \n \nln(X(t)) = ln(X_0) + μt')

% determine mu in test data set

[mu, cx0] = mu_determination(tt,tx);

% calculate data with determined mu

cx = [cx0];

for i = 2:1:length(tt)
    
    cx(i) = cx(1) * exp(mu * tt(i));

end

% plot the results

figure(4)
plot(tt, tx, '.b', tt, cx, '-r', 'MarkerSize', 10)
set(gca, 'color', 'w') % this is only necessary if you're using the dark mode...
title('Growth rate determination')
legend('test data', 'calculated data points')
xlabel('time')
ylabel('Bacterial population')

%% import data_set_2

load('data_set_2.mat');

% plot the results

figure(4)
plot(time, bio_r, '.b')
set(gca, 'color', 'w') % this is only necessary if you're using the dark mode...
title('Bacterial growth')
legend('data set 2')
xlabel('time')
ylabel('Bacterial population')