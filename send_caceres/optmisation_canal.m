%% TP TIC : Codage de source et optimisation de la capacité du canal
%% Mauricio Caceres


clc
clear all
close all

%% Parametres 
p1 = 0.1;    % probabilites de transition 
p2 = 0.2;    % probabilites de transition
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

Capacite_experimental = max(IXY)

A1 = -p1*log2(p1) - (1-p1)*log2(1-p1)
A2 = -p2*log2(p2) - (1-p2)*log2(1-p2)

%%Calcul de alpha optimale theorique
L = 2^((A1-A2)/(1-p1-p2))
alphaopt = (1-p2*(1+L))/((1-p1-p2)*(1+L));

%%calcul de la capacite
K = alphaopt*(1-p1)+(1-alphaopt)*p2
HBm = -K*log2(K)-(1-K)*log2(1-K)
HABm = A1*alphaopt+A2*(1-alphaopt)
Capacite_theorique = HBm - HABm
Capacite_experimental = max(IXY)
alphaopt



%% GRAPHICS
figure(1)
plot(alpha,IXY);
hold on 
plot(alpha,IXYest,'r');
title('Infomation Mutuelle estimé et theorique','FontSize',12);
xlabel('\alpha','FontSize',12);
ylabel('IXY(\alpha)','FontSize',12);

E = (IXY - IXYest);
figure(2)
errorbar(IXY(1,1:4:discretisation),30*E(1,1:4:discretisation))
grid()
title('Erreur entre courbes (avec facteur d echelle)','FontSize',12);
xlabel('i','FontSize',12);
ylabel('IXY(i)','FontSize',12);




figure(3)
subplot (2, 1, 1)
plot(alpha,IXYest,'r');
colormap (summer ());
grid()
title('Estimation','FontSize',12);
xlabel('\alpha','FontSize',12);
ylabel('IXY(\alpha)','FontSize',12);
subplot (2, 1, 2)
plot(alpha,IXY);
grid()
title('Theorique ','FontSize',12);
xlabel('\alpha','FontSize',12);
ylabel('IXY(\alpha)','FontSize',12);







%% TEST BSC
% figure()
% plot(alpha,IXYbsc,'b');


%% DOCUMENTATION

% sauvegarde les images pour le rapport
h = get(0,'children');
for i=length(h):-1:1
  saveas(h(i), ['canal' num2str(length(h)+1-i)], 'png');
end
