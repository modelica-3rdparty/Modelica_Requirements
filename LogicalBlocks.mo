within Modelica_Requirements;
package LogicalBlocks
  "Library of logical blocks (2-/3-valued logical operators with and without memory)"
  extends Modelica.Icons.Package;

  block BooleanToProperty
    "Convert Boolean (false,true) to Property (Violated, Satisfied)"
    import Modelica_Requirements.Types.Property;
    extends Interfaces.PartialConversion;
    Modelica.Blocks.Interfaces.BooleanInput u "Boolean input signal"
      annotation (Placement(transformation(extent={{-90,-20},{-50,20}})));
    Modelica_Requirements.Interfaces.PropertyOutput y "Property output signal"
      annotation (Placement(transformation(extent={{50,-10},{70,10}})));
  equation
    y = if u then Property.Satisfied else Property.Violated;

    annotation (defaultComponentName="BtoP1",Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
              {100,100}},
          grid={1,1}),     graphics={Text(
            extent={{-48,48},{0,-0}},
            lineColor={0,0,0},
            fillColor={210,210,210},
            fillPattern=FillPattern.Solid,
            textString="B",
            fontSize=10),    Text(
            extent={{0,0},{48,-48}},
            lineColor={0,0,0},
            fillColor={210,210,210},
            fillPattern=FillPattern.Solid,
            textString="P",
            fontSize=10)}),    Diagram(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics),
      Documentation(info="<html>
<p>
The Boolean input u is converted to a Property output y according to the following table:
</p>

<blockquote>
<p>
<table border=1 cellspacing=0 cellpadding=2>
<tr><th>Boolean u = </th>
    <th>Property y =</th></tr>

<tr><td align=\"center\">true</td>
    <td align=\"center\">Satisfied</td> </tr>

<tr><td align=\"center\">false</td>
    <td align=\"center\">Violated</td> </tr>
</table>
</p></blockquote>

<p>
This block is demonstrated with example
<a href=\"modelica://Modelica_Requirements.Examples.Elementary.LogicalBlocks.Conversions\">Conversions</a>.
</p>
</html>"));
  end BooleanToProperty;

  block IntegerToProperty
    "Convert Integer (1,2,3) to Property (Violated, Undecided, Satisfied)"
    import Modelica_Requirements.Types.Property;
    extends Interfaces.PartialConversion;
    Modelica.Blocks.Interfaces.IntegerInput u
      "Integer input signal (with only values 1,2,3)"
      annotation (Placement(transformation(extent={{-90,-20},{-50,20}})));
    Modelica_Requirements.Interfaces.PropertyOutput y "Property output signal"
      annotation (Placement(transformation(extent={{50,-10},{70,10}})));
  equation
    assert(u>=1 and u<=3, "Integer input u (=" + String(u) + ") cannot be converted to Property output (u = 1, 2 or 3 required)");
    y = if u == 3 then Property.Satisfied else
        (if u == 2 then Property.Undecided else Property.Violated);
    annotation (defaultComponentName="ItoP1",Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
              {100,100}},
          grid={1,1}),     graphics={Text(
            extent={{-48,48},{0,-0}},
            lineColor={0,0,0},
            fillColor={210,210,210},
            fillPattern=FillPattern.Solid,
            fontSize=10,
            textString="I"), Text(
            extent={{0,0},{48,-48}},
            lineColor={0,0,0},
            fillColor={210,210,210},
            fillPattern=FillPattern.Solid,
            fontSize=10,
            textString="P")}), Diagram(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}},
          grid={1,1})),
      Documentation(info="<html>
<p>
The Integer input u is converted to a Property output y according to the following table:
</p>

<blockquote>
<p>
<table border=1 cellspacing=0 cellpadding=2>
<tr><th>Integer u = </th>
    <th>Property y =</th></tr>

<tr><td align=\"center\">1</td>
    <td align=\"center\">Violated</td> </tr>

<tr><td align=\"center\">2</td>
    <td align=\"center\">Undecided</td> </tr>

<tr><td align=\"center\">3</td>
    <td align=\"center\">Satisfied</td> </tr>
</table>
</table>
</p></blockquote>

<p>
An assert is triggered if the input is not 1, 2 or 3.
</p>

<p>
This block is demonstrated with example
<a href=\"modelica://Modelica_Requirements.Examples.Elementary.LogicalBlocks.Conversions\">Conversions</a>.
</p>
</html>"));
  end IntegerToProperty;

  block PropertyToBoolean
    "Convert  Property (Violated, Undecided, Satisfied) to Boolean (false, true)"
    import Modelica_Requirements.Types.Property;
    parameter Boolean undecided=false "Boolean value of Property.Undecided"
                                            annotation(choices(checkBox=true));
    Modelica_Requirements.Interfaces.PropertyInput u "Property input signal"
      annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
      Modelica.Blocks.Interfaces.BooleanOutput y "Boolean output signal"
      annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  equation
    y = if u == Property.Satisfied then true else
       (if u == Property.Undecided then undecided else false);

    annotation (defaultComponentName="PtoB1",Diagram(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics), Icon(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics={
         Rectangle(
            extent={{-100,50},{100,-50}},
            lineColor={0,0,0},
            lineThickness=5.0,
            fillColor={210,210,210},
            fillPattern=FillPattern.Solid,
            borderPattern=BorderPattern.Raised),
          Rectangle(
            extent={{-90,10},{90,-40}},
            lineColor={0,0,0},
            lineThickness=5.0,
            fillColor={245,245,245},
            fillPattern=FillPattern.Solid,
            borderPattern=BorderPattern.Sunken),
          Text(
            extent={{-90,40},{90,15}},
            lineColor={95,95,95},
            fillColor={210,210,210},
            fillPattern=FillPattern.Solid,
            textString="undecided"),
          Text(
            extent={{-90,0},{90,-30}},
            lineColor={0,0,0},
            fillColor={210,210,210},
            fillPattern=FillPattern.Solid,
            textString="%undecided"),            Text(
            extent={{-150,60},{150,100}},
            lineColor={175,175,175},
            textString="%name")}),
      Documentation(info="<html>
<p>
The Property input u is converted to a Boolean output y according to the following table
(note, <b>undecided</b> is a parameter that defines, how a Property.Undecided value
shall be mapped to a Boolean):
</p>

<blockquote>
<p>
<table border=1 cellspacing=0 cellpadding=2>
<tr><th>Property u = </th>
    <th>Boolean y =</th></tr>

<tr><td align=\"center\">Violated</td>
    <td align=\"center\">false</td> </tr>

<tr><td align=\"center\">Undecided</td>
    <td align=\"center\">undecided</td> </tr>

<tr><td align=\"center\">Satisfied</td>
    <td align=\"center\">true</td> </tr>
</table>
</p></blockquote>

<p>
This block is demonstrated with example
<a href=\"modelica://Modelica_Requirements.Examples.Elementary.LogicalBlocks.Conversions\">Conversions</a>.
</p>
</html>"));
  end PropertyToBoolean;

  block PropertyToInteger
    "Convert Property (Violated, Undecided, Satisfied) to Integer (1,2,3)"
    import Modelica_Requirements.Types.Property;
    extends Interfaces.PartialConversion;
    Modelica_Requirements.Interfaces.PropertyInput u "Property input signal"
      annotation (Placement(transformation(extent={{-90,-20},{-50,20}})));
      Modelica.Blocks.Interfaces.IntegerOutput y
      "Integer output signal (values 1,2,3)"
      annotation (Placement(transformation(extent={{50,-10},{70,10}})));
  equation
    y = Integer(u);
    annotation (defaultComponentName="PtoI1",Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
              {100,100}},
          grid={1,1}),     graphics={Text(
            extent={{-48,48},{0,-0}},
            lineColor={0,0,0},
            fillColor={210,210,210},
            fillPattern=FillPattern.Solid,
            fontSize=10,
            textString="P"), Text(
            extent={{0,0},{48,-48}},
            lineColor={0,0,0},
            fillColor={210,210,210},
            fillPattern=FillPattern.Solid,
            fontSize=10,
            textString="I")}), Diagram(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}},
          grid={1,1})),
      Documentation(info="<html>
<p>
The Property input u is converted to an Integer output y according to the following table:
</p>

<blockquote>
<p>
<table border=1 cellspacing=0 cellpadding=2>
<tr><th>Property u = </th>
    <th>Integer y =</th></tr>

<tr><td align=\"center\">Violated</td>
    <td align=\"center\">1</td> </tr>

<tr><td align=\"center\">Undecided</td>
    <td align=\"center\">2</td> </tr>

<tr><td align=\"center\">Satisfied</td>
    <td align=\"center\">3</td> </tr>
</table>
</table>
</p></blockquote>

<p>
This block is demonstrated with example
<a href=\"modelica://Modelica_Requirements.Examples.Elementary.LogicalBlocks.Conversions\">Conversions</a>.
</p>
</html>"));
  end PropertyToInteger;

  block GreaterThreshold
    "Output y is true if input u is greater than threshold"
     extends Modelica_Requirements.Interfaces.partialThresholdComparison;
  equation
    y = u > threshold;

    annotation (defaultComponentName="gt1",Icon(graphics={Line(
            points={{-180,14},{-158,0},{-180,-14}},
            color={0,0,0},
            thickness=0.5)}), Documentation(info="<html>
<p>
The output is <b>true</b> if the Real input is greater than
parameter <b>threshold</b>, otherwise
the output is <b>false</b>.
</p>

<p>
This block is demonstrated with example
<a href=\"modelica://Modelica_Requirements.Examples.Elementary.LogicalBlocks.ThresholdComparisons\">ThresholdComparisons</a>.
</p>
</html>"));
  end GreaterThreshold;

  block GreaterEqualThreshold
    "Output y is true if input u is greater or equal than threshold"
     extends Modelica_Requirements.Interfaces.partialThresholdComparison;
  equation
    y = u >= threshold;
    annotation (defaultComponentName="ge1",Icon(graphics={Line(
            points={{-179,13},{-159,0},{-179,-13}},
            color={0,0,0},
            smooth=Smooth.None,
            thickness=0.5),      Line(
            points={{-179,-23},{-159,-10}},
            color={0,0,0},
            smooth=Smooth.None,
            thickness=0.5)}),      Documentation(info="<html>
<p>
The output is <b>true</b> if the Real input is greater or equal than
parameter <b>threshold</b>, otherwise
the output is <b>false</b>.
</p>

<p>
This block is demonstrated with example
<a href=\"modelica://Modelica_Requirements.Examples.Elementary.LogicalBlocks.ThresholdComparisons\">ThresholdComparisons</a>.
</p>
</html>"),
      Diagram(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}},
          grid={1,1})));
  end GreaterEqualThreshold;

  block LessThreshold "Output y is true if input u is less than threshold"
     extends Modelica_Requirements.Interfaces.partialThresholdComparison;
  equation
    y = u < threshold;
    annotation (defaultComponentName="lt1",Icon(graphics={Line(
            points={{-158,14},{-182,0},{-158,-14}},
            color={0,0,0},
            smooth=Smooth.None,
            thickness=0.5)}),      Documentation(info="<html>
<p>
The output is <b>true</b> if the Real input is less than
parameter <b>threshold</b>, otherwise
the output is <b>false</b>.
</p>

<p>
This block is demonstrated with example
<a href=\"modelica://Modelica_Requirements.Examples.Elementary.LogicalBlocks.ThresholdComparisons\">ThresholdComparisons</a>.
</p>
</html>"));
  end LessThreshold;

  block LessEqualThreshold
    "Output y is true if input u is less or equal than threshold"
     extends Modelica_Requirements.Interfaces.partialThresholdComparison;
  equation
    y = u <= threshold;
    annotation (defaultComponentName="le1",Icon(graphics={Line(
            points={{-158,13},{-178,0},{-158,-13}},
            color={0,0,0},
            smooth=Smooth.None,
            thickness=0.5),      Line(
            points={{-178,-10},{-158,-23}},
            color={0,0,0},
            smooth=Smooth.None,
            thickness=0.5)}),      Documentation(info="<html>
<p>
The output is <b>true</b> if the Real input is less or equal than
parameter <b>threshold</b>, otherwise
the output is <b>false</b>.
</p>

<p>
This block is demonstrated with example
<a href=\"modelica://Modelica_Requirements.Examples.Elementary.LogicalBlocks.ThresholdComparisons\">ThresholdComparisons</a>.
</p>
</html>"));
  end LessEqualThreshold;

  block WithinBand
    "Output y is true if input u is within a lower and upper threshold"
    parameter Real u_max = 1 "Upper threshold";
    parameter Real u_min = -u_max "Lower threshold";

    Modelica.Blocks.Interfaces.RealInput u "Connector of Boolean input signal"
      annotation (Placement(transformation(extent={{-240,-20},{-200,20}},
            rotation=0), iconTransformation(extent={{-240,-20},{-200,20}})));
    Modelica.Blocks.Interfaces.BooleanOutput y
      "Connector of Boolean output signal" annotation (Placement(transformation(
            extent={{200,-10},{220,10}}, rotation=0), iconTransformation(extent={{
              200,-10},{220,10}})));

  equation
    assert(u_min <= u_max, "u_min <= u_max required");
    y = u >= u_min and u <= u_max;

    annotation (defaultComponentName="band1",Icon(coordinateSystem(preserveAspectRatio=false,extent={{-200,
              -100},{200,100}}),
                           graphics={
          Rectangle(
            extent={{-200,102},{200,-100}},
            lineColor={0,0,0},
            lineThickness=5.0,
            fillColor={210,210,210},
            fillPattern=FillPattern.Solid,
            borderPattern=BorderPattern.Raised),
                                     Line(
            points={{-178,-31},{-158,-44},{-178,-57}},
            color={0,0,0},
            smooth=Smooth.None,
            thickness=0.5),
          Line(
            points={{-178,-67},{-158,-54}},
            color={0,0,0},
            smooth=Smooth.None,
            thickness=0.5),          Line(
            points={{-160,65},{-180,52},{-160,39}},
            color={0,0,0},
            smooth=Smooth.None,
            thickness=0.5),
          Line(
            points={{-180,42},{-160,29}},
            color={0,0,0},
            smooth=Smooth.None,
            thickness=0.5),
          Rectangle(
            extent={{-140,90},{190,5}},
            lineColor={0,0,0},
            lineThickness=5.0,
            fillColor={245,245,245},
            fillPattern=FillPattern.Solid,
            borderPattern=BorderPattern.Sunken),
          Rectangle(
            extent={{-140,-5},{190,-90}},
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
            extent={{-140,90},{190,5}},
            lineColor={0,0,0},
            fontSize=8,
            textString="%u_max"),
          Text(
            extent={{-140,-90},{190,-5}},
            lineColor={0,0,0},
            fontSize=8,
            textString="%u_min")}),           Documentation(info="<html>
<p>
The output y is <b>true</b> if the Real input u is greater or equal u_min
and less or equal u_max. Otherwise the output is <b>false</b>:
</p>
<pre>
   y = u &ge; u_min <b>and</b> u &le; u_max
</pre>

<p>
This block is demonstrated with example
<a href=\"modelica://Modelica_Requirements.Examples.Elementary.LogicalBlocks.ThresholdComparisons\">ThresholdComparisons</a>.
</p>
</html>"));
  end WithinBand;

  block DelayedRising
    "Output y is true after a duration of a rising input edge and false after a falling input edge"
    input Boolean u "Boolean input" annotation(Dialog);
    parameter Modelica.SIunits.Time duration(start=1)
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
    y = false;
  equation
    when u then
      // u has a rising edge, duration starts
      startDuration = true;
      startTime = time;
      y = false;
    elsewhen pre(startDuration) and time >= pre(startTime) + duration then
      // end of duration reached
      startDuration = false;
      startTime = time;
      y = true;
    elsewhen not u then
      startDuration = false;
      startTime = time;
      y = false;
    end when;

    annotation (defaultComponentName="delayedRising1",
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
            extent={{-190,90},{190,65}},
            lineColor={95,95,95},
            horizontalAlignment=TextAlignment.Left,
            textString="delay rising"),
          Text(
            extent={{-190,-5},{20,-30}},
            lineColor={95,95,95},
            horizontalAlignment=TextAlignment.Left,
            textString="by"),
          Text(
            extent={{-190,-45},{190,-75}},
            lineColor={0,0,0},
            textString="%duration s")}),
      Documentation(info="<html>
<h4>Syntax</h4>

<blockquote><p>
condition = <b>DelayedRising</b>(u=..., duration=...).y;
</p></blockquote>

<h4>Description</h4>

<p>
Output <b>y</b> = true, after a rising edge of the input <b>u</b> and after u remains true for at least the defined <b>duration</b> .
After a falling edge of u, y = false immediately.
</p>

<h4>Example</h4>

<p>
This block is demonstrated with the following
<a href=\"modelica://Modelica_Requirements.Examples.Elementary.LogicalBlocks.DelayedRising\">example</a>: 
</p>

<p><blockquote>
<img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/Elementary/LogicalBlocks/DelayedRising1.png\">
</blockquote></p>

<p>
results in
</p>

<table border=0 cellspacing=0 cellpadding=2>
<tr><td width=\"50\"></td>
    <td valign=\"bottom\"><img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/Elementary/LogicalBlocks/DelayedRising2.png\"></td>
    </tr>

<tr><td></td>
    <td align=\"center\">simulation result</td>
   </tr>
</table>
</html>"));
  end DelayedRising;

  block AnyTrue
    "Output y is true if at least on input is true (\"or\" of all inputs)"
    extends Modelica_Requirements.Interfaces.PartialBooleanVISO;

  equation
    y = Modelica_Requirements.LogicalFunctions.exists(u);

    annotation (defaultComponentName="anyTrue1", Icon(graphics={Text(
            extent={{-40,15},{40,-15}},
            lineColor={0,0,0},
            textString="or")}),
      Documentation(info="<html>
<p>
Output y is <b>true</b> if at least one input is <b>true</b>, otherwise
output y is <b>false</b>.
</p>

<p>
The input connector is a vector of Boolean input signals.
When a connection line is drawn, the dimension of the input
vector is enlarged by one and the connection is automatically
connected to this new free index (thanks to the
connectorSizing annotation).
</p>

<p>
If no connection to the input connector \"u\" is present,
the output is set to: y=false.
</p>

<h4>Example</h4>

<p>
This block is demonstrated with the following
<a href=\"modelica://Modelica_Requirements.Examples.Elementary.LogicalBlocks\">example</a>: 
</p>

<p><blockquote>
<img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/Elementary/LogicalBlocks/AllTrue1.png\">
</blockquote></p>

<p>
results in
</p>

<table border=0 cellspacing=0 cellpadding=2>
<tr><td width=\"50\"></td>
    <td valign=\"bottom\"><img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/Elementary/LogicalBlocks/AllTrue2.png\"></td>
    </tr>

<tr><td></td>
    <td align=\"center\">simulation result</td>
   </tr>
</table>

<p>
This block is similar to block <a href=\"modelica://Modelica.Blocks.MathBoolean.Or\">Or</a>, but has a slightly different icon and the internal function call is inlined (so it is a bit more efficient).
</p>
</html>"));
  end AnyTrue;

  block AllTrue
    "Output y is true if all inputs are true (\"and\" of all inputs)"
    extends Modelica_Requirements.Interfaces.PartialBooleanVISO;

  equation
    y = Modelica_Requirements.LogicalFunctions.forall(u);

    annotation (defaultComponentName="allTrue1", Icon(graphics={Text(
            extent={{-40,15},{40,-15}},
            lineColor={0,0,0},
            textString="and")}),
      Documentation(info="<html>
<p>
Output y is <b>true</b> if all inputs are <b>true</b>, otherwise
output y is <b>false</b>.
</p>

<p>
The input connector is a vector of Boolean input signals.
When a connection line is drawn, the dimension of the input
vector is enlarged by one and the connection is automatically
connected to this new free index (thanks to the
connectorSizing annotation).
</p>

<p>
If no connection to the input connector \"u\" is present,
the output is set to: y=true.
</p>

<h4>Example</h4>

<p>
This block is demonstrated with the following
<a href=\"modelica://Modelica_Requirements.Examples.Elementary.LogicalBlocks.AllTrue\">example</a>: 
</p>

<p><blockquote>
<img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/Elementary/LogicalBlocks/AllTrue1.png\">
</blockquote></p>

<p>
results in
</p>

<table border=0 cellspacing=0 cellpadding=2>
<tr><td width=\"50\"></td>
    <td valign=\"bottom\"><img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/Elementary/LogicalBlocks/AllTrue2.png\"></td>
    </tr>

<tr><td></td>
    <td align=\"center\">simulation result</td>
   </tr>
</table>

<p>
This block is similar to block <a href=\"modelica://Modelica.Blocks.MathBoolean.And\">And</a>, but has a slightly different icon, the internal function call is inlined (so it is a bit more efficient), and y = true instead of false, if there are no connections.
</p>
</html>"));
  end AllTrue;

  block PropertyNot "3-valued logic 'not' of Property input u: y = not u"
    import Modelica_Requirements.Types.Property;

    Modelica_Requirements.Interfaces.PropertyInput u "Property input signal" annotation (Placement(transformation(extent={{-90,-20},{-50,20}})));

    Modelica_Requirements.Interfaces.PropertyOutput y
      "Property output signal y = not u"
      annotation (Placement(transformation(extent={{50,-10},{70,10}})));
  equation
    y = if u == Property.Satisfied then Property.Violated elseif
           u == Property.Violated  then Property.Satisfied else Property.Undecided;

    annotation (defaultComponentName="not1", Icon(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics={
          Rectangle(
            extent={{-50,50},{50,-50}},
            lineColor={0,0,0},
            lineThickness=5,
            fillColor={255,170,213},
            fillPattern=FillPattern.Solid,
            borderPattern=BorderPattern.Raised), Text(
            extent={{-150,100},{150,60}},
            lineColor={175,175,175},
            textString="%name"),                           Text(
            extent={{-50,15},{50,-15}},
            lineColor={0,0,0},
            textString="not")}),
          Diagram(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}},
          grid={1,1})),
      Documentation(info="<html>
<p>
Property output y is the 3-valued logic <b>not</b> of the property input u:
</p>

<blockquote><pre>
y = <b>not</b> u
</pre></blockquote>

<p>
The \"not\" of a property value u is defined according to the following table
(see also <a href=\"http://en.wikipedia.org/wiki/Three-valued_logic\">Wikipedia</a>):
</p>

<blockquote>
<table border=1 cellspacing=0 cellpadding=2>
<tr><td valign=\"top\"> u </td>
    <td valign=\"top\"><b>not</b> u</td></tr>

<tr><td valign=\"top\"><b>Violated</b></td>
    <td valign=\"top\">Satisfied </td></tr>

<tr><td valign=\"top\"><b>Undecided</b> </td>
    <td valign=\"top\">Undecided</td></tr>

<tr><td valign=\"top\"><b>Satisfied</b</td>
    <td valign=\"top\">Violated</td></tr>
</table>
</blockquote>

<p>
Violated, Undecided, and Satisfied are elements of enumeration
<a href=\"modelica://Modelica_Requirements.Types.Property\">Property</a>.
</p>

<h4>Example</h4>

<p>
This block is demonstrated with the following
<a href=\"modelica://Modelica_Requirements.Examples.Elementary.LogicalBlocks.PropertyNot\">example</a>: 
</p>

<p><blockquote>
<img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/Elementary/LogicalBlocks/PropertyNot1.png\">
</blockquote></p>

<p>
results in
</p>

<table border=0 cellspacing=0 cellpadding=2>
<tr><td width=\"50\"></td>
    <td valign=\"bottom\"><img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/Elementary/LogicalBlocks/PropertyNot2.png\"></td>
    </tr>

<tr><td></td>
    <td align=\"center\">simulation result</td>
   </tr>
</table>
</html>"));
  end PropertyNot;

  block PropertyOr
    "3-valued logic 'or' of Property input u: y = u[1] or u[2] or ... or u[nu]"
    extends Modelica_Requirements.Interfaces.PartialPropertyVISO;
    import Modelica_Requirements.LogicalFunctions.*;
    import Modelica_Requirements.Types.Property;
  equation
    y = if cardSatisfied(u) > 0  then Property.Satisfied elseif
           cardViolated(u) == nu then Property.Violated else
                                      Property.Undecided;
    annotation (defaultComponentName="or1", Icon(graphics={Text(
            extent={{-40,15},{40,-15}},
            lineColor={0,0,0},
            textString="or")}),
      Documentation(info="<html>
<p>
Property output y is the 3-valued logic <b>or</b> of the elements
of the property input vector u:
</p>

<blockquote><pre>
y = u[1] <b>or</b> u[2] <b>or</b> ... <b/>or</b> u[size(u,1)]
</pre></blockquote>

<p>
The \"or\" of two property values u[1] and u[2] is defined according to the following table
(see also <a href=\"http://en.wikipedia.org/wiki/Three-valued_logic\">Wikipedia</a>):
</p>

<blockquote>
<table border=1 cellspacing=0 cellpadding=2>
<tr><td valign=\"top\">u[1] <b>or</b> u[2]</td>
    <td valign=\"top\"><b>Violated</b></td>
    <td valign=\"top\"><b>Undecided</b></td>
    <td valign=\"top\"><b>Satisfied</b></td></tr>

<tr><td valign=\"top\"><b>Violated</b></td>
    <td valign=\"top\"> Violated </td>
    <td valign=\"top\"> Undecided </td>
    <td valign=\"top\"> Satisfied </td></tr>

<tr><td valign=\"top\"><b>Undecided</b></td>
    <td valign=\"top\"> Undecided </td>
    <td valign=\"top\"> Undecided </td>
    <td valign=\"top\"> Satisfied </td></tr>

<tr><td valign=\"top\"><b>Satisfied</b></td>
    <td valign=\"top\"> Satisfied </td>
    <td valign=\"top\"> Satisfied </td>
    <td valign=\"top\"> Satisfied </td></tr>
</table>
</blockquote>

<p>
Violated, Undecided, and Satisfied are elements of enumeration
<a href=\"modelica://Modelica_Requirements.Types.Property\">Property</a>.
</p>

<p>
The input connector <b>u</b> is a vector of Property input signals.
When a connection line is drawn, the dimension of the input
vector is enlarged by one and the connection is automatically
connected to this new free index (thanks to the
connectorSizing annotation).
</p>

<p>
If no connection to the input connector <b>u</b> is present,
the output is set to: y = Violated.
</p>

<h4>Example</h4>

<p>
This block is demonstrated with the following
<a href=\"modelica://Modelica_Requirements.Examples.Elementary.LogicalBlocks.PropertyOr\">example</a>: 
</p>

<p><blockquote>
<img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/Elementary/LogicalBlocks/PropertyOr1.png\">
</blockquote></p>

<p>
results in
</p>

<table border=0 cellspacing=0 cellpadding=2>
<tr><td width=\"50\"></td>
    <td valign=\"bottom\"><img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/Elementary/LogicalBlocks/PropertyOr2.png\"></td>
    </tr>

<tr><td></td>
    <td align=\"center\">simulation result</td>
   </tr>
</table>
</html>"),
      Diagram(graphics={
          Rectangle(
            extent={{-50,50},{50,-50}},
            lineColor={0,0,0},
            lineThickness=5,
            fillColor={255,170,213},
            fillPattern=FillPattern.Solid,
            borderPattern=BorderPattern.Raised),           Text(
            extent={{-40,15},{40,-15}},
            lineColor={0,0,0},
            textString="or")}));
  end PropertyOr;

  block PropertyAnd
    "3-valued logic 'and' of Property input u: y = u[1] and u[2] and ... and u[nu]"
    extends Modelica_Requirements.Interfaces.PartialPropertyVISO;
    import Modelica_Requirements.LogicalFunctions.*;
    import Modelica_Requirements.Types.Property;
  equation
    y = if cardSatisfied(u) == nu then Property.Satisfied elseif
           cardViolated(u) > 0    then Property.Violated else
                                       Property.Undecided;
    annotation (defaultComponentName="and1", Icon(graphics={Text(
            extent={{-40,15},{40,-15}},
            lineColor={0,0,0},
            textString="and")}),
      Documentation(info="<html>
<p>
Property output y is the 3-valued logic <b>and</b> of the elements
of the property input vector u:
</p>

<blockquote><pre>
y = u[1] <b>and</b> u[2] <b>and</b> ... <b/>and</b> u[size(u,1)]
</pre></blockquote>

<p>
The \"and\" of two property values u[1] and u[2] is defined according to the following table
(see also <a href=\"http://en.wikipedia.org/wiki/Three-valued_logic\">Wikipedia</a>):
</p>

<blockquote>
<table border=1 cellspacing=0 cellpadding=2>
<tr><td valign=\"top\">u[1] <b>and</b> u[2]</td>
    <td valign=\"top\"><b>Violated</b></td>
    <td valign=\"top\"><b>Undecided</b></td>
    <td valign=\"top\"><b>Satisfied</b></td></tr>

<tr><td valign=\"top\"><b>Violated</b></td>
    <td valign=\"top\"> Violated </td>
    <td valign=\"top\"> Violated </td>
    <td valign=\"top\"> Violated </td></tr>

<tr><td valign=\"top\"><b>Undecided</b></td>
    <td valign=\"top\"> Violated </td>
    <td valign=\"top\"> Undecided </td>
    <td valign=\"top\"> Undecided </td></tr>

<tr><td valign=\"top\"><b>Satisfied</b></td>
    <td valign=\"top\"> Violated </td>
    <td valign=\"top\"> Undecided </td>
    <td valign=\"top\"> Satisfied </td></tr>
</table>
</blockquote>

<p>
Violated, Undecided, and Satisfied are elements of enumeration
<a href=\"modelica://Modelica_Requirements.Types.Property\">Property</a>.
</p>

<p>
The input connector <b>u</b> is a vector of Property input signals.
When a connection line is drawn, the dimension of the input
vector is enlarged by one and the connection is automatically
connected to this new free index (thanks to the
connectorSizing annotation).
</p>

<p>
If no connection to the input connector <b>u</b> is present,
the output is set to: y = Satisfied.
</p>

<h4>Example</h4>

<p>
This block is demonstrated with the following
<a href=\"modelica://Modelica_Requirements.Examples.Elementary.LogicalBlocks.PropertyAnd\">example</a>: 
</p>

<p><blockquote>
<img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/Elementary/LogicalBlocks/PropertyAnd1.png\">
</blockquote></p>

<p>
results in
</p>

<table border=0 cellspacing=0 cellpadding=2>
<tr><td width=\"50\"></td>
    <td valign=\"bottom\"><img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/Elementary/LogicalBlocks/PropertyAnd2.png\"></td>
    </tr>

<tr><td></td>
    <td align=\"center\">simulation result</td>
   </tr>
</table>
</html>"));
  end PropertyAnd;

  block FallingEdgeTerminate
    "Terminate simulation when a falling edge of the input u occurs"
    parameter String text = "Simulation terminated explicitely"
      "Shown when simulation is terminated";
    Modelica.Blocks.Interfaces.BooleanInput u
      "Falling edge of this input terminates the simulation"
      annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  equation
    when not u then
      terminate(text);
    end when;
    annotation (defaultComponentName = "terminate1", Icon(coordinateSystem(preserveAspectRatio=false), graphics={
                                                 Text(
            extent={{-150,60},{150,100}},
            lineColor={175,175,175},
            textString="%name"),
         Rectangle(
            extent={{-100,50},{100,-50}},
            lineColor={0,0,0},
            lineThickness=5.0,
            fillColor={210,210,210},
            fillPattern=FillPattern.Solid,
            borderPattern=BorderPattern.Raised),
          Line(points={{-84,30},{-24,30},{-24,-2},{88,-2}},
                                                          color={255,0,255}),
          Polygon(
            points={{-24,-8},{-30,-26},{-18,-26},{-24,-8}},
            lineColor={255,0,0},
            fillColor={255,0,0},
            fillPattern=FillPattern.Solid),
          Line(points={{-24,-26},{-24,-44}},
                                           color={255,0,0}),
          Text(
            extent={{-10,-8},{90,-42}},
            lineColor={255,0,0},
            fillColor={210,210,210},
            fillPattern=FillPattern.Solid,
            textString="stop",
            horizontalAlignment=TextAlignment.Left)}),             Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end FallingEdgeTerminate;
  annotation (Icon(graphics={
                          Line(
          points={{-86,-12},{-50,-12},{-50,32},{48,32},{48,-12},{88,-12}},
          color={135,135,135})}));
end LogicalBlocks;
