function[MESH] = mesh_rect_domain(DOMAIN,MESH)

%%%% Generate a mesh of three-noded triangles over a rectangular domain
if(strcmp(MESH.type,'lin_triangles'))
    [MESH] = three_node_triangles(DOMAIN,MESH);
elseif(strcmp(MESH.type,'bilin_quads'))
    [MESH] = four_node_quads(DOMAIN,MESH);
else
    fprintf('MeshErr: Type not supported\n');
end

