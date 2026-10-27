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

x_rect = abs(st);

yt_envo = zeros(1, N);
yt_envo(1) = x_rect(1);

alpha = 0.95;

for i = 2:N
    if x_rect(i) > yt_envo(i-1)
        yt_envo(i) = x_rect(i);
    else
        yt_envo(i) = alpha*yt_envo(i-1);
    end
end

yt_envo = yt_envo - mean(yt_envo);

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
plot(t, x_rect, 'b', 'LineWidth', 1)
grid on
title('|s(t)|')
xlabel('t (sec)')
ylabel('Amplitude')

subplot(4,2,6)
plot(f, abs(fftshift(fft(x_rect))), 'r', 'LineWidth', 1)
grid on
title('||S(f)||')
xlabel('f (Hz)')
ylabel('Magnitude')
xlim([-fc-3e4 fc+3e4])

subplot(4,2,7)
plot(t, yt_envo, 'b', 'LineWidth', 1)
grid on
title('y_{Envelope}(t)')
xlabel('t (sec)')
ylabel('Amplitude')

subplot(4,2,8)
plot(f, abs(fftshift(fft(yt_envo))), 'r', 'LineWidth', 1)
grid on
title('|Y_{Envelope}(f)|')
xlabel('f (Hz)')
ylabel('Magnitude')
xlim([-fc-3e4 fc+3e4])

sgtitle('Lab 4 Demo: AM Modulation and Envelope (Diode) Detector')
