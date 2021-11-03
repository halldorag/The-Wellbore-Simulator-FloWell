%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%         FloWellFrictionCorrectionFactor.m        Halldora Gudmundsdottir
%         The Wellbore Simulator FloWell           Last update: 05/07/2015
%         Calculates the friction correction factor
%   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function phi2 = FloWellFrictionCorrectionFactor(u, x, T, rhol, rhog, mul, mug, d, input, choice)

if choice.friction_correction_factor == 1
    % Friedel
    Rel = rhol * u * d / mul;
    fl = 0.316 / Rel^(1/4);
    Reg = rhog * u * d / mug;
    fg = 0.316 / Reg^(1/4);
    
    rhom = 1 / (x / rhog + (1-x) / rhol);
    Tc = 647.096;
    sigma = 0.2358*(1-T/Tc)^1.256*(1-0.625*(1-T/Tc));
    
    E = (1 - x^2) + x^2 * rhol/rhog * fg / fl;
    F = x^0.78 * (1 - x^2)^0.24;
    H = (rhol/rhog)^0.91*(mug*rhol/(mul*rhog))^0.19*(1-rhog/rhol)^0.7;
    Fr = rhol^2*u^2/(input.g*rhom^2*d);
    We = rhol^2*u^2*d/(sigma*rhom^2);
    
    phi2 = E + 3.24*F*H / (Fr^0.045*We^0.035);
else
    % Beattie
    phi2 = (1+x*(rhol/rhog-1))^0.8*(1+x*((3.5*mug+2*mul)/((mug+mul)*rhog)-1))^0.2;
end