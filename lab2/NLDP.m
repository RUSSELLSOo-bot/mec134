g = 9.81; %ms^-2
L = 2.0; %m
m = 1.0; %kg
c = 0.25; %s^-1






out = sim('NLDP');          % SimulationOutput object
theta = out.simout;

