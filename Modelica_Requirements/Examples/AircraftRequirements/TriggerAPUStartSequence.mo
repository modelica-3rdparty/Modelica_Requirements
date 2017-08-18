within Modelica_Requirements.Examples.AircraftRequirements;
model TriggerAPUStartSequence
  "Requirement: The Auxiliary Power Unit shall be started after successive start failures of one of the engines"
   extends Modelica.Icons.Example;
   import Modelica_Requirements.LogicalFunctions.*;

  parameter Integer NbMin= 3;

  inner Modelica_Requirements.Verify.PrintViolations printViolations
    annotation (Placement(transformation(extent={{-88,74},{-68,94}})));
  Modelica_Requirements.Verify.Requirement R_APUTriggering(text="APU (Auxiliar Power Unit) start 
sequence shall start after three 
succesive start failures of one 
of the engines.")
    annotation (Placement(transformation(extent={{26,26},{86,46}})));
  Modelica_Requirements.ChecksInFixedWindow.MaxRising maxRising1(
      nRisingMax=3, check=EngineStart.y)
    annotation (Placement(transformation(extent={{-34,26},{6,46}})));
  Modelica.Blocks.Sources.BooleanPulse EngineStart(startTime=1, period=1.5)
    annotation (Placement(transformation(extent={{-40,-4},{-20,16}})));
  Modelica.Blocks.Sources.BooleanStep APUSeqStarted(startTime=6)
    annotation (Placement(transformation(extent={{-70,26},{-50,46}})));
equation
  connect(maxRising1.y, R_APUTriggering.property) annotation (Line(
      points={{7,36},{24,36}},
      color={255,0,128},
      smooth=Smooth.None));
  connect(APUSeqStarted.y, maxRising1.condition) annotation (Line(
      points={{-49,36},{-42,36},{-42,36.1},{-36,36.1}},
      color={255,0,255},
      smooth=Smooth.None));
  annotation (Documentation(info="<html>
<p>
This example demonstrates the modeling and verification of the 
following aircraft requirement:
</p>

<blockquote><p>
<b>Requirement</b>:<br>
APU (Auxiliar Power Unit) start sequence 
shall start after three successive 
start failures of one of the engines.
</p></blockquote>

<p>
This is an informal requirement. It is interpreted in the following formal way:
<p>

<blockquote><p>
<b>Formalized requirement</b>:<br>
APU (Auxiliar Power Unit) start sequence 
shall start after three succesive 
start failures of one of the engines.
</p>

<blockquote><pre>
nRisingMax     : Maximum number of check rising edges.
APUSeqStarted.y: Output of the boolean step. True if the APU backup sequence is started.
EngineStart.y  : Output of the boolean pulse. True if the engine is started.

</pre></blockquote> 
Inputs and parameter of the MaxRising() block are:

<blockquote><pre>
nRisingMax = 3
condition = APUSeqStarted.y
check = EngineStart.y
</pre></blockquote>
</blockquote>
<p>
This requirement can be modelled with the 
<a href=\"modelica://Modelica_Requirements.ChecksInFixedWindow.MaxRising\">ChecksInSlidingWindow.MaxRising</a>
block. 
</p>

<p>
Test setup of this example:
</p>

<p><blockquote>
<img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/AircraftRequirements/TriggerAPUStartSequence1.png\">
</blockquote></p>

<p>
results in
</p>

<table border=0 cellspacing=0 cellpadding=2>
<tr><td width=\"50\"></td>
    <td valign=\"bottom\"><img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/AircraftRequirements/TriggerAPUStartSequence2.png\"></td>
    </tr>

<tr><td></td>
    <td align=\"center\">simulation result</td>
   </tr>
</table>
</html>"),
         Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}),       graphics),
    experiment(StopTime=8),
    __Dymola_experimentSetupOutput);
end TriggerAPUStartSequence;
