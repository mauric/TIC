function output=bnsc(data,p1,p2)


maskp1 = seqbinaire(size(data,2),p1)
maskp2 = seqbinaire(size(data,2),p2)

poszeros = xor(data, ones(1,size(data,2)))

resmaskp1 = xor(data,maskp1)

resmaskp2 = and(poszeros,maskp2)

output = xor(resmaskp1,resmaskp2);