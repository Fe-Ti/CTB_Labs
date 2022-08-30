% Copyright 2022 Fe-Ti aka T.Kravchenko

% Do not run.
% This script is
% Just for fun.
% SymPy can't eval ilaplace of such a thing
% At least in reasonable time.

pkg load symbolic

k = sym(1);

delay = 2


syms s real;
W1 = k;
W2 = sym(1.6, 'r') / (sym(0.7, 'r')*s + 1);
W3 = 1 / (sym(0.1, 'r')*s + 1);
W4 = 1 / (s);
SYS = W1 * W2 * W3 * W4;
SYSFB = SYS / (1 - SYS);

SSYSFB = simplify(SYSFB);

DELAY_SYSFB = exp(-delay*s) * SSYSFB

syms t real
sf_ft = ilaplace(SYSFB, s, t)
mag = []
for t=0:0.1:15
    mag = [mag eval(DS=sf_ft)]
end

#s = 1
#out = (eval(DELAY_SYSFB))
