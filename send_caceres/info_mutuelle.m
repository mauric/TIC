function [IXY]=info_mutuelle(X,Y) 
    %  Fonction pour  Estimation   I(X,Y) = H(Y) - H(Y|X);

    %% Variables
    N = length(X);
    NY = length(Y);
    
    %% Estimation de P(X = 0) et P(X = 1)
    NXones = length(find(X));
    NXzeros = N - NXones ;
    PX1 = NXones/N; %find cherche les elements non nuls
    PX0 = 1 - PX1;

    %% Estimation de P(Y = 0) et P(Y = 1)
    NYones =  length(find(Y));
    NYzeros =  N - NYones;
    PY1 = NYones/NY;
    PY0 = 1 - PY1;

    %% Estimation de probabilités conditional  
    PY1X1 = 0;
    PY1X0 = 0;
    PY0X1 = 0;
    PY0X0 = 0;
    
    for i = 1:N
        %% Estimation de P(Y = 0|X = 0) et P(Y = 0|X = 1) 
        if Y(i)==0 && X(i)== 0
                PY0X0 =  PY0X0 +1;  %% count P(Y = 0|X = 0)
        elseif Y(i)==0 && X(i)==1
            
                PY0X1 = PY0X1+1;    % count P(Y = 0|X = 1                  
        %% Estimation de P(Y = 1X = 0) et P(Y = 1|X = 1) 
        elseif Y(i)==1 && X(i) == 0  
                PY1X0 =  PY1X0 +1;   %count for P(Y = 1X = 0)
        elseif Y(i)==1 && X(i) == 1
                PY1X1 =PY1X1 + 1;   %count for P(Y = 1|X = 1) 
        end
    end
    %utiliser bayes
    PY1X1 = PY1X1/NXones;
    PY1X0 = PY1X0/NXzeros;
    PY0X1 = PY0X1/NXones; 
    PY0X0 = PY0X0/NXzeros;


    %% Estimation de H(Y) = -P(Y=0)log(P(Y=0))-P(Y=1)log(P(Y=1));
    HY = -PY0*log2(PY0)-PY1*log2(PY1);

    %% Estimation de H(Y|X) = 
    HXY = (-PY0X0*log2(PY0X0)-PY1X0*log2(PY1X0))*PX0 +(-PY0X1*log2(PY0X1)-PY1X1*log2(PY1X1))*PX1;

    %% Information Mutuelle estimée
    IXY = HY - HXY;



end