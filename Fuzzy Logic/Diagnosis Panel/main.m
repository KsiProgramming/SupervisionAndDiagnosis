close all
clc
clear all
load('data_fuzzy');
a=-1;
b=0;
c=1;
for signal_index=1:length(s)
    x=s(signal_index).residuals;
for(i=1:length(x))

    
            for(j=1:length(x(1,:)))
                        [N(j),Z(j),P(j)]=fuzzy_values(x(i,j),a,b,c);
                        
            end
            
            Not_F(i)    =   1-min([Z(1) Z(2) Z(3)]);
            F_1(i)      =   min( [P(1) Z(2) N(3)] );
            F_2(i)      =   min( [P(1) Z(2) Z(3)] );
            F_3(i)      =   min( [Z(1) P(2) N(3)]);
            Unknow_F(i) =   min( [Not_F(i) 1-F_1(i) 1-F_2(i) 1-F_3(i)] );           
            
end
    M=[Not_F ; F_1 ; F_2 ; F_3 ;  Unknow_F];
    figure(signal_index)
    Zto0 = [0:1/15:1]';
    OtoZ = linspace(1,0,16)';
    map = [[Zto0;ones(16,1)] [ones(16,1);OtoZ] [zeros(32,1)]];
    imagesc(M,[0 1])
    set(gca,'YTick',1:5)
    set(gca,'YTickLabel',{'No Fault';'Fault 1';'Fault 2';'Fault 3';'UnKnown Fault'})
    colormap(map)
    colorbar
    xlabel('Tame Sample')
    title(sprintf('The diagnostic panel for signal %d',signal_index));
    figure(length(s)+1)
    subplot(2,2,signal_index)
    Zto0 = [0:1/15:1]';
    OtoZ = linspace(1,0,16)';
    map = [[Zto0;ones(16,1)] [ones(16,1);OtoZ] [zeros(32,1)]];
    imagesc(M,[0 1])
    set(gca,'YTick',1:5)
    set(gca,'YTickLabel',{'No Fault';'Fault 1';'Fault 2';'Fault 3';'UnKnown Fault'})
    colormap(map)
    colorbar
    xlabel('Time Samples')
    title(sprintf('The diagnostic panel for signal %d',signal_index));

end


