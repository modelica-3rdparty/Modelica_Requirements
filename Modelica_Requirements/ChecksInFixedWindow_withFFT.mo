within Modelica_Requirements;
package ChecksInFixedWindow_withFFT
  "Library of check blocks that inspect properties in a fixed time window using FFT (Fast Fourier Transform)"
  extends Modelica.Icons.Package;

  model WithinAbsoluteDomain
    "A rising condition input triggers an FFT calculation. The amplitudes of the FFTs must be below a frequency dependent limit"
    extends Internal.PartialFFT;

    parameter Real maxAmplitude[:,2]
      "Maximum allowed amplitude: Real[:,2] array with [frequency in Hz, amplitude]";
    final parameter Real A_max_plot = 1.2*max(maxAmplitude[:,2]);
    final parameter Real maxAmplitudePlot[:,2] = Internal.maxAmplitudeCurveForIcon(maxAmplitude,A_max_plot,f_max_plot);
    final Real fA_plot[3*np,2](each start=0, each fixed=true)
      "[frequency, amplitude] matrix used for plotting in icon";

  equation
    when {iTick == ns, terminal() and time <= nextTime} then
       fA_plot             = Internal.amplitudeFrequencyCurveForIcon(A_buf,A_max_plot);
       (y, scaledDistance) = Internal.checkDomain(A_buf, f_max_plot, maxAmplitude, periods_ok);
    end when;

    annotation (defaultComponentName="fft_absoluteDomain1",Diagram(coordinateSystem(preserveAspectRatio=false,
            extent={{-300,-300},{300,300}})),           Icon(coordinateSystem(preserveAspectRatio=false,
            extent={{-300,-300},{300,300}}), graphics={
          Rectangle(
            extent={{-290,258},{-100,208}},
            lineColor={0,0,0},
            lineThickness=5.0,
            fillColor={245,245,245},
            fillPattern=FillPattern.Solid,
            borderPattern=BorderPattern.Sunken),
          Line(
            points=DynamicSelect({{-260,-230},{260,-230}},fA_plot), lineColor={0,0,0}),
          Line(
            points=DynamicSelect({{-260,140},{260,140}},maxAmplitudePlot), color={255,0,0}),
          Text(
            extent={{-252,-215},{-22,-245}},
            lineColor={0,0,255},
            horizontalAlignment=TextAlignment.Left,
            textString="0 Hz"),
          Text(
            extent={{50,-215},{280,-245}},
            lineColor={0,0,255},
            horizontalAlignment=TextAlignment.Right,
            textString=DynamicSelect("???", String(f_max_plot)) + " Hz"),
          Text(
            extent={{-240,185},{-15,155}},
            lineColor={0,0,255},
            horizontalAlignment=TextAlignment.Left,
            textString=DynamicSelect("???", String(A_max_plot))),
          Text(
            extent={{50,185},{280,155}},
            lineColor={0,0,255},
            horizontalAlignment=TextAlignment.Right,
            textString=DynamicSelect("???", String(time)) + " s"),
          Text(
            extent={{-290,288},{-100,263}},
            lineColor={95,95,95},
            textString="f_max"),
          Text(
            extent={{-290,243},{-100,213}},
            lineColor={0,0,0},
            textString="%f_max Hz"),
          Text(
            extent={{-90,288},{100,263}},
            lineColor={95,95,95},
            textString="f_resolution"),
          Rectangle(
            extent={{-90,258},{100,208}},
            lineColor={0,0,0},
            lineThickness=5.0,
            fillColor={245,245,245},
            fillPattern=FillPattern.Solid,
            borderPattern=BorderPattern.Sunken),
          Text(
            extent={{-90,243},{100,213}},
            lineColor={0,0,0},
            fillColor={255,0,0},
            fillPattern=FillPattern.Solid,
            textString="%f_resolution Hz")}),
      Documentation(info="<html>
<h4>Syntax</h4>

<blockquote><p>
property = <b>WithinAbsoluteFFTdomain</b>(condition=..., u=..., f_max=..., f_resolution=..., maxAmplitude=...).y;
</p></blockquote>

<h4>Description</h4>

<p>
Whenever the Boolean input <b>condition</b> has a rising edge,
the Real input <b>u</b> is sampled and stored in a buffer.
Once enough values of u are stored in the buffer
(depending on parameters <b>f_max</b> and <b>f_resolution</b>)
a Fast Fourier Transform (FFT) of the buffer u-values is computed.
The amplitudes and frequencies of the computed FFT are stored on file and displayed in the icon.
The ampltiudes must be below the polygon defined by parameter <b>maxAmplitude</b> (maxAmplitude[fi,Ai] defines
the maximum amplitude Ai at frequency point fi in [Hz]. fi &ge; 0 required). The check is performed in the range:
0 &le; f &le; min(f_max, maxAmplitude[end,1]) and the maxAmplitude values are linearly interpolated for this check.
</p>

<p>
For more details, see the description of package
<a href=\"Modelica_Requirements.ChecksInFixedWindow_withFFT\">ChecksInFixedWindow_withFFT</a>.
</p>


<h4>Example</h4>

<p>
This block is demonstrated with the following first
<a href=\"modelica://Modelica_Requirements.Examples.Elementary.ChecksInFixedWindow_withFFT.WithinAbsoluteDomain1\">example</a>: 
</p>

<p><blockquote>
<img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/Elementary/ChecksInFixedWindow_withFFT/WithinAbsoluteDomain1_example.png\">
</blockquote></p>

<p>
The amplitutes of the FFT are dynamically displayed in the icon of the block (in black), as well
as the maximume amplitudes maxAmplitude (in red).
</p>

<p><blockquote>
<img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/Elementary/ChecksInFixedWindow_withFFT/WithinAbsoluteDomain1_icon.png\">
</blockquote></p>

<p>
Simulating this examples results in
</p>

<table border=0 cellspacing=0 cellpadding=2>
<tr><td width=\"50\"></td>
    <td valign=\"bottom\"><img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/Elementary/ChecksInFixedWindow_withFFT/WithinAbsoluteDomain1_result.png\"></td>
    </tr>

<tr><td></td>
    <td align=\"center\">simulation result</td>
   </tr>
</table>

<p>
As can be seen, the simulation is terminate (via instance <b>terminate1</b> of block 
<a href=\"Modelica_Requirements.LogicalBlocks.FallingEdgeTerminate\">FallingEdgeTerminate</a>) once
the FFT has been computed (signaled via the falling edge of FFT_computation).
Since all FFT amplitudes between 0 &le; f &le; min(f_max, maxAmplitude[end,1]) are below the maximally allowed limit,
the block returns Property.Satisfied.
</p>

<p>
A plot of the FFT result file is shown in the next figure:
</p>

<p><blockquote>
<img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/Elementary/ChecksInFixedWindow_withFFT/WithinAbsoluteDomain1_FFT.png\">
</blockquote></p>

<p>
This block can be also used to compute several FFTs along a simulation as demonstrated with the following second
<a href=\"modelica://Modelica_Requirements.Examples.Elementary.ChecksInFixedWindow_withFFT.WithinAbsoluteDomain2\">example</a>: 
</p>

<p><blockquote>
<img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/Elementary/ChecksInFixedWindow_withFFT/WithinAbsoluteDomain2_example.png\">
</blockquote></p>

<p>
The amplitutes of the FFT are dynamically displayed in the icon of the block (in black), as well
as the maximume amplitudes maxAmplitude (in red). At the end of the simulation, one of the amplitudes
is larger as allowed:
</p>

<p><blockquote>
<img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/Elementary/ChecksInFixedWindow_withFFT/WithinAbsoluteDomain2_icon.png\">
</blockquote></p>

<p>
Simulating this examples results in
</p>

<table border=0 cellspacing=0 cellpadding=2>
<tr><td width=\"50\"></td>
    <td valign=\"bottom\"><img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/Elementary/ChecksInFixedWindow_withFFT/WithinAbsoluteDomain2_result.png\"></td>
    </tr>

<tr><td></td>
    <td align=\"center\">simulation result</td>
   </tr>
</table>

<p>
As can be seen, the first FFT fulfills the check (scaledDistance = 0), whereas the second FFT has amplitudes that are larger as allowed (scaledDistance = -0.1).
</p>
</html>", revisions="<html>
<table border=1 cellspacing=0 cellpadding=2>
<tr><th>Date</th> <th align=\"left\">Description</th></tr>

<tr><td valign=\"top\"> Nov. 29, 2015 </td>
    <td valign=\"top\">
     Initial version implemented by
     Martin R. Kuhn and Martin Otter 
     (<a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>)<br>  
     The research leading to these results has received funding from the European Union’s Seventh
     Framework Programme (FP7/2007-2016) for the Clean Sky Joint Technology Initiative under
     grant agreement no. CSJU-GAM-SGO-2008-001.</td></tr>
</table>
</html>"));
  end WithinAbsoluteDomain;

  model WithinRelativeDomain
    "A rising condition input triggers an FFT calculation. The amplitudes of the FFTs must be below a frequency dependent limit that is defined relative to the amplitude of the base frequency"
    extends Internal.PartialFFT;

    parameter Modelica.SIunits.Frequency f_base
      "Base frequency (100 % amplitude = largest amplitude around f_base)";
    parameter Real searchInterval(min=0, max=100) = 5
      "Search interval [%] around base frequency f_base for real base frequency (with largest amplitude)"
      annotation (Dialog(tab="Advanced"));
    parameter Real maxAmplitude[:,2]
      "Maximum allowed amplitude: Real[:,2] array with [frequency in Hz, amplitude[%]]";

    discrete Modelica.SIunits.Frequency f_base2
      "Real base frequency (frequency with largest amplitude around f_base)";
    discrete Real A_base2
      "Amplitude at the real base frequency (= largest amplitude around f_base)";
    discrete Real f_base2_line[2,2];
    discrete Real A_max_plot;
    discrete Real A_max_plot_perCent;
    discrete Real maxAmplitude2[size(maxAmplitude,1),2]
      "Maximum allowed amplitude: Real[:,2] array with [frequency in Hz, amplitude]";
    discrete Real maxAmplitudePlot[size(maxAmplitude,1),2];
  initial equation
    f_base2       = 0;
    A_base2       = 0;
    f_base2_line  = {{0,0},{0,0}};
    A_max_plot    = 0;
    maxAmplitude2 = zeros(size(maxAmplitude,1),2);
    maxAmplitudePlot = zeros(size(maxAmplitude,1),2);
  equation
    when {iTick == ns, terminal() and time <= nextTime} then
       (f_base2, A_base2)  = Internal.findBaseFrequency(f_resolution, f_base, searchInterval, A_buf);
       maxAmplitude2       = [maxAmplitude[:,1],maxAmplitude[:,2]*(A_base2/100)];
       A_max_plot          = max(maxAmplitude2[:,2]) + 0.1*A_base2;
       A_max_plot_perCent  = A_max_plot*100/A_base2;
       maxAmplitudePlot    = Internal.maxAmplitudeCurveForIcon(maxAmplitude2,A_max_plot,f_max_plot);
       f_base2_line        = Internal.baseAmplitudeForIcon(f_base2, f_max_plot, A_base2, A_max_plot);
       fA_plot             = Internal.amplitudeFrequencyCurveForIcon(A_buf, A_max_plot);
       (y, scaledDistance) = Internal.checkDomain(A_buf, f_max_plot, maxAmplitude2, periods_ok);
    end when;

    annotation (defaultComponentName="fft_relativeDomain1",Diagram(coordinateSystem(preserveAspectRatio=false,
            extent={{-300,-300},{300,300}})),           Icon(coordinateSystem(preserveAspectRatio=false,
            extent={{-300,-300},{300,300}}), graphics={
          Rectangle(
            extent={{-290,260},{-100,210}},
            lineColor={0,0,0},
            lineThickness=5.0,
            fillColor={245,245,245},
            fillPattern=FillPattern.Solid,
            borderPattern=BorderPattern.Sunken),
          Rectangle(
            extent={{110,260},{290,210}},
            lineColor={0,0,0},
            lineThickness=5.0,
            fillColor={245,245,245},
            fillPattern=FillPattern.Solid,
            borderPattern=BorderPattern.Sunken),
          Text(
            extent={{110,245},{290,215}},
            lineColor={0,0,0},
            textString="%f_base Hz"),
          Text(
            extent={{110,290},{290,265}},
            lineColor={95,95,95},
            textString="f_base"),
          Line(
            points=DynamicSelect({{-260,-230},{260,-230}},fA_plot), lineColor={0,0,0}),
          Line(
            points=DynamicSelect({{-260,140},{260,140}},maxAmplitudePlot), color={255,0,0}),
          Text(
            extent={{-252,-215},{-22,-245}},
            lineColor={0,0,255},
            horizontalAlignment=TextAlignment.Left,
            textString="0 Hz"),
          Text(
            extent={{50,-215},{280,-245}},
            lineColor={0,0,255},
            horizontalAlignment=TextAlignment.Right,
            textString=DynamicSelect("???", String(f_max_plot)) + " Hz"),
          Text(
            extent={{-240,185},{-15,155}},
            lineColor={0,0,255},
            horizontalAlignment=TextAlignment.Left,
            textString=DynamicSelect("???", String(A_max_plot_perCent,significantDigits=3)) + " %%"),
          Text(
            extent={{50,185},{280,155}},
            lineColor={0,0,255},
            horizontalAlignment=TextAlignment.Right,
            textString=DynamicSelect("???", String(time)) + " s"),
          Line(points=DynamicSelect({{0,0},{0,0}},f_base2_line),
               color={0,127,0},
               lineThickness=0.5),
          Text(
            extent={{-290,290},{-100,265}},
            lineColor={95,95,95},
            textString="f_max"),
          Text(
            extent={{-290,245},{-100,215}},
            lineColor={0,0,0},
            textString="%f_max Hz"),
          Text(
            extent={{-90,290},{100,265}},
            lineColor={95,95,95},
            textString="f_resolution"),
          Rectangle(
            extent={{-90,260},{100,210}},
            lineColor={0,0,0},
            lineThickness=5.0,
            fillColor={245,245,245},
            fillPattern=FillPattern.Solid,
            borderPattern=BorderPattern.Sunken),
          Text(
            extent={{-90,245},{100,215}},
            lineColor={0,0,0},
            fillColor={255,0,0},
            fillPattern=FillPattern.Solid,
            textString="%f_resolution Hz")}),
      Documentation(info="<html>
<h4>Syntax</h4>

<blockquote><p>
property = <b>WithinRelativeFFTdomain</b>(condition=..., u=..., f_max=..., f_resolution=..., f_base=...., maxAmplitude=...).y;
</p></blockquote>

<h4>Description</h4>

<p>
Whenever the Boolean input <b>condition</b> has a rising edge,
the Real input <b>u</b> is sampled and stored in a buffer.
Once enough values of u are stored in the buffer
(depending on parameters <b>f_max</b> and <b>f_resolution</b>)
a Fast Fourier Transform (FFT) of the buffer u-values is computed.
The amplitudes and frequencies of the computed FFT are stored on file and displayed in the icon.
The amplitudes must be below the polygon defined by parameter <b>maxAmplitude</b> (maxAmplitude[fi,Ai] defines
the maximum amplitude Ai in [% of amplitude at base frequency] at frequency point fi in [Hz]. fi &ge; 0 required). 
The amplitude of the base frequency is defined to be the largest amplitude of the computed FFT around the frequency:
</p>

<pre>   f_base - df &le; f &le; f_base + df</pre>

<p>
and the frequency difference <code>df</code> is computed from the advanced parameter
<b>searchInterfal</b> (default = 5 %) as:
</p>

<pre>   df = f_base*searchInterval/100</pre>

<p>
The check is performed in the range:
0 &le; f &le; min(f_max, maxAmplitude[end,1]) and the maxAmplitude values are linearly
interpolated for this check.
</p>

<p>
For more details, see the description of package
<a href=\"Modelica_Requirements.ChecksInFixedWindow_withFFT\">ChecksInFixedWindow_withFFT</a>.
</p>


<h4>Example</h4>

<p>
This block is demonstrated with the following first
<a href=\"modelica://Modelica_Requirements.Examples.Elementary.ChecksInFixedWindow_withFFT.WithinRelativeDomain1\">example</a>: 
</p>

<p><blockquote>
<img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/Elementary/ChecksInFixedWindow_withFFT/WithinRelativeDomain1_example.png\">
</blockquote></p>

<p>
The amplitutes of the FFT are dynamically displayed in the icon of the block (in black), as well
as the maximume amplitudes maxAmplitude (in red).
The computed amplitude of the base frequency is shown in green (so this amplitude is 100 %)
</p>

<p><blockquote>
<img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/Elementary/ChecksInFixedWindow_withFFT/WithinRelativeDomain1_icon.png\">
</blockquote></p>

<p>
Simulating this examples results in
</p>

<table border=0 cellspacing=0 cellpadding=2>
<tr><td width=\"50\"></td>
    <td valign=\"bottom\"><img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/Elementary/ChecksInFixedWindow_withFFT/WithinRelativeDomain1_result.png\"></td>
    </tr>

<tr><td></td>
    <td align=\"center\">simulation result</td>
   </tr>
</table>

<p>
As can be seen, the simulation is terminate (via instance <b>terminate1</b> of block 
<a href=\"Modelica_Requirements.LogicalBlocks.FallingEdgeTerminate\">FallingEdgeTerminate</a>) once
the FFT has been computed (signaled via the falling edge of FFT_computation).
Since all FFT amplitudes between 0 &le; f &le; min(f_max, maxAmplitude[end,1]) are below the maximally allowed limit,
the block returns Property.Satisfied.
</p>

<p>
A plot of the FFT result file is shown in the next figure:
</p>

<p><blockquote>
<img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/Elementary/ChecksInFixedWindow_withFFT/WithinRelativeDomain1_FFT.png\">
</blockquote></p>

<p>
This block can be also used to compute several FFTs along a simulation as demonstrated with the following second
<a href=\"modelica://Modelica_Requirements.Examples.Elementary.ChecksInFixedWindow_withFFT.WithinRelativeDomain2\">example</a>: 
</p>

<p><blockquote>
<img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/Elementary/ChecksInFixedWindow_withFFT/WithinRelativeDomain2_example.png\">
</blockquote></p>

<p>
The amplitutes of the FFT are dynamically displayed in the icon of the block (in black), as well
as the maximume amplitudes maxAmplitude (in red). At the end of the simulation, one of the amplitudes
is larger as allowed:
</p>

<p><blockquote>
<img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/Elementary/ChecksInFixedWindow_withFFT/WithinRelativeDomain2_icon.png\">
</blockquote></p>

<p>
Simulating this examples results in
</p>

<table border=0 cellspacing=0 cellpadding=2>
<tr><td width=\"50\"></td>
    <td valign=\"bottom\"><img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/Elementary/ChecksInFixedWindow_withFFT/WithinRelativeDomain2_result.png\"></td>
    </tr>

<tr><td></td>
    <td align=\"center\">simulation result</td>
   </tr>
</table>

<p>
As can be seen, the first FFT fulfills the check (scaledDistance = 0), whereas the second FFT has amplitudes that are larger as allowed (scaledDistance = -0.1).
</p>
</html>", revisions="<html>
<table border=1 cellspacing=0 cellpadding=2>
<tr><th>Date</th> <th align=\"left\">Description</th></tr>

<tr><td valign=\"top\"> Nov. 29, 2015 </td>
    <td valign=\"top\">
     Initial version implemented by
     Martin R. Kuhn and Martin Otter 
     (<a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>)<br>  
     The research leading to these results has received funding from the European Union’s Seventh
     Framework Programme (FP7/2007-2016) for the Clean Sky Joint Technology Initiative under
     grant agreement no. CSJU-GAM-SGO-2008-001.</td></tr>
</table>
</html>"));
  end WithinRelativeDomain;

  model MaxTotalHarmonicDistortion
    "A rising condition input triggers an FFT calculation. The Total Harmonic Distortion (THD) of the FFTs must be below the given limit."
    import Modelica_Requirements.Types.Property;
    extends Internal.PartialFFT(final f_max=n_harmonics*f_base);

    parameter Modelica.SIunits.Frequency f_base
      "Base frequency (100 % amplitude = largest amplitude around f_base)";
    parameter Integer n_harmonics=5
      "Number of harmonics to treat for THD (f_max = n_harmonics*f_base; sampling frequency >= 10*f_max)";
    parameter Real THDmax=0.1 "Total harmonic distortion limit";
    parameter Real searchInterval(min=0, max=100) = 5
      "Search interval [%] around base frequency f_base for real base frequency (with largest amplitude)"
      annotation (Dialog(tab="Advanced"));

    discrete Modelica.SIunits.Frequency f_base2
      "Real base frequency (frequency with largest amplitude around f_base)";
    discrete Real A_base2
      "Amplitude at the real base frequency (= largest amplitude around f_base)";
    discrete Real A_max_plot "Maximum amplitude of the FFT";
    discrete Real THD "THD value";
    discrete Real f_base2_line[2,2];
  protected
    discrete Integer index_base2(start=1, fixed=true);
  initial equation
    f_base2 = 0;
    A_base2 = 0;
    A_max_plot = 0;
    THD = 0;
    f_base2_line = {{0,0},{0,0}};
  equation
    when {iTick == ns, terminal() and time <= nextTime} then
       (f_base2, A_base2, index_base2) = Internal.findBaseFrequency(f_resolution, f_base, searchInterval, A_buf);
       A_max_plot     = max(A_buf);
       f_base2_line   = Internal.baseAmplitudeForIcon(f_base2, f_max_plot, A_base2, A_max_plot);
       fA_plot        = Internal.amplitudeFrequencyCurveForIcon(A_buf, A_max_plot);
       THD            = Internal.calculateTHD(index_base2, n_harmonics, A_buf);
       scaledDistance = THDmax-THD;
       y              = if scaledDistance >= 0 then
                            (if periods_ok then Property.Satisfied else Property.Undecided) else Property.Violated;
    end when;

    annotation (defaultComponentName="maxTHD1",Diagram(coordinateSystem(preserveAspectRatio=false,
            extent={{-300,-300},{300,300}})),           Icon(coordinateSystem(preserveAspectRatio=false,
            extent={{-300,-300},{300,300}}), graphics={
          Rectangle(
            extent={{-130,260},{-10,210}},
            lineColor={0,0,0},
            lineThickness=5.0,
            fillColor={245,245,245},
            fillPattern=FillPattern.Solid,
            borderPattern=BorderPattern.Sunken),
          Rectangle(
            extent={{-290,260},{-140,210}},
            lineColor={0,0,0},
            lineThickness=5.0,
            fillColor={245,245,245},
            fillPattern=FillPattern.Solid,
            borderPattern=BorderPattern.Sunken),
          Rectangle(
            extent={{0,260},{150,210}},
            lineColor={0,0,0},
            lineThickness=5.0,
            fillColor={245,245,245},
            fillPattern=FillPattern.Solid,
            borderPattern=BorderPattern.Sunken),
          Text(
            extent={{-290,245},{-140,215}},
            lineColor={0,0,0},
            textString="%f_base Hz"),
          Text(
            extent={{-290,290},{-150,265}},
            lineColor={95,95,95},
            textString="f_base"),
          Line(
            points=DynamicSelect({{-260,-230},{260,-230}},fA_plot), lineColor={0,0,0}),
          Text(
            extent={{-252,-215},{-22,-245}},
            lineColor={0,0,255},
            horizontalAlignment=TextAlignment.Left,
            textString="0 Hz"),
          Text(
            extent={{50,-215},{280,-245}},
            lineColor={0,0,255},
            horizontalAlignment=TextAlignment.Right,
            textString=DynamicSelect("???", String(f_max_plot)) + " Hz"),
          Text(
            extent={{-240,177},{-15,147}},
            lineColor={0,0,255},
            horizontalAlignment=TextAlignment.Left,
            textString=DynamicSelect("???", String(A_max_plot,significantDigits=3))),
          Text(
            extent={{50,185},{280,155}},
            lineColor={0,0,255},
            horizontalAlignment=TextAlignment.Right,
            textString=DynamicSelect("???", String(time)) + " s"),
          Text(
            extent={{50,125},{280,155}},
            lineColor={0,0,255},
            horizontalAlignment=TextAlignment.Right,
            textString="THD = " + DynamicSelect("???", String(THD,format=".3f"))),
          Line(points=DynamicSelect({{0,0},{0,0}},f_base2_line),
               color={0,127,0},
               lineThickness=0.5),
          Text(
            extent={{-150,290},{0,265}},
            lineColor={95,95,95},
            textString="n_harmonics"),
          Text(
            extent={{-130,245},{-10,215}},
            lineColor={0,0,0},
            textString="%n_harmonics"),
          Text(
            extent={{0,290},{150,265}},
            lineColor={95,95,95},
            textString="f_resolution"),
          Text(
            extent={{0,245},{150,215}},
            lineColor={0,0,0},
            fillColor={255,0,0},
            fillPattern=FillPattern.Solid,
            textString="%f_resolution Hz"),
          Rectangle(
            extent={{160,260},{290,210}},
            lineColor={0,0,0},
            lineThickness=5.0,
            fillColor={245,245,245},
            fillPattern=FillPattern.Solid,
            borderPattern=BorderPattern.Sunken),
          Text(
            extent={{160,245},{290,215}},
            lineColor={0,0,0},
            fillColor={255,0,0},
            fillPattern=FillPattern.Solid,
            textString="%THDmax"),
          Text(
            extent={{160,290},{290,265}},
            lineColor={95,95,95},
            textString="THDmax")}),
      Documentation(info="<html>
<h4>Syntax</h4>

<blockquote><p>
property = <b>MaxTotalHarmonicDistortion</b>(condition=..., u=..., f_resolution=..., f_base=...., n_harmonics=..., THDmax=...).y;
</p></blockquote>

<h4>Description</h4>

<p>
Whenever the Boolean input <b>condition</b> has a rising edge,
the Real input <b>u</b> is sampled and stored in a buffer.
Once enough values of u are stored in the buffer
(depending on parameters <b>f_base</b>, <b>n_harmonics</b> and <b>f_resolution</b>)
a Fast Fourier Transform (FFT) of the buffer u-values is computed.
The amplitudes and frequencies of the computed FFT are stored on file and displayed in the icon.
The Total Harmonic Distortion (THD) of the amplitudes must be below the given limit <b>THDmax</b> (in [%]).
The theoretical THD is defined as:
</p>

<pre>   THD_theoretical = sqrt( sum( A(i*f_base)^2 ) ) / A(f_base);  i = 2,3,...</pre>

<p>
where parameter <b>f_base</b> is the base frequency and A(f) is the amplitude at frequency f.
The THD is computed within this block by using the maximum amplitude within a small interval
around the higher harmonic frequencies (i*f_base; i=2,3,...).
</p>

<p>
After the FFT computation has been performed it is checked that the THD value is within
the required limit:
</p>

<pre>   THD &le; THDmax </pre>

<p>
where <b>THDmax</b> is the maximum allowed THD value. The default value is 0.1 (so 10 %).
</p>

<p>
For more details, see the description of package
<a href=\"Modelica_Requirements.ChecksInFixedWindow_withFFT\">ChecksInFixedWindow_withFFT</a>.
</p>


<h4>Example</h4>

<p>
This block is demonstrated with the following first
<a href=\"modelica://Modelica_Requirements.Examples.Elementary.ChecksInFixedWindow_withFFT.MaxTotalHarmonicDistortion1\">example</a>: 
</p>

<p><blockquote>
<img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/Elementary/ChecksInFixedWindow_withFFT/MaxTotalHarmonicDistortion1_example.png\">
</blockquote></p>

<p>
The amplitutes of the FFT are dynamically displayed in the icon of the block (in black).
The amplitude of the base frequency is shown in green.
</p>

<p><blockquote>
<img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/Elementary/ChecksInFixedWindow_withFFT/MaxTotalHarmonicDistortion1_icon.png\">
</blockquote></p>

<p>
Simulating this examples results in
</p>

<table border=0 cellspacing=0 cellpadding=2>
<tr><td width=\"50\"></td>
    <td valign=\"bottom\"><img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/Elementary/ChecksInFixedWindow_withFFT/MaxTotalHarmonicDistortion1_result.png\"></td>
    </tr>

<tr><td></td>
    <td align=\"center\">simulation result</td>
   </tr>
</table>

<p>
A plot of the FFT result file is shown in the next figure:
</p>

<p><blockquote>
<img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/Elementary/ChecksInFixedWindow_withFFT/MaxTotalHarmonicDistortion1_FFT.png\">
</blockquote></p>

<p>
This block can be also used to compute several FFTs along a simulation as demonstrated with the following second
<a href=\"modelica://Modelica_Requirements.Examples.Elementary.ChecksInFixedWindow_withFFT.MaxTotalHamonicDistortion2\">example</a>: 
</p>

<p><blockquote>
<img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/Elementary/ChecksInFixedWindow_withFFT/MaxTotalHarmonicDistortion2_example.png\">
</blockquote></p>

<p>
Since in the second FFT calculation the THD value is larger as THDmax, the icon is displayed
in light red.
</p>

<p><blockquote>
<img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/Elementary/ChecksInFixedWindow_withFFT/MaxTotalHarmonicDistortion2_icon.png\">
</blockquote></p>

<p>
Simulating this examples results in
</p>

<table border=0 cellspacing=0 cellpadding=2>
<tr><td width=\"50\"></td>
    <td valign=\"bottom\"><img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/Elementary/ChecksInFixedWindow_withFFT/MaxTotalHarmonicDistortion2_result.png\"></td>
    </tr>

<tr><td></td>
    <td align=\"center\">simulation result</td>
   </tr>
</table>

<p>
As can be seen, the first FFT fulfills the check (THD &lt; THDmax), whereas the second FFT has a too large THD value.
</p>
</html>",   revisions="<html>
<table border=1 cellspacing=0 cellpadding=2>
<tr><th>Date</th> <th align=\"left\">Description</th></tr>

<tr><td valign=\"top\"> Nov. 29, 2015 </td>
    <td valign=\"top\">
     Initial version implemented by
     Martin R. Kuhn and Martin Otter 
     (<a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>)<br>  
     The research leading to these results has received funding from the European Union’s Seventh
     Framework Programme (FP7/2007-2016) for the Clean Sky Joint Technology Initiative under
     grant agreement no. CSJU-GAM-SGO-2008-001.</td></tr>
</table>
</html>"));
  end MaxTotalHarmonicDistortion;

  package Internal
    "Library of internal components used by FFT blocks (should not be directly used)"
     extends Modelica.Icons.InternalPackage;

      partial model PartialFFT
      "Partial model containing the common part of the FFT blocks"
        import Modelica_Requirements.Types.Property;

        parameter Boolean storeFFTonFile=true
        "= true, if FFT results shall be stored on file <modelName>/FFT.<instanceName>.<index>.mat"
                                                                                       annotation(Evaluate=true, choices(checkBox=true));
        parameter Modelica.SIunits.Frequency  f_max
        "Maximum frequency of interest (sampling frequency >= 10*f_max)";
        parameter Modelica.SIunits.Frequency  f_resolution
        "Frequency resolution (frequency axis points are an integer multiple of f_resolution)";

        Modelica.Blocks.Interfaces.BooleanInput condition
        "Boolean input condition signal (a rising edge signals to store u-values in a buffer; if there are enough values in the buffer, an FFT is computed)"
                                                                                                            annotation (Placement(transformation(extent={{-340,180},{-300,220}})));
        Modelica.Blocks.Interfaces.RealInput u
        "Signal on which an FFT is performed"                                        annotation (Placement(
            transformation(extent={{-340,-20},{-300,20}})));

        Modelica_Requirements.Interfaces.PropertyOutput y
        "Property output signal (= Satisfied, if FFT Amplitudes of u are within maxAmplitude)"   annotation (Placement(transformation(extent={{300,-10},{320,10}})));
        Modelica.Blocks.Interfaces.BooleanOutput FFT_computation
        "= true, when u is stored in buffer for FFT computation"    annotation (Placement(transformation(extent={{300,190},{320,210}})));

        Modelica.Blocks.Interfaces.RealOutput scaledDistance
        "Minimum distance of FFT Amplitudes of u to maxAmplitude (>= 0 if inside, otherwise outside of maxAmplitude)"
                                                                                                          annotation (Placement(transformation(extent={{300,-210},{320,-190}})));

        final parameter Integer ns = Internal.get_ns(f_max, f_resolution)
        "Number of FFT sample points (is even and can be expressed as ns = 2^i*3^j*5^k)";
        final parameter Modelica.SIunits.Frequency f_max_FFT = f_resolution*div(ns, 2)
        "Maximum frequency used by FFT";
        final parameter Integer nf = div(ns,2) + 1 "Number of frequency points";
        final parameter Modelica.SIunits.Time Ts = 1/(2*f_max_FFT)
        "Sample period";
        final parameter Modelica.SIunits.Time T = (ns - 1)*Ts
        "Simulation time for one FFT calculation";
        Boolean periods_ok
        "= true, if all periods for FFT computations have been long enough";

        final parameter Integer np = max(1,min(integer(ceil(f_max/f_resolution))+1,nf))
        "Number of frequency points used for plotting (only up to interested frequency";
        final parameter Modelica.SIunits.Frequency f_max_plot = (np-1)*f_resolution;
        Integer fillColor[3] = if scaledDistance >= 0 then {245,245,245} else {255,218,213};
        final Real fA_plot[3*np,2](each start=0, each fixed=true)
        "[frequency, amplitude] matrix used for plotting in icon";
    protected
        constant String instanceName =    getInstanceName();
        constant String resultDirectory = Modelica_Requirements.Internal.getFirstName(instanceName);
        constant String filePrefix =      "FFT." + Modelica_Requirements.Internal.removeFirstName(instanceName) + ".";

        Real u_buf[ns](each start=0, each fixed=true);
        Real A_buf[np](each start=0, each fixed=true);

        Real Tstart
        "Start time when condition became true and first value of u needs to be stored";
        Real nextTime "Next time to store u value";
        Integer iTick "Number of stored frequency value; starts at iTick=1";
        Boolean startFFT
        "First time instant where u shall be stored in buffer for FFT computation";
        Integer fileIndex "Index of file name (= i-th FFT calculation)";
      initial equation
        pre(condition)  = false;
        pre(Tstart)     = time - 1;
        pre(nextTime)   = time - 1;
        pre(iTick)      = -1;
        pre(periods_ok) = true;
        y               = Property.Undecided;
        scaledDistance  = 1;
        fileIndex       = 0;
      equation
        // Remove previous result files
        when initial() then
           Internal.removeFFTresultFiles(resultDirectory);
        end when;

        // Store u in internal buffer u_buf, if condition becomes true
        startFFT = condition and not pre(condition);
        when {initial(), condition, time >= pre(nextTime)} then
           Tstart   = if startFFT then time else pre(Tstart);
           iTick    = if startFFT then 1 else pre(iTick) + 1;
           nextTime = if iTick >= 1 and iTick < ns then Tstart+iTick*Ts else time-1;
           FFT_computation = iTick>=1 and iTick < ns;
        end when;

        // After the value of u is stored at the last sample point or when
        // the simulation is terminated and one or more u-values already stored,
        // perform an FFT computation
        when {iTick == ns, terminal() and time <= nextTime} then
           (A_buf, periods_ok) = Internal.fftScaled(u_buf, np, iTick, Ts, pre(periods_ok), instanceName);
           fileIndex           = pre(fileIndex) + 1;
           if storeFFTonFile and iTick > 1 then
              Internal.saveFFTonFile(resultDirectory, filePrefix, fileIndex, f_max_plot, A_buf, iTick);
           end if;
        end when;

      algorithm
        // Store actual value of u in buffer
        when {condition, time >= pre(nextTime)} then
          u_buf[iTick] := u;
        end when;

        annotation(Diagram(coordinateSystem(preserveAspectRatio=false,extent={{-300,-300},{300,300}})),
                    Icon(coordinateSystem(preserveAspectRatio=false,
                extent={{-300,-300},{300,300}}), graphics={
              Rectangle(
                extent={{-300,300},{300,-300}},
                lineColor={0,0,0},
                lineThickness=5.0,
                fillColor={210,210,210},
                fillPattern=FillPattern.Solid,
                borderPattern=BorderPattern.Raised),
              Rectangle(
                extent={{-290,200},{290,-290}},
                lineColor={0,0,0},
                lineThickness=5.0,
                fillColor=DynamicSelect({245,245,245},fillColor),
                fillPattern=FillPattern.Solid,
                borderPattern=BorderPattern.Sunken),
              Text(
                extent={{-350,310},{350,350}},
                lineColor={175,175,175},
                textString="%name"),
             Line(points={{-270,-260},{260,-260}}, color={195,195,195}),
             Polygon(
                points={{270,-260},{245,-250},{245,-270},{270,-260}},
                lineColor={195,195,195},
                fillColor={195,195,195},
                fillPattern=FillPattern.Solid),
              Polygon(
                points={{-260,180},{-270,155},{-250,155},{-260,180}},
                lineColor={195,195,195},
                fillColor={195,195,195},
                fillPattern=FillPattern.Solid),
              Line(points={{-260,-270},{-260,170}}, color={195,195,195})}),
          Documentation(revisions="<html>
<table border=1 cellspacing=0 cellpadding=2>
<tr><th>Date</th> <th align=\"left\">Description</th></tr>

<tr><td valign=\"top\"> Nov. 29, 2015 </td>
    <td valign=\"top\">
     Initial version implemented by
     Martin R. Kuhn and Martin Otter 
     (<a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>)<br>  
     The research leading to these results has received funding from the European Union’s Seventh
     Framework Programme (FP7/2007-2016) for the Clean Sky Joint Technology Initiative under
     grant agreement no. CSJU-GAM-SGO-2008-001.</td></tr>
</table>
</html>"));
      end PartialFFT;

    function amplitudeFrequencyCurveForIcon
      "Return amplitude = f(frequency) for icon animation"
       input Real A[:] "Amplitude to plot";
       input Real A_max "Maximum value to be shown";
       output Real line[3*size(A,1),2] "Line to be shown in icon";
    protected
       constant Real x_min = -260 "Minimum x-coordinate in icon";
       constant Real x_max =  260 "Maximum x-coordinate in icon";
       constant Real y_min = -260 "Minimum y-coordinate in icon";
       constant Real y_max =  160 "Maximum y-coordinate in icon";
       Integer nA = size(A,1);
       Real t;
       Real y;
    algorithm
       for i in 1:nA loop
          t := x_min + (x_max-x_min)*(i-1)/(nA-1);
          y := y_min + (y_max-y_min)*min(A[i],A_max)/A_max;
          line[1+3*(i-1):1+3*(i-1)+2,:] :=[t,y_min; t,y; t,y_min];
       end for;
      annotation (Documentation(revisions="<html>
<table border=1 cellspacing=0 cellpadding=2>
<tr><th>Date</th> <th align=\"left\">Description</th></tr>

<tr><td valign=\"top\"> Nov. 29, 2015 </td>
    <td valign=\"top\">
     Initial version implemented by
     Martin R. Kuhn and Martin Otter 
     (<a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>)<br>  
     The research leading to these results has received funding from the European Union’s Seventh
     Framework Programme (FP7/2007-2016) for the Clean Sky Joint Technology Initiative under
     grant agreement no. CSJU-GAM-SGO-2008-001.</td></tr>
</table>
</html>"));
    end amplitudeFrequencyCurveForIcon;

    function checkDomain "Check whether FFT is in required domain"
      import Modelica_Requirements.Types.Property;

      input Real A[:] "Amplitudes";
      input Modelica.SIunits.Frequency f_max "Frequency value of A[n]";
      input Real maxAmplitude[:,2] "Maximum amplitude";
      input Boolean periods_ok;
      output Modelica_Requirements.Types.Property property;
      output Real scaledDistance;
    protected
      Integer nA=size(A,1);
      Real    fMin, fMax;
      Real    df = f_max/(nA-1);
      Real    diff[:];
      Integer iMin, iMax;
      Real f[:];
    algorithm
      // Determine frequency domain that must be checked
      fMin :=max(0, maxAmplitude[1, 1]);
      fMax :=min(f_max, maxAmplitude[size(maxAmplitude,1), 1]);

      // Find points of frequency axis
      iMin :=max(integer(ceil(fMin/df))+1, 1);
      iMax :=min(integer(floor(fMax/df))+1, nA);

      // Compute difference
      f := linspace((iMin - 1)*df, (iMax - 1)*df, (iMax - iMin + 1));
      diff := interpolate(maxAmplitude*1.001, f) - A[iMin:iMax];

      // Compute scaled distance
      scaledDistance :=min(diff)/max(maxAmplitude[:, 2]);
      property :=if scaledDistance >= 0 then
                    (if periods_ok then Property.Satisfied else Property.Undecided) else Property.Violated;
      annotation (Documentation(revisions="<html>
<table border=1 cellspacing=0 cellpadding=2>
<tr><th>Date</th> <th align=\"left\">Description</th></tr>

<tr><td valign=\"top\"> Nov. 29, 2015 </td>
    <td valign=\"top\">
     Initial version implemented by
     Martin R. Kuhn and Martin Otter 
     (<a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>)<br>  
     The research leading to these results has received funding from the European Union’s Seventh
     Framework Programme (FP7/2007-2016) for the Clean Sky Joint Technology Initiative under
     grant agreement no. CSJU-GAM-SGO-2008-001.</td></tr>
</table>
</html>"));
    end checkDomain;

    function get_ns "Return number of sample points"
       input Modelica.SIunits.Frequency f_max "Maximum frequency of interest";
       input Modelica.SIunits.Frequency f_resolution "Frequency resolution";
       input Integer f_max_factor(min=1)=5
        "Maximum FFT frequency >= f_max*f_max_factor (sample frequency = 2*Maximum FFT Frequency)";
       output Integer ns
        "Number of sample points that can be expressed as ns = 2^i*3^j*5^k and ns is even";
    protected
       Integer ns1;
    algorithm
       // Check input arguments
       assert(f_resolution > 0, "f_resolution > 0 required");
       assert(f_max > f_resolution, "f_max > f_resolution required");

       // Compute best ns according to f_max*f_max_factor and f_resolution = roundAgainstInfinity(2*f_max*f_max_factor/f_resolution)
       ns1 :=2*integer(ceil(f_max*f_max_factor/f_resolution));

       // If necessary, enlarge ns1 so that it is even and can be expressed as 2^i*3^j*5^k
       ns :=if mod(ns1, 2) == 0 then ns1 else ns1 + 1;

       while true loop
          ns1 :=ns;
          while mod(ns1,2) == 0 loop ns1 :=div(ns1, 2);end while;
          while mod(ns1,3) == 0 loop ns1 :=div(ns1, 3);end while;
          while mod(ns1,5) == 0 loop ns1 :=div(ns1, 5);end while;

          if ns1 <= 1 then
             break;
          end if;
          ns :=ns + 2;
       end while;
      annotation (Documentation(revisions="<html>
<table border=1 cellspacing=0 cellpadding=2>
<tr><th>Date</th> <th align=\"left\">Description</th></tr>

<tr><td valign=\"top\"> Nov. 29, 2015 </td>
    <td valign=\"top\">
     Initial version implemented by
     Martin R. Kuhn and Martin Otter 
     (<a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>)<br>  
     The research leading to these results has received funding from the European Union’s Seventh
     Framework Programme (FP7/2007-2016) for the Clean Sky Joint Technology Initiative under
     grant agreement no. CSJU-GAM-SGO-2008-001.</td></tr>
</table>
</html>"));
    end get_ns;

    function interpolate
      "Interpolate polygon (abscissa values must be within polygon values)"
       input Real polygon[:,2];
       input Real u[:] "Evaluate polygon at u";
       output Real y[size(u,1)] "Interpolated value";
    protected
       Integer np = size(polygon,1);
       Integer nu = size(u,1);
       Real u1, u2, y1, y2;
       Integer j,k;
    algorithm
       j :=1;
       for i in 1:nu loop
          // Check input argument
          assert(u[i] >= polygon[1,1] and u[i] <= polygon[np,1], "u out of range");

          // Interpolate all u values (assuming polygon and u are monotonically increasing)
          for k in j+1:np loop
             if u[i] < polygon[k,1] then
                j:= k - 1;
                break;
             end if;
          end for;

          // Get interpolation data
          u1 := polygon[j,   1];
          u2 := polygon[j+1, 1];
          y1 := polygon[j,   2];
          y2 := polygon[j+1, 2];

          // Interpolate
          assert(u2 > u1, "Table index must be increasing");
          y[i] := y1 + (y2 - y1)*(u[i] - u1)/(u2 - u1);
       end for;
      annotation (Documentation(revisions="<html>
<table border=1 cellspacing=0 cellpadding=2>
<tr><th>Date</th> <th align=\"left\">Description</th></tr>

<tr><td valign=\"top\"> Nov. 29, 2015 </td>
    <td valign=\"top\">
     Initial version implemented by
     Martin R. Kuhn and Martin Otter 
     (<a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>)<br>  
     The research leading to these results has received funding from the European Union’s Seventh
     Framework Programme (FP7/2007-2016) for the Clean Sky Joint Technology Initiative under
     grant agreement no. CSJU-GAM-SGO-2008-001.</td></tr>
</table>
</html>"));
    end interpolate;

    function maxAmplitudeCurveForIcon
      "Return maxAmplitude = f(frequency) for icon animation in defined icon area"
       input Real A[:,2] "Amplitude to plot";
       input Real A_max "Maximum value to be shown";
       input Real f_max "Maximum frequency to be shown";
       output Real line[size(A,1),2] "Line to be shown in icon";

    protected
       constant Real x_min = -260 "Minimum x-coordinate in icon";
       constant Real x_max =  260 "Maximum x-coordinate in icon";
       constant Real y_min = -260 "Minimum y-coordinate in icon";
       constant Real y_max =  160 "Maximum y-coordinate in icon";

       Integer nA = size(A,1);
       Real f1;
       Real f2;
       Real Af;
    algorithm
       for i in 1:nA loop
          if A[i,1] <= f_max then
             line[i,1] := x_min + (x_max-x_min)*A[i,1]/f_max;
             line[i,2] := y_min + (y_max-y_min)*min(A[i,2],A_max)/A_max;
          elseif i > 1 then
             if A[i-1,1] < f_max then
                f1 :=A[i - 1, 1];
                f2 :=A[i, 1];
                Af :=A[i - 1, 2] + (A[i, 2] - A[i - 1, 2])*(f_max - f1)/(f2 - f1);
                line[i,1] := x_max;
                line[i,2] := y_min + (y_max-y_min)*min(Af,A_max)/A_max;
             else
                line[i,1] := line[i-1,1];
                line[i,2] := line[i-1,2];
             end if;
          else
             line[1,1] := 0;
             line[1,2] := A_max;
          end if;
       end for;
      annotation (Documentation(revisions="<html>
<table border=1 cellspacing=0 cellpadding=2>
<tr><th>Date</th> <th align=\"left\">Description</th></tr>

<tr><td valign=\"top\"> Nov. 29, 2015 </td>
    <td valign=\"top\">
     Initial version implemented by
     Martin R. Kuhn and Martin Otter 
     (<a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>)<br>  
     The research leading to these results has received funding from the European Union’s Seventh
     Framework Programme (FP7/2007-2016) for the Clean Sky Joint Technology Initiative under
     grant agreement no. CSJU-GAM-SGO-2008-001.</td></tr>
</table>
</html>"));
    end maxAmplitudeCurveForIcon;

    function saveFFTonFile "Save FFT computation on file"
       import Modelica.Utilities.Streams.print;
       input String resultDirectory "Directory where results shall be stored";
       input String filePrefix
        "First part of file name (= FFT.<instanceNamne>.)";
       input Integer fileIndex "Index of FFT computation";
       input Modelica.SIunits.Frequency f_max "Maximum frequency";
       input Real    A[:] "Amplitude";
       input Integer iTick;
    protected
       Integer nA = size(A,1);
       Real fA[3*size(A,1),2];
       Real f;
       String fileName;
    algorithm
       if iTick > 1 then
          // Create directory (if it does not yet exist)
          Modelica.Utilities.Files.createDirectory(resultDirectory);

          // Construct full path name
          fileName :=Modelica.Utilities.Files.fullPathName(resultDirectory + "/" + filePrefix + String(fileIndex) + ".mat");

          // Remove file, if it exists
          Modelica.Utilities.Files.removeFile(fileName);

          // Construct output matrix
          for i in 1:nA loop
             f := f_max*(i-1)/(nA-1);
             fA[1+3*(i-1):1+3*(i-1)+2,:] :=[f,0; f,A[i]; f,0];
          end for;

          // Write matrix on file and print message
          Modelica.Utilities.Streams.writeRealMatrix(fileName, "FFT", fA);
          print("... FFT results stored on file: " + fileName);
       end if;
      annotation (Documentation(revisions="<html>
<table border=1 cellspacing=0 cellpadding=2>
<tr><th>Date</th> <th align=\"left\">Description</th></tr>

<tr><td valign=\"top\"> Nov. 29, 2015 </td>
    <td valign=\"top\">
     Initial version implemented by
     Martin R. Kuhn and Martin Otter 
     (<a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>)<br>  
     The research leading to these results has received funding from the European Union’s Seventh
     Framework Programme (FP7/2007-2016) for the Clean Sky Joint Technology Initiative under
     grant agreement no. CSJU-GAM-SGO-2008-001.</td></tr>
</table>
</html>"));
    end saveFFTonFile;

    function set_u "Store one u value in buffer"
       input Real u_buf[:];
       input Integer iu;
       input Real u;
       output Real u_buf_modified[size(u_buf,1)] = u_buf;
    algorithm
       u_buf_modified[iu] :=u;
       annotation(Inline=true, Documentation(revisions="<html>
<table border=1 cellspacing=0 cellpadding=2>
<tr><th>Date</th> <th align=\"left\">Description</th></tr>

<tr><td valign=\"top\"> Nov. 29, 2015 </td>
    <td valign=\"top\">
     Initial version implemented by
     Martin R. Kuhn and Martin Otter 
     (<a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>)<br>  
     The research leading to these results has received funding from the European Union’s Seventh
     Framework Programme (FP7/2007-2016) for the Clean Sky Joint Technology Initiative under
     grant agreement no. CSJU-GAM-SGO-2008-001.</td></tr>
</table>
</html>"));
    end set_u;

    function fftScaled "Compute scaled FFT"
      import Modelica.Utilities.Streams.print;

      input Real u_buf[:] "Signal for which FFT shall be computed; (size(u_buf,1) MUST be EVEN and should be an integer multiple of 2,3,5, that is size(u_buf,1) = 2^a*3^b*5^c, with a,b,c Integer >= 0)";
      input Integer nf(min=1) "Number of frequency points that shall be returned in amplitudes and phases (typically: nf = max(1,min(integer(ceil(f_max/f_resolution))+1,nf_max))); the maximal possible value is nf_Max=div(size(u_buf,1),2)+1)";
      input Integer iTick "Number of sample points that have been stored in u_buf";
      input Modelica.SIunits.Time Ts "Sample period of FFT";
      input Boolean pre_periods_ok "Previous value of periods_ok";
      input String instanceName="???";
      output Real A_buf[nf];
      output Boolean periods_ok;
    protected
      Real A[div(size(u_buf,1),2)+1];
      Integer ns = size(u_buf,1);
      Real u_buf2[size(u_buf,1)];
      Real u_DC;
      Modelica.SIunits.Time T_req = (ns-1)*Ts
        "Required period for FFT computation";
      Modelica.SIunits.Time T_act = (iTick-1)*Ts
        "Actually used period for FFT computation";
      Integer info;
    algorithm
      periods_ok :=pre_periods_ok;
      if iTick < ns then
         // Buffer was not completely filled
         u_DC                := sum(u_buf[1:iTick]) / iTick;
         u_buf2[1:iTick]     := u_buf[1:iTick] - fill(u_DC, iTick);
         u_buf2[iTick+1:end] := zeros(ns-iTick);
         periods_ok          := false;

         print("<html><p style=\"font-family:Arial; font-weight:bold; color:blue;\">FFT of " + instanceName + " probably wrong because simulation time too short for f_resolution<br>" +
               "&nbsp;&nbsp;&nbsp; Required period for FFT computation: " + String(T_req) + " s<br>" +
               "&nbsp;&nbsp;&nbsp; Actual period for FFT computation: " + String(T_act) + " s</p></html>");
         /*
     print("... FFT probably wrong because simulation time too short for f_resolution\n" +
           "    Required period for FFT computation: " + String(T_req) + " s\n" +
           "    Actual period for FFT computation  : " + String(T_act) + " s");
     */
      else
         // Buffer is completely filled
         u_DC   := sum(u_buf)/ns;
         u_buf2 := u_buf - fill(u_DC,ns);
      end if;
      (info,A) := Modelica.Math.FastFourierTransform.Internal.rawRealFFT(u_buf2);
      assert(info==0,"FFT not computed; info = " + String(info));
      A_buf    := A[1:nf];
      A_buf[1] := u_DC;

      annotation (Documentation(revisions="<html>
<table border=1 cellspacing=0 cellpadding=2>
<tr><th>Date</th> <th align=\"left\">Description</th></tr>

<tr><td valign=\"top\"> Nov. 29, 2015 </td>
    <td valign=\"top\">
     Initial version implemented by
     Martin R. Kuhn and Martin Otter 
     (<a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>)<br>  
     The research leading to these results has received funding from the European Union’s Seventh
     Framework Programme (FP7/2007-2016) for the Clean Sky Joint Technology Initiative under
     grant agreement no. CSJU-GAM-SGO-2008-001.</td></tr>
</table>
</html>"));
    end fftScaled;

    function removeFFTresultFiles
      "Remove FFT results files of previous simulation runs of the current model (if they exist)"
      import Modelica.Utilities.Internal.FileSystem;
      import Modelica.Utilities.Strings;
      import Modelica.Utilities.Streams.print;

      input String resultDirectory
        "Existing directory where the results are stored";
    protected
      function removeFFTresultFiles2
         input String directory
          "Existing directory where the results are stored";
      protected
         Integer nFiles = FileSystem.getNumberOfFiles(directory);
         String files[nFiles] = FileSystem.readDirectory(directory,nFiles);
      algorithm
         for i in 1:nFiles loop
            // Determine whether file starts with "FFT."
            if Strings.length(files[i]) > 4 then
               if Strings.substring(files[i],1,4) == "FFT." then
                  // Remove file
                  Modelica.Utilities.Files.removeFile(directory + "/" + files[i]);
               end if;
            end if;
         end for;
      end removeFFTresultFiles2;

    algorithm
      if Modelica.Utilities.Files.exist(resultDirectory) then
         print("... Files FFT.* are removed in directory " +
               Modelica.Utilities.Files.fullPathName(resultDirectory));
         removeFFTresultFiles2(resultDirectory);
      end if;
      annotation (Documentation(revisions="<html>
<table border=1 cellspacing=0 cellpadding=2>
<tr><th>Date</th> <th align=\"left\">Description</th></tr>

<tr><td valign=\"top\"> Nov. 29, 2015 </td>
    <td valign=\"top\">
     Initial version implemented by
     Martin R. Kuhn and Martin Otter 
     (<a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>)<br>  
     The research leading to these results has received funding from the European Union’s Seventh
     Framework Programme (FP7/2007-2016) for the Clean Sky Joint Technology Initiative under
     grant agreement no. CSJU-GAM-SGO-2008-001.</td></tr>
</table>
</html>"));
    end removeFFTresultFiles;

    function prime235Factorization
      "Factorization of an integer in prime numbers 2,3,5"
      input Integer n;
      output Boolean success "= true, if factorization in 2,3,5 is possible";
      output Integer e2 "n = 2^e2*3^e3*5^e5";
      output Integer e3 "n = 2^e2*3^e3*5^e5";
      output Integer e5 "n = 2^e2*3^e3*5^e5";
    protected
      Integer ns1 = n;
    algorithm
      e2:=0;
      e3:=0;
      e5:=0;
      while mod(ns1,2) == 0 loop
         ns1 :=div(ns1, 2);
         e2 :=e2 + 1;
      end while;

      while mod(ns1,3) == 0 loop
         ns1 :=div(ns1, 3);
         e3 := e3+1;
      end while;

      while mod(ns1,5) == 0 loop
         ns1 :=div(ns1, 5);
         e5 :=e5 + 1;
      end while;

      success :=ns1 <= 1;
      annotation (Documentation(revisions="<html>
<table border=1 cellspacing=0 cellpadding=2>
<tr><th>Date</th> <th align=\"left\">Description</th></tr>

<tr><td valign=\"top\"> Nov. 29, 2015 </td>
    <td valign=\"top\">
     Initial version implemented by
     Martin R. Kuhn and Martin Otter 
     (<a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>)<br>  
     The research leading to these results has received funding from the European Union’s Seventh
     Framework Programme (FP7/2007-2016) for the Clean Sky Joint Technology Initiative under
     grant agreement no. CSJU-GAM-SGO-2008-001.</td></tr>
</table>
</html>"));
    end prime235Factorization;

    function getLastName "Get last name of a Modelica path name"
       import Modelica.Utilities.Strings;
       input String path;
       output String tail "= last part of path (after the last '.'";
    protected
       Integer startIndex;
       Integer endIndex;
    algorithm
       startIndex :=Strings.findLast(path, ".");
       if startIndex == 0 or startIndex >= Strings.length(path) then
          tail := path;
       else
          tail := Strings.substring(path, startIndex+1, Strings.length(path));
       end if;
      annotation (Documentation(revisions="<html>
<table border=1 cellspacing=0 cellpadding=2>
<tr><th>Date</th> <th align=\"left\">Description</th></tr>

<tr><td valign=\"top\"> Nov. 29, 2015 </td>
    <td valign=\"top\">
     Initial version implemented by
     Martin R. Kuhn and Martin Otter 
     (<a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>)<br>  
     The research leading to these results has received funding from the European Union’s Seventh
     Framework Programme (FP7/2007-2016) for the Clean Sky Joint Technology Initiative under
     grant agreement no. CSJU-GAM-SGO-2008-001.</td></tr>
</table>
</html>"));
    end getLastName;

    function findBaseFrequency
      "Find real base frequency (search around an interval of f_base for the largest amplitude"
      import Modelica.Utilities.Streams.print;
      input Modelica.SIunits.Frequency f_resolution;
      input Modelica.SIunits.Frequency f_base;
      input Real searchInterval "in [%] of f_base";
      input Real A_buf[:];
      output Modelica.SIunits.Frequency f_baseReal;
      output Real A_baseReal;
      output Integer index_baseReal;
    protected
      Integer nf = size(A_buf,1);
      Modelica.SIunits.Frequency f1;
      Modelica.SIunits.Frequency f2;
      Integer i1;
      Integer i2;
      Integer j;
      Real Aj;
    algorithm
      f1 := (100 - searchInterval)/100*f_base;
      f2 := (100 + searchInterval)/100*f_base;
      i1 := max(1,integer(floor(f1/f_resolution)) + 1);
      i2 := min(nf,integer(ceil(f1/f_resolution)) + 1);
      if i1 == i2 then
         i1 := min(1, i1 - 1);
         i2 := max(nf, i2 + 1);
      end if;

      j  := i1;
      Aj := A_buf[j];
      for i in i1+1:i2 loop
         if A_buf[i] > Aj then
            j  := i;
            Aj := A_buf[i];
         end if;
      end for;

      f_baseReal   := f_resolution*(j - 1);
      A_baseReal := Aj;
      index_baseReal := j;
      annotation (Documentation(revisions="<html>
<table border=1 cellspacing=0 cellpadding=2>
<tr><th>Date</th> <th align=\"left\">Description</th></tr>

<tr><td valign=\"top\"> Nov. 29, 2015 </td>
    <td valign=\"top\">
     Initial version implemented by
     Martin R. Kuhn and Martin Otter 
     (<a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>)<br>  
     The research leading to these results has received funding from the European Union’s Seventh
     Framework Programme (FP7/2007-2016) for the Clean Sky Joint Technology Initiative under
     grant agreement no. CSJU-GAM-SGO-2008-001.</td></tr>
</table>
</html>"));
    end findBaseFrequency;

    function calculateTHD
      "Compute Total Harmonic Distortion from amplitude of FFT"
      import Modelica.Utilities.Streams.print;
      input Integer iBase "A_buf[iBase] is computed base frequency";
      input Integer n_harmonics "Number of harmonics to take into account";
      input Real A_buf[:];
      output Real thd;
    protected
      Integer nf = size(A_buf,1);
      Integer di;
      Integer dj;
      Integer j0;
      Integer j1;
      Integer j2;
    algorithm
      thd := 0;
      di  := max(1, div(iBase,4));
      for i in 2:n_harmonics loop
         j0  := i*(iBase-1) "Index of higher harmonics frequency";
         dj  := div(i,2);
         j1  := 1 + max(j0-dj, j0-di);
         j2  := 1 + min(j0+dj, j0+di);
         thd := thd + max(A_buf[j1:min(j2,nf)])^2;
      end for;
      thd := sqrt(thd)/A_buf[iBase];

      annotation (Documentation(revisions="<html>
<table border=1 cellspacing=0 cellpadding=2>
<tr><th>Date</th> <th align=\"left\">Description</th></tr>

<tr><td valign=\"top\"> Nov. 29, 2015 </td>
    <td valign=\"top\">
     Initial version implemented by
     Martin R. Kuhn and Martin Otter 
     (<a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>)<br>  
     The research leading to these results has received funding from the European Union’s Seventh
     Framework Programme (FP7/2007-2016) for the Clean Sky Joint Technology Initiative under
     grant agreement no. CSJU-GAM-SGO-2008-001.</td></tr>
</table>
</html>"));
    end calculateTHD;

    function baseAmplitudeForIcon
      "Determine amplitude line of base frequency for icon"
      input Modelica.SIunits.Frequency f_baseReal;
      input Modelica.SIunits.Frequency f_max_plot;
      input Real A_f_baseReal;
      input Real A_max_plot "Maximum amplitude in %";
      output Real line[2,2];
    protected
      constant Real x_min = -260 "Minimum x-coordinate in icon";
      constant Real x_max =  260 "Maximum x-coordinate in icon";
      constant Real y_min = -260 "Minimum y-coordinate in icon";
      constant Real y_max =  160 "Maximum y-coordinate in icon";
      Real x;
      Real y;
    algorithm
      x    := x_min + (x_max - x_min)*f_baseReal/f_max_plot;
      y    := y_min + (y_max - y_min)*A_f_baseReal/A_max_plot;
      line := {{x,y_min},{x,y}};
      annotation (Documentation(revisions="<html>
<table border=1 cellspacing=0 cellpadding=2>
<tr><th>Date</th> <th align=\"left\">Description</th></tr>

<tr><td valign=\"top\"> Nov. 29, 2015 </td>
    <td valign=\"top\">
     Initial version implemented by
     Martin R. Kuhn and Martin Otter 
     (<a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>)<br>  
     The research leading to these results has received funding from the European Union’s Seventh
     Framework Programme (FP7/2007-2016) for the Clean Sky Joint Technology Initiative under
     grant agreement no. CSJU-GAM-SGO-2008-001.</td></tr>
</table>
</html>"));
    end baseAmplitudeForIcon;

    annotation (Documentation(revisions="<html>
<table border=1 cellspacing=0 cellpadding=2>
<tr><th>Date</th> <th align=\"left\">Description</th></tr>

<tr><td valign=\"top\"> Nov. 29, 2015 </td>
    <td valign=\"top\">
     Initial version implemented by
     Martin R. Kuhn and Martin Otter 
     (<a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>)<br>  
     The research leading to these results has received funding from the European Union’s Seventh
     Framework Programme (FP7/2007-2016) for the Clean Sky Joint Technology Initiative under
     grant agreement no. CSJU-GAM-SGO-2008-001.</td></tr>
</table>
</html>"));
  end Internal;
  annotation (Documentation(info="<html>
<p>
This library provides blocks that check properties based on 
<b>FFT</b> (Fast Fourier Transform) computations in <b>fixed time windows</b>.
An FFT determines the frequency content and amplitudes of a sampled, periodic signal,
and the blocks in this package check whether these frequencies and amplitudes fulfill
certain conditions.
The approach is to trigger the sampling of the periodic signal by a rising
edge of Boolean input variable <b>condition</b>, storing the
values in an internal buffer and computing the FFT once \"sufficient\"
values are available.
</p>

<p>
Other blocks performing checks in a <b>fixed time</b> window are provided in sublibrary
<a href=\"modelica://Modelica_Requirements.ChecksInFixedWindow\">ChecksInFixedWindow</a>.<br>
Blocks performing checks in a <b>sliding time</b> window are provided in sublibrary
<a href=\"modelica://Modelica_Requirements.ChecksInSlidingWindow\">ChecksInSlidingWindow</a>.
</p>

<p>
All blocks of this library have the following interfaces:
</p>

<ul>
<li> Real input <b>u</b>: The time signal on which the FFT computation is performed.
     This signal should be (at least approximately) periodic, after a rising
     edge of input <b>condition</b>.</li>

<li> Boolean input <b>condition</b>: Whenever condition has a <b>rising edge</b>
     an FFT computation is triggered. This means that the input signal u is
     sampled and the sampled values are stored in an internal buffer. Once 
     \"enough\" sample values are available, the FFT computation is performed.<br>
     If the simulation ends before enough samples values are stored,
     then the remaining buffer of the FFT computation is filled with
     zeros (\"zero-padding\"), an FFT computation is performed and a warning message
     is printed. If condition has a rising edge before the buffer of the previous FFT computation
     was filled, the buffer of the previous FFT computation is reset and no
     FFT computation takes place. Instead, u is newly sampled and stored in the internal
     buffer.<br>
     Whenever an FFT has been computed, the \"check\" of the respective block is evaluated.
     Note, condition is typically the output of a time locator from library
     <a href=\"modelica://Modelica_Requirements.TimeLocators\">TimeLocators</a>.</li>
    
<li> <a href=\"modelica://Modelica_Requirements.Types.Property\">Property</a> output <b>y</b>:
     If the check is successful, y = Property.Satisfied. If the check fails,
     y = Property.Violated. If neither of the two properties hold
     (for example before the first rising edge of input condition), y = Property.Undecided.</li>
     
<li> Real output <b>scaledDistance</b>: The (scaled) \"distance\" between the FFT
     and its allowed domain.<br>
     If y = Property.Undecided, scaledDistance = 1.<br>
     If y = Property.Satisfied, scaledDistance &ge; 0.<br>
     If y = Property.Violated, scaledDistance &lt; 0.<br>
     This signal can be used for example to formulate a constraint in 
     an optimization setup.</li>
          
<li> Boolean output <b>FFT_computation</b>: = true as long as input u is sampled
     and stored in an internal buffer. At the time instant where FFT_computation
     has a falling edge (changes from true to false), the FFT computation and 
     afterwards the check is performed. Property output y gets a new value and keeps
     it until a new FFT computation is performed. This output can for example be used
     to stop the simulation once the FFT computation is finished.
     It also gives an indication how long the sampling of the input u is performed,
     until enough values are available to compute the FFT in the required precision.
     </li>
</ul>

<p>
All blocks of this library have the following features:
</p>

<ul>
<li> The <b>maximum frequency</b> of interest <b>f_max</b> is either defined by
     a parameter, or is computed from other data. Internally, the FFT is computed
     with a frequency &ge; 10*f_max (more details see below).</li>
     
<li> The <b>frequency resolution f_resolution</b> is a parameter that defines
     the resolution of the frequency axis. In particular all frequency points are
     an integer multiple of f_resolution. For example if f_resolution = 0.1, then
     the frequency axis of the FFT is {0, 0.1, 0.2, 0.3, ...}. It is highly recommended
     that f_resolution is selected in such a way that the frequencies of interest
     (such as a base frequency of 50 Hz) can be expressed as an integer multiple of
     f_resolution. </li>

<li> The number of sample points of the FFT is not an input, but is computed as the smallest
     Integer number that fulfills the following conditions:
     <ul>
     <li> Maximum FFT frequency &ge; 10*f_max.</li>
     <li> Frequency axis resolution is f_resolution.</li>
     <li> The number of sample points can be expressed as 2^a*3^b*4^c*5^d
          (and a,b,c,d are appropriate Integers).</li>
     <li> The number of sample points is even.</li>
     </ul></li>
     Note, in the original publication about the efficient computation of FFT (Cooley and Tukey, 1965),
     the number of sample points must be 2^a. However, all newer FFT algorithms do not have
     this strong restriction and especially not the open source software
     <a href=\"http://sourceforge.net/projects/kissfft/\">KissFFT</a> from Mark Borgerding
    used in this package.</li>
</ul>

<p>
Before starting a simulation, the needed simulation time for the FFT is typically not known.
You can handle this in the following way:
</p>

<ul>
<li> If you just would like to determine an FFT of a signal, set the simulation time to a large value
     (say 100000 s) and terminate the simulation when output signal <b>FFT_computed</b>
     has a falling edge. You can use the block
     <a href=\"modelica://Modelica_Requirements.LogicalBlocks.FallingEdgeTerminate\">FallingEdgeTerminate</a>
     for this purpose.</li>

<li> Just use any simulation end time and inspect the result. If your simulation time is too short, 
     a warning message is printed (in the warning message the minimum needed simulation time is
     displayed). If your simulation time is too long, inspect signal <b>FFT_computed</b>
     (a falling edge indicates when the FFT was computed).</li>

<li> Use function <a href=\"modelica://Modelica.Math.FastFourierTransform.realFFTinfo\">realFFTinfo</a>
     to determine the minimum simulation time and other characteristics of the desired FFT computation
     beforehand. For example calling this function as:
     <pre>  realFFTinfo(f_max = 170, f_resolution = 0.3)</pre>
     results in the following output:
<pre>   ... Calculate FFT properties   
   Desired:
      f_max         = 170 Hz
      f_resolution  = 0.3 Hz
      f_max_factor  = 5
   Calculated:
      Number of sample points    = 5760 (= 2^7*3^2*5^1)
      Sampling frequency         = 1728 Hz (= 0.3*5760)
      Sampling period            = 0.000578704 s (= 1/1728)
      Maximum FFT frequency      = 864 Hz (= 0.3*5760/2; f={0,0.3,0.6,...,864} Hz)
      Number of frequency points = 2881 (= 5760/2+1)
      Simulation time            = 3.33275 s
</pre>
</li>
</ul>

<p>
In the icon of the blocks the last computed FFT is shown, see example in the next figure:
</p>

<p><blockquote>
<img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/Elementary/ChecksInFixedWindow_withFFT/IconAnimation.png\">
</blockquote></p>

<p>
The Boolean parameter <b>storeFFTonFile</b> defines whether the result of every
FFT computation is also stored on file (storeFFTonFile = true) or not.
By default, every FFT computation is stored on a separate file in MATLAB 4 binary
format. For example, if the FFT computation is performed in a model with the instance
name \"MyModel.Requirements.Rectifier.R2\", then in the current directoy the following
files will be stored (during initialization, all files FFT.* in directory MyModel are deleted
in order to remove potentially old results. If directory MyModel does not exist, it is created):
</p>

<pre>   MyModel
     FFT.Requirements.Rectifier.R2.1.mat   // first FFT
     FFT.Requirements.Rectifier.R2.2.mat   // second FFT
       ...
</pre>

<p>
All files consist of a matrix FFT[f,A] where the first column are the frequency values in [Hz]
and the second column are the amplitudes at the corresponding frequency.
The FFTs can be plotted with functions 
<a href=\"modelica://Modelica_LinearSystems2.Utilities.Plot.plot_FFT_fromFile\">plot_FFT_fromFile</a>,
<a href=\"modelica://Modelica_LinearSystems2.Utilities.Plot.plot_FFTs_of_model\">plot_FFTs_of_model</a>,
<a href=\"modelica://Modelica_LinearSystems2.Utilities.Plot.plot_FFTs_from_directory\">plot_FFTs_from_directory</a>.
For example, all FFTs of the last simulation run can be plotted by calling
function <a href=\"modelica://Modelica_LinearSystems2.Utilities.Plot.plot_FFTs_of_model\">plot_FFTs_of_model</a>.
The FFT plot of signal 
</p>
<pre>     y = 5 + 3*sin(2*pi*2) + 1.5*sin(2*pi*3)
</pre>
<p>
is shown in the next figure:
</p>

<p><blockquote>
<img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/Elementary/ChecksInFixedWindow_withFFT/WithinAbsoluteDomain1_FFT.png\">
</blockquote></p>

<p>
As can be seen, the mean value = 5 of y is present at f = 0 Hz. The amplitudes and frequencies of the two sin-functions are precisely reported in the plot.
This FFT was computed with f_resolution = 0.2 Hz.
</p>

<h4>References</h4>

<dl>
<dt>Mark Borgerding (2010):</dt>
<dd> <b>KissFFT, version 1.3.0</b>.
     <a href=\"http://sourceforge.net/projects/kissfft/\">http://sourceforge.net/projects/kissfft/</a>.
     <br>&nbsp;
     </dd>
     
<dt>James W. Cooley, John W. Tukey (1965):</dt>
<dd> <b>An algorithm for the machine calculation of complex Fourier series</b>.
     Math. Comput. 19: 297–301. doi:10.2307/2003354.
     <br>&nbsp;
     </dd>

<dt>Martin R. Kuhn (2011):</dt>
<dd> <b>Advanced generator design using pareto-optimization</b>.
     2011 IEEE Ninth International Conference on
     Power Electronics and Drive Systems (PEDS),
     pp. 1061 –1067, Dec. DOI: 10.1109/PEDS.2011.6147391.
     <br>&nbsp;
     </dd>

<dt>Martin R. Kuhn, Martin Otter, Tim Giese (2015):</dt>
<dd> <b>Model Based Specifications in Aircraft Systems Design</b>.
     Modelica 2015 Conference, Versailles, France,
     pp. 491-500, Sept.23-25, 2015.
     Download from:
     <a href=\"http://www.ep.liu.se/ecp/118/053/ecp15118491.pdf\">http://www.ep.liu.se/ecp/118/053/ecp15118491.pdf</a>
     </dd>
</dl>

</html>", revisions="<html>
<table border=1 cellspacing=0 cellpadding=2>
<tr><th>Date</th> <th align=\"left\">Description</th></tr>

<tr><td valign=\"top\"> Nov. 29, 2015 </td>
    <td valign=\"top\">
     Initial version implemented by
     Martin R. Kuhn and Martin Otter 
     (<a href=\"http://www.dlr.de/rmc/sr/en\">DLR Institute of System Dynamics and Control</a>)<br>  
     The research leading to these results has received funding from the European Union’s Seventh
     Framework Programme (FP7/2007-2016) for the Clean Sky Joint Technology Initiative under
     grant agreement no. CSJU-GAM-SGO-2008-001.</td></tr>
</table>
</html>"), Icon(graphics={
        Line(points={{-40,-26},{-40,-80}},color={175,175,175}),
        Line(points={{-2,42},{-2,-80}},   color={175,175,175}),
        Line(points={{38,0},{38,-80}},  color={175,175,175}),
        Line(
          points={{-90,-80},{-66,-80},{-66,66},{62,66},{62,-80},{88,-80}},
          color={0,0,0},
          smooth=Smooth.None)}));
end ChecksInFixedWindow_withFFT;
