%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%         FloWellVoidFraction.m                    Halldora Gudmundsdottir
%         The Wellbore Simulator FloWell           Last update: 05/07/2015
%         Calculates the void fraction
%   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function alpha = FloWellVoidFraction(x, rhol, rhog, mul, mug, T, dotm, A, choice)
    %% Homogeneous
if choice.void_fraction == 1;
    S = 1;
    alpha = x/rhog / (x / rhog + (1-x) / rhol * S);
elseif choice.void_fraction == 2;
    % Zivi
    S = (rhol/rhog)^(1/3);       
    alpha = x/rhog / (x / rhog + (1-x) / rhol * S);
elseif choice.void_fraction == 3;
    % Chrisholm
    S = sqrt(1-x*(1-rhol/rhog)); 
    alpha = x/rhog / (x / rhog + (1-x) / rhol * S);
elseif choice.void_fraction == 4;
    %% Premoli
    d = sqrt(A*4/pi);
    sigma = 0.2358*(1-T/647.096)^1.256*(1-0.625*(1-T/647.096));
    G = dotm/A;
    Rel = G*d/mul;
    Wel = G^2*d/(sigma*rhol);
    y = (((1-x)/x)*(rhog/rhol))^-1;
    F2 = 0.0273*Wel*Rel^-0.51*(rhol/rhog)^-0.08;
    F1 = 1.578*Rel^-0.19*(rhol/rhog)^0.22;
    Aprm = 1+F1*(y/(1+y*F2)-y*F2);
    alpha = (1+Aprm*((1-x)/x)*(rhog/rhol))^-1;
elseif choice.void_fraction == 5;
    %% Lockhart Martinelli
    alpha = 1 / (1 + 0.28*((1-x)/x)^0.64*(rhog/rhol)^0.36*(mul/mug)^0.07);
elseif choice.void_fraction == 6;
    %% Rouhani-Axelsson
    sigma = 0.2358*(1-T/647.096)^1.256*(1-0.625*(1-T/647.096));
    G = dotm/A;
    g = 9.8;
    alpha = (x/rhog)*((1+0.12*(1-x))*(x/rhog+(1-x)/rhol)+(1.18*(1-x))*(g*sigma*(rhol-rhog)^0.25)/(G*rhol^0.5))^-1;
end
