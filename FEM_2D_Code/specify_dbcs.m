function [NODE] = specify_dbcs(NODE,DOMAIN)
% Modify the nodal data structure to specify Dirichlet BCs

for i=1:length(NODE)
    if (NODE(i).X(1) == DOMAIN.xmin)
        % u at x = xmin
        NODE(i).u_is_fixed = 1;
        NODE(i).u = 2;
    end
    
    if (NODE(i).X(1) == DOMAIN.xmax)
        % u at x = xmax
        NODE(i).u_is_fixed = 1;
        NODE(i).u = 3;
    end
end



end