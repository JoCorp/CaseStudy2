%% main script

% Task 1.

% Task 1.1.

clear all
close all
clc

% import data_set_1

load('data_set_1.mat');

% insepction of data_set_1.mat

figure(1)
plot(x,y, '.r', 'MarkerSize', 10)
set(gca, 'color', 'w') % this is only necessary if you're using the dark mode...
title('Data Set 1')
xlabel('x')
ylabel('y')

% linear interpolation using own function

stepsize = 10;

[x_olinint, y_olinint] = linearInterpolation(x,y, stepsize);

% linear interpolation using matlab function 

x_mlinint = linspace(x(1),x(end), length(x)*stepsize);
y_mlinint = interp1(x,y,x_mlinint);

figure(2)
plot(x_mlinint, y_mlinint, '-g', x_olinint, y_olinint, '--b', x,y, '.r', 'MarkerSize', 10)
set(gca, 'color', 'w') % this is only necessary if you're using the dark mode...
title('Linear interpolation')
legend('interp1', 'own function', 'Original data')
xlabel('x')
ylabel('y')




