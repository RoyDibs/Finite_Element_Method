function [FE] = create_fe_library(gauss_psi,gauss_eta,FE)

for igp=1:length(gauss_psi)

    FE.N(1,igp) = 0.5*(1-gauss_psi(igp))*0.5*(1-gauss_eta(igp)); % shape function 1 at quadrature point i
    FE.N(2,igp) = 0.5*(1+gauss_psi(igp))*0.5*(1-gauss_eta(igp)); % shape function 2 at quadrature point i
    FE.N(3,igp) = 0.5*(1+gauss_psi(igp))*0.5*(1+gauss_eta(igp)); % shape function 3 at quadrature point i
    FE.N(4,igp) = 0.5*(1-gauss_psi(igp))*0.5*(1+gauss_eta(igp)); % shape function 4 at quadrature point i

    FE.dNdpsi(1,igp) = -0.25 + 0.25*gauss_eta(igp); % dN1/dpsi at quadrature point i
    FE.dNdpsi(2,igp) =  0.25 - 0.25*gauss_eta(igp); % dN2/dpsi at quadrature point i
    FE.dNdpsi(3,igp) =  0.25 + 0.25*gauss_eta(igp); % dN3/dpsi at quadrature point i
    FE.dNdpsi(4,igp) = -0.25 - 0.25*gauss_eta(igp); % dN4/dpsi at quadrature point i

    FE.dNdeta(1,igp) = -0.25 + 0.25*gauss_psi(igp); % dN1/deta at quadrature point i
    FE.dNdeta(2,igp) = -0.25 - 0.25*gauss_psi(igp); % dN2/deta at quadrature point i
    FE.dNdeta(3,igp) =  0.25 + 0.25*gauss_psi(igp); % dN3/deta at quadrature point i
    FE.dNdeta(4,igp) =  0.25 - 0.25*gauss_psi(igp); % dN4/deta at quadrature point i

end

end