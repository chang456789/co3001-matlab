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

B = 22;
h_lpf = B*sinc(B*t)/fs;

y_lpf = conv(x, h_lpf, 'same');

figure
subplot(3,2,1)
plot(t, x, 'b', 'LineWidth', 1)
grid on
title('x(t)')
xlabel('t (sec)')
ylabel('Amplitude')

subplot(3,2,3)
plot(t, h_lpf, 'k', 'LineWidth', 1)
grid on
title('h_{lpf}(t)')
xlabel('t (sec)')
ylabel('Amplitude')

subplot(3,2,5)
plot(t, x, 'c:', 'LineWidth', 1)
hold on
plot(t, y_lpf, 'b', 'LineWidth', 1)
hold off
grid on
legend('x(t)', 'y_{lpf}(t)')
title('x(t) vs y_{lpf}(t)')
xlabel('t (sec)')
ylabel('Amplitude')

subplot(3,2,2)
plot(f, abs(fftshift(fft(x))), 'r', 'LineWidth', 1)
grid on
xlim([-150 150])
title('|X(f)|')
xlabel('f (Hz)')
ylabel('Magnitude')

subplot(3,2,4)
plot(f, abs(fftshift(fft(h_lpf))), 'k', 'LineWidth', 1)
grid on
xlim([-150 150])
title('|H_{lpf}(f)|')
xlabel('f (Hz)')
ylabel('Magnitude')

subplot(3,2,6)
plot(f, abs(fftshift(fft(y_lpf))), 'r', 'LineWidth', 1)
grid on
xlim([-150 150])
title('|Y_{lpf}(f)|')
xlabel('f (Hz)')
ylabel('Magnitude')

sgtitle('Lab 2 Q2: LPF by One sinc')
