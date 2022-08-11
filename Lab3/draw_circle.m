function [x y] = draw_circle(r, center, style, step)
% Copyright 2022 Fe-Ti aka T.Kravchenko

    if (nargin < 1)
        error("Radius is mandatory arg for draw_circle(r, center, style)")
    end

    if (nargin < 2)
        center = [0, 0];
    end

    if (nargin < 3)
        style = 'k--';
    end

    if (nargin < 4)
        step = 0.001;
    end

    psi = 0:step:2*pi;
    coord_x = center(1) + r .* cos(psi);
    coord_y = center(2) + r .* sin(psi);

    if (! nargout)
        hold on;
        plot(coord_x, coord_y, style);
        hold off;
    else
        x = coord_x;
        y = coord_y;
    end
