clear; close all; clc;

% specify problem domain
DOMAIN.xmin = -1; DOMAIN.xmax = 1; 
DOMAIN.ymin = -1; DOMAIN.ymax = 1; 
DOMAIN.L = DOMAIN.xmax-DOMAIN.xmin;
DOMAIN.H = DOMAIN.ymax-DOMAIN.ymin;

% create mesh
MESH.xdiv = 2; MESH.ydiv = 2;
MESH.type = 'bilin_quads';
[MESH] = mesh_rect_domain(DOMAIN,MESH);

MESH.x(5,1) = 0.5; MESH.y(5,1) = 0.3;

% assign material properties
PARAMS.analysis_type = '2d_heat';
if(strcmp(PARAMS.analysis_type,'2d_heat'))
    MATERIAL.kappa = eye(2);
else
    fprintf('errAnalysisType::Analysis type not supported\n');
end

% create data structures to store nodal coordinates and element
% connectivity
[NODE, ELEM, PARAMS, FE] = create_data_structures(MESH,PARAMS,MATERIAL);

% specify boundary conditions
[NODE] = specify_dbcs(NODE,DOMAIN);

% assemble system
[bigk,fext] = assemble_system(ELEM,NODE,FE);

% apply boundary conditions
[bigk,fext] = apply_bcs(bigk,fext,NODE);

% solve system
u_fem = bigk\fext;


% exact solution
u_ex = zeros(length(NODE),1);
for inode=1:length(NODE)
    u_ex(inode,1) = (2 + ((NODE(inode).X(1) - DOMAIN.xmin) / DOMAIN.L));
end

disp('     u_fem     u_ex');
out = [u_fem u_ex];
disp(out);


% postprocess results
postprocess_results(u_fem,NODE,FE,ELEM);
