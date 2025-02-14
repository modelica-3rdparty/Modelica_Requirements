within Modelica_Requirements.Examples.AircraftRequirements;
model PreventHeatExchangerClogging
  "Requirement: Cold heat exchanger clogging shall not occur"
   extends Modelica.Icons.Example;
   import Modelica_Requirements.LogicalFunctions.*;

  parameter Modelica.Units.SI.Mass Mmax=8e-4;

  inner Modelica_Requirements.Verify.PrintViolations printViolations
    annotation (Placement(transformation(extent={{-88,14},{-74,28}})));
  Modelica_Requirements.Verify.BooleanRequirement R_Clogging(text="To prevent clogging of the cold heat
exchanger, the time integral of the product
of AirHumidity and MassAirFlow, 
is limited by %Mmax kg.")
    annotation (Placement(transformation(extent={{8,30},{68,50}})));
  Sources.RealConstant             massAirFlow(c=2e-3)
               annotation (Placement(transformation(extent={{-80,66},{-60,86}})));
  Sources.RealConstant             airHumidity(c=10/60)
    annotation (Placement(transformation(extent={{-40,66},{-20,86}})));
  Modelica_Requirements.SignalAnalysis.TriggeredIntegrator integrator1
    annotation (Placement(transformation(extent={{-50,30},{-30,50}})));
  Modelica_Requirements.LogicalBlocks.LessThreshold less(threshold=
        Mmax) annotation (Placement(transformation(extent={{-20,30},{0,50}})));
  Modelica_Requirements.Sources.BooleanConstant const1
    annotation (Placement(transformation(extent={{-66,10},{-46,30}})));
  Modelica.Blocks.Math.MultiProduct product(nu=2)
    annotation (Placement(transformation(extent={{-72,34},{-60,46}})));
equation
  connect(less.u, integrator1.y) annotation (Line(
      points={{-21,40},{-29,40}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(less.y, R_Clogging.u) annotation (Line(
      points={{0.5,40},{6,40}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(const1.y, integrator1.active) annotation (Line(
      points={{-45,20},{-40,20},{-40,33}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(airHumidity.y, product.u[1]) annotation (Line(points={{-19,76},{-12,76},
          {-12,52},{-76,52},{-76,42.1},{-72,42.1}}, color={0,0,127}));
  connect(massAirFlow.y, product.u[2]) annotation (Line(points={{-59,76},{-48,76},
          {-48,54},{-78,54},{-78,38},{-76,38},{-76,37.9},{-72,37.9}}, color={0,0,
          127}));
  connect(product.y, integrator1.u)
    annotation (Line(points={{-58.98,40},{-56,40},{-52,40}}, color={0,0,127}));
  annotation (Documentation(info="<html>
<p>
This example demonstrates the modeling and verification of the 
following aircraft requirement:
</p>

<blockquote><p>
<b>Requirement</b>:<br>
To prevent cold heat exchanger clogging, the time integral of 
the product of AirHumidity and MassAirFlow is limited.
</p></blockquote>

<p>
This requirement can be modelled with the 
<a href=\"modelica://Modelica_Requirements.SignalAnalysis.TriggeredIntegrator\">SignalAnalysis.TriggeredIntegrator</a> 
and <a href=\"modelica://Modelica_Requirements.LogicalBlocks.LessThreshold\">LogicalBlocks.LessThreshold</a> 
blocks.
</p>


<p>
Setup of this example:
</p>

<p><blockquote>
<img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/AircraftRequirements/PreventHeatExchangerClogging1.png\">
</blockquote></p>

<p>
results in
</p>

<table border=0 cellspacing=0 cellpadding=2>
<tr><td width=\"50\"></td>
    <td valign=\"bottom\"><img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/AircraftRequirements/PreventHeatExchangerClogging2.png\"></td>
    </tr>

<tr><td></td>
    <td align=\"center\">simulation result</td>
   </tr>
</table>
</html>"),
         Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}),       graphics={Text(
          extent={{-90,92},{2,88}},
          lineColor={0,140,72},
          fontSize=10,
          horizontalAlignment=TextAlignment.Left,
          textStyle={TextStyle.Bold},
          textString="Aircraft status to be verified"),Text(
          extent={{-88,61},{4,57}},
          lineColor={0,140,72},
          fontSize=10,
          horizontalAlignment=TextAlignment.Left,
          textString="Requirements definition",
          textStyle={TextStyle.Bold})}),
    experiment(StopTime=3),
    __Dymola_experimentSetupOutput);
end PreventHeatExchangerClogging;
