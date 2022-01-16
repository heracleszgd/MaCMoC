%%               __  __        ____ __  __        ____
%%              |  \/  | __ _ / ___|  \/  | ___  / ___|
%%              | |\/| |/ _` | |   | |\/| |/ _ \| |
%%              | |  | | (_| | |___| |  | | (_) | |___
%%              |_|  |_|\__,_|\____|_|  |_|\___/ \____|
%%                                                  V6.1_2021/01/24_inequivalent
%% +---------------------------(y￣▽￣)y---------------------------+
%% |                                                               |
%% |                     Guo-Dong Zhao, Wei Ren                    |
%% |                  ICQMS of Shanghai University                 |
%% |                                                               |
%% |                Contact: heracleszgd@shu.edu.cn                |
%% +---------------------------------------------------------------+

%% 1. Initial Configuration by hand
%global model Lat J1 J2 J3 A Sp L estep mstep Ts para kb
Name   =   'VOCl2'      ; % Report Folder Name
model  =   1            ; % 1: ising; 2: XY; 3: heisenberg; 4: heisenberg+anisotropy_exchange
Lat    =   'c'          ; % Lattice, 'h' for hex, 't' for tri, 'c' for cub
J1     =   0.80e-3      ; % Fir-Nearest Strength of interaction (eV)
J2     = -43.65e-3      ; % Sec-Nearest Strength of interaction (eV)
J3     =   1.24e-3      ; % Thi-Nearest Strength of interaction (eV)
D      =   0            ; % Single ion anisotropy (eV), only for heisenberg
A      =   0            ; % Anisotropy Exchange Lambda (eV), only for heisenberg+anisotropy_exchange
Sp     =   1/2          ; % Sum of Spin
L      =   20           ; % Size of the grid
epass  =   1e3          ; % eqs=esteps for equilibrium
mpass  =   1e3          ; % mcs=msteps for statistic
Ts     =   400:-10:10   ; % [80:-2:2] ; % linspace(100,0,10)  ; % Always in a descending order!
para   =   3            ; % Parallel workers (cores), depending on your CPU, spare one for urself.(revise code)
kb     =   8.617333262145e-5 ; % Boltzmann constant in eV/kelvin  %1.380649e-23 in Joules/kelvin
% (3*S^2*J1/Kb) / (4*1^2/1) = Tc / 2.269 , this is good for estimating Tc. '3' is for hexagonal
% i.e. (3*((2/2)^2)*1.966e-3)*2.269/(4*8.617333262145e-5)
estep  =   epass*L^2    ; % eqs=esteps for equilibrium
mstep  =   mpass*L^2    ; % mcs=msteps for statistic
%need add a time estimation functional

%% 2. Declare the physical quantities
Ms = [] ; % Averaged magnetisation per site per MC step
Cs = [] ; % Specific heat, but carful that it's calculated in S not M
Mx = [] ; % Magnetic Susceptibility, but carful that it's calculated in S not M
Es = [] ; % Energy per site

%% 3. Equlibrium and Monte Carlo Loops
%par = parpool('local',para); % Accelerate with parpool & parfor, 3 cores
%if you want to make it parallel, change the corresponding .m file, e.g. ising.m.

if model == 1
[Ms, Cs, Mx, Es, time1] =      ising(model,Lat,J1,J2,J3,D,Sp,L,estep,mstep,Ts,para,kb);
elseif model == 2       
[Ms, Cs, Mx, Es, time1] =         xy(model,Lat,J1,J2,J3,D,Sp,L,estep,mstep,Ts,para,kb);
elseif model == 3
[Ms, Cs, Mx, Es, time1] = heisenberg(model,Lat,J1,J2,J3,D,Sp,L,estep,mstep,Ts,para,kb);
elseif model == 4
[Ms, Cs, Mx, Es, time1] =    plusl(model,Lat,J1,J2,J3,D,A,Sp,L,estep,mstep,Ts,para,kb);
end

%delete(par)                ; %delete(gcp); % Shutdown the parpool
%Ts=rot90(rot90(Ts));

%% 4. Show 
%where is the Tc and how much time (Sec) taken
[a,b] = max(Cs) ;
c = sprintf('Transition T (K): %.2f \nTime used (min):  %.0f',Ts(b),time1/60);
disp(c)

%% 5. Figure Generation
%Name=num2str(Name);
mkdir(Name);
plotmc(Ts, Ms, Cs, Mx, Es, Sp);
%print(fig,'result','-dtiff');
set(gcf,'PaperPositionMode','auto')
print(['./',Name,'/',Name,'.tif'],'-dtiff','-r0')

f=[Ts', Ms', Cs', Es', Mx'];
%save results.dat f -ascii
fid = fopen(['./',Name,'/',Name,'.dat'],'w');
fprintf(fid,'%12s %12s %12s %12s %12s \n','T','M','Cv','E','Xm');
fprintf(fid,'%12.8e %12.8e %12.8e %12.8e %12.8e \n',f');
fclose(fid);

save(['./',Name,'/',Name,'.mat'])
%clear