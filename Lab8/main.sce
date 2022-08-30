// Setting initial parameters
k = 1
T = 0.5
T1 = 2.2

s = poly(0, 's')

// WOW! Symbolic math!
num = k
den =  (T * T1) * s^3 + (T + T1) * s^2 + s

// tf(...) equivalent in scilab
wO = syslin('c', num, den)

// Another TF for PD-controller
kp = 1;
Ta = 1;
Td = 10;
wP = syslin('c', (kp * Ta + Td) * s + kp, Ta * s + 1);

// Load SISO tool

exec 'Software/sisotool/sisotool-master/loader.sce'

