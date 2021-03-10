close all
clear all
clc
load('broyage');
%Q.1- Elaboration of the decision function
%a. Visualisation of XA depending on the two classes.
%Faulty Conditions in [XA] Of The Grinder_DATA and Thepartical_Speratotr_DATA
XA_Faulty = XA(find(XA(:,3) == 1),1:2);
%Normal Conditions in [XA] Of The Grinder_DATA and Thepartical_Speratotr_DATA
XA_Normal = XA(find(XA(:,3) == -1),1:2);
%Plot XA in 2Dspace
figure(1)
plot(XA_Faulty(:,1),XA_Faulty(:,2),'r*',XA_Normal(:,1),XA_Normal(:,2),'b* ');
legend('Faulty  Examples','Normal Examples');
title('XA in 2D space');
%b. Building The Decision Function
% The mean of Class Faulty Condition
Mean_Faulty = mean(XA_Faulty);
% The Covariance Of Class Faulty Conditions
Cov_Faulty  = cov(XA_Faulty);
% The mean of Class Faulty Condition
Mean_Normal = mean(XA_Normal);
% The Covariance Of Class Faulty Conditions
Cov_Normal  = cov(XA_Normal);
% Gaussain Hypthosis Method
% The Density Probability Of [XV] Function ==> prom.m
% Decision Rule Function ==> D.m
% Decision of XV in Time
Option = 1;
Cr = 0;
Cd=0;
Decision_Rule_XV=D(Option, Cr, Cd,XV,Mean_Faulty, Cov_Faulty,Mean_Normal, Cov_Normal);
figure(2)
plot([find(Decision_Rule_XV == 1)],1,'r*',[find(Decision_Rule_XV == -1)],-1,'g*');
xlabel('Time');
ylabel('Decision');
legend(' 1 ==> Faulty  Examples','-1 ==> Normal Examples');
title('XV in Time');
% Decision of SV in 2D Space
figure(3)
gscatter(XV(:,1),XV(:,2),Decision_Rule_XV,'gr','**');
title('XV in 2D Space');
% The Confusion Matrix of XV
Confusion_Matrix_XV = [sum((XV(:,3)' == -1) & (Decision_Rule_XV == -1)) , sum((XV(:,3)'== -1) & (Decision_Rule_XV== 1));sum((XV(:,3)'== 1)  &  (Decision_Rule_XV== -1)) ,sum((XV(:,3)'== 1) & (Decision_Rule_XV== 1))];
%%Q.2
%% Ambiguity rejection
% Decision of XV With Cr=0.4
Option=2;
Cr=0.4;
Decision_Rule_XV_Ambguise =D(Option, Cr, Cd,XV,Mean_Faulty, Cov_Faulty,Mean_Normal, Cov_Normal);
% The confusion Matrix for Cr=0.4
Confusion_Matrix_XV_cr0_4 = [sum((XV(:,3)' == -1) & (Decision_Rule_XV_Ambguise == -1)) , sum((XV(:,3)'== -1) & (Decision_Rule_XV_Ambguise== 1))
    ;sum((XV(:,3)'== 1)  &  (Decision_Rule_XV_Ambguise== -1)) ,sum((XV(:,3)'== 1) & (Decision_Rule_XV_Ambguise== 1))];
