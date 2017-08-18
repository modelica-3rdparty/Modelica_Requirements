within Modelica_Requirements.Examples.AircraftRequirements;
model LimitedFreshECSFlow
  "Requirement: The fresh airflow entering the pressurized areas shall be within the given domain"
   extends Modelica.Icons.Example;
   import Modelica_Requirements.LogicalFunctions.*;

  inner Modelica_Requirements.Verify.PrintViolations printViolations
    annotation (Placement(transformation(extent={{-88,74},{-68,94}})));
  Modelica_Requirements.Verify.Requirement R_FreshECSFlow(text="The fresh airflow entering the pressurized
area (including air dedicated to equipment
cooling) shall be contained within the
the given domain.")
    annotation (Placement(transformation(extent={{24,30},{90,50}})));
  Modelica.Blocks.Sources.CombiTimeTable
                               signal(table=[0.0,0,0; 1,0.5,1; 2,1,1.5; 3,1.5,3;
        4,2,5; 5,2.5,6; 6,3,7; 7,3.5,7.5; 8,4,8])
    annotation (Placement(transformation(extent={{-82,20},{-62,40}})));

  Modelica_Requirements.Sources.BooleanConstant const1
    annotation (Placement(transformation(extent={{-82,42},{-62,62}})));
  Modelica_Requirements.ChecksInFixedWindow.WithinDomain withinDomain1(polygon=[
        0.0155762,-0.0421935; 0.00936511,8.10129; 0.554531,8.09669; 3.89943,
        4.60856; 4.64519,2.9567; 4.65728,-0.0813639; 0.0311038,-0.0845185])
    annotation (Placement(transformation(extent={{-34,20},{6,60}})));
equation
  connect(const1.y, withinDomain1.condition) annotation (Line(points={{-61,52},{
          -44,52},{-44,40.1},{-36,40.1}}, color={255,0,255}));
  connect(withinDomain1.y, R_FreshECSFlow.property)
    annotation (Line(points={{7,40},{21.8,40}},       color={255,0,128}));
  connect(signal.y[1], withinDomain1.point[1])
    annotation (Line(points={{-61,30},{-36,30},{-36,29}}, color={0,0,127}));
  connect(signal.y[2], withinDomain1.point[2])
    annotation (Line(points={{-61,30},{-36,30},{-36,31}}, color={0,0,127}));
  annotation (Documentation(info="<html>
<p>
This example demonstrates the modeling and verification of the 
following aircraft requirement:
</p>

<blockquote>
<p>
<b>Requirement</b>:<br>
The fresh airflow entering the pressurized 
area (including air dedicated to equipment 
cooling) shall be within the domain
described by the following figure:
</p>
<p>
<img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/AircraftRequirements/FreshAirFlowSchedule.png\">
</p>
</blockquote>

<p>
This requirement can be modelled with the 
<a href=\"modelica://Modelica_Requirements.ChecksInFixedWindow.WithinDomain\">ChecksInFixedWindow.WithinDomain</a>
block. 
</p>

<p>
Setup of this example:
</p>

<p><blockquote>
<img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/AircraftRequirements/LimitedFreshECSFlow1.png\">
</blockquote></p>

<p>
results in (the first figure shows the domain at the end of the simulation)
</p>

<table border=0 cellspacing=0 cellpadding=2>
<tr><td width=\"50\"></td>
<td align=\"center\" valign=\"bottom\"><img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/AircraftRequirements/LimitedFreshECSFlow3.png\"></td>
</tr>
<tr><td width=\"50\"></td>
<td valign=\"bottom\"><img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/AircraftRequirements/LimitedFreshECSFlow2.png\"></td>
    </tr>

<tr><td></td>
    <td align=\"center\">simulation result</td>
   </tr>
</table>
</html>"),
         Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}),       graphics),
    experiment(StopTime=10),
    __Dymola_experimentSetupOutput);
end LimitedFreshECSFlow;
