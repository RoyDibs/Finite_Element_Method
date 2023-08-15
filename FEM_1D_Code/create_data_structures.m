function [NODE,ELEM,PARAMS,FE] = create_data_structures(x,T,f1,f2)

PARAMS = struct('nlink', 2, 'ndof', 1, 'Xmin', min(x), 'Xmax', max(x));

% Nodal data structure
NODE(length(x)) = struct('X', [], 'u_is_fixed', [], 'u', []);
for inod=1:length(x)
    
    NODE(inod).X = x(inod); % store nodal coordinates

    if(NODE(inod).X > mean([PARAMS.Xmin, PARAMS.Xmax])) % f_inod = f(x_inod)
        NODE(inod).body_force = f2;
    else
        NODE(inod).body_force = f1;
    end
end

% Finite element library
FE = struct('gradN', [], 'N', []);
gauss = [-1/sqrt(3); 1/sqrt(3)];

for i=1:length(gauss)

    FE.N(1,i) = 0.5*(1-gauss(i)); % shape function 1 at quadrature point i
    FE.N(2,i) = 0.5*(1+gauss(i)); % shape function 2 at quadrature point i

    FE.gradN(1,i) = -0.5; % dN1/dpsi at quadrature point i
    FE.gradN(2,i) =  0.5; % dN2/dpsi at quadrature point i

end


ELEM((length(x)-1)) = struct('nodes', [], 'length', [], 'E', [], ...
    'jcob', []);

for ielem=1:length(ELEM)
    ELEM(ielem).E = T;
    ELEM(ielem).nodes = [ielem, ielem+1];
    
    ELEM(ielem).length = NODE(ELEM(ielem).nodes(2)).X - NODE(ELEM(ielem).nodes(1)).X;
    
    [ELEM(ielem).jcob] = get_jcob(FE,x(ELEM(ielem).nodes));
end

end