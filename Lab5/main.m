% Copyright 2022 Fe-Ti aka T.Kravchenko

isOctave = exist('OCTAVE_VERSION', 'builtin') ~= 0; % detecting type of CAS
isMatlab = not(isOctave);
if isOctave
    pkg load control symbolic;
end

linewidth = 2;
fontsize = 14;

T1 = 0.7
k1 = 1.6
T = 0.1
k = 1

modelling_time = 25
tsam = 0.5
%~ tsam = 0.1
%~ tsam = 0.01
%~ tsam = 0.0001

w1 = tf(k)
w2 = tf(k1, [T1, 1])
w3 = tf(1, [T, 1])
w4 = tf(1, [1, 0])

sys = w1 * w2 * w3 * w4
sys_fb = feedback(sys, tf(1), '-')
set(sys_fb, 'Name', 'Непрерывная система');

dsys_fb_zoh = c2d(sys_fb, tsam, 'zoh')
set(dsys_fb_zoh, 'Name', 'Экстр. нул. пор.');
%~ dsys_fb_foh = c2d(sys_fb, tsam, 'foh')
dsys_fb_tus = c2d(sys_fb, tsam, 'tustin')
set(dsys_fb_tus, 'Name', 'Билин. аппрокс. Тастина');
%~ dsys_fb_imp = c2d(sys_fb, tsam, 'impulse')


%~ plot_diagrams(sys, modelling_time)
%~ plot_diagrams(sys_fb, modelling_time)
%~ plot_diagrams(dsys_fb, modelling_time)
syscell1 = {sys_fb, dsys_fb_zoh};
syscell2 = {sys_fb, dsys_fb_tus};
syscell3 = {sys_fb, dsys_fb_zoh, dsys_fb_tus};
%~ syscell = {sys_fb, dsys_fb_zoh, dsys_fb_foh, dsys_fb_tus, dsys_fb_imp}
plot_diagrams(syscell1, modelling_time, 'Cool Diagrams1')
plot_diagrams(syscell2, modelling_time, 'Cool Diagrams2')
plot_diagrams(syscell3, modelling_time, 'Cool Diagrams3')

%  -power of z is amount of sampling periods
dsys_fb_zoh_delay3 = dsys_fb_zoh * tf(1, [1 0 0 0 0], tsam)
set(dsys_fb_zoh_delay3, 'Name', 'ZOH с задержкой 2 с');

%~ step(dsys_fb_zoh_delay1, sys_fb, dsys_fb_zoh)
%~ step(dsys_fb_zoh_delay2, sys_fb, dsys_fb_zoh)
figure
set(gcf, 'DefaultLineLineWidth', linewidth);
step(dsys_fb_zoh_delay3, sys_fb, dsys_fb_zoh)
ax = gca();
set(ax, 'fontsize', fontsize);
sys_cell = {dsys_fb_zoh_delay3, sys_fb, dsys_fb_zoh}
lg = cellfun (@get, sys_cell, {'Name'}, "uniformoutput", false);
legend(lg)
pause
