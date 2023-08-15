function  postprocess_results(x,u_fem,T,NODE,ELEM,FE,PARAMS,W)

plot(x, u_fem, 'LineWidth', 2, 'Color', 'blue');
hold on

% plot exact solution
xmin = min(x); xmax = max(x);
x_ex = linspace(xmin,xmax,201);
L = xmax-xmin;
u_ex =  zeros(length(x_ex),1);
for inod=1:length(x_ex)
    if(x_ex(inod)<mean([xmin, xmax]))
        u_ex(inod) = (L*L)/(T)*(1.5*(x_ex(inod)/L)*(x_ex(inod)/L)-(5/4)*(x_ex(inod)/L));
    else
        u_ex(inod) = (L*L)/(T)*(0.5*(x_ex(inod)/L)*(x_ex(inod)/L)-(1/4)*(x_ex(inod)/L) - (1/4));
    end
end

plot(x_ex, u_ex,'--r','LineWidth', 2);

legend('u_{fem}', 'u_{ex}', 'FontSize', 12);
hold off

%% calculate strain

strain_fem = zeros(length(ELEM),1);

for jelem=1:length(ELEM)
    for inode=1:PARAMS.nlink
        for gaussit=1:size(FE.N,2)
            strain_fem(jelem,1) = strain_fem(jelem,1) + (u_fem(ELEM(jelem).nodes(1,gaussit))*FE.gradN(gaussit,inode)*(1/ELEM(jelem).jcob(gaussit,1)));
        end
    end
     strain_fem(jelem,1) =  strain_fem(jelem,1)/2;
end

% strain exact

strain_exact = zeros(length(x_ex),1);
for inod=1:length(x_ex)
    if(x_ex(inod)<mean([xmin, xmax]))
        strain_exact(inod,1) = (W*L^2)/T * (((3*x_ex(inod))/L) - (5/4));
    else
        strain_exact(inod,1) = (W*L^2)/T * (((x_ex(inod))/L) - (1/4));
    end
end




% plot
elem_cord = zeros(length(ELEM),1);
for i=1:length(ELEM)
    elem_cord(i,1) = (NODE(i+1).X + NODE(i).X)/2 ;
end
figure(2)

display(strain_fem)
display(strain_exact)
plot(elem_cord, strain_fem, 'LineWidth', 2, 'Color', 'blue');
hold on

plot(x_ex, strain_exact,'--r','LineWidth', 2);

legend('strain_{fem}', 'stain_{ex}', 'FontSize', 12);


end