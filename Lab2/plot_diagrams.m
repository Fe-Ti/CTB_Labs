function sucsess=plot_diagrams(sys, modelling_time)
% Copyright 2022 Fe-Ti aka T.Kravchenko

    r = 3;
    c = 3;
    step_tiles = 1;
    impulse_tiles = 2;
    nyquist_tiles = 3;
    mag_tiles = [4:6];
    pha_tiles = [7:9];
    
    % new figure with awesome name
    figure('Name', get(sys, 'Name'));

    % workaround for Octave's control package
    [m p w] = bode(sys);
    plot_bode(m, p, w, r, c, mag_tiles, pha_tiles);

    subplot(r, c, step_tiles); % row, col, index;
    set(sys, 'OutputName', 'Amplitude');
    step(sys, modelling_time);

    subplot(r, c, impulse_tiles); % row, col, index;
    impulse(sys, modelling_time);

    subplot(r, c, nyquist_tiles); % row, col, index;
    nyquist(sys)

    success = 1;
