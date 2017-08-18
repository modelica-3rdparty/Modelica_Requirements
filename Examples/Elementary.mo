within Modelica_Requirements.Examples;
package Elementary
  "Library of examples to demonstrate the features of single property functions/blocks using a graphical description"
    extends Modelica.Icons.ExamplesPackage;

  package Verify "Library of examples using Verify blocks"
    extends Modelica.Icons.ExamplesPackage;

    model Requirement
      "Example for Requirement (Property shall not be Violated)"
      import Modelica_Requirements;
       extends Modelica.Icons.Example;

      Modelica.Blocks.Sources.BooleanTable check(startValue=true, table={1.5,3.3,4.2})
        annotation (Placement(transformation(extent={{-88,20},{-68,40}})));
      Modelica_Requirements.Sources.PropertyConstant propertyConstant(c=Modelica_Requirements.Types.Property.Undecided)
        annotation (Placement(transformation(extent={{-80,-40},{-60,-20}})));
      inner Modelica_Requirements.Verify.PrintViolations printViolations
        annotation (Placement(transformation(extent={{40,62},{60,82}})));
      Modelica_Requirements.Verify.Requirement R_violated(text=
            "Input gives a violated requirement")
        annotation (Placement(transformation(extent={{0,20},{60,40}})));
      Modelica_Requirements.Verify.Requirement R_Satisfied(text=
            "Input gives a satisfied requirement")
        annotation (Placement(transformation(extent={{0,-10},{60,10}})));
      Modelica_Requirements.Verify.Requirement R_Undecided(text=
            "Input gives an undecided requirement")
        annotation (Placement(transformation(extent={{0,-40},{60,-20}})));

      Modelica_Requirements.LogicalBlocks.BooleanToProperty BtoP1
        annotation (Placement(transformation(extent={{-40,20},{-20,40}})));
      Modelica_Requirements.ChecksInFixedWindow.During during1(check=check.y)
        annotation (Placement(transformation(extent={{-52,-10},{-12,10}})));
    equation

      connect(propertyConstant.y, R_Undecided.property) annotation (Line(
          points={{-59,-30},{-2,-30}},
          color={255,0,128},
          smooth=Smooth.None));
      connect(check.y, BtoP1.u) annotation (Line(
          points={{-67,30},{-37,30}},
          color={255,0,255},
          smooth=Smooth.None));
      connect(BtoP1.y, R_violated.property) annotation (Line(
          points={{-24,30},{-2,30}},
          color={255,0,128},
          smooth=Smooth.None));
      connect(R_Satisfied.property, during1.y)
        annotation (Line(points={{-2,0},{-6,0},{-11,0}}, color={255,0,128}));
      connect(check.y, during1.condition) annotation (Line(points={{-67,30},{
              -67,30},{-60,30},{-60,0.1},{-54,0.1}}, color={255,0,255}));
      annotation (experiment(StopTime=5), Documentation(info="<html>
<p>
Using the <a href=\"modelica://Modelica_Requirements.Verify.Requirement\">Requirement</a> block as
</p>

<p><blockquote>
<img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/Elementary/Verify/Requirement1.png\">
</blockquote></p>

<p>
results in
</p>

<table border=0 cellspacing=0 cellpadding=2>
<tr><td width=\"50\"></td>
    <td valign=\"bottom\"><img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/Elementary/Verify/Requirement2.png\"></td>
    </tr>
<tr><td></td>
    <td align=\"center\">simulation result</td>
   </tr>
</table>
<p>
and gives the following output to the output window:
</p>

<blockquote>
<pre>
Requirements violated (1 of 3):
    (R_violated at 1.5 s): Input gives a violated requirement

Requirements untested (1 of 3):
    (R_Undecided): Input gives an undecided requirement

Requirements satisfied (1 of 3):
    (R_Satisfied): Input gives a satisfied requirement
</pre>
</blockquote>
</html>"),
        Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                {100,100}})));
    end Requirement;
  end Verify;

  package TimeLocators "Library of examples using TimeLocators blocks"
      extends Modelica.Icons.ExamplesPackage;

    model Every
      "Example for Every (output is true, during every interval for a defined duration)"
       extends Modelica.Icons.Example;

      Modelica_Requirements.TimeLocators.Every every(interval=2, duration=0.5)
        annotation (Placement(transformation(extent={{-80,40},{-40,60}})));
      annotation (experiment(StopTime=11),Documentation(info="<html>
<p>
Using time locator block <a href=\"modelica://Modelica_Requirements.TimeLocators.Every\">Every</a> as
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
</html>
"),     Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics));
    end Every;

    model Until
      "Example for Until (output is true, until first rising edge of input)"
       extends Modelica.Icons.Example;

      Modelica.Blocks.Sources.BooleanPulse pulse1(period=2)
        annotation (Placement(transformation(extent={{-80,40},{-60,60}})));
      Modelica.Blocks.Sources.BooleanPulse pulse2(period=2, startTime=3)
        annotation (Placement(transformation(extent={{-80,0},{-60,20}})));

      Modelica_Requirements.TimeLocators.Until until1(u=pulse1.y)
        annotation (Placement(transformation(extent={{-40,40},{0,60}})));
      Modelica_Requirements.TimeLocators.Until until2(u=pulse2.y)
        annotation (Placement(transformation(extent={{-40,0},{0,20}})));
      annotation (experiment(StopTime=8), Documentation(info="<html>
<p>
Using time locator block <a href=\"modelica://Modelica_Requirements.TimeLocators.Until\">Until</a> as
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
</html>
"),     Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics));
    end Until;

    model After
      "Example for After (output is true, after first rising edge of input)"
       extends Modelica.Icons.Example;

      Modelica.Blocks.Sources.BooleanPulse pulse1(period=2)
        annotation (Placement(transformation(extent={{-80,40},{-60,60}})));
      Modelica.Blocks.Sources.BooleanPulse pulse2(period=2, startTime=3)
        annotation (Placement(transformation(extent={{-80,0},{-60,20}})));

      Modelica_Requirements.TimeLocators.After after1(u=pulse1.y)
        annotation (Placement(transformation(extent={{-40,40},{0,60}})));
      Modelica_Requirements.TimeLocators.After after2(u=pulse2.y)
        annotation (Placement(transformation(extent={{-40,0},{0,20}})));
      annotation (experiment(StopTime=8), Documentation(info="<html>
<p>
Using time locator block <a href=\"modelica://Modelica_Requirements.TimeLocators.After\">After</a> as
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
</html>
"),     Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics));
    end After;

    model AfterFor
      "Example for AfterFor (output is true, after rising edge of input for defined duration)"
       extends Modelica.Icons.Example;

      Modelica_Requirements.TimeLocators.AfterFor afterFor(duration=1, u=timeTable.y)
        annotation (Placement(transformation(extent={{-40,40},{0,60}})));
      Modelica.Blocks.Sources.BooleanTable timeTable(table={1,3,5,5.2,9,9.2,9.5,9.7},
          startValue=false)
        annotation (Placement(transformation(extent={{-80,40},{-60,60}})));
      annotation (experiment(StopTime=12),Documentation(info="<html>
<p>
Using time locator block <a href=\"modelica://Modelica_Requirements.TimeLocators.AfterFor\">AfterFor</a> as
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
</html>
"),     Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics));
    end AfterFor;

    model AfterUntil
      "Example for AfterUntil (output is true, after rising edge of input u1 until rising edge of input u2)"
       extends Modelica.Icons.Example;

      Modelica.Blocks.Sources.BooleanPulse pulse1(period=2)
        annotation (Placement(transformation(extent={{-80,40},{-60,60}})));
      Modelica.Blocks.Sources.BooleanPulse pulse2(          startTime=3, period=1.5)
        annotation (Placement(transformation(extent={{-80,0},{-60,20}})));

      Modelica_Requirements.TimeLocators.AfterUntil afterUntil1(u1=pulse1.y,u2=pulse2.y)
        annotation (Placement(transformation(extent={{-40,40},{0,60}})));
      annotation (experiment(StopTime=8), Documentation(info="<html>
<p>
Using time locator block <a href=\"modelica://Modelica_Requirements.TimeLocators.AfterUntil\">AfterUntil</a> as
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
</html>
"),     Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics));

    end AfterUntil;
  end TimeLocators;

  package ChecksInFixedWindow
    "Library of examples using ChecksInFixedWindow blocks"
    model During
      "Example for During (in every true condition phase, check must be true)"
       extends Modelica.Icons.Example;

      Modelica.Blocks.Sources.BooleanTable condition(table={1,3,5,7,9,9.5,11,13},
          startValue=false)
        annotation (Placement(transformation(extent={{-80,40},{-60,60}})));
      Modelica.Blocks.Sources.BooleanTable check(startValue=false,
            table={0.5,2.5,5.5,8,9.1,10.5,11.5,12})
        annotation (Placement(transformation(extent={{-80,12},{-60,32}})));
      Modelica_Requirements.ChecksInFixedWindow.During during(check=check.y)
        annotation (Placement(transformation(extent={{-40,40},{0,60}})));
    equation
      connect(condition.y, during.condition) annotation (Line(
          points={{-59,50},{-50,50},{-50,50.1},{-42,50.1}},
          color={255,0,255},
          smooth=Smooth.None));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics), experiment(StopTime=14),
        Documentation(info="<html>
<p>
Using check block <a href=\"modelica://Modelica_Requirements.ChecksInFixedWindow.During\">During</a> as
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

    model MinDuration
      "Example for MinDuration (in every true condition phase, check must be true for at least the defined duration)"
       extends Modelica.Icons.Example;

      Modelica.Blocks.Sources.BooleanTable condition(table={1,3,5,7,9,9.5,11,13},
          startValue=false)
        annotation (Placement(transformation(extent={{-80,40},{-60,60}})));
      Modelica.Blocks.Sources.BooleanTable check(startValue=false,
            table={0.5,2.5,5.2,5.4,5.6,5.8,6.0,8,9.1,10.5,11.5,12})
        annotation (Placement(transformation(extent={{-80,12},{-60,32}})));
      Modelica_Requirements.ChecksInFixedWindow.MinDuration minDuration(durationMin=1,
                check=check.y)
              annotation (Placement(transformation(extent={{-40,40},{0,60}})));
    equation
      connect(condition.y, minDuration.condition) annotation (Line(
          points={{-59,50},{-50,50},{-50,50.1},{-42,50.1}},
          color={255,0,255},
          smooth=Smooth.None));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics), experiment(StopTime=14),
        Documentation(info="<html>
<p>
Using check block <a href=\"modelica://Modelica_Requirements.ChecksInFixedWindow.MinDuration\">MinDuration</a> as
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
    extends Modelica.Icons.ExamplesPackage;

    model MaxDuration
      "Example for MaxDuration (in every true condition phase, check must be true for at most the defined duration)"
       extends Modelica.Icons.Example;

      Modelica.Blocks.Sources.BooleanTable condition(table={1,3,5,7,9,9.5,11,13},
          startValue=false)
        annotation (Placement(transformation(extent={{-80,40},{-60,60}})));
      Modelica.Blocks.Sources.BooleanTable check(startValue=false,
            table={0.5,2.5,5.2,5.4,5.6,5.8,6.0,8,9.1,10.5,11.5,12})
        annotation (Placement(transformation(extent={{-80,12},{-60,32}})));
      Modelica_Requirements.ChecksInFixedWindow.MaxDuration maxDuration(durationMax=1,
                check=check.y)
              annotation (Placement(transformation(extent={{-40,40},{0,60}})));
    equation
      connect(condition.y, maxDuration.condition) annotation (Line(
          points={{-59,50},{-50,50},{-50,50.1},{-42,50.1}},
          color={255,0,255},
          smooth=Smooth.None));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics), experiment(StopTime=14),
        Documentation(info="<html>
<p>
Using check block <a href=\"modelica://Modelica_Requirements.ChecksInFixedWindow.MaxDuration\">MaxDuration</a> as
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

    model BandDuration
      "Example for BandDuration (in every true condition phase, check must be true for at least a minimum duration and at most a maximum duration)"
       extends Modelica.Icons.Example;

      Modelica.Blocks.Sources.BooleanTable condition(table={1,3,5,7,9,9.5,11,13},
          startValue=false)
        annotation (Placement(transformation(extent={{-80,40},{-60,60}})));
      Modelica.Blocks.Sources.BooleanTable check(startValue=false,
            table={0.5,2.5,5.2,5.4,5.6,5.8,6.0,8,9.1,10.5,11.5,12})
        annotation (Placement(transformation(extent={{-80,12},{-60,32}})));
      Modelica_Requirements.ChecksInFixedWindow.BandDuration bandDuration1(
        check=check.y,
        durationMin=0.9,
        durationMax=1.3)
        annotation (Placement(transformation(extent={{-40,40},{0,60}})));
    equation
      connect(condition.y, bandDuration1.condition) annotation (Line(
          points={{-59,50},{-50,50},{-50,50.1},{-42,50.1}},
          color={255,0,255},
          smooth=Smooth.None));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics), experiment(StopTime=14),
        Documentation(info="<html>
<p>
Using check block <a href=\"modelica://Modelica_Requirements.ChecksInFixedWindow.BandDuration\">BandDuration</a> as
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

    model NoRising
      "Example for NoRising (in every true condition phase, no rising edge of check is allowed)"
       extends Modelica.Icons.Example;

      Modelica.Blocks.Sources.BooleanTable condition(table={1,2,3,3.5,4},
          startValue=false)
        annotation (Placement(transformation(extent={{-80,40},{-60,60}})));
      Modelica.Blocks.Sources.BooleanTable check(startValue=true, table={0.2,0.3,0.4,
            1.1,1.2,1.3,1.4,2.2,2.5,2.8,3.4,3.6,3.8})
        annotation (Placement(transformation(extent={{-80,10},{-60,30}})));
      Modelica_Requirements.ChecksInFixedWindow.NoRising noRising1(check=check.y)
        annotation (Placement(transformation(extent={{-40,40},{0,60}})));
    equation
      connect(condition.y, noRising1.condition) annotation (Line(
          points={{-59,50},{-50,50},{-50,50.1},{-42,50.1}},
          color={255,0,255},
          smooth=Smooth.None));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics), experiment(StopTime=5),
        Documentation(info="<html>
<p>
Using check block <a href=\"modelica://Modelica_Requirements.ChecksInFixedWindow.NoRising\">NoRising</a> as
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

    model FixedRising
      "Example for FixedRising (in every true condition phase, a defined number of check rising edges must occur)"
       extends Modelica.Icons.Example;

      Modelica.Blocks.Sources.BooleanTable condition(table={1,2,3,3.5,4},
          startValue=false)
        annotation (Placement(transformation(extent={{-80,40},{-60,60}})));
      Modelica.Blocks.Sources.BooleanTable check(startValue=true, table={0.2,0.3,0.4,
            1.1,1.2,1.3,1.4,2.2,2.5,3.1,3.15,3.2,3.25,3.3, 3.35,3.4,3.45,
            4.1,4.15,4.3,4.35,4.5,4.55,4.7,4.75,4.9,4.95})
        annotation (Placement(transformation(extent={{-80,10},{-60,30}})));
      Modelica_Requirements.ChecksInFixedWindow.FixedRising fixedRising1(check=check.y, nRising=4)
        annotation (Placement(transformation(extent={{-40,40},{0,60}})));
      Modelica_Requirements.ChecksInFixedWindow.FixedRising fixedRising2(check=check.y, nRising=
            0)
        annotation (Placement(transformation(extent={{-40,10},{0,30}})));
    equation
      connect(condition.y, fixedRising1.condition) annotation (Line(
          points={{-59,50},{-50,50},{-50,50.1},{-42,50.1}},
          color={255,0,255},
          smooth=Smooth.None));
      connect(condition.y, fixedRising2.condition) annotation (Line(
          points={{-59,50},{-50,50},{-50,20.1},{-42,20.1}},
          color={255,0,255},
          smooth=Smooth.None));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics), experiment(StopTime=5),
        Documentation(info="<html>
<p>
Using check block <a href=\"modelica://Modelica_Requirements.ChecksInFixedWindow.FixedRising\">FixedRising</a> as
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

    model MinRising
      "Example for MinRising (in every true condition phase, a minimum number of check rising edges must occur)"
       extends Modelica.Icons.Example;

      Modelica.Blocks.Sources.BooleanTable condition(table={1,2,3,3.5,4},
          startValue=false)
        annotation (Placement(transformation(extent={{-80,40},{-60,60}})));
      Modelica.Blocks.Sources.BooleanTable check(startValue=true, table={0.2,0.3,0.4,
            1.1,1.2,1.3,1.4,2.2,2.5,3.1,3.15,3.2,3.25,3.3, 3.35,3.4,3.45})
        annotation (Placement(transformation(extent={{-80,10},{-60,30}})));
      Modelica_Requirements.ChecksInFixedWindow.MinRising minRising1(check=check.y,
          nRisingMin=3)
        annotation (Placement(transformation(extent={{-40,40},{0,60}})));
    equation
      connect(condition.y, minRising1.condition) annotation (Line(
          points={{-59,50},{-50,50},{-50,50.1},{-42,50.1}},
          color={255,0,255},
          smooth=Smooth.None));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics), experiment(StopTime=5),
        Documentation(info="<html>
<p>
Using check block <a href=\"modelica://Modelica_Requirements.ChecksInFixedWindow.MinRising\">MinRising</a> as
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

    model MaxRising
      "Example for MaxRising (in every true condition phase, the number of check rising edges is bounded)"
       extends Modelica.Icons.Example;

      Modelica.Blocks.Sources.BooleanTable condition(table={1,2,3,3.5,4},
          startValue=false)
        annotation (Placement(transformation(extent={{-80,40},{-60,60}})));
      Modelica.Blocks.Sources.BooleanTable check(startValue=true, table={0.2,0.3,0.4,
            1.1,1.2,1.3,1.4,2.2,2.5,3.1,3.15,3.2,3.25,3.3, 3.35,3.4,3.45})
        annotation (Placement(transformation(extent={{-80,12},{-60,32}})));
      Modelica_Requirements.ChecksInFixedWindow.MaxRising maxRising(nRisingMax=3, check=
            check.y)
        annotation (Placement(transformation(extent={{-40,40},{0,60}})));
    equation
      connect(condition.y, maxRising.condition) annotation (Line(
          points={{-59,50},{-50,50},{-50,50.1},{-42,50.1}},
          color={255,0,255},
          smooth=Smooth.None));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics), experiment(StopTime=5),
        Documentation(info="<html>
<p>
Using check block <a href=\"modelica://Modelica_Requirements.ChecksInFixedWindow.MaxRising\">MaxRising</a> as
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

    model BandRising
      "Example for BandRising (in every true condition phase, a minimum number of check rising edges must occur and the number of check rising edges is bounded)"
       extends Modelica.Icons.Example;

      Modelica.Blocks.Sources.BooleanTable condition(table={1,2,3,3.5,4},
          startValue=false)
        annotation (Placement(transformation(extent={{-80,40},{-60,60}})));
      Modelica.Blocks.Sources.BooleanTable check(startValue=true, table={0.2,0.3,0.4,
            1.1,1.2,1.3,1.4,2.2,2.5,3.1,3.15,3.2,3.25,3.3, 3.35,3.4,3.45})
        annotation (Placement(transformation(extent={{-80,12},{-60,32}})));
      Modelica_Requirements.ChecksInFixedWindow.BandRising bandRising(nRisingMax=3, check=check.y,
        nRisingMin=2)
        annotation (Placement(transformation(extent={{-40,40},{0,60}})));
    equation
      connect(condition.y, bandRising.condition) annotation (Line(
          points={{-59,50},{-50,50},{-50,50.1},{-42,50.1}},
          color={255,0,255},
          smooth=Smooth.None));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics), experiment(StopTime=5),
        Documentation(info="<html>
<p>
Using check block <a href=\"modelica://Modelica_Requirements.ChecksInFixedWindow.BandRising\">BandRising</a> as
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
</html>"));
    end BandRising;

    model MaxRisingFrequency
      "Example for MaxRisingFrequency (in every true condition phase, the frequency of the check rising edges is limited)"
       extends Modelica.Icons.Example;
      constant Real pi = Modelica.Constants.pi;

      Modelica.Blocks.Sources.BooleanTable condition(
          startValue=false, table={1,3,5,7,9,9.5,11,13,17})
        annotation (Placement(transformation(extent={{-80,40},{-60,60}})));
      Modelica_Requirements.SignalAnalysis.CrossingMonitoring crossing
        annotation (Placement(transformation(extent={{36,10},{56,30}})));
      Modelica_Requirements.ChecksInFixedWindow.MaxRisingFrequency maxFrequency1(
          freqHzMax=3, check=crossing.y)
                       annotation (Placement(transformation(extent={{-40,40},{0,60}})));
      Modelica_Requirements.Sources.RealExpression expr1(y=sin(2*pi*(if time <= 5
             then 2 elseif time <= 10 then 4 elseif time <= 15 then 2 else 0)*time))
        annotation (Placement(transformation(extent={{-92,10},{16,30}})));
    equation
      connect(condition.y, maxFrequency1.condition)
        annotation (Line(points={{-59,50},{-42,50},{-42,50.1}}, color={255,0,255}));
      connect(expr1.y, crossing.u)
        annotation (Line(points={{18.7,20},{26,20},{34,20}},
                                                           color={0,0,127}));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
                100}}),            graphics), experiment(StopTime=18, Interval=1e-4),
        Documentation(info="<html>
<p>
Using check block <a href=\"modelica://Modelica_Requirements.ChecksInFixedWindow.MaxRisingFrequency\">MaxRisingFrequency</a> as
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

    model WhenRising
      "Example for WhenRising (return Satisfied when check is true and condition has a rising edge)"
       extends Modelica.Icons.Example;

      Modelica.Blocks.Sources.BooleanTable check1(startValue=true, table={1.5,
            3.3,4.2})
        annotation (Placement(transformation(extent={{-60,-20},{-40,0}})));
      Modelica.Blocks.Sources.BooleanTable condition1(table={1,2,3,3.5,4},
          startValue=false)
        annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
      Modelica_Requirements.ChecksInFixedWindow.WhenRising whenRising1(check=check1.y)
        annotation (Placement(transformation(extent={{20,20},{60,40}})));
      Modelica_Requirements.ChecksInFixedWindow.WhenRising whenRising2(check=check1.y)
        annotation (Placement(transformation(extent={{20,-10},{60,10}})));
      Modelica.Blocks.MathBoolean.Not condition2
        annotation (Placement(transformation(extent={{0,-4},{8,4}})));
      Modelica_Requirements.ChecksInFixedWindow.WhenRising whenRising3(check=check2.y)
        annotation (Placement(transformation(extent={{20,-40},{60,-20}})));
      Modelica.Blocks.MathBoolean.Not check2
        annotation (Placement(transformation(extent={{-28,-14},{-20,-6}})));
    equation

      connect(condition1.y, whenRising1.condition) annotation (Line(
          points={{-39,30},{-30,30},{-30,30.1},{18,30.1}},
          color={255,0,255},
          smooth=Smooth.None));
      connect(condition2.u, whenRising1.condition) annotation (Line(
          points={{-1.6,0},{-10,0},{-10,30.1},{18,30.1}},
          color={255,0,255},
          smooth=Smooth.None));
      connect(whenRising3.condition, whenRising1.condition) annotation (Line(
          points={{18,-29.9},{-10,-29.9},{-10,30.1},{18,30.1}},
          color={255,0,255},
          smooth=Smooth.None));
      connect(check1.y, check2.u) annotation (Line(
          points={{-39,-10},{-29.6,-10}},
          color={255,0,255},
          smooth=Smooth.None));
      connect(condition2.y, whenRising2.condition) annotation (Line(
          points={{8.8,0},{14,0},{14,0.1},{18,0.1}},
          color={255,0,255},
          smooth=Smooth.None));
      annotation (experiment(StopTime=5), Documentation(info="<html>
<p>
Using check block <a href=\"modelica://Modelica_Requirements.ChecksInFixedWindow.WhenRising\">WhenRising</a> as
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
</html>"),
        Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
                100}}), graphics));
    end WhenRising;

    model WhenFalling
      "Example for WhenFalling (return Satisfied when check is true and condition has a falling edge)"
       extends Modelica.Icons.Example;

      Modelica.Blocks.Sources.BooleanTable check1(startValue=true, table={1.5,
            3.3,4.2})
        annotation (Placement(transformation(extent={{-60,-20},{-40,0}})));
      Modelica.Blocks.Sources.BooleanTable condition1(table={1,2,3,3.5,4},
          startValue=false)
        annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
      Modelica_Requirements.ChecksInFixedWindow.WhenFalling whenFalling1(check=check1.y)
        annotation (Placement(transformation(extent={{20,20},{60,40}})));
      Modelica_Requirements.ChecksInFixedWindow.WhenFalling whenFalling2(check=check1.y)
        annotation (Placement(transformation(extent={{20,-10},{60,10}})));
      Modelica.Blocks.MathBoolean.Not condition2
        annotation (Placement(transformation(extent={{0,-4},{8,4}})));
      Modelica_Requirements.ChecksInFixedWindow.WhenFalling whenFalling3(check=check2.y)
        annotation (Placement(transformation(extent={{20,-40},{60,-20}})));
      Modelica.Blocks.MathBoolean.Not check2
        annotation (Placement(transformation(extent={{-28,-14},{-20,-6}})));
    equation

      connect(condition1.y, whenFalling1.condition) annotation (Line(
          points={{-39,30},{-30,30},{-30,30.1},{18,30.1}},
          color={255,0,255},
          smooth=Smooth.None));
      connect(condition2.u, whenFalling1.condition) annotation (Line(
          points={{-1.6,0},{-10,0},{-10,30.1},{18,30.1}},
          color={255,0,255},
          smooth=Smooth.None));
      connect(whenFalling3.condition, whenFalling1.condition) annotation (Line(
          points={{18,-29.9},{-10,-29.9},{-10,30.1},{18,30.1}},
          color={255,0,255},
          smooth=Smooth.None));
      connect(check1.y, check2.u) annotation (Line(
          points={{-39,-10},{-29.6,-10}},
          color={255,0,255},
          smooth=Smooth.None));
      connect(condition2.y, whenFalling2.condition) annotation (Line(
          points={{8.8,0},{14,0},{14,0.1},{18,0.1}},
          color={255,0,255},
          smooth=Smooth.None));
      annotation (experiment(StopTime=5), Documentation(info="<html>
<p>
Using check block <a href=\"modelica://Modelica_Requirements.ChecksInFixedWindow.WhenFalling\">WhenFalling</a> as
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
</html>"),
        Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
                100}}), graphics));
    end WhenFalling;

    model WhenChanging
      "Example for WhenChanging (return Satisfied when check is true and condition has a changing edge)"
       extends Modelica.Icons.Example;

      Modelica.Blocks.Sources.BooleanTable check1(startValue=true, table={1.5,
            3.3,4.2})
        annotation (Placement(transformation(extent={{-60,-20},{-40,0}})));
      Modelica.Blocks.Sources.BooleanTable condition1(table={1,2,3,3.5,4},
          startValue=false)
        annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
      Modelica_Requirements.ChecksInFixedWindow.WhenChanging whenChanging1(check=check1.y)
        annotation (Placement(transformation(extent={{20,20},{60,40}})));
      Modelica_Requirements.ChecksInFixedWindow.WhenChanging whenChanging2(check=check1.y)
        annotation (Placement(transformation(extent={{20,-10},{60,10}})));
      Modelica.Blocks.MathBoolean.Not condition2
        annotation (Placement(transformation(extent={{0,-4},{8,4}})));
      Modelica_Requirements.ChecksInFixedWindow.WhenChanging whenChanging3(check=check2.y)
        annotation (Placement(transformation(extent={{20,-40},{60,-20}})));
      Modelica.Blocks.MathBoolean.Not check2
        annotation (Placement(transformation(extent={{-28,-14},{-20,-6}})));
    equation

      connect(condition1.y, whenChanging1.condition) annotation (Line(
          points={{-39,30},{-30,30},{-30,30.1},{18,30.1}},
          color={255,0,255},
          smooth=Smooth.None));
      connect(condition2.u, whenChanging1.condition) annotation (Line(
          points={{-1.6,0},{-10,0},{-10,30.1},{18,30.1}},
          color={255,0,255},
          smooth=Smooth.None));
      connect(whenChanging3.condition, whenChanging1.condition) annotation (Line(
          points={{18,-29.9},{-10,-29.9},{-10,30.1},{18,30.1}},
          color={255,0,255},
          smooth=Smooth.None));
      connect(check1.y, check2.u) annotation (Line(
          points={{-39,-10},{-29.6,-10}},
          color={255,0,255},
          smooth=Smooth.None));
      connect(condition2.y, whenChanging2.condition) annotation (Line(
          points={{8.8,0},{14,0},{14,0.1},{18,0.1}},
          color={255,0,255},
          smooth=Smooth.None));
      annotation (experiment(StopTime=5), Documentation(info="<html>
<p>
Using check block <a href=\"modelica://Modelica_Requirements.ChecksInFixedWindow.WhenChanging\">WhenChanging</a> as
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
</html>"),
        Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
                100}}), graphics));
    end WhenChanging;

    model WithinDomain
      "Example for WithinDomain (in every true condition phase, point input must be within domain defined by polygon)"
       import Modelica_Requirements;
       extends Modelica.Icons.Example;

      Modelica_Requirements.ChecksInFixedWindow.WithinDomain withinDomain(polygon=[
            0.200003,1; 0.262864,1.06863; 0.31059,1.13545; 0.328082,1.18709;
            0.339319,1.2227; 0.366828,1.2975; 0.394388,1.35717; 0.413196,
            1.39279; 0.434519,1.4311; 0.45963,1.46851; 0.473459,1.48366;
            0.497347,1.50951; 0.518703,1.53802; 0.542597,1.56209; 0.556408,
            1.58258; 0.574017,1.59952; 0.596673,1.61646; 0.621856,1.63252;
            0.647041,1.64769; 0.673492,1.66197; 0.698669,1.67981; 0.723857,
            1.69409; 0.749043,1.70926; 0.772973,1.72265; 0.796897,1.73782;
            0.827112,1.75834; 0.859848,1.77975; 0.883775,1.79403; 0.901416,
            1.80118; 1.79731,1.80267; 1.79787,1.25984; 1.74873,1.2384; 1.70086,
            1.21608; 1.65676,1.19554; 1.6114,1.17499; 1.56474,1.16691; 1.53575,
            1.15796; 1.48661,1.1383; 1.44375,1.12488; 1.38575,1.11143; 1.31012,
            1.08728; 1.24708,1.07294; 1.19289,1.05238; 1.15004,1.0354; 1.11854,
            1.022; 1.09965,1.01129; 1.08581,1.00059; 0.200006,0.99911; 0.200003,
            1]) annotation (Placement(transformation(extent={{-20,0},{20,40}})));

      Modelica.Blocks.Sources.CombiTimeTable table(table=[0,0.26,1; 0.023,
            0.262864,1.02; 0.046,0.31059,1.02; 0.069,0.328082,1.03; 0.092,
            0.339319,1.05; 0.115,0.366828,1.07; 0.138,0.394388,1.1; 0.161,
            0.413196,1.11; 0.184,0.434519,1.12; 0.207,0.45963,1.13; 0.23,
            0.473459,1.14; 0.253,0.497347,1.15; 0.276,0.518703,1.16; 0.299,
            0.542597,1.17; 0.322,0.556408,1.18; 0.345,0.574017,1.19; 0.368,
            0.596673,1.2; 0.391,0.621856,1.21; 0.414,0.647041,1.22; 0.437,
            0.673492,1.23; 0.46,0.698669,1.24; 0.483,0.723857,1.25; 0.506,
            0.749043,1.26; 0.529,0.772973,1.27; 0.552,0.796897,1.25; 0.575,
            0.827112,1.22; 0.598,0.859848,1.19; 0.621,0.883775,1.18; 0.644,
            0.901416,1.19; 0.667,1.08581,1.18; 0.69,1.09965,1.17; 0.713,1.11854,
            1.16; 0.736,1.15004,1.15; 0.759,1.19289,1.14; 0.782,1.24708,1.13;
            0.805,1.31012,1.12; 0.828,1.38575,1.11; 0.851,1.44375,1.1; 0.874,
            1.48661,1.09; 0.897,1.53575,1.08; 0.92,1.56474,1.07; 0.943,1.6114,
            1.06; 0.966,1.65676,1.05; 0.989,1.70086,1.04; 1.012,1.74873,1.03;
            1.035,1.79787,1.02; 1.058,1.79731,1.01])
        annotation (Placement(transformation(extent={{-80,0},{-60,20}})));

      Modelica_Requirements.Sources.BooleanConstant const1
        annotation (Placement(transformation(extent={{-50,10},{-30,30}})));
    equation
      connect(table.y, withinDomain.point) annotation (Line(points={{-59,10},{-42,
              10},{-22,10}}, color={0,0,127}));
      connect(withinDomain.condition, const1.y) annotation (Line(points={{-22,
              20.1},{-26,20.1},{-26,20},{-29,20}}, color={255,0,255}));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics={
            Text(
              extent={{-190,120},{210,160}},
              lineColor={175,175,175},
              textString="%name")}),          experiment(StopTime=1.2),
        Documentation(info="<html>
<p>
Using check block <a href=\"modelica://Modelica_Requirements.ChecksInFixedWindow.WithinDomain\">WithinDomain</a> as
</p>

<p><blockquote>
<img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/Elementary/ChecksInFixedWindow/WithinDomain1a.png\">
</blockquote></p>

<p>
displays the polygon and the point in the icon of the block. If the point is within the polygon,
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
  end ChecksInFixedWindow;

    package ChecksInFixedWindow_withFFT
      "Library of check blocks that inspect properties in a fixed time window using FFT (Fast Fourier Transform)"
      extends Modelica.Icons.ExamplesPackage;

      model WithinAbsoluteDomain1
        "Example for WithinAbsoluteDomain block with one FFT computation (a rising condition input triggers an FFT calculation. The amplitudes of the FFTs must be below a frequency dependent limit)"
        extends Modelica.Icons.Example;

        Modelica_Requirements.ChecksInFixedWindow_withFFT.WithinAbsoluteDomain
          fft_absoluteDomain1(
          f_max=4,
          f_resolution=0.2,
          maxAmplitude=[0,6; 1,6; 2,4; 3,1.5; 4,1.5])
          annotation (Placement(transformation(extent={{8,0},{68,60}})));
        Modelica.Blocks.Sources.Sine sine2(amplitude=3, freqHz=2)
          annotation (Placement(transformation(extent={{-80,0},{-60,20}})));
        Modelica.Blocks.Sources.Sine sine3(amplitude=1.5, freqHz=3)
          annotation (Placement(transformation(extent={{-80,-40},{-60,-20}})));
        Modelica.Blocks.Sources.Constant const(k=5)
          annotation (Placement(transformation(extent={{-80,40},{-60,60}})));
        Modelica.Blocks.Math.MultiSum multiSum(nu=3)
          annotation (Placement(transformation(extent={{-36,24},{-24,36}})));
        Modelica_Requirements.Sources.BooleanConstant const1
          annotation (Placement(transformation(extent={{-40,60},{-20,80}})));
        Modelica_Requirements.LogicalBlocks.FallingEdgeTerminate terminate1(text=
              "Terminated since FFT computation finished")
          annotation (Placement(transformation(extent={{78,40},{98,60}})));
      equation
        connect(const.y, multiSum.u[1]) annotation (Line(points={{-59,50},{-48,50},{-48,
                32.8},{-36,32.8}},            color={0,0,127}));
        connect(sine2.y, multiSum.u[2]) annotation (Line(points={{-59,10},{-48,10},{-48,
                30},{-36,30}},                color={0,0,127}));
        connect(sine3.y, multiSum.u[3]) annotation (Line(points={{-59,-30},{-46,-30},{
                -46,27.2},{-36,27.2}},         color={0,0,127}));
        connect(multiSum.y, fft_absoluteDomain1.u)
          annotation (Line(points={{-22.98,30},{-4,30},{6,30}},
                                                         color={0,0,127}));
        connect(const1.y, fft_absoluteDomain1.condition) annotation (Line(
              points={{-19,70},{-10,70},{-10,50},{6,50}},  color={255,0,255}));
        connect(fft_absoluteDomain1.FFT_computation, terminate1.u)
          annotation (Line(points={{69,50},{76,50}}, color={255,0,255}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false)),
          experiment(StopTime=6),
          Documentation(info="<html>
<p>
Using check block <a href=\"modelica://Modelica_Requirements.ChecksInFixedWindow_withFFT.WithinAbsoluteDomain\">WithinAbsoluteDomain</a> as
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
      end WithinAbsoluteDomain1;

      model WithinAbsoluteDomain2
        "Example for WithinAbsoluteDomain block with two FFT computations (a rising condition input triggers an FFT calculation. The amplitudes of the FFTs must be below a frequency dependent limit)"
        extends Modelica.Icons.Example;

        Modelica_Requirements.ChecksInFixedWindow_withFFT.WithinAbsoluteDomain
          fft_absoluteDomain1(
          f_resolution=0.2,
          f_max=6,
          maxAmplitude=[0,6; 1,6; 2,4; 3,1.5; 10,1.5])
          annotation (Placement(transformation(extent={{20,0},{80,60}})));
        Modelica.Blocks.Sources.Sine sine2(amplitude=3, freqHz=2)
          annotation (Placement(transformation(extent={{-80,8},{-60,28}})));
        Modelica.Blocks.Sources.Sine sine3(amplitude=1.5, freqHz=3)
          annotation (Placement(transformation(extent={{-80,-24},{-60,-4}})));
        Modelica.Blocks.Sources.Constant const(k=5)
          annotation (Placement(transformation(extent={{-80,40},{-60,60}})));
        Modelica.Blocks.Sources.Sine sine5(freqHz=5,startTime=7,amplitude=2)
          annotation (Placement(transformation(extent={{-80,-56},{-60,-36}})));
        Modelica.Blocks.Math.MultiSum multiSum(nu=4)
          annotation (Placement(transformation(extent={{-36,24},{-24,36}})));
        Modelica.Blocks.Sources.BooleanTable booleanTable(table={1,1.5,9,9.5})
          annotation (Placement(transformation(extent={{-40,60},{-20,80}})));
      equation
        connect(const.y, multiSum.u[1]) annotation (Line(points={{-59,50},{-48,
                50},{-48,33.15},{-36,33.15}}, color={0,0,127}));
        connect(sine2.y, multiSum.u[2]) annotation (Line(points={{-59,18},{-48,18},{-48,
                31.05},{-36,31.05}},          color={0,0,127}));
        connect(sine3.y, multiSum.u[3]) annotation (Line(points={{-59,-14},{-46,-14},{
                -46,28.95},{-36,28.95}},       color={0,0,127}));
        connect(sine5.y, multiSum.u[4]) annotation (Line(points={{-59,-46},{-44,-46},{
                -44,26.85},{-36,26.85}},       color={0,0,127}));
        connect(multiSum.y, fft_absoluteDomain1.u)
          annotation (Line(points={{-22.98,30},{18,30}}, color={0,0,127}));
        connect(booleanTable.y, fft_absoluteDomain1.condition) annotation (Line(
              points={{-19,70},{-8,70},{-8,50},{18,50}}, color={255,0,255}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false)),
          experiment(StopTime=16),
          Documentation(info="<html>
<p>
Using check block <a href=\"modelica://Modelica_Requirements.ChecksInFixedWindow_withFFT.WithinAbsoluteDomain\">WithinAbsoluteDomain</a> as
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
      end WithinAbsoluteDomain2;

      model WithinRelativeDomain1
        "Example for RelativeDomain block with one FFT computation (a rising condition input triggers an FFT calculation. The amplitudes of the FFTs must be below a frequency dependent limit that is defined relative to the amplitude of the base frequency)"
        extends Modelica.Icons.Example;

        Modelica_Requirements.ChecksInFixedWindow_withFFT.WithinRelativeDomain
          fft_relativeDomain1(
          f_max=4,
          f_resolution=0.2,
          f_base=2,
          maxAmplitude=[0,120; 1,120; 2,100; 3,50; 4,50])
          annotation (Placement(transformation(extent={{4,0},{64,60}})));
        Modelica.Blocks.Sources.Sine sine2(amplitude=3, freqHz=2)
          annotation (Placement(transformation(extent={{-80,0},{-60,20}})));
        Modelica.Blocks.Sources.Sine sine3(amplitude=1.5, freqHz=3)
          annotation (Placement(transformation(extent={{-80,-40},{-60,-20}})));
        Modelica.Blocks.Sources.Constant const(k=3)
          annotation (Placement(transformation(extent={{-80,40},{-60,60}})));
        Modelica.Blocks.Math.MultiSum multiSum(nu=3)
          annotation (Placement(transformation(extent={{-36,24},{-24,36}})));
        Modelica_Requirements.Sources.BooleanConstant const1
          annotation (Placement(transformation(extent={{-40,60},{-20,80}})));
        Modelica_Requirements.LogicalBlocks.FallingEdgeTerminate
                                           terminate1(text=
              "Terminated since FFT computation finished")
          annotation (Placement(transformation(extent={{74,40},{94,60}})));
      equation
        connect(const.y, multiSum.u[1]) annotation (Line(points={{-59,50},{-48,50},{-48,
                32.8},{-36,32.8}},            color={0,0,127}));
        connect(sine2.y, multiSum.u[2]) annotation (Line(points={{-59,10},{-48,10},{-48,
                30},{-36,30}},                color={0,0,127}));
        connect(sine3.y, multiSum.u[3]) annotation (Line(points={{-59,-30},{-46,-30},{
                -46,27.2},{-36,27.2}},         color={0,0,127}));
        connect(multiSum.y,fft_relativeDomain1. u)
          annotation (Line(points={{-22.98,30},{2,30}},  color={0,0,127}));
        connect(const1.y,fft_relativeDomain1. condition) annotation (Line(
              points={{-19,70},{-10,70},{-10,50},{2,50}},  color={255,0,255}));
        connect(fft_relativeDomain1.FFT_computation, terminate1.u) annotation (
            Line(points={{65,50},{68,50},{72,50}}, color={255,0,255}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false)),
          experiment(StopTime=6),
          Documentation(info="<html>
<p>
Using check block <a href=\"modelica://Modelica_Requirements.ChecksInFixedWindow_withFFT.WithinRelativeDomain\">WithinRelativeDomain</a> as
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
      end WithinRelativeDomain1;

      model WithinRelativeDomain2
        "Example for RelativeDomain block with two FFT computations (a rising condition input triggers an FFT calculation. The amplitudes of the FFTs must be below a frequency dependent limit that is defined relative to the amplitude of the base frequency)"
        extends Modelica.Icons.Example;

        Modelica_Requirements.ChecksInFixedWindow_withFFT.WithinRelativeDomain
          fft_relativeDomain1(
          f_resolution=0.2,
          f_max=6,
          f_base=2,
          maxAmplitude=[0,120; 1,120; 2,100; 3,50; 10,50])
          annotation (Placement(transformation(extent={{20,0},{80,60}})));
        Modelica.Blocks.Sources.Sine sine2(amplitude=3, freqHz=2)
          annotation (Placement(transformation(extent={{-80,8},{-60,28}})));
        Modelica.Blocks.Sources.Sine sine3(amplitude=1.5, freqHz=3)
          annotation (Placement(transformation(extent={{-80,-24},{-60,-4}})));
        Modelica.Blocks.Sources.Constant const(k=3)
          annotation (Placement(transformation(extent={{-80,40},{-60,60}})));
        Modelica.Blocks.Sources.Sine sine5(freqHz=5,startTime=7,amplitude=2)
          annotation (Placement(transformation(extent={{-80,-56},{-60,-36}})));
        Modelica.Blocks.Math.MultiSum multiSum(nu=4)
          annotation (Placement(transformation(extent={{-36,24},{-24,36}})));
        Modelica.Blocks.Sources.BooleanTable booleanTable(table={1,1.5,9,9.5})
          annotation (Placement(transformation(extent={{-40,60},{-20,80}})));
      equation
        connect(const.y, multiSum.u[1]) annotation (Line(points={{-59,50},{-48,
                50},{-48,33.15},{-36,33.15}}, color={0,0,127}));
        connect(sine2.y, multiSum.u[2]) annotation (Line(points={{-59,18},{-48,18},{-48,
                31.05},{-36,31.05}},          color={0,0,127}));
        connect(sine3.y, multiSum.u[3]) annotation (Line(points={{-59,-14},{-46,-14},{
                -46,28.95},{-36,28.95}},       color={0,0,127}));
        connect(sine5.y, multiSum.u[4]) annotation (Line(points={{-59,-46},{-44,-46},{
                -44,26.85},{-36,26.85}},       color={0,0,127}));
        connect(multiSum.y,fft_relativeDomain1. u)
          annotation (Line(points={{-22.98,30},{18,30}}, color={0,0,127}));
        connect(booleanTable.y,fft_relativeDomain1. condition) annotation (Line(
              points={{-19,70},{-8,70},{-8,50},{18,50}}, color={255,0,255}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false)),
          experiment(StopTime=16),
          Documentation(info="<html>
<p>
Using check block <a href=\"modelica://Modelica_Requirements.ChecksInFixedWindow_withFFT.WithinRelativeDomain\">WithinRelativeDomain</a> as
</p>

<p><blockquote>
<img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/Elementary/ChecksInFixedWindow_withFFT/WithinRelativeDomain2_example.png\">
</blockquote></p>

<p>
The amplitutes of the FFT are dynamically displayed in the icon of the block (in black), as well
as the maximume amplitudes maxAmplitude (in red). 
The computed amplitude of the base frequency is shown in green (so this amplitude is 100 %).
At the end of the simulation, one of the amplitudes
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
      end WithinRelativeDomain2;

      model MaxTotalHamonicDistortion1
        "Example for MaxTotalHamonicDistortion block with one FFT computation (a rising condition input triggers an FFT calculation. The Total Harmonic Distortion (THD) of the FFTs must be below the given limit)"

        extends Modelica.Icons.Example;

        Modelica_Requirements.ChecksInFixedWindow_withFFT.MaxTotalHarmonicDistortion
          maxTHD1(f_resolution=0.2, f_base=2)
          annotation (Placement(transformation(extent={{-2,0},{58,60}})));
        Modelica.Blocks.Sources.Sine sine1(amplitude=3, freqHz=2)
          annotation (Placement(transformation(extent={{-80,40},{-60,60}})));
        Modelica.Blocks.Sources.Sine sine2(               freqHz=4, amplitude=0.2)
          annotation (Placement(transformation(extent={{-80,8},{-60,28}})));
        Modelica.Blocks.Sources.Constant const(k=2.5)
          annotation (Placement(transformation(extent={{-80,70},{-60,90}})));
        Modelica.Blocks.Math.MultiSum multiSum(nu=6)
          annotation (Placement(transformation(extent={{-36,24},{-24,36}})));
        Modelica_Requirements.Sources.BooleanConstant const1
          annotation (Placement(transformation(extent={{-40,60},{-20,80}})));
        Modelica.Blocks.Sources.Sine sine3(               freqHz=6, amplitude=0.15)
          annotation (Placement(transformation(extent={{-80,-26},{-60,-6}})));
        Modelica.Blocks.Sources.Sine sine4(                freqHz=8, amplitude=0.1)
          annotation (Placement(transformation(extent={{-14,-40},{-34,-20}})));
        Modelica.Blocks.Sources.Sine sine5(                freqHz=10, amplitude=0.08)
          annotation (Placement(transformation(extent={{-14,-6},{-34,14}})));
      equation
        connect(const.y, multiSum.u[1]) annotation (Line(points={{-59,80},{-46,80},{-46,
                33.5},{-36,33.5}},            color={0,0,127}));
        connect(sine1.y, multiSum.u[2]) annotation (Line(points={{-59,50},{-48,50},{-48,
                32.1},{-36,32.1}},            color={0,0,127}));
        connect(sine2.y, multiSum.u[3]) annotation (Line(points={{-59,18},{-48,18},{-48,
                30.7},{-36,30.7}},             color={0,0,127}));
        connect(multiSum.y, maxTHD1.u)
          annotation (Line(points={{-22.98,30},{-4,30}}, color={0,0,127}));
        connect(const1.y, maxTHD1.condition) annotation (Line(points={{-19,70},{-10,70},
                {-10,50},{-4,50}},          color={255,0,255}));
        connect(sine3.y, multiSum.u[4]) annotation (Line(points={{-59,-16},{-46,-16},{
                -46,29.3},{-36,29.3}}, color={0,0,127}));
        connect(sine4.y, multiSum.u[5]) annotation (Line(points={{-35,-30},{-44,-30},{
                -44,28},{-36,28},{-36,27.9}}, color={0,0,127}));
        connect(sine5.y, multiSum.u[6]) annotation (Line(points={{-35,4},{-42,4},{-42,
                26.5},{-36,26.5}},     color={0,0,127}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false)),
          experiment(StopTime=6),
          Documentation(info="<html>
<p>
Using check block <a href=\"modelica://Modelica_Requirements.ChecksInFixedWindow_withFFT.MaxTotalHarmonicDistortion\">MaxTotalHarmonicDistortion</a> as
</p>

<p><blockquote>
<img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/Elementary/ChecksInFixedWindow_withFFT/MaxTotalHarmonicDistortion1_example.png\">
</blockquote></p>

<p>
The amplitutes of the FFT are dynamically displayed in the icon of the block (in black).
The computed amplitude of the base frequency is shown in green:
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
      end MaxTotalHamonicDistortion1;

      model MaxTotalHamonicDistortion2
        "Example for MaxTotalHamonicDistortion block with two FFT computations (a rising condition input triggers an FFT calculation. The Total Harmonic Distortion (THD) of the FFTs must be below the given limit)"

        extends Modelica.Icons.Example;

        Modelica_Requirements.ChecksInFixedWindow_withFFT.MaxTotalHarmonicDistortion
          maxTHD1(f_resolution=0.2, f_base=2,
          THDmax=0.1)
          annotation (Placement(transformation(extent={{20,0},{80,60}})));
        Modelica.Blocks.Sources.Sine sine1(amplitude=3, freqHz=2)
          annotation (Placement(transformation(extent={{-80,40},{-60,60}})));
        Modelica.Blocks.Sources.Sine sine2(               freqHz=4, amplitude=0.2)
          annotation (Placement(transformation(extent={{-80,8},{-60,28}})));
        Modelica.Blocks.Sources.Constant const(k=2.5)
          annotation (Placement(transformation(extent={{-80,70},{-60,90}})));
        Modelica.Blocks.Math.MultiSum multiSum(nu=6)
          annotation (Placement(transformation(extent={{-36,24},{-24,36}})));
        Modelica.Blocks.Sources.Sine sine3(               freqHz=6,
          amplitude=0.3,
          startTime=7)
          annotation (Placement(transformation(extent={{-80,-26},{-60,-6}})));
        Modelica.Blocks.Sources.Sine sine4(amplitude=0.15, freqHz=8)
          annotation (Placement(transformation(extent={{0,-34},{-20,-14}})));
        Modelica.Blocks.Sources.Sine sine5(                freqHz=10, amplitude=
             0.1)
          annotation (Placement(transformation(extent={{0,0},{-20,20}})));
        Modelica.Blocks.Sources.BooleanTable booleanTable(table={1,1.5,9,9.5})
          annotation (Placement(transformation(extent={{-32,60},{-12,80}})));
      equation
        connect(const.y, multiSum.u[1]) annotation (Line(points={{-59,80},{-46,80},{-46,
                33.5},{-36,33.5}},            color={0,0,127}));
        connect(sine1.y, multiSum.u[2]) annotation (Line(points={{-59,50},{-48,50},{-48,
                32.1},{-36,32.1}},            color={0,0,127}));
        connect(sine2.y, multiSum.u[3]) annotation (Line(points={{-59,18},{-48,18},{-48,
                30.7},{-36,30.7}},             color={0,0,127}));
        connect(multiSum.y, maxTHD1.u)
          annotation (Line(points={{-22.98,30},{18,30}}, color={0,0,127}));
        connect(sine3.y, multiSum.u[4]) annotation (Line(points={{-59,-16},{-46,-16},{
                -46,29.3},{-36,29.3}}, color={0,0,127}));
        connect(sine4.y, multiSum.u[5]) annotation (Line(points={{-21,-24},{-44,-24},{
                -44,28},{-36,28},{-36,27.9}}, color={0,0,127}));
        connect(sine5.y, multiSum.u[6]) annotation (Line(points={{-21,10},{-42,10},{-42,
                26.5},{-36,26.5}},     color={0,0,127}));
        connect(booleanTable.y, maxTHD1.condition) annotation (Line(points={{-11,70},{
                6,70},{6,50},{18,50}}, color={255,0,255}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false)),
          experiment(StopTime=16),
          Documentation(info="<html>
<p>
Using check block <a href=\"modelica://Modelica_Requirements.ChecksInFixedWindow_withFFT.MaxTotalHarmonicDistortion\">MaxTotalHarmonicDistortion</a> as
</p>

<p><blockquote>
<img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/Elementary/ChecksInFixedWindow_withFFT/MaxTotalHarmonicDistortion2_example.png\">
</blockquote></p>

<p>
The amplitutes of the FFT are dynamically displayed in the icon of the block (in black).
The computed amplitude of the base frequency is shown in green:
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
      end MaxTotalHamonicDistortion2;
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
    end ChecksInFixedWindow_withFFT;

  package ChecksInSlidingWindow
    "Library of examples using ChecksInSlidingWindow blocks"
    extends Modelica.Icons.ExamplesPackage;

    model MinDuration
      "Example for MinDuration (in every sliding time window, the longest time duration where check was permanently true must be above a lower limit)"
       extends Modelica.Icons.Example;

      Modelica.Blocks.Sources.BooleanTable check(startValue=false,
            table={1,3.3,5.2,5.4,5.6,5.8,6.0,8,9.1,10.5,11.5,12})
        annotation (Placement(transformation(extent={{-80,40},{-60,60}})));
      Modelica_Requirements.ChecksInSlidingWindow.MinDuration minDuration(
        lowerLimit=1,
        check=check.y,
        window=2)
        annotation (Placement(transformation(extent={{-40,40},{0,60}})));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics), experiment(StopTime=14),
        Documentation(info="<html>
<p>
Using sliding time window check block <a href=\"modelica://Modelica_Requirements.ChecksInSlidingWindow.MinDuration\">MinDuration</a> as
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
</html>"));
    end MinDuration;

    model MinAccumulatedDuration
      "Example for AccumulatedMinDuration (in every sliding time window, the accumulated time duration where check was true must be above a lower limit)"
       extends Modelica.Icons.Example;

      Modelica.Blocks.Sources.BooleanTable check(startValue=false,
            table={1,3.3,5.2,5.4,5.6,5.8,6.0,8,9.1,10.5,11.5,12})
        annotation (Placement(transformation(extent={{-80,40},{-60,60}})));
      Modelica_Requirements.ChecksInSlidingWindow.MinAccumulatedDuration minAccDuration(
        lowerLimit=1,
        check=check.y,
        window=2)
        annotation (Placement(transformation(extent={{-40,40},{0,60}})));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics), experiment(StopTime=14),
        Documentation(info="<html>
<p>
Using sliding time window check block <a href=\"modelica://Modelica_Requirements.ChecksInSlidingWindow.MinAccumulatedDuration\">AccumulatedMinDuration</a> as
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
</html>"));
    end MinAccumulatedDuration;

    model MinAccumulatedDuration2
      "Example for AccumulatedMinDuration (in every sliding time window, the accumulated time duration where check was true must be above a lower limit)"
       extends Modelica.Icons.Example;

      Modelica.Blocks.Sources.BooleanTable check(startValue=false,
            table={1,3.3,5.2,5.4,5.6,5.8,6.0,8,9.1,10.5,11.5,12})
        annotation (Placement(transformation(extent={{-80,40},{-60,60}})));
      Modelica_Requirements.ChecksInSlidingWindow.MinAccumulatedDuration2 minAccDuration(
        lowerLimit=1,
        check=check.y,
        window=2)
        annotation (Placement(transformation(extent={{-40,40},{0,60}})));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics), experiment(StopTime=14),
        Documentation(info="<html>
<p>
Using sliding time window check block <a href=\"modelica://Modelica_Requirements.ChecksInSlidingWindow.MinAccumulatedDuration\">AccumulatedMinDuration</a> as
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
</html>"));
    end MinAccumulatedDuration2;

    model MaxDuration
      "Example for MaxDuration (in every sliding time window, the longest time duration where check was permanently true must be below an upper limit)"
       extends Modelica.Icons.Example;

      Modelica.Blocks.Sources.BooleanTable check(startValue=false,
            table={1,3.3,5.2,5.4,5.6,5.8,6.0,8,8.2,8.4,8.6,9.1,10.5,11.5,12})
        annotation (Placement(transformation(extent={{-80,40},{-60,60}})));
      Modelica_Requirements.ChecksInSlidingWindow.MaxDuration maxDuration1(check=
            check.y, upperLimit=1,
        window=2)
        annotation (Placement(transformation(extent={{-40,40},{0,60}})));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics), experiment(StopTime=14),
        Documentation(info="<html>
<p>
Using sliding time window check block <a href=\"modelica://Modelica_Requirements.ChecksInSlidingWindow.MaxDuration\">MaxDuration</a> as
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
</html>"));
    end MaxDuration;

    model MaxAccumulatedDuration
      "Example for MaxDuration (in every sliding time window, the accumulated time duration where check was true must be below an upper limit)"
       extends Modelica.Icons.Example;

      Modelica.Blocks.Sources.BooleanTable check(startValue=false,
            table={1,3.3,5.2,5.4,5.6,5.8,6.0,8,8.2,8.4,8.6,9.1,10.5,11.5,12})
        annotation (Placement(transformation(extent={{-80,40},{-60,60}})));
      Modelica_Requirements.ChecksInSlidingWindow.MaxAccumulatedDuration maxAccDuration(
        check=check.y,
        upperLimit=1,
        window=2)
        annotation (Placement(transformation(extent={{-40,40},{0,60}})));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics), experiment(StopTime=14),
        Documentation(info="<html>
<p>
Using sliding time window check block <a href=\"modelica://Modelica_Requirements.ChecksInSlidingWindow.MaxAccumulatedDuration\">AccumulatedMaxDuration</a> as
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
</html>"));
    end MaxAccumulatedDuration;

    model BandDuration
      "Example for BandDuration (in every sliding time window, the longest time duration where check was permanently true must be within a given band)"
       extends Modelica.Icons.Example;

      Modelica.Blocks.Sources.BooleanTable check(startValue=false,
            table={1,3.5,5.2,5.4,5.6,5.8,6.0,8.5,9.1,10.5,11.5,12})
        annotation (Placement(transformation(extent={{-80,40},{-60,60}})));
      Modelica_Requirements.ChecksInSlidingWindow.BandDuration bandDuration(
        lowerLimit=1,
        upperLimit=2,
        check=check.y,
        window=3)
        annotation (Placement(transformation(extent={{-40,40},{0,60}})));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics), experiment(StopTime=14),
        Documentation(info="<html>
<p>
Using sliding time window check block <a href=\"modelica://Modelica_Requirements.ChecksInSlidingWindow.BandDuration\">BandDuration</a> as
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
</html>"));
    end BandDuration;

    model BandAccumulatedDuration
      "Example for BandAccumulatedDuration (in every sliding time window, the accumulated time duration where check was true must be within a given band)"
       extends Modelica.Icons.Example;

      Modelica.Blocks.Sources.BooleanTable check(startValue=false,
            table={1,3.5,5.2,5.4,5.6,5.8,6.0,8.5,9.1,10.5,11.5,12})
        annotation (Placement(transformation(extent={{-80,40},{-60,60}})));
      Modelica_Requirements.ChecksInSlidingWindow.BandAccumulatedDuration bandAccDuration(
        lowerLimit=1,
        upperLimit=2,
        check=check.y,
        window=3)
        annotation (Placement(transformation(extent={{-40,40},{0,60}})));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics), experiment(StopTime=14),
        Documentation(info="<html>
<p>
Using sliding time window check block <a href=\"modelica://Modelica_Requirements.ChecksInSlidingWindow.BandAccumulatedDuration\">BandAccumulatedDuration</a> as
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
</html>"));
    end BandAccumulatedDuration;

    model MinRising
      "Example for MinRising (in every sliding time window, a minimum number of check rising edges must occur)"
       extends Modelica.Icons.Example;

      Modelica.Blocks.Sources.BooleanTable check(startValue=false,
            table={1,3.3,5.2,5.4,5.6,5.8,6.0,8,9.1,9.3,9.5,9.7,10,10.5,11.5,12})
        annotation (Placement(transformation(extent={{-80,40},{-60,60}})));
      Modelica_Requirements.ChecksInSlidingWindow.MinRising minRising(
        nRisingMin=1,
        check=check.y,
        window=2)
        annotation (Placement(transformation(extent={{-40,40},{0,60}})));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics), experiment(StopTime=14),
        Documentation(info="<html>
<p>
Using sliding time window check block <a href=\"modelica://Modelica_Requirements.ChecksInSlidingWindow.MinRising\">MinRising</a> as
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
</html>"));
    end MinRising;

    model MaxRising
      "Example for MaxRising (in every sliding time window, the number of check rising edges is bounded)"
       extends Modelica.Icons.Example;

      Modelica.Blocks.Sources.BooleanTable check(startValue=false,
            table={1,3.3,5.2,5.4,5.6,5.8,6.0,6.2,6.4,8,9.1,9.3,9.5,9.7,10,10.5,11.5,12})
        annotation (Placement(transformation(extent={{-80,40},{-60,60}})));
      Modelica_Requirements.ChecksInSlidingWindow.MaxRising maxRising(
        nRisingMax=2,
        check=check.y,
        window=2)
        annotation (Placement(transformation(extent={{-40,40},{0,60}})));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics), experiment(StopTime=14),
        Documentation(info="<html>
<p>
Using sliding time window check block <a href=\"modelica://Modelica_Requirements.ChecksInSlidingWindow.MaxRising\">MaxRising</a> as
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
</html>"));
    end MaxRising;

    model BandRising
      "Example for BandRising (in every sliding time window, a minimum number of check rising edges must occur and the number of check rising edges is bounded)"
       extends Modelica.Icons.Example;

      Modelica.Blocks.Sources.BooleanTable check(startValue=false,
            table={1,3.3,5.2,5.4,5.6,5.8,6.0,6.2,6.4,8,9.1,9.3,9.5,9.7,10,10.2,10.4,10.6,11.5,12})
        annotation (Placement(transformation(extent={{-80,40},{-60,60}})));
      Modelica_Requirements.ChecksInSlidingWindow.BandRising bandRising(
        nRisingMin=1,
        nRisingMax=3,
        check=check.y,
        window=2)
        annotation (Placement(transformation(extent={{-40,40},{0,60}})));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics), experiment(StopTime=14),
        Documentation(info="<html>
<p>
Using sliding time window check block <a href=\"modelica://Modelica_Requirements.ChecksInSlidingWindow.BandRising\">BandRising</a> as
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
</html>"));
    end BandRising;

    model MaxFrequency
      "Example for MaxFrequency (in every sliding time window, the mean frequency of check is limited)"
      import Modelica_Requirements;
       extends Modelica.Icons.Example;
      constant Real pi = Modelica.Constants.pi;

      Modelica_Requirements.SignalAnalysis.CrossingMonitoring crossing
        annotation (Placement(transformation(extent={{34,10},{54,30}})));
      Modelica_Requirements.ChecksInSlidingWindow.MaxFrequency maxFrequency(
        check=crossing.y,
        freqHzMeanMax=3,
        window=2)
        annotation (Placement(transformation(extent={{-60,40},{-20,60}})));
      Modelica_Requirements.Sources.RealExpression expr1(y=sin(2*pi*(if time
             <= 5 then 2 elseif time <= 10 then 4 elseif time <= 15 then 2
             else 0)*time))
        annotation (Placement(transformation(extent={{-88,10},{20,30}})));
    equation
      connect(expr1.y, crossing.u)
        annotation (Line(points={{22.7,20},{28,20},{28,20},{32,20}},
                                                     color={0,0,127}));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics), experiment(StopTime=18,Interval=4e-3),
        Documentation(info="<html>
<p>
Using check block <a href=\"modelica://Modelica_Requirements.ChecksInSlidingWindow.MaxFrequency\">MaxFrequency</a> as
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
more precise as using the <a href=\"modelica://Modelica_Requirements.Examples.Elementary.ChecksInSlidingWindow.MaxRisingFrequency\">MaxRisingFrequency</a> block that takes only the rising edges of check into account.
</p>
</html>"));
    end MaxFrequency;

    model MaxRisingFrequency
      "Example for MaxRisingFrequency (in every sliding time window, the frequency of the check rising edges is limited)"
      import Modelica_Requirements;
       extends Modelica.Icons.Example;
      constant Real pi = Modelica.Constants.pi;

      Modelica_Requirements.SignalAnalysis.CrossingMonitoring crossing
        annotation (Placement(transformation(extent={{34,10},{54,30}})));
      Modelica_Requirements.ChecksInSlidingWindow.MaxRisingFrequency maxRisingFrequency(
        check=crossing.y,
        freqHzMeanMax=3,
        window=2)
        annotation (Placement(transformation(extent={{-60,40},{-20,60}})));
      Modelica_Requirements.Sources.RealExpression expr1(y=sin(2*pi*(if time
             <= 5 then 2 elseif time <= 10 then 4 elseif time <= 15 then 2
             else 0)*time))
        annotation (Placement(transformation(extent={{-88,10},{20,30}})));
    equation
      connect(expr1.y, crossing.u)
        annotation (Line(points={{22.7,20},{32,20}}, color={0,0,127}));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics), experiment(StopTime=18,Interval=4e-3),
        Documentation(info="<html>
<p>
Using check block <a href=\"modelica://Modelica_Requirements.ChecksInSlidingWindow.MaxRisingFrequency\">MaxRisingFrequency</a> as
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
</html>"));
    end MaxRisingFrequency;

    model MaxIncrease
      "Example for MaxIncrease (in every sliding time window, the increase of the input is limited)"
      import Modelica_Requirements;
       extends Modelica.Icons.Example;

      Modelica.Blocks.Sources.CombiTimeTable signal(table=[0,20; 4,22.5; 6,27;
            8,28; 12,28])
        annotation (Placement(transformation(extent={{-80,60},{-60,80}})));
      Modelica_Requirements.ChecksInSlidingWindow.MaxIncrease maxIncrease(
          upperLimit=3, window(displayUnit="s") = 2)
        annotation (Placement(transformation(extent={{-44,60},{-24,80}})));
    equation
      connect(signal.y[1], maxIncrease.u) annotation (Line(points={{-59,70},{-52.5,
              70},{-46,70}}, color={0,0,127}));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}})),           experiment(StopTime=12),
        Documentation(info="<html>
<p>
Using sliding time window check block <a href=\"modelica://Modelica_Requirements.ChecksInSlidingWindow.MaxIncrease\">MaxIncrease</a> as
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

    model MaxPercentageIncrease
      "Example for MaxPercentageIncrease (in every sliding time window, the increase of the input is limited)"
      import Modelica_Requirements;
       extends Modelica.Icons.Example;

      Modelica.Blocks.Sources.CombiTimeTable signal(table=[0,20; 2,20; 4,24; 6,
            27; 8,28; 12,28])
        annotation (Placement(transformation(extent={{-80,60},{-60,80}})));
      Modelica_Requirements.ChecksInSlidingWindow.MaxPercentageIncrease
                                        maxIncrease1(
                                  window(displayUnit="s") = 2,
          upperPercentageLimit=10)
        annotation (Placement(transformation(extent={{-44,60},{-24,80}})));
    equation
      connect(signal.y[1], maxIncrease1.u)
        annotation (Line(points={{-59,70},{-52.5,70},{-46,70}}, color={0,0,127}));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}})),           experiment(StopTime=12),
        Documentation(info="<html>
<p>
Using sliding time window check block <a href=\"modelica://Modelica_Requirements.ChecksInSlidingWindow.MaxPercentageIncrease\">MaxPercentageIncrease</a> as
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
  end ChecksInSlidingWindow;

  package SignalAnalysis "Library of examples using SignalAnalysis blocks"
      extends Modelica.Icons.ExamplesPackage;

    model Derivatives
      "Examples for DerXXX (various ways to compute derivatives of signals)"
       extends Modelica.Icons.Example;

      Modelica_Requirements.SignalAnalysis.ExactDerivative der1
        annotation (Placement(transformation(extent={{-40,20},{-20,40}})));
      Modelica_Requirements.SignalAnalysis.ApproximateDerivativeWithFilter
        approxDerFilter(f_cut=10)
        annotation (Placement(transformation(extent={{-40,-4},{-20,16}})));
      Modelica.Blocks.Sources.Sine sine(
        amplitude=2,
        freqHz=1,
        phase=0.78539816339745)
        annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
      Modelica_Requirements.SignalAnalysis.ApproximateDerivativeWithWindow
        approxDerWindow(dt=0.1)
        annotation (Placement(transformation(extent={{-40,-26},{-20,-6}})));
    equation
      connect(sine.y, der1.u) annotation (Line(
          points={{-59,30},{-37,30}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(sine.y, approxDerFilter.u) annotation (Line(
          points={{-59,30},{-52,30},{-52,6},{-42,6}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(approxDerWindow.u, der1.u) annotation (Line(
          points={{-42,-16},{-52,-16},{-52,30},{-37,30}},
          color={0,0,127},
          smooth=Smooth.None));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{
                -100,-100},{100,100}}), graphics), experiment(StopTime=2),
        Documentation(info="<html>
<p>
Using the signal analysis blocks
<a href=\"modelica://Modelica_Requirements.SignalAnalysis.ExactDerivative\">ExactDerivative</a>,
<a href=\"modelica://Modelica_Requirements.SignalAnalysis.ApproximateDerivativeWithFilter\">ApproximateDerivativeWithFilter</a>, and 
<a href=\"modelica://Modelica_Requirements.SignalAnalysis.ApproximateDerivativeWithWindow\">ApproximateDerivativeWithWindow</a>
to compute the derivative of the input signal analytically or approximately with
the following example
</p>

<p><blockquote>
<img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/Elementary/SignalAnalysis/Derivatives1.png\">
</blockquote></p>

<p>
results in
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
    end Derivatives;

    model Integrator
      "Example for Integrator (output is the integral over the input, as long as input active is true)"
      extends Modelica.Icons.Example;

      Modelica.Blocks.Sources.Sine sine(freqHz=0.3, offset=2)
        annotation (Placement(transformation(extent={{-60,0},{-40,20}})));
      Modelica.Blocks.Sources.BooleanPulse pulse(period=2, startTime=1)
        annotation (Placement(transformation(extent={{-40,-40},{-20,-20}})));
      Modelica_Requirements.SignalAnalysis.TriggeredIntegrator integrator1
        annotation (Placement(transformation(extent={{-20,0},{0,20}})));
    equation
      connect(sine.y, integrator1.u)
        annotation (Line(points={{-39,10},{-30.5,10},{-22,10}}, color={0,0,127}));
      connect(pulse.y, integrator1.active) annotation (Line(points={{-19,-30},{
              -10,-30},{-10,3}}, color={255,0,255}));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics),
                Documentation(info="<html>
<p>
Using signal analysis block <a href=\"modelica://Modelica_Requirements.SignalAnalysis.Integrator\">Integrator</a> as
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
</html>
"),     experiment(StopTime=8));
    end Integrator;

    model MovingAverage
      "Example for MovingAverage (output is the continuous moving average of the input, as long as input active is true)"
      extends Modelica.Icons.Example;

      Modelica.Blocks.Sources.Sine sine(freqHz=0.3, offset=2)
        annotation (Placement(transformation(extent={{-60,0},{-40,20}})));
      Modelica.Blocks.Sources.BooleanPulse pulse(          startTime=1, period=3)
        annotation (Placement(transformation(extent={{-40,-40},{-20,-20}})));
      Modelica_Requirements.SignalAnalysis.MovingAverage movAv1(T=0.2)
        annotation (Placement(transformation(extent={{-20,0},{0,20}})));
    equation
      connect(sine.y, movAv1.u)
        annotation (Line(points={{-39,10},{-30.5,10},{-22,10}}, color={0,0,127}));
      connect(pulse.y, movAv1.active) annotation (Line(points={{-19,-30},{-10,-30},{
              -10,-2}}, color={255,0,255}));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics),
                Documentation(info="<html>
<p>
Using signal analysis block <a href=\"modelica://Modelica_Requirements.SignalAnalysis.MovingAverage\">MovingAverage</a> as
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
</html>
"),     experiment(StopTime=8));
    end MovingAverage;

    model TimeMonitoring
      "Example for TimeMonitoring (output is the time duration where the Boolean input was true)"
      extends Modelica.Icons.Example;

      Modelica.Blocks.Sources.BooleanTable booleanTable(startValue=false, table={1,2,
            3.5,5,6,6.5})
        annotation (Placement(transformation(extent={{-60,0},{-40,20}})));
      Modelica_Requirements.SignalAnalysis.TimeMonitoring timeMon1
        annotation (Placement(transformation(extent={{-20,0},{0,20}})));
    equation
      connect(booleanTable.y, timeMon1.u)
        annotation (Line(points={{-39,10},{-22,10},{-22,10}}, color={255,0,255}));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics),
                Documentation(info="<html>
<p>
Using signal analysis block <a href=\"modelica://Modelica_Requirements.SignalAnalysis.TimeMonitoring\">TimeMonitoring</a> as
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
</html>
"),     experiment(StopTime=8));
    end TimeMonitoring;

    model CrossingMonitoring
      "Example for CrossingMonitoring (output is true for a positive threshold crossing of the input and false for a negative threshold crossing)"
      extends Modelica.Icons.Example;

      Modelica.Blocks.Sources.Sine sine(freqHz=2)
        annotation (Placement(transformation(extent={{-60,0},{-40,20}})));
      Modelica_Requirements.SignalAnalysis.CrossingMonitoring crossingMon1(
          threshold=0.5)
        annotation (Placement(transformation(extent={{-20,0},{0,20}})));
    equation
      connect(sine.y, crossingMon1.u)
        annotation (Line(points={{-39,10},{-22,10}},          color={0,0,127}));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics),
                Documentation(info="<html>
<p>
Using signal analysis block <a href=\"modelica://Modelica_Requirements.SignalAnalysis.CrossingMonitoring\">CrossingMonitoring</a> as
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
</html>
"),     experiment(StopTime=2));
    end CrossingMonitoring;

  end SignalAnalysis;

  package LogicalBlocks "Library of examples using LogicalBlocks blocks"
    model Conversions
      "Examples for BooleanToProperty, IntegerToProperty, PropertyToBoolean, PropertyToInteger"
       import Modelica_Requirements.Types.Property;
       extends Modelica.Icons.Example;

      Modelica.Blocks.Sources.BooleanTable booleanTable(startValue=true, table={1.5,
            3.3,4.2})
        annotation (Placement(transformation(extent={{-80,40},{-60,60}})));
      Modelica_Requirements.LogicalBlocks.BooleanToProperty BtoP1
        annotation (Placement(transformation(extent={{-50,40},{-30,60}})));
      Modelica.Blocks.Sources.IntegerTable integerTable(table=[0,3; 1,2; 2,1; 3,3; 4,
            2]) annotation (Placement(transformation(extent={{-80,0},{-60,20}})));
      Modelica_Requirements.LogicalBlocks.IntegerToProperty ItoP1
        annotation (Placement(transformation(extent={{-52,0},{-32,20}})));
      Modelica_Requirements.LogicalBlocks.PropertyToBoolean PtoB1
        annotation (Placement(transformation(extent={{-20,-20},{0,0}})));
      Modelica_Requirements.LogicalBlocks.PropertyToBoolean PtoB2(undecided=true)
        annotation (Placement(transformation(extent={{-20,-40},{0,-20}})));
      Modelica_Requirements.LogicalBlocks.PropertyToInteger PtoI1
        annotation (Placement(transformation(extent={{-20,0},{0,20}})));
    equation

      connect(booleanTable.y, BtoP1.u) annotation (Line(
          points={{-59,50},{-47,50}},
          color={255,0,255},
          smooth=Smooth.None));
      connect(integerTable.y, ItoP1.u) annotation (Line(
          points={{-59,10},{-49,10}},
          color={255,127,0},
          smooth=Smooth.None));
      connect(ItoP1.y, PtoB1.u) annotation (Line(
          points={{-36,10},{-30,10},{-30,-10},{-22,-10}},
          color={255,0,128},
          smooth=Smooth.None));
      connect(ItoP1.y, PtoB2.u) annotation (Line(
          points={{-36,10},{-30,10},{-30,-30},{-22,-30}},
          color={255,0,128},
          smooth=Smooth.None));
      connect(ItoP1.y, PtoI1.u) annotation (Line(
          points={{-36,10},{-17,10}},
          color={255,0,128},
          smooth=Smooth.None));
      annotation (experiment(StopTime=5), Documentation(info="<html>
<p>
Using conversion blocks from package
 <a href=\"modelica://Modelica_Requirements.LogicalBlocks\">LogicalBlocks</a> as
</p>

<p><blockquote>
<img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/Elementary/LogicalBlocks/Conversions5.png\">
</blockquote></p>

<p>
results in
</p>

<table border=0 cellspacing=0 cellpadding=2>
<tr><td width=\"50\"></td>
    <td valign=\"bottom\"><img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/Elementary/LogicalBlocks/Conversions1.png\"></td>
<br>
    </tr>

<tr><td width=\"50\"></td>
    <td valign=\"bottom\"><img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/Elementary/LogicalBlocks/Conversions2.png\"></td>
<br>
    </tr>

<tr><td width=\"50\"></td>
    <td valign=\"bottom\"><img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/Elementary/LogicalBlocks/Conversions3.png\"></td>
<br>
    </tr>

<tr><td width=\"50\"></td>
    <td valign=\"bottom\"><img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/Elementary/LogicalBlocks/Conversions4.png\"></td>
    </tr>

<tr><td></td>
    <td align=\"center\">simulation results</td>
   </tr>
</table>
</html>"),
        Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
                100}}),            graphics));
    end Conversions;
    extends Modelica.Icons.ExamplesPackage;

    model ThresholdComparisons
      "Examples for the threshold comparison blocks in package LogicalBlocks"
       import Modelica_Requirements.Types.Property;
       extends Modelica.Icons.Example;

      Modelica_Requirements.LogicalBlocks.GreaterThreshold gt1(threshold=0.5)
        annotation (Placement(transformation(extent={{-40,40},{0,60}})));
      Modelica.Blocks.Sources.Sine sine(amplitude=2, freqHz=1)
        annotation (Placement(transformation(extent={{-80,40},{-60,60}})));
      Modelica_Requirements.LogicalBlocks.GreaterEqualThreshold ge1(threshold=
            0.5)
        annotation (Placement(transformation(extent={{-40,20},{0,40}})));
      Modelica_Requirements.LogicalBlocks.LessThreshold lt1(threshold=0.5)
        annotation (Placement(transformation(extent={{-40,0},{0,20}})));
      Modelica_Requirements.LogicalBlocks.LessEqualThreshold le1(threshold=0.5)
        annotation (Placement(transformation(extent={{-40,-20},{0,0}})));
      Modelica_Requirements.LogicalBlocks.WithinBand band1(u_min=-0.5, u_max=
            0.5)
        annotation (Placement(transformation(extent={{-40,-44},{0,-24}})));
    equation
      connect(sine.y, gt1.u) annotation (Line(
          points={{-59,50},{-42,50}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(sine.y, ge1.u) annotation (Line(
          points={{-59,50},{-52,50},{-52,30},{-42,30}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(lt1.u, ge1.u) annotation (Line(
          points={{-42,10},{-52,10},{-52,30},{-42,30}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(le1.u, ge1.u) annotation (Line(
          points={{-42,-10},{-52,-10},{-52,30},{-42,30}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(band1.u, gt1.u) annotation (Line(
          points={{-42,-34},{-52,-34},{-52,50},{-42,50}},
          color={0,0,127},
          smooth=Smooth.None));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{
                -100,-100},{100,100}}), graphics), experiment(StopTime=2),
        Documentation(info="<html>
<p>
Using comparison blocks from package
 <a href=\"modelica://Modelica_Requirements.LogicalBlocks\">LogicalBlocks</a> as
</p>

<p><blockquote>
<img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/Elementary/LogicalBlocks/ThresholdComparisons1.png\">
</blockquote></p>

<p>
results in
</p>

<table border=0 cellspacing=0 cellpadding=2>
<tr><td width=\"50\"></td>
    <td valign=\"bottom\"><img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/Elementary/LogicalBlocks/ThresholdComparisons2.png\"></td>
    </tr>

<tr><td></td>
    <td align=\"center\">simulation result</td>
   </tr>
</table>
</html>"));
    end ThresholdComparisons;

    model DelayedRising
      "Example for DelayedRising (output is true, after a duration of a rising input edge and false after a falling input edge)"
       extends Modelica.Icons.Example;

      Modelica.Blocks.Sources.BooleanTable timeTable(table={1,3,5,5.2,9,9.2,9.5,10.7},
          startValue=false)
        annotation (Placement(transformation(extent={{-80,40},{-60,60}})));
      Modelica_Requirements.LogicalBlocks.DelayedRising delayedRising1(u=
            timeTable.y, duration=1)
        annotation (Placement(transformation(extent={{-40,40},{0,60}})));
      annotation (experiment(StopTime=12),Documentation(info="<html>
<p>
Using logical block <a href=\"modelica://Modelica_Requirements.LogicalBlocks.DelayedRising\">DelayedRising</a> as
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
</html>
"),     Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
                                   graphics));
    end DelayedRising;

    model AnyTrue
      "Example for AnyTrue (output is true if at least one input is true)"
      extends Modelica.Icons.Example;

      Modelica.Blocks.Sources.BooleanStep booleanStep(startTime=2)
        annotation (Placement(transformation(extent={{-60,0},{-40,20}})));
      Modelica.Blocks.Sources.BooleanPulse booleanPulse(
        width=50,
        period=1.5,
        startTime=1.5)
        annotation (Placement(transformation(extent={{-60,-32},{-40,-12}})));
      Modelica_Requirements.Sources.BooleanConstant const1(c=false)
        annotation (Placement(transformation(extent={{-60,24},{-40,44}})));
      Modelica_Requirements.LogicalBlocks.AnyTrue anyTrue1(nu=3)
        annotation (Placement(transformation(extent={{-20,0},{0,20}})));
    equation
      connect(const1.y, anyTrue1.u[1]) annotation (Line(points={{-39,34},{-26,
              34},{-26,12.6667},{-15,12.6667}}, color={255,0,255}));
      connect(booleanStep.y, anyTrue1.u[2]) annotation (Line(points={{-39,10},{
              -15,10},{-15,10}}, color={255,0,255}));
      connect(booleanPulse.y, anyTrue1.u[3]) annotation (Line(points={{-39,-22},
              {-28,-22},{-28,7.33333},{-15,7.33333}}, color={255,0,255}));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics),
                Documentation(info="<html>
<p>
Using logical block <a href=\"modelica://Modelica_Requirements.LogicalBlocks.AnyTrue\">AnyTrue</a> as
</p>

<p><blockquote>
<img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/Elementary/LogicalBlocks/AnyTrue1.png\">
</blockquote></p>

<p>
results in
</p>

<table border=0 cellspacing=0 cellpadding=2>
<tr><td width=\"50\"></td>
    <td valign=\"bottom\"><img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/Elementary/LogicalBlocks/AnyTrue2.png\"></td>
    </tr>

<tr><td></td>
    <td align=\"center\">simulation result</td>
   </tr>
</table>
</html>
"),     experiment(StopTime=5));
    end AnyTrue;

    model AllTrue "Example for AllTrue (output is true if all inputs are true)"
      extends Modelica.Icons.Example;

      Modelica.Blocks.Sources.BooleanStep booleanStep(startTime=2)
        annotation (Placement(transformation(extent={{-60,0},{-40,20}})));
      Modelica.Blocks.Sources.BooleanPulse booleanPulse(
        width=50,
        period=1.5,
        startTime=1.5)
        annotation (Placement(transformation(extent={{-60,-32},{-40,-12}})));
      Modelica_Requirements.Sources.BooleanConstant const1
        annotation (Placement(transformation(extent={{-60,24},{-40,44}})));
      Modelica_Requirements.LogicalBlocks.AllTrue allTrue1(nu=3)
        annotation (Placement(transformation(extent={{-20,0},{0,20}})));
    equation
      connect(const1.y, allTrue1.u[1]) annotation (Line(points={{-39,34},{-28,
              34},{-28,12.6667},{-15,12.6667}}, color={255,0,255}));
      connect(booleanStep.y, allTrue1.u[2]) annotation (Line(points={{-39,10},{
              -15,10},{-15,10}}, color={255,0,255}));
      connect(booleanPulse.y, allTrue1.u[3]) annotation (Line(points={{-39,-22},
              {-28,-22},{-28,7.33333},{-15,7.33333}}, color={255,0,255}));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics),
                Documentation(info="<html>
<p>
Using logical block <a href=\"modelica://Modelica_Requirements.LogicalBlocks.AllTrue\">AllTrue</a> as
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
</html>
"),     experiment(StopTime=5));
    end AllTrue;

    model PropertyNot
      "Example for AllTrue (output is true if all inputs are true)"
      import Modelica_Requirements;
      extends Modelica.Icons.Example;

      Modelica_Requirements.Sources.PropertyTable p(table=[0,1; 3,2; 6,3; 9,2;
            12,1; 13,3])
        annotation (Placement(transformation(extent={{-50,0},{-30,20}})));
      Modelica_Requirements.LogicalBlocks.PropertyNot not1
        annotation (Placement(transformation(extent={{-20,0},{0,20}})));
    equation
      connect(p.y, not1.u)
        annotation (Line(points={{-29,10},{-17,10}}, color={255,0,128}));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics),
                Documentation(info="<html>
<p>
Using logical block <a href=\"modelica://Modelica_Requirements.LogicalBlocks.PropertyNot\">PropertyNot</a> as
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
</html>
"),     experiment(StopTime=14));
    end PropertyNot;

    model PropertyOr
      "Example for PropertyOr (3-valued logic 'or' of Property input u)"
      import Modelica_Requirements;
      extends Modelica.Icons.Example;

      Modelica_Requirements.Sources.PropertyTable p1(table=[0,1; 3,2; 6,3; 9,2; 12,1; 13,3])
        annotation (Placement(transformation(extent={{-60,30},{-40,50}})));
      Modelica_Requirements.Sources.PropertyTable p2(table=[0,1; 1,2; 4,3; 7,1; 10,2; 12,3])
        annotation (Placement(transformation(extent={{-60,0},{-40,20}})));
      Modelica_Requirements.Sources.PropertyTable p3(table=[0,1; 2,3; 5,1; 8,2; 11,3; 13,3])
        annotation (Placement(transformation(extent={{-60,-30},{-40,-10}})));
      Modelica_Requirements.LogicalBlocks.PropertyOr or1(nu=3)
        annotation (Placement(transformation(extent={{-20,0},{0,20}})));
    equation
      connect(p1.y, or1.u[1]) annotation (Line(points={{-39,40},{-34,40},{-28,
              40},{-28,12.6667},{-15,12.6667}}, color={255,0,128}));
      connect(p2.y, or1.u[2])
        annotation (Line(points={{-39,10},{-15,10}}, color={255,0,128}));
      connect(p3.y, or1.u[3]) annotation (Line(points={{-39,-20},{-28,-20},{-28,
              7.33333},{-15,7.33333}}, color={255,0,128}));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics),
                Documentation(info="<html>
<p>
Using logical block <a href=\"modelica://Modelica_Requirements.LogicalBlocks.PropertyOr\">PropertyOr</a> as
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
</html>
"),     experiment(StopTime=14));
    end PropertyOr;

    model PropertyAnd
      "Example for PropertyAnd (3-valued logic 'and' of Property input u)"
      import Modelica_Requirements;
      extends Modelica.Icons.Example;

      Modelica_Requirements.Sources.PropertyTable p1(table=[0,1; 3,2; 6,3; 9,2; 12,1; 13,3])
        annotation (Placement(transformation(extent={{-60,30},{-40,50}})));
      Modelica_Requirements.Sources.PropertyTable p2(table=[0,1; 1,2; 4,3; 7,1; 10,2; 12,3])
        annotation (Placement(transformation(extent={{-60,0},{-40,20}})));
      Modelica_Requirements.Sources.PropertyTable p3(table=[0,1; 2,3; 5,1; 8,2; 11,3; 13,3])
        annotation (Placement(transformation(extent={{-60,-30},{-40,-10}})));
      Modelica_Requirements.LogicalBlocks.PropertyAnd and1(nu=3)
        annotation (Placement(transformation(extent={{-20,0},{0,20}})));
    equation
      connect(p1.y, and1.u[1]) annotation (Line(points={{-39,40},{-34,40},{-28,
              40},{-28,12.6667},{-15,12.6667}},
                                           color={255,0,128}));
      connect(p2.y, and1.u[2])
        annotation (Line(points={{-39,10},{-15,10}},          color={255,0,128}));
      connect(p3.y, and1.u[3]) annotation (Line(points={{-39,-20},{-28,-20},{
              -28,7.33333},{-15,7.33333}},
                              color={255,0,128}));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics),
                Documentation(info="<html>
<p>
Using logical block <a href=\"modelica://Modelica_Requirements.LogicalBlocks.PropertyAnd\">PropertyAnd</a> as
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
</html>
"),     experiment(StopTime=14));
    end PropertyAnd;
  end LogicalBlocks;

  package Sources "Library of examples using Sources blocks"
    extends Modelica.Icons.ExamplesPackage;
    model ConstantsAndExpressions "Examples for XXXConstant and XXXExpressions"
       extends Modelica.Icons.Example;
      Modelica_Requirements.Sources.RealExpression expr1(y=time/2)
        annotation (Placement(transformation(extent={{-60,-20},{-20,0}})));
      Modelica_Requirements.Sources.IntegerExpression expr2(y=integer(time))
        annotation (Placement(transformation(extent={{-60,-40},{-20,-20}})));
      Modelica_Requirements.Sources.BooleanExpression expr3(y=time > 1 and time < 3)
        annotation (Placement(transformation(extent={{-60,-60},{-20,-40}})));
      Modelica_Requirements.Sources.RealConstant const1(c=1.234)
        annotation (Placement(transformation(extent={{-60,60},{-40,80}})));
      Modelica_Requirements.Sources.BooleanConstant const2(c=false)
        annotation (Placement(transformation(extent={{-60,40},{-40,60}})));
      Modelica_Requirements.Sources.IntegerConstant const3(c=123)
        annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
      Modelica_Requirements.Sources.PropertyConstant const4(c=Modelica_Requirements.Types.Property.Undecided)
        annotation (Placement(transformation(extent={{-60,0},{-40,20}})));
       annotation (experiment(StopTime=4));
    end ConstantsAndExpressions;

    model PropertyTable "Example for PropertyTable"
      import Modelica_Requirements;
       extends Modelica.Icons.Example;

      Modelica_Requirements.Sources.PropertyTable propertyTable(table=[0,2; 1,1; 2,3;
            3,2; 4,3; 5,1; 6,2])
        annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
      annotation (experiment(StopTime=8));
    end PropertyTable;
  end Sources;
  annotation (Documentation(info="<html>
<p>
This package contains example models to demonstrate all components of library
Modelica_Requirements. Every example demonstrates usually <b>one</b> component, in order
to understand the fine details of this component. <b>Every</b> component of library
Modelica_Requirements is used at least once in one of the examples of package Elementary.
Using the Modelica_Requirements components in applications is performed
in the other packages of the Examples package.
</p>
</html>"));
end Elementary;
