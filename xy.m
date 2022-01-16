function [Ms, Cs, Mx, Es, time1] = xy(model,Lat,J1,J2,J3,D,Sp,L,estep,mstep,Ts,para,kb)
%global model Lat J1 J2 J3 A Sp L estep mstep Ts para kb

Ms = zeros(1, size(Ts,2));
Mx = zeros(1, size(Ts,2));
Es = zeros(1, size(Ts,2));
Cs = zeros(1, size(Ts,2));
const = 0.0;
time1 = 0; time2 = 0; time3 = 0;
newC = zeros(1,3);
%% Generate zero and ones matrix for hexagonal lattice
aones = zeros(L,L,model);
for i = 1:L
    for j = 1:L
        if mod(i-j,2)==1
        aones(i,j,:)=0;
        else
        aones(i,j,:)=1;
        end
    end
end
bar = waitbar(0,'1','Name','Monte-Carlo');
%% Generate a spheracal(uniform) random initial configuration of theta & phi,
%% And the corresponding Cartisian coordinates (without spin!)
gridS = 2*pi*unifrnd(0,1,L,L);
gridC = cat(3, cos(gridS(:,:)), sin(gridS(:,:)));

%% Evolve the system for a fixed number of steps
for t = 1:size(Ts,2)   %change into parfor if parellel
    E0 = 0.0; E1 = 0.0; E2 = 0.0; M0 = 0.0; M1 = 0.0; M2 = 0.0;
    const = 1 / (L^2 * Ts(t) * kb) ;  % factor to be used in specific heat
    %grid = zeros(L);                           % move into parfor if parellel
    %grid(:,:) = initiate(:,:) ;  % deep copy?  % move into parfor if parellel
    %gridS = cat(3,acos(1-2*unifrnd(0,1,L,L)),2*pi*unifrnd(0,1,L,L));
    %gridC = cat(3,sin(gridS(:,:,1)) .* cos(gridS(:,:,2)), ...
    %            sin(gridS(:,:,1)) .* sin(gridS(:,:,2)), ...
    %            cos(gridS(:,:,1))                     );
    str=['Calculating: ',num2str(Ts(t)),'K' , ...
         ' (',num2str(100*t/size(Ts,2)),'%) ', ...
         num2str((size(Ts,2)-t)*time3/60), ' min left'];
    waitbar(t/size(Ts,2),bar,str)
    
    tic
    for i=1:(estep+mstep)
    % Pick a random spin and its touching/testing random direction
    row = randi(L);   % or : linearIndex = randi(numel(grid));
    col = randi(L);   % or : [row, col]  = ind2sub(size(grid), linearIndex);
    gridTS = zeros(1,1);
    gridTC = zeros(1,1,2);
    gridTS(1,1) = 2*pi*unifrnd(0,1,1,1);
    %gridTS(1,1) = gridS(row,col)+pi*unifrnd(0,1,1,1);
    gridTC(1,1,:) = [cos(gridTS), sin(gridTS)];
    
    % Find its Fir/Sec/Thi-Nearest neighbors
    neighbors1=[]; neighbors2=[]; neighbors3=[];
    above1 = mod(row - 1 - 1, size(gridC,1)) + 1;
    below1 = mod(row + 1 - 1, size(gridC,1)) + 1;
    left1  = mod(col - 1 - 1, size(gridC,2)) + 1;
    right1 = mod(col + 1 - 1, size(gridC,2)) + 1;
    
    above2 = mod(row - 1 - 2, size(gridC,1)) + 1;
    below2 = mod(row + 2 - 1, size(gridC,1)) + 1;
    left2  = mod(col - 1 - 2, size(gridC,2)) + 1;
    right2 = mod(col + 2 - 1, size(gridC,2)) + 1;
    
    if Lat == 'c'
        neighbors1 = gridC(above1,    col, :) + ...
                     gridC(below1,    col, :) + ...
                     gridC(row,     left1, :) + ...
                     gridC(row,    right1, :) ;
        neighbors2 = gridC(above1,  left1, :) + ...
                     gridC(above1, right1, :) + ...
                     gridC(below1,  left1, :) + ...
                     gridC(below1, right1, :) ;
        neighbors3 = gridC(above2,    col, :) + ...
                     gridC(below2,    col, :) + ...
                     gridC(row,     left2, :) + ...
                     gridC(row,    right2, :) ;
    elseif Lat == 'h'
        neighbors1 = gridC(above1,    col, :) + ...
                     gridC(below1,    col, :) + ...
                     gridC(row,     left1, :) .* (mod(row-col,2)==1) + ...
                     gridC(row,    right1, :) .* (mod(row-col,2)==0) ;
        neighbors2 = gridC(above2,    col, :) + ...
                     gridC(below2,    col, :) + ...
                     gridC(above1,  left1, :) + ...
                     gridC(above1, right1, :) + ...
                     gridC(below1,  left1, :) + ...
                     gridC(below1, right1, :) ;
        neighbors3 = gridC(row,     left1, :) .* (mod(row-col,2)==0) + ...
                     gridC(row,    right1, :) .* (mod(row-col,2)==1) + ...
                     gridC(above2,  left1, :) .* (mod(row-col,2)==1) + ...
                     gridC(above2, right1, :) .* (mod(row-col,2)==0) + ...
                     gridC(below2,  left1, :) .* (mod(row-col,2)==1) + ...
                     gridC(below2, right1, :) .* (mod(row-col,2)==0) ;
    elseif Lat == 't'
        neighbors1 = gridC(above1,    col, :) + ...
                     gridC(below1,    col, :) + ...
                     gridC(row,     left1, :) + ...
                     gridC(row,    right1, :) + ...
                     gridC(above1,  left1, :) + ...
                     gridC(below1, right1, :) ;
        neighbors2 = gridC(above1, right1, :) + ...
                     gridC(below1,  left1, :) + ...
                     gridC(above2,  left1, :) + ...
                     gridC(below2, right1, :) + ...
                     gridC(above1,  left2, :) + ...
                     gridC(below1, right2, :) ;
        neighbors3 = gridC(above2,    col, :) + ...
                     gridC(below2,    col, :) + ...
                     gridC(row,     left2, :) + ...
                     gridC(row,    right2, :) + ...
                     gridC(above2,  left2, :) + ...
                     gridC(below2, right2, :) ;
    end
    Ea = - 2 * Sp^2 * sum(gridTC(1,1,:)     .* ...
                         (J1 .* neighbors1   + ...
                          J2 .* neighbors2   + ...
                          J3 .* neighbors3)) ;
    Eb = - 2 * Sp^2 * sum(gridC(row,col,:)  .* ...
                         (J1 .* neighbors1   + ...
                          J2 .* neighbors2   + ...
                          J3 .* neighbors3)) ;
    dE = Ea - Eb ;
    % Transition probabilities and performed on the chosen spin
    if dE < 0
    transition = 1;
    else
    transition = (rand() < exp(-dE/(kb*Ts(t))));
    end
    gridC(row,col,:) = gridC(row,col,:) .* (1-transition) + gridTC .* transition;
    % Transform back from Cartisian to Spherecal
    newC = zeros(1,2);
    for in = 1:2
    newC(in) = gridC(row, col, in);
    end
    gridS(row, col) = acos(newC(1)/(sqrt(newC(1)^2+newC(2)^2)+eps));
        
        
    % Calculate total E
    if i == estep
        if Lat == 'c'
            shift1 = circshift(gridC, [ 0  1]) + ...
                     circshift(gridC, [ 1  0]) ;
            shift2 = circshift(gridC, [ 1  1]) + ...
                     circshift(gridC, [ 1 -1]) ;
            shift3 = circshift(gridC, [ 0  2]) + ...
                     circshift(gridC, [ 2  0]) ;
            Eini = -2*Sp^2*sum(sum(sum(gridC      .* ...
                                      (J1 * shift1 + ...
                                       J2 * shift2 + ...
                                       J3 * shift3 ))));
        elseif Lat == 't'
            shift1 = circshift(gridC, [ 0  1]) + ...
                     circshift(gridC, [ 1  0]) + ...
                     circshift(gridC, [ 1  1]) ;
            shift2 = circshift(gridC, [ 1  2]) + ...
                     circshift(gridC, [ 2  1]) + ...
                     circshift(gridC, [ 1 -1]) ;
            shift3 = circshift(gridC, [ 2  0]) + ...
                     circshift(gridC, [ 2  2]) + ...
                     circshift(gridC, [ 0  2]) ;
            Eini = -2*Sp^2*sum(sum(sum(gridC      .* ...
                                      (J1 * shift1 + ...
                                       J2 * shift2 + ...
                                       J3 * shift3 ))));
        elseif Lat == 'h'
            shift1 = circshift(gridC, [ 0 -1]) .* aones + ...
                     circshift(gridC, [ 1  0]) ;
            shift2 = circshift(gridC, [ 1  1]) + ...
                     circshift(gridC, [ 1 -1]) + ...
                     circshift(gridC, [ 2  0]) ;
            shift3 = circshift(gridC, [ 0  1]) .* aones + ...
                     circshift(gridC, [-2 -1]) .* aones + ...
                     circshift(gridC, [ 2 -1]) .* aones ;
            Eini = -2*Sp^2*sum(sum(sum(gridC      .* ...
                                      (J1 * shift1 + ...
                                       J2 * shift2 + ...
                                       J3 * shift3 ))));
        end
    E0 = Eini;
    end
    
        %pick = 1;
    if i > estep %&& mod(i,500) == 0
        E0 =  E0 + dE * (transition == 1);
        E1 =  E1 + E0        ;
        E2 =  E2 + E0^2      ;
        
        M0 =  2 * Sp * sum(sum(gridC(:,:,2)));
        M1 =  M1 + M0        ;
        M2 =  M2 + M0^2      ;
        M0 =  0.0            ;
    end
    % calculate average E&M per site

    % Display the current state of the system (optional)
    %image((grid+1)*128);
    %%xlabel(sprintf('t = %0.2f, M = %0.2f, E = %0.2f', T, M/L^2, E/L^2));
    %set(gca,'YTickLabel',[],'XTickLabel',[]);
    %axis square; colormap bone; drawnow;
    %if mod(i,10000) == 0
    %[x,y] = meshgrid(1:1:L,1:1:L);
    %u = gridC(:,:,1);
    %v = gridC(:,:,2);
    %q=quiver(x,y,u,v); %c=q.Color;
    %q.LineWidth = 0.9; q.AutoScaleFactor = 0.5;
    %xlim([0 L+1]); ylim([0 L+1]);
    %axis square; drawnow;
    %end
    end
    time2 = toc                    ;
    time1 = time1 + time2          ;
    time3 = (time2 + time3*(t-1))/t;
    % Sum up our variables of interest    
    Ms(t) = abs(M1)/(mstep*L^2);
    Mx(t) = (M2/mstep-(M1/mstep)^2)*const;
    Cs(t) = (E2/mstep-(E1/mstep)^2)*const/Ts(t);
    Es(t) =  E1/(mstep*L^2);
    E1 = 0.0; E2 = 0.0;
    M1 = 0.0; M2 = 0.0;
end
close(bar)
%figure;
%[x,y] = meshgrid(1:1:L,1:1:L);
%u = gridC(:,:,1);
%v = gridC(:,:,2);
%q=quiver(x,y,u,v); %c=q.Color;
%q.LineWidth = 1; q.AutoScaleFactor = 0.5; q.MaxHeadSize = 1;
%xlim([0 L+1]); ylim([0 L+1]);
%axis square; drawnow;

% Count the number of clusters of 'spin up' states
%[L, num] = bwlabel(grid == 1, 4);