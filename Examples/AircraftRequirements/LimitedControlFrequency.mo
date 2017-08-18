within Modelica_Requirements.Examples.AircraftRequirements;
model LimitedControlFrequency
  "Requirement: The frequency of the control signal is limited"
   extends Modelica.Icons.Example;
  constant Real pi = Modelica.Constants.pi;
  Modelica_Requirements.SignalAnalysis.CrossingMonitoring crossing(threshold=
        0.4) annotation (Placement(transformation(extent={{-4,60},{16,80}})));
  Modelica_Requirements.ChecksInSlidingWindow.MaxFrequency meanFreq(
    check=crossing.y,
    window=2,
    freqHzMeanMax=1.5)
    annotation (Placement(transformation(extent={{-52,10},{-12,30}})));
  Modelica_Requirements.Sources.RealExpression expr1(y=2*exp(-0.2*
        time)*sin(2*pi*(0.15*time)*time))
    annotation (Placement(transformation(extent={{-80,60},{-18,80}})));
  Modelica_Requirements.Verify.BooleanRequirement requirement(text="The frequency of the control signal
of the valve should not exceed 1.5 Hz
during more than 2 seconds")
    annotation (Placement(transformation(extent={{2,10},{62,30}})));
  inner Modelica_Requirements.Verify.PrintViolations printViolations
    annotation (Placement(transformation(extent={{-80,12},{-60,32}})));
equation
  connect(meanFreq.y, requirement.u) annotation (Line(points={{-11,20},{-11,20},
          {0,20}},       color={255,0,255}));
  connect(expr1.y, crossing.u) annotation (Line(points={{-16.45,70},{-16.45,70},
          {-6,70}},  color={0,0,127}));
  annotation (Documentation(info="<html>
<p>
This example demonstrates the modeling and verification of the 
following aircraft requirement:
</p>

<blockquote><p>
<b>Requirement</b>:<br>
The frequency of the control signal of the valve 
must not exceed 1.5 Hz during more than 2 seconds.
</p></blockquote>

<p>
This is an informal requirement. It is interpreted in the following formal way:
<p>

<blockquote><p>
<b>Formalized requirement</b>:<br>
The mean frequency of the control signal of the valve 
must not exceed 1.5 Hz during any 2 seconds time window.
The mean frequency freqHzMean in this window is defined as
</p>

<blockquote><pre>
T        : Length of sliding window (= 2 seconds)
nCrossing: Number of threshold crossing edges of check in the last T seconds

if nCrossing > 1 then
  freqHzMean = 1/(T/( (nCrossing-1)/2 ));
else
  freqHzMean = 0
end if;
</pre></blockquote>
</blockquote>
<p>
This requirement can be modelled with the 
<a href=\"modelica://Modelica_Requirements.ChecksInSlidingWindow.MeanFrequency\">ChecksInSlidingWindow.MeanFrequency</a>
block. 
</p>

<p>
Setup of this example:
</p>

<p><blockquote>
<img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/AircraftRequirements/LimitedControlFrequency1.png\">
</blockquote></p>

<p>
results in
</p>

<table border=0 cellspacing=0 cellpadding=2>
<tr><td width=\"50\"></td>
    <td valign=\"bottom\"><img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/AircraftRequirements/LimitedControlFrequency2.png\"></td>
    </tr>

<tr><td></td>
    <td align=\"center\">simulation result</td>
   </tr>
</table>
</html>"),
         Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}),       graphics={Text(
          extent={{-92,90},{0,86}},
          lineColor={0,140,72},
          fontSize=10,
          horizontalAlignment=TextAlignment.Left,
          textString="Control signal to be verified",
          textStyle={TextStyle.Bold}),                 Text(
          extent={{-90,46},{2,42}},
          lineColor={0,140,72},
          fontSize=10,
          horizontalAlignment=TextAlignment.Left,
          textString="Requirements definition",
          textStyle={TextStyle.Bold})}),
    experiment(StopTime=8));
end LimitedControlFrequency;
