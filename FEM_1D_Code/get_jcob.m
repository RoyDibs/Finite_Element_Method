function [jcob] = get_jcob(FE,xe)

ngp = size(FE.N,2);
jcob = zeros(ngp,1);
for i=1:ngp
    dN1dpsi = FE.gradN(1,i); dN2dpsi = FE.gradN(2,i);
    jcob(i,1) = dN1dpsi*xe(1)+dN2dpsi*xe(2);
end