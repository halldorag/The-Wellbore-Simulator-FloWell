# The Wellbore Simulator FloWell
FloWell was designed at the University of Iceland in 2012. The development of FloWell was a part of my master's study to create a practical tool to evaluate the state of geothermal reservoirs and well performances using measured wellhead conditions and inverse analysis. In order to create this practical tool, FloWell was coupled to the reservoir simulator TOUGH2. Although, FloWell was originally designed to be coupled to a reservoir simulator it can also be used individually to simulate the behavior of producing geothermal wells.

## Basic Architecture of FloWell
The simulator is built around eq. (1)-(32) defined in the section *The Physical Model of FloWell* in [5] and MATLAB is used as a programming language. The version of FloWell published here is the first version that was developed. FloWell has since been further developed (see **Other Comments**). To perform a simulation with FloWell the following input parameters are needed:
- Inner diameter and depth of a well
- Roughness of the walls in the well
- Total mass flow rate at the wellhead
- Enthalpy of the working fluid
- Bottomhole pressure or wellhead pressure

## Features and Assumptions
The wellbore simulator is capable of:
- Modeling liquid, two phase and superheated steam flows
- Allowing users to choose between various friction, friction correction factor and void fraction correlations
- Accounting for multiple feedzones and diameters in the well
- Performing wellbore simulations from the bottom to wellhead section, or from the wellhead to the bottom of the well
- Providing simulated results, such as pressure and temperature distribution as well as steam quality, friction, velocity, enthalpy and void fraction at each dept increment
- Providing graphical plots of simulated pressure and temperature profiles 

Some general assumptions have been made in the development of the simulator. It is assumed that:
- The flow is steady and one dimensional
- The fluid is pure water and IAPWS Industrial Formulation 1997 is used for the thermodynamic properties of liquid and vapor phases. The dynamic viscosity is obtained from the IAPWS Formulation 2008 for the viscosity of ordinary water substance
- Phases are in thermodynamic equilibrium
- Fluid properties remain constant within a step
- The presence of non-condensable gases and dissolved solids is ignored

The simulator solves the continuity, energy and momentum equations up the well using numerical integration. The ode23 function built in MATLAB is used to evaluate the differential equations. The function uses second and third order Runge-Kutta methods simultaneously to obtain the. The depth interval is adjusted by the integration function and at each depth node the function produces velocity, pressure and enthalpy values.

To validate the wellbore simulator FloWell, simulated output needs to be compared to measured data. Comparison is essential for the credibility of the simulator but many factors can affect the outcome of the simulation. The accuracy of the wellbore simulator depends mainly on:
- The amount and accuracy of measured data available
- The accuracy of any estimated data, such as well roughness and in some cases well diameter which may have been reduced by scaling
- The validity of correlations coded into the simulator, i.e. friction, void fraction and friction correction correlations
- Moreover, inaccurate prediction can be caused by the use of physical properties of water that do not represent actual thermodynamic behavior of geothermal fluid.

## How to run FloWell
**Step 1:** Open FloWellInput.m and insert input values

**Step 2:** Run FloWell.m in MATLAB


## Other Comments
The version of FloWell published here is the first version that was developed (after some minor enhancement in 2015). FloWell has since been integrated into iTOUGH2 [6,7] and further developed to handle deviated wells, injection mode, and other enhancements [8,9,10].

## References
<a id="1">[1]</a> 
Gudmundsdottir, H., Jonsson, M.T., and Palsson, H. (2012, January 30 - February 1). *Coupling Wellbore Simulator with Reservoir Simulator* [Paper presentation]. 37th Workshop on Geothermal Reservoir Engineering, Stanford University, Stanford, California. 

<a id="1">[2]</a>
Gudmundsdottir, H. (2012). *A Coupled Wellbore-Reservoir Simulator utilizing Measured Wellhead Conditions* [Master’s Thesis, University of Iceland]. Skemman. http://hdl.handle.net/1946/13219

<a id="1">[3]</a>
Gudmundsdottir, H., Jonsson, M.T., and Palsson, H. (2013, February 11-13). *The Wellbore Simulator FloWell* [Paper presentation]. 38th Workshop on Geothermal Reservoir Engineering, Stanford University, Stanford, California. 

<a id="1">[4]</a>
Gudmundsdottir, H., Jonsson, M.T., and Palsson, H. (2013, February 11-13). *Coupling Wellbore Simulator with Reservoir Simulator* [Paper presentation]. 38th Workshop on Geothermal Reservoir Engineering, Stanford University, Stanford, California.

<a id="1">[5]</a>
Gudmundsdottir, H., and Jonsson, M.T. (2015, April 19-25). *The Wellbore Simulator FloWell – Model Enhancement and Verification* [Paper presentation]. World Geothermal Congress, Melbourne, Australia. 

<a id="1">[6]</a>
Gudmundsdottir, H., M.T. Jonsson, and S. Finsterle. (2015). *iTOUGH2-FloWell: Simulating Coupled Reservoir and Wellhead Conditions, User’s Guide*, Report LBNL-TBD, Lawrence Berkeley National Laboratory, Berkeley, California.

<a id="1">[7]</a>
Finsterle, S. (2018). *Enhancements to the TOUGH2 Simulator Integrated in iTOUGH2*, Report LBNL-7016E, Lawrence Berkeley National Laboratory, Berkeley, California.

<a id="1">[8]</a>
Gudmundsdottir, H., Jonsson, M.T., Berthet, J.-C., Arnaldsson, A., and Finsterle, S. (2018). *iTOUGH-FLOWELL: Simulating Wellhead Conditions Coupled to Geothermal Reservoir. User's Guide*. Lawrence Berkeley National Laboratory, Energy Geosciences Division.

<a id="1">[9]</a>
Berthet, J.-C., Arnaldsson, A., Gudmundsdottir, H., Jonsson, M.T., and Finsterle, S. (2018, November 14, 15). *iTOUGH2-FloWell Reservoir and Wellbore Simulation* [Presentation]. Georg Geothermal Workshop 2018. https://geothermalworkshop.com/wp-content/uploads/2018/12/ggw2018-b1-berthet.pdf

<a id="1">[10]</a>
Arnaldsson, A., Berhet, J.-C., Thorvaldsson, L., Einarsson, H.M., and Finsterle, S. (2021, April - October). *Development and Application of Enhancements to the iTOUGH2 Simulator for Geothermal Reservoir Management* [Paper presentation]. World Geothermal Congress, Reykjavik, Iceland.