% The Decision in 2D
figure(4)
gscatter(XV(:,1),XV(:,2),Decision_Rule_XV_Ambguise,'gyr','*.*');
title('XV in 2D Space, Cr=0.4');
% The Decision In Time
figure(5)
plot([find(Decision_Rule_XV_Ambguise == 1)],1,'r*')
hold on;
plot([find(Decision_Rule_XV_Ambguise == -1)],-1,'g*');
hold on;
plot([find(Decision_Rule_XV_Ambguise == 0)],0,'yo');
xlabel('Time');
ylabel('Decision');
legend(' 1 ==> Faulty  Samples','-1 ==> Normal Samples','2 ==> Ambiguity Rejected Samples');
% Decision of XV With Cr=0.05
Option=2;
Cr=0.01;
Decision_Rule_XV_Ambguise=D(Option,Cr,Cd,XV,Mean_Faulty, Cov_Faulty,Mean_Normal, Cov_Normal);
% The Decision in 2D
figure(6)
gscatter(XV(:,1),XV(:,2),Decision_Rule_XV_Ambguise,'gyr','*.*');
title('XV in 2D Space, Cr=0.01');
% The Decision In Time
figure(7)
plot([find(Decision_Rule_XV_Ambguise == 1)],1,'r*')
hold on;
plot([find(Decision_Rule_XV_Ambguise == -1)],-1,'g*');
hold on;
plot([find(Decision_Rule_XV_Ambguise == 0)],0,'y.');
xlabel('Time');
ylabel('Decision');
legend(' 1 ==> Faulty  Examples','-1 ==> Normal Examples','0 ==> Ambiguis Rejected Examples');
% Decision of XV With Cr=0.14
Option=2;
Cr=0.14;
Decision_Rule_XV_Ambguise=D(Option,Cr,Cd,XV,Mean_Faulty, Cov_Faulty,Mean_Normal, Cov_Normal);
% The confusion Matrix for Cr=0.14
Confusion_Matrix_XV_cr1_4 = [sum((XV(:,3)' == -1) & (Decision_Rule_XV_Ambguise == -1)) , sum((XV(:,3)'== -1) & (Decision_Rule_XV_Ambguise== 1));sum((XV(:,3)'== 1)  &  (Decision_Rule_XV_Ambguise== -1)) ,sum((XV(:,3)'== 1) & (Decision_Rule_XV_Ambguise== 1))];
% The Decision in 2D
figure(8)
gscatter(XV(:,1),XV(:,2),Decision_Rule_XV_Ambguise,'gyr','*.*');
title('XV in 2D Space, Cr=0.14');
%% Distance Rejection:
Option=3;
% Decision Rule For XV2
Cr = 0.4;
Cd = 1/1000;
Decision_Rule_XV2 = D(Option,Cr,Cd,XV2,Mean_Faulty, Cov_Faulty,Mean_Normal, Cov_Normal);
% Plot The Decision In Time
figure(9)
plot([find(Decision_Rule_XV2 == -1)],1,'g*',[find(Decision_Rule_XV2 == 0)],0,'bo',[find(Decision_Rule_XV2 == 1)],1,'r*',[find(Decision_Rule_XV2 == 2)],2,'yo');
xlabel('Time');
ylabel('Decision');
legend(' -1 ==> Normal  Samples',' 0 ==> Ambiguity Rejection',' 1 ==> Faulty  Samples','2 ==> Distance Rejected Samples');
title('XV2 in time, Cd=0.0001');
%% The confusion Matrix For Cd=0.001
Confusion_Matrix_XV_cd00_1 = [sum((XV2(:,3)' == -1) & (Decision_Rule_XV2 == -1)) , sum((XV2(:,3)'== -1) & (Decision_Rule_XV2== 1));sum((XV2(:,3)' == 1)  &  (Decision_Rule_XV2== -1)) ,sum((XV2(:,3)'== 1) & (Decision_Rule_XV2 == 1))];
% Plot The Decision in 2D space
figure(10)
gscatter(XV2(:,1),XV2(:,2),Decision_Rule_XV2,'gbry','*.*.');
title('XV2 in 2D space, Cd=0.0001');
%New Decision Rule For XV2
Cr = 0.4;
Cd = 1/100;
Decision_Rule_XV2_New = D(Option,Cr,Cd,XV2,Mean_Faulty, Cov_Faulty,Mean_Normal, Cov_Normal);
% Plot The New Decision in 2D space
figure(11)
gscatter(XV2(:,1),XV2(:,2),Decision_Rule_XV2_New,'gbry','*.*.');
title('XV in 2D Space, Cr=1/100');
