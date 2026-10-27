clc; clear; close all;

a = [1 2 3 4];
h = [1 1 1];

y_conv = conv(a, h)
y_same = conv(a, h, 'same')
y_filt = filter(h, 1, a)

figure
subplot(3,1,1)
stem(0:length(y_conv)-1, y_conv, 'filled', 'b', 'LineWidth', 1)
grid on
title('conv(a, h)')
xlabel('n')
ylabel('Amplitude')

subplot(3,1,2)
stem(0:length(y_same)-1, y_same, 'filled', 'r', 'LineWidth', 1)
grid on
title('conv(a, h, ''same'')')
xlabel('n')
ylabel('Amplitude')

subplot(3,1,3)
stem(0:length(y_filt)-1, y_filt, 'filled', 'k', 'LineWidth', 1)
grid on
title('filter(h, 1, a)')
xlabel('n')
ylabel('Amplitude')

sgtitle('Lab 1 Q5: conv vs conv same vs filter')
