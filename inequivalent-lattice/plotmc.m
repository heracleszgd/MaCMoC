function plotmc(Ts, Ms, Cs, Mx, Es, Sp)
%global Sp
%close all;

%h = quiver3(0,0,0, 1,1,1,1);
%set(h,'maxheadsize',3);  %set the size

%plot ([0,5],[3,3]) plot grid lines

%% Figure Generation 
figure('color',[1 1 1]); 
set(gcf,'position',[200,300,1280,1024])

xmin = min(Ts) - (max(Ts)-min(Ts))/16;
xmax = max(Ts) + (max(Ts)-min(Ts))/16;

mmax = 2*Sp*(1+1/16);
mmin = -1/16;
cmin = min(Cs) - (max(Cs)-min(Cs))/16;
cmax = max(Cs) + (max(Cs)-min(Cs))/16;
Xmin = min(Mx) - (max(Mx)-min(Mx))/16;
Xmax = max(Mx) + (max(Mx)-min(Mx))/16;
emin = min(Es) - (max(Es)-min(Es))/16;
emax = max(Es) + (max(Es)-min(Es))/16;

subplot(2,2,1); % Magnetization per site, versus temperature
plot(Ts, Ms, 'bo', 'MarkerFaceColor', 'b', 'MarkerSize', 10);
set(gca,'linewidth',2,'fontsize',24,'fontname','Times New Roman');
ylabel('Magnetization');
xlabel('Temperature');
xlim([xmin xmax]);
%ylim([mmin mmax]);
%pbaspect([2 1 1]);
title('Mz - T');
%print(gcf, '-depsc2', 'ising-magnetization');

subplot(2,2,3); % Specific Heat, versus Temperature
plot(Ts, Cs, 'bo', 'MarkerFaceColor', 'b', 'MarkerSize', 10);
set(gca,'linewidth',2,'fontsize',24,'fontname','Times New Roman');
ylabel('Specific Heat');
xlabel('Temperature');
xlim([xmin xmax]);
ylim([cmin cmax]);
%pbaspect([2 1 1]);
title('Cv - T');

subplot(2,2,2); % Magnetic Susceptibility, versus Temperature
plot(Ts, Mx, 'bo', 'MarkerFaceColor', 'b', 'MarkerSize', 10);
set(gca,'linewidth',2,'fontsize',24,'fontname','Times New Roman');
ylabel('Susceptibility');
xlabel('Temperature');
xlim([xmin xmax]);
ylim([Xmin Xmax]);
%pbaspect([2 1 1]);
title('Xm - T');

subplot(2,2,4); % Average Energy, versus Temperature
plot(Ts, Es, 'bo', 'MarkerFaceColor', 'b', 'MarkerSize', 10);
set(gca,'linewidth',2,'fontsize',24,'fontname','Times New Roman');
ylabel('Energy');
xlabel('Temperature');
xlim([xmin xmax]);
ylim([emin emax]);
%pbaspect([2 1 1]);
title('E - T');

end