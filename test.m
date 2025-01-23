clear all
close all
clc

% show influence of alpha
load('data_set_2.mat');

[Ts, Xs] = smooth_operator(time, bio_r, 0.1);

figure(1)
plot(time, bio_r, '-b', Ts, Xs, 'r')