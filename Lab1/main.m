% Copyright 2022 Fe-Ti aka T.Kravchenko

% Eq. is
% a_3 x^(3)(t) + a_2 x^(2)(t) + a_1 x^(1)(t) + a_0 x(t) = b_0 y(t) 
%
% The system is
% x_1^(1)(t) = x_2(t)
% x_2^(1)(t) = x_3(t)
% x_3^(1)(t) = 1 over a_3 (b_0 y(t) - a_2 x_3(t) - a_1 x_2 (t) - a_0 x_1(t))
% 
% assuming
% x_1(t) = x(t)
% x_2(t) = x_1^(1)(t)
% x_3(t) = x_2^(1)(t)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Initializing stuff

init_variables;

T = 25 % seconds

ode_opts = odeset('AbsTol',[1e-5,1e-5,1e-5],'RelTol',1e-5);

y_1 = @(t) 1;
y_sin = @(t) sin(t);

model_1 = @(t, x) model(t, x, y_1);
model_sin = @(t, x) model(t, x, y_sin);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plotting beautiful plots


% input signal is 1, zero initial conditions
[time, x] = ode45(model_1, [0, T], x_zero, ode_opts);
figure;
plot(time, x(:,1), 'b-', time, x(:,2), 'g--', 'LineWidth', 2);
legend('x_1(t)','x_2(t)');
title('Входной сигнал 1, нулевые Н.У.');
grid on;

% input signal is 1, nonzero initial conditions
[time, x] = ode45(model_1, [0, T], x_nonzero, ode_opts);
figure;
plot(time, x(:,1), 'b-', time, x(:,2), 'g--', 'LineWidth', 2);
legend('x_1(t)','x_2(t)');
title('Входной сигнал 1, ненулевые Н.У.');
grid on;

% input signal is sin(t), zero initial conditions
[time, x] = ode45(model_sin, [0, T], x_zero, ode_opts);
figure;
plot(time, x(:,1), 'b-', time, x(:,2), 'g--', 'LineWidth', 2);
legend('x_1(t)','x_2(t)');
title('Входной сигнал sin(t), нулевые Н.У.');
grid on;

% input signal is sin(t), nonzero initial conditions
[time, x] = ode45(model_sin, [0, T], x_nonzero, ode_opts);
figure;
plot(time, x(:,1), 'b-', time, x(:,2), 'g--', 'LineWidth', 2);
legend('x_1(t)','x_2(t)');
title('Входной сигнал sin(t), ненулевые Н.У.');
grid on;
