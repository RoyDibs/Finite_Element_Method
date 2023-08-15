function  postprocess_results(u_fem,NODE,FE,ELEM)

x = zeros(length(NODE),1);
y = zeros(length(NODE),1);

for inode=1:length(NODE)
    x(inode,1) = NODE(inode).X(1);
    y(inode,1) = NODE(inode).X(2);
end



end