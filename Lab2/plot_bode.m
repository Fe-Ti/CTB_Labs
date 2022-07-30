function success = plot_bode(m, p, r, c, mag_tiles, pha_tiles)
    subplot(r, c, mag_tiles); % row, col, index;
    semilogx (m)
    axis ("tight")
    ylim (__axis_margin__ (ylim))
    grid ("on")
    title ("Bode Diagram")
    ylabel ("Magnitude [dB]")

    subplot(r, c, pha_tiles);
    semilogx (p)
    axis ("tight")
    ylim (__axis_margin__ (ylim))
    grid ("on")
    xlabel ("Frequency [rad/s]")
    ylabel ("Phase [deg]")

    success = 1;
