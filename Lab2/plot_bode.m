function success = plot_bode(m, p, w, r, c, mag_tiles, pha_tiles)
    % based on bode.m from control package
    mag_db = mag2db(m);

    subplot(r, c, mag_tiles); % row, col, index;
    semilogx (w, mag_db)
    axis ("tight")
    ylim (__axis_margin__ (ylim))
    grid ("on")
    title ("Bode Diagram")
    ylabel ("Magnitude [dB]")

    subplot(r, c, pha_tiles);
    semilogx (w, p)
    axis ("tight")
    ylim (__axis_margin__ (ylim))
    grid ("on")
    xlabel ("Frequency [rad/s]")
    ylabel ("Phase [deg]")

    success = 1;
