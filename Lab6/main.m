% Copyright 2022 Fe-Ti aka T.Kravchenko

isOctave = exist('OCTAVE_VERSION', 'builtin') ~= 0; % detecting type of CAS
isMatlab = not(isOctave);
if isOctave
    pkg load control;
end

T1 = 0.7
k1 = 1.6
T = 0.1
T_vec = [0.1:0.01:0.19, 0.2:0.1:5.0]
k = 1

w1 = tf(k)
w2 = tf(k1, [T1, 1])
w3 = tf(1, [T, 1])
w4 = tf(1, [1, 0])

sys = w1 * w2 * w3 * w4
sys_fb = feedback(sys, tf(1), '-')
