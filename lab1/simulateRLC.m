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

B = [1/L ;
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
dem = [L*C L/R 1];

RLCtf = tf(num ,dem);
figure;
step(RLCtf)
grid on


% Run the Simulink model
simOut = sim('simuRLC');

% Extract the timeseries object
vC_ts = simOut.simulateRLC;

% Plot
%figure;
%plot(vC_ts.Time, vC_ts.Data, 'LineWidth', 1.5);
%grid on;
%xlabel('Time (s)');
%ylabel('v_C (V)');
%title('Simulink Model Response');

% Plot
% figure;
% plot(vC_ts.Time, vC_ts.Data, 'LineWidth', 1.5);
% grid on;
% xlabel('Time (s)');
% ylabel('v_C (V)');
% title('Simulink Model Response (25Hz square input)');

% Plot
figure;
plot(vC_ts.Time, vC_ts.Data, 'LineWidth', 1.5);
grid on;
xlabel('Time (s)');
ylabel('v_C (V)');
title('Simulink Model Response (250Hz square input)');


