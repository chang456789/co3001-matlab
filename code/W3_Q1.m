clc; clear; close all;

fs = 100e3;
dt = 1/fs;
t = -0.25 : dt : 0.25-dt;

x1 = 1*sin(2*pi*10*t);
x2 = 0.8*sin(2*pi*40*t);
x3 = 0.5*sin(2*pi*90*t);
x = x1 + x2 + x3;

N = length(t);
f = (-N/2:N/2-1)*fs/N;
X = abs(fftshift(fft(x)));

figure
subplot(3,1,1)
plot(t, x1, 'b-', 'LineWidth', 1)
hold on
plot(t, x2, 'r--', 'LineWidth', 1)
plot(t, x3, 'k:', 'LineWidth', 1.5)
hold off
grid on
legend('x_1 (10 Hz)', 'x_2 (40 Hz)', 'x_3 (90 Hz)')
title('x_1, x_2, x_3')
xlabel('t (sec)')
ylabel('Amplitude (V)')

subplot(3,1,2)
plot(t, x, 'b', 'LineWidth', 1)
grid on
title('x(t) = x_1 + x_2 + x_3')
xlabel('t (sec)')
ylabel('Amplitude (V)')

subplot(3,1,3)
plot(f, X, 'r', 'LineWidth', 1)
grid on
xlim([-150 150])
title('|X(f)|')
xlabel('f (Hz)')
ylabel('Magnitude')

sgtitle('Lab 2 Q1: Sum of Sinusoids and Spectrum')
