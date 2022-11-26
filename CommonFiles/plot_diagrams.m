function sucsess=plot_diagrams(sys, modelling_time, name, fontsize, linewidth)
% Copyright 2022 Fe-Ti aka T.Kravchenko
    isOctave = exist('OCTAVE_VERSION', 'builtin') ~= 0; % detecting type of CAS
    isMatlab = not(isOctave);
    if isOctave
        pkg load control;
    end

    if (nargin < 3)
        name = "Diagrams";
    end

    if (nargin < 4)
        fontsize = 14;
    end

    if (nargin < 5)
        linewidth = 2;
    end

    if (~iscell(sys))
        sys = {sys};
    end

    r = 3;
    c = 3;
    step_tiles = 1;
    impulse_tiles = 2;
    nyquist_tiles = 3;
    mag_tiles = [4:6];
    pha_tiles = [7:9];

    % new figure with awesome name
    figure('Name', name);

    set(gcf, 'DefaultLineLineWidth', linewidth);


    % legend is just system names
    lg = cellfun (@get, sys, {'Name'}, "uniformoutput", false);

    if isOctave
        % workaround for Octave's control package
        [m p w] = cellfun (@bode, sys, "uniformoutput", false);
        plot_bode(m, p, w, r, c, mag_tiles, pha_tiles);
        legend(lg{:});
    else
        subplot(r, c, [mag_tiles pha_tiles]);
        hold on
        cellfun (@bode, sys);
        legend(lg{:});
        ax = gca();
        set(ax, 'fontsize', fontsize);
        %~ set(ax, 'linewidth', linewidth / 10);
        hold off
    end

    subplot(r, c, step_tiles); % row, col, index;
    hold on
    step(sys{:}, modelling_time);
    legend(lg{:});
    ax = gca();
    set(ax, 'fontsize', fontsize);
    %~ set(ax, 'linewidth', linewidth / 10);
    hold off

    subplot(r, c, impulse_tiles); % row, col, index;
    hold on
    impulse(sys{:}, modelling_time);
    legend(lg{:});
    ax = gca();
    set(ax, 'fontsize', fontsize);
    %~ set(ax, 'linewidth', linewidth);
    hold off

    subplot(r, c, nyquist_tiles); % row, col, index;
    hold on
    nyquist(sys{:});
    legend(lg{:});
    ax = gca();
    set(ax, 'fontsize', fontsize);
    %~ set(ax, 'linewidth', linewidth);
    hold off

    success = 1;
end
