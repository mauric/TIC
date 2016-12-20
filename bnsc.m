function Y=bnsc(X,p1,p2)
    %Simulation du canal asymetrique
    %
    %    X    +--------------------+   Y
    % +-----> |       CANAL        | +----->
    %         +--------------------+
    %




    % Selon le item 2 du sujet nous avons:
    % p(Y=1|X=0)=p1
    % p(Y=0|X=1)=p2
    Y = zeros(1,length(X));

    %% version en utilisant meme function seqbinaire PREND BEAUCOUP DE TEMPS!!

%     for i = 1:length(X)
%         if(X(i) == 0) %en sachant X=0
%                Y(i) =  seqbinaire(1,1-p1); %cette function utilise proba de element 0 de l'alphabet donc 1-p1
%         else             %en sachant X=1
%                Y(i) =  seqbinaire(1,p2);
%         end  
%     end
% 

    %% implementation  plus "simple" 
    for i = 1:length(X)
        if(X(i) == 0) %en sachant X=0
            if rand()< p1 
                Y(i) = 1;  % p(Y=1|X=0)=p1
            else              
                Y(i) = 0; %sinon Y = 0 avec proba = 1-p1
            end
        else             %en sachant X=1
            if rand()< p2
                Y(i) = 0; % p(Y=0|X=1)=p2
            else
                Y(i) = 1; %sinon Y = 0 avec proba = 1-p2
            end      
        end
    end

    %% version en utilisant masquague SUPER RAPIDE MAIS il y a un bug

%     maskp1 = seqbinaire(size(X,2),1-p1);
%     maskp2 = seqbinaire(size(X,2),p2);
%     resmaskp1 = xor(X,maskp1);
%     poszeros = xor(X, ones(1,size(X,2)));
%     resmaskp2 = and(poszeros,maskp2); %il manque une operation ici
%     Y = xor(resmaskp1,resmaskp2);
end