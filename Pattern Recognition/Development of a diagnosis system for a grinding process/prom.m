% Function For Gaussain Hypthosis Method
function P_Set_Class = P(Set ,Class_Mean, Class_Cov)
          % Value of d For The formula 
            d=length(Set);         
          % Mahalanobis Distance Of The Class   
            Mahalanobis_Distance =  (Set - Class_Mean )* inv(Class_Cov)*( Set - Class_Mean )';  
          % The Density Probability Of Set In The Class    
            P_Set_Class = exp(-0.5*(Mahalanobis_Distance)) / (power(2*pi,d/2) * sqrt(det(Class_Cov)));
end