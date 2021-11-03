%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%         FloWellOutput.m                          Halldora Gudmundsdottir
%         The Wellbore Simulator FloWell           Last update: 05/07/2015
%         Plotting results
%   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function FloWellOutput(output, measurement)

% Pressure
figure(1)
plot(output.p, output.H,'b','LineWidth',2); 
set(gca,'XAxisLocation','top')
xlabel('Pressure [bar-a]')
ylabel('Depth [m]')
if measurement.choice == 1
hold on
plot(measurement.p(:,2), -measurement.p(:,1), 'r.', 'MarkerSize', 10)
legend('FloWell', 'Measured data')
end

% Temperature
figure(2)
plot(output.T, output.H,'b','LineWidth',2); 
set(gca,'XAxisLocation','top')
xlabel('Temperature [°C]')
ylabel('Depth [m]')

% Steam Fraction
figure(3)
plot(output.x, output.H,'b','LineWidth',2); 
set(gca,'XAxisLocation','top')
xlabel('Steam Fraction')
ylabel('Depth [m]')
