function[bigk,fext] = assemble_global(elem,bigk,fext,ke,fe)

nlink = length(elem.nodes);
for jnod=1:nlink
    cg = elem.nodes(jnod);
    ce = jnod;
    % Assemble global stiffness vector
    for inod=1:nlink
        rg = elem.nodes(inod);
        re = inod;
        bigk(rg,cg) = bigk(rg,cg) + ke(re,ce);
    end
    % Assemble global force vector 
    fext(cg) = fext(cg) + fe(ce);
end