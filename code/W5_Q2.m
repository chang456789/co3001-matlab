clc; clear; close all;

fs = 1e6;
t = -0.0005+1/fs:1/fs:0.0005;

mt = 2.2*sin(2*pi*4e3*t) + 1.8*sin(2*pi*8e3*t);

Ac = 2;
fc = 1e5;
ct = Ac*cos(2*pi*fc*t);

Ka = 0.2;

st = Ac*(1 + Ka*mt).*ct;

N = length(t);
f = (-N/2:N/2-1)*fs/N;

et = st .* ct;

lpf = sinc(2.5*8e3*t)/N*(2.5*8e3)/2;
dt = conv(et, lpf, 'same');

yt = dt - mean(dt);

figure

subplot(4,2,1)
plot(t, mt, 'b', 'LineWidth', 1)
grid on
title('m(t)')
xlabel('t (sec)')
ylabel('Amplitude')

subplot(4,2,2)
plot(f, abs(fftshift(fft(mt))), 'r', 'LineWidth', 1)
grid on
title('|M(f)|')
xlabel('f (Hz)')
ylabel('Magnitude')
xlim([-fc-3e4 fc+3e4])

subplot(4,2,3)
plot(t, st, 'b', 'LineWidth', 1)
grid on
title('s(t)')
xlabel('t (sec)')
ylabel('Amplitude')

subplot(4,2,4)
plot(f, abs(fftshift(fft(st))), 'r', 'LineWidth', 1)
grid on
title('|S(f)|')
xlabel('f (Hz)')
ylabel('Magnitude')
xlim([-fc-3e4 fc+3e4])

subplot(4,2,5)
plot(t, et, 'b', 'LineWidth', 1)
grid on
title('e(t) = s(t)*c(t)')
xlabel('t (sec)')
ylabel('Amplitude')

subplot(4,2,6)
plot(f, abs(fftshift(fft(et))), 'r', 'LineWidth', 1)
hold on
plot(f, abs(fftshift(fft(lpf))) / max(abs(fftshift(fft(lpf)))) * max(abs(fftshift(fft(et)))) /2, ...
    'k', 'LineWidth', 1)
hold off
grid on
title('|E(f)|')
xlabel('f (Hz)')
ylabel('Magnitude')
xlim([-fc-3e4 fc+3e4])

subplot(4,2,7)
plot(t, yt, 'b', 'LineWidth', 1)
grid on
title('y(t)')
xlabel('t (sec)')
ylabel('Amplitude')

subplot(4,2,8)
plot(f, abs(fftshift(fft(yt))), 'r', 'LineWidth', 1)
grid on
title('|Y(f)|')
xlabel('f (Hz)')
ylabel('Magnitude')
xlim([-fc-3e4 fc+3e4])

sgtitle('Lab 4 Q2: AM Modulation and Synchronous Demodulation')
