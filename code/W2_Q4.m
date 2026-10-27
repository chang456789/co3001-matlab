clc; clear; close all;

fs = 100e3;
dt = 1/fs;
t = -20 : dt : 20-dt;

a = [1 2 0.5];
x = zeros(length(a), length(t));
for k = 1:length(a)
    x(k,:) = sin(pi*a(k)*t) ./ (pi*a(k)*t);
    x(k, t == 0) = 1;
end

N = length(t);
f = (-N/2:N/2-1)*fs/N;

figure
for k = 1:length(a)
    subplot(3,1,k)
    plot(f, abs(fftshift(fft(x(k,:)))), 'r', 'LineWidth', 1)
    grid on
    xlim([-0.5 0.5])
    title(['|X(f)| of sinc(', num2str(a(k)), 't)'])
    xlabel('f (Hz)')
    ylabel('Magnitude')
end
sgtitle('Lab 1 Q4: FFT of sinc Waves')
