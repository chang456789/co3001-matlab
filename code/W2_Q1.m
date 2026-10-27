clc; clear; close all;

A = [1 2 3; 4 5 6]
B = [3 2 1; 6 5 4]
C = [1 2; 3 4; 5 6]

A_add = A + B
A_sub = A - B
A_mul = A * C
A_emul = A .* B
A_ediv = A ./ B

A_T = A.'

Z = [1+2j 3-1j; 2j 4]
Z_T = Z.'
Z_H = Z'
