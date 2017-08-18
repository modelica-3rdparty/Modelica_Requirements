within Modelica_Requirements;
package Interfaces "Library of interfaces and of partial blocks"
  extends Modelica.Icons.InterfacesPackage;
  connector PropertyInput =   input Modelica_Requirements.Types.Property
    "'input Property' as connector"
    annotation (
    defaultComponentName="u",
    Icon(graphics={Polygon(
          points={{-100,100},{100,0},{-100,-100},{-100,100}},
          fillColor={255,0,128},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={255,0,128})},         coordinateSystem(
        extent={{-100,-100},{100,100}},
        preserveAspectRatio=true,
        initialScale=0.2)),
    Diagram(coordinateSystem(
        preserveAspectRatio=true,
        initialScale=0.2,
        extent={{-100,-100},{100,100}}), graphics={Polygon(
          points={{0,50},{100,0},{0,-50},{0,50}},
          lineColor={255,0,128},
          fillColor={255,0,128},
          fillPattern=FillPattern.Solid), Text(
          extent={{-10,85},{-10,60}},
          lineColor={255,0,128},
          textString="%name")}),
    Documentation(info="<html>
<p>
Connector with one input signal of type Modelica_Requirements.Types.Property.
</p>
</html>"));

  connector PropertyOutput = output Modelica_Requirements.Types.Property
    "'output Property' as connector"
    annotation (
    defaultComponentName="y",
    Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}), graphics={Polygon(
          points={{-100,100},{100,0},{-100,-100},{-100,100}},
          lineColor={255,0,128},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid)}),
    Diagram(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}), graphics={Polygon(
          points={{-100,50},{0,0},{-100,-50},{-100,50}},
          lineColor={255,0,128},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid), Text(
          extent={{30,110},{30,60}},
          lineColor={255,0,128},
          textString="%name")}),
    Documentation(info="<html>
<p>
Connector with one output signal of type Modelica_Requirements.Types.Property.
</p>
</html>"));

  connector PropertyVectorInput =input Modelica_Requirements.Types.Property
    "Property input connector used for vector of connectors" annotation (
    defaultComponentName="u",
    Icon(graphics={Ellipse(
          extent={{-100,-100},{100,100}},
          lineColor={255,0,128},
          fillColor={255,0,128},
          fillPattern=FillPattern.Solid)}, coordinateSystem(
        extent={{-100,-100},{100,100}},
        preserveAspectRatio=false,
        initialScale=0.2)),
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        initialScale=0.2,
        extent={{-100,-100},{100,100}}), graphics={Text(
          extent={{-10,85},{-10,60}},
          lineColor={255,0,128},
          textString="%name"), Ellipse(
          extent={{-50,50},{50,-50}},
          lineColor={255,0,128},
          fillColor={255,0,128},
          fillPattern=FillPattern.Solid)}),
    Documentation(info="<html>
<p>
Property input connector that is used for a vector of connectors,
for example <a href=\"modelica://Modelica_Requirements.Interfaces.PartialPropertyVISO\">PartialPropertyVISO</a>,
and has therefore a different icon as PropertyInput connector.
</p>
</html>"));
  connector EventInput =   input Boolean "'input Event' as connector"
    annotation (
    defaultComponentName="u",
    Icon(graphics={Polygon(
          points={{-100,100},{100,0},{-100,-100},{-100,100}},
          fillColor={255,170,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={255,170,255})},       coordinateSystem(
        extent={{-100,-100},{100,100}},
        preserveAspectRatio=true,
        initialScale=0.2)),
    Diagram(coordinateSystem(
        preserveAspectRatio=true,
        initialScale=0.2,
        extent={{-100,-100},{100,100}}), graphics={Polygon(
          points={{0,50},{100,0},{0,-50},{0,50}},
          lineColor={255,170,255},
          fillColor={255,170,255},
          fillPattern=FillPattern.Solid), Text(
          extent={{-10,85},{-10,60}},
          lineColor={255,170,255},
          textString="%name")}),
    Documentation(info="<html>
<p>
Connector with one input signal of type Boolean.
</p>
</html>"));
  connector EventOutput =   output Boolean "'output Event' as connector"
    annotation (
    defaultComponentName="y",
    Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}), graphics={Polygon(
          points={{-100,100},{100,0},{-100,-100},{-100,100}},
          lineColor={255,170,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid)}),
    Diagram(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}), graphics={Polygon(
          points={{-100,50},{0,0},{-100,-50},{-100,50}},
          lineColor={255,170,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid), Text(
          extent={{30,110},{30,60}},
          lineColor={255,170,255},
          textString="%name")}),
    Documentation(info="<html>
<p>
Connector with one output signal of type Boolean.
</p>
</html>"));

  partial block PartialSystem "Block defining properties2 of a system"

    annotation (
      Icon(coordinateSystem(preserveAspectRatio=false, extent={{-200,-200},{200,200}}),
                        graphics={Rectangle(
          extent={{-200,-200},{200,200}},
          lineColor={0,0,0},
          fillColor={213,255,170},
          fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-200,200},{200,120}},
            lineColor={0,0,0},
            fillColor={0,179,0},
            fillPattern=FillPattern.Solid),
                                          Text(
          extent={{-190,190},{190,140}},
          textString="%name",
          lineColor={0,0,0})}),
    Documentation(info="<html>
<p>
Block that defines properties2 of a system
</p>
</html>"));

  end PartialSystem;

  partial block PartialEnvironment
    "Block defining properties2 of the environment"

    annotation (
      Icon(coordinateSystem(preserveAspectRatio=false, extent={{-200,-200},{200,200}}),
                        graphics={Rectangle(
          extent={{-200,-200},{200,200}},
          lineColor={0,0,0},
          fillColor={255,255,170},
          fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-200,200},{200,120}},
            lineColor={0,0,0},
            fillColor={255,170,85},
            fillPattern=FillPattern.Solid),
                                          Text(
          extent={{-190,190},{190,140}},
          textString="%name",
          lineColor={0,0,0})}),
    Documentation(info="<html>
<p>
Block that defines properties2 of the environment
</p>
</html>"));

  end PartialEnvironment;

  partial function PropertyFunction
    "Icon for functions returning a variable of type Property"

    annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
          Text(
            lineColor={0,0,255},
            extent={{-150,105},{150,145}},
            textString="%name"),
          Ellipse(
            lineColor={255,0,128},
            fillColor={255,215,136},
            fillPattern=FillPattern.Solid,
            extent={{-100,-100},{100,100}}),
          Text(
            lineColor={108,88,49},
            extent={{-90,-90},{90,90}},
            textString="f")}),
  Documentation(info="<html>
<p>This icon indicates Modelica functions.</p>
</html>"));
  end PropertyFunction;

  partial block PartialBooleanVISO
    "Partial block with a BooleanVectorInput and a BooleanOutput signal"

    parameter Integer nu(min=0) = 0 "Number of input connections"
      annotation (Dialog(connectorSizing=true), HideResult=true);
    Modelica.Blocks.Interfaces.BooleanVectorInput u[nu]
      "Vector of Boolean input signals"
      annotation (Placement(transformation(extent={{-60,40},{-40,-40}})));
    Modelica.Blocks.Interfaces.BooleanOutput y "Boolean output signal"
      annotation (Placement(transformation(extent={{50,-10},{70,10}})));
  initial equation
    pre(u) = fill(false, nu);

    annotation (Icon(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics={
          Rectangle(
            extent={{-50,50},{50,-50}},
            lineColor={0,0,0},
            lineThickness=5.0,
            fillColor={210,210,210},
            fillPattern=FillPattern.Solid,
            borderPattern=BorderPattern.Raised), Text(
            extent={{-150,100},{150,60}},
            lineColor={175,175,175},
            textString="%name"),
          Ellipse(
            extent={{35,6},{45,-4}},
            lineColor=DynamicSelect({235,235,235}, if y > 0.5 then {0,255,0}
                 else {235,235,235}),
            fillColor=DynamicSelect({235,235,235}, if y > 0.5 then {0,255,0}
                 else {235,235,235}),
            fillPattern=FillPattern.Solid)}),
          Diagram(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}},
          grid={1,1})));
  end PartialBooleanVISO;

  partial block PartialPropertyVISO
    "Partial block with a PropertyVectorInput and a PropertyOutput signal"

    parameter Integer nu(min=0) = 0 "Number of input connections"
      annotation (Dialog(connectorSizing=true), HideResult=true);
    Modelica_Requirements.Interfaces.PropertyVectorInput u[nu]
      "Vector of Boolean input signals"
      annotation (Placement(transformation(extent={{-60,40},{-40,-40}})));
    Modelica_Requirements.Interfaces.PropertyOutput y "Property output signal"
      annotation (Placement(transformation(extent={{50,-10},{70,10}})));

    annotation (Icon(coordinateSystem(
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
            textString="%name")}),
          Diagram(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}},
          grid={1,1})));
  end PartialPropertyVISO;

  partial block PartialExpression "Icon for expression block"

    annotation (Diagram(coordinateSystem(
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
            extent={{-190,40},{190,-40}},
            lineColor={0,0,0},
            lineThickness=5.0,
            fillColor={245,245,245},
            fillPattern=FillPattern.Solid,
            borderPattern=BorderPattern.Sunken),
          Text(
            extent={{-200,100},{200,60}},
            lineColor={175,175,175},
            textString="%name")}));
  end PartialExpression;

  partial block PartialConstant "Icon for Constant block"

    annotation (Diagram(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}},
          grid={1,1})), Icon(coordinateSystem(
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
            extent={{-90,40},{90,-40}},
            lineColor={0,0,0},
            lineThickness=5.0,
            fillColor={245,245,245},
            fillPattern=FillPattern.Solid,
            borderPattern=BorderPattern.Sunken),
          Text(
            extent={{-150,100},{150,60}},
            lineColor={175,175,175},
            textString="%name")}));
  end PartialConstant;

  partial block partialThresholdComparison
    "Partial block to compare the Real input u with a threshold and provide the result as 1 Boolean output signal"

    parameter Real threshold=0 "Comparison with respect to threshold";

    Modelica.Blocks.Interfaces.RealInput u
      annotation (Placement(transformation(extent={{-240,-20},{-200,20}})));
    Modelica.Blocks.Interfaces.BooleanOutput y
      annotation (Placement(transformation(extent={{200,-10},{220,10}})));

    annotation (Documentation(info="<html>
<p>
Block has one continuous Real input and one continuous Boolean output signal
as well as a 3D icon (e.g., used in Blocks.Logical library).
</p>
</html>"),
     Diagram(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-200,-100},{200,100}},
          grid={1,1})),
     Icon(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-200,-100},{200,100}},
          grid={1,1}),
        graphics={
         Rectangle(
            extent={{-200,50},{200,-50}},
            lineColor={0,0,0},
            lineThickness=5.0,
            fillColor={210,210,210},
            fillPattern=FillPattern.Solid,
            borderPattern=BorderPattern.Raised),
          Rectangle(
            extent={{-140,40},{190,-40}},
            lineColor={0,0,0},
            lineThickness=5.0,
            fillColor={245,245,245},
            fillPattern=FillPattern.Solid,
            borderPattern=BorderPattern.Sunken),
          Text(
            extent={{-140,-15},{190,15}},
            lineColor={0,0,0},
            fontSize=8,
            textString="%threshold"),
          Text(
            extent={{-200,101},{200,61}},
            lineColor={175,175,175},
            textString="%name")}));

  end partialThresholdComparison;

  partial block PartialTriggeredMovingWindow
    "Icon and equationns for a block with a trigger signal and a moving time window"
     parameter Modelica.SIunits.Time T(min=Modelica.Constants.eps)
      "Length of sliding time window";

    Modelica.Blocks.Interfaces.RealInput u "Real input signal"
      annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
    Modelica.Blocks.Interfaces.RealOutput y "Real output signal"
      annotation (Placement(transformation(extent={{100,-10},{120,10}})));
    Modelica.Blocks.Interfaces.BooleanInput active "Boolean input signal" annotation (Placement(
          transformation(
          extent={{-20,-20},{20,20}},
          rotation=90,
          origin={0,-120})));
    annotation (Diagram(coordinateSystem(
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
          Rectangle(
            extent={{-90,-30},{90,-90}},
            lineColor={0,0,0},
            lineThickness=5.0,
            fillColor={245,245,245},
            fillPattern=FillPattern.Solid,
            borderPattern=BorderPattern.Sunken),
          Text(
            extent={{-150,110},{150,150}},
            lineColor={175,175,175},
            textString="%name"),
          Text(
            extent={{-90,-77},{90,-47}},
            lineColor={0,0,0},
            textString="%T s"),
          Text(
            extent={{-80,0},{90,-20}},
            lineColor={102,102,102},
            textString="T",
            horizontalAlignment=TextAlignment.Left)}));
  end PartialTriggeredMovingWindow;

  partial block PartialCheck "Interfaces and icon for check block"

    Modelica.Blocks.Interfaces.BooleanInput condition
      "Boolean input condition signal"
      annotation (Placement(transformation(extent={{-240,-19},{-200,21}})));
    input Boolean check(start = false) "Boolean to check"
       annotation(Dialog);
    Modelica_Requirements.Interfaces.PropertyOutput y "Property output signal"
      annotation (Placement(transformation(extent={{200,-10},{220,10}})));
    annotation (Diagram(coordinateSystem(
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
            extent={{-190,0},{190,-90}},
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
            extent={{50,30},{180,0}},
            lineColor={95,95,95},
            horizontalAlignment=TextAlignment.Right,
            textString="check"),
          Text(
            extent={{-190,-30},{190,-60}},
            lineColor={0,0,0},
            textString="%check")}));
  end PartialCheck;

  partial block PartialCheckInSlidingWindowWithBooleanOutput
    "Interfaces and icon for check block that evaluates a property in a sliding time window and returns the result as Boolean"

    input Boolean check(start = false) "Boolean to check"
       annotation(Dialog);
    parameter Modelica.SIunits.Time window(min=Modelica.Constants.eps)
      "Length of sliding time window (> 0)";
    Modelica.Blocks.Interfaces.BooleanOutput y
      "= true if property satisfied, otherwise false"
      annotation (Placement(transformation(extent={{200,-10},{220,10}})));
    annotation (Diagram(coordinateSystem(
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
            extent={{0,-5},{185,-30}},
            lineColor={95,95,95},
            horizontalAlignment=TextAlignment.Right,
            textString="check"),
          Text(
            extent={{-190,-47},{190,-77}},
            lineColor={0,0,0},
            textString="%check"),
          Line(
            points={{-194,10},{-171,10}},
            color={0,0,0},
            smooth=Smooth.None),
          Line(
            points={{-186,10},{-186,65},{5,65},{5,10}},
            color={255,0,0},
            pattern=LinePattern.Dot),
          Rectangle(
            extent={{10,60},{190,10}},
            lineColor={0,0,0},
            lineThickness=5.0,
            fillColor={245,245,245},
            fillPattern=FillPattern.Solid,
            borderPattern=BorderPattern.Sunken),
          Text(
            extent={{10,47},{190,17}},
            lineColor={0,0,0},
            fillColor={255,0,0},
            fillPattern=FillPattern.Solid,
            textString="%window s"),
          Rectangle(
            extent={{-180,60},{0,10}},
            lineColor={0,0,0},
            lineThickness=5.0,
            fillColor={245,245,245},
            fillPattern=FillPattern.Solid,
            borderPattern=BorderPattern.Sunken),
          Text(
            extent={{0,85},{190,60}},
            lineColor={95,95,95},
            horizontalAlignment=TextAlignment.Right,
            textString="window"),
          Line(
            points={{0,10},{10,10}},
            color={0,0,0},
            smooth=Smooth.None)}));
  end PartialCheckInSlidingWindowWithBooleanOutput;

  partial block PartialCheckInSlidingWindowWithPropertyOutput
    "Interfaces and icon for check block that evaluates a property in a sliding time window and returns the result as Property"

    input Boolean check(start = false) "Boolean to check"
       annotation(Dialog);
    parameter Modelica.SIunits.Time window(min=Modelica.Constants.eps)
      "Length of sliding time window (> 0)";
    Modelica_Requirements.Interfaces.PropertyOutput y "Property output signal"
      annotation (Placement(transformation(extent={{200,-10},{220,10}})));
    annotation (Diagram(coordinateSystem(
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
            extent={{0,-5},{185,-30}},
            lineColor={95,95,95},
            horizontalAlignment=TextAlignment.Right,
            textString="check"),
          Text(
            extent={{-190,-47},{190,-77}},
            lineColor={0,0,0},
            textString="%check"),
          Line(
            points={{-194,10},{-171,10}},
            color={0,0,0},
            smooth=Smooth.None),
          Line(
            points={{-186,10},{-186,65},{5,65},{5,10}},
            color={255,0,0},
            pattern=LinePattern.Dot),
          Rectangle(
            extent={{10,60},{190,10}},
            lineColor={0,0,0},
            lineThickness=5.0,
            fillColor={245,245,245},
            fillPattern=FillPattern.Solid,
            borderPattern=BorderPattern.Sunken),
          Text(
            extent={{10,47},{190,17}},
            lineColor={0,0,0},
            fillColor={255,0,0},
            fillPattern=FillPattern.Solid,
            textString="%window s"),
          Rectangle(
            extent={{-180,60},{0,10}},
            lineColor={0,0,0},
            lineThickness=5.0,
            fillColor={245,245,245},
            fillPattern=FillPattern.Solid,
            borderPattern=BorderPattern.Sunken),
          Text(
            extent={{0,85},{190,60}},
            lineColor={95,95,95},
            horizontalAlignment=TextAlignment.Right,
            textString="window"),
          Line(
            points={{0,10},{10,10}},
            color={0,0,0},
            smooth=Smooth.None)}));
  end PartialCheckInSlidingWindowWithPropertyOutput;

  partial block PartialConversion "Icon for conversion block"

    annotation (Icon(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}},
          grid={1,1}), graphics={
          Rectangle(
            extent={{-50,50},{50,-50}},
            lineColor={0,0,0},
            lineThickness=5.0,
            fillColor={210,210,210},
            fillPattern=FillPattern.Solid,
            borderPattern=BorderPattern.Raised), Text(
            extent={{-150,100},{150,60}},
            lineColor={175,175,175},
            textString="%name"),
          Line(
            points={{50,50},{-50,-50}},
            color={135,135,135},
            smooth=Smooth.None)}), Diagram(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}},
          grid={1,1})));
  end PartialConversion;

  record ObservationID
    "Identification of instance from which observations are used"
    extends Modelica.Icons.Record;

     parameter String name = ""
      "Name of instance from which variables are used for observation";

     annotation(defaultComponentName="observationID",
                defaultComponentPrefixes="inner",
   missingInnerMessage="No \"observationID\" component is defined. A default
observationID component with name=\"\" will be used. 
If this is not desired, drag Modelica_Requirements.Interfaces.ObservationID
into the top level of your model.");
  end ObservationID;

  partial block PartialRequirement
    "Common properties of all requirement blocks"
    import Modelica_Requirements.Types.Property;
    import Modelica.Utilities.Streams.print;

    parameter String text="" "Requirement stated in natural language";
    input Modelica_Requirements.Types.Property localProperty
      "Property that is required to be satisfied";

  protected
    outer Modelica_Requirements.Verify.PrintViolations printViolations;
    outer Modelica_Requirements.Interfaces.ObservationID observationID;

    /*
  outer parameter String observationName 
    "Name of instance from which variables are used for observation"
 annotation(missingInnerMessage="inner parameter String observationName is missing");
 */

    constant String instanceName = getInstanceName()
      "Instance name of Requirement";
    Boolean atLeastOneFailure "=true, if property = Violated at least one time";
    Boolean untested
      "= true, if property=Property.Undecided all the time, otherwise false";
    Real firstFailureTime;
    Real firstTestedTime;
    parameter Real startTime(fixed=false);

    /* Declarations used to enforce that the printViolationsToFile function is
  called before the printViolationsToOutput in the inner printViolations model.
  */
    model Dummy
      input Real one=1.0;
      input Real status=3.0;
      Modelica_Requirements.Internal.SortingPort sortingPort;
    equation
      sortingPort.one = one;
      sortingPort.status = status;
    end Dummy;
    Real ok;
    Real status "= 0 (Violated), =1 (Undecided), ... =2 (Satisfied)";
    Dummy dummy(one=ok,status=status);
  initial equation
    pre(localProperty)    = Property.Undecided;
    startTime             = time;
    pre(firstFailureTime) = startTime;
    pre(firstTestedTime)  = startTime;
    pre(ok) = 1.0;

    if localProperty == Property.Violated then
       atLeastOneFailure = true;
       untested          = false;
       pre(status)       = 0;
    elseif localProperty == Property.Undecided then
       atLeastOneFailure = false;
       untested          = true;
       pre(status)       = 1;
    else
       atLeastOneFailure = false;
       untested          = false;
       pre(status)       = 2;
    end if;

  equation
    /* Print information about violated and untested requirements to file.
  The problem is that during event iteration the property variable can change
  between different values and for the printing only the last value of the 
  event iteration matters. This "last" value is approximately determined 
  with the "if abs(time - firstXXXTime)" clause.
  */

  algorithm
    when not terminal() and change(localProperty) then
       if not pre(atLeastOneFailure) and localProperty==Property.Violated then
          atLeastOneFailure :=true;
          firstFailureTime :=time;
       elseif pre(atLeastOneFailure) and time <= firstFailureTime and
            (localProperty==Property.Satisfied or localProperty==Property.Undecided) then
          // current event iteration changed property to Satisfied or Undecided
          atLeastOneFailure := false;
          firstFailureTime := startTime;
       end if;

       if pre(untested) and
          (localProperty==Property.Satisfied or localProperty==Property.Violated) then
          untested :=false;
          firstTestedTime := time;
       elseif not pre(untested) and time <= firstTestedTime and
              localProperty==Property.Undecided then
           // current event iteration changed property back to Undecided
          untested := true;
          firstTestedTime := startTime;
       end if;

       status :=if atLeastOneFailure then 0 else (if untested then 1 else 2);
    end when;

  equation
    connect(dummy.sortingPort, printViolations.sortingPort);

    when terminal() then
      ok =Modelica_Requirements.Internal.printViolationsToLogFile(
          printViolations.logFile,
          observationID.name,
          instanceName,
          text,
          atLeastOneFailure,
          untested,
          firstFailureTime);
    end when;
    annotation (Diagram(coordinateSystem(
            preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
                                                      graphics),
      Documentation(info="<html>
<p>
This block is used to verify a requirement. The input signal \"property\" can have the
three values Violated, Undecided, or Satisfied. The goal is that \"property\" is always Satisfied.
A requirement is violated, if property = Violated. It is untested, if property=Undecided.
A Boolean signal can be casted to the three-valued logic required by \"property\"
by cast blocks, such as 
<a href=\"modelica://Modelica_Requirements.LogicalBlocks.ToProperty\">ToProperty</a>,
<a href=\"modelica://Modelica_Requirements.LogicalBlocks.During\">During</a>, or
<a href=\"modelica://Modelica_Requirements.Temporal.WhenRising\">WhenRising</a>
</p>

<p>
In the top level of a model, block <a href=\"modelica://Modelica_Requirements.Verify.PrintViolations\">PrintViolations</a>
has to be dragged. This block prints an information message at the end of a simulation, whether
a Requirement has been violated or untested in the current simulation run.
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
<a href=\"modelica://Modelica_Requirements.Examples.Textual.Elementary.Verify.Requirement\">Examples.Textual.Elementary.Verify.Requirement</a>.
</p>
</html>"));
  end PartialRequirement;

  partial record PartialWatching
    "Partial definition of watch record to observe the signals from a source"
    extends Modelica.Icons.Record;
    String name = "Unknown" "Full path name of data source";
  end PartialWatching;

  partial block PartialRequirements "Partial requirements block"

    parameter String observationName="Unknown"
      "Name of instance from which variables are used for observation"
      annotation(Dialog(group="Observation variables"));
  protected
    inner Modelica_Requirements.Interfaces.ObservationID observationID(name=observationName);

    annotation (
      Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
              100}}),   graphics={Rectangle(
          extent={{-100,-100},{100,100}},
          lineColor={0,0,127},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid), Text(
            extent={{-250,150},{250,110}},
            textString="%name",
            lineColor={175,175,175}),       Line(
            points={{-86,-14},{-62,-48},{-28,40}},
            color={0,127,0},
            smooth=Smooth.None,
            thickness=0.5),
          Text(
            extent={{-150,-110},{150,-140}},
            lineColor={0,0,0},
            textString="%observationName")}),
    Documentation(info="<html>
<p>
Block that has only the basic icon for an input/output
block (no declarations, no equations). Most blocks
of package Modelica.Blocks inherit directly or indirectly
from this block.
</p>
</html>"));
  end PartialRequirements;

  partial block PartialVerify
    "Partial model containing the common interfaces to check requirements"
      parameter Boolean printViolated = true
      "= true, if violated requirements shall be printed"
       annotation(choices(checkBox=true));
      parameter Boolean printUntested = true
      "= true, if untested requirements shall be printed"
       annotation(choices(checkBox=true));
      parameter Boolean printSatisfied = true
      "= true, if satisfied requirements shall be printed"
       annotation(choices(checkBox=true));
    final output Real satisfaction = printViolations.satisfaction
      "Satisfaction of all requirements in % (0% ... 100%)";

    inner Verify.PrintViolations printViolations(final printViolated=printViolated,
       final printUntested=printUntested, final printSatisfied=printSatisfied)
      annotation (Placement(transformation(extent={{-100,80},{-80,100}})));

    annotation (
      Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
                        graphics={Rectangle(
          extent={{-100,-100},{100,100}},
          lineColor={0,0,127},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid), Text(
          extent={{-250,150},{250,110}},
          textString="%name",
          lineColor={0,0,255}),             Line(
            points={{-48,0},{-8,-58},{54,68}},
            color={0,127,0},
            smooth=Smooth.None,
            thickness=1),
          Text(
            extent={{-200,-105},{20,-145}},
            lineColor={0,0,0},
            horizontalAlignment=TextAlignment.Right,
            textString="satisfaction:"),
          Text(
            extent={{0,-105},{100,-145}},
            lineColor={0,0,0},
            textStyle={TextStyle.Bold},
            textString=DynamicSelect("   ",String(satisfaction, format="3.1f")),
            horizontalAlignment=TextAlignment.Right),
          Text(
            extent={{105,-105},{130,-145}},
            lineColor={0,0,0},
            horizontalAlignment=TextAlignment.Left,
            textString="%%")}),
    Documentation(info="<html>
</html>"));
  end PartialVerify;

end Interfaces;
