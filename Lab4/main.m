% Copyright 2022 Fe-Ti aka T.Kravchenko

isOctave = exist('OCTAVE_VERSION', 'builtin') ~= 0; % detecting type of CAS
isMatlab = not(isOctave);
if isOctave
    pkg load control symbolic;
end

T1 = 0.7
k1 = 1.6
T = 0.1
k = 2.0
w1 = tf(k)
w2 = tf(k1, [T1, 1])
w3 = tf(1, [T, 1])
w4 = tf(1, [1, 0])

sys = w1 * w2 * w3 * w4

sys_fb = feedback(sys, tf(1), '-')

% from 0 to 2pi with 5000 points
w = 2*pi*linspace(0, 1, 5*10^3);

even_more_epic_mikhailov(sys_fb, w)
[re im wr] = even_more_epic_mikhailov(sys_fb, w);

hold on
max_coord = max(abs([re, im]));
plot([0, 0], [-max_coord, max_coord], 'k--', [-max_coord, max_coord], [0, 0], 'k--')
hold off

k_vec = []
w_vec = []
for T=0.1:5.0
    syms K real;
    syms W real;
    W1 = K;
    W2 = k1 / (T1*1i*W + 1);
    W3 = 1 / (T*1i*W + 1);
    W4 = 1 / (1i*W);
    SYS = W1 * W2 * W3 * W4;
    SYSFB = SYS / (1 - SYS);

    SSYSFB = simplify(SYSFB);

    [num den] = numden(SSYSFB);
    iceq = simplify(imag (den));
    rceq = simplify(real (den));
    [K, W] = solve(rceq == 0, iceq == 0);
    k_vec = [k_vec sort(double(K), "ascend")(1)]
    w_vec = [w_vec sort(double(W), "descend")(1)];
    % plotting
    k = -sort(double(K), "ascend")(1);
    w1 = tf(k);
    w2 = tf(k1, [T1, 1]);
    w3 = tf(1, [T, 1]);
    w4 = tf(1, [1, 0]);
    sys = w1 * w2 * w3 * w4;
    sys_fb = feedback(sys, tf(1), '-');
    figure
    even_more_epic_mikhailov(sys_fb, w);
end
