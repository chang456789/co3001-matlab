clc; clear; close all;

fs = 1e6;
t = -0.0005+1/fs : 1/fs : 0.0005;

N = length(t);
f = (-N/2:N/2-1)*fs/N;

mt = 2.2*sin(2*pi*4e3*t) + 1.8*sin(2*pi*8e3*t);

Ac = 2;
fc = 1e5;
Ka = 0.2;
ct = Ac*cos(2*pi*fc*t);

st = Ac*(1 + Ka*mt).*ct;

figure

subplot(2,2,1)
plot(t, mt, 'b', 'LineWidth', 1)
grid on
title('m(t)')
xlabel('t (sec)')
ylabel('Amplitude')

subplot(2,2,2)
plot(f, abs(fftshift(fft(mt))), 'r', 'LineWidth', 1)
grid on
title('|M(f)|')
xlabel('f (Hz)')
ylabel('Magnitude')
xlim([-2*fc-3e4 2*fc+3e4])

subplot(2,2,3)
plot(t, st, 'b', 'LineWidth', 1)
grid on
title('s(t)')
xlabel('t (sec)')
ylabel('Amplitude')

subplot(2,2,4)
plot(f, abs(fftshift(fft(st))), 'r', 'LineWidth', 1)
grid on
title('|S(f)|')
xlabel('f (Hz)')
ylabel('Magnitude')
xlim([-2*fc-3e4 2*fc+3e4])

sgtitle('Lab 4 Q1: AM Modulation (Ka = 0.2)')
