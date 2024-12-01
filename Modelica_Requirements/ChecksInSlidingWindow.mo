within Modelica_Requirements;
package ChecksInSlidingWindow
  "Library of check blocks that inspect a property in a sliding time window"
  extends Modelica.Icons.Package;

  block MinDuration
    "In every sliding time window, the longest time duration where check was permanently true must be above a lower limit"
    import Modelica_Requirements.Types.Property;
    import Modelica_Requirements.Internal.SlidingWindow;
    extends Interfaces.PartialCheckInSlidingWindowWithPropertyOutput;

    parameter Modelica.Units.SI.Time lowerLimit(min=Modelica.Constants.eps)
      "In sliding time window, maxDuration(check=true) >= lowerLimit required";

    Modelica.Blocks.Interfaces.RealOutput maxDuration(final unit="s")
      "Longest time duration in the sliding time window where check was permanently true"
     annotation (Placement(transformation(extent={{200,-70},{220,-50}})));

  protected
    SlidingWindow.Buffer buffer "Buffer for sliding window";
    discrete Modelica.Units.SI.Time t_first;
    Boolean first;

  initial equation
    buffer = SlidingWindow.push(SlidingWindow.init(window,time), time, check);
    first = true;
    pre(check) = check;

  equation
    assert(lowerLimit < window, "lowerLimit < window required");

    when initial() then
       t_first = time + window;
    end when;

    when time >= t_first then
       first = false;
    end when;

    when change(check) then
       buffer = SlidingWindow.push(pre(buffer), time, check);
    end when;

    maxDuration = SlidingWindow.maxDuration(buffer, time, check);
    y = if maxDuration >= lowerLimit then Property.Satisfied else
        (if first then Property.Undecided else Property.Violated);

  annotation (defaultComponentName="minDuration1",Documentation(info="<html>
<h4>Syntax</h4>

<blockquote><p>
property = <b>MinDuration</b>(check=..., window=..., lowerLimit=...).y;
</p></blockquote>

<h4>Description</h4>

<p>
In any (sliding) time window of length <b>window</b>, the longest
time duration where the Boolean input <b>check</b> was permanently true (= maxDuration)
must be &ge; parameter <b>lowerLimit</b>.
Whenever this property is fulfilled, Property output y = Satisfied.
If this property is not fulfilled at the end of a sliding time window,
y = Violated (exception: before the end of the first time window, 
y = Undecided):
</p>

<blockquote><pre>
y =  if maxDuration &ge; lowerLimit then Satisfied else 
    (if first then Undecided else Violated);
</pre></blockquote>

<p>
Violated, Undecided, and Satisfied are elements of enumeration
<a href=\"modelica://Modelica_Requirements.Types.Property\">Property</a>.
</p>


<h4>Example</h4>

<p>
The property is demonstrated with the following
<a href=\"modelica://Modelica_Requirements.Examples.Elementary.ChecksInSlidingWindow.MinDuration\">example</a> calling the block as:
</p>

<p><blockquote>
<img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/Elementary/ChecksInSlidingWindow/MinDuration1.png\">
</blockquote></p>

<p>
results in
</p>

<table border=0 cellspacing=0 cellpadding=2>
<tr><td width=\"50\"></td>
    <td valign=\"bottom\"><img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/Elementary/ChecksInSlidingWindow/MinDuration2.png\"></td>
    </tr>

<tr><td></td>
    <td align=\"center\">simulation result</td>
   </tr>
</table>
</html>"),   Icon(coordinateSystem(preserveAspectRatio=false, extent={{-200,
              -100},{200,100}}),
                  graphics={
          Text(
            extent={{-180,45},{0,15}},
            lineColor={0,0,0},
            fillColor={255,0,0},
            fillPattern=FillPattern.Solid,
            textString="%lowerLimit s"),
          Text(
            extent={{-180,90},{0,65}},
            lineColor={95,95,95},
            textString=">="),
          Line(points={{-192,70},{-180,70},{-180,88},{-166,88},{-166,70},{-156,
                70}}, color={255,0,0})}));
  end MinDuration;

  block MinAccumulatedDuration
    "In every sliding time window, the accumulated time duration where check was true must be above a lower limit"
    import Modelica_Requirements.Types.Property;
    import Modelica_Requirements.Internal.SlidingWindow;
    extends Interfaces.PartialCheckInSlidingWindowWithPropertyOutput;

    parameter Modelica.Units.SI.Time lowerLimit(min=Modelica.Constants.eps)
      "In sliding time window, accumulatedDuration(check=true) >= lowerLimit required";

    Modelica.Blocks.Interfaces.RealOutput accumulatedDuration(final unit="s")
      "Accumulated time duration in the sliding time window where check was true"
     annotation (Placement(transformation(extent={{200,-70},{220,-50}})));

  protected
    SlidingWindow.Buffer buffer "Buffer for sliding window";
    discrete Modelica.Units.SI.Time t_first;
    Boolean first;

  initial equation
    buffer = SlidingWindow.push(SlidingWindow.init(window,time), time, check);
    first = true;
    pre(check) = check;

  equation
    assert(lowerLimit < window, "lowerLimit < window required");

    when initial() then
       t_first = time + window;
    end when;

    when time >= t_first then
       first = false;
    end when;

    when change(check) then
       buffer = SlidingWindow.push(pre(buffer), time, check);
    end when;

    accumulatedDuration = SlidingWindow.accumulatedDuration(buffer, time, check);
    y = if accumulatedDuration >= lowerLimit then Property.Satisfied else
        (if first then Property.Undecided else Property.Violated);

  annotation (defaultComponentName="minAccDuration1",Documentation(info="<html>
<h4>Syntax</h4>

<blockquote><p>
property =  <b>MinAccumulatedDuration</b>(check=..., window=..., lowerLimit=...).y;
</p></blockquote>

<h4>Description</h4>

<p>
In any (sliding) time window of length <b>window</b>, the accumulated
time duration where the Boolean input <b>check</b> was true (= accumulatedDuration)
must be &ge; parameter <b>lowerLimit</b>.
Whenever this property is fulfilled, Property output y = Satisfied.
If this property is not fulfilled at the end of a sliding time window,
y = Violated (exception: before the end of the first time window, 
y = Undecided):
</p>

<blockquote><pre>
y =  if accumulatedDuration &ge; lowerLimit then Satisfied else 
    (if first then Undecided else Violated);
</pre></blockquote>

<p>
Violated, Undecided, and Satisfied are elements of enumeration
<a href=\"modelica://Modelica_Requirements.Types.Property\">Property</a>.
</p>


<h4>Example</h4>

<p>
The property is demonstrated with the following
<a href=\"modelica://Modelica_Requirements.Examples.Elementary.ChecksInSlidingWindow.MinAccumulatedDuration\">example</a> calling the block as:
</p>

<p><blockquote>
<img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/Elementary/ChecksInSlidingWindow/MinAccumulatedDuration1.png\">
</blockquote></p>

<p>
results in
</p>

<table border=0 cellspacing=0 cellpadding=2>
<tr><td width=\"50\"></td>
    <td valign=\"bottom\"><img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/Elementary/ChecksInSlidingWindow/MinAccumulatedDuration2.png\"></td>
    </tr>

<tr><td></td>
    <td align=\"center\">simulation result</td>
   </tr>
</table>
</html>"),   Icon(graphics={
          Text(
            extent={{-180,45},{0,15}},
            lineColor={0,0,0},
            fillColor={255,0,0},
            fillPattern=FillPattern.Solid,
            textString="%lowerLimit s"),
          Text(
            extent={{-180,92},{0,67}},
            lineColor={95,95,95},
            textString=">="),
          Line(points={{-192,70},{-184,70},{-184,88},{-174,88},{-174,70},{-164.01,70},{-164,
                87.9297},{-154,88},{-154,70},{-146,70}}, color={255,0,0})}));
  end MinAccumulatedDuration;

  block MinAccumulatedDuration2
    "In every sliding time window, the accumulated time duration where check was true must be above a lower limit (same as MinAccumulationDuration but with Boolean instead of Property output)"
    import Modelica_Requirements.Types.Property;
    import Modelica_Requirements.Internal.SlidingWindow;
    extends Interfaces.PartialCheckInSlidingWindowWithBooleanOutput;

    parameter Modelica.Units.SI.Time lowerLimit(min=Modelica.Constants.eps)
      "In sliding time window, accumulatedDuration(check=true) >= lowerLimit required";

    Modelica.Blocks.Interfaces.RealOutput accumulatedDuration(final unit="s")
      "Accumulated time duration in the sliding time window where check was true"
     annotation (Placement(transformation(extent={{200,-70},{220,-50}})));

  protected
    SlidingWindow.Buffer buffer "Buffer for sliding window";

  initial equation
    buffer = SlidingWindow.push(SlidingWindow.init(window,time), time, check);
    pre(check) = check;

  equation
    assert(lowerLimit < window, "lowerLimit < window required");

    when change(check) then
       buffer = SlidingWindow.push(pre(buffer), time, check);
    end when;

    accumulatedDuration = SlidingWindow.accumulatedDuration(buffer, time, check);
    y = accumulatedDuration >= lowerLimit;

  annotation (defaultComponentName="minAccDuration1",Documentation(info="<html>
<h4>Syntax</h4>

<blockquote><p>
property =  <b>MinAccumulatedDuration2</b>(check=..., window=..., lowerLimit=...).y;
</p></blockquote>

<h4>Description</h4>

<p>
In any (sliding) time window of length <b>window</b>, the accumulated
time duration where the Boolean input <b>check</b> was true (= accumulatedDuration)
must be &ge; parameter <b>lowerLimit</b>.
Whenever this property is fulfilled, Boolean output y = true.
If this property is not fulfilled at the end of a sliding time window,
y = false (even at the first window):
</p>

<blockquote><pre>
y =  if accumulatedDuration &ge; lowerLimit then Satisfied else 
    (if first then Undecided else Violated);
</pre></blockquote>

<p>
Violated, Undecided, and Satisfied are elements of enumeration
<a href=\"modelica://Modelica_Requirements.Types.Property\">Property</a>.
</p>


<h4>Example</h4>

<p>
The property is demonstrated with the following
<a href=\"modelica://Modelica_Requirements.Examples.Elementary.ChecksInSlidingWindow.MinAccumulatedDuration2\">example</a> calling the block as:
</p>

<p><blockquote>
<img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/Elementary/ChecksInSlidingWindow/MinAccumulatedDuration1.png\">
</blockquote></p>

<p>
results in
</p>

<table border=0 cellspacing=0 cellpadding=2>
<tr><td width=\"50\"></td>
    <td valign=\"bottom\"><img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/Elementary/ChecksInSlidingWindow/MinAccumulatedDuration2_2.png\"></td>
    </tr>

<tr><td></td>
    <td align=\"center\">simulation result</td>
   </tr>
</table>
</html>"),   Icon(graphics={
          Text(
            extent={{-180,45},{0,15}},
            lineColor={0,0,0},
            fillColor={255,0,0},
            fillPattern=FillPattern.Solid,
            textString="%lowerLimit s"),
          Text(
            extent={{-180,92},{0,67}},
            lineColor={95,95,95},
            textString=">="),
          Line(points={{-192,70},{-184,70},{-184,88},{-174,88},{-174,70},{-164.01,70},{-164,
                87.9297},{-154,88},{-154,70},{-146,70}}, color={255,0,0})}));
  end MinAccumulatedDuration2;

  block MaxDuration
    "In every sliding time window, the longest time duration where check was permanently true must be below an upper limit"
    import Modelica_Requirements.Internal.SlidingWindow;
    extends Interfaces.PartialCheckInSlidingWindowWithBooleanOutput;

    parameter Modelica.Units.SI.Time upperLimit(min=Modelica.Constants.eps)
      "In sliding time window, maxDuration(check=true) <= upperLimit required";

    Modelica.Blocks.Interfaces.RealOutput maxDuration(final unit="s")
      "Longest time duration in the sliding time window where check was permanently true"
     annotation (Placement(transformation(extent={{200,-70},{220,-50}})));

  protected
    SlidingWindow.Buffer buffer "Buffer for sliding window";

  initial equation
    buffer = SlidingWindow.push(SlidingWindow.init(window,time), time, check);
    pre(check) = check;

  equation
    assert(upperLimit < window, "upperLimit < window required");

    when change(check) then
       buffer = SlidingWindow.push(pre(buffer), time, check);
    end when;

    maxDuration = SlidingWindow.maxDuration(buffer, time, check);
    y = maxDuration <= upperLimit;

  annotation (defaultComponentName="maxDuration1",Documentation(info="<html>
<h4>Syntax</h4>

<blockquote><p>
maxDurationLimited = <b>MaxDuration</b>(check=..., window=..., upperLimit=...).y;
</p></blockquote>

<h4>Description</h4>

<p>
In any (sliding) time window of length <b>window</b>, the longest
time duration where the Boolean input <b>check</b> was permanently true (= maxDuration)
must be &le; parameter <b>upperLimit</b>.
Whenever this property is fulfilled, Boolean output y = true,
otherwise y = false:
</p>

<blockquote><pre>
y =  maxDuration &le; upperLimit;
</pre></blockquote>

<h4>Example</h4>

<p>
The property is demonstrated with the following
<a href=\"modelica://Modelica_Requirements.Examples.Elementary.ChecksInSlidingWindow.MaxDuration\">example</a> calling the block as:
</p>

<p><blockquote>
<img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/Elementary/ChecksInSlidingWindow/MaxDuration1.png\">
</blockquote></p>

<p>
results in
</p>

<table border=0 cellspacing=0 cellpadding=2>
<tr><td width=\"50\"></td>
    <td valign=\"bottom\"><img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/Elementary/ChecksInSlidingWindow/MaxDuration2.png\"></td>
    </tr>

<tr><td></td>
    <td align=\"center\">simulation result</td>
   </tr>
</table>
</html>"),   Diagram(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-200,-100},{200,100}},
          grid={1,1}), graphics),
                        Icon(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-200,-100},{200,100}},
          grid={1,1}), graphics={
          Text(
            extent={{-200,110},{200,150}},
            lineColor={175,175,175},
            textString="%name"),
          Text(
            extent={{-180,45},{0,15}},
            lineColor={0,0,0},
            fillColor={255,0,0},
            fillPattern=FillPattern.Solid,
            textString="%upperLimit s"),
          Text(
            extent={{-180,90},{0,65}},
            lineColor={95,95,95},
            textString="<="),
          Line(points={{-190,72},{-178,72},{-178,90},{-164,90},{-164,72},{-154,
                72}}, color={255,0,0})}));
  end MaxDuration;

  block MaxAccumulatedDuration
    "In every sliding time window, the accumulated time duration where check was true must be below an upper limit"
    import Modelica_Requirements.Internal.SlidingWindow;
    extends Interfaces.PartialCheckInSlidingWindowWithBooleanOutput;

    parameter Modelica.Units.SI.Time upperLimit(min=Modelica.Constants.eps)
      "In sliding time window, accumulatedDuration(check=true) <= upperLimit required";

    Modelica.Blocks.Interfaces.RealOutput accumulatedDuration(final unit="s")
      "Accumulated time duration in the sliding time window where check was true"
     annotation (Placement(transformation(extent={{200,-70},{220,-50}})));

  protected
    SlidingWindow.Buffer buffer "Buffer for sliding window";

  initial equation
    buffer = SlidingWindow.push(SlidingWindow.init(window,time), time, check);
    pre(check) = check;

  equation
    assert(upperLimit < window, "upperLimit < window required");

    when change(check) then
       buffer = SlidingWindow.push(pre(buffer), time, check);
    end when;

    accumulatedDuration = SlidingWindow.accumulatedDuration(buffer, time, check);
    y = accumulatedDuration <= upperLimit;

  annotation (defaultComponentName="maxAccDuration1",Documentation(info="<html>
<h4>Syntax</h4>

<blockquote><p>
accumulatedDurationLimited = <b>MaxAccumulatedDuration</b>(check=..., window=..., upperLimit=...).y;
</p></blockquote>

<h4>Description</h4>

<p>
In any (sliding) time window of length <b>window</b>, the accumulated
time duration where the Boolean input <b>check</b> was true (= accumulatedDuration)
must be &le; parameter <b>upperLimit</b>.
Whenever this property is fulfilled, Boolean output y = true,
otherwise y = false:
</p>

<blockquote><pre>
y =  accumulatedDuration &le; upperLimit;
</pre></blockquote>

<h4>Example</h4>

<p>
The property is demonstrated with the following
<a href=\"modelica://Modelica_Requirements.Examples.Elementary.ChecksInSlidingWindow.MaxAccumulatedDuration\">example</a> calling the block as:
</p>

<p><blockquote>
<img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/Elementary/ChecksInSlidingWindow/MaxAccumulatedDuration1.png\">
</blockquote></p>

<p>
results in
</p>

<table border=0 cellspacing=0 cellpadding=2>
<tr><td width=\"50\"></td>
    <td valign=\"bottom\"><img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/Elementary/ChecksInSlidingWindow/MaxAccumulatedDuration2.png\"></td>
    </tr>

<tr><td></td>
    <td align=\"center\">simulation result</td>
   </tr>
</table>
</html>"),   Diagram(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-200,-100},{200,100}},
          grid={1,1}), graphics),
                        Icon(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-200,-100},{200,100}},
          grid={1,1}), graphics={
          Text(
            extent={{-200,110},{200,150}},
            lineColor={175,175,175},
            textString="%name"),
          Text(
            extent={{-180,45},{0,15}},
            lineColor={0,0,0},
            fillColor={255,0,0},
            fillPattern=FillPattern.Solid,
            textString="%upperLimit s"),
          Text(
            extent={{-180,90},{0,65}},
            lineColor={95,95,95},
            textString="<="),
          Line(points={{-192,70},{-184,70},{-184,88},{-174,88},{-174,70},{-164.01,70},{-164,
                87.9297},{-154,88},{-154,70},{-146,70}}, color={255,0,0})}));
  end MaxAccumulatedDuration;

  block BandDuration
    "In every sliding time window, the longest time duration where check was permanently true must be within a given band"
    import Modelica_Requirements.Types.Property;
    import Modelica_Requirements.Internal.SlidingWindow;
    extends Interfaces.PartialCheckInSlidingWindowWithPropertyOutput;

    parameter Modelica.Units.SI.Time lowerLimit(min=Modelica.Constants.eps)
      "In sliding time window, maxDuration(check=true) >= lowerLimit required";
    parameter Modelica.Units.SI.Time upperLimit(min=Modelica.Constants.eps)
      "In sliding time window, maxDuration(check=true) <= upperLimit required";

    Modelica.Blocks.Interfaces.RealOutput maxDuration(final unit="s")
      "Longest time duration in the sliding time window where check was permanently true"
     annotation (Placement(transformation(extent={{200,-70},{220,-50}})));

  protected
    SlidingWindow.Buffer buffer "Buffer for sliding window";
    discrete Modelica.Units.SI.Time t_first;
    Boolean first;

  initial equation
    buffer = SlidingWindow.push(SlidingWindow.init(window,time), time, check);
    first = true;
    pre(check) = check;

  equation
    assert(lowerLimit < upperLimit, "lowerLimit < upperLimit required");
    assert(upperLimit < window, "upperLimit < window required");

    when initial() then
       t_first = time + window;
    end when;

    when time >= t_first then
       first = false;
    end when;

    when change(check) then
       buffer = SlidingWindow.push(pre(buffer), time, check);
    end when;

    maxDuration = SlidingWindow.maxDuration(buffer, time, check);
    y = if maxDuration >= lowerLimit and maxDuration <= upperLimit then Property.Satisfied else
        (if first and maxDuration <= upperLimit then Property.Undecided else Property.Violated);

  annotation (defaultComponentName="bandDuration1", Documentation(info="<html>
<h4>Syntax</h4>

<blockquote><p>
property = <b>BandDuration</b>(check=..., window=..., lowerLimit=..., upperLimit=...).y;
</p></blockquote>

<h4>Description</h4>

<p>
In any (sliding) time window of length <b>window</b>, the longest
time duration where the Boolean input <b>check</b> was permanently true (= maxDuration)
must be &ge; parameter <b>lowerLimit</b> and &le; parameter <b>upperLimit</b>.
Whenever this property is fulfilled, Property output y = Satisfied.
If this property is not fulfilled at the end of a sliding time window,
y = Violated (exception: before the end of the first time window, 
y = Undecided provided maxDuration &le; lowerLimit):
</p>

<blockquote><pre>
y =  if maxDuration &ge; lowerLimit and maxDuration &le; upperLimit then Satisfied else 
    (if first and maxDuration &le; upperLimit then Undecided else Violated);
</pre></blockquote>

<p>
Violated, Undecided, and Satisfied are elements of enumeration
<a href=\"modelica://Modelica_Requirements.Types.Property\">Property</a>.
</p>


<h4>Example</h4>

<p>
The property is demonstrated with the following
<a href=\"modelica://Modelica_Requirements.Examples.Elementary.ChecksInSlidingWindow.BandDuration\">example</a> calling the block as:
</p>

<p><blockquote>
<img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/Elementary/ChecksInSlidingWindow/BandDuration1.png\">
</blockquote></p>

<p>
results in
</p>

<table border=0 cellspacing=0 cellpadding=2>
<tr><td width=\"50\"></td>
    <td valign=\"bottom\"><img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/Elementary/ChecksInSlidingWindow/BandDuration2.png\"></td>
    </tr>

<tr><td></td>
    <td align=\"center\">simulation result</td>
   </tr>
</table>
</html>"),   Icon(graphics={
          Text(
            extent={{-180,45},{0,15}},
            lineColor={0,0,0},
            fillColor={255,0,0},
            fillPattern=FillPattern.Solid,
            textString="%lowerLimit ... %upperLimit"),
          Text(
            extent={{-154,90},{26,65}},
            lineColor={95,95,95},
            textString=">= .... <= [s]"),
          Line(points={{-194,72},{-182,72},{-182,90},{-168,90},{-168,72},{-158,
                72}}, color={255,0,0})}));
  end BandDuration;

  block BandAccumulatedDuration
    "In every sliding time window, the accumulated time duration where check was true must be within a given band"
    import Modelica_Requirements.Types.Property;
    import Modelica_Requirements.Internal.SlidingWindow;
    extends Interfaces.PartialCheckInSlidingWindowWithPropertyOutput;

    parameter Modelica.Units.SI.Time lowerLimit(min=Modelica.Constants.eps)
      "In sliding time window, maxDuration(check=true) >= lowerLimit required";
    parameter Modelica.Units.SI.Time upperLimit(min=Modelica.Constants.eps)
      "In sliding time window, maxDuration(check=true) <= upperLimit required";

    Modelica.Blocks.Interfaces.RealOutput accumulatedDuration(final unit="s")
      "Accumulated time duration in the sliding time window where check was true"
     annotation (Placement(transformation(extent={{200,-70},{220,-50}})));

  protected
    SlidingWindow.Buffer buffer "Buffer for sliding window";
    discrete Modelica.Units.SI.Time t_first;
    Boolean first;

  initial equation
    buffer = SlidingWindow.push(SlidingWindow.init(window,time), time, check);
    first = true;
    pre(check) = check;

  equation
    assert(lowerLimit < upperLimit, "lowerLimit < upperLimit required");
    assert(upperLimit < window, "upperLimit < window required");

    when initial() then
       t_first = time + window;
    end when;

    when time >= t_first then
       first = false;
    end when;

    when change(check) then
       buffer = SlidingWindow.push(pre(buffer), time, check);
    end when;

    accumulatedDuration = SlidingWindow.accumulatedDuration(buffer, time, check);
    y = if accumulatedDuration >= lowerLimit and accumulatedDuration <= upperLimit then Property.Satisfied else
        (if first and accumulatedDuration <= upperLimit then Property.Undecided else Property.Violated);

  annotation (defaultComponentName="bandAccDuration1", Documentation(info="<html>
<h4>Syntax</h4>

<blockquote><p>
property = <b>BandAccumulatedDuration</b>(check=..., window=..., lowerLimit=..., upperLimit=...).y;
</p></blockquote>

<h4>Description</h4>

<p>
In any (sliding) time window of length <b>window</b>, the accumulated
time duration where the Boolean input <b>check</b> was true (= accumulatedDuration)
must be &ge; parameter <b>lowerLimit</b> and &le; parameter <b>upperLimit</b>.
Whenever this property is fulfilled, Property output y = Satisfied.
If this property is not fulfilled at the end of a sliding time window,
y = Violated (exception: before the end of the first time window, 
y = Undecided provided maxDuration &le; lowerLimit):
</p>

<blockquote><pre>
y =  if accumulatedDuration &ge; lowerLimit and accumulatedDuration &le; upperLimit then Satisfied else 
    (if first and accumulatedDuration &le; upperLimit then Undecided else Violated);
</pre></blockquote>

<p>
Violated, Undecided, and Satisfied are elements of enumeration
<a href=\"modelica://Modelica_Requirements.Types.Property\">Property</a>.
</p>


<h4>Example</h4>

<p>
The property is demonstrated with the following
<a href=\"modelica://Modelica_Requirements.Examples.Elementary.ChecksInSlidingWindow.BandAccumulatedDuration\">example</a> calling the block as:
</p>

<p><blockquote>
<img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/Elementary/ChecksInSlidingWindow/BandAccumulatedDuration1.png\">
</blockquote></p>

<p>
results in
</p>

<table border=0 cellspacing=0 cellpadding=2>
<tr><td width=\"50\"></td>
    <td valign=\"bottom\"><img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/Elementary/ChecksInSlidingWindow/BandAccumulatedDuration2.png\"></td>
    </tr>

<tr><td></td>
    <td align=\"center\">simulation result</td>
   </tr>
</table>
</html>"),   Icon(graphics={
          Text(
            extent={{-180,45},{0,15}},
            lineColor={0,0,0},
            fillColor={255,0,0},
            fillPattern=FillPattern.Solid,
            textString="%lowerLimit ... %upperLimit"),
          Text(
            extent={{-154,90},{26,65}},
            lineColor={95,95,95},
            textString=">= .... <= [s]"),
          Line(points={{-192,70},{-184,70},{-184,88},{-174,88},{-174,70},{-164.01,70},{-164,
                87.9297},{-154,88},{-154,70},{-146,70}}, color={255,0,0})}));
  end BandAccumulatedDuration;

  block MinRising
    "In every sliding time window, a minimum number of check rising edges must occur"

    import Modelica_Requirements.Types.Property;
    import Modelica_Requirements.Internal.SlidingWindow;
    extends Interfaces.PartialCheckInSlidingWindowWithPropertyOutput;

     parameter Integer nRisingMin(min=0)=1
      "Minimum number of check rising edges in a sliding time window";

    Modelica.Blocks.Interfaces.IntegerOutput nRising
      "Number of check rising edges in the sliding time window"
     annotation (Placement(transformation(extent={{200,-70},{220,-50}})));

  protected
    SlidingWindow.Buffer buffer "Buffer for sliding window";
    discrete Modelica.Units.SI.Time t_first;
    discrete Modelica.Units.SI.Time t_next
      "Next time instant where a rising edge of check is leaving the sliding time window";
    Boolean first;
    Boolean checkRising;

  initial equation
    buffer = if check then SlidingWindow.push(SlidingWindow.init(window,time), time) else
                SlidingWindow.init(window,time);
    t_next = if check then time + window else time - 1.0;
    nRising = if check then 1 else 0;
    y = if nRising >= nRisingMin then Property.Satisfied else Property.Undecided;
    first = true;
    pre(check) = check;

  equation
    when initial() then
       t_first = time + window;
    end when;

    when time >= t_first then
       first = false;
    end when;

    checkRising = edge(check);
    when {checkRising, time >= pre(t_next)} then
       buffer = if checkRising then SlidingWindow.push(pre(buffer),time) else
                                    SlidingWindow.removeOldest(pre(buffer), time);
       nRising = SlidingWindow.numberOfValues(buffer);
       t_next = SlidingWindow.nextLeaving(buffer, time);
       y = if nRising >= nRisingMin then Property.Satisfied else
           (if first then Property.Undecided else Property.Violated);
    end when;
    annotation(defaultComponentName="minRising1", Documentation(info="<html>
<h4>Syntax</h4>

<blockquote><p>
property = <b>MinRising</b>(check=..., window=..., nRisingMin=1).y;
</p></blockquote>

<h4>Description</h4>

<p>
In any (sliding) time window of length <b>window</b>, the number
or rising edges of the Boolean input <b>check</b> (= nRising)
must be &ge; parameter <b>nRisingMin</b>.
Whenever this property is fulfilled, Property output y = Satisfied.
If this property is not fulfilled at the end of a sliding time window,
Property output y = Violated (exception: before the end of the first time window, 
y = Undecided):
</p>

<blockquote><pre>
y =  if nRising &ge; nRisingMin then Satisfied else 
    (if first then Undecided else Violated);
</pre></blockquote>


<p>
Violated, Undecided, and Satisfied are elements of enumeration
<a href=\"modelica://Modelica_Requirements.Types.Property\">Property</a>.
</p>


<h4>Example</h4>

<p>
The property is demonstrated with the following
<a href=\"modelica://Modelica_Requirements.Examples.Elementary.ChecksInSlidingWindow.MinRising\">example</a> calling the block as:
</p>

<p><blockquote>
<img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/Elementary/ChecksInSlidingWindow/MinRising1.png\">
</blockquote></p>

<p>
results in
</p>

<table border=0 cellspacing=0 cellpadding=2>
<tr><td width=\"50\"></td>
    <td valign=\"bottom\"><img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/Elementary/ChecksInSlidingWindow/MinRising2.png\"></td>
    </tr>

<tr><td></td>
    <td align=\"center\">simulation result</td>
   </tr>
</table>
</html>"),   Icon(graphics={
          Text(
            extent={{-180,45},{0,15}},
            lineColor={0,0,0},
            fillColor={255,0,0},
            fillPattern=FillPattern.Solid,
            textString="%nRisingMin"),
          Text(
            extent={{-180,90},{0,65}},
            lineColor={95,95,95},
            textString="#edges >=")}));
  end MinRising;

  block MaxRising
    "In every sliding time window, the number of check rising edges is bounded"

    import Modelica_Requirements.Internal.SlidingWindow;
    extends Interfaces.PartialCheckInSlidingWindowWithBooleanOutput;

     parameter Integer nRisingMax(min=0)=1
      "Maximum number of check rising edges in a sliding time window";

    Modelica.Blocks.Interfaces.IntegerOutput nRising
      "Number of check rising edges in the sliding time window"
     annotation (Placement(transformation(extent={{200,-70},{220,-50}})));

  protected
    SlidingWindow.Buffer buffer "Buffer for sliding window";
    discrete Modelica.Units.SI.Time t_next
      "Next time instant where a rising edge of check is leaving the sliding time window";
    Boolean checkRising;

  initial equation
    buffer = if check then SlidingWindow.push(SlidingWindow.init(window,time), time) else
                SlidingWindow.init(window,time);
    t_next = if check then time + window else time - 1.0;
    nRising = if check then 1 else 0;
    y = nRising <= nRisingMax;
    pre(check) = check;

  equation
    checkRising = edge(check);
    when {checkRising, time >= pre(t_next)} then
       buffer = if checkRising then SlidingWindow.push(pre(buffer),time) else
                                    SlidingWindow.removeOldest(pre(buffer), time);
       nRising = SlidingWindow.numberOfValues(buffer);
       t_next = SlidingWindow.nextLeaving(buffer, time);
       y = nRising <= nRisingMax;
    end when;
  annotation (defaultComponentName="maxRising1", Documentation(info="<html>
<h4>Syntax</h4>

<blockquote><p>
nRisingLimited = <b>MaxRising</b>(check=..., window=..., nRisingMax=1).y;
</p></blockquote>

<h4>Description</h4>

<p>
In any (sliding) time window of length <b>window</b>, the number
or rising edges of the Boolean input <b>check</b> (= nRising)
must be &le; parameter <b>nRisingMax</b>.
Whenever this property is fulfilled, Boolean output y = true,
otherwise y = false.
</p>

<blockquote><pre>
y = nRising &le; nRisingMax;
</pre></blockquote>


<h4>Example</h4>

<p>
The property is demonstrated with the following
<a href=\"modelica://Modelica_Requirements.Examples.Elementary.ChecksInSlidingWindow.MaxRising\">example</a> calling the block as:
</p>

<p><blockquote>
<img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/Elementary/ChecksInSlidingWindow/MaxRising1.png\">
</blockquote></p>

<p>
results in
</p>

<table border=0 cellspacing=0 cellpadding=2>
<tr><td width=\"50\"></td>
    <td valign=\"bottom\"><img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/Elementary/ChecksInSlidingWindow/MaxRising2.png\"></td>
    </tr>

<tr><td></td>
    <td align=\"center\">simulation result</td>
   </tr>
</table>
</html>"),   Icon(graphics={
          Text(
            extent={{-180,45},{0,15}},
            lineColor={0,0,0},
            fillColor={255,0,0},
            fillPattern=FillPattern.Solid,
            textString="%nRisingMax"),
          Text(
            extent={{-180,90},{0,65}},
            lineColor={95,95,95},
            textString="#edges <=")}));
  end MaxRising;

  block BandRising
    "In every sliding time window, a minimum number of check rising edges must occur and the number of check rising edges is bounded"

    import Modelica_Requirements.Types.Property;
    import Modelica_Requirements.Internal.SlidingWindow;
    extends Interfaces.PartialCheckInSlidingWindowWithPropertyOutput;

     parameter Integer nRisingMin(min=0)=1
      "Minimum number of check rising edges in a sliding time window";
     parameter Integer nRisingMax(min=0)=2
      "Maximum number of check rising edges in a sliding time window";

    Modelica.Blocks.Interfaces.IntegerOutput nRising
      "Number of check rising edges in the sliding time window"
     annotation (Placement(transformation(extent={{200,-70},{220,-50}})));

  protected
    SlidingWindow.Buffer buffer "Buffer for sliding window";
    discrete Modelica.Units.SI.Time t_first;
    discrete Modelica.Units.SI.Time t_next
      "Next time instant where a rising edge of check is leaving the sliding time window";
    Boolean first;
    Boolean checkRising;

  initial equation
    buffer = if check then SlidingWindow.push(SlidingWindow.init(window,time), time) else
                SlidingWindow.init(window,time);
    t_next = if check then time + window else time - 1.0;
    nRising = if check then 1 else 0;
    y = if nRising >= nRisingMin and nRising <= nRisingMax  then
           Property.Satisfied else Property.Undecided;
    first = true;
    pre(check) = check;

  equation
    assert(nRisingMin <= nRisingMax, "nRisingMin > nRisingMax");

    when initial() then
       t_first = time + window;
    end when;

    when time >= t_first then
       first = false;
    end when;

    checkRising = edge(check);
    when {checkRising, time >= pre(t_next)} then
       buffer = if checkRising then SlidingWindow.push(pre(buffer),time) else
                                    SlidingWindow.removeOldest(pre(buffer), time);
       nRising = SlidingWindow.numberOfValues(buffer);
       t_next = SlidingWindow.nextLeaving(buffer, time);
       y = if nRising >= nRisingMin and nRising <= nRisingMax then Property.Satisfied else
           (if first and nRising <= nRisingMax then Property.Undecided else Property.Violated);
    end when;
    annotation(defaultComponentName="bandRising1", Documentation(info="<html>
<h4>Syntax</h4>

<blockquote><p>
property = <b>BandRising</b>(check=..., window=..., nRisingMin=1, nRisingMax=2).y;
</p></blockquote>

<h4>Description</h4>

<p>
In any (sliding) time window of length <b>window</b>, the number
or rising edges of the Boolean input <b>check</b> (= nRising)
must be &ge; parameter <b>nRisingMin</b> and &le; parameter <b>nRisingMax</b>.
Whenever this property is fulfilled, Property output y = Satisfied.
If this property is not fulfilled at the end of a sliding time window,
Property output y = Violated (exception: before the end of the first time window, 
y = Undecided provided nRising &le; nRisingMax):
</p>

<blockquote><pre>
y =  if nRising &ge; nRisingMin and nRising &le; nRisingMax then Satisfied else 
    (if first and nRising &le; nRisingMax then Undecided else Violated);
</pre></blockquote>


<p>
Violated, Undecided, and Satisfied are elements of enumeration
<a href=\"modelica://Modelica_Requirements.Types.Property\">Property</a>.
</p>


<h4>Example</h4>

<p>
The property is demonstrated with the following
<a href=\"modelica://Modelica_Requirements.Examples.Elementary.ChecksInSlidingWindow.BandRising\">example</a> calling the block as:
</p>

<p><blockquote>
<img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/Elementary/ChecksInSlidingWindow/BandRising1.png\">
</blockquote></p>

<p>
results in
</p>

<table border=0 cellspacing=0 cellpadding=2>
<tr><td width=\"50\"></td>
    <td valign=\"bottom\"><img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/Elementary/ChecksInSlidingWindow/BandRising2.png\"></td>
    </tr>

<tr><td></td>
    <td align=\"center\">simulation result</td>
   </tr>
</table>
</html>"),   Icon(graphics={
          Text(
            extent={{-180,45},{0,15}},
            lineColor={0,0,0},
            fillColor={255,0,0},
            fillPattern=FillPattern.Solid,
            textString="%nRisingMin ... %nRisingMax"),
          Text(
            extent={{-180,90},{0,65}},
            lineColor={95,95,95},
            textString="#edges")}));
  end BandRising;

  block MaxFrequency
    "In every sliding time window, the mean frequency of check is limited"
    import Modelica_Requirements.Internal.SlidingWindow;
    extends Interfaces.PartialCheckInSlidingWindowWithBooleanOutput;

    parameter Modelica.Units.SI.Frequency freqHzMeanMax(min=0.0)
      "Maximum allowed mean frequency of check in sliding time window";
    Modelica.Blocks.Interfaces.RealOutput freqHzMean(final quantity="Frequency",final unit="Hz")
      "Mean frequency of check in sliding time window"
      annotation (Placement(transformation(extent={{200,-70},{220,-50}})));
  protected
    function meanFrequency "Return mean frequency"
       input Integer nCrossing "Number of crossing edges in the last window";
      input Modelica.Units.SI.Time window "Length of sliding time window";
      output Modelica.Units.SI.Frequency freqHzMean
        "Mean frequency in sliding time window";
    algorithm
       freqHzMean :=if nCrossing > 1 then 1/(window/((nCrossing - 1)/2)) else 0;
    end meanFrequency;

    SlidingWindow.Buffer buffer "Buffer for sliding window";
    constant Real eps = 100*Modelica.Constants.eps
      "Small number to guard against division of zero";
    Modelica.Units.SI.Time t_next
      "Next time instant where a rising edge of check is leaving the sliding time window";
    Integer nCrossing;
    Boolean checkChanging;

  initial equation
    pre(check) = check;
    nCrossing = 0;
    buffer = SlidingWindow.init(window,time);
    freqHzMean = 0;
    t_next = time - window;
    y = true;

  equation
    checkChanging = change(check);
    when {checkChanging, time >= pre(t_next)} then
       buffer = if checkChanging then SlidingWindow.push(pre(buffer),time) else
                   SlidingWindow.removeOldest(pre(buffer), time);
       nCrossing = SlidingWindow.numberOfValues(buffer);
       freqHzMean = meanFrequency(nCrossing, window);
       t_next = SlidingWindow.nextLeaving(buffer, time);
       y = freqHzMean <= freqHzMeanMax;
    end when;

  annotation (defaultComponentName="maxFrequency1",Documentation(info="<html>
<h4>Syntax</h4>

<blockquote><p>
freqLimited = <b>MaxFrequency</b>(check=..., window=..., freqHzMeanMax=...).y;
</p></blockquote>

<h4>Description</h4>

<p>
In any (sliding) time window of length <b>window</b>,
the mean frequency of the Boolean input <b>check</b> 
is limited by <b>freqHzMeanMax</b>. With T the time period for
a rising, falling and rising edge of check, the frequency is defined
as freqHz = 1/T. Therefore, in any sliding window the
following constraint shall hold:
</p>

<blockquote><pre>
if nCrossing > 1 then
  freqHzMean = 1/(window/( (nCrossing-1)/2 ));
else
  freqHzMean = 0
end if;

freqHzMean &le; freqHzMax
</pre></blockquote>

<p>
where nCrossing is the number of crossing edges of check in the last time window
of length window. The mean frequency over the sliding time window 
is also provided as additional output
signal <b>freqHzMean</b>. 
If the mean frequency is not larger as freqHzMeanMax, output
<b>y</b> is set to true, otherwise to y = false.
</p>


<h4>Example</h4>

<p>
The property is demonstrated with the following
<a href=\"modelica://Modelica_Requirements.Examples.Elementary.ChecksInSlidingWindow.MaxFrequency\">example</a> calling the block as:
</p>

<p><blockquote>
<img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/Elementary/ChecksInSlidingWindow/MaxFrequency1.png\">
</blockquote></p>

<p>
results in
</p>

<table border=0 cellspacing=0 cellpadding=2>
<tr><td width=\"50\"></td>
    <td valign=\"bottom\"><img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/Elementary/ChecksInSlidingWindow/MaxFrequency2.png\"></td>
    </tr>

<tr><td></td>
    <td align=\"center\">simulation result</td>
   </tr>
</table>
<p>
Note, the check signal has first a frequency of 2 Hz, then of 4 Hz, then of 2 Hz and finally of 0 Hz.
The MaxFrequency block can reproduce these frequencies approximately. It is not exact, because
the frequency is only determined based on the rising and falling edges of check. However, it is slightly
more precise as using the <a href=\"modelica://Modelica_Requirements.ChecksInSlidingWindow.MeanRisingFrequency\">MeanRisingFrequency</a> block that takes only the
rising edges of check into account.
</p>
</html>"),   Icon(graphics={
          Text(
            extent={{-180,45},{0,15}},
            lineColor={0,0,0},
            fillColor={255,0,0},
            fillPattern=FillPattern.Solid,
            textString="%freqHzMeanMax Hz"),
          Line(
            points={{-184,72},{-150,72},{-150,90},{-104,90},{-104,72},{-60,72},{-60,
                90},{-8,90}},
            color={0,0,0},
            smooth=Smooth.None),
          Line(
            points={{-60,96},{-60,72}},
            color={255,0,0},
            smooth=Smooth.None),
          Line(
            points={{-150,96},{-150,72}},
            color={255,0,0},
            smooth=Smooth.None),
          Line(
            points={{-104,90},{-104,66}},
            color={255,0,0},
            smooth=Smooth.None)}));
  end MaxFrequency;

  block MaxRisingFrequency
    "In every sliding time window, the mean frequency of the check rising edges is limited"
    import Modelica_Requirements.Internal.SlidingWindow;
    extends Interfaces.PartialCheckInSlidingWindowWithBooleanOutput;

    parameter Modelica.Units.SI.Frequency freqHzMeanMax(min=0.0)
      "Maximum allowed mean frequency of rising edges in sliding time window";
    Modelica.Blocks.Interfaces.RealOutput freqHzMean(final quantity="Frequency",final unit="Hz")
      "Mean frequency of the rising edges in sliding time window"
      annotation (Placement(transformation(extent={{200,-70},{220,-50}})));
  protected
    function meanFrequency "Return mean frequency"
       input Integer nRising "Number of rising edges in the last window";
      input Modelica.Units.SI.Time window "Length of sliding time window";
      output Modelica.Units.SI.Frequency freqHzMean
        "Mean frequency in sliding time window";
    algorithm
       freqHzMean :=if nRising > 1 then 1/(window/(nRising - 1)) else 0;
    end meanFrequency;

    SlidingWindow.Buffer buffer "Buffer for sliding window";
    constant Real eps = 100*Modelica.Constants.eps
      "Small number to guard against division of zero";
    Modelica.Units.SI.Time t_next
      "Next time instant where a rising edge of check is leaving the sliding time window";
    Integer nRising;
    Boolean checkRising;

  initial equation
    pre(check) = check;
    nRising = 0;
    buffer = SlidingWindow.init(window,time);
    freqHzMean = 0;
    t_next = time - window;
    y = true;

  equation
    checkRising = edge(check);
    when {checkRising, time >= pre(t_next)} then
       buffer = if checkRising then SlidingWindow.push(pre(buffer),time) else
                   SlidingWindow.removeOldest(pre(buffer), time);
       nRising = SlidingWindow.numberOfValues(buffer);
       freqHzMean = meanFrequency(nRising, window);
       t_next = SlidingWindow.nextLeaving(buffer, time);
       y = freqHzMean <= freqHzMeanMax;
    end when;

  annotation (defaultComponentName="maxRisingFrequency1",Documentation(info="<html>
<h4>Syntax</h4>

<blockquote><p>
freqLimited = <b>MaxRisingFrequency</b>(check=..., window=..., freqHzMeanMax=...).y;
</p></blockquote>

<h4>Description</h4>

<p>
In any (sliding) time window of length <b>window</b>,
the mean frequency of the rising edges of Boolean input <b>check</b> 
is limited by <b>freqHzMeanMax</b>. Therefore, in any sliding window the
following constraint shall hold:
</p>

<blockquote><pre>
if nRising > 1 then
  freqHzMean = 1/(window/(nRising-1));
else
  freqHzMean = 0
end if;

freqHzMean &le; freqHzMax
</pre></blockquote>

<p>
where nRising is the number of rising edges of check in the last time window
of length window. The mean frequency over the sliding time window 
is also provided as additional output
signal <b>freqHzMean</b>. 
If the mean frequency is not larger as freqHzMeanMax, output
<b>y</b> is set to true, otherwise to y = false.
</p>


<h4>Example</h4>

<p>
The property is demonstrated with the following
<a href=\"modelica://Modelica_Requirements.Examples.Elementary.ChecksInSlidingWindow.MaxRisingFrequency\">example</a> calling the block as:
</p>

<p><blockquote>
<img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/Elementary/ChecksInSlidingWindow/MaxRisingFrequency1.png\">
</blockquote></p>

<p>
results in
</p>

<table border=0 cellspacing=0 cellpadding=2>
<tr><td width=\"50\"></td>
    <td valign=\"bottom\"><img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/Elementary/ChecksInSlidingWindow/MaxRisingFrequency2.png\"></td>
    </tr>

<tr><td></td>
    <td align=\"center\">simulation result</td>
   </tr>
</table>
</html>"),   Icon(graphics={
          Text(
            extent={{-180,45},{0,15}},
            lineColor={0,0,0},
            fillColor={255,0,0},
            fillPattern=FillPattern.Solid,
            textString="%freqHzMeanMax Hz"),
          Line(
            points={{-184,72},{-150,72},{-150,90},{-104,90},{-104,72},{-60,72},{-60,
                90},{-8,90}},
            color={0,0,0},
            smooth=Smooth.None),
          Line(
            points={{-60,96},{-60,72}},
            color={255,0,0},
            smooth=Smooth.None),
          Line(
            points={{-150,96},{-150,72}},
            color={255,0,0},
            smooth=Smooth.None)}));
  end MaxRisingFrequency;

  block MaxIncrease
    "In every sliding time window, the increase of the input is limited"

    parameter Modelica.Units.SI.Time window(min=Modelica.Constants.eps)
      "Length of sliding time window (> 0)";
    parameter Real upperLimit(min=Modelica.Constants.eps)
      "In sliding time window, increase <= upperLimit of input u required";

    Modelica.Blocks.Interfaces.BooleanOutput y
      "= true if increase <= upperLimit"
      annotation (Placement(transformation(extent={{100,-10},{120,10}})));

    Modelica.Blocks.Interfaces.RealOutput increase
      "Increase of the input signal in the sliding time window"
     annotation (Placement(transformation(extent={{100,-70},{120,-50}})));

    Modelica.Blocks.Interfaces.RealInput u "Real input signal"
      annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));

  equation
    increase = u - delay(u,window);
    y = increase <= upperLimit;

    annotation (defaultComponentName="upperLimit1",Diagram(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics), Icon(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics={
         Rectangle(
            extent={{-100,100},{100,-100}},
            lineColor={0,0,0},
            lineThickness=5.0,
            fillColor={210,210,210},
            fillPattern=FillPattern.Solid,
            borderPattern=BorderPattern.Raised),
          Rectangle(
            extent={{-90,46},{90,-4}},
            lineColor={0,0,0},
            lineThickness=5.0,
            fillColor={245,245,245},
            fillPattern=FillPattern.Solid,
            borderPattern=BorderPattern.Sunken),
          Text(
            extent={{-90,76},{90,51}},
            lineColor={95,95,95},
            fillColor={210,210,210},
            fillPattern=FillPattern.Solid,
            horizontalAlignment=TextAlignment.Left,
            textString="window"),
          Text(
            extent={{-90,36},{90,6}},
            lineColor={0,0,0},
            fillColor={210,210,210},
            fillPattern=FillPattern.Solid,
            textString="%window s"),             Text(
            extent={{-150,109},{150,149}},
            lineColor={175,175,175},
            textString="%name"),
          Rectangle(
            extent={{-90,-39},{90,-89}},
            lineColor={0,0,0},
            lineThickness=5.0,
            fillColor={245,245,245},
            fillPattern=FillPattern.Solid,
            borderPattern=BorderPattern.Sunken),
          Text(
            extent={{-90,-49},{90,-79}},
            lineColor={0,0,0},
            fillColor={210,210,210},
            fillPattern=FillPattern.Solid,
            textString="%upperLimit"),
          Text(
            extent={{-90,-12},{90,-37}},
            lineColor={95,95,95},
            fillColor={210,210,210},
            fillPattern=FillPattern.Solid,
            textString="increase <=",
            horizontalAlignment=TextAlignment.Left),
          Line(points={{56,56},{82,56}}, color={135,135,135}),
          Line(points={{78,91},{78,56}}, color={255,0,0}),
          Line(points={{42,50},{54,55},{66,64},{71,75},{73,85},{75,89},{82,93},{94,
                93}}, color={0,0,0})}),
      Documentation(info="<html>
<h4>Syntax</h4>

<blockquote><p>
increaseLimited = <b>MaxIncrease</b>(window=..., upperLimit=...).y;
</p></blockquote>

<h4>Description</h4>

<p>
In any (sliding) time window of length <b>window</b>, the increase of input <b>u</b>
is limited by parameter <b>upperLimit</b>, that is
</p>
<blockquote><pre>
increase(t) = u(t) - u(t-window)
       y(t) = increase(t) &le; upperLimit
</pre></blockquote>
<p>
Whenever this property is fulfilled, Boolean output y = true,
otherwise y = false:
</p>

<p>
Hereby it is assumed that u(t-window) = u(t<sub>0</sub>) for
t<sub>0</sub> &le; t &lt; t<sub>0</sub> + window, where t<sub>0</sub> is the
start time of the simulation. 
</p>

<h4>Example</h4>

<p>
The property is demonstrated with the following
<a href=\"modelica://Modelica_Requirements.Examples.Elementary.ChecksInSlidingWindow.MaxIncrease\">example</a> calling the block as:
</p>

<p><blockquote>
<img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/Elementary/ChecksInSlidingWindow/MaxIncrease1.png\">
</blockquote></p>

<p>
results in
</p>

<table border=0 cellspacing=0 cellpadding=2>
<tr><td width=\"50\"></td>
    <td valign=\"bottom\"><img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/Elementary/ChecksInSlidingWindow/MaxIncrease2.png\"></td>
    </tr>

<tr><td></td>
    <td align=\"center\">simulation result</td>
   </tr>
</table>
</html>"));
  end MaxIncrease;

  block MaxPercentageIncrease
    "In every sliding time window, the percentage increase of the input is limited"

    parameter Modelica.Units.SI.Time window(min=Modelica.Constants.eps)
      "Length of sliding time window (> 0)";
    parameter Real upperPercentageLimit(min=Modelica.Constants.eps)
      "(in [%]) In sliding time window, percentageIncrease <= upperPercentageLimit of input u required";
    parameter Real u_small = 1e-10
      "Small number to guard against a division by zero";

    Modelica.Blocks.Interfaces.BooleanOutput y
      "= true if percentageIncrease <= upperPercentageLimit"
      annotation (Placement(transformation(extent={{100,-10},{120,10}})));

    Modelica.Blocks.Interfaces.RealOutput percentageIncrease
      "Increase of the input signal in the sliding time window in [%]"
     annotation (Placement(transformation(extent={{100,-70},{120,-50}})));

    Modelica.Blocks.Interfaces.RealInput u "Real input signal"
      annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  protected
    Real u_delayed;
  equation
    assert(u_small > 0, "u_small > 0 required");
    u_delayed = delay(u, window);
    percentageIncrease = 100*(u - u_delayed)/noEvent(max( abs(u_delayed), u_small));
    y = percentageIncrease <= upperPercentageLimit;

    annotation (defaultComponentName="maxIncrease1",Diagram(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics), Icon(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics={
         Rectangle(
            extent={{-100,100},{100,-100}},
            lineColor={0,0,0},
            lineThickness=5.0,
            fillColor={210,210,210},
            fillPattern=FillPattern.Solid,
            borderPattern=BorderPattern.Raised),
          Rectangle(
            extent={{-90,46},{90,-4}},
            lineColor={0,0,0},
            lineThickness=5.0,
            fillColor={245,245,245},
            fillPattern=FillPattern.Solid,
            borderPattern=BorderPattern.Sunken),
          Text(
            extent={{-90,76},{90,51}},
            lineColor={95,95,95},
            fillColor={210,210,210},
            fillPattern=FillPattern.Solid,
            horizontalAlignment=TextAlignment.Left,
            textString="window"),
          Text(
            extent={{-90,36},{90,6}},
            lineColor={0,0,0},
            fillColor={210,210,210},
            fillPattern=FillPattern.Solid,
            textString="%window s"),             Text(
            extent={{-150,109},{150,149}},
            lineColor={175,175,175},
            textString="%name"),
          Rectangle(
            extent={{-90,-39},{90,-89}},
            lineColor={0,0,0},
            lineThickness=5.0,
            fillColor={245,245,245},
            fillPattern=FillPattern.Solid,
            borderPattern=BorderPattern.Sunken),
          Text(
            extent={{-90,-49},{90,-79}},
            lineColor={0,0,0},
            fillColor={210,210,210},
            fillPattern=FillPattern.Solid,
            textString="%upperPercentageLimit %%"),
          Text(
            extent={{-90,-12},{90,-37}},
            lineColor={95,95,95},
            fillColor={210,210,210},
            fillPattern=FillPattern.Solid,
            textString="increase <=",
            horizontalAlignment=TextAlignment.Left),
          Line(points={{56,56},{82,56}}, color={135,135,135}),
          Line(points={{78,91},{78,56}}, color={255,0,0}),
          Line(points={{42,50},{54,55},{66,64},{71,75},{73,85},{75,89},{82,93},{94,
                93}}, color={0,0,0})}),
      Documentation(info="<html>
<h4>Syntax</h4>

<blockquote><p>
percentageIncreaseLimited = <b>MaxPercentageIncrease</b>(window=..., upperPercentageLimit=...).y;
</p></blockquote>

<h4>Description</h4>

<p>
In any (sliding) time window of length <b>window</b>, the percentage increase of input <b>u</b>
is limited by parameter <b>upperPercentageLimit</b>, that is
</p>
<blockquote><pre>
percentageIncrease(t) = 100*(u(t) - u(t-window)/max(|u(t-window)|,u<sub>small</sub>), if t &ge; t<sub>0</sub> + window
                      = 100*(u(t) - u(t<sub>0</sub>)/max(|u(t<sub>0</sub>)|,u<sub>small</sub>), if t &lt; t<sub>0</sub> + window
                 y(t) = percentageIncrease(t) &le; upperPercentageLimit
</pre></blockquote>
<p>
Whenever this property is fulfilled, Boolean output y = true,
otherwise y = false.
</p>

<p>
The denominator of the percentageIncrease uses the max(...,u<sub>small</sub>)) construction to
guard against division by 0.
</p>

<p>
Note, percentageIncrease and upperPercentageLimit have unit [%].
</p>

<h4>Example</h4>

<p>
The property is demonstrated with the following
<a href=\"modelica://Modelica_Requirements.Examples.Elementary.ChecksInSlidingWindow.MaxPercentageIncrease\">example</a> calling the block as:
</p>

<p><blockquote>
<img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/Elementary/ChecksInSlidingWindow/MaxPercentageIncrease1.png\">
</blockquote></p>

<p>
results in
</p>

<table border=0 cellspacing=0 cellpadding=2>
<tr><td width=\"50\"></td>
    <td valign=\"bottom\"><img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/Elementary/ChecksInSlidingWindow/MaxPercentageIncrease2.png\"></td>
    </tr>

<tr><td></td>
    <td align=\"center\">simulation result</td>
   </tr>
</table>
</html>"));
  end MaxPercentageIncrease;
  annotation (Icon(graphics={
        Line(
          points={{60,-40},{40,-40},{22,-40}},
          color={175,175,175},
          smooth=Smooth.None),
        Rectangle(
          extent={{-56,64},{22,-40}},
          lineColor={175,175,175},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-88,-40},{-6,-40},{-6,30},{60,30},{60,-40},{90,-40}},
          color={0,0,0},
          smooth=Smooth.None)}), Documentation(info="<html>
<p>
This library provides blocks that check properties in a <b>sliding time window</b>.
Blocks performing checks in fixed windows defined by a Boolean condition variable
are provided in sublibrary
<a href=\"modelica://Modelica_Requirements.ChecksInFixedWindow\">ChecksInFixedWindow</a>.
</p>

<p>
All blocks of this library have the following interface:
</p>

<ul>
<li> Boolean input <b>check</b> is a Boolean expression that must be true
     according to the property check of the particular block. </li>

<li> Real input <b>window</b> is the length of the sliding time window in seconds.
     A check is performed conceptually in every interval [time-window, time].</li>

<li> Property output <b>y</b> is of enumeration type 
     <a href=\"modelica://Modelica_Requirements.Types.Property\">Property</a>.
     If the check is successful, y = Property.Satisfied. If the check fails,
     y = Property.Violated. If neither of the two properties hold
     (for example when condition = false), y = Property.Undecided.<br>
     If Property.Undecided cannot occur, output y is a Boolean instead of a Property.</li>
</ul>
<p></p>
</html>
"));
end ChecksInSlidingWindow;
