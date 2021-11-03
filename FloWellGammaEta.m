%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%         FloWell.m                                Halldora Gudmundsdottir
%         The Wellbore Simulator FloWell           Last update: 05/07/2015
%         Simulations down the well
%   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [g, e] = FloWellGammaEta(p, h, dotm, A, choice)
[~, T, x, rhol, rhog] = water_iapws97_superheat(p, h);
mul = water_viscosity(T, rhol);
mug = water_viscosity(T, rhog);
alpha = FloWellVoidFraction(x, rhol, rhog, mul, mug, T, dotm, A, choice);
g = (1-x)^3/(1-alpha)^2 + (rhol/rhog)^2*x^3/alpha^2;
e = (1-x)^2/(1-alpha) + (rhol/rhog)*x^2/alpha;