clc; clear; close all;

fs = 100e3;
dt = 1/fs;
t = -0.2 : dt : 0.2-dt;

x1 = 1.0*sin(2*pi*3*t);
x2 = 0.8*sin(2*pi*5*t);
x3 = 0.5*sin(2*pi*7*t);
x_sum = x1 + x2 + x3;

figure
subplot(2,1,1)
plot(t, x1, 'b-', 'LineWidth', 1)
hold on
plot(t, x2, 'r--', 'LineWidth', 1)
plot(t, x3, 'k:', 'LineWidth', 1.5)
hold off
grid on
legend('x_1 (3 Hz)', 'x_2 (5 Hz)', 'x_3 (7 Hz)')
title('Three Sinusoids')
xlabel('t (sec)')
ylabel('Amplitude')

subplot(2,1,2)
plot(t, x_sum, 'b', 'LineWidth', 1)
grid on
legend('x_{sum} = x_1 + x_2 + x_3')
title('Sum of Three Sinusoids')
xlabel('t (sec)')
ylabel('Amplitude')

sgtitle('Lab 1 Q2: Time Vector and Sinusoids')
