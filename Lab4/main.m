% Copyright 2022 Fe-Ti aka T.Kravchenko

isOctave = exist('OCTAVE_VERSION', 'builtin') ~= 0; % detecting type of CAS
isMatlab = not(isOctave);
if isOctave
    pkg load control symbolic;
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

% from 0 to 2pi with 5000 points
w = 2*pi*linspace(0, 1, 5*10^3);

figure
even_more_epic_mikhailov(sys_fb, w);
[re im wr] = even_more_epic_mikhailov(sys_fb, w);

hold on
max_coord = max(abs([re, im]));
plot([0, 0], [-max_coord, max_coord], 'k--', [-max_coord, max_coord], [0, 0], 'k--')
hold off

% Here should be some sort of an ASUS logo:
% <h1 > CTBL </h1>
% <h4> In search of incredible coefficients </h4>


k_vec = []
w_vec = []

% if the script exists, then run script for initializing vectors
if (exist ('precompiled_k_T.m', 'file') == 2)
    precompiled_k_T;
else
    % else solve equations and get k_vec
    for T = T_vec
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % Using symbolic package for auto solving   %
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        syms K real;
        syms W real;
        W1 = K;
        W2 = sym(k1, 'r') / (sym(T1, 'r')*1i*W + 1);
        W3 = 1 / (sym(T, 'r')*1i*W + 1);
        W4 = 1 / (1i*W);
        SYS = W1 * W2 * W3 * W4;
        SYSFB = SYS / (1 - SYS);

        SSYSFB = simplify(SYSFB);
        [num den] = numden(SSYSFB);
        iceq = simplify(imag (den));
        rceq = simplify(real (den));
        [K, W] = solve(rceq == 0, iceq == 0);
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        k_vec = [k_vec -sort(double(K), "ascend")(1)]
        w_vec = [w_vec sort(double(W), "descend")(1)];
        % plotting part (uncomment the latter text)
        %~ k = -sort(double(K), "ascend")(1);
        %~ w1 = tf(k);
        %~ w2 = tf(k1, [T1, 1]);
        %~ w3 = tf(1, [T, 1]);
        %~ w4 = tf(1, [1, 0]);
        %~ sys = w1 * w2 * w3 * w4;
        %~ sys_fb = feedback(sys, tf(1), '-');
        %~ figure
        %~ even_more_epic_mikhailov(sys_fb, w);
    end
end
% Plot K_sb = f(T)
figure
plot(T_vec, k_vec, 'LineWidth', 2)

% And finnaly plot diagrams for three systems
k_sys1 = 0.1
T_sys1 = 0.7
k_sys2 = 3.0
T_sys2 = 1.7
k_sys3 = k_vec(10)
T_sys3 = T_vec(10)

sys1 = tf(k_sys1*k1,[T_sys1*T1, T_sys1+T1, 1, -k_sys1*k1], 'Name', 'sys_A1')
sys2 = tf(k_sys2*k1,[T_sys2*T1, T_sys2+T1, 1, -k_sys2*k1], 'Name', 'sys_A2')
sys3 = tf(k_sys3*k1,[T_sys3*T1, T_sys3+T1, 1, -k_sys3*k1], 'Name', 'sys_A3')

plot_diagrams(sys1, 4)
plot_diagrams(sys2, 4)
plot_diagrams(sys3, 4)
