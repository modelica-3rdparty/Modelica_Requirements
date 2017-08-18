within Modelica_Requirements.Examples.AircraftRequirements;
model MinimumOperationalServiceLife
  "Requirement: The aircraft shall be designed for a minimum operational service life."
   extends Modelica.Icons.Example;
   import Modelica_Requirements.LogicalFunctions.*;

  inner Modelica_Requirements.Verify.PrintViolations printViolations
    annotation (Placement(transformation(extent={{-84,-6},{-64,14}})));
  Modelica_Requirements.Verify.Requirement R_OpLife(text="The aircraft shall be designed for an
operational service life of 150 flight
cycles and 800 flight hours,
whichever is more stringent.")
    annotation (Placement(transformation(extent={{21,5},{73,23}})));
  Modelica.Blocks.Sources.BooleanPulse InFlight(period(displayUnit="h") = 3600)
    annotation (Placement(transformation(extent={{-50,60},{-30,80}})));
  Modelica_Requirements.ChecksInFixedWindow.MinDuration minDuration1(check=
        InFlight.y, durationMin(displayUnit="h") = 2880000)
    annotation (Placement(transformation(extent={{-46,-6},{-6,14}})));
  Modelica_Requirements.ChecksInFixedWindow.MinRising minRising1(check=
        InFlight.y, nRisingMin=150)
    annotation (Placement(transformation(extent={{-46,22},{-6,42}})));
  Modelica.Blocks.Sources.BooleanStep InOperation(startTime=1)
    annotation (Placement(transformation(extent={{-80,60},{-60,80}})));
  Modelica_Requirements.LogicalBlocks.PropertyAnd and1(nu=2)
    annotation (Placement(transformation(extent={{-2,4},{18,24}})));
equation

  connect(InOperation.y, minRising1.condition) annotation (Line(
      points={{-59,70},{-56,70},{-56,32},{-48,32},{-48,32.1}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(minDuration1.condition, InOperation.y) annotation (Line(
      points={{-48,4.1},{-56,4.1},{-56,70},{-59,70}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(and1.y, R_OpLife.property) annotation (Line(points={{14,14},{19.2667,
          14}},              color={255,0,128}));
  connect(minRising1.y, and1.u[1]) annotation (Line(points={{-5,32},{-2,32},{-2,
          16},{3,16}},  color={255,0,128}));
  connect(minDuration1.y, and1.u[2]) annotation (Line(points={{-5,4},{-2,4},{-2,
          12},{3,12}},  color={255,0,128}));
  annotation (Documentation(info="<html>
<p>
This example demonstrates the modeling and verification of the 
following aircraft requirement:
</p>

<blockquote><p>
<b>Requirement</b>:<br>
The aircraft shall be designed for an 
operational service life of 150 flight 
cycles and 800 flight hours, whichever 
is more stringent.
</p></blockquote>

<p>
This requirement can be modelled with the 
<a href=\"modelica://Modelica_Requirements.ChecksInFixedWindow.MinDuration\">ChecksInFixedWindow.MinDuration</a>
and <a href=\"modelica://Modelica_Requirements.ChecksInFixedWindow.MinRising\">ChecksInFixedWindow.MinRising</a> blocks 
and an <a href=\"modelica://Modelica_Requirements.LogicalBlocks.PropertyAnd\">and</a> block for 3-valued logic.
</p>

<p>
Setup of this example:
</p>

<blockquote><pre>
InOperation.y: True if the aircraft is in operation (and not, e.g., in maintenance).
InFlight.y   : True if the aircraft is in flight.
</pre></blockquote> 

<p><blockquote>
<img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/AircraftRequirements/MinimumOperationalServiceLife1.png\">
</blockquote></p>

<p>
results in
</p>

<table border=0 cellspacing=0 cellpadding=2>
<tr><td width=\"50\"></td>
    <td valign=\"bottom\"><img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/AircraftRequirements/MinimumOperationalServiceLife2.png\"></td>
    </tr>

<tr><td></td>
    <td align=\"center\">simulation result</td>
   </tr>
</table>
</html>"),
         Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}),       graphics={Text(
          extent={{-98,92},{-6,88}},
          lineColor={0,140,72},
          fontSize=10,
          horizontalAlignment=TextAlignment.Left,
          textString="Aircraft status to be verified",
          textStyle={TextStyle.Bold}),                 Text(
          extent={{-98,49},{-6,45}},
          lineColor={0,140,72},
          fontSize=10,
          horizontalAlignment=TextAlignment.Left,
          textString="Requirements definition",
          textStyle={TextStyle.Bold})}),
    experiment(StopTime=1e+007));
end MinimumOperationalServiceLife;
