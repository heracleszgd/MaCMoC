
S = 2/2;
A = [ -1 -3 -6 -3 -3  1  ; % Z-FM       -1DSz^2-3J1S^2-6J2S^2-3J3S^2-3位Sz^2+1E0
      -1  3 -6  3  3  1  ; % Z-Neel     -1DSz^2+3J1S^2-6J2S^2+3J3S^2+3位Sz^2+1E0
      -1 -1  2  3 -1  1  ; % Z-Zigzag   -1DSz^2-1J1S^2+2J2S^2+3J3S^2-1位Sz^2+1E0
      -1  1  2 -3  1  1  ; % Z-Stripy   -1DSz^2+1J1S^2+2J2S^2-3J3S^2+1位Sz^2+1E0
       0 -3 -6 -3  0  1  ; % X-FM          0   -3J1S^2-6J2S^2-3J3S^2   0   +1E0
       0  3 -6  3  0  1 ]; % X-Neel        0   +3J1S^2-6J2S^2+3J3S^2   0   +1E0
for i=1:(length(A)-1)
    A(:,i) = A(:,i)*S^2;
end

B = [-42.15189939/2 ;      % Z-FM       -1DSz^2-3J1S^2-6J2S^2-3J3S^2-3位Sz^2+1E0
     -84.21814006/4 ;      % Z-Neel     -1DSz^2+3J1S^2-6J2S^2+3J3S^2+3位Sz^2+1E0
     -84.26951334/4 ;      % Z-Zigzag   -1DSz^2-1J1S^2+2J2S^2+3J3S^2-1位Sz^2+1E0
     -84.24481391/4 ;      % Z-Stripy   -1DSz^2+1J1S^2+2J2S^2-3J3S^2+1位Sz^2+1E0
     -42.13635297/2 ;      % X-FM          0   -3J1S^2-6J2S^2-3J3S^2   0   +1E0
     -42.09511228/2];      % X-Neel        0   +3J1S^2-6J2S^2+3J3S^2   0   +1E0

format shortG
x=A\B*1000;            % D, J1, J2, J3, 位, E0 (meV)
x
%c = sprintf(' D:   %.3f meV(single ion anisotropy)\n J:  %.3f meV(exchange constant)\n A: %.3f meV(anisotropic exchange)',x(1),x(2),x(3));
%disp(c)
% D, J, λ, E0. in meV
