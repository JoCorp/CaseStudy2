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
title('Visualisation of the bacterial growth')
xlabel('time')
ylabel('Biomass')
ylim([0 3]);
xlim([0 13]);
subplot(2, 1, 2);
plot(time,ln_bio_r,'ob','MarkerSize', 5)
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

figure(5)
plot(time_mu, growth_rate, '-b', 'MarkerSize', 10)
hold on 
yline(average_mu, '-r')
title('Growth rate determination')
legend('Growth rate', 'Average growth rate');
xlabel('time')
ylabel('Growth rate')
xlim([3.75 10]);


%% Task 3.1.

load('data_set_2.mat');

for i = 1:1:4

[Ts{i}, Xs{i}] = smooth_operator(time, bio_r, 0.25*i);
[smoothed_mu{i}] = mu_determination(Ts{i}, Xs{i});
average_smu(i) = mean(smoothed_mu{i});

end


figure(6)
plot(time, bio_r, '.k', Ts{1}, Xs{1}, 'r', Ts{2}, Xs{2}, 'g', Ts{3}, Xs{3}, 'c', Ts{4}, Xs{4}, 'b')
title('Smoothened data');
legend('original data', 'α = 0.25', 'α = 0.50', 'α = 0.75', 'α = 1.00')
set(gca, 'color', 'w') % this is only necessary if you're using the dark mode...
xlabel('Time');
ylabel('Biomass');
ylim([0 3]);
xlim([0 12]);

figure(7)
sgtitle('Growth rate of smoothened data')
subplot(2,2,1)
plot(time_mu, growth_rate, '-k', Ts{1}, smoothed_mu{1}, '-r')
set(gca, 'color', 'w') % this is only necessary if you're using the dark mode...
hold on 
yline(average_smu(1), '-m')
title('α = 0.25')
legend('original data', 'smoothed data with α = 0.25', 'Average growth rate of smoothed data');
xlabel('time')
ylabel('Growth rate')
xlim([3.75 10]);
subplot(2,2,2)
plot(time_mu, growth_rate, '-k', Ts{2}, smoothed_mu{2}, '-g')
set(gca, 'color', 'w') % this is only necessary if you're using the dark mode...
hold on 
yline(average_smu(2), '-m')
title('α = 0.50')
legend('original data', 'smoothed data with α = 0.50', 'Average growth rate of smoothed data');
xlabel('time')
ylabel('Growth rate')
xlim([3.75 10]);
subplot(2,2,3)
plot(time_mu, growth_rate, '-k', Ts{3}, smoothed_mu{3}, '-c')
set(gca, 'color', 'w') % this is only necessary if you're using the dark mode...
hold on 
yline(average_smu(3), '-m')
title('α = 0.75')
legend('original data', 'smoothed data with α = 0.75', 'Average growth rate of smoothed data');
xlabel('time')
ylabel('Growth rate')
xlim([3.75 10]);
subplot(2,2,4)
plot(time_mu, growth_rate, '-k', Ts{4}, smoothed_mu{4}, '-b')
set(gca, 'color', 'w') % this is only necessary if you're using the dark mode...
hold on 
yline(average_smu(4), '-m')
title('α = 1.00')
legend('original data', 'smoothed data with α = 1.00', 'Average growth rate of smoothed data');
xlabel('time')
ylabel('Growth rate')
xlim([3.75 10]);


%% Task 3.2.

diff_noisy = differentiator(time, bio_r);
mu_noisy = diff_noisy./bio_r';

for i = 1:1:4

diff_smooth_numeric(i,:) = differentiator(Ts{i}, Xs{i});
mu_smooth_n{i} = diff_smooth_numeric(i,:)./Xs{i};
avg_mu_smooth_n{i} = mean(mu_smooth_n{i});

end

figure(8)
sgtitle('Numerical differentiation')
subplot(2,2,1)
plot(time, mu_noisy, 'k', time , mu_smooth_n{1}, 'r')
set(gca, 'color', 'w') % this is only necessary if you're using the dark mode...
hold on 
yline(avg_mu_smooth_n{1}, '-m')
title('α = 0.25')
legend('noisy data','smoothed data', 'average growth rate')
xlabel('time')
ylabel('Growth rate')
subplot(2,2,2)
plot(time, mu_noisy, 'k', time , mu_smooth_n{2}, 'g')
set(gca, 'color', 'w') % this is only necessary if you're using the dark mode...
hold on 
yline(avg_mu_smooth_n{2}, '-m')
title('α = 0.50')
legend('noisy data','smoothed data', 'average growth rate')
xlabel('time')
ylabel('Growth rate')
subplot(2,2,3)
plot(time, mu_noisy, 'k', time , mu_smooth_n{3}, 'c')
set(gca, 'color', 'w') % this is only necessary if you're using the dark mode...
hold on 
yline(avg_mu_smooth_n{3}, '-m')
title('α = 0.75')
legend('noisy data','smoothed data', 'average growth rate')
xlabel('time')
ylabel('Growth rate')
subplot(2,2,4)
plot(time, mu_noisy, 'k', time , mu_smooth_n{4}, 'b')
set(gca, 'color', 'w') % this is only necessary if you're using the dark mode...
hold on 
yline(avg_mu_smooth_n{4}, '-m')
title('α = 1.00')
legend('noisy data','smoothed data', 'average growth rate')
xlabel('time')
ylabel('Growth rate')