function S=seqbinaire(N,alpha)
    % Two-Row : If ALPHABET is a two-row matrix, the first row defines the
    %     Matrix    possible outputs (as above).  The second row of ALPHABET
    %               specifies the probability for each corresponding element.  The
    %               elements of the second row must sum to one.
     alphabet = [0 1 ; alpha 1-alpha];
     S=randsrc(1,N,alphabet);

    % or more classic version 
    % S = rand(1, N) > alpha;

end