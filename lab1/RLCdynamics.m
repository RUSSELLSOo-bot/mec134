function xdot = RLCdynamics(t, x) 

    %Args: x = [i vc]^-1
    %return xdot = [idot vcdot]^-1
    
    
    R = 2; %ohms
    L = 1e-3; %H
    C = 1e-3; %F

    u = 1; %v_in

    A = [0  -1/L ;
        1/C  -1/(R*C)];

    B = [1/L ;
        0];



    xdot = A*x +B*u;

end 
