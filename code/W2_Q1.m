clc; clear; close all;

A = [1 2 3; 4 5 6]
B = [3 2 1; 6 5 4]
C = [1 2; 3 4; 5 6]
D = [1 2; 3 4; 5 6]

A_add = A + B
A_sub = A - B
A_emul = A .* B
A_mul = A * C

E = [1+2j 3-1j; 2+0j 4+5j]

A_T = A.'
E_H = E'
