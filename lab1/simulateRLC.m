%plot the evolution of the system 
tspan = [0 4e-2];
x0 = [0; 0];

[t,x] = ode45(@RLCdynamics,tspan,x0);

i = x(:, 1);
vc=  x(:, 2);

figure;
yyaxis left
plot(t, i, 'LineWidth', 1.5);
ylabel('Current i (A)');

yyaxis right
plot(t, vc, 'LineWidth', 1.5);
ylabel('Capacitor voltage v_C (V)');

xlabel('Time (s)');
grid on;
title('RLC response (u = 1V)');

grid off
%now plot the step response and build the state space model 

R = 2; %ohms
L = 1e-3; %H
C = 1e-3; %F

u = 1; %v_in

A = [0  -1/L ;
    1/C  -1/(R*C)];

B = [1/C ;
    0];

Cmat = [0 1];

D = 0;


RLCss = ss(A,B,Cmat,D);

figure;
step(RLCss)
grid on
title('Step response: outputs [i; v_C] to input v_{in}')

%construct transfer function model 

num = 1;
dem = [L*C L/R 1/C];

RLCtf = tf(num ,dem);
figure;
step(RLCtf)
grid on


figure;
sim('simuRLC.slx')
plot(Vc.time, Vc.signals.values)
xlabel('Time (s)')
ylabel('Vc(t)')
grid on

