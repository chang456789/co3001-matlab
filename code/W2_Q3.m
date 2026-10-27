clc; clear; close all;

fs = 100e3;
dt = 1/fs;
t = -20 : dt : 20-dt;

a = [1 2 0.5];
x = zeros(length(a), length(t));

for k = 1:length(a)
    for n = 1:length(t)
        if t(n) == 0
            x(k,n) = 1;
        else
            x(k,n) = sin(pi*a(k)*t(n)) / (pi*a(k)*t(n));
        end
    end
end

figure
for k = 1:length(a)
    subplot(3,1,k)
    plot(t, x(k,:), 'b', 'LineWidth', 1)
    grid on
    xlim([-10 10])
    title(['sinc(', num2str(a(k)), 't) = sin(\pi ', num2str(a(k)), 't) / (\pi ', num2str(a(k)), 't)'])
    xlabel('t (sec)')
    ylabel('Amplitude')
end
sgtitle('Lab 1 Q3: sinc Waves from sin(x)/x')
