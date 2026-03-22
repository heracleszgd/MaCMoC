
S = 2.63/2;
A = [ -6 -6  1;
       6 -6  1;
      -2  2  1;
       2  2  1];
for i=1:3
A(:,i) = A(:,i)*S^2;
end

B = [-309.53864011/4;   % fm   = -6 Jout S^2 -6 Jin S^2 +E0
     -310.10117986/4;   % afm1 =  6 Jout S^2 -6 Jin S^2 +E0
     -309.44896625/4;   % afm2 = -2 Jout S^2 +2 Jin S^2 +E0
     -309.83427311/4];  % afm3 = +2 Jout S^2 +2 Jin S^2 +E0
     
format shortG
x=A\B*1000;            % meV
c = sprintf('%.3f J1-interlayer (meV)\n %.3f J2-intralayer (meV)\n %.3f E0 meV',x(1),x(2),x(3));%note the order
disp(c)

