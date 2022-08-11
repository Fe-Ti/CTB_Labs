function [re im wr] = epic_nyquist(sys, w)
% Copyright 2022 Fe-Ti aka T.Kravchenko

    if (nargin == 1)
        w = [0.1:0.01:100];
    end

    den_vec = get(sys, 'den'){1};
    den_len = size(den_vec)(2);

    num_vec = get(sys, 'num'){1};
    num_len = size(num_vec)(2);

    re_arr = [];
    im_arr = [];

    for w_n = w
        num = 0;
        den = 0;
        for n = 1:num_len
            s_power = num_len - n;
            num = num + num_vec(n)*((w_n*i)^s_power);
        end
        for n = 1:den_len
            s_power = den_len - n;
            den = den + den_vec(n)*((w_n*i)^s_power);
        end

        trans_func = num / den;

        re_arr = [re_arr real(trans_func)];
        im_arr = [im_arr imag(trans_func)];

    end

    if (!nargout)
        % finally plotting like a lib function
        plot(re_arr, im_arr, re_arr, uminus(im_arr), -1,0, 'MarkerSize', 20);
        %axis equal;
        grid on;
        title ("Годограф Найквиста");
        xlabel ("[Re]");
        ylabel ("[Im]");
    else
        re = re_arr;
        im = im_arr;
        wr = w;
    end
