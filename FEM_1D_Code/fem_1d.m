clear; close all; clc;

% specify problem domain
L = 1;
xmin = 0; xmax = L;

% assign material properties
T = 1; W = 1; f1 = -3*W; f2 = -1*W;

% create mesh
x = linspace(xmin, xmax, 100);

% create data structures to store nodal coordinates and element
% connectivity
[NODE, ELEM, PARAMS, FE] = create_data_structures(x,T,f1,f2);

% global/local bc application
% PARAMS.global_bc = 1 --> Dirichlet BCs are applied by 
%                          modifying bigk and fext
% PARAMS.global_bc = 0 --> Dirichlet BCs are applied by 
%                          modifying ke and fe prior to assembly
PARAMS.global_bc = 0; 

% specify boundary conditions
[NODE] = specify_dbcs(NODE);

% assemble system
[bigk,fext] = assemble_system(ELEM,NODE,FE,PARAMS);

% apply boundary conditions
if(PARAMS.global_bc)
    [bigk,fext] = apply_bcs(bigk,fext,NODE);
end

% solve system
u_fem = bigk\fext;

% postprocess results
postprocess_results(x,u_fem,T,NODE,ELEM,FE,PARAMS,W);
