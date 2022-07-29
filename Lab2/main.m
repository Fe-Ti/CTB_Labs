% Copyright 2022 Fe-Ti aka T.Kravchenko

isOctave = exist('OCTAVE_VERSION', 'builtin') ~= 0; % detecting type of CAS
isMatlab = not(isOctave);
if isOctave
    pkg load control;
end

K = 2
T = 0.5
ksi = 0.4

% TF for links:
% amp.
w1 = tf(K, 1, 'Name', 'Усилитель')

% intg.
w2 = tf(K, [1, 0], 'Name', 'Интегрирующее звено')

% 1-Ord aper.
w3 = tf(K, [T, 1], 'Name', 'Апериод. звено 1-го пор.')

% 1-Ord real diff.
w4 = tf([K, 0], [T, 1], 'Name', 'Реальное диф. звено 1-го пор.')

% osc.
w5 = tf(K, [T*T, 2*T*ksi, 1], 'Name', 'Колебательное звено')

