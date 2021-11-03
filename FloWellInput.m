%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%         FloWellInput                             Halldora Gudmundsdottir
%         The Wellbore Simulator FloWell           Last update: 05/07/2015
%         Defines input values for simulation
%   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [input, choice, measurement] = FloWellInput
%% Choose type of simulation
% 1: From top to bottom (DOWN)
% 2: From bottom to top (UP)
choice.simulation_type = 1;

%% Insert input values
% NOTE: insert p0 according to the type chosen. For type 2,
% make sure p0 corresponds to the final depth of the well in matrix M.
input.p0 = 38;              % Initial pressure [bar-a]
input.h0 = 1300;            % Initial enthalpy [kJ/kg]
input.dotQ = 0;             % Heat loss [W/m]
input.g = 9.8;              % Gravitational acceleration [m/s^2]

% Matrix M: Depth [m], Diameter [m], Mass flow [kg/s], Pipe roughness [m]
input.M = [0   0.3153 70 0.1e-3
          800  0.2450 70 0.1e-3
          1500 0.2450 10 0.5e-1
          1999 0.2450 10 0.5e-1];
      
% NOTE: different representations of Matrix M depending on type 1 or 2
% Only add row when there is a change in diameter, mass flow or roughness
% (Exeption: Always add a row at the end with final values, even though
% there is no change.
% An example of different representation (type 1 and 2) for the same well: 
% Type 1: input.M = [0    0.3153 70 0.1e-3      
%                    800  0.2450 70 0.1e-3      % Changing diameter                         
%                    1000 0.2450 10 0.5e-1      % Changing mass flow and roughness                    
%                    2000 0.2450 10 0.5e-1];    % No change, final values must always be stated              
% Type 2: input.M = [2000   0.2450 10 0.5e-1     
%                    1000   0.2450 70 0.1e-3    % Changing mass flow and roughness
%                    800    0.3153 70 0.1e-3    % Changing diameter
%                    0      0.3153 70 0.1e-3];  % No change, final values must always be stated
      
%% Choose between empirical relations
% Friction factor
% 1: Blasius (smooth pipes)
% 2: Swamee-Jain
choice.friction_factor = 2;

% Friction Correction factor
% 1: Friedel
% 2: Beattie
choice.friction_correction_factor = 1;

% Void fraction
% 1: Homogeneous
% 2: Zivi
% 3: Chisholm
% 4: Premoli
% 5: Lockhart-Martinelli
% 6: Rouhani-Axelsson
choice.void_fraction = 6;

%% Actual measurements 
% 1: Yes, I want to plot measurements along with simulations
% 2: No, I don't have measurements
measurement.choice = 1;

% If yes, insert measurements:
%               Depth [m]      Pressure [bar-a]
measurement.p = [11.5          38.2164
                 89.8          40.1068
                 209.5         42.7060
                 306.2         45.0690
                 407.5         47.6682
                 508.7         50.7401
                 600.8         54.5208
                 692.9         58.5378
                 803.4         64.2089
                 900.1         71.0614
                 1006.0        78.8592
                 1098.1        86.4206
                 1204.0        94.2183
                 1296.0       102.2524
                 1406.5       109.5775
                 1498.6       117.3752
                 1599.9       125.4093
                 1696.6       133.2070
                 1797.9       141.0047
                 1894.6       148.8025
                 2005.1       157.0728
                 2101.7       164.1616];
