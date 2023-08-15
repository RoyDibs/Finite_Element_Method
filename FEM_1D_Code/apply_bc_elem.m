function[ke,fe] = apply_bc_elem(elem,ke,fe,NODE)

u_vec = zeros(length(ke),1);
for i=1:length(ke)
    if (NODE(elem.nodes(1,i)).u_is_fixed == 1)
        u_vec(i) = NODE(elem.nodes(1,i)).u ;
    end
end

%% Transforming the fixed row
for i=1:length(ke)
    for j=1:length(ke)
        if (isempty(NODE(elem.nodes(1,i)).u_is_fixed))
            fe(i,1) = fe(i,1) - ke(i,j)*u_vec(j);
        else
            fe(i,1) = u_vec(i);
            if (i == j)
                ke(i,j) = 1;
            else
                ke(i,j) = 0;
                ke(j,i) = 0;
            end
        end
    end
end


end