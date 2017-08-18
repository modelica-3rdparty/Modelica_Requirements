within Modelica_Requirements;
package ChecksInFixedWindow
  "Library of check blocks (if the condition input is true, a property must hold)"
  extends Modelica.Icons.Package;

  block During "In every true condition phase, check must be true"
    extends Modelica_Requirements.Interfaces.PartialCheck;
    import Modelica_Requirements.Types.Property;

  equation
     y = if condition then
          (if check then Property.Satisfied else Property.Violated) else Property.Undecided;
    annotation (defaultComponentName="during1",
          Icon(coordinateSystem(preserveAspectRatio=false, extent={{-200,-100},
              {200,100}}), graphics={
          Line(
            points={{-168,18},{-168,18},{-168,64},{26,64},{26,22},{26,22}},
            color={255,0,0},
            smooth=Smooth.None),
          Line(
            points={{-192,18},{-168,18}},
            color={0,0,0},
            smooth=Smooth.None),
          Line(
            points={{26,22},{50,22}},
            color={0,0,0},
            smooth=Smooth.None)}), Documentation(info="<html>
<h4>Syntax</h4>

<blockquote><p>
property = <b>During</b>(condition=..., check=...).y;
</p></blockquote>

<h4>Description</h4>

<p>
In every duration where the Boolean input <b>condition</b> is true,
the Boolean input <b>check</b> must be true.
During a true condition phase, property output <b>y</b> = Satisfied if check = true,
and Violated if check = false.
During a false condition phase, property output y = Undecided.
</p>


<p>
Violated, Undecided, and Satisfied are elements of enumeration
<a href=\"modelica://Modelica_Requirements.Types.Property\">Property</a>.
</p>

<h4>Example</h4>

<p>
This block is demonstrated with the following
<a href=\"modelica://Modelica_Requirements.Examples.Elementary.ChecksInFixedWindow.During\">example</a>: 
</p>

<p><blockquote>
<img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/Elementary/ChecksInFixedWindow/During1.png\">
</blockquote></p>

<p>
results in
</p>

<table border=0 cellspacing=0 cellpadding=2>
<tr><td width=\"50\"></td>
    <td valign=\"bottom\"><img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/Elementary/ChecksInFixedWindow/During2.png\"></td>
    </tr>

<tr><td></td>
    <td align=\"center\">simulation result</td>
   </tr>
</table>
</html>"));
  end During;

  block MinDuration
    "In every true condition phase, check must be true for at least the defined duration"
    extends Modelica_Requirements.Interfaces.PartialCheck;
    import Modelica_Requirements.Types.Property;

    parameter Modelica.SIunits.Time durationMin(start=1,min=0)
      "Minimum duration in true condition phase";
  protected
    discrete Real actualDuration;
    discrete Real startTime;
    discrete Boolean startCheck;
  initial equation
    actualDuration = 0.0;
    startTime = time;
    startCheck = condition and check;
    y = if condition and actualDuration >= durationMin then
           Property.Satisfied else Property.Undecided;

  algorithm
    when condition then
       // condition has a rising edge (true condition phase started)
       actualDuration :=0.0;
       startTime :=time;
       startCheck :=check;
       y :=if actualDuration >= durationMin then Property.Satisfied else Property.Undecided;

    elsewhen condition and check then
       // true condition phase and rising edge of check
       startTime :=time;
       startCheck :=true;

    elsewhen condition and startCheck and
             pre(actualDuration) + time - pre(startTime) >= durationMin then
       // Minimum duration reached
       y :=Property.Satisfied;

    elsewhen condition and not check then
       // true condition phase and falling edge of check
       startCheck := false;
       actualDuration := pre(actualDuration) + time - pre(startTime);

    elsewhen not condition then
       // condition has a falling edge (true condition phase terminated)
       actualDuration := if startCheck then pre(actualDuration) + time - pre(startTime) else pre(actualDuration);
       y :=if actualDuration >= durationMin then Property.Satisfied else Property.Violated;
    end when;

    annotation (defaultComponentName="minDuration1",
         Icon(coordinateSystem(preserveAspectRatio=false, extent={{-200,-100},
              {200,100}}), graphics={
          Rectangle(
            extent={{-160,60},{20,10}},
            lineColor={0,0,0},
            lineThickness=5.0,
            fillColor={245,245,245},
            fillPattern=FillPattern.Solid,
            borderPattern=BorderPattern.Sunken),
          Text(
            extent={{-160,45},{20,15}},
            lineColor={0,0,0},
            fillColor={255,0,0},
            fillPattern=FillPattern.Solid,
            textString="%durationMin s"),
          Line(
            points={{-168,18},{-168,18},{-168,64},{26,64},{26,22},{26,22}},
            color={255,0,0},
            smooth=Smooth.None),
          Line(
            points={{-192,18},{-168,18}},
            color={0,0,0},
            smooth=Smooth.None),
          Line(
            points={{26,22},{50,22}},
            color={0,0,0},
            smooth=Smooth.None),
          Text(
            extent={{-160,90},{20,65}},
            lineColor={95,95,95},
            textString=">=")}),    Documentation(info="<html>
<h4>Syntax</h4>

<blockquote><p>
property = <b>MinDuration</b>(condition=..., check=..., durationMin=...).y;
</p></blockquote>

<h4>Description</h4>

<p>
In every duration where the Boolean input <b>condition</b> is true,
the Boolean input <b>check</b> must be true for at least the time span 
defined by parameter <b>durationMin</b>.
Whenever this property is fulfilled, property output y = Satisfied.
If this property is not fulfilled at the end of a true condition phase,
property output y = Violated. 
At initialization and when entering a true condition phase,
property output y = Undecided.
Output y keeps its value, until one of the above conditions occur.
</p>

<p>
Violated, Undecided, and Satisfied are elements of enumeration
<a href=\"modelica://Modelica_Requirements.Types.Property\">Property</a>.
</p>

<h4>Example</h4>

<p>
This block is demonstrated with the following
<a href=\"modelica://Modelica_Requirements.Examples.Elementary.ChecksInFixedWindow.MinDuration\">example</a>: 
</p>

<p><blockquote>
<img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/Elementary/ChecksInFixedWindow/MinDuration1.png\">
</blockquote></p>

<p>
results in
</p>

<table border=0 cellspacing=0 cellpadding=2>
<tr><td width=\"50\"></td>
    <td valign=\"bottom\"><img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/Elementary/ChecksInFixedWindow/MinDuration2.png\"></td>
    </tr>

<tr><td></td>
    <td align=\"center\">simulation result</td>
   </tr>
</table>
</html>"));
  end MinDuration;

  block MaxDuration
    "In every true condition phase, check must be true for at most the defined duration"
    extends Modelica_Requirements.Interfaces.PartialCheck;
    import Modelica_Requirements.Types.Property;

    parameter Modelica.SIunits.Time durationMax(start=1,min=0)
      "Maximum duration in true condition phase";
  protected
    discrete Real actualDuration;
    discrete Real startTime;
    discrete Boolean startCheck;
  initial equation
    actualDuration = 0.0;
    startTime = time;
    startCheck = condition and check;
    y = if condition then Property.Satisfied else Property.Undecided;

  algorithm
    when condition then
       // condition has a rising edge (true condition phase started)
       actualDuration :=0.0;
       startTime :=time;
       startCheck :=check;
       y :=Property.Satisfied;

    elsewhen condition and check then
       // true condition phase and rising edge of check
       startTime := time;
       startCheck := true;

    elsewhen condition and startCheck and pre(actualDuration) + time - pre(startTime) <= durationMax and not check then
       // true condition phase and falling edge of check before the Maximum duration expired;
       startCheck := false;
       actualDuration := pre(actualDuration) + time - pre(startTime);
       y :=Property.Satisfied;

    elsewhen condition and check and pre(actualDuration) + time - pre(startTime) > durationMax then
       // Maximum duration has been exceded before the falling edge of check
        y :=Property.Violated;

     elsewhen condition and not check then
       // true condition phase and falling edge of check
       startCheck :=false;
       actualDuration := pre(actualDuration) + time - pre(startTime);

    elsewhen not condition then
       // condition has a falling edge (true condition phase terminated)
       actualDuration := if startCheck then pre(actualDuration) + time - pre(startTime) else pre(actualDuration);
       y :=if actualDuration <= durationMax then Property.Satisfied else Property.Violated;
    end when;

    annotation (defaultComponentName="maxDuration1",
         Icon(coordinateSystem(preserveAspectRatio=false, extent={{-200,-100},
              {200,100}}), graphics={
          Rectangle(
            extent={{-160,60},{20,10}},
            lineColor={0,0,0},
            lineThickness=5.0,
            fillColor={245,245,245},
            fillPattern=FillPattern.Solid,
            borderPattern=BorderPattern.Sunken),
          Text(
            extent={{-160,45},{20,15}},
            lineColor={0,0,0},
            fillColor={255,0,0},
            fillPattern=FillPattern.Solid,
            textString="%durationMax s"),
          Line(
            points={{-168,18},{-168,18},{-168,64},{26,64},{26,22},{26,22}},
            color={255,0,0},
            smooth=Smooth.None),
          Line(
            points={{-192,18},{-168,18}},
            color={0,0,0},
            smooth=Smooth.None),
          Line(
            points={{26,22},{50,22}},
            color={0,0,0},
            smooth=Smooth.None),
          Text(
            extent={{-160,90},{20,65}},
            lineColor={95,95,95},
            textString="<=")}),    Documentation(info="<html>
<h4>Syntax</h4>

<blockquote><p>
property = <b>MaxDuration</b>(condition=..., check=..., durationMax=...).y;
</p></blockquote>

<h4>Description</h4>

<p>
In every duration where the Boolean input <b>condition</b> is true,
the Boolean input <b>check</b> must be true for at most the time span 
defined by parameter <b>durationMax</b>.
Whenever this property is fulfilled, property output y = Satisfied.
If this property is not fulfilled during a true condition phase,
property output y = Violated. 
If condition=false during initialization, property output y = Undecided.
Output y keeps its value, until one of the above conditions occur.
</p>

<p>
Violated, Undecided, and Satisfied are elements of enumeration
<a href=\"modelica://Modelica_Requirements.Types.Property\">Property</a>.
</p>

<h4>Example</h4>

<p>
This block is demonstrated with the following
<a href=\"modelica://Modelica_Requirements.Examples.Elementary.ChecksInFixedWindow.MaxDuration\">example</a>: 
</p>

<p><blockquote>
<img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/Elementary/ChecksInFixedWindow/MaxDuration1.png\">
</blockquote></p>

<p>
results in
</p>

<table border=0 cellspacing=0 cellpadding=2>
<tr><td width=\"50\"></td>
    <td valign=\"bottom\"><img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/Elementary/ChecksInFixedWindow/MaxDuration2.png\"></td>
    </tr>

<tr><td></td>
    <td align=\"center\">simulation result</td>
   </tr>
</table>
</html>"));
  end MaxDuration;

  block BandDuration
    "In every true condition phase, check must be true for at least a minimum duration and at most a maximum duration"
    extends Modelica_Requirements.Interfaces.PartialCheck;
    import Modelica_Requirements.Types.Property;
    parameter Modelica.SIunits.Time durationMin(start=1) "Minimum duration";
    parameter Modelica.SIunits.Time durationMax(start=2) "Maximum duration";
  protected
    discrete Real actualDuration;
    discrete Real startTime;
    discrete Boolean startCheck;
  initial equation
    actualDuration = 0.0;
    startTime = time;
    startCheck = condition and check;
    y = if condition and actualDuration >= durationMin then
           Property.Satisfied else Property.Undecided;

  equation
    assert(durationMax >= durationMin, "durationMax >= durationMin required");

  algorithm
    when condition then
       // condition has a rising edge (true condition phase started)
       actualDuration :=0.0;
       startTime :=time;
       startCheck :=check;
       y :=if actualDuration >= durationMin then Property.Satisfied else Property.Undecided;

    elsewhen condition and check then
       // true condition phase and rising edge of check
       startTime := time;
       startCheck := true;

    elsewhen condition and startCheck and
             pre(actualDuration) + time - pre(startTime) >= durationMin then
       // Minimum duration reached
       y :=Property.Satisfied;

    elsewhen condition and check and pre(actualDuration) + time - pre(startTime) > durationMax then
       // Maximum duration has been exceeded before the falling edge of check
        y :=Property.Violated;

     elsewhen condition and not check then
       // true condition phase and falling edge of check
       startCheck :=false;
       actualDuration := pre(actualDuration) + time - pre(startTime);

    elsewhen not condition then
       // condition has a falling edge (true condition phase terminated)
       actualDuration := if startCheck then pre(actualDuration) + time - pre(startTime) else pre(actualDuration);
       y :=if actualDuration >= durationMin and actualDuration <= durationMax then
              Property.Satisfied else Property.Violated;
    end when;

    annotation (defaultComponentName="bandDuration1",
         Icon(coordinateSystem(preserveAspectRatio=false, extent={{-200,-100},
              {200,100}}), graphics={
          Line(
            points={{-168,18},{-168,18},{-168,64},{26,64},{26,22},{26,22}},
            color={255,0,0},
            smooth=Smooth.None),
          Line(
            points={{-192,18},{-168,18}},
            color={0,0,0},
            smooth=Smooth.None),
          Line(
            points={{26,22},{50,22}},
            color={0,0,0},
            smooth=Smooth.None),
          Text(
            extent={{-160,90},{-75,65}},
            lineColor={95,95,95},
            textString=">="),
          Rectangle(
            extent={{-160,60},{-75,10}},
            lineColor={0,0,0},
            lineThickness=5.0,
            fillColor={245,245,245},
            fillPattern=FillPattern.Solid,
            borderPattern=BorderPattern.Sunken),
          Rectangle(
            extent={{-66,60},{19,10}},
            lineColor={0,0,0},
            lineThickness=5.0,
            fillColor={245,245,245},
            fillPattern=FillPattern.Solid,
            borderPattern=BorderPattern.Sunken),
          Text(
            extent={{-160,45},{-75,20}},
            lineColor={0,0,0},
            fillColor={255,0,0},
            fillPattern=FillPattern.Solid,
            textString="%durationMin"),
          Text(
            extent={{-65,45},{20,20}},
            lineColor={0,0,0},
            fillColor={255,0,0},
            fillPattern=FillPattern.Solid,
            textString="%durationMax"),
          Text(
            extent={{28,46},{60,24}},
            lineColor={95,95,95},
            textString="s"),
          Text(
            extent={{-65,90},{20,65}},
            lineColor={95,95,95},
            textString="<=")}),         Documentation(info="<html>
<h4>Syntax</h4>

<blockquote><p>
property = <b>BandDuration</b>(condition=..., check=..., durationMin=..., durationMax=...).y;
</p></blockquote>

<h4>Description</h4>

<p>
In every duration where the Boolean input <b>condition</b> is true,
the Boolean input <b>check</b> must be true at least for the time span defined by  parameter <b>durationMin</b> and for at most the time span 
defined by parameter <b>durationMax</b>.
Whenever this property is fulfilled, property output y = Satisfied.
If this property is not fulfilled during a true condition phase, property output y = Violated.
If condition=true and durationMin=0 during initialization, property output y = Satisfied
else y = Undecided. Output y keeps its value, until one of the above conditions occur.
</p>

<p>
Violated, Undecided, and Satisfied are elements of enumeration
<a href=\"modelica://Modelica_Requirements.Types.Property\">Property</a>.
</p>

<h4>Example</h4>

<p>
This block is demonstrated with the following
<a href=\"modelica://Modelica_Requirements.Examples.Elementary.ChecksInFixedWindow.BandDuration\">example</a>: 
</p>

<p><blockquote>
<img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/Elementary/ChecksInFixedWindow/BandDuration1.png\">
</blockquote></p>

<p>
results in
</p>

<table border=0 cellspacing=0 cellpadding=2>
<tr><td width=\"50\"></td>
    <td valign=\"bottom\"><img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/Elementary/ChecksInFixedWindow/BandDuration2.png\"></td>
    </tr>

<tr><td></td>
    <td align=\"center\">simulation result</td>
   </tr>
</table>
</html>"));
  end BandDuration;

  block NoRising
    "In every true condition phase, no rising edge of check is allowed"
    extends Modelica_Requirements.Interfaces.PartialCheck;
    import Modelica_Requirements.Types.Property;

  initial equation
    y = Property.Undecided;
  equation
    when condition then
       y = Property.Undecided;
    elsewhen condition and check then
       y = Property.Violated;
    elsewhen not condition then
       y = if pre(y) == Property.Violated then Property.Violated else Property.Satisfied;
    end when;

    annotation (defaultComponentName="noRising1",
         Icon(coordinateSystem(preserveAspectRatio=false, extent={{-200,-100},
              {200,100}}), graphics={
          Line(
            points={{-168,18},{-168,18},{-168,64},{26,64},{26,22},{26,22}},
            color={255,0,0},
            smooth=Smooth.None),
          Line(
            points={{-192,18},{-168,18}},
            color={0,0,0},
            smooth=Smooth.None),
          Line(
            points={{26,22},{50,22}},
            color={0,0,0},
            smooth=Smooth.None),
          Text(
            extent={{-162,52},{18,27}},
            lineColor={95,95,95},
            textString="#edges == 0")}),
                                       Documentation(info="<html>
<h4>Syntax</h4>

<blockquote><p>
property = <b>NoRising</b>(condition=..., check=...).y;
</p></blockquote>

<h4>Description</h4>

<p>
In every duration where the Boolean input <b>condition</b> is true,
the Boolean input <b>check</b> must not have any rising edges. 
Property output <b>y</b> is initialized to Undecided.
When condition becomes true (so entering a duration), property output y = Undecided 
until either check has a rising edge in this duration, then y = Violated,
or the condition becomes false without any rising edge of check,
then y = Satisfied.
</p>

<p>
Violated, Undecided, and Satisfied are elements of enumeration
<a href=\"modelica://Modelica_Requirements.Types.Property\">Property</a>.
</p>

<h4>Example</h4>

<p>
This block is demonstrated with the following
<a href=\"modelica://Modelica_Requirements.Examples.Elementary.ChecksInFixedWindow.NoRising\">example</a>: 
</p>

<p><blockquote>
<img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/Elementary/ChecksInFixedWindow/NoRising1.png\">
</blockquote></p>

<p>
results in
</p>

<table border=0 cellspacing=0 cellpadding=2>
<tr><td width=\"50\"></td>
    <td valign=\"bottom\"><img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/Elementary/ChecksInFixedWindow/NoRising2.png\"></td>
    </tr>

<tr><td></td>
    <td align=\"center\">simulation result</td>
   </tr>
</table>
</html>"));
  end NoRising;

  block FixedRising
    "In every true condition phase, a defined number of check rising edges must occur"
    extends Modelica_Requirements.Interfaces.PartialCheck;
    import Modelica_Requirements.Types.Property;

    parameter Integer nRising(min=0)=1 "Number of required check rising edges";
  protected
    discrete Integer countRising;
  initial equation
    countRising = 0;
    y = if condition and nRising == 0 then Property.Satisfied else Property.Undecided;
  equation
    when condition then
       countRising = 0;
       y = if countRising == nRising then Property.Satisfied else
           (if countRising < nRising then Property.Undecided else Property.Violated);
    elsewhen condition and check then
       countRising = pre(countRising) + 1;
       y = if countRising == nRising then Property.Satisfied else
           (if countRising < nRising then Property.Undecided else Property.Violated);
    elsewhen not condition then
       countRising = pre(countRising);
       y = if countRising == nRising then Property.Satisfied else Property.Violated;
    end when;

    annotation (defaultComponentName="fixedRising1",
         Icon(coordinateSystem(preserveAspectRatio=false, extent={{-200,-100},
              {200,100}}), graphics={
          Rectangle(
            extent={{-160,60},{20,10}},
            lineColor={0,0,0},
            lineThickness=5.0,
            fillColor={245,245,245},
            fillPattern=FillPattern.Solid,
            borderPattern=BorderPattern.Sunken),
          Text(
            extent={{-160,45},{20,15}},
            lineColor={0,0,0},
            fillColor={255,0,0},
            fillPattern=FillPattern.Solid,
            textString="%nRising"),
          Line(
            points={{-168,18},{-168,18},{-168,64},{26,64},{26,22},{26,22}},
            color={255,0,0},
            smooth=Smooth.None),
          Line(
            points={{-192,18},{-168,18}},
            color={0,0,0},
            smooth=Smooth.None),
          Line(
            points={{26,22},{50,22}},
            color={0,0,0},
            smooth=Smooth.None),
          Text(
            extent={{-160,90},{20,65}},
            lineColor={95,95,95},
            textString="#edges ==")}), Documentation(info="<html>
<h4>Syntax</h4>

<blockquote><p>
property = <b>FixedRising</b>(condition=..., check=..., nRising=1).y;
</p></blockquote>

<h4>Description</h4>

<p>
In every duration where the Boolean input <b>condition</b> is true,
a number of <b>nRising</b> edges of the Boolean input <b>check</b> 
must occur. The default for nRising=1 (so exactly one rising edge).
Property output <b>y</b> is initialized to Undecided.
When condition becomes true (so entering a duration), property output y = Undecided,
as long as the number of rising edges &lt; nRising. If condition is true and
the number of rising edges == nRising, output y = Satisfied. If 
the number of rising edges &gt; nRising or the number of rising
edges &ne; nRising at the end of a true condition phase, 
y = Violated.
</p>

<p>
Violated, Undecided, and Satisfied are elements of enumeration
<a href=\"modelica://Modelica_Requirements.Types.Property\">Property</a>.
</p>

<h4>Example</h4>

<p>
This block is demonstrated with the following
<a href=\"modelica://Modelica_Requirements.Examples.Elementary.ChecksInFixedWindow.FixedRising\">example</a>: 
</p>

<p><blockquote>
<img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/Elementary/ChecksInFixedWindow/FixedRising1.png\">
</blockquote></p>

<p>
results in
</p>

<table border=0 cellspacing=0 cellpadding=2>
<tr><td width=\"50\"></td>
    <td valign=\"bottom\"><img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/Elementary/ChecksInFixedWindow/FixedRising2.png\"></td>
    </tr>

<tr><td></td>
    <td align=\"center\">simulation result</td>
   </tr>
</table>
</html>"));
  end FixedRising;

  block MinRising
    "In every true condition phase, a minimum number of check rising edges must occur"
    extends Modelica_Requirements.Interfaces.PartialCheck;
    import Modelica_Requirements.Types.Property;

    parameter Integer nRisingMin(min=0)=1
      "Minimum number of check rising edges";
  protected
    discrete Integer countRising;
  initial equation
    countRising = 0;
    y = if condition and nRisingMin == 0 then Property.Satisfied else Property.Undecided;
  equation
    when condition then
       countRising = 0;
       y = if countRising >= nRisingMin then Property.Satisfied else Property.Undecided;
    elsewhen condition and check then
       countRising = pre(countRising) + 1;
       y = if countRising >= nRisingMin then Property.Satisfied else Property.Undecided;
    elsewhen not condition then
       countRising = pre(countRising);
       y = if countRising >= nRisingMin then Property.Satisfied else Property.Violated;
    end when;

    annotation (defaultComponentName="minRising1",
         Icon(coordinateSystem(preserveAspectRatio=false, extent={{-200,-100},
              {200,100}}), graphics={
          Rectangle(
            extent={{-160,60},{20,10}},
            lineColor={0,0,0},
            lineThickness=5.0,
            fillColor={245,245,245},
            fillPattern=FillPattern.Solid,
            borderPattern=BorderPattern.Sunken),
          Text(
            extent={{-160,45},{20,15}},
            lineColor={0,0,0},
            fillColor={255,0,0},
            fillPattern=FillPattern.Solid,
            textString="%nRisingMin"),
          Line(
            points={{-168,18},{-168,18},{-168,64},{26,64},{26,22},{26,22}},
            color={255,0,0},
            smooth=Smooth.None),
          Line(
            points={{-192,18},{-168,18}},
            color={0,0,0},
            smooth=Smooth.None),
          Line(
            points={{26,22},{50,22}},
            color={0,0,0},
            smooth=Smooth.None),
          Text(
            extent={{-160,90},{20,65}},
            lineColor={95,95,95},
            textString="#edges >=")}), Documentation(info="<html>
<h4>Syntax</h4>

<blockquote><p>
property = <b>MinRising</b>(condition=..., check=..., nRisingMin=1).y;
</p></blockquote>

<h4>Description</h4>

<p>
In every duration where the Boolean input <b>condition</b> is true,
a minimum number of <b>nRisingMin</b> edges of the Boolean input <b>check</b> 
must occur. The default for nRisingMin=1 (so at least one rising edge).
Property output <b>y</b> is initialized to Undecided.
When condition becomes true (so entering a duration), property output y = Undecided,
as long as the number of rising edges &lt; nRisingMin. If condition is true and
the number of rising edges &ge; nRisingMin, output y = Satisfied. If at the end
of a true condition phase the number of rising edges in this phase &lt; nRisingMin,
y = Violated.
</p>

<p>
Violated, Undecided, and Satisfied are elements of enumeration
<a href=\"modelica://Modelica_Requirements.Types.Property\">Property</a>.
</p>

<h4>Example</h4>

<p>
This block is demonstrated with the following
<a href=\"modelica://Modelica_Requirements.Examples.Elementary.ChecksInFixedWindow.MinRising\">example</a>: 
</p>

<p><blockquote>
<img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/Elementary/ChecksInFixedWindow/MinRising1.png\">
</blockquote></p>

<p>
results in
</p>

<table border=0 cellspacing=0 cellpadding=2>
<tr><td width=\"50\"></td>
    <td valign=\"bottom\"><img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/Elementary/ChecksInFixedWindow/MinRising2.png\"></td>
    </tr>

<tr><td></td>
    <td align=\"center\">simulation result</td>
   </tr>
</table>
</html>"));
  end MinRising;

  block MaxRising
    "In every true condition phase, the number of check rising edges must be bounded"
    extends Modelica_Requirements.Interfaces.PartialCheck;
    import Modelica_Requirements.Types.Property;

    parameter Integer nRisingMax(min=0)=1
      "Maximum number of check rising edges";
  protected
    discrete Integer countRising;
  initial equation
    countRising = 0;
    y = if condition then Property.Satisfied else Property.Undecided;
  equation
    when condition then
       countRising = 0;
       y = Property.Satisfied;
    elsewhen condition and check then
       countRising = pre(countRising) + 1;
       y = if countRising <= nRisingMax then Property.Satisfied else Property.Violated;
    elsewhen not condition then
       countRising = 0;
       y = Property.Undecided;
    end when;

    annotation (defaultComponentName="maxRising1",
         Icon(coordinateSystem(preserveAspectRatio=false, extent={{-200,-100},
              {200,100}}), graphics={
          Rectangle(
            extent={{-160,60},{20,10}},
            lineColor={0,0,0},
            lineThickness=5.0,
            fillColor={245,245,245},
            fillPattern=FillPattern.Solid,
            borderPattern=BorderPattern.Sunken),
          Text(
            extent={{-160,45},{20,15}},
            lineColor={0,0,0},
            fillColor={255,0,0},
            fillPattern=FillPattern.Solid,
            textString="%nRisingMax"),
          Line(
            points={{-168,18},{-168,18},{-168,64},{26,64},{26,22},{26,22}},
            color={255,0,0},
            smooth=Smooth.None),
          Line(
            points={{-192,18},{-168,18}},
            color={0,0,0},
            smooth=Smooth.None),
          Line(
            points={{26,22},{50,22}},
            color={0,0,0},
            smooth=Smooth.None),
          Text(
            extent={{-160,90},{20,65}},
            lineColor={95,95,95},
            textString="#edges <=")}), Documentation(info="<html>
<h4>Syntax</h4>

<blockquote><p>
property = <b>MaxRising</b>(condition=..., check=..., nRisingMax=1).y;
</p></blockquote>

<h4>Description</h4>

<p>
In every duration where the Boolean input <b>condition</b> is true,
the number of rising edges of the Boolean input <b>check</b> is not allowed to exceed
parameter <b>nRisingMax</b>. The default for nRisingMax=1 (so at most one rising edge).
Property output <b>y</b> is initialized to Undecided if condition=false,
and is initialized to Satisfied if condition=true.
When condition becomes true (so entering a duration), property output y = Satisfied,
as long as the number of rising edges &le; nRisingMax. If condition is true and
the number of rising edges &gt; nRisingMax, output y = Violated.
If condition is false, output y = Undecided.
</p>

<p>
Violated, Undecided, and Satisfied are elements of enumeration
<a href=\"modelica://Modelica_Requirements.Types.Property\">Property</a>.
</p>

<h4>Example</h4>

<p>
This block is demonstrated with the following
<a href=\"modelica://Modelica_Requirements.Examples.Elementary.ChecksInFixedWindow.MaxRising\">example</a>: 
</p>

<p><blockquote>
<img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/Elementary/ChecksInFixedWindow/MaxRising1.png\">
</blockquote></p>

<p>
results in
</p>

<table border=0 cellspacing=0 cellpadding=2>
<tr><td width=\"50\"></td>
    <td valign=\"bottom\"><img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/Elementary/ChecksInFixedWindow/MaxRising2.png\"></td>
    </tr>

<tr><td></td>
    <td align=\"center\">simulation result</td>
   </tr>
</table>
</html>"));
  end MaxRising;

  block BandRising
    "In every true condition phase, a minimum number of check rising edges must occur and the number of check rising edges is bounded"
    extends Modelica_Requirements.Interfaces.PartialCheck;
    import Modelica_Requirements.Types.Property;

    parameter Integer nRisingMin(min=0)=1
      "Minimum number of check rising edges";
    parameter Integer nRisingMax(min=0)=2
      "Maximum number of check rising edges";
  protected
    discrete Integer countRising;
  initial equation
    countRising = 0;
    y = if condition and nRisingMin==0 and nRisingMax>=0 then Property.Satisfied else Property.Undecided;
  equation
    assert(nRisingMin <= nRisingMax, "nRisingMin > nRisingMax");
    when condition then
       countRising = 0;
       y = if countRising >= nRisingMin and countRising <= nRisingMax then Property.Satisfied else Property.Undecided;
    elsewhen condition and check then
       countRising = pre(countRising) + 1;
       y = if countRising >= nRisingMin and countRising <= nRisingMax then Property.Satisfied elseif countRising > nRisingMax then Property.Violated else Property.Undecided;
    elsewhen not condition then
       countRising = pre(countRising);
       y = if countRising >= nRisingMin and countRising <= nRisingMax then Property.Satisfied else Property.Violated;
    end when;

    annotation (defaultComponentName="minRising1",
         Icon(coordinateSystem(preserveAspectRatio=false, extent={{-200,-100},{
              200,100}}),  graphics={
          Rectangle(
            extent={{-160,60},{-75,10}},
            lineColor={0,0,0},
            lineThickness=5.0,
            fillColor={245,245,245},
            fillPattern=FillPattern.Solid,
            borderPattern=BorderPattern.Sunken),
          Text(
            extent={{-160,45},{-75,20}},
            lineColor={0,0,0},
            fillColor={255,0,0},
            fillPattern=FillPattern.Solid,
            textString="%nRisingMin"),
          Line(
            points={{-168,18},{-168,18},{-168,64},{26,64},{26,22},{26,22}},
            color={255,0,0},
            smooth=Smooth.None),
          Line(
            points={{-192,18},{-168,18}},
            color={0,0,0},
            smooth=Smooth.None),
          Line(
            points={{26,22},{50,22}},
            color={0,0,0},
            smooth=Smooth.None),
          Text(
            extent={{-162,90},{18,65}},
            lineColor={95,95,95},
            textString="<= #edges <="),
          Rectangle(
            extent={{-66,60},{19,10}},
            lineColor={0,0,0},
            lineThickness=5.0,
            fillColor={245,245,245},
            fillPattern=FillPattern.Solid,
            borderPattern=BorderPattern.Sunken),
          Text(
            extent={{-65,45},{20,20}},
            lineColor={0,0,0},
            fillColor={255,0,0},
            fillPattern=FillPattern.Solid,
            textString="%nRisingMax")}),
                                    Documentation(info="<html>
<h4>Syntax</h4>

<blockquote><p>
property = <b>BandRising</b>(condition=..., check=..., nRisingMin=1, nRisingMax=2).y;
</p></blockquote>

<h4>Description</h4>

<p>
In every duration where the Boolean input <b>condition</b> is true,
a minimum number of <b>nRisingMin</b> edges of the Boolean input <b>check</b> 
must occur and a maximum number of <b>nRisingMax</b> edges is allowed. The default for nRisingMin=1 (so at least one rising edge), whereas
the default for nRisingMax=2 (so at most two rising edges). If condition = true and
nRisingMin = 0, then Property output <b>y</b> is initialized to Satisfied, otherwise to Undecided.
</p>

<p>
Violated, Undecided, and Satisfied are elements of enumeration
<a href=\"modelica://Modelica_Requirements.Types.Property\">Property</a>.
</p>

<h4>Example</h4>

<p>
This block is demonstrated with the following
<a href=\"modelica://Modelica_Requirements.Examples.Elementary.ChecksInFixedWindow.BandRising\">example</a>: 
</p>

<p><blockquote>
<img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/Elementary/ChecksInFixedWindow/BandRising1.png\">
</blockquote></p>

<p>
results in
</p>

<table border=0 cellspacing=0 cellpadding=2>
<tr><td width=\"50\"></td>
    <td valign=\"bottom\"><img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/Elementary/ChecksInFixedWindow/BandRising2.png\"></td>
    </tr>

<tr><td></td>
    <td align=\"center\">simulation result</td>
   </tr>
</table>
</html>"),
      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-200,-100},{
              200,100}}), graphics));
  end BandRising;

  block MaxRisingFrequency
    "In every true condition phase, the frequency of the check rising edges is limited"
    extends Modelica_Requirements.Interfaces.PartialCheck;
    import Modelica_Requirements.Types.Property;

    parameter Modelica.SIunits.Frequency freqHzMax(min=0.0)
      "Maximum frequency of rising edges in true condition phase";
    Modelica.Blocks.Interfaces.RealOutput freqHz(final quantity="Frequency",final unit="Hz")
      "Check rising edge frequency in true condition phase, otherwise zero"
      annotation (Placement(transformation(extent={{200,-70},{220,-50}})));

  protected
    constant Real eps = 100*Modelica.Constants.eps
      "Small number to guard against division of zero";
    discrete Modelica.SIunits.Time timeOfLastRising
      "Time instance of last rising edge";
    discrete Modelica.SIunits.Time T
      "Duration between actual time and last rising";
    Boolean computeFrequency
      "= true, if frequency can be computed at the next rising";

  initial equation
    pre(check) = false;
    computeFrequency = false;
    timeOfLastRising = time;
    T = 0;
    freqHz = 0;
    y = if condition then Property.Satisfied else Property.Undecided;

  equation
    when condition then
       // Start of true condition phase
       computeFrequency = edge(check);
       timeOfLastRising = time;
       T = 0;
       freqHz = 0;
       y = Property.Satisfied;

    elsewhen condition and check then
       // Check rising edge in a true-condition phase
       computeFrequency = true;
       timeOfLastRising = time;
       T = time - pre(timeOfLastRising);
       freqHz = if pre(computeFrequency) and T >= eps then 1/T else 0.0;
       y = if freqHz <= freqHzMax then Property.Satisfied else Property.Violated;

    elsewhen not condition then
       // True condition phase is left
       computeFrequency = false;
       timeOfLastRising = time;
       T = 0;
       freqHz = 0;
       y = Property.Undecided;
    end when;

    annotation (defaultComponentName="maxFrequency1",
         Icon(coordinateSystem(preserveAspectRatio=false, extent={{-200,-100},
              {200,100}}), graphics={
          Rectangle(
            extent={{-160,60},{20,10}},
            lineColor={0,0,0},
            lineThickness=5.0,
            fillColor={245,245,245},
            fillPattern=FillPattern.Solid,
            borderPattern=BorderPattern.Sunken),
          Text(
            extent={{-160,45},{20,15}},
            lineColor={0,0,0},
            fillColor={255,0,0},
            fillPattern=FillPattern.Solid,
            textString="%freqHzMax Hz"),
          Line(
            points={{-168,18},{-168,18},{-168,64},{26,64},{26,22},{26,22}},
            color={255,0,0},
            smooth=Smooth.None),
          Line(
            points={{-192,18},{-168,18}},
            color={0,0,0},
            smooth=Smooth.None),
          Line(
            points={{26,22},{50,22}},
            color={0,0,0},
            smooth=Smooth.None),
          Line(
            points={{-166,70},{-132,70},{-132,88},{-86,88},{-86,70},{-42,70},{-42,88},{10,
                88}},
            color={0,0,0},
            smooth=Smooth.None),
          Line(
            points={{-132,94},{-132,70}},
            color={255,0,0},
            smooth=Smooth.None),
          Line(
            points={{-42,94},{-42,70}},
            color={255,0,0},
            smooth=Smooth.None)}), Documentation(info="<html>
<h4>Syntax</h4>

<blockquote><p>
property = <b>MaxRisingFrequency</b>(condition=..., check=..., freqHzMax=...).y;
</p></blockquote>

<h4>Description</h4>

<p>
In every duration where the Boolean input <b>condition</b> is true,
the frequency of the rising edges of Boolean input <b>check</b> 
is limited by <b>freqHzMax</b>. Therefore, in every true condition phase the
constraint shall hold:
</p>

<blockquote><pre>
1/T &le; freqHzMax
</pre></blockquote>

<p>
where T is the time duration between two rising edges of check.
The frequency 1/T is also provided as additional output
signal <b>freqHz</b>. Once the frequency cannot be computed
(outside of the true condition phase, or before the second
rising edge of check in a true condition phase), it is set to freqHz = 0.
If the frequency is not larger as freqHzMax, property output
<b>y</b> is set to Satisfied. If the limit is violated,
y = Violated. In all other cases, y = Undecided.
</p>

<p>
Violated, Undecided, and Satisfied are elements of enumeration
<a href=\"modelica://Modelica_Requirements.Types.Property\">Property</a>.
</p>

<h4>Example</h4>

<p>
This block is demonstrated with the following
<a href=\"modelica://Modelica_Requirements.Examples.Elementary.ChecksInFixedWindow.MaxRisingFrequency\">example</a>
where the check signal has first a frequency of 2 Hz, then of 4 Hz, and then again of 2 Hz and the maximum allowed frequency is 3 Hz: 
</p>

<p><blockquote>
<img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/Elementary/ChecksInFixedWindow/MaxRisingFrequency1.png\">
</blockquote></p>

<p>
results in
</p>

<table border=0 cellspacing=0 cellpadding=2>
<tr><td width=\"50\"></td>
    <td valign=\"bottom\"><img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/Elementary/ChecksInFixedWindow/MaxRisingFrequency2.png\"></td>
    </tr>

<tr><td></td>
    <td align=\"center\">simulation result</td>
   </tr>
</table>
</html>"));
  end MaxRisingFrequency;

  block WhenRising "When condition input has a rising edge, check must be true"
    extends Modelica_Requirements.Interfaces.PartialCheck;
    import Modelica_Requirements.LogicalFunctions.*;
    import Modelica_Requirements.Types.Property;

  initial equation
    y=if condition then BooleanToProperty(check) else Property.Undecided;
  equation
    when condition then
       y = BooleanToProperty(check);
    end when;
    annotation (defaultComponentName="whenRising1",
         Documentation(info="<html>
<h4>Syntax</h4>

<blockquote><p>
property = <b>WhenRising</b>(condition=..., check=...).y;
</p></blockquote>

<h4>Description</h4>

<p>
At the time instants where condition has a rising edge, property is set to 
\"<a href=\"Modelica_Requirements.LogicalFunctions.BooleanToProperty\">BooleanToProperty</a>(check)\" (so either Satisfied or Violated)
and keeps this value until the next rising edge. Before the first rising edge,
property = Undecided. If condition = true during initialization, property = toProperty(check)
at initialization. 
</p>

<p>
Violated, Undecided, and Satisfied are elements of enumeration
<a href=\"modelica://Modelica_Requirements.Types.Property\">Property</a>.
</p>

<h4>Example</h4>

<p>
The property is demonstrated with the following
<a href=\"modelica://Modelica_Requirements.Examples.Elementary.ChecksInFixedWindow.WhenRising\">example</a>: 
</p>

<p><blockquote>
<img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/Elementary/ChecksInFixedWindow/WhenRising1.png\">
</blockquote></p>

<p>
results in
</p>

<table border=0 cellspacing=0 cellpadding=2>
<tr><td width=\"50\"></td>
    <td valign=\"bottom\"><img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/Elementary/ChecksInFixedWindow/WhenRising2.png\"></td>
    </tr>

<tr><td></td>
    <td align=\"center\">simulation result</td>
   </tr>
</table>
</html>"),   Icon(coordinateSystem(preserveAspectRatio=false, extent={{-200,-100},
              {200,100}}), graphics={
          Line(
            points={{-188,22},{-154,22},{-154,48},{-108,48},{-108,22},{-64,22},{-64,
                48},{-12,48}},
            color={0,0,0},
            smooth=Smooth.None),
          Line(
            points={{-154,96},{-154,22}},
            color={255,0,0},
            smooth=Smooth.None),
          Polygon(
            points={{-168,74},{-154,50},{-138,74},{-154,68},{-168,74}},
            lineColor={255,0,0},
            smooth=Smooth.None,
            fillColor={255,0,0},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{-78,74},{-64,50},{-48,74},{-64,68},{-78,74}},
            lineColor={255,0,0},
            smooth=Smooth.None,
            fillColor={255,0,0},
            fillPattern=FillPattern.Solid),
          Line(
            points={{-64,96},{-64,22}},
            color={255,0,0},
            smooth=Smooth.None)}));
  end WhenRising;

  block WhenFalling
    "When condition input has a falling edge, check must be true"
    extends Modelica_Requirements.Interfaces.PartialCheck;
    import Modelica_Requirements.LogicalFunctions.*;
    import Modelica_Requirements.Types.Property;

  initial equation
    y=if not condition then BooleanToProperty(check) else Property.Undecided;
  equation
    when not condition then
       y = BooleanToProperty(check);
    end when;
    annotation (defaultComponentName="whenFalling1",
         Documentation(info="<html>
<h4>Syntax</h4>

<blockquote><p>
property = <b>WhenFalling</b>(condition=..., check=...).y;
</p></blockquote>

<h4>Description</h4>

<p>
At the time instants where condition has a falling edge, property is set to 
\"<a href=\"Modelica_Requirements.LogicalFunctions.BooleanToProperty\">BooleanToProperty</a>(check)\" (so either Satisfied or Violated)
and keeps this value until the next falling edge. Before the first falling edge,
property = Undecided. If condition = false during initialization, property = toProperty(check)
at initialization. 
</p>

<p>
Violated, Undecided, and Satisfied are elements of enumeration
<a href=\"modelica://Modelica_Requirements.Types.Property\">Property</a>.
</p>

<h4>Example</h4>

<p>
The property is demonstrated with the following
<a href=\"modelica://Modelica_Requirements.Examples.Elementary.ChecksInFixedWindow.WhenFalling\">example</a>: 
</p>

<p><blockquote>
<img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/Elementary/ChecksInFixedWindow/WhenFalling1.png\">
</blockquote></p>

<p>
results in
</p>

<table border=0 cellspacing=0 cellpadding=2>
<tr><td width=\"50\"></td>
    <td valign=\"bottom\"><img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/Elementary/ChecksInFixedWindow/WhenFalling2.png\"></td>
    </tr>

<tr><td></td>
    <td align=\"center\">simulation result</td></tr>
</table>
</html>
</html>"),   Icon(coordinateSystem(preserveAspectRatio=false, extent={{-200,-100},
              {200,100}}), graphics={
          Line(
            points={{-188,22},{-154,22},{-154,48},{-108,48},{-108,22},{-64,22},{-64,
                48},{-12,48}},
            color={0,0,0},
            smooth=Smooth.None),
          Line(
            points={{-108,96},{-108,22}},
            color={255,0,0},
            smooth=Smooth.None),
          Polygon(
            points={{-122,72},{-108,48},{-92,72},{-108,66},{-122,72}},
            lineColor={255,0,0},
            smooth=Smooth.None,
            fillColor={255,0,0},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{-26,72},{-12,48},{4,72},{-12,66},{-26,72}},
            lineColor={255,0,0},
            smooth=Smooth.None,
            fillColor={255,0,0},
            fillPattern=FillPattern.Solid),
          Line(
            points={{-12,96},{-12,22}},
            color={255,0,0},
            smooth=Smooth.None)}));
  end WhenFalling;

  block WhenChanging
    "When condition input has a changing edge, check must be true"
    extends Modelica_Requirements.Interfaces.PartialCheck;
    import Modelica_Requirements.LogicalFunctions.*;
    import Modelica_Requirements.Types.Property;

  initial equation
    y = Property.Undecided;
  equation
    when {condition, not condition} then
       y = BooleanToProperty(check);
    end when;
    annotation (defaultComponentName="whenChanging1",
         Documentation(info="<html>
<h4>Syntax</h4>

<blockquote><p>
property = <b>WhenChanging</b>(condition=..., check=...).y;
</p></blockquote>

<h4>Description</h4>

<p>
At the time instants where condition has a changing edge, property is set to 
\"<a href=\"Modelica_Requirements.LogicalFunctions.BooleanToProperty\">BooleanToProperty</a>(check)\" (so either Satisfied or Violated)
and keeps this value until the next changing edge. At initialization, property = Undecided, independently of the value of condition. 
</p>

<p>
Violated, Undecided, and Satisfied are elements of enumeration
<a href=\"modelica://Modelica_Requirements.Types.Property\">Property</a>.
</p>

<h4>Example</h4>

<p>
The property is demonstrated with the following
<a href=\"modelica://Modelica_Requirements.Examples.Elementary.ChecksInFixedWindow.WhenChanging\">example</a>: 
</p>

<p><blockquote>
<img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/Elementary/ChecksInFixedWindow/WhenChanging1.png\">
</blockquote></p>

<p>
results in
</p>

<table border=0 cellspacing=0 cellpadding=2>
<tr><td width=\"50\"></td>
    <td valign=\"bottom\"><img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/Elementary/ChecksInFixedWindow/WhenChanging2.png\"></td>
    </tr>

<tr><td></td>
    <td align=\"center\">simulation result</td>
   </tr>
</table>
</html>"),   Icon(coordinateSystem(preserveAspectRatio=false, extent={{-200,-100},
              {200,100}}), graphics={
          Line(
            points={{-188,22},{-154,22},{-154,48},{-108,48},{-108,22},{-64,22},{-64,
                48},{-12,48}},
            color={0,0,0},
            smooth=Smooth.None),
          Line(
            points={{-154,96},{-154,22}},
            color={255,0,0},
            smooth=Smooth.None),
          Polygon(
            points={{-168,74},{-154,50},{-138,74},{-154,68},{-168,74}},
            lineColor={255,0,0},
            smooth=Smooth.None,
            fillColor={255,0,0},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{-122,72},{-108,48},{-92,72},{-108,66},{-122,72}},
            lineColor={255,0,0},
            smooth=Smooth.None,
            fillColor={255,0,0},
            fillPattern=FillPattern.Solid),
          Line(
            points={{-108,96},{-108,22}},
            color={255,0,0},
            smooth=Smooth.None),
          Line(
            points={{-64,96},{-64,22}},
            color={255,0,0},
            smooth=Smooth.None),
          Line(
            points={{-12,96},{-12,22}},
            color={255,0,0},
            smooth=Smooth.None),
          Polygon(
            points={{-78,72},{-64,48},{-48,72},{-64,66},{-78,72}},
            lineColor={255,0,0},
            smooth=Smooth.None,
            fillColor={255,0,0},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{-26,72},{-12,48},{4,72},{-12,66},{-26,72}},
            lineColor={255,0,0},
            smooth=Smooth.None,
            fillColor={255,0,0},
            fillPattern=FillPattern.Solid)}));
  end WhenChanging;

  model WithinDomain
    "In every true condition phase, point input must be within the domain defined by a polygon"
    import Modelica_Requirements.Types.Property;

    Modelica.Blocks.Interfaces.BooleanInput condition
      "Boolean input condition signal"
      annotation (Placement(transformation(extent={{-240,-19},{-200,21}})));

    Modelica.Blocks.Interfaces.RealInput point[2] "Point to test" annotation (Placement(
          transformation(extent={{-240,-120},{-200,-80}}),  iconTransformation(
            extent={{-240,-120},{-200,-80}})));

    Modelica_Requirements.Interfaces.PropertyOutput y
      "Property output signal (Satisfied, if point is within polygon)"
      annotation (Placement(transformation(extent={{200,-10},{220,10}}),
          iconTransformation(extent={{200,-10},{220,10}})));

    Modelica.Blocks.Interfaces.RealOutput distance
      "Minimum distance of point to polygon (>= 0 if inside or on polygon, otherwise outside of polygon)"
       annotation (Placement(
          transformation(extent={{200,-110},{220,-90}}),  iconTransformation(
            extent={{200,-110},{220,-90}})));
    output Real polygonPoint[2] "Point on polygon that is closest to point";

    parameter Real polygon[:,2]
      "Polygon defining the boundary of the domain (polygon[i,2] is point i of polygon)";

  protected
    type Color = Integer[3](min=0, max=255);
    parameter Color inSide = {0, 127, 0} "Color when inside polygon (= green)";
    parameter Color outSide = {255, 0, 0} "Color when outside polygon (= red)";
    parameter Real icon_max = 195 "Length of x and y axis of icon";
    parameter Real x_min = -icon_max*0.8 "Minimum x-value of scaled polygon";
    parameter Real x_max = +icon_max*0.8 "Maximum x-value of scaled polygon";
    parameter Real y_min = -icon_max*0.8 "Minimum y-value of scaled polygon";
    parameter Real y_max = +icon_max*0.8 "Maximum y-value of scaled polygon";
    parameter Real poly_x_min = min(polygon[:,1]);
    parameter Real poly_x_max = max(polygon[:,1]);
    parameter Real poly_y_min = min(polygon[:,2]);
    parameter Real poly_y_max = max(polygon[:,2]);
    parameter Real x_scale = (x_max - x_min) / (poly_x_max - poly_x_min);
    parameter Real y_scale = (y_max - y_min) / (poly_y_max - poly_y_min);
    parameter Real scaledPoly[size(polygon,1),2]=
                      [x_min .+ x_scale*(polygon[:, 1].-poly_x_min),
                       y_min .+ y_scale*(polygon[:, 2].-poly_y_min)]
      "Scaled polygon" annotation(HideResult=false);

    Real px_temp = x_min + x_scale*(point[1]-poly_x_min);
    Real py_temp = y_min + y_scale*(point[2]-poly_y_min);
    Real px = max(min(px_temp, icon_max), -icon_max);
    Real py = max(min(py_temp, icon_max), -icon_max);
    Real poly_px;
    Real poly_py;
    Real line1[2,2] annotation(HideResult=false);
    Real circle1[2,2] annotation(HideResult=false);
    Real circle2[2,2] annotation(HideResult=false);
    Color varColor annotation(HideResult=false);
    Color fillColor annotation(HideResult=false);
  equation
    (distance, polygonPoint) = Modelica_Requirements.Utilities.distancePointToPolygon(polygon, point);
    y = if condition then
           (if distance >= 0 then Property.Satisfied else Property.Violated) else
           Property.Undecided;

    poly_px = x_min + x_scale*(polygonPoint[1]-poly_x_min);
    poly_py = y_min + y_scale*(polygonPoint[2]-poly_y_min);
    line1 = {{px,py},{poly_px, poly_py}};
    circle1 = {{px-10, py-10}, {px+10, py+10}};
    circle2 = {{poly_px-10, poly_py-10}, {poly_px+10, poly_py+10}};
    varColor = if distance >= 0 then inSide else outSide;
    fillColor = if distance >= 0 then {245,245,245} else {255,218,213};

    annotation (defaultComponentName="withinDomain1",Icon(coordinateSystem(preserveAspectRatio=false,extent={{-200,-200},
              {200,200}}), graphics={
          Rectangle(
            extent={{-200,200},{200,-200}},
            lineColor={0,0,0},
            lineThickness=5.0,
            fillColor={210,210,210},
            fillPattern=FillPattern.Solid,
            borderPattern=BorderPattern.Raised),
          Rectangle(
            extent={{-190,190},{190,-190}},
            lineColor={0,0,0},
            lineThickness=5.0,
            fillColor={245,245,245},
            fillPattern=FillPattern.Solid,
            borderPattern=BorderPattern.Sunken),
          Polygon(
            points=DynamicSelect({{-140,116},{-2,158},{158,98},{116,-88},{-14,-158},{-140,-142},{-140,116}},scaledPoly),
            lineColor={0,0,0},
            fillColor=DynamicSelect({245,245,245},fillColor),
            fillPattern=FillPattern.Solid),
          Line(points=DynamicSelect({{0,0},{-140,0}}, line1),
               lineColor=DynamicSelect({0,127,0},varColor)),
          Ellipse(
            extent=DynamicSelect({{-10,10},{10,-10}}, circle1),
            fillPattern=FillPattern.Solid,
            lineColor=DynamicSelect({0,127,0}, varColor),
            fillColor=DynamicSelect({0,127,0}, varColor)),
          Ellipse(
            extent=DynamicSelect({{-150,10},{-130,-10}}, circle2),
            lineColor={135,135,135},
            fillPattern=FillPattern.Solid,
            fillColor={135,135,135}),
          Text(
            extent={{-250,210},{250,250}},
            lineColor={175,175,175},
            textString="%name")}), Diagram(coordinateSystem(preserveAspectRatio=false,
            extent={{-200,-200},{200,200}}), graphics),
      Documentation(info="<html>
<h4>Syntax</h4>

<blockquote><p>
property = <b>WithinDomain</b>(condition=..., point=..., polygon=...).y;
</p></blockquote>

<h4>Description</h4>

<p>
In every duration where the Boolean input <b>condition</b> is true,
the <b>point</b> must be within the domain defined by the <b>polygon</b>.
The polygon is defined by a set of points <b>polygon</b>[:,2],
where polygon[i,1] is the x-coordinate of
polygon point i and polygon[i,2] is the y-coordinate. The last point of the polygon
can be identical to the first point, so polygon[1,:] = polygon[end,:].
If this is not the case, the block assumes that the last point
polygon[end,:] is connected implicitely to the first point polygon[1,:].
The area inside the polygon is the desired domain.
</p>

<p>
When condition is true, output y = Satisfied if the point is on or 
within the polygon, and y = Violated if the point is outside of the 
polygon. When condition is false, y = Undecided.
</p>

<p>
The block provides additionally output <b>distance</b>
which is the minimum distance between the point and the polygon. <br>
If distance &gt; 0, then point is inside of the polygon.<br>
If distance &lt; 0, then point is outside of the polygon.<br>
If distance = 0, then point is on the polygon.
</p>

<p>
Violated, Undecided, and Satisfied are elements of enumeration
<a href=\"modelica://Modelica_Requirements.Types.Property\">Property</a>.
</p>

<h4>Example</h4>

<p>
This block is demonstrated with the following
<a href=\"modelica://Modelica_Requirements.Examples.Elementary.ChecksInFixedWindow.WithinDomain\">example</a>: 
</p>
<p><blockquote>
<img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/Elementary/ChecksInFixedWindow/WithinDomain1a.png\">
</blockquote></p>

<p>
The polygon and the point are dynamically displayed in the icon of the block.
If the point is within the polygon,
the point is displayed in green and the polygon area in grey (the grey point on the polygon
marks the polygon point that is closest to the point).
If the point is outside of the polygon, it is displayed in red and the polygon area
in light red:
</p>

<p><blockquote>
<img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/Elementary/ChecksInFixedWindow/WithinDomain1b.png\">
</blockquote></p>

<p>
Simulating this examples results in
</p>

<table border=0 cellspacing=0 cellpadding=2>
<tr><td width=\"50\"></td>
    <td valign=\"bottom\"><img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/Elementary/ChecksInFixedWindow/WithinDomain2.png\"></td>
    </tr>

<tr><td></td>
    <td align=\"center\">simulation result</td>
   </tr>
</table>
<p>
Note, that the point is outside of the domain defined by the polygon if distance &lt; 0.
</p>
</html>"));
  end WithinDomain;
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics={
        Line(
          points={{-88,-40},{-60,-40},{-60,40},{60,40},{60,-40},{90,-40}},
          color={0,0,0},
          smooth=Smooth.None),
        Rectangle(
          extent={{-40,0},{40,-40}},
          lineColor={175,175,175},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-40,-40},{-60,-40},{-60,-40}},
          color={175,175,175},
          smooth=Smooth.None),
        Line(
          points={{60,-40},{40,-40},{40,-40}},
          color={175,175,175},
          smooth=Smooth.None)}), Documentation(info="<html>
<p>
This library provides blocks that check properties in <b>fixed windows</b>
defined by the true value of Boolean input variable <b>condition</b>.
Whenever this variable is true, the check is performed.
Blocks performing checks in a sliding time window are provided in sublibrary
<a href=\"modelica://Modelica_Requirements.ChecksInSlidingWindow\">ChecksInSlidingWindow</a>.
</p>

<p>
All blocks of this library have the following interface:
</p>

<ul>
<li> Boolean input <b>condition</b>. If true, the check is performed.
     Typically, condition is the output of a time locator from library
     <a href=\"modelica://Modelica_Requirements.TimeLocators\">TimeLocators</a>.</li>

<li> Boolean input <b>check</b> is a Boolean expression that must be true
     according to the property check of the particular block. </li>

<li> Property output <b>y</b> is of enumeration type 
     <a href=\"modelica://Modelica_Requirements.Types.Property\">Property</a>.
     If the check is successful, y = Property.Satisfied. If the check fails,
     y = Property.Violated. If neither of the two properties hold
     (for example when condition = false), y = Property.Undecided.</li>
</ul>
</html>"));
end ChecksInFixedWindow;
