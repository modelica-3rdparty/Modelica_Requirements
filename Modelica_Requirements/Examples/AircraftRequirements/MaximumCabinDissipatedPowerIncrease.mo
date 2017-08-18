within Modelica_Requirements.Examples.AircraftRequirements;
model MaximumCabinDissipatedPowerIncrease
  "Requirement: The dissipated power of cabin area is limited to ensure passenger comfort"
   extends Modelica.Icons.Example;
   import Modelica_Requirements.LogicalFunctions.*;

  parameter Real P_RoClim= 2/100;

  inner Modelica_Requirements.Verify.PrintViolations printViolations
    annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
  Verify.BooleanRequirement Requirement_CabinDissipatedPower(text="In the cabin area the dissipated
power should not increase 
more than 2% per hour
(to ensure passenger comfort).")
    annotation (Placement(transformation(extent={{0,20},{60,40}})));
  ChecksInSlidingWindow.MaxPercentageIncrease maxIncrease1(window(displayUnit="h")=
         3600, upperPercentageLimit=2)
    annotation (Placement(transformation(extent={{-40,20},{-20,40}})));
  Modelica.Blocks.Sources.CombiTimeTable P_cabin(table=[0,20; 3600,20; 7200,
        20.4; 10000,21.4; 13000,21])
    annotation (Placement(transformation(extent={{-80,60},{-60,80}})));
equation
  connect(P_cabin.y[1], maxIncrease1.u) annotation (Line(points={{-59,70},{-48,70},
          {-48,30},{-42,30}}, color={0,0,127}));
  connect(maxIncrease1.y, Requirement_CabinDissipatedPower.u)
    annotation (Line(points={{-19,30},{-2,30}}, color={255,0,255}));
  annotation (Documentation(info="<html>
<p>
This example demonstrates the modeling and verification of the 
following aircraft requirement:
</p>

<blockquote><p>
<b>Requirement</b>:<br>
In the cabin area the dissipated power should not increase more 
than 2% per hour (to ensure passenger comfort).
</p></blockquote>

<p>
This requirement can be modelled with the 
<a href=\"modelica://Modelica_Requirements.ChecksInSlidingWindow.MaxPercentageIncrease\">ChecksInSlidingWindow.MaxPercentageIncrease</a>
block. 
</p>

<p>
Setup of this example:
</p>

<p><blockquote>
<img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/AircraftRequirements/MaximumCabinDissipatedPowerIncrease1.png\">
</blockquote></p>

<p>
results in
</p>

<table border=0 cellspacing=0 cellpadding=2>
<tr><td width=\"50\"></td>
    <td valign=\"bottom\"><img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/AircraftRequirements/MaximumCabinDissipatedPowerIncrease2\"></td>
    </tr>

<tr><td></td>
    <td align=\"center\">simulation result</td>
   </tr>
</table>
</html>"),
         Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}), graphics={      Text(
          extent={{-94,92},{-2,88}},
          lineColor={0,140,72},
          fontSize=10,
          horizontalAlignment=TextAlignment.Left,
          textStyle={TextStyle.Bold},
          textString="Aircraft status to be verified"),Text(
          extent={{-94,51},{-2,47}},
          lineColor={0,140,72},
          fontSize=10,
          horizontalAlignment=TextAlignment.Left,
          textString="Requirements definition",
          textStyle={TextStyle.Bold})}),
    experiment(StopTime=14400),
    __Dymola_experimentSetupOutput);
end MaximumCabinDissipatedPowerIncrease;
