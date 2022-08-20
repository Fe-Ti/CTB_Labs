k = 1
T = 0.5
T1 = 2.2

s = poly(0, 's')

num = k
den =  (T * T1) * s^3 + (T + T1) * s^2 + s

wO = syslin('c', num, den)

kp = 1;
Ta = 1;
Td = 10;
wP = syslin('c', (kp * Ta + Td) * s + kp, Ta * s + 1);
