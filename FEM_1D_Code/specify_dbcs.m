function [NODE] = specify_dbcs(NODE)
% specify boundary conditions on u at x = 0
NODE(1).u_is_fixed = 1;
NODE(1).u = 0;

% specify boundary conditions on u at x = 1
NODE(length(NODE)).u_is_fixed = 1;
NODE(length(NODE)).u = 0;

end