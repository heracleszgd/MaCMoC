
S = 2.50/2;
A = [ -4 -4 -6 1;
       4  4 -6 1;
       4 -4  2 1;
      -4  4  2 1];
for i=1:3
A(:,i) = A(:,i)*S^2;
end

B = [-309.44548089/4;   % fm   = -4 Jout S^2 -4 Joutp S^2 -6 Jin S^2 +E0
     -310.06544998/4;   % afm1 = +4 Jout S^2 +4 Joutp S^2 -6 Jin S^2 +E0
     -309.14569139/4;   % afm2 = +4 Jout S^2 -4 Joutp S^2 +2 Jin S^2 +E0
     -309.56770191/4];  % afm3 = -4 Jout S^2 +4 Joutp S^2 +2 Jin S^2 +E0
     
format shortG
x=A\B*1000;            % meV
c = sprintf('%.3f J1-interlayer (meV)\n %.3f J1p-interlayer (meV)\n %.3f J2-intralayer (meV)\n %.3f E0 meV',x(1),x(2),x(3),x(4));%note the order
disp(c)

