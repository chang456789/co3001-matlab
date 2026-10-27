clc; clear; close all;

fs = 240e3;
dt = 1/fs;
t = -0.002 : dt : 0.002-dt;

f0 = 2e3;
y = sin(2*pi*f0*t);

fs_num = [1e3 3e3 4e3 5e3 8e3];
y_sample = zeros(length(fs_num), length(t));
for i = 1:length(fs_num)
    n = round(fs/fs_num(i));
    idx = 1:n:length(t);
    y_sample(i, idx) = y(idx);
end

N = length(y);
f = (-N/2:N/2-1)*fs/N;

h_lpf = sinc(2.1*f0*t)/N*(2.1*f0)/2;

figure
subplot(length(fs_num)+1,4,1)
plot(t, y, 'b', 'LineWidth', 1)
grid on
xlim([min(t) max(t)])
title(['Original Signal, f_0 = ', num2str(f0), ' Hz'])
xlabel('t (sec)')
ylabel('Amp.')

subplot(length(fs_num)+1,4,2)
plot(f, abs(fftshift(fft(y))), 'r', 'LineWidth', 1)
hold on
plot(f, abs(fftshift(fft(h_lpf)))./max(abs(fftshift(fft(h_lpf)))) .* max(abs(fftshift(fft(y)))), 'k', 'LineWidth', 1)
grid on
xlim(6*[-f0 f0])
title('Freq. Response of Original Signal and LPF')
xlabel('f (Hz)')
ylabel('|X(f)| & |H_{LPF}(f)|')
hold off

y_lpf = zeros(length(fs_num)+1, length(t));
y_lpf(1,:) = conv(y, h_lpf, 'same');

subplot(length(fs_num)+1,4,3)
plot(f, abs(fftshift(fft(y_lpf(1,:)))), 'r', 'LineWidth', 1)
grid on
xlim(6*[-f0 f0])
title('Freq. Response of Original Signal Passing LPF')
xlabel('f (Hz)')
ylabel('|Y(f)|')

subplot(length(fs_num)+1,4,4)
plot(t, y_lpf(1,:), 'b', 'LineWidth', 1)
grid on
xlim([min(t) max(t)])
title('Reduction Signal')
xlabel('t (sec)')
ylabel('Amp.')

for i = 1:length(fs_num)
    subplot(length(fs_num)+1,4,4*i+1)
    stem(t, y_sample(i,:), 'filled', 'b', 'LineWidth', 1)
    grid on
    xlim([min(t) max(t)])
    ylim([-1.1 1.1])
    xlabel('t (sec)')
    ylabel('Amp.')
    title(['Sampled Signal, f_s = ', num2str(fs_num(i)), ' Hz'])

    subplot(length(fs_num)+1,4,4*i+2)
    plot(f, abs(fftshift(fft(y_sample(i,:)))), 'r', 'LineWidth', 1)
    hold on
    plot(f, abs(fftshift(fft(h_lpf)))./max(abs(fftshift(fft(h_lpf)))) .* max(abs(fftshift(fft(y_sample(i,:))))), 'k', 'LineWidth', 1)
    grid on
    xlim(6*[-f0 f0])
    xlabel('f (Hz)')
    ylabel('|X_s(f)| & |H_{LPF}(f)|')
    title('Freq. Response of Sampled Signal and LPF')
    hold off

    y_lpf(i+1,:) = conv(y_sample(i,:), h_lpf, 'same');

    subplot(length(fs_num)+1,4,4*i+3)
    plot(f, abs(fftshift(fft(y_lpf(i+1,:)))), 'r', 'LineWidth', 1)
    grid on
    xlim(6*[-f0 f0])
    xlabel('f (Hz)')
    ylabel('|Y_s(f)|')
    title('Freq. Response of Sampled Signal Passing LPF')

    subplot(length(fs_num)+1,4,4*i+4)
    plot(t, y_lpf(i+1,:), 'b', 'LineWidth', 1)
    grid on
    xlim([min(t) max(t)])
    xlabel('t (sec)')
    ylabel('Amp.')
    title(['Reduction Signal, f_s = ', num2str(fs_num(i)), ' Hz'])
end
sgtitle('Lab 3 Q1: Nyquist Sampling and Reconstruction')
