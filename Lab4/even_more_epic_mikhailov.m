function [re im wr] = even_more_epic_mikhailov(sys, w)
% Copyright 2022 Fe-Ti aka T.Kravchenko

    if (nargin == 1)
        w = [0.1:0.001:100];
    endif

    den_vec = get(sys, 'den'){1}
    den_len = size(den_vec)(2);

    re_arr = [];
    im_arr = [];

    for w_n = w
        den = 0;
        for n = 1:den_len
            s_power = den_len - n;
            den = den + den_vec(n)*((w_n*i)^s_power);
        endfor

        re_arr = [re_arr real(den)];
        im_arr = [im_arr imag(den)];

    endfor

    if (!nargout)
        plot(re_arr, im_arr, 0,0, 'MarkerSize', 20);
        %axis equal;
        grid on;
        title ("Годограф Михайлова");
        xlabel ("[Re]");
        ylabel ("[Im]");
    else
        re = re_arr;
        im = im_arr;
        wr = w;
    endif
end
