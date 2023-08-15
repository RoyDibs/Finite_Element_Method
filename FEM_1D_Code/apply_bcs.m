function [bigk,fext] = apply_bcs(bigk,fext,NODE)
% apply_bcs: Modify the global stiffness and 
% force vector to enforce BCs
for inod=1:length(NODE)
    if(NODE(inod).u_is_fixed)
        % Modify force vector
        for jnod=1:length(NODE)
            fext(jnod) = fext(jnod) - bigk(jnod,inod)*NODE(inod).u;
        end
        fext(inod) = NODE(inod).u;
        % clear row
        bigk(inod,:) = zeros(1,length(NODE));
        % clear column
        bigk(:,inod) = zeros(length(NODE),1);
        % set diagonal entry to 1
        bigk(inod,inod) = 1.0;
    end
end

end