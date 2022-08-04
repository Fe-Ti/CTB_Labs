% Copyright 2022 Fe-Ti aka T.Kravchenko
% getting mandatory point for calculating stability margins
%% circle params
radius = 1
circle_center = [0, 0]

% using my epic nyquist function, 'cause it's cool :-)
[re im w] = epic_nyquist(sys, w);

%% coordinate delta between center of a circle and a point
delta_cc = [[re - circle_center(1)]
            [im - circle_center(2)]];

%% distance between point and circumference
distance = abs((delta_cc(1,:).^2 + delta_cc(2,:).^2).^(0.5) - radius);

[minimum, pha_sm_index] = min(distance);
re_smp1 = re(pha_sm_index);
im_smp1 = im(pha_sm_index);
w_smp1 = w(pha_sm_index);


[mag, pha, w] = bode(sys, w);

abs_im = abs(im);
mag_sm_index = 0;
for n = 2:size(abs_im)(2)
    if ((im(n) * im(n-1)) <= 0)
        if (abs(im(n)) < abs(im(n-1)))
            mag_sm_index = n;
        else
            mag_sm_index = n-1;
        endif
        break
    endif
endfor

re_smp2 = re(mag_sm_index);
im_smp2 = im(mag_sm_index);
w_smp2 = w(mag_sm_index);

% dots in nyquist diagram
hold on 
plot (re_smp1,im_smp1 , 'MarkerSize', 20)
hold off 
hold on 
plot (re_smp2, im_smp2 , 'MarkerSize', 20)
hold off 

phase_sm = abs(pha(pha_sm_index)) - 180;
mag_sm = mag2db(mag(mag_sm_index));
phase_sm_abs_val = abs(phase_sm)
mag_sm_abs_val = abs(mag_sm)


% bode plotting (based on bode.m from control package)
figure

r = 2;
c = 1;
mag_tiles = 1;
pha_tiles = 2;

mag_db = mag2db(mag);

subplot(r, c, mag_tiles); % row, col, index;
hold on
semilogx (w, mag_db)
axis ("tight")
grid ("on")
ylabel ("Magnitude [dB]")
semilogx([w(1), w(size(w)(2))], [0, 0], 'k:');
semilogx([w(pha_sm_index), w(pha_sm_index)], [min(mag_db), 0], 'k--');
semilogx([w(mag_sm_index), w(mag_sm_index)], [min(mag_db), 0], 'k--');

semilogx([w(mag_sm_index), w(mag_sm_index)], [0, mag_db(mag_sm_index)], 'MarkerSize', 20);
title(sprintf("Запасы устойчивости: по амплитуде %g dB, по фазе %g deg", mag_sm_abs_val, phase_sm_abs_val));
hold off

subplot(r, c, pha_tiles);
hold on
semilogx (w, pha)
axis ("tight")
grid ("on")
xlabel ("Frequency [rad/s]")
ylabel ("Phase [deg]")
semilogx([w(1), w(size(w)(2))], [-180, -180], 'k:');
semilogx([w(mag_sm_index), w(mag_sm_index)], [-180, max(pha)], 'k--');
semilogx([w(pha_sm_index), w(pha_sm_index)], [-180, max(pha)], 'k--');

semilogx([w(pha_sm_index), w(pha_sm_index)], [-180, pha(pha_sm_index)], 'MarkerSize', 20);
hold off

