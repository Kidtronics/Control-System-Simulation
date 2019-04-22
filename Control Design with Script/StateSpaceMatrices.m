function [A, B] = StateSpaceMatrices()
    global m M L g b I;
    
    D = (M+m)*I + M*m*L^2;
    N = I + m*L^2;
    
    A = [0, 1, 0, 0; 
         0, -b*N/D, m^2*L^2*g/D, 0;
         0, 0, 0, 1;
         0, -m*L*b/D, m*g*L*(M+m)/D, 0];
    B = [0; N/D; 0; m*L/D];
end

