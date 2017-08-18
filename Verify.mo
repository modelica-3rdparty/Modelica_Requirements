within Modelica_Requirements;
package Verify "Library of components to verify requirements"
  extends Modelica.Icons.Package;

  model PrintViolations
    "Print violated, untested and satisfied requirements at end of simulation (drag in top level of your model)"
     import Modelica.Utilities.Streams.print;
     import Modelica_Requirements.Internal;
     parameter String logFile = Internal.getFirstName(getInstanceName()) + "_log.txt"
      "Name of log file (default = <root name>_log.txt)";
     parameter String htmlFile = Internal.getFirstName(getInstanceName()) + "_log.html"
      "Name of html log file (default = <root name>_log.html)";
      parameter Boolean printViolated = true
      "= true, if violated requirements shall be printed"
       annotation(choices(checkBox=true));
      parameter Boolean printUntested = true
      "= true, if untested requirements shall be printed"
       annotation(choices(checkBox=true));
      parameter Boolean printSatisfied = true
      "= true, if satisfied requirements shall be printed"
       annotation(choices(checkBox=true));
     Modelica_Requirements.Internal.SortingPort sortingPort(final dummy1=ok, final dummy2=0.0)
      "Dummy connector to enforce that printing to and reading from log file is performed in the correct order; do not connect to it)";
     final output Real satisfaction = noEvent(if abs(sortingPort.one) < 0.5 then 100.0 else 100*abs(sortingPort.status/(2*sortingPort.one)))
      "Satisfaction of all requirements in % (0% ... 100%)";
  protected
    constant String rootName = Internal.getFirstName( getInstanceName());
    Real ok annotation(HideResult=true);
  equation
    when initial() then
       ok = Internal.initializeLogFile(logFile, time);
    end when;

    when terminal() then
       Internal.printViolationsToOutput(logFile, htmlFile, rootName, sortingPort.one,
                 satisfaction, time, printViolated, printUntested, printSatisfied);
    end when;

    annotation (
      defaultComponentName="printViolations",
      defaultComponentPrefixes="inner",
      missingInnerMessage="
Your model is using an outer \"printViolations\" component but
an inner \"printViolations\" component is not defined and therefore
a default inner \"printViolations\" component is introduced by the tool.
To change the default setting, drag Modelica_Requirements.Verify.PrintViolations
into your model.
",Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
                           graphics={Ellipse(
            extent={{-100,100},{100,-100}},
            lineColor={0,0,127},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
            Text(
            extent={{-150,140},{150,100}},
            textString="%name",
            lineColor={175,175,175}),
            Line(
              points={{-48,-10},{-8,-68},{54,58}},
              color={0,127,0},
              smooth=Smooth.None,
              thickness=1),
          Text(
            extent={{-120,-105},{120,-135}},
            lineColor={0,0,0},
            textString="satisfaction:"),
          Text(
            extent={{-150,-140},{150,-175}},
            lineColor={0,0,0},
            textStyle={TextStyle.Bold},
            textString=DynamicSelect("???", String(satisfaction,format="3.1f")) + " %% at " +
                       DynamicSelect("???", String(time)) + " s")}),
      Documentation(info="<html>
<p>
Block PrintViolations has to be dragged in the top-level of the model, where components of
library Modelica_Requirements are used. This block provides the file name, to which the Requirement
blocks write their status at the end of the simulation (whether a Requirement is Violated
or Untested). Furthermore, the PrintViolations block reads this log-file at the end of
the simulation and prints a summary to the output window.
</p>
</html>"));
  end PrintViolations;

  block Requirement
    "Check requirement defined by Property input property (property shall be Property.Satisfied)"
    extends Modelica_Requirements.Interfaces.PartialRequirement(final localProperty=property);
    Modelica_Requirements.Interfaces.PropertyInput property
      "Property that shall be Satisfied"
      annotation (Placement(transformation(extent={{-340,-20},{-300,20}})));
    annotation (Icon(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-300,-100},{300,100}},
          initialScale=0.1), graphics={
          Rectangle(
            extent={{-300,100},{300,-100}},
            lineColor={0,0,0},
            fillColor={245,245,245},
            fillPattern=FillPattern.Solid,
            borderPattern=BorderPattern.Sunken),
          Rectangle(
            extent={{-300,100},{-240,-100}},
            lineColor={0,0,0},
            lineThickness=5.0,
            fillColor={215,215,215},
            fillPattern=FillPattern.Solid,
            borderPattern=BorderPattern.Raised),
          Line(
            points={{-288,12},{-274,-30},{-252,42}},
            color={0,127,0},
            smooth=Smooth.None,
            thickness=0.5),
          Text(
            extent={{-230,90},{290,-90}},
            lineColor={0,0,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid,
            horizontalAlignment=TextAlignment.Left,
            textString="%text"),
          Text(
            extent={{-300,150},{300,110}},
            textString="%name",
            lineColor={175,175,175})}),           Diagram(coordinateSystem(
            preserveAspectRatio=false, extent={{-300,-100},{300,100}}),
                                                      graphics),
      Documentation(info="<html>
<p>
This block is used to verify a requirement. The input signal \"property\" can have the
three values Violated, Undecided, or Satisfied
(= elements of enumeration
<a href=\"modelica://Modelica_Requirements.Types.Property\">Property</a>).
A requirement is violated, if property = Violated, it is untested, if property = Undecided,
and it is satisfied, if property = Satisfied. If a required property is naturally 
defined as Boolean, use block 
<a href=\"modelica://Modelica_Requirements.Verify.BooleanRequirement\">BooleanRequirement</a>
instead.
</p>

<p>
With parameter <b>text</b> a textual description of the required property should be defined in
natural language.
This description is, for example, shown when a requirement is violated at the end of a simulation.
</p>

<p>
In the top level of a model, block <a href=\"modelica://Modelica_Requirements.Verify.PrintViolations\">PrintViolations</a>
has to be dragged. This block prints an information message at the end of a simulation, whether
a Requirement has been violated, untested, or satisfied in the current simulation run
(the amount of output can be configured).
Furthermore, all Requirement instances store information about the Requirement in a log file
(the default name is \"&lt;root-name&gt;_log.txt\"; this name can be changed via parameter logFile
in the instance of PrintViolations. Exactly one line is printed in the log file with the status for every 
instance of a Requirement block.
</p>

<p>
This block is demonstrated with the following
<a href=\"modelica://Modelica_Requirements.Examples.Elementary.Verify.Requirement\">example</a>: 
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
In a textual definition, the Requirements block can be used as shown in this
<a href=\"modelica://Modelica_Requirements.Examples.Textual.Elementary.Verify.Requirement\">example</a>: 
</p>

<blockquote>
<pre>
import Modelica_Requirements.LogicalFunctions.*;
import Modelica_Requirements.Types.Property;
Requirement R_Violated (property = PropertyToBoolean(check));
Requirement R_Undecided(property = Property.Undecided);
Requirement R_Satisfied(property = during(check, check));
</pre>
</blockquote>v
</html>"));
  end Requirement;

  block BooleanRequirement
    "Check requirement defined by Boolean input u (u shall be true for a satisfied requirement)"
    extends Modelica_Requirements.Interfaces.PartialRequirement(final localProperty=Modelica_Requirements.LogicalFunctions.BooleanToProperty(
                                                                                                    u));

    Modelica.Blocks.Interfaces.BooleanInput u
      "Boolean input that shall be true"
      annotation (Placement(transformation(extent={{-340,-20},{-300,20}})));
    annotation (defaultComponentName="requirement",Icon(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-300,-100},{300,100}},
          initialScale=0.1), graphics={
          Rectangle(
            extent={{-300,100},{300,-100}},
            lineColor={0,0,0},
            fillColor={245,245,245},
            fillPattern=FillPattern.Solid,
            borderPattern=BorderPattern.Sunken),
          Rectangle(
            extent={{-300,100},{-240,-100}},
            lineColor={0,0,0},
            lineThickness=5.0,
            fillColor={215,215,215},
            fillPattern=FillPattern.Solid,
            borderPattern=BorderPattern.Raised),
          Line(
            points={{-288,12},{-274,-30},{-252,42}},
            color={0,127,0},
            smooth=Smooth.None,
            thickness=0.5),
          Text(
            extent={{-230,90},{290,-90}},
            lineColor={0,0,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid,
            horizontalAlignment=TextAlignment.Left,
            textString="%text"),
          Text(
            extent={{-300,150},{300,110}},
            textString="%name",
            lineColor={175,175,175})}),           Diagram(coordinateSystem(
            preserveAspectRatio=false, extent={{-300,-100},{300,100}}),
                                                      graphics),
      Documentation(info="<html><p>
This block is used to verify a requirement. The Boolean input signal \"property\" shall always be true.
This signal is mapped to a 3-valued logic <a href=\"Modelica_Requirements.Types.Property\">Property</a>
(= Property.Satisfied if true and Property.Violated if false).
</p>

<p>
In the top level of a model, block <a href=\"modelica://Modelica_Requirements.Verify.PrintViolations\">PrintViolations</a>
has to be dragged. This block prints an information message at the end of a simulation, whether
a Requirement has been violated in the current simulation run.
Furthermore, all Requirement instances store information about the Requirement in a log file
(the default name is \"&lt;root-name&gt;_log.txt\"; this name can be changed via parameter logFile
in the instance of PrintViolations. Exactly one line is printed in the log file for every used
Requirement block that is either violated or untested:
</p>

<p>
If the Requirement instance is violated at least once:
</p>
<pre>
   Requirement violated: &lt;full path name&gt; (at time = &lt;first failure time&gt; s)
</pre>

<p>
If the Requirement instance is not tested:
</p>

<pre>
   Requirement untested: &lt;full path name&gt;
</pre>

<p>
For an example to use the Requirement block in graphical form, see
<a href=\"modelica://Modelica_Requirements.Examples.Elementary.Verify.Requirement\">Examples.Elementary.Verify.Requirement</a>.<br>
For an example to use the Requirement block in textual form, see
<a href=\"modelica://Modelica_Requirements.Examples.Textual.Elementary.Verify.Requirement\">Examples.Textual.Elementary.Verify.Requirement</a>.<br>

</p>
</html>"));
  end BooleanRequirement;

  annotation (Icon(graphics={             Line(
          points={{-46,-6},{-6,-64},{56,62}},
          color={135,135,135},
          smooth=Smooth.None,
          thickness=0.5)}),      Documentation(info="<html>
<p>
Sublibrary Verify contains components to evaluate whether requirements are
satisfied, violated, or not tested and to print the result of this assessment after
the simulation run to the output window.
</p>
</html>"));
end Verify;
