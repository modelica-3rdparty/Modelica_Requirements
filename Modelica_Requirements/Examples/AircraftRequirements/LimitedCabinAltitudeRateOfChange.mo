within Modelica_Requirements.Examples.AircraftRequirements;
model LimitedCabinAltitudeRateOfChange
  "Requirement: The cabin altitude rate of change is limited by the pressure bump duration domain to ensure passenger comfort"
   extends Modelica.Icons.Example;
   import Modelica_Requirements.LogicalFunctions.*;

  inner Modelica_Requirements.Verify.PrintViolations printViolations
    annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
  Modelica_Requirements.Verify.Requirement R_FreshECSFlow(text="The cabin altitude rate of change
should not be out of the cabin
pressure domain, more than 5s.")
    annotation (Placement(transformation(extent={{-10,-50},{50,-30}})));

  Modelica_Requirements.SignalAnalysis.ExactDerivative derP
    annotation (Placement(transformation(extent={{-36,60},{-16,80}})));
  Modelica.Blocks.Sources.ContinuousClock clock
    annotation (Placement(transformation(extent={{-72,-3},{-60,9}})));
  Modelica_Requirements.ChecksInFixedWindow.MaxDuration maxDuration1(check=
        true, durationMax(displayUnit="s") = 5)
    annotation (Placement(transformation(extent={{-70,-50},{-30,-30}})));
  Modelica_Requirements.ChecksInFixedWindow.WithinDomain withinDomain1(polygon=[
        0.589706,138.824; 100,100; 100,2507.06; 87.2676,2507.06; 83.1051,
        2701.18; 71.5971,3865.88; 18.9537,10000; 0.344853,9961.18; 0.344853,
        138.824])
    annotation (Placement(transformation(extent={{-16,0},{24,40}})));
  Modelica_Requirements.Sources.BooleanConstant const1
    annotation (Placement(transformation(extent={{-50,10},{-30,30}})));
  Sources.RealExpression PressureAltitude(y=20*time^2 + 150*time)
    annotation (Placement(transformation(extent={{-80,60},{-40,80}})));
  Modelica.Blocks.Routing.Multiplex2 multiplex
    annotation (Placement(transformation(extent={{-44,-5},{-34,5}})));
  LogicalBlocks.PropertyToBoolean toBoolean(undecided=true)
    annotation (Placement(transformation(extent={{34,10},{54,30}})));
  Modelica.Blocks.MathBoolean.Not not1
    annotation (Placement(transformation(extent={{62,16},{70,24}})));
equation
  connect(PressureAltitude.y, derP.u)
    annotation (Line(points={{-39,70},{-33,70}}, color={0,0,127}));
  connect(const1.y, withinDomain1.condition) annotation (Line(points={{-29,20},{
          -18,20},{-18,20.1}}, color={255,0,255}));
  connect(multiplex.y, withinDomain1.point) annotation (Line(points={{-33.5,0},{
          -26,0},{-26,10},{-18,10}}, color={0,0,127}));
  connect(clock.y, multiplex.u1[1])
    annotation (Line(points={{-59.4,3},{-56,3},{-45,3}}, color={0,0,127}));
  connect(derP.y, multiplex.u2[1]) annotation (Line(points={{-20,70},{-14,70},{-14,
          70},{-14,46},{-86,46},{-86,-10},{-52,-10},{-52,-3},{-45,-3}}, color={0,
          0,127}));
  connect(maxDuration1.y, R_FreshECSFlow.property) annotation (Line(points={{-29,
          -40},{-20.5,-40},{-12,-40}}, color={255,0,128}));
  connect(withinDomain1.y, toBoolean.u)
    annotation (Line(points={{25,20},{32,20}}, color={255,0,128}));
  connect(toBoolean.y, not1.u)
    annotation (Line(points={{55,20},{60.4,20}}, color={255,0,255}));
  connect(not1.y, maxDuration1.condition) annotation (Line(points={{70.8,20},{
          76,20},{76,-20},{-80,-20},{-80,-39.9},{-72,-39.9}}, color={255,0,255}));
  annotation (Documentation(info="<html>
<p>
This example demonstrates the modeling and verification of the 
following aircraft requirement:
</p>

<blockquote>
<p>
<b>Requirement</b>:<br>
The cabin altitude rate of change should 
not be out of the cabin pressure domain,
more than 5s:
</p>
<p>
<img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/AircraftRequirements/LimitedCabinAltitudeRateOfChange_CabinPressureDomain.png\">
</p>
</blockquote>

<p>
This requirement can be modelled with the 
<a href=\"modelica://Modelica_Requirements.ChecksInFixedWindow.WithinDomain\">ChecksInFixedWindow.WithinDomain</a>
and <a href=\"modelica://Modelica_Requirements.ChecksInFixedWindow.MaxDuration\">ChecksInFixedWindow.MaxDuration</a> blocks. 
</p>

<p>
Setup of this example:
</p>

<p><blockquote>
<img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/AircraftRequirements/LimitedCabinAltitudeRateOfChange1.png\">
</blockquote></p>

<p>
results in (the first figure shows the domain at the end of the simulation)
</p>

<table border=0 cellspacing=0 cellpadding=2>
<tr><td width=\"50\"></td>
    <td align=\"center\" valign=\"bottom\"><img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/AircraftRequirements/LimitedCabinAltitudeRateOfChange2\">
</td>
    </tr>
<tr><td width=\"50\"></td>
    <td valign=\"bottom\"><img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/AircraftRequirements/LimitedCabinAltitudeRateOfChange3\"></td>
    </tr>
<tr><td></td>
    <td align=\"center\">simulation result</td>
   </tr>
</table>
</html>"),
         Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}), graphics={      Text(
          extent={{-96,86},{-4,82}},
          lineColor={0,140,72},
          fontSize=10,
          horizontalAlignment=TextAlignment.Left,
          textStyle={TextStyle.Bold},
          textString="Aircraft status to be verified"),Text(
          extent={{-96,55},{-4,51}},
          lineColor={0,140,72},
          fontSize=10,
          horizontalAlignment=TextAlignment.Left,
          textString="Requirements definition",
          textStyle={TextStyle.Bold})}),
    experiment(StopTime=100),
    __Dymola_experimentSetupOutput);
end LimitedCabinAltitudeRateOfChange;
