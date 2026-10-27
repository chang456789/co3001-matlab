clc; clear; close all;

fs = 1e6;
t = -0.0005+1/fs : 1/fs : 0.0005;

N = length(t);
f = (-N/2:N/2-1)*fs/N;

mt = 2.2*sin(2*pi*4e3*t) + 1.8*sin(2*pi*8e3*t);

Ac = 2;
fc = 1e5;
Ka = 0.6;
ct = Ac*cos(2*pi*fc*t);

st = Ac*(1 + Ka*mt).*ct;

et = st.*ct;

lpf = sinc(2.5*8e3*t)/N*(2.5*8e3)/2;

yt = conv(et, lpf, 'same');
yt = yt - mean(yt);

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
xlim([-2*fc-3e4 2*fc+3e4])

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
xlim([-2*fc-3e4 2*fc+3e4])

subplot(4,2,5)
plot(t, et, 'b', 'LineWidth', 1)
grid on
title('e(t) = s(t)*c(t)')
xlabel('t (sec)')
ylabel('Amplitude')

subplot(4,2,6)
plot(f, abs(fftshift(fft(et))), 'r', 'LineWidth', 1)
hold on
plot(f, abs(fftshift(fft(lpf))) / max(abs(fftshift(fft(lpf)))) * max(abs(fftshift(fft(et)))) / 2, 'k', 'LineWidth', 1)
hold off
grid on
title('|E(f)| & |H_{LPF}(f)|')
xlabel('f (Hz)')
ylabel('Magnitude')
xlim([-2*fc-3e4 2*fc+3e4])

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
xlim([-2*fc-3e4 2*fc+3e4])

sgtitle('Lab 4 HW2: Synchronous Demodulation (Ka = 0.6)')

x_rect = abs(st);
alpha = 0.95;
yt_envo = zeros(1, N);
yt_envo(1) = x_rect(1);
for i = 2:N
    if x_rect(i) > yt_envo(i-1)
        yt_envo(i) = x_rect(i);
    else
        yt_envo(i) = alpha*yt_envo(i-1);
    end
end
yt_env = yt_envo - mean(yt_envo);

figure
subplot(3,1,1)
plot(t, st, 'b', 'LineWidth', 1)
hold on
plot(t, yt_envo, 'k', 'LineWidth', 1.5)
hold off
grid on
legend('s(t)', 'envelope')
title('s(t) and Detected Envelope')
xlabel('t (sec)')
ylabel('Amplitude')

subplot(3,1,2)
plot(t, x_rect, 'b', 'LineWidth', 1)
hold on
plot(t, yt_envo, 'k', 'LineWidth', 1.5)
hold off
grid on
legend('|s(t)|', 'peak tracking')
title('Rectified Signal and Peak Tracking')
xlabel('t (sec)')
ylabel('Amplitude')

subplot(3,1,3)
plot(t, mt/max(abs(mt)), 'r--', 'LineWidth', 1)
hold on
plot(t, yt_env/max(abs(yt_env)), 'b', 'LineWidth', 1)
hold off
grid on
legend('m(t) (normalized)', 'y_{env}(t) (normalized)')
title('Envelope Detector Output vs m(t)')
xlabel('t (sec)')
ylabel('Normalized Amplitude')
sgtitle('Lab 4 HW2: Envelope Detector (Ka = 0.6)')
