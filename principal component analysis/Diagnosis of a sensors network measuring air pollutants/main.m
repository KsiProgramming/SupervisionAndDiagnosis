close all
clear all
clc

% Loading the data
    load('sensor');

    %% Q.1 ACP MODEL
    %1. The temporal visualation of some pollutants
        %==> Creating time Interval
            Sampling_Time = 15; %[Minutes]
            Size_Samples = length(X1(1,:));
            T_min=0:Sampling_Time:(Size_Samples-1)*Sampling_Time;
            T_hours = T_min/60 ;  % 1hour = 60 minutes
        %==> The plots
            figure()
                plot(T_hours,X1(1,:),'r',T_hours,X1(2,:),'b',T_hours,X1(3,:),'g');
                xlabel('Time_{[Hour]}');
                set(gca,'FontSize',16);
                ylabel('Sensors Measurements');
                set(gca,'FontSize',16);
                legend('Ozon Measurements','Nitrogen Oxyde Measurements','Dioxyde Measurements');
                set(gca,'FontSize',16);
                title('The Temporal Evoluation Of Pollutants in Location 1');
                set(gca,'FontSize',16);
%             figure()
%                 plot(T_min,X1(1,:),'r',T_min,X1(2,:),'b',T_min,X1(3,:),'g');
%                 xlabel('Time_{[Minute]}');
%                 ylabel('Sensors Measurements');
%                 legend('Ozon Measurements','Nitrogen Oxyde Measurements','Dioxyde Measurements');
%                 title('The Temporal Evoluation Of Pollutants');
            l1=1:3:18;  
            l2=2:3:18;
            l3=3:3:18;
            figure ()
            plot(1:length(X1),X1(l1,:));    %Ozon measurements across 6 locations
            xlabel('Time_{[Hour]}');
            set(gca,'FontSize',16);
            ylabel('Sensors Measurements');
            set(gca,'FontSize',16);
            legend('Location 1','Location 2','Location 3','Location 4','Location 5','Location 6');
            set(gca,'FontSize',16);
            title('The Temporal Evoluation Of Ozon across 6 locations');
            set(gca,'FontSize',16);
            figure ()
            plot(1:length(X1),X1(l2,:));    %Nitrogen oxyde measurements across 6 locations
            xlabel('Time_{[Hour]}');
            set(gca,'FontSize',16);
            ylabel('Sensors Measurements');
            set(gca,'FontSize',16);
            legend('Location 1','Location 2','Location 3','Location 4','Location 5','Location 6');
            set(gca,'FontSize',16);
            title('The Temporal Evoluation Of Nitrogen Oxyde across 6 locations');
            set(gca,'FontSize',16);
            figure ()
            plot(1:length(X1),X1(l3,:));    %Dioxyde measurements across 6 locations
            xlabel('Time_{[Hour]}');
            set(gca,'FontSize',16);
            ylabel('Sensors Measurements');
            set(gca,'FontSize',16);
            legend('Location 1','Location 2','Location 3','Location 4','Location 5','Location 6');
            set(gca,'FontSize',16);
            title('The Temporal Evoluation Of Dioxyde across 6 locations');
            set(gca,'FontSize',16);

    %2. Centering And Normalizing The Data
        Mean_X1 = mean(X1')';
        Std_X1  = std(X1')';
        for i=1:Size_Samples
            Norm_X1(:,i) = (X1(:,i)-Mean_X1)./(Std_X1);
        end
        
    %3. Computing The Covaraince Of X1 centered and Normalized
        Cov_X1 = (Norm_X1*Norm_X1')/(length(Norm_X1(1,:)-1));
        
    %4. The EigenVectors And The EigenValue of The Cov Matrix
        [P,lambda,P] = svd(Cov_X1);
        
    %5. Plotting The cumulative Sum Of The Eigen Values
        figure()
                imagesc(diag(Cov_X1))
                colormap hsv
                colorbar
                xlabel('Proportion Of Variance Matrix Diag');
                set(gca,'FontSize',16);
                ylabel('Components(Axis)');
                set(gca,'FontSize',16);
                title('Proportion of Diag Matrix varianceFor Each Component');
                set(gca,'FontSize',16);
        figure()
                bar(cumsum(diag(lambda))/length(Norm_X1(:,1)))
                xlabel('Axis');
                set(gca,'FontSize',16);
                ylabel('Proportion of variance expressed');
                set(gca,'FontSize',16);
                title('Proportion of variance expressed by each axis');
                set(gca,'FontSize',16);
        
    %6. The Projection Of Each Vector In X1 on 12 Components Frame
        New_P = P(:,1:12);                                       %P(q)
        Pr_Comp_X1 = New_P'*Norm_X1;                                %12 Principas components C(q)
        Mean_P = mean(Pr_Comp_X1');                                 %Mean of C(q)
        Cov_P  = cov(Pr_Comp_X1');                                  %Covariance of C(q)
        M_dist = (Pr_Comp_X1)'*inv(lambda(1:12,1:12))*(Pr_Comp_X1);     %Mahalanobis distance
        M_dist_mean = mean(diag(M_dist));
        M_dist_std = std(diag(M_dist));
        
%         Ma_dist = sqrt((Pr_Comp_X1-Mean_P)*inv(Cov_P)*(Pr_Comp_X1-Mean_P)');
        %figure()
        %plot(T_hours,diag(M_dist));
        
     %7. The Estimation of X1,X^1
        Estm_X1 = New_P * Pr_Comp_X1;
        Eucl_dist = (Estm_X1-Norm_X1)'*(Estm_X1-Norm_X1);
        Eucl_dist_mean = mean(diag(Eucl_dist));
        Eucl_dist_std = std(diag(Eucl_dist));
        figure()
        subplot(3,1,1);
        plot(T_hours,Estm_X1(1,:),T_hours,Norm_X1(1,:));
        xlabel('Time (hours)');
        %set(gca,'FontSize',16);
        ylabel('O3 concentration');
        %set(gca,'FontSize',16);
        title('Reconstruction and true measurements of ozon concentration in location 1');
        %set(gca,'FontSize',16);
        legend('Estimated O3 concentration','True O3 concentration');
        %set(gca,'FontSize',16);
        subplot(3,1,2);
        plot(T_hours,Estm_X1(2,:),T_hours,Norm_X1(2,:));
        xlabel('Time (hours)');
        %set(gca,'FontSize',16);
        ylabel('NO2 concentration');
        %set(gca,'FontSize',16);
        title('Reconstruction and true measurements of NO2 concentration in location 1');
        %set(gca,'FontSize',16);
        legend('Estimated NO2 concentration','True NO2 concentration');
        %set(gca,'FontSize',16);
        subplot(3,1,3);
        plot(T_hours,Estm_X1(3,:),T_hours,Norm_X1(3,:));
        xlabel('Time (hours)');
        %set(gca,'FontSize',16);
        ylabel('CO2 concentration');
        %set(gca,'FontSize',16);
        title('Reconstruction and true measurements of CO2 concentration in location 1');
        %set(gca,'FontSize',16);
        legend('Estimated CO2 concentration','True CO2 concentration');
        %set(gca,'FontSize',16);
        
        %8. Square Norm (Squared Prediction Error)  
        Q = (Norm_X1-Estm_X1)'*(Norm_X1-Estm_X1);
        
%%Part.2 Fault Detection
    %Q.1 Applying the ACP model On X2
        %% Creating The Time Interval
            Size_Samples_X2 = length(X2(1,:));
            T_min_X2=0:Sampling_Time:(Size_Samples_X2-1)*Sampling_Time;
            T_hours_X2 = T_min_X2/60 ;  % 1hour = 60 minutes
            
            for i=1:length(T_hours_X2)
                Norm_X2(:,i) = (X2(:,i)-Mean_X1)./Std_X1;
                Pr_Comp_X2(:,i) = New_P'*Norm_X2(:,i);
                %% Malalobinos Distance Checking
                M_dist_X2(i) = (Pr_Comp_X2(:,i))'*inv(lambda(1:12,1:12))*(Pr_Comp_X2(:,i));
                if M_dist_X2(i)> 12
                    X2_Decision(i) = 1;
                else
                    X2_Decision(i) = 0;
                end
                %Decision based onquared estimation error 
                    Estm_X2(:,i) = New_P * Pr_Comp_X2(:,i);     %Slide27
                %%Eucliedien Checking
                    Eucludien_Dist2(i) = (Estm_X2(:,i)-Norm_X2(:,i))'*(Estm_X2(:,i)-Norm_X2(:,i));
                    if Eucludien_Dist2(i)> 1      
                        Eu_decision(i) = 1;
                    else
                        Eu_decision(i) = 0;
                    end
                
                Q_X2(i)=(Estm_X2(:,i)-Norm_X2(:,i))'*(Estm_X2(:,i)-Norm_X2(:,i));
                if Q_X2(i)> (0.99*Mean_X1/(2*Std_X1))
                    X2_Decision2(i) = 1;
                else
                    X2_Decision2(i) = 0;
                end
                
            end
            figure()
                    plot(T_hours, diag(M_dist),'b',T_hours_X2,M_dist_X2,'g','LineWidth',2)
                    xlabel('Time_{[Hours]}')
                    ylabel('Concentration')
                    legend('Learning set', 'Evaluated set');
                    title('Learning Set vs Evaluated set In Malalobinos Distance')
            figure()
                    plot(T_hours, diag(M_dist),'b',T_hours_X2,M_dist_X2,'g',...
                        T_hours,12*ones(length(T_hours)),'r','LineWidth',2)
                    xlabel('Time_{[Hours]}')
                    ylabel('Concentration')
                    legend('Learning set', 'Evaluated set','Threshold ==12');
                    title('Learning Set vs Evaluated set With Threshold')
            figure()
                    plot(T_hours, diag(Eucl_dist),'b',T_hours_X2,Eucludien_Dist2,'g','LineWidth',2)
                    xlabel('Time_{[Hours]}')
                    ylabel('Concentration')
                    legend('Learning set', 'Evaluated set');
                    title('Learning Set vs Evaluated set In Eucludien Distance')
            figure()
                    plot(T_hours, diag(Eucl_dist),'b',T_hours_X2,Eucludien_Dist2,'g',...
                        T_hours,1*ones(length(T_hours)),'r','LineWidth',2)
                    xlabel('Time_{[Hours]}')
                    ylabel('Concentration')
                    legend('Learning set', 'Evaluated set','Threshold ==1');
                    title('Learning Set vs Evaluated set With Threshold')
            figure()
                    plot(find(X2_Decision==1),1,'*r');
                    hold on 
                    plot(find(X2_Decision==0),0,'*g');
                    xlabel('Iterations');
                    xlim([0 559]);
                    yticks([0 1]);
                    set(gca,'FontSize',16);
                    ylabel('Decision');
                    set(gca,'FontSize',16);
                    title('Decision system based on Mahalanobis distance, Th=12');
                    set(gca,'FontSize',16);
                    legend('1 ==> Faulty','0==> Normal');
                   
            figure()
                    plot(find(Eu_decision==1),1,'*r');
                    hold on 
                    plot(find(Eu_decision==0),0,'*g');
                    xlabel('Iterations');
                    xlim([0 559]);
                    yticks([0 1]);
                    set(gca,'FontSize',16);
                    ylabel('Decision');
                    set(gca,'FontSize',16);
                    title('Decision system based on Eucludien Distance, TH=1');
                    set(gca,'FontSize',16);
                    legend('1 ==> Faulty','0==> Normal');
                    
            figure()
            plot(T_hours_X2,X2_Decision2,'*b')
            xlabel('Time (hours)');
            set(gca,'FontSize',16);
            ylabel('Decision');
            set(gca,'FontSize',16);
            title('Decision system based on squared prediction error');
            set(gca,'FontSize',16);
 

%%Part3. Fault Localisation

V = New_P*New_P';
Den=0;
for i=1:18
    V = New_P*New_P';
    Den=1/(1-V(i,i));
    V(i,i)=0;
    Z_r(i,:) = V(i,:)*X2*Den;
end
V = New_P*New_P';

%Sensor 7 (ozon in location 3) with X1 
figure()
subplot(2,1,1);
plot(T_hours,X1(7,:),T_hours,Z_r(7,1:558))
xlabel('Time (hours)');
set(gca,'FontSize',16);
ylabel('Ozon concentration');
set(gca,'FontSize',16);
title('Ozon concentration in location 3');
set(gca,'FontSize',16);
legend('Values from normal situation','Values from estimated faulty situation');
set(gca,'FontSize',16);
%Sensor 7 with X2 
subplot(2,1,2);
plot(T_hours_X2,X2(7,:),T_hours_X2,Z_r(7,:))
xlabel('Time (hours)');
set(gca,'FontSize',16);
ylabel('Ozon concentration');
set(gca,'FontSize',16);
title('Ozon concentration in location 3');
set(gca,'FontSize',16);
legend('Values from faulty situation','Values from estimated faulty situation');
set(gca,'FontSize',16);
%Sensor 8 (nitrogen oxyde in location 3) with X1
figure()
subplot(2,1,1);
plot(T_hours,X1(8,:),T_hours,Z_r(8,1:558))
xlabel('Time (hours)');
set(gca,'FontSize',16);
ylabel('Nitrogen oxyde concentration');
set(gca,'FontSize',16);
title('Nitrogen oxyde concentration in location 3');
set(gca,'FontSize',16);
legend('Values from normal situation','Values from estimated faulty situation');
%Sensor 8 with X2 
subplot(2,1,2);
plot(T_hours_X2,X2(8,:),T_hours_X2,Z_r(8,:))
xlabel('Time (hours)');
set(gca,'FontSize',16);
ylabel('Nitrogen oxyde concentration');
set(gca,'FontSize',16);
title('Nitrogen oxyde concentration in location 3');
set(gca,'FontSize',16);
legend('Values from faulty situation','Values from estimated faulty situation');
set(gca,'FontSize',16);

%Xr7
Xr7 = X2;
Xr7(7,:) = Z_r(7,:);
Estm_X7 = V * Xr7;
Estm_X8 = V * Xr7;

%Xr8
Xr8 = X2;
Xr8(8,:) = Z_r(8,:);
Estm_X7_2 = V * Xr8;
Estm_X8_2 = V * Xr8;

figure()
subplot(2,1,1)
plot(T_hours_X2,Estm_X7(7,:),T_hours_X2,X2(7,:))
xlabel('Time (hours)');
set(gca,'FontSize',16);
ylabel('Sensor 7 Measurements');
set(gca,'FontSize',16);
title('Estimated sensor 7 measurements from Xr7 and with true measurements ');
set(gca,'FontSize',16);
legend('Estimated sensor measurements','True sensor measurements');
set(gca,'FontSize',16);
subplot(2,1,2)
plot(T_hours_X2,Estm_X8(8,:),T_hours_X2,X2(8,:))
xlabel('Time (hours)');
set(gca,'FontSize',16);
ylabel('Sensor 8 Measurements');
set(gca,'FontSize',16);
title('Estimated sensor 8 measurements from Xr7 and with true measurements ');
set(gca,'FontSize',16);
legend('Estimated sensor measurements','True sensor measurements');
set(gca,'FontSize',16);

figure()
subplot(2,1,1)
plot(T_hours_X2,Estm_X7_2(7,:),T_hours_X2,X2(7,:))
xlabel('Time (hours)');
set(gca,'FontSize',16);
ylabel('Sensor 7 Measurements');
set(gca,'FontSize',16);
title('Estimated sensor 7 measurements from Xr8 and with true measurements ');
set(gca,'FontSize',16);
legend('Estimated sensor measurements','True sensor measurements');
set(gca,'FontSize',16);
subplot(2,1,2)
plot(T_hours_X2,Estm_X8_2(8,:),T_hours_X2,X2(8,:))
xlabel('Time (hours)');
set(gca,'FontSize',16);
ylabel('Sensor 8 Measurements');
set(gca,'FontSize',16);
title('Estimated sensor 8 measurements from Xr8 and with true measurements ');
set(gca,'FontSize',16);
legend('Estimated sensor measurements','True sensor measurements');
set(gca,'FontSize',16);
