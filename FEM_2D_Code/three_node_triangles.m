function [MESH] = three_node_triangles(DOMAIN,MESH)

xdiv = MESH.xdiv;
ydiv = MESH.ydiv;

L = DOMAIN.L; 
H = DOMAIN.H;
xc = 0.5*(DOMAIN.xmin+DOMAIN.xmax);
yc = 0.5*(DOMAIN.ymin+DOMAIN.ymax);

numnodx = xdiv + 1;
numnody = ydiv + 1;

numnod = numnodx*numnody;

x = zeros(numnod,1);
y = zeros(numnod,1);
z = zeros(numnod,1);

numsquare = xdiv*ydiv;
nodes = zeros(3,2*numsquare);
nrowtriangles = 2*xdiv;


for j=1:numnody
    x(((j-1)*numnodx + 1): j*numnodx) = linspace(-L/2+xc,L/2+xc,numnodx);
    y(((j-1)*numnodx + 1): j*numnodx) = (j-1)*(H/ydiv)-H/2+yc;
end

for ysquare=1:ydiv
    nodefirstsquare = [(ysquare-1)*numnodx+1      (ysquare-1)*numnodx+2
                       (ysquare-1)*numnodx+2      (ysquare-1)*numnodx+(numnodx+2)
                       (ysquare-1)*numnodx+(numnodx+1)      (ysquare-1)*numnodx+(numnodx+1)];
    for xsquare=1:xdiv
        xcol = 2*xsquare-1;
        ycol = (ysquare-1)*nrowtriangles + xcol;
        nodes(1:3,ycol:(ycol+1)) = nodefirstsquare + (xsquare-1);
    end
end

MESH.x = x; MESH.y = y; MESH.z = z; MESH.numnod = length(x);
MESH.nodes = nodes; MESH.numele = size(nodes,2);

end