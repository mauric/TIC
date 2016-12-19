%% TP TIC : Codage de source et optimisation de la capacité du canal
%% Mauricio Caceres


clc
clear all
close all

%% Parametres 
p1 = 0.1;    % probabilites de transition 
p2 = 0.1;    % probabilites de transition
N = 1e6; % valuer pour lequel on obtien une bonne courbe
%N = 6; % pour tester le sequences 

%% boucle principal - variation de alpha
discretisation = 200;
alpha = linspace(0,1,discretisation);
IXYest = zeros(1,discretisation);
IXY = zeros(1,discretisation);

for  i = 1:discretisation
%% generation de sequence binaire
X = seqbinaire(N,alpha(i));

%% simulation du canal asymetrique
Y = bnsc(X,p1,p2); %canal asymetrique


%% Calcul estimation de la information mutuelle
IXYest(i) = info_mutuelle(X,Y);

%% TEST: Decomenter pour comparer comportement avec BSC de matlab si p1=p2
%Y_bsc = bsc(X,0.1); %canal symetrique pour verifier quand p1=p2
%IXYbsc(i) = info_mutuelle(X,Y_bsc);

%% Calcul theorique de l'information mutuelle I(X|Y)
K = alpha(i)*(1-p1)+(1-alpha(i))*p2;
HB = -K*log2(K)-(1-K)*log2(1-K);
A1 = -p1*log2(p1) - (1-p1)*log2(1-p1);
A2 = -p2*log2(p2) - (1-p2)*log2(1-p2);
HAB = A1*alpha(i)+A2*(1-alpha(i));
IXY(i) = HB - HAB;


end


%% GRAPHICS
figure()
plot(alpha,IXY);
hold on 
plot(alpha,IXYest,'r');
E = (IXY - IXYest);
figure()
errorbar(IXY(1,1:4:discretisation),30*E(1,1:4:discretisation))

%% TEST BSC
% figure()
% plot(alpha,IXYbsc,'b');
