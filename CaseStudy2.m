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
f_ln = fit(time, ln_bio_r, 'poly1');
ln_bio_r_fitted = f_ln(time);

figure(4)
subplot(2, 1, 1);
plot(time,bio_r,'or','MarkerSize', 5)
title('Visualisation of the bacterial growth')
xlabel('time')
ylabel('Biomass')
ylim([0 3]);
xlim([0 13]);
subplot(2, 1, 2);
plot(time,ln_bio_r,'ob','MarkerSize', 5)
hold on
plot(time, ln_bio_r_fitted, '-r', 'LineWidth', 1.5)
title('Visualisation of the linearlised bacterial growth')
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
% average_mu = mean(growth_rate); 
% i added abs as direction od growth rate should not matter without it the smpoth and noisy data show same avg

figure(5)
plot(time_mu, growth_rate, '-b', 'MarkerSize', 10)
hold on 
yline(average_mu, '-r')
title('Growth rate determination')
legend('Growth rate', 'Average growth rate');
xlabel('time')
ylabel('Bacterial population')
xlim([3.75 10]);


%% Task 3.1.

load('data_set_2.mat');

% single alpha value
figure(6);
title('Visualisation of the Bacterial Growth');
xlabel('Time');
ylabel('Biomass');
ylim([0 3]);
xlim([0 13]);
plot(time, bio_r, 'or', 'MarkerSize', 5, 'DisplayName', 'Original Data');
hold on;
% a = 0.25;
% a = 0.33;
a = 0.50;
% a = 0.75;
[t_s, y_smooth] = smooth_operator(time, bio_r, a);
plot(t_s, y_smooth, '-b', 'LineWidth', 1.5, 'DisplayName', sprintf('Smoothed Data (a=%.2f)', a));
% legend('show');
hold off;

% BASICALLY THE MU PLOT FROM TASK 2.2
% a = 0.25;
% a = 0.33;
a = 0.50;
% a = 0.75;
[time_mu_smooth, bio_r_mu_smooth] = smooth_operator(time_mu, bio_r_mu, a);
% plot(time_mu_smooth, bio_r_mu_smooth, '-b', 'LineWidth', 1.5, 'DisplayName', sprintf('Smoothed Data (a=%.2f)', a));
% legend('show');

[mu_smooth] = mu_determination(time_mu_smooth,bio_r_mu_smooth);
growth_rate_smooth = mu_smooth';
average_mu_smooth = mean(growth_rate_smooth);

figure(7)
hold on
plot(time_mu, growth_rate,'-b', 'MarkerSize', 15)
yline(average_mu, '-r')
plot(time_mu_smooth, growth_rate_smooth,'--k', 'MarkerSize', 15)
yline(average_mu_smooth, '--g')
title('Growth rate determination')
legend('Growth rate', 'Average growth rate', ' Smoothed growth rate', 'Smoothed average growth rate');
xlabel('time')
ylabel('Bacterial population')
xlim([3.75 10]);
hold off


%% Task 3.2.

diff_noisy = differentiator(time, bio_r);
mu_noisy = diff_noisy./bio_r';
diff_smooth_numeric = differentiator(t_s, y_smooth);
mu_smooth_numeric = diff_smooth_numeric./y_smooth;
avg_mu_noisy = mean(mu_noisy);
avg_mu_smooth_numeric = mean(mu_smooth_numeric);

figure(8)
plot(time, mu_noisy, time, mu_smooth_numeric)
title('Numerical differentiation')
legend('noisy data','smoothed data')
xlabel('time')
ylabel('Bacterial population')
xlim([3 10]);