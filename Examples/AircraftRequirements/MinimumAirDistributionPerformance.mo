within Modelica_Requirements.Examples.AircraftRequirements;
model MinimumAirDistributionPerformance
  "Requirement: If only one engine is running, the air distribution circuit shall provide nominal performance"
   extends Modelica.Icons.Example;
   import Modelica_Requirements.LogicalFunctions.*;

  inner Modelica_Requirements.Verify.PrintViolations printViolations
    annotation (Placement(transformation(extent={{-88,20},{-68,40}})));
  Modelica_Requirements.Verify.Requirement Requirement_AirCircuitOneEngine(text="In flight, with only one engine 
running, the air distribution circuit 
shall provide nominal performances.")
    annotation (Placement(transformation(extent={{32,20},{90,40}})));
  Modelica.Blocks.Sources.BooleanStep EngineOff(startTime=2, startValue=false)
    annotation (Placement(transformation(extent={{-50,60},{-30,80}})));
  Modelica_Requirements.ChecksInFixedWindow.During during1(check=
        NominalPerformance.y)
    annotation (Placement(transformation(extent={{-20,20},{20,40}})));
  Modelica.Blocks.Sources.BooleanStep InFlight(startValue=false, startTime=1)
    annotation (Placement(transformation(extent={{-80,60},{-60,80}})));
  Modelica.Blocks.MathBoolean.And
                        allTrue1(nu=2)
    annotation (Placement(transformation(extent={{-46,25},{-36,35}})));
  Modelica.Blocks.Sources.BooleanPulse NominalPerformance(period=5)
    annotation (Placement(transformation(extent={{-14,60},{6,80}})));
equation
  connect(during1.condition, allTrue1.y) annotation (Line(
      points={{-22,30.1},{-35.25,30.1},{-35.25,30}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(during1.y, Requirement_AirCircuitOneEngine.property) annotation (Line(
      points={{21,30},{30.0667,30}},
      color={255,0,128},
      smooth=Smooth.None));
  connect(EngineOff.y, allTrue1.u[1]) annotation (Line(points={{-29,70},{-24,70},
          {-24,44},{-52,44},{-52,32},{-52,31.75},{-46,31.75}}, color={255,0,255}));
  connect(InFlight.y, allTrue1.u[2]) annotation (Line(points={{-59,70},{-54,70},
          {-54,28.25},{-46,28.25}}, color={255,0,255}));
  annotation (Documentation(info="<html>
<p>
This example demonstrates the modeling and verification of the 
following aircraft requirement:
</p>

<blockquote><p>
<b>Requirement</b>:<br>
In flight, with only one engine running, 
the air distribution circuit shall 
provide nominal performance.
</p></blockquote>

<p>
This requirement can be modelled with the logical blocks and the
<a href=\"modelica://Modelica_Requirements.ChecksInFixedWindow.During\">ChecksInFixedWindow.During</a>
block.
</p>

<p>
Setup of this example:
</p>

<blockquote><pre>
InFlight.y          : True if the aircraft is in flight.
EngineOff.y         : True if one of the two engines is off.
NominalPerformance.y: True if the system provides nominal performance.
</pre></blockquote> 

<p><blockquote>
<img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/AircraftRequirements/MinimumAirDistributionPerformance1.png\">
</blockquote></p>

<p>
results in
</p>

<table border=0 cellspacing=0 cellpadding=2>
<tr><td width=\"50\"></td>
    <td valign=\"bottom\"><img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/AircraftRequirements/MinimumAirDistributionPerformance2.png\"></td>
    </tr>

<tr><td></td>
    <td align=\"center\">simulation result</td>
   </tr>
</table>
</html>"),
         Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}), graphics={      Text(
          extent={{-98,94},{-6,90}},
          lineColor={0,140,72},
          fontSize=10,
          horizontalAlignment=TextAlignment.Left,
          textString="Aircraft status to be verified",
          textStyle={TextStyle.Bold}),                 Text(
          extent={{-98,51},{-6,47}},
          lineColor={0,140,72},
          fontSize=10,
          horizontalAlignment=TextAlignment.Left,
          textString="Requirements definition",
          textStyle={TextStyle.Bold})}),
    experiment(StopTime=3));
end MinimumAirDistributionPerformance;
