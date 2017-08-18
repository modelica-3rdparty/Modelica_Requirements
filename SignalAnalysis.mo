within Modelica_Requirements;
package SignalAnalysis
  "Library of signal analysis blocks to compute properties from Real signals"
  extends Modelica.Icons.Package;

  block ExactDerivative
    "Output is the analytic derivative of the input (= exact derivative)"

    Modelica.Blocks.Interfaces.RealInput u "Real input signal" annotation (Placement(transformation(extent={{-90,-20},
              {-50,20}}), iconTransformation(extent={{-90,-20},{-50,20}})));
    Modelica.Blocks.Interfaces.RealOutput y "Derivative of the input signal" annotation (Placement(transformation(extent={{50,-10},
              {70,10}}), iconTransformation(extent={{50,-10},{70,10}})));
  equation
    y = der(u);

     annotation (defaultComponentName="der1",Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
          graphics={
          Rectangle(
            extent={{-50,50},{50,-50}},
            lineColor={0,0,0},
            lineThickness=5.0,
            fillColor={210,210,210},
            fillPattern=FillPattern.Solid,
            borderPattern=BorderPattern.Raised),
          Text(
            extent={{-150,100},{150,60}},
            lineColor={175,175,175},
            textString="%name"),
          Text(
            extent={{-50,15},{50,-15}},
            lineColor={0,0,0},
            fillColor={245,245,245},
            fillPattern=FillPattern.Solid,
            textString="der")}),
      Documentation(info="<html>
<h4>Syntax</h4>

<blockquote><p>
der_u = <b>ExactDerivative</b>(u=...).y;
</p></blockquote>

<h4>Description</h4>

<p>
Real output <b>y</b> is the exact (analytic) derivative of the input <b>u</b>.
This is achieved by using the Modelica operator <b>der</b>(..).
This block will only work, if the tool is able to \"somehow\" determine the
analytic derivative of the input u (for example, either der(u) is computed
already somewhere else, or a tool is able to differentiate u analytically).
If this fails, or if this is not practical, for example with measurement data,
then use the blocks that compute a derivative in an approximate way:
<a href=\"modelica://Modelica_Requirements.SignalAnalysis.ApproximateDerivativeWithFilter\">ApproximateDerivativeWithFilter</a> or
<a href=\"modelica://Modelica_Requirements.SignalAnalysis.ApproximateDerivativeWithWindow\">ApproximateDerivativeWithWindow</a>.
</p>

<h4>Example</h4>

<p>
This block is demonstrated with the following
<a href=\"modelica://Modelica_Requirements.Examples.Elementary.SignalAnalysis.Derivatives\">example</a>: 
</p>

<p><blockquote>
<img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/Elementary/SignalAnalysis/Derivatives1.png\">
</blockquote></p>

<p>
that compares different ways to compute a derivative. Simulation results in:
</p>

<table border=0 cellspacing=0 cellpadding=2>
<tr><td width=\"50\"></td>
    <td valign=\"bottom\"><img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/Elementary/SignalAnalysis/Derivatives2.png\"></td>
    </tr>

<tr><td></td>
    <td align=\"center\">simulation result</td>
   </tr>
</table>

<p>
Note, the approximate derivatives have a large error at the start of the simulation, because
no information about the derivative of the signal is known. For this reason, the
ApproximateDerivativeWithFilter block starts, for example, with steady-state (so zero derivative), and then
needs some time until the approximation of the derivative is fine.
</p>
</html>"));
  end ExactDerivative;

  block ApproximateDerivativeWithFilter
    "Output is the filtered derivative of the input (= approximate derivative)"
    parameter Modelica.SIunits.Frequency f_cut "Cut-off frequency of filter";
    parameter Integer order=2 "Order of filter";

    Modelica.Blocks.Continuous.Filter filter(
      analogFilter=Modelica.Blocks.Types.AnalogFilter.CriticalDamping,
      order=order,
      f_cut=f_cut)   annotation (Placement(transformation(extent={{-39,-10},{-19,10}})));
    Modelica.Blocks.Interfaces.RealInput u "Real input signal"
      annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
    ExactDerivative derExact
      annotation (Placement(transformation(extent={{-6,-10},{14,10}})));
    Modelica.Blocks.Interfaces.RealOutput y
      "Real output signal (= approximative derivative of input u)"
      annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  equation
    connect(filter.u, u) annotation (Line(
        points={{-41,0},{-120,0}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(filter.y, derExact.u) annotation (Line(
        points={{-18,0},{-3,0}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(derExact.y, y) annotation (Line(
        points={{10,0},{110,0}},
        color={0,0,127},
        smooth=Smooth.None));
    annotation (defaultComponentName="approxDer1",Diagram(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics), Icon(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics={
         Rectangle(
            extent={{-100,100},{101,-100}},
            lineColor={0,0,0},
            lineThickness=5.0,
            fillColor={210,210,210},
            fillPattern=FillPattern.Solid,
            borderPattern=BorderPattern.Raised),
          Rectangle(
            extent={{-90,45},{90,-5}},
            lineColor={0,0,0},
            lineThickness=5.0,
            fillColor={245,245,245},
            fillPattern=FillPattern.Solid,
            borderPattern=BorderPattern.Sunken),
          Text(
            extent={{-90,75},{90,50}},
            lineColor={95,95,95},
            fillColor={210,210,210},
            fillPattern=FillPattern.Solid,
            textString="f_cut",
            horizontalAlignment=TextAlignment.Left),
          Text(
            extent={{-90,35},{90,5}},
            lineColor={0,0,0},
            fillColor={210,210,210},
            fillPattern=FillPattern.Solid,
            textString="%f_cut Hz"),             Text(
            extent={{-150,110},{150,150}},
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
            textString="%order"),
          Text(
            extent={{-90,-10},{90,-35}},
            lineColor={95,95,95},
            fillColor={210,210,210},
            fillPattern=FillPattern.Solid,
            horizontalAlignment=TextAlignment.Left,
            textString="order"),
          Text(
            extent={{-90,95},{90,65}},
            lineColor={0,0,0},
            fillColor={210,210,210},
            fillPattern=FillPattern.Solid,
            textString="der")}),
      Documentation(info="<html>
<h4>Syntax</h4>

<blockquote><p>
der_u = <b>ApproximateDerivativeWithFilter</b>(u=..., f_cut=..., order=2).y;
</p></blockquote>

<h4>Description</h4>

<p>
Real output <b>y</b> is the approximate derivative of the input <b>u</b>.
This is achieved by first filtering the input with a low pass critical damping
filter and then differentiating the filter output analytically
(with the effect that some combinations of filter states are used as
approximate derivative). This block requires to define two parameters:
<b>f_cut</b> the cut-off frequency of the filter in Hz and
<b>order</b> the order of the filter (default of order=2).
The larger the cut-off frequency, the smaller the approximation error.
On the other hand, if the input signal is from measurements, then the
cut-off frequency should be not too large to remove unwanted signal noise
by the filter. The order of the filter defines the \"steepness\" of the
frequency response and therefore a larger order reduces the effect
of frequencies in the input that are above f_cut.
</p>

<p>
Alternatively, derivatives might be computed with the following blocks:
<a href=\"modelica://Modelica_Requirements.SignalAnalysis.ExactDerivative\">ExactDerivative</a> or
<a href=\"modelica://Modelica_Requirements.SignalAnalysis.ApproximateDerivativeWithWindow\">ApproximateDerivativeWithWindow</a>.
</p>

<h4>Example</h4>

<p>
This block is demonstrated with the following
<a href=\"modelica://Modelica_Requirements.Examples.Elementary.SignalAnalysis.Derivatives\">example</a>: 
</p>

<p><blockquote>
<img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/Elementary/SignalAnalysis/Derivatives1.png\">
</blockquote></p>

<p>
that compares different ways to compute a derivative. Simulation results in:
</p>

<table border=0 cellspacing=0 cellpadding=2>
<tr><td width=\"50\"></td>
    <td valign=\"bottom\"><img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/Elementary/SignalAnalysis/Derivatives2.png\"></td>
    </tr>

<tr><td></td>
    <td align=\"center\">simulation result</td>
   </tr>
</table>

<p>
Note, the approximate derivatives have a large error at the start of the simulation, because
no information about the derivative of the signal is known. For this reason, the
ApproximateDerivativeWithFilter block starts, for example, with steady-state (so zero derivative), and then
needs some time until the approximation of the derivative is fine.
</p>
</html>"));
  end ApproximateDerivativeWithFilter;

  block ApproximateDerivativeWithWindow
    "Output is the finite difference quotient of the input (= approximate derivative)"
    parameter Modelica.SIunits.Time dt(min=10*Modelica.Constants.eps)
      "Time difference used for difference quotient";
    Modelica.Blocks.Interfaces.RealInput u
      "Real input signal (shall be differentiated)"
      annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
    Modelica.Blocks.Interfaces.RealOutput y
      "Approximative derivative of u (computed via finite difference)"
      annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  equation
    y = (u - delay(u, dt))/dt;
    annotation (defaultComponentName="approxDer1",Diagram(coordinateSystem(preserveAspectRatio=false,
                                                                  extent={{-100,-100},{100,100}}),
                           graphics), Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}),           graphics={
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
            extent={{-90,-30},{90,0}},
            lineColor={0,0,0},
            textString="%dt s"),
          Text(
            extent={{-150,100},{150,60}},
            lineColor={175,175,175},
            textString="%name"),
          Text(
            extent={{-90,35},{90,10}},
            lineColor={95,95,95},
            fillColor={210,210,210},
            fillPattern=FillPattern.Solid,
            horizontalAlignment=TextAlignment.Left,
            textString="dt"),
          Text(
            extent={{-90,45},{90,15}},
            lineColor={0,0,0},
            fillColor={210,210,210},
            fillPattern=FillPattern.Solid,
            textString="der")}),
      Documentation(info="<html>
<h4>Syntax</h4>

<blockquote><p>
der_u = <b>ApproximateDerivativeWithWindow</b>(u=..., dt=...).y;
</p></blockquote>

<h4>Description</h4>

<p>
Real output <b>y</b> is the approximate derivative of the input <b>u</b>.
This is achieved by computing a backwards finite difference quotient:
</p>
<blockquote>
<pre>
y = (u - delay(u,dt)) / dt;
</pre>
</blockquote>
<p>
where parameter <b>dt</b> is the time increment for the finite difference
quotient and delay(u,dt) is the input signal u delayed by dt.
The smaller dt, the smaller the appropximation error.
</p>

<p>
Alternatively, derivatives might be computed with the following blocks:
<a href=\"modelica://Modelica_Requirements.SignalAnalysis.ExactDerivative\">ExactDerivative</a> or
<a href=\"modelica://Modelica_Requirements.SignalAnalysis.ApproximateDerivativeWithFilter\">ApproximateDerivativeWithFilter</a>.
If the input signal is from measurements, it is better to utilize
the <a href=\"modelica://Modelica_Requirements.SignalAnalysis.ApproximateDerivativeWithFilter\">ApproximateDerivativeWithFilter</a>
block to compute the derivative, since the signal noise in the measurement
is low pass filtered (and therefore this unwanted effect is considerably removed).
</p>

<h4>Example</h4>

<p>
This block is demonstrated with the following
<a href=\"modelica://Modelica_Requirements.Examples.Elementary.SignalAnalysis.Derivatives\">example</a>: 
</p>

<p><blockquote>
<img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/Elementary/SignalAnalysis/Derivatives1.png\">
</blockquote></p>

<p>
that compares different ways to compute a derivative. Simulation results in:
</p>

<table border=0 cellspacing=0 cellpadding=2>
<tr><td width=\"50\"></td>
    <td valign=\"bottom\"><img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/Elementary/SignalAnalysis/Derivatives2.png\"></td>
    </tr>

<tr><td></td>
    <td align=\"center\">simulation result</td>
   </tr>
</table>

<p>
Note, the approximate derivatives have a large error at the start of the simulation, because
no information about the derivative of the signal is known. For this reason, the
ApproximateDerivativeWithFilter block starts, for example, with steady-state (so zero derivative), and then
needs some time until the approximation of the derivative is fine.
</p>
</html>"));
  end ApproximateDerivativeWithWindow;

  block TriggeredIntegrator
    "Output is the integral over the input, as long as the Boolean input active is true (for a rising edge of active the integrator state is reset to 0)"

    Modelica.Blocks.Interfaces.RealInput u "Input signal"
      annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
    Modelica.Blocks.Interfaces.RealOutput y
      "Output signal = if active then integral over input"
      annotation (Placement(transformation(extent={{100,-10},{120,10}})));
    Modelica.Blocks.Interfaces.BooleanInput active
      "Boolean input defining when integral shall be computed)" annotation (Placement(
          transformation(
          extent={{-20,-20},{20,20}},
          rotation=90,
          origin={0,-70})));
  initial equation
    y = 0;
  equation
    der(y) = if active then u else 0;

    when active then
       reinit(y,0);
    end when;
    annotation (defaultComponentName="integrator1",Icon(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics={
          Rectangle(
            extent={{-100,50},{100,-50}},
            lineColor={0,0,0},
            lineThickness=5,
            fillColor={215,215,215},
            fillPattern=FillPattern.Solid,
            borderPattern=BorderPattern.Raised),
          Text(
            extent={{-150,100},{150,60}},
            lineColor={175,175,175},
            textString="%name"), Polygon(
            points={{-70,36},{-78,14},{-62,14},{-70,36}},
            lineColor={135,135,135},
            fillColor={135,135,135},
            fillPattern=FillPattern.Solid),Line(points={{-70,36},{-70,-36}},
            color={135,135,135}),          Polygon(
            points={{84,-28},{62,-20},{62,-36},{84,-28}},
            lineColor={135,135,135},
            fillColor={135,135,135},
            fillPattern=FillPattern.Solid),Line(points={{-78,-28},{74,-28}},
            color={135,135,135}),
          Polygon(
            points={{-47,-28},{-47,17},{-44,22},{-39,28},{-35,31},{-35,-28},{-47,-28}},
            lineColor={135,135,135},
            fillColor={255,255,255},
            fillPattern=FillPattern.Backward),
          Polygon(
            points={{-5,-28},{-5,29},{0.5,26},{6,22},{10,19},{15,17},{18,16},{21,16},
                {24,17.5},{27,19.5},{28.5,21},{30,22.5},{32,23.5},{32,-28},{-5,-28}},
            lineColor={135,135,135},
            fillColor={255,255,255},
            fillPattern=FillPattern.Backward),
                                      Line(
            points={{-57,2},{-35,36},{-7,32},{19,12},{33,26},{59,32},{67,22},{67,20}},
            color={135,135,135},
            smooth=Smooth.Bezier)}),
                                   Diagram(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics),
      Documentation(info="<html>
<h4>Syntax</h4>

<blockquote><p>
integral_u = <b>TriggeredIntegrator</b>(u=..., active=...).y;
</p></blockquote>

<h4>Description</h4>

<p>
Real output <b>y</b> is the integral over the input <b>u</b>, that is y = integral(u*dt) whenever
the Boolean input <b>active</b> = true. Output y is initialized to zero.
When active has a rising edge, output y is re-initialized to zero.
</p>

<h4>Example</h4>

<p>
This block is demonstrated with the following
<a href=\"modelica://Modelica_Requirements.Examples.Elementary.SignalAnalysis.Integrator\">example</a>: 
</p>

<p><blockquote>
<img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/Elementary/SignalAnalysis/Integrator1.png\">
</blockquote></p>

<p>
results in
</p>

<table border=0 cellspacing=0 cellpadding=2>
<tr><td width=\"50\"></td>
    <td valign=\"bottom\"><img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/Elementary/SignalAnalysis/Integrator2.png\"></td>
    </tr>

<tr><td></td>
    <td align=\"center\">simulation result</td>
   </tr>
</table>
</html>"));
  end TriggeredIntegrator;

  block MovingAverage "Output is the continuous moving average of the input"
   extends Modelica_Requirements.Interfaces.PartialTriggeredMovingWindow;
  protected
    Real uFilt;
  initial equation
    uFilt = u;
  equation
    der(uFilt) = (u - delay(u,T))/T;

    y = if active then uFilt else 0;

    annotation (defaultComponentName="movAv1",Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}),
                           graphics={      Line(points={{-74,80},{-74,8}},
            color={135,135,135}),Polygon(
            points={{-74,80},{-82,58},{-66,58},{-74,80}},
            lineColor={135,135,135},
            fillColor={135,135,135},
            fillPattern=FillPattern.Solid),Polygon(
            points={{80,16},{58,24},{58,8},{80,16}},
            lineColor={135,135,135},
            fillColor={135,135,135},
            fillPattern=FillPattern.Solid),Line(points={{-82,16},{70,16}},
            color={135,135,135}),
          Polygon(
            points={{-9,16},{-9,73},{-3.5,70},{2,66},{6,63},{11,61},{14,60},{17,60},
                {20,61.5},{23,63.5},{24.5,65},{26,66.5},{28,67.5},{28,16},{-9,16}},
            lineColor={135,135,135},
            fillColor={255,255,255},
            fillPattern=FillPattern.Backward),
                                      Line(
            points={{-61,46},{-39,80},{-11,76},{15,56},{29,70},{55,76},{63,66},{63,
                64}},
            color={135,135,135},
            smooth=Smooth.Bezier),
          Text(
            extent={{28,60},{71,30}},
            lineColor={102,102,102},
            horizontalAlignment=TextAlignment.Right,
            textString="/ T"),
          Line(points={{28,92},{28,16}}, color={255,0,0})}),
      Documentation(info="<html>
<h4>Syntax</h4>

<blockquote><p>
u_filt = <b>MovingAverage</b>(u=..., active=...).y;
</p></blockquote>

<h4>Description</h4>

<p>
Real output <b>y</b> is the moving average over the input <b>u</b> as long as 
Boolean input <b>active</b> is true. If active = true, the output is computed as:
</p>

<p><blockquote>
<img src=\"modelica://Modelica_Requirements/Resources/Images/SignalAnalysis/MovingAverageFormula.png\">
</blockquote></p>

<h4>Example</h4>

<p>
This block is demonstrated with the following
<a href=\"modelica://Modelica_Requirements.Examples.Elementary.SignalAnalysis.MovingAverage\">example</a>: 
</p>

<p><blockquote>
<img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/Elementary/SignalAnalysis/MovingAverage1.png\">
</blockquote></p>

<p>
results in
</p>

<table border=0 cellspacing=0 cellpadding=2>
<tr><td width=\"50\"></td>
    <td valign=\"bottom\"><img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/Elementary/SignalAnalysis/MovingAverage2.png\"></td>
    </tr>

<tr><td></td>
    <td align=\"center\">simulation result</td>
   </tr>
</table>
</html>"));
  end MovingAverage;

  block TimeMonitoring
    "Output is the time duration where the Boolean input was true"

    Modelica.Blocks.Interfaces.BooleanInput u "Boolean input signal"
      annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));

    Modelica.Blocks.Interfaces.RealOutput y(quantity="Time", unit="s")
      "Real output signal = duration of input signal u being true"
      annotation (Placement(transformation(extent={{100,-10},{120,10}})));
    Modelica.Blocks.Logical.Timer timer annotation (Placement(transformation(extent={{-10,-10},
              {10,10}})));
  equation
    connect(timer.u, u)
      annotation (Line(points={{-12,0},{-120,0}},          color={255,0,255}));
    connect(timer.y, y)
      annotation (Line(points={{11,0},{58,0},{110,0}},        color={0,0,127}));
    annotation (defaultComponentName="timeMon1",Icon(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics={
          Rectangle(
            extent={{-100,50},{100,-50}},
            lineColor={0,0,0},
            lineThickness=5,
            fillColor={215,215,215},
            fillPattern=FillPattern.Solid,
            borderPattern=BorderPattern.Raised),
          Text(
            extent={{-150,100},{150,60}},
            lineColor={175,175,175},
            textString="%name"), Polygon(
            points={{-70,42},{-78,20},{-62,20},{-70,42}},
            lineColor={135,135,135},
            fillColor={135,135,135},
            fillPattern=FillPattern.Solid),Line(points={{-70,36},{-70,-41}},
            color={135,135,135}),          Polygon(
            points={{84,-34},{62,-26},{62,-42},{84,-34}},
            lineColor={135,135,135},
            fillColor={135,135,135},
            fillPattern=FillPattern.Solid),Line(points={{-78,-34},{74,-34}},
            color={135,135,135}),        Line(points={{-70,-24},{-34,-24},{-34,
                0},{34,0},{34,-24},{62,-24}},
                                  color={255,0,255}),Line(points={{-70,14},{-34,
                14},{34,40},{34,14},{62,14}},        color={0,0,255})}),
                                   Diagram(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics),
      Documentation(info="<html>
<h4>Syntax</h4>

<blockquote><p>
duration = <b>TimeMonitoring</b>(u=...).y;
</p></blockquote>

<h4>Description</h4>

<p>
Real output <b>y</b> is the duration in seconds, since the input <b>u</b> was true.
</p>

<h4>Example</h4>

<p>
This block is demonstrated with the following
<a href=\"modelica://Modelica_Requirements.Examples.Elementary.SignalAnalysis.TimeMonitoring\">example</a>: 
</p>

<p><blockquote>
<img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/Elementary/SignalAnalysis/TimeMonitoring1.png\">
</blockquote></p>

<p>
results in
</p>

<table border=0 cellspacing=0 cellpadding=2>
<tr><td width=\"50\"></td>
    <td valign=\"bottom\"><img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/Elementary/SignalAnalysis/TimeMonitoring2.png\"></td>
    </tr>

<tr><td></td>
    <td align=\"center\">simulation result</td>
   </tr>
</table>
</html>"));
  end TimeMonitoring;

  block CrossingMonitoring
    "Output is true for a positive threshold crossing of the input and false for a negative threshold crossing"
    parameter Real threshold = 0 "Threshold to define crossing";

    Modelica.Blocks.Interfaces.RealInput u "Real input signal"
      annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
    Modelica.Blocks.Interfaces.BooleanOutput y
      "Boolean output signal (= monitoring zero crossing of u)"                                           annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  protected
    Boolean b;
  initial equation
    y = u >= threshold and
        u <= threshold + max(10*Modelica.Constants.eps, abs(threshold)*10*Modelica.Constants.eps);
  equation
    b = u >= threshold;
    when b then
       y = true;
    elsewhen not b then
       y = false;
    end when;

    annotation (defaultComponentName="crossingMon1",Diagram(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}},
          grid={1,1})), Icon(coordinateSystem(
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
          Text(
            extent={{-150,150},{150,110}},
            lineColor={175,175,175},
            textString="%name"), Polygon(
            points={{-73,92},{-81,70},{-65,70},{-73,92}},
            lineColor={135,135,135},
            fillColor={135,135,135},
            fillPattern=FillPattern.Solid),Line(points={{-73,92},{-73,-2}},
            color={135,135,135}),          Line(points={{-82,6},{70,6}},
            color={135,135,135}),          Polygon(
            points={{91,6},{69,14},{69,-2},{91,6}},
            lineColor={135,135,135},
            fillColor={135,135,135},
            fillPattern=FillPattern.Solid),
                                      Line(
            points={{-71,21},{-49,76},{-21,55},{10,20},{23,73},{43,57},{52,32},{74,
                31}},
            color={135,135,135},
            smooth=Smooth.Bezier),
          Line(points={{-73,18},{-60,18},{-60,80},{-16,80},{-16,18},{17,18},{17,80},
                {45,80},{45,18},{75,18}},       color={255,0,255}),
          Rectangle(
            extent={{-90,-30},{90,-90}},
            lineColor={0,0,0},
            lineThickness=5.0,
            fillColor={245,245,245},
            fillPattern=FillPattern.Solid,
            borderPattern=BorderPattern.Sunken),
          Text(
            extent={{-90,-47},{90,-77}},
            lineColor={0,0,0},
            textString="%threshold"),      Line(points={{-81,49},{75,49}},
            color={135,135,135},
            pattern=LinePattern.Dot),
          Text(
            extent={{-80,0},{90,-25}},
            lineColor={102,102,102},
            textString="threshold",
            horizontalAlignment=TextAlignment.Left)}),
      Documentation(info="<html>
<h4>Syntax</h4>

<blockquote><p>
b = <b>CrossingMonitoring</b>(u=..., threshold = 0).y;
</p></blockquote>

<h4>Description</h4>

<p>
Whenever the Real input <b>u</b> crosses parameter <b>threshold</b> from negative to positive values, 
output <b>y</b> is set to true, and whenever u crosses threshold from positive to negative values,
y is set to false. The default value for the threshold = 0.
</p>

<h4>Example</h4>

<p>
This block is demonstrated with the following
<a href=\"modelica://Modelica_Requirements.Examples.Elementary.SignalAnalysis.CrossingMonitoring\">example</a>: 
</p>

<p><blockquote>
<img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/Elementary/SignalAnalysis/CrossingMonitoring1.png\">
</blockquote></p>

<p>
results in
</p>

<table border=0 cellspacing=0 cellpadding=2>
<tr><td width=\"50\"></td>
    <td valign=\"bottom\"><img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/Elementary/SignalAnalysis/CrossingMonitoring2.png\"></td>
    </tr>

<tr><td></td>
    <td align=\"center\">simulation result</td>
   </tr>
</table>
</html>"));
  end CrossingMonitoring;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}),
                   graphics={Line(
          points={{-90,-56},{-40,-28},{-32,64},{-6,64},{4,-54},{30,34},{42,-68},
              {62,-30},{86,62}},
          color={135,135,135},
          smooth=Smooth.Bezier)}));
end SignalAnalysis;
