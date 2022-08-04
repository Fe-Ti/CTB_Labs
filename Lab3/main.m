% Copyright 2022 Fe-Ti aka T.Kravchenko

isOctave = exist('OCTAVE_VERSION', 'builtin') ~= 0; % detecting type of CAS
isMatlab = not(isOctave);
if isOctave
    pkg load control symbolic signal;
end

T1 = 0.7
k1 = 1.6
T = 0.1
k = 1.0

w1 = tf(k)
w2 = tf(k1, [T1, 1])
w3 = tf(1, [T, 1])
w4 = tf(1, [1, 0])

sys = w1 * w2 * w3 * w4

%sys_fb = feedback(sys, tf(1))

% freqs, mag and phase

[mag, pha, wr] = bode(sys);
% from 0.1*2pi to 10*2pi with 5000 points
w = 2*pi*logspace(-2, 2, 5*10^3);

#[0 0.1:0.01:10, 20:1:100, 200:100:1000];

figure('Name', 'nyquist(sys)');
nyquist(sys,w);
draw_circle(1);

figure('Name', 'margin(sys)');
margin(sys);


figure('Name', 'My epic_nyquist(sys)');
epic_nyquist(sys, w);
draw_circle(1);

% run a script
calculate_stability_margins_nyquist
