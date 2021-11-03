%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%         FloWellMain.m                            Halldora Gudmundsdottir
%         The Wellbore Simulator FloWell           Last update: 05/07/2015
%         Integrates and saves output values
%   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function output = FloWellMain(input, choice)

% Initialize p, h and u
p0 = input.p0 * 10^5;
h0 = input.h0 * 10^3;
[rho, ~, ~, rhol, ~] = water_iapws97_superheat(p0, h0);
dotm = input.M(1,3);
d = input.M(1,2);
A = pi* d^2/4;
if choice.simulation_type == 1
    u0 = dotm /(A * rhol);
else
    u0 = dotm /(A * rho);
end

% Preparing to store values
output.H = -input.M(1,1); output.p = p0; output.h = h0; output.u = u0; output.ul = u0; output.ug = u0;

% Integrating and solving system of equations
for i = 1:size(input.M,1)-1
    d    = input.M(i,2);
    dotm = input.M(i,3);
    e    = input.M(i,4);
    L1   = -input.M(i,1);
    L2   = -input.M(i+1,1);
    
    % Integration with ode23
    [z, s] = ode23s(@(z, s) FloWellSystemOfEquations(z, s, d, dotm, e, input, choice), [L1 L2], [u0; p0; h0], odeset);
    odeset('reltol',1e-7);
    
    % Obtaining output values calculated during integration
    for j = 1:size(s,1)
    [~, ul(j,1), ug(j,1)] = FloWellSystemOfEquations(z, s(j,:), d, dotm, e, input, choice);
    end
    
    % Updating initial values (p,h,u) for next depth interval
    u0 = s(end,1);
    p0 = s(end,2);
    h0 = s(end,3);
    
    % Storing values
    output.H = cat(1, output.H, z(2:end)); output.p = cat(1, output.p, s(2:end,2)); 
    output.h = cat(1, output.h, s(2:end,3)); output.u = cat(1, output.u, s(2:end,1));
    output.ul = cat(1, output.ul, ul); output.ug = cat(1, output.ug, ug);
end

% Storing saturation properties
for i = 1:size(output.p,1)
    [output.rho(i,1), output.T(i,1), output.x(i,1), output.rhol(i,1), output.rhog(i,1), output.hl(i,1), output.hg(i,1)] = water_iapws97_superheat(output.p(i,1), output.h(i,1));
end

% Adjusting units
output.p = 10^-5 * output.p;  % [Pa] to [bar]
output.h = 10^-3 * output.h;  % [J/kg] to [kJ/kg]
output.T = output.T - 273.15; % [K] to [°C]