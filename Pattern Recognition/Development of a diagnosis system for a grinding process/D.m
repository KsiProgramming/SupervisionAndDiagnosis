% Function For Decision Rule
 function Decision_Rule_Set=D(Option, Cr, Cd,Set,Class_Mean_Faulty, Class_Cov_Faulty,Class_Mean_Normal, Class_Cov_Normal)
          for i = 1 : length(Set) 
             % The Density Probability Of set In The Class Faulty Conditions 
                  P_Set_Faulty =prom(Set(i,1:2) ,Class_Mean_Faulty, Class_Cov_Faulty); 
                % The Density Probability Of set In The Class Normal Conditions 
 P_Set_Normal =prom(Set(i,1:2) ,Class_Mean_Normal, Class_Cov_Normal) ; 
                %Decision For Quastion1  
                   if Option == 1    
                     % The Decision Rule For set   
                          if (P_Set_Faulty > P_Set_Normal) 
                                % The Decision Is Class Faulty
                                 Decision_Rule_Set(i) = 1; 
                          else
                              % The Decision Is Class Normal   
                              Decision_Rule_Set(i) = -1;      
                          end
                          % Decision of Q.2 with Cr=0.4
                    elseif Option == 2          
               % 50/50 Probability between the two classes     
                    P_Set_Faulty_New = P_Set_Faulty / sum(P_Set_Faulty + P_Set_Normal);   
                      P_Set_Normal_New = P_Set_Normal / sum(P_Set_Faulty + P_Set_Normal); 
                        % The Decision Rule For set based on Cr               
              if max(P_Set_Faulty_New,P_Set_Normal_New) < 1-Cr               
                  % The Decision Is Ambiguis   
                              Decision_Rule_Set(i) = 0;   
                          elseif (P_Set_Faulty > P_Set_Normal)  
                               % The Decision Is Class Faulty   
                              Decision_Rule_Set(i) = 1;    
              else
                  % The Decision Is Class Normal    
                             Decision_Rule_Set(i) = -1;      
              end
                   elseif Option == 3    
                     % 50/50 Probability between the two classes  
                           P_Set_Faulty_New = P_Set_Faulty / sum(P_Set_Faulty + P_Set_Normal);  
                           P_Set_Normal_New = P_Set_Normal / sum(P_Set_Faulty + P_Set_Normal);   
                      % Computing the distance            
                 P_D = 0.5*(P_Set_Normal+P_Set_Faulty);   
                      % The Decision Rule For set based on Cr            
                 if(P_D < Cd )  
                              Decision_Rule_Set(i) = 2; 
                             elseif max(P_Set_Faulty_New,P_Set_Normal_New) < 1-Cr  
                               % The Decision Is Ambiguis     
                            Decision_Rule_Set(i) = 0;         
                    elseif (P_Set_Faulty > P_Set_Normal)      
                           % The Decision Is Class Faulty     
                            Decision_Rule_Set(i) = 1;         
                 else
                     % The Decision Is Class Normal      
                           Decision_Rule_Set(i) = -1;    
                 end
                   end
          end
 end
