%%          __  __        ____ __  __            _____ ____
%%         |  \/  | __ _ / ___|  \/  | ___   ___|___ /|  _ \
%%         | |\/| |/ _` | |   | |\/| |/ _ \ / __| |_ \| | | |
%%         | |  | | (_| | |___| |  | | (_) | (__ ___) | |_| |
%%         |_|  |_|\__,_|\____|_|  |_|\___/ \___|____/|____/
%%                                                  V0.2_2026/03/21
%% +---------------------------(y￣▽￣)y---------------------------+
%% |                                                               |
%% |                     Guo-Dong Zhao, Wei Ren                    |
%% |                  ICQMS of Shanghai University                 |
%% |                                                               |
%% |                  Contact: heracles@shu.edu.cn                 |
%% +---------------------------------------------------------------+

%% 1. Initial Configuration by hand
%global model Lat J1 J2 J3 A Sp L estep mstep Ts para kb
Name   =   'HH_fine'        ; % File Name
model  =   3           ; % 1: ising; 3: Heisenberg (SIA)
Lat    =   "tVCHH"     ; % Lattice. 'c' for cub, 't' for tiangle_ABC_staking on [111] plane (only NN/J1)
                                  % 'cab' = 't', for cubic_AB on [001] plane
                                  % 'tVCHH' triangle inplane, for CV, AB staking V_lattice, interlayer_right/below/rightbelow
                                  % 'tVCNH' triangle inplane, HH configuration

J1     =  -8.292e-3    ; % Fir-Nearest Strength of interaction (eV)
J2     =   3.566e-3    ; % Sec-Nearest Strength of interaction (eV)
J3     =   0           ; % Thi-Nearest Strength of interaction (eV)
D      =  -0.6e-3      ; % Single ion anisotropy (eV), only for heisenberg
Sp     =   2.63/2      ; % Sum of Spin
L      =   10           ; % Size of grid
epass  =   1e4         ; % eqs=esteps for equilibrium
mpass  =   1e4         ; % mcs=msteps for statistic
Ts     =   1600:-50:50 ; %[80:-2:2] ; % linspace(100,0,10)  ; % Always in a descending order!
para   =   3           ; % Parallel workers (cores), depending on your CPU, spare one for urself
kb     =   8.617333262145e-5 ; % Boltzmann constant in eV/kelvin  %1.380649e-23 in Joules/kelvin
% (3*S^2*J1/Kb) / (4*1^2/1) = Tc / 2.269 , this is good for estimating Tc. '3' is for hexagonal
% i.e. (3*((2/2)^2)*1.966e-3)*2.269/(4*8.617333262145e-5)
estep  =   epass*L^3    ; % eqs=esteps for equilibrium
mstep  =   mpass*L^3    ; % mcs=msteps for statistic
%need add a time estimation functional

%% 2. Declare the physical quantities
Ms = [] ; % Averaged magnetisation per site per MC step
Cs = [] ; % Specific heat, but carful that it's calculated in S not M
Mx = [] ; % Magnetic Susceptibility, but carful that it's calculated in S not M
Es = [] ; % Energy per site

%% 3. Equlibrium and Monte Carlo Loops
%par = parpool('local',para); % Accelerate with parpool & parfor, 3 cores
%if you want to make it parallel, change the corresponding .m file, e.g. ising.m.
tic

if model == 1
[Ms, Cs, Mx, Es] =       ising3d(model,Lat,J1,J2,J3,Sp,L,estep,mstep,Ts,para,kb);
elseif model == 3
[Ms, Cs, Mx, Es] =  heisenberg3d(model,Lat,J1,J2,J3,D,Sp,L,estep,mstep,Ts,para,kb);
end

time1=toc;
%delete(par)                ; %delete(gcp); % Shutdown the parpool

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