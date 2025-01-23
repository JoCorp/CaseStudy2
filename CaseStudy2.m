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

load('data_set_2.mat');

% plot the results
ln_bio_r = log(bio_r);

figure(4)
subplot(2, 1, 1);
plot(time,bio_r,'or','MarkerSize', 5)
set(gca, 'color', 'w') % this is only necessary if you're using the dark mode...
title('Visualisation of the bacterial growth')
xlabel('time')
ylabel('Biomass')
ylim([0 3]);
xlim([0 13]);
subplot(2, 1, 2);
plot(time,ln_bio_r,'ob','MarkerSize', 5)
title('Visualisation of the linearlised bacterial growth')
set(gca, 'color', 'w') % this is only necessary if you're using the dark mode...
xlabel('time')
ylabel('Logarithmic biomass')
ylim([-1.5 1.5]);
xlim([0 13]);



%% Task 2.2

% import data_set_2

load('data_set_2.mat');
% select index of time for exponential
ti = find(time == 3.75);
tf = find(time == 10);
time_mu = time(ti:tf,:);
bio_r_mu = bio_r(ti:tf,:);


% determine mu in data set 2

[mu] = mu_determination(time_mu,bio_r_mu);
growth_rate = mu';
average_mu = mean(growth_rate);

figure(5)
plot(time_mu, growth_rate, '-b', 'MarkerSize', 10)
set(gca, 'color', 'w') % this is only necessary if you're using the dark mode...
hold on 
yline(average_mu, '-r')
title('Growth rate determination')
legend('Growth rate', 'Average growth rate');
xlabel('time')
ylabel('Bacterial population')
xlim([3.75 10]);


%% Task 3.1.

% show influence of alpha
load('data_set_2.mat');
alpha= 0:0.01:1;

k = alpha*length(time);
nachbarn = abs(ts-time);
nachbarn_max = max(nachbarn);
ind = 1:1:k;
neighbours_k = [ind, nachbarn(1:k)];

u = nachbarn/nachbarn_max;
w = @u (1- u^3)^3;
fit(time,bio_r, poly2, 'Weights', w )





% % make sure to install curve fitting toolbox
% 
% for k = 1:1:4
% 
%     [Ts(k,:), Xs(k,:)] = smoother(time, bio_r, k);
% 
% end
% 
% figure(8)
% plot(time, bio_r, '.k', Ts(1,:), Xs(1,:), '-c', Ts(2,:), Xs(2,:), '-g', ...
%     Ts(3,:), Xs(3,:), '-y', Ts(4,:), Xs(4,:), '-r')
% set(gca, 'color', 'w') % this is only necessary if you're using the dark mode...
% title('Smoothed data fit')
% legend('Original data set', 'k = 1', 'k = 2', 'k = 3', 'k = 4')
% xlabel('time')
% ylabel('Bacterial population')

%% Task 3.2.

% calculate first derivative

for k = 1:1:4
    
    fbar_y(k,:) = differentiator(Ts(k,:), Xs(k,:));

end

figure(9)
plot(Ts(1,:), Xs(1,:), '-c', Ts(2,:), Xs(2,:), '-g', Ts(3,:), Xs(3,:), '-y', Ts(4,:), Xs(4,:), '-r', ...
    Ts(1,:), fbar_y(1,:), '.c', Ts(2,:), fbar_y(2,:), '.g', Ts(3,:), fbar_y(3,:), '.y', Ts(4,:), fbar_y(4,:), '.r')
set(gca, 'color', 'w') % this is only necessary if you're using the dark mode...
title('Numerical differentiation')
legend('smoothed data fit, k = 1', 'smoothed data fit, k = 2', 'smoothed data fit, k = 3', 'smoothed data fit, k = 4', ...
    'numeric differentiation, k = 1', 'numeric differentiation, k = 2', 'numeric differentiation, k = 3', 'numeric differentiation, k = 4')
xlabel('time')
ylabel('Bacterial population')