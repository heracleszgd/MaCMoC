%H=-2Ja*∑S1*S2-2Jb*∑S1*S2-2Jab*∑S1*S2
S = 1/2;
A = [ -2 -2 -4  1  ; % FM    = -2Ja*S^2-2Jb*S^2-4Jab*S^2 +1E0
       2 -2  4  1  ; % AFMa  = -2Ja*S^2-2Jb*S^2-4Jab*S^2 +1E0
      -2  2  4  1  ; % AFMb  = -2Ja*S^2-2Jb*S^2-4Jab*S^2 +1E0
       2  2 -4  1 ]; % AFMab = -2Ja*S^2-2Jb*S^2-4Jab*S^2 +1E0

for i=1:(length(A)-1)
    A(:,i) = A(:,i)*S^2;
end

B = [171.4e-3/4 ;    % FM    = -2Ja*S^2-2Jb*S^2-4Jab*S^2 +1E0
     184.5e-3/4 ;    % AFMa  = -2Ja*S^2-2Jb*S^2-4Jab*S^2 +1E0
       6.7e-3/4 ;    % AFMb  = -2Ja*S^2-2Jb*S^2-4Jab*S^2 +1E0
         0e-3/4];    % AFMab = -2Ja*S^2-2Jb*S^2-4Jab*S^2 +1E0

format shortG
x=A\B*1000;            % D, J1, J2, J3, λ, E0 (meV)
x
%c = sprintf(' D:   %.3f meV(single ion anisotropy)\n J:  %.3f meV(exchange constant)\n A: %.3f meV(anisotropic exchange)',x(1),x(2),x(3));
%disp(c)
% Ja, Jb, Jab, E0. in meV
