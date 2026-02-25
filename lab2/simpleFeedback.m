
%Part 1: Verify Oscillatory regime 
%should be oscillatory on k = 12

K = 12;

out = sim('simpleFeedback');          % SimulationOutput object
stpresponse = out.simout;             % timeseries from Workspace block

figure 
hold on 
plot(stpresponse.Time, stpresponse.Data)
xlabel('Time (s)')
ylabel('Step Response (testing for oscillations')
grid on
hold off

%Part 2: Verify stable regime

K_val = [13 120 1200 12000];

%setup the calculate
s = tf('s');
G = (s+2)/(s^2 - 12*s);     

figure
hold on

for i = 1:length(K_val)
    
    K = K_val(i);      

    T = feedback(K*G, 1);
    p = pole(T);                    %find pole per K

    out = sim('simpleFeedback');  % run Simulink
    stpresponse = out.simout;     % get output
    
    plot(stpresponse.Time, stpresponse.Data)
    
    fprintf('K = %g, poles = ', K); %print output for pole information
    disp(p.')                      
end

print('____________________________________')
plot(stpresponse.Time, stpresponse.Data)
xlabel('Time (s)')
ylabel('Step Response (testing for stability')
legendStrings = "K=" + string(K_val);
legend(legendStrings)
grid on
hold off

%Part 3:


K_test = 58:0.1:62;
validK = [];
count = 0;

for i = 1:length(K_test)

    K = K_test(i);

    out = sim('simpleFeedback');  % run Simulink
    stpresponse = out.simout;

    max_val = max(stpresponse.Data);
    OS = (max_val - 1) ;

    if OS <= 0.25
        count = count + 1;
        validK(count) = K;
    end 
end

K_min = min(validK);
K_max = max(validK);

fprintf('K range: %.1f ≤ K ≤ %.1f\n', K_min, K_max)
%12 - 20 does not work
%now we got 6-120 with 2 interval
%59.3 is the answer, range should go to infinity
% as k approaches infinity







