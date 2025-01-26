clear all
close all
clc

% show influence of alpha
load('data_set_2.mat');


for i = 1:1:4

[Ts{i}, Xs{i}] = smooth_operator(time, bio_r, 0.25*i);

end



figure(1)
plot(time, bio_r, '.k', Ts{1}, Xs{1}, 'r', Ts{2}, Xs{2}, 'g', Ts{3}, Xs{3}, 'c', Ts{4}, Xs{4}, 'b')