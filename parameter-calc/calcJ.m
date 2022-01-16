
S = 2/2;
A = [ -1 -3 -3 1 ;
       0 -3  0 1 ;
      -1  3  3 1 ;
       0  3  0 1 ];
for i=1:3
A(:,i) = A(:,i)*S^2;
end

%B = [-42.14955883/2;   % fmz  = -DS^2-3JS^2-3位S^2+E0
%     -42.13452512/2;   % fmx  =      -3JS^2      +E0
%     -42.10793149/2;   % afmz = -DS^2+3JS^2+3位S^2+E0
%     -42.08399105/2];  % afmx =      +3JS^2      +E0
     
B = [-42.15824598/2;   % fmz  = -DS^2-3JS^2-3位S^2+E0
     -42.14262300/2;   % fmx  =      -3JS^2      +E0
     -42.11621943/2;   % afmz = -DS^2+3JS^2+3位S^2+E0
     -42.10144801/2];  % afmx =      +3JS^2      +E0
     
format shortG
x=A\B*1000;            % meV
c = sprintf(' D:   %.3f meV(single ion anisotropy)\n J:  %.3f meV(exchange constant)\n A: %.3f meV(anisotropic exchange)',x(1),x(2),x(3));
disp(c)
% D, J, λ, E0. in meV
