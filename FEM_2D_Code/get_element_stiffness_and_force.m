function [ke,fe] = get_element_stiffness_and_force(elem,NODE,FE)

% Write code here to evaluate element stiffness matrix and force vector
ngp = size(FE.N,2);
xy_Mat = zeros(2,length(elem.nodes));
ke = zeros(length(elem.nodes));
fe = zeros(length(elem.nodes),1);
for i=1:ngp
    for nnode=1:length(elem.nodes)
        xy_Mat(:,nnode) = [NODE(elem.nodes(nnode)).X(1); NODE(elem.nodes(nnode)).X(2)];
    end
    
    jcob_Mat = xy_Mat * [FE.dNdpsi(:,i)  FE.dNdeta(:,i)];

    ke = ke + (( [FE.dNdpsi(:,i) FE.dNdeta(:,i)]/(jcob_Mat) ) * elem.Dmat * ( [FE.dNdpsi(:,i) FE.dNdeta(:,i)]/(jcob_Mat) )' * elem.jcob(i,1));

end


end