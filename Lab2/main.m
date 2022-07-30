% Copyright 2022 Fe-Ti aka T.Kravchenko

isOctave = exist('OCTAVE_VERSION', 'builtin') ~= 0; % detecting type of CAS
isMatlab = not(isOctave);
if isOctave
    pkg load control;
end

K = 2
T = 0.5
ksi = 0.4
modelling_time = 4

% TF for links:
% amp.
w1 = tf(K, 'Name', 'Усилитель W1')
#plot_diagrams(w1, modelling_time)

% intg.
w2 = tf(K, [1, 0], 'Name', 'Интегрирующее звено W2')
plot_diagrams(w2, modelling_time)

% 1-Ord aper.
w3 = tf(K, [T, 1], 'Name', 'Апериод. звено 1-го пор. W3')
plot_diagrams(w3, modelling_time)

% 1-Ord real diff.
num = [K, 0]
den = [T, 1]
w4 = tf(num, den, 'Name', 'Реальное диф. звено 1-го пор. W4')
plot_diagrams(w4, modelling_time)

% osc. (checkout the README.md)
num = K;
den = [T*T, 2*T*ksi, 1];
w5 = tf(num, den, 'Name', 'Колебательное звено W5')
plot_diagrams(w5, modelling_time)

num = K * 2;
den = [T*T, 2*T*ksi, 1];
w6 = tf(num, den, 'Name', 'Колебательное звено W6 (K*2)')
plot_diagrams(w6, modelling_time)

num = K;
T1 = T * 2;
den = [T1*T1, 2*T1*ksi, 1];
w7 = tf(num, den, 'Name', 'Колебательное звено W7 (T*2)')
plot_diagrams(w7, modelling_time)

num = K;
den = [T*T, 2*T*ksi*2, 1];
w8 = tf(num, den, 'Name', 'Колебательное звено W8 (ksi*2)')
plot_diagrams(w8, modelling_time)

num = K;
den = [T*T, 0, 1];
w9 = tf(num, den, 'Name', 'Консервативное звено W9 (ksi=0)')
plot_diagrams(w9, modelling_time)
