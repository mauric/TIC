%% TP TIC
% Codage de source et optimisation de la capacité du canal

% Ecrire une fonction Matlab permettant d’engendrer une séquence binaire (pseudo) aléatoire
% { } de longueur
%  paramétrable. Cette fonction prendra également en entrée le
% paramètre =
%  =0 .
alpha = 0.5
p1 = 0.1
p2 = 0.2
N = 6
S = seqbinaire(N,alpha)

output_bsc = bsc(S,0.5)
output = bnsc(S,p1,p2)


K = alpha*(1-p1)+(1-alpha)*p2
HB = -K*log2(K)-(1-K)*log2(1-K);
A1 = -p1*log(p1) - (1-p1)*log2(1-p1);
A2 = -p2*log(p2) - (1-p2)*log2(1-p2);
HAB = A1*alpha+A2*(1-alpha);
I = HB - HAB;


%%----------------------------
% Estimation

K = alpha*(1-p1e)+(1-alpha)*p2e
HB = -K*log2(K)-(1-K)*log2(1-K);
A1 = -p1e*log(p1e) - (1-p1e)*log2(1-p1e);
A2 = -p2e*log(p2e) - (1-p2e)*log2(1-p2e);
HAB = A1*alpha+A2*(1-alpha);
Iest = HB - HAB;