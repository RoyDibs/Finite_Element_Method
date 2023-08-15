function [NODE,ELEM,PARAMS,FE] = create_data_structures(MESH,PARAMS,MATERIAL)

PARAMS.nlink = 2;
PARAMS.ndof = 1;

% Nodal data structure
NODE(MESH.numnod) = struct('X', [], 'u_is_fixed', [], 'u', []);
% Populate the nodal data structure with coordinates
for inod = 1:MESH.numnod
    NODE(inod).X = [MESH.x(inod,1),MESH.y(inod,1)];
end


% Finite element library
FE = struct('dNdpsi', [],'dNdeta', [], 'N', []);
gauss_psi = [-1/sqrt(3); 1/sqrt(3); -1/sqrt(3); 1/sqrt(3)];
gauss_eta = [-1/sqrt(3); -1/sqrt(3); 1/sqrt(3); 1/sqrt(3)];
[FE] = create_fe_library(gauss_psi,gauss_eta,FE);

ELEM(MESH.numele) = struct('nodes', [], 'volume', [], 'Dmat', [], ...
    'jcob', [],'strain',[],'avg_strain',0);
% Populate the element data structure
for ielem=1:MESH.numele
    ELEM(ielem).nodes = MESH.nodes(:,ielem);
    ELEM(ielem).Dmat = get_mat_tensor(MATERIAL,PARAMS);
    ELEM(ielem).jcob = get_jcob(FE,ELEM,NODE,ielem);
end


end