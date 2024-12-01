within Modelica_Requirements.Examples.AircraftRequirements;
model MaximumCabinTemperatureIncrease
  "Requirement: The temperature increase of the cabin area is limited to ensure passenger comfort"
   extends Modelica.Icons.Example;
   import Modelica_Requirements.LogicalFunctions.*;

  inner Modelica_Requirements.Verify.PrintViolations printViolations
    annotation (Placement(transformation(extent={{-80,10},{-60,30}})));
  Verify.BooleanRequirement                R_TCabin(text="In the cabin area, the temperature
increase should not exceed 3°C
per hour.") annotation (Placement(transformation(extent={{-6,20},{46,40}})));
  Modelica.Blocks.Sources.CombiTimeTable T_cabin(table=[0,20; 3600,22.5; 7200,
        27; 11800,28])
    annotation (Placement(transformation(extent={{-80,60},{-60,80}})));
  ChecksInSlidingWindow.MaxIncrease maxIncrease(window(displayUnit="h") = 3600,
      upperLimit=3)
    annotation (Placement(transformation(extent={{-40,20},{-20,40}})));
equation
  connect(maxIncrease.y, R_TCabin.u)
    annotation (Line(points={{-19,30},{-7.73333,30}}, color={255,0,255}));
  connect(T_cabin.y[1], maxIncrease.u) annotation (Line(points={{-59,70},{-54,
          70},{-48,70},{-48,30},{-42,30}}, color={0,0,127}));
  annotation (Documentation(info="<html>
<p>
This example demonstrates the modeling and verification of the
following aircraft requirement:
</p>

<blockquote><p>
<b>Requirement</b>:<br>
In the cabin area, the temperature increase
should not exceed 3°C per hour.
</p></blockquote>

</blockquote>
<p>
This requirement can be modelled with the
<a href=\"modelica://Modelica_Requirements.ChecksInSlidingWindow.MaxIncrease\">ChecksInSlidingWindow.MaxIncrease</a>
block.
</p>

<p>
Setup of this example:
</p>

<p><blockquote>
<img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/AircraftRequirements/MaximumCabinTemperatureIncrease1.png\">
</blockquote></p>

<p>
results in
</p>

<table border=0 cellspacing=0 cellpadding=2>
<tr><td width=\"50\"></td>
    <td valign=\"bottom\"><img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/AircraftRequirements/MaximumCabinTemperatureIncrease2.png\"></td>
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
          extent={{-94,43},{-2,39}},
          lineColor={0,140,72},
          fontSize=10,
          horizontalAlignment=TextAlignment.Left,
          textString="Requirements definition",
          textStyle={TextStyle.Bold})}),
    experiment(StopTime=10800),
    __Dymola_experimentSetupOutput);
end MaximumCabinTemperatureIncrease;
