function [bigk,fext] = assemble_system(ELEM,NODE,FE,PARAMS)

% initialize stiffness and force matrices
fext = zeros(length(NODE),1);
bigk = zeros(length(NODE),length(NODE));

% assemble system
for ielem=1:length(ELEM)

    % evaluate element force vector
    [ke,fe] = get_element_stiffness_and_force(ELEM(ielem),NODE,FE);
    
    % apply Dirichlet BCs on ke and fe
    if(~PARAMS.global_bc)
        [ke,fe] = apply_bc_elem(ELEM(ielem),ke,fe,NODE);
    end
    
    

    % assemble local system in global matrix
    [bigk,fext] = assemble_global(ELEM(ielem),...
        bigk,fext,ke,fe);
end

end