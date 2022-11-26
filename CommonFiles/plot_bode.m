function success = plot_bode(m, p, w, r, c, mag_tiles, pha_tiles, fontsize, linewidth)
% Copyright 2022 Fe-Ti aka T.Kravchenko
    if (nargin < 4)
        r = 2;
        c = 1;
        mag_tiles = 1;
        pha_tiles = 2;
    end
    
    
    if (nargin < 8)
        fontsize = 14;
    end

    if (nargin < 9)
        linewidth = 2;
    end


    if (~iscell(m))
        m = {m}
    end
    
    if (~iscell(p))
        p = {p}
    end
    
    if (~iscell(w))
        w = {w}
    end

    % based on bode.m from control package
    mag_db = cellfun (@mag2db, m, "uniformoutput", false);
    
    subplot(r, c, mag_tiles); % row, col, index;
    hold on
    cellfun (@semilogx, w, mag_db)
    hold off
    axis ("tight")
    ylim (__axis_margin__ (ylim))
    grid ("on")
    title ("Bode Diagram")
    ylabel ("Magnitude [dB]")
    ax = gca();
    set(ax, 'fontsize', fontsize);
        %~ set(ax, 'linewidth', linewidth / 10);

    subplot(r, c, pha_tiles);
    hold on
    cellfun (@semilogx, w, p)
    hold off
    axis ("tight")
    ylim (__axis_margin__ (ylim))
    grid ("on")
    xlabel ("Frequency [rad/s]")
    ylabel ("Phase [deg]")
    success = 1;
    ax = gca();
    set(ax, 'fontsize', fontsize);
        %~ set(ax, 'linewidth', linewidth / 10);
end
