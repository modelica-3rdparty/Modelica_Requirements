within Modelica_Requirements;
package TimeLocators
  "Library of continuous time locators (output is true, if within time locator)"
  extends Modelica.Icons.Package;
  block Every "Output is true, during every interval for a defined duration"
    parameter Modelica.Units.SI.Time interval(start=1) "Length of interval"
      annotation (Dialog);
    parameter Modelica.Units.SI.Time duration(start=0.5)
      "Duration within interval (< interval)";
    Modelica.Blocks.Interfaces.BooleanOutput y
      "= true, during every interval for defined duration"
      annotation (Placement(transformation(extent={{200,-10},{220,10}})));
  protected
    discrete Real durationStart;
    constant Real startTime = 0;
  initial equation
    if time >= startTime then
       durationStart = startTime + interval*mod(time-startTime,interval);
    else
       durationStart = startTime;
    end if;
    y = time >= pre(durationStart) and time <= pre(durationStart) + duration;
  equation
    assert(0 < duration and duration < interval,
           "Relationship 0 < duration < interval required");

    when sample(startTime, interval) then
       durationStart = time;
       y = true;
    elsewhen time >= pre(durationStart) + duration then
       durationStart = time;
       y = false;
    end when;

    annotation (defaultComponentName="every1",
        Diagram(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-200,-100},{200,100}},
          grid={1,1}), graphics),
                        Icon(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-200,-100},{200,100}},
          grid={1,1}), graphics={
          Rectangle(
            extent={{-200,100},{200,-100}},
            lineColor={0,0,0},
            lineThickness=5.0,
            fillColor={210,210,210},
            fillPattern=FillPattern.Solid,
            borderPattern=BorderPattern.Raised),
          Rectangle(
            extent={{-190,60},{190,5}},
            lineColor={0,0,0},
            lineThickness=5.0,
            fillColor={245,245,245},
            fillPattern=FillPattern.Solid,
            borderPattern=BorderPattern.Sunken),
          Rectangle(
            extent={{-190,-30},{190,-90}},
            lineColor={0,0,0},
            lineThickness=5.0,
            fillColor={245,245,245},
            fillPattern=FillPattern.Solid,
            borderPattern=BorderPattern.Sunken),
          Text(
            extent={{-200,110},{200,150}},
            lineColor={175,175,175},
            textString="%name"),
          Text(
            extent={{-190,45},{190,15}},
            lineColor={0,0,0},
            textString="%interval s"),
          Text(
            extent={{-190,90},{20,65}},
            lineColor={95,95,95},
            horizontalAlignment=TextAlignment.Left,
            textString="every"),
          Text(
            extent={{-190,-5},{20,-30}},
            lineColor={95,95,95},
            horizontalAlignment=TextAlignment.Left,
            textString="for"),
          Text(
            extent={{-190,-45},{190,-75}},
            lineColor={0,0,0},
            textString="%duration s")}),
      Documentation(info="<html>
<h4>Syntax</h4>

<blockquote><p>
condition = <b>Every</b>(interval=..., duration=...).y;
</p></blockquote>

<h4>Description</h4>

<p>
Output <b>y</b> = true, after every <b>interval</b> seconds for <b>duration</b> seconds.
Otherwise y = false. The periodic interval starts at time = 0s.
</p>

<h4>Example</h4>

<p>
This block is demonstrated with the following
<a href=\"modelica://Modelica_Requirements.Examples.Elementary.TimeLocators.Every\">example</a>: 
</p>

<p><blockquote>
<img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/Elementary/TimeLocators/Every1.png\">
</blockquote></p>

<p>
results in
</p>

<table border=0 cellspacing=0 cellpadding=2>
<tr><td width=\"50\"></td>
    <td valign=\"bottom\"><img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/Elementary/TimeLocators/Every2.png\"></td>
    </tr>

<tr><td></td>
    <td align=\"center\">simulation result</td>
   </tr>
</table>
</html>"));
  end Every;

  block Until "Output is true, until first rising edge of input"
    input Boolean u "Boolean input" annotation(Dialog);
    Modelica.Blocks.Interfaces.BooleanOutput y
      "= true, after first rising edge of u"
      annotation (Placement(transformation(extent={{200,-10},{220,10}})));

  initial equation
    y = not u;
  equation
    when u then
      y = false;
    end when;

    annotation (defaultComponentName="until1",
         Diagram(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-200,-100},{200,100}},
          grid={1,1})), Icon(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-200,-100},{200,100}},
          grid={1,1}), graphics={
          Rectangle(
            extent={{-200,50},{200,-50}},
            lineColor={0,0,0},
            lineThickness=5.0,
            fillColor={210,210,210},
            fillPattern=FillPattern.Solid,
            borderPattern=BorderPattern.Raised),
          Rectangle(
            extent={{-190,15},{190,-40}},
            lineColor={0,0,0},
            lineThickness=5.0,
            fillColor={245,245,245},
            fillPattern=FillPattern.Solid,
            borderPattern=BorderPattern.Sunken),
          Text(
            extent={{-200,100},{200,60}},
            lineColor={175,175,175},
            textString="%name"),
          Text(
            extent={{-190,40},{20,15}},
            lineColor={95,95,95},
            textString="until",
            horizontalAlignment=TextAlignment.Left),
          Text(
            extent={{-190,0},{190,-30}},
            lineColor={0,0,0},
            textString="%u"),
          Line(
            points={{54,21},{91,21},{91,39},{101,39},{101,21},{138,21}},
            color={95,95,95},
            smooth=Smooth.None),
          Line(
            points={{52,40},{93,40},{93,24},{137,24}},
            color={255,0,0},
            smooth=Smooth.None)}),
      Documentation(info="<html>
<h4>Syntax</h4>

<blockquote><p>
condition = <b>Until</b>(u=...).y;
</p></blockquote>

<h4>Description</h4>

<p>
Until the first rising edge of Boolean input u, output y = true. Afterwards, y = false.
If input u = true at initialization, y = false always.
</p>

<h4>Example</h4>

<p>
This block is demonstrated with the following
<a href=\"modelica://Modelica_Requirements.Examples.Elementary.TimeLocators.Until\">example</a>: 
</p>

<p><blockquote>
<img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/Elementary/TimeLocators/Until1.png\">
</blockquote></p>

<p>
results in
</p>

<table border=0 cellspacing=0 cellpadding=2>
<tr><td width=\"50\"></td>
    <td valign=\"bottom\"><img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/Elementary/TimeLocators/Until2.png\"></td>
    </tr>

<tr><td></td>
    <td align=\"center\">simulation result</td>
   </tr>
</table>
</html>"));
  end Until;

  block After "Output is true, after first rising edge of input"
    input Boolean u "Boolean input" annotation(Dialog);
    Modelica.Blocks.Interfaces.BooleanOutput y
      "= true, after first rising edge of u"
      annotation (Placement(transformation(extent={{200,-10},{220,10}})));
  initial equation
    y = u;
  equation
    when u then
      y = true;
    end when;

    annotation (defaultComponentName="after1",
         Diagram(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-200,-100},{200,100}},
          grid={1,1})), Icon(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-200,-100},{200,100}},
          grid={1,1}), graphics={
          Rectangle(
            extent={{-200,50},{200,-50}},
            lineColor={0,0,0},
            lineThickness=5.0,
            fillColor={210,210,210},
            fillPattern=FillPattern.Solid,
            borderPattern=BorderPattern.Raised),
          Rectangle(
            extent={{-190,15},{190,-40}},
            lineColor={0,0,0},
            lineThickness=5.0,
            fillColor={245,245,245},
            fillPattern=FillPattern.Solid,
            borderPattern=BorderPattern.Sunken),
          Text(
            extent={{-200,100},{200,60}},
            lineColor={175,175,175},
            textString="%name"),
          Text(
            extent={{-190,40},{20,15}},
            lineColor={95,95,95},
            textString="after (flat)",
            horizontalAlignment=TextAlignment.Left),
          Text(
            extent={{-190,0},{190,-30}},
            lineColor={0,0,0},
            textString="%u"),
          Line(
            points={{44,21},{81,21},{81,39},{91,39},{91,21},{128,21}},
            color={95,95,95},
            smooth=Smooth.None),
          Line(
            points={{45,23},{77,23},{77,39},{126,39}},
            color={255,0,0},
            smooth=Smooth.None)}),
      Documentation(info="<html>
<h4>Syntax</h4>

<blockquote><p>
condition = <b>After</b>(u=...).y;
</p></blockquote>

<h4>Description</h4>

<p>
At the first rising edge of Boolean input u, output y = true (and remains true).
If input u = true at initialization, y = true always.
</p>

<h4>Example</h4>

<p>
This block is demonstrated with the following
<a href=\"modelica://Modelica_Requirements.Examples.Elementary.TimeLocators.After\">example</a>: 
</p>

<p><blockquote>
<img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/Elementary/TimeLocators/After1.png\">
</blockquote></p>

<p>
results in
</p>

<table border=0 cellspacing=0 cellpadding=2>
<tr><td width=\"50\"></td>
    <td valign=\"bottom\"><img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/Elementary/TimeLocators/After2.png\"></td>
    </tr>

<tr><td></td>
    <td align=\"center\">simulation result</td>
   </tr>
</table>
</html>"));
  end After;

  block AfterFor
    "Output is true, after rising edge of input for defined duration (flat version)"
    input Boolean u "Boolean input" annotation(Dialog);
    parameter Modelica.Units.SI.Time duration(start=1)
      "Duration after rising edge of u";
    Modelica.Blocks.Interfaces.BooleanOutput y
      "= true, after rising edge of u for given duration"
      annotation (Placement(transformation(extent={{200,-10},{220,10}})));
  protected
    discrete Boolean startDuration;
    discrete Real startTime;
  initial equation
    startDuration = u;
    startTime = time;
    y = u;
  equation
    when u then
      // u has a rising edge (duration starts)
      startDuration = true;
      startTime = time;
      y = true;
    elsewhen pre(startDuration) and time >= pre(startTime) + duration then
      // end of duration reached
      startDuration = false;
      startTime = time;
      y = false;
    end when;

    annotation (defaultComponentName="afterFor1",
        Diagram(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-200,-100},{200,100}},
          grid={1,1}), graphics),
                        Icon(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-200,-100},{200,100}},
          grid={1,1}), graphics={
          Rectangle(
            extent={{-200,100},{200,-100}},
            lineColor={0,0,0},
            lineThickness=5.0,
            fillColor={210,210,210},
            fillPattern=FillPattern.Solid,
            borderPattern=BorderPattern.Raised),
          Rectangle(
            extent={{-190,60},{190,5}},
            lineColor={0,0,0},
            lineThickness=5.0,
            fillColor={245,245,245},
            fillPattern=FillPattern.Solid,
            borderPattern=BorderPattern.Sunken),
          Rectangle(
            extent={{-190,-30},{190,-90}},
            lineColor={0,0,0},
            lineThickness=5.0,
            fillColor={245,245,245},
            fillPattern=FillPattern.Solid,
            borderPattern=BorderPattern.Sunken),
          Text(
            extent={{-200,110},{200,150}},
            lineColor={175,175,175},
            textString="%name"),
          Text(
            extent={{-190,45},{190,15}},
            lineColor={0,0,0},
            textString="%u"),
          Text(
            extent={{-190,90},{20,65}},
            lineColor={95,95,95},
            textString="after (flat)",
            horizontalAlignment=TextAlignment.Left),
          Text(
            extent={{-190,-5},{20,-30}},
            lineColor={95,95,95},
            horizontalAlignment=TextAlignment.Left,
            textString="for"),
          Text(
            extent={{-190,-45},{190,-75}},
            lineColor={0,0,0},
            textString="%duration s")}),
      Documentation(info="<html>
<h4>Syntax</h4>

<blockquote><p>
condition = <b>AfterFor</b>(u=..., duration=...).y;
</p></blockquote>

<h4>Description</h4>

<p>
Output <b>y</b> = true, after a rising edge of the input <b>u</b> for the defined <b>duration</b>
(if a previous duration was not yet completed, it is implicitely canceled by a new rising
edge of u; this has the effect to make the y=true phase longer; see time = 7 s - 9.5 s in the 
example below).
Otherwise, y = false. If u = true at initialization, y = true for the defined duration.
</p>

<h4>Example</h4>

<p>
This block is demonstrated with the following
<a href=\"modelica://Modelica_Requirements.Examples.Elementary.TimeLocators.AfterFor\">example</a>: 
</p>

<p><blockquote>
<img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/Elementary/TimeLocators/AfterFor1.png\">
</blockquote></p>

<p>
results in
</p>

<table border=0 cellspacing=0 cellpadding=2>
<tr><td width=\"50\"></td>
    <td valign=\"bottom\"><img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/Elementary/TimeLocators/AfterFor2.png\"></td>
    </tr>

<tr><td></td>
    <td align=\"center\">simulation result</td>
   </tr>
</table>
</html>"));
  end AfterFor;

  block AfterUntil
    "Output is true, after rising edge of input 1 until the rising edge of input 2"
    input Boolean u1 "Boolean input 1" annotation (Dialog);
    input Boolean u2 "Boolean input 2" annotation (Dialog);

    Modelica.Blocks.Interfaces.BooleanOutput y
      "= true, after rising edge of u1 until rising edge of u2"
      annotation (Placement(transformation(extent={{200,-10},{220,10}})));
  initial equation
    y = u1;
  equation
    when u1 then
      y = true;
    elsewhen u2 then
      y = false;
    end when;
     annotation (defaultComponentName="afterUntil1",
        Diagram(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-200,-100},{200,100}},
          grid={1,1}), graphics),
                        Icon(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-200,-100},{200,100}},
          grid={1,1}), graphics={
          Rectangle(
            extent={{-200,100},{200,-100}},
            lineColor={0,0,0},
            lineThickness=5.0,
            fillColor={210,210,210},
            fillPattern=FillPattern.Solid,
            borderPattern=BorderPattern.Raised),
          Rectangle(
            extent={{-190,60},{190,5}},
            lineColor={0,0,0},
            lineThickness=5.0,
            fillColor={245,245,245},
            fillPattern=FillPattern.Solid,
            borderPattern=BorderPattern.Sunken),
          Rectangle(
            extent={{-190,-30},{190,-90}},
            lineColor={0,0,0},
            lineThickness=5.0,
            fillColor={245,245,245},
            fillPattern=FillPattern.Solid,
            borderPattern=BorderPattern.Sunken),
          Text(
            extent={{-200,110},{200,150}},
            lineColor={175,175,175},
            textString="%name"),
          Text(
            extent={{-190,45},{190,15}},
            lineColor={0,0,0},
            textString="%u1"),
          Text(
            extent={{-190,90},{20,65}},
            lineColor={95,95,95},
            textString="after (flat)",
            horizontalAlignment=TextAlignment.Left),
          Text(
            extent={{-190,-5},{20,-30}},
            lineColor={95,95,95},
            horizontalAlignment=TextAlignment.Left,
            textString="until"),
          Text(
            extent={{-190,-45},{190,-75}},
            lineColor={0,0,0},
            textString="%u2")}),
      Documentation(info="<html>
<h4>Syntax</h4>

<blockquote><p>
condition = <b>AfterUntil</b>(u1=...,u2=...).y;
</p></blockquote>

<h4>Description</h4>

<p>
At a rising edge of Boolean input u1, output y = true until the Boolean input u2 has a rising edge.
If input u1 = true at initialization, y = true.
</p>

<h4>Example</h4>

<p>
This block is demonstrated with the following
<a href=\"modelica://Modelica_Requirements.Examples.Elementary.TimeLocators.AfterUntil\">example</a>: 
</p>

<p><blockquote>
<img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/Elementary/TimeLocators/AfterUntil1.png\">
</blockquote></p>

<p>
results in
</p>

<table border=0 cellspacing=0 cellpadding=2>
<tr><td width=\"50\"></td>
    <td valign=\"bottom\"><img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/Elementary/TimeLocators/AfterUntil2.png\"></td>
    </tr>

<tr><td></td>
    <td align=\"center\">simulation result</td>
   </tr>
</table>
</html>"));
  end AfterUntil;
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics={
        Line(
          points={{-88,-68},{-2,-68},{-2,-22},{86,-22}},
          color={0,0,0},
          smooth=Smooth.None),
        Line(
          points={{-2,84},{-2,-12}},
          color={0,0,0},
          smooth=Smooth.None),
        Polygon(
          points={{-28,34},{22,34},{-2,-12},{-28,34}},
          lineColor={135,135,135},
          smooth=Smooth.None,
          fillPattern=FillPattern.Solid,
          fillColor={135,135,135})}), Documentation(info="<html>
<p>
This library contains blocks defining <b>continuous time locators</b>.
All the blocks have a Boolean output <b>y</b>. Whenever y = true, 
the desired continuous time location is defined. The output y is
usually used as input to one of the 
<a href=\"modelica://Modelica_Requirements.ChecksInFixedWindow\">ChecksInFixedWindow</a>
blocks that check particular properties at the defined time locations.
</p>
</html>"));
end TimeLocators;
