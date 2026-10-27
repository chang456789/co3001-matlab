clc; clear; close all;

fs = 10e3;
dt = 1/fs;
t = -0.02 : dt : 0.02;

x1 = 4*sin(2*pi*6*t);
x2 = 2*sin(2*pi*4*t);
x3 = 1*sin(2*pi*2*t);
x_sum = x1 - x2 - x3;

figure
plot(t, x_sum, 'r-', 'LineWidth', 1.5)
grid on
legend('x_{sum}')
title('x_{sum} = x_1 - x_2 - x_3')
xlabel('Time (s)')
ylabel('Amplitude')
