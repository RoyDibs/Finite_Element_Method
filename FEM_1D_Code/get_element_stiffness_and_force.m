function [ke,fe] = get_element_stiffness_and_force(elem,NODE,FE)

fe = zeros(length(elem(1).nodes),1);
ke = zeros(length(elem(1).nodes));

for i=1:length(elem(1).nodes)    
    for j=1:length(elem(1).nodes)
        for kgp=1:size(FE.N,2)
            fe(i,1) = fe(i,1) + (FE.N(i,kgp) * FE.N(j,kgp) * ((elem.jcob(kgp))) * NODE(elem.nodes(1,j)).body_force);
            ke(i,j) = ke(i,j) + ((FE.gradN(i,kgp)) * (FE.gradN(j,kgp)) * (1/elem(1).jcob(kgp,1)));
        end
    end

    
end

%% in matrix form
% for kgp=1:size(FE.N,2)
%     fe = fe + (FE.N(:,kgp) * FE.N(:,kgp)' * ((elem.jcob(kgp))) * [NODE(elem.nodes(1)).body_force;NODE(elem.nodes(2)).body_force]);
%     ke = ke + ((FE.gradN(:,kgp)) * (FE.gradN(:,kgp))' * (1/elem.jcob(kgp,1)));
% end

end