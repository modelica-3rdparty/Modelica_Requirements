within Modelica_Requirements;
package Sources
  "Library of signal source blocks generating Real, Integer, Boolean and Property signals"
  block RealConstant "Output y is a Real parameter"
    extends Modelica_Requirements.Interfaces.PartialConstant;

    parameter Real c=0.0 "Fixed Real output value";
    Modelica.Blocks.Interfaces.RealOutput y "Value of Real output"
                                annotation (Placement(transformation(
            extent={{100,-10},{120,10}}, rotation=0), iconTransformation(extent={{100,-10},
              {120,10}})));
  equation
    y = c;
    annotation(defaultComponentName="const1",
        Icon(graphics={
          Text(
            extent={{-90,-15},{90,15}},
            lineColor={0,0,0},
            textString="%c")}),
  Documentation(info="<html>
<p>
Output y is the Real constant <b>c</b> defined in the parameter menu.
</p>

<p>
Alternatively component <a href=\"modelica://Modelica_Requirements.Sources.RealExpression\">RealExpression</a>
could be used to define a constant. The advantage of RealConstant is that a literal value
given as parameter can still be changed after model translation which is not the case for a
literal value defined with RealExpression.
</p>
</html>"));
  end RealConstant;
  extends Modelica.Icons.Package;

  block IntegerConstant "Output y is an Integer parameter"
    extends Modelica_Requirements.Interfaces.PartialConstant;

    parameter Integer c=0 "Fixed Integer output value";
    Modelica.Blocks.Interfaces.IntegerOutput y "Value of Integer output"
                                annotation (Placement(transformation(
            extent={{100,-10},{120,10}}, rotation=0), iconTransformation(extent={{100,-10},
              {120,10}})));
  equation
    y = c;
    annotation(defaultComponentName="const1",
        Icon(graphics={
          Text(
            extent={{-90,-15},{90,15}},
            lineColor={0,0,0},
            textString="%c")}),
  Documentation(info="<html>
<p>
Output y is the Integer constant <b>c</b> defined in the parameter menu.
</p>

<p>
Alternatively component <a href=\"modelica://Modelica_Requirements.Sources.IntegerExpression\">IntegerExpression</a>
could be used to define a constant. The advantage of IntegerConstant is that a literal value
given as parameter can still be changed after model translation which is not the case for a
literal value defined with IntegerExpression.
</p>
</html>"));
  end IntegerConstant;

  block BooleanConstant "Output y is a Boolean parameter"
    extends Modelica_Requirements.Interfaces.PartialConstant;

    parameter Boolean c=true "Fixed Boolean output value" annotation(choices(checkBox=true));
    Modelica.Blocks.Interfaces.BooleanOutput y
      annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  equation
    y = c;
    annotation (defaultComponentName="const1",
        Icon(graphics={
          Text(
            extent={{-90,-15},{90,15}},
            lineColor={0,0,0},
            textString="%c")}),
        Documentation(info="<html>
<p>
Output y is the Boolean constant <b>c</b> defined in the parameter menu.
</p>

<p>
Alternatively component <a href=\"modelica://Modelica_Requirements.Sources.BooleanExpression\">BooleanExpression</a>
could be used to define a constant. The advantage of BooleanConstant is that a literal value
given as parameter can still be changed after model translation which is not the case for a
literal value defined with BooleanExpression.
</p>
</html>"));
  end BooleanConstant;

  block PropertyConstant "Output y is a Property parameter"
    extends Modelica_Requirements.Interfaces.PartialConstant;

    parameter Modelica_Requirements.Types.Property c=Modelica_Requirements.Types.Property.Satisfied
      "Fixed Property output value"
      annotation(Dialog(__Dymola_compact=true, __Dymola_descriptionLabel = true),
                          choices(choice=Modelica_Requirements.Types.Property.Violated
          "Violated",     choice=Modelica_Requirements.Types.Property.Undecided
          "Undecided",    choice=Modelica_Requirements.Types.Property.Satisfied
          "Satisfied",    __Dymola_radioButtons=true));
    Modelica_Requirements.Interfaces.PropertyOutput y
      "Constant Property output value"
      annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  equation
    y = c;
    annotation (
    defaultComponentName="const1",
        Icon(graphics={
          Text(
            extent={{-90,-15},{90,15}},
            lineColor={0,0,0},
            textString="%c")}),
        Documentation(info="<html>
<p>
Output y is the <a href=\"modelica://Modelica_Requirements.Types.Property\">Property</a>
constant <b>c</b> defined in the parameter menu.
</p>
</html>"));
  end PropertyConstant;

  block RealExpression "Output y is a (time-varying) Real expression"
    extends Modelica_Requirements.Interfaces.PartialExpression;

    Modelica.Blocks.Interfaces.RealOutput y = 0.0 "Value of Real output"
                                annotation (Dialog,  Placement(transformation(
            extent={{200,-10},{220,10}}, rotation=0), iconTransformation(extent={{200,-10},
              {220,10}})));

    annotation(defaultComponentName="expr1",
        Icon(graphics={
          Text(
            extent={{-190,-15},{190,15}},
            lineColor={0,0,0},
            textString="%y")}),
  Documentation(info="<html>
<p>
Output y is defined as an arbitrary (time-varying) Real expression
in the parameter menu.
</p>
</html>"),
      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-200,-100},{200,
              100}}), graphics));
  end RealExpression;

  block IntegerExpression "Output y is a (time-varying) Integer expression"
    extends Modelica_Requirements.Interfaces.PartialExpression;

    Modelica.Blocks.Interfaces.IntegerOutput y = 0 "Value of Integer output"
                                annotation (Dialog,  Placement(transformation(
            extent={{200,-10},{220,10}}, rotation=0)));

    annotation(defaultComponentName="expr1",
        Icon(graphics={
          Text(
            extent={{-190,-15},{190,15}},
            lineColor={0,0,0},
            textString="%y")}),
                           Documentation(info="<html>
<p>
Output y is defined as an arbitrary (time-varying) Integer expression
in the parameter menu.
</p>
</html>"),
      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-200,-100},{200,
              100}}), graphics));
  end IntegerExpression;

  block BooleanExpression "Output y is a (time-varying) Boolean expression"
    extends Modelica_Requirements.Interfaces.PartialExpression;

    Modelica.Blocks.Interfaces.BooleanOutput y = false
      "Value of Boolean output" annotation (Dialog,  Placement(transformation(
            extent={{200,-10},{220,10}}, rotation=0)));

    annotation(defaultComponentName="expr1",
        Icon(graphics={
          Text(
            extent={{-190,-15},{190,15}},
            lineColor={0,0,0},
            textString="%y")}),
  Documentation(info="<html>
<p>
Output y is defined as an arbitrary (time-varying) Boolean expression
in the parameter menu.
</p>
</html>"),
      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-200,-100},{
              200,100}}), graphics));
  end BooleanExpression;

  block PropertyTable
    "Output y is a Property signal computed by constant interpolation in a table matrix with [time, property] values"
    parameter Real table[:, 2]=fill(
          0,
          0,
          2)
      "Table matrix (first column time; second column y as Integer: =1 (Violated), =2 (Undecided), =3 (Satisfied))";

    Modelica_Requirements.Interfaces.PropertyOutput y
      "Constantly interpolated table value"
      annotation (Placement(transformation(extent={{100,-10},{120,10}})));
    Modelica.Blocks.Sources.IntegerTable integerTable(table=table)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
    LogicalBlocks.IntegerToProperty ItoP "Transform Integer to Property"
      annotation (Placement(transformation(extent={{20,-10},{40,10}})));
  equation
    connect(integerTable.y, ItoP.u) annotation (Line(
        points={{11,0},{23,0}},
        color={255,127,0},
        smooth=Smooth.None));
    connect(ItoP.y, y) annotation (Line(
        points={{36,0},{110,0}},
        color={255,0,128},
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics),
                                 Icon(coordinateSystem(preserveAspectRatio=false,
            extent={{-100,-100},{100,100}}), graphics={
                                             Rectangle(
              extent={{-100,-100},{100,100}},
              lineColor={255,0,128},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid), Text(
              extent={{-150,150},{150,110}},
              textString="%name",
              lineColor={0,0,255}),
          Line(points={{-80,64},{-80,-84}}, color={192,192,192}),
          Polygon(
            points={{-80,86},{-88,64},{-72,64},{-80,86}},
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Line(points={{-90,-74},{82,-74}}, color={192,192,192}),
          Polygon(
            points={{90,-74},{68,-66},{68,-82},{90,-74}},
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-46,68},{4,-52}},
            lineColor={255,255,255},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Line(points={{-46,-52},{-46,68},{54,68},{54,-52},{-46,-52},{-46,-22},{54,
                -22},{54,8},{-46,8},{-46,38},{54,38},{54,68},{4,68},{4,-53}},
              color={0,0,0})}));
  end PropertyTable;

  annotation (Icon(graphics={Line(
          points={{-76,0},{82,0}},
          color={135,135,135},
          smooth=Smooth.None,
          thickness=0.5),      Polygon(
          points={{82,0},{8,40},{8,-36},{82,0}},
          lineColor={135,135,135},
          smooth=Smooth.None,
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid)}));
end Sources;
