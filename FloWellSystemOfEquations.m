%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%         FloWellFrictionCorrectionFactor.m        Halldora Gudmundsdottir
%         The Wellbore Simulator FloWell           Last update: 05/07/2015
%         Solves system of equations
%   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [ds, ul, ug] = FloWellSystemOfEquations(z, s, d, dotm, e, input, choice)

A = pi*d^2/4;
u = s(1);
p = s(2);
h = s(3);

[rho, T, x, rhol, rhog] = water_iapws97_superheat(p, h);

%% Single phase flow
if x == 0 || x == 1
    mu = water_viscosity(T, rho);
    Re = rho * u * d / mu;
    if choice.friction_factor == 1
        % Blasius
        f = 0.316 / Re^(1/4);
    else
        % Swamee-Jain
        f = 0.25 / (log10(e/(3.7 * d) + 5.74/Re^0.9))^2;
    end
    rho_p = (water_iapws97_superheat(p * (1 + 1e-5), h) - rho) / (p * 1e-5);
    rho_h = (water_iapws97_superheat(p, h * (1 + 1e-5)) - rho) / (h * 1e-5);
    C = [rho u * rho_p u * rho_h; dotm * u 0 dotm; rho*u 1 0];
    b = [0; dotm * input.g + input.dotQ; rho * input.g + rho * f/(2*d) * u^2];
    
    if x == 0 
        ug = 0; ul = u;
    else
        ug = u; ul = 0;
    end

    ds = -C\b;
    else
%% Two phase flow

    % Estimating derivatives 
    [gamma, eta] = FloWellGammaEta(p, h, dotm, A, choice);
    [gp,ep] = FloWellGammaEta(p*(1+1e-5),h, dotm, A, choice);
    [gh,eh] = FloWellGammaEta(p,h*(1+1e-5), dotm, A, choice);
    gamma_p = (gp - gamma) / (p * (1+1e-5));
    gamma_h = (gh - gamma) / (h * (1+1e-5));
    eta_p = (ep - eta) / (p * (1+1e-5));
    eta_h = (eh - eta) / (h * (1+1e-5));
    
    [~, ~, ~, rl] = water_iapws97_superheat(p * (1 + 1e-5), h);
    rhol_p = (rl - rhol) / (p * (1 + 1e-5));

    
    mul = water_viscosity(T, rhol);
    mug = water_viscosity(T, rhog);
    alpha = FloWellVoidFraction(x, rhol, rhog, mul, mug, T, dotm, A, choice);



    Re = rhol * u * d / mul;
    if choice.friction_factor == 1
        % Blasius
        f = 0.316 / Re^(1/4);
    else
        % Swamee-Jain
        f = 0.25/(log10(e/(3.7*d)+5.74/Re^0.9))^2;
    end

    phi2 = FloWellFrictionCorrectionFactor(u, x, T, rhol, rhog, mul, mug, d, input, choice);
    C = [rhol u*rhol_p 0; gamma*u u^2/2*gamma_p (1+u^2/2*gamma_h); ...
        eta*rhol*u (1+rhol*u^2*eta_p+eta*u^2*rhol_p) rhol*u^2*eta_h];
    b = [0; input.g+input.dotQ/dotm; ((1-alpha)*rhol+alpha*rhog)*input.g + ...
        phi2 * rhol * f / (2 * d) * u^2];

    ug = (x*rhol*u)/(alpha*rhog);
    ul = (1-x)*u/(1-alpha);

    ds = -C\b;
end