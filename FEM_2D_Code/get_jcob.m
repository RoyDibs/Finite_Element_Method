function [j] = get_jcob(FE,ELEM,NODE,ielem)

ngp = size(FE.N,2);
jcob = zeros(ngp,1);
for i=1:ngp
    for nnode=1:length(ELEM(ielem).nodes)
        xy_Mat(:,nnode) = [NODE(ELEM(ielem).nodes(nnode)).X(1); NODE(ELEM(ielem).nodes(nnode)).X(2)];
    end

    jcob = xy_Mat * [FE.dNdpsi(:,i)  FE.dNdeta(:,i)];
    j(i,1) = det(jcob);
end


end