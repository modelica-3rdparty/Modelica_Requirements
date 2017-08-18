within Modelica_Requirements.Examples;
package BackupPowerSupply
  "Example package to evaluate the requirements of the EDF Backup Power Supply benchmark (using a graphical definition)"
    extends Modelica.Icons.ExamplesPackage;
    model MainPowerSupplyRequirements
    "Evaluating the requirement definitions for the Main Power Supply system"
    extends Modelica.Icons.Example;
    inner Verify.PrintViolations printViolations(printSatisfied=true)
      annotation (Placement(transformation(extent={{40,60},{60,80}})));

    Modelica.Blocks.Sources.CombiTimeTable MPSVoltageTable(table=[0,240; 10,
          220; 20,165; 30,150; 40,165; 50,190; 60,220; 70,210])
      annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
    Modelica.Blocks.Sources.BooleanTable onTable(table={0,10,15,18,25,30,40,50,
          60,70})
      annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
    Modelica.Blocks.Sources.BooleanTable availableTable(table={0,15,25,35,45,55,65,
          70})
      annotation (Placement(transformation(extent={{-80,-40},{-60,-20}})));

    Components.MPS MPS
      annotation (Placement(transformation(extent={{-20,0},{20,40}})));
    equation

    connect(MPSVoltageTable.y[1], MPS.MPSVoltage) annotation (Line(
        points={{-59,30},{-40,30},{-40,26},{-22,26}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(onTable.y, MPS.On) annotation (Line(
        points={{-59,0},{-40,0},{-40,18},{-22,18}},
        color={255,0,255},
        smooth=Smooth.None));
    connect(availableTable.y, MPS.Available) annotation (Line(
        points={{-59,-30},{-34,-30},{-34,10},{-22,10}},
        color={255,0,255},
        smooth=Smooth.None));
    annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
              100,100}}),        graphics), experiment(StopTime=70),
    Documentation(info="<html>
<p>
Using the given input signals <b>MBSVoltage</b>, <b>On</b>, and 
<b>Available</b> results in<br>
</p>

<table border=0 cellspacing=0 cellpadding=2>
<tr><td width=\"50\"></td>
    <td><img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/MainPowerSupplyRequirements/MPS1.png\"></td>
   </tr>
</table>

<table border=0 cellspacing=0 cellpadding=2>
<tr><td width=\"160\"></td>
    <td>Simulation results for requirements R1 and R2:<br>
    R1: MPS CAN be declared Off when the voltage gets below 170 V<br>
    R2: MPS MUST be declared Off when the voltage gets below 160 V</td>
   </tr>
</table>

<p>
&nbsp;
</p>

<table border=0 cellspacing=0 cellpadding=2>
<tr><td width=\"50\"></td>
    <td><img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/MainPowerSupplyRequirements/MPS2.png\"></td>
   </tr>
</table>

<table border=0 cellspacing=0 cellpadding=2>
<tr><td width=\"160\"></td>
    <td>Simulation results for requirements R3 and R4:<br>
    R3: MPS CAN be declared On again when the voltage gets above 200 V<br>
    R4: MPS MUST be declared On again when the voltage gets above 210 V</td>
   </tr>
</table>

<p>
At the end of the simulation, the following information is printed to the output window:
</p>


<blockquote>
<pre>
Requirements violated:
   MPS.R1 (at time = 10 s)
   MPS.R2 (at time = 25 s)
   MPS.R3 (at time = 15 s)
   MPS.R4 (at time = 10 s)
   MPS.R7 (at time = 0 s)

Requirements untested:
   MPS.R8
</pre>
</blockquote>
</html>"));
    end MainPowerSupplyRequirements;

  package Components
    "Utility components needed for Backup-Power-Supply examples"
    extends Modelica.Icons.UtilitiesPackage;

    block MPS
      "Requirements for Main Power Supply (MPS) defined in graphical form"

      /* FORM-L

     Set 1 of requirements
     external real MBSVoltage;
     external Boolean on;
     Boolean Off = not(On);
     requirement during (MBSVoltage > V170) check no (Off becomes true)  ????
     requirement during (MBSVoltage < V160) check off
     requirement during (MBSVoltage < 200) check no (On becomes true) ????
     requirement during (MBSVoltage) > V210) check on

     Set 2 of requirements
     external fsa Availability = {Available; Unavailable};
     event eLoss = when Availability becomes Unavailable;
     event eRestore = when Availability becomes Available;
     
     private condition C1a = duringAny s4 check Off;
     private condition C1b = duringAny s10 check duration(Off) >= s4;
     private condition C2a = duringAny s6 check Off;
     private condition C2b = duringAny s10 check duration(Off) >= s6;

     requirement during (Available and not(C1a or C1b)) check no eLoss;
     requirement during (C2a or C2b) check Unavailable;
     requirement during (Unavailable and not(duringAny s8 check On)) check no eRestore;
     requirement during (duringAny s10 check On) check Available;
  */

      // Modelica
      extends Modelica_Requirements.Interfaces.PartialEnvironment;

      // Interface to this block
      Modelica.Blocks.Interfaces.RealInput MPSVoltage(unit="V")
        "Voltage of MPS"                                                         annotation (Placement(
            transformation(extent={{-240,40},{-200,80}}), iconTransformation(extent=
               {{-240,40},{-200,80}})));
      Modelica.Blocks.Interfaces.BooleanInput On(start=false, fixed=true)
        "= true, if MPS is on"   annotation (Placement(
            transformation(extent={{-240,-80},{-200,-40}}), iconTransformation(
              extent={{-240,-40},{-200,0}})));

      Modelica.Blocks.Interfaces.BooleanInput Available(start=false,fixed=true)
        "= true, if MPS is available" annotation (Placement(transformation(extent={{-240,
                -20},{-200,20}}),      iconTransformation(extent={{-240,-120},{-200,
                -80}})));
      Modelica_Requirements.Interfaces.EventOutput eLoss
        "Signals that the MPS has transited from available to unavailable" annotation (Placement(
            transformation(extent={{-10,-10},{10,10}},
            rotation=-90,
            origin={-80,-270}),                             iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=-90,
            origin={-120,-210})));
      Modelica_Requirements.Interfaces.EventOutput eRestore
        "Signals that the MPS has transited from unavailable to available" annotation (Placement(
            transformation(extent={{-10,-10},{10,10}},
            rotation=-90,
            origin={20,-270}),                              iconTransformation(
            extent={{-10,-10},{10,10}},
            rotation=-90,
            origin={122,-210})));

      Modelica.Blocks.MathBoolean.Not Off
        annotation (Placement(transformation(extent={{-190,-64},{-182,-56}})));
      Verify.Requirement R1(text="MPS CAN be declared Off
when the voltage
gets below 170 V")
        annotation (Placement(transformation(extent={{-60,140},{20,160}})));
      Verify.Requirement R2(text="MPS MUST be declared Off
when the voltage
gets below 160 V")
        annotation (Placement(transformation(extent={{-60,110},{20,130}})));
      Verify.Requirement R3(text="MPS CAN be declared On again
when the voltage
gets above 200 V")
        annotation (Placement(transformation(extent={{-60,80},{20,100}})));
      Verify.Requirement R4(text="MPS MUST be declared On again
when the voltage
gets above 210 V")
        annotation (Placement(transformation(extent={{-60,50},{20,70}})));
      Modelica.Blocks.MathBoolean.Not Unavailable
        annotation (Placement(transformation(extent={{-164,-4},{-156,4}})));
      LogicalBlocks.DelayedRising
                    duringAny1(duration=4, u=Off.y)
        "= true, when MPS has been Off for more than 4 consecutive seconds"
        annotation (Placement(transformation(extent={{-120,-20},{-80,0}})));
      ChecksInSlidingWindow.MinAccumulatedDuration2
                            duringAcc1(
        window=10,
        lowerLimit=4,
        check=Off.y)
        "= true, when MPS has been Off for more than 4 accumulated seconds during any 10 seconds time window"
        annotation (Placement(transformation(extent={{-120,-60},{-80,-40}})));
      Modelica.Blocks.Logical.Or or1
        annotation (Placement(transformation(extent={{-60,-40},{-40,-20}})));
      Verify.Requirement R5(text=
    "MPS CAN be declared Unavailable
when it has been Off
for more than 4 consecutive seconds or
for more than 4 accumulated seconds
during any 10 seconds time window")
        annotation (Placement(transformation(extent={{40,-44},{120,-16}})));
      LogicalBlocks.DelayedRising
                    duringAny2(duration=6, u=Off.y)
        "= true, when MPS has been Off for more than 6 consecutive seconds"
        annotation (Placement(transformation(extent={{-120,-100},{-80,-80}})));
      ChecksInSlidingWindow.MinAccumulatedDuration2
                            duringAcc2(
        window=10,
        lowerLimit=6,
        check=Off.y)
        "= true, when MPS has been Off for more than 6 accumulated seconds during any 10 seconds time window"
        annotation (Placement(transformation(extent={{-120,-140},{-80,-120}})));
      Modelica.Blocks.Logical.Or or2 annotation (Placement(transformation(
              extent={{-60,-120},{-40,-100}})));
      ChecksInFixedWindow.During
                 during3(check=Unavailable.y)
        annotation (Placement(transformation(extent={{-20,-120},{20,-100}})));
      Verify.Requirement R6(text=
    "MPS MUST be declared Unavailable
when it has been Off
for more than 6 consecutive seconds or
for more than 6 accumulated seconds
during any 10 seconds time window")
        annotation (Placement(transformation(extent={{40,-126},{120,-94}})));
      LogicalBlocks.DelayedRising
                    duringAny3(duration=8, u=On)
        "= true, when MPS has been Off for more than 6 consecutive seconds"
        annotation (Placement(transformation(extent={{-120,-180},{-80,-160}})));
      Verify.Requirement R7(text=
    "MPS CAN be declared Available again
when On for more than
8 consecutive seconds")
        annotation (Placement(transformation(extent={{20,-180},{100,-160}})));
      LogicalBlocks.DelayedRising
                    duringAny4(duration=10, u=On)
        "= true, when MPS has been Off for more than 6 consecutive seconds"
        annotation (Placement(transformation(extent={{-120,-220},{-80,-200}})));
      ChecksInFixedWindow.During
                 during4(check=Available)
        annotation (Placement(transformation(extent={{-60,-220},{-20,-200}})));
      Verify.Requirement R8(text=
    "MPS MUST be declared Available again
when On for more than
10 consecutive seconds")
        annotation (Placement(transformation(extent={{20,-220},{100,-200}})));
      Modelica.Blocks.Logical.Edge edge1 annotation (Placement(transformation(
              extent={{-120,-260},{-100,-240}})));
      Modelica.Blocks.Logical.Edge edge2 annotation (Placement(transformation(
              extent={{-40,-260},{-20,-240}})));
      ChecksInFixedWindow.WhenRising whenRising1(check=Off.y)
        annotation (Placement(transformation(extent={{-120,140},{-80,160}})));
      Sources.BooleanExpression expr1(y=MPSVoltage < 170)
        annotation (Placement(transformation(extent={{-180,140},{-140,160}})));
      ChecksInFixedWindow.During during1(check=Off.y)
        annotation (Placement(transformation(extent={{-120,110},{-80,130}})));
      Sources.BooleanExpression expr2(y=MPSVoltage < 160)
        annotation (Placement(transformation(extent={{-180,110},{-140,130}})));
      ChecksInFixedWindow.WhenRising whenRising2(check=On)
        annotation (Placement(transformation(extent={{-120,80},{-80,100}})));
      Sources.BooleanExpression expr3(y=MPSVoltage > 200)
        annotation (Placement(transformation(extent={{-180,80},{-140,100}})));
      ChecksInFixedWindow.During during2(check=On)
        annotation (Placement(transformation(extent={{-120,50},{-80,70}})));
      Sources.BooleanExpression expr4(y=MPSVoltage > 210)
        annotation (Placement(transformation(extent={{-180,50},{-140,70}})));
      ChecksInFixedWindow.WhenRising whenRising3(check=Unavailable.y)
        annotation (Placement(transformation(extent={{-20,-40},{20,-20}})));
      ChecksInFixedWindow.WhenRising whenRising4(check=duringAny3.y)
        annotation (Placement(transformation(extent={{-40,-180},{0,-160}})));
    equation
      connect(On, Off.u) annotation (Line(
          points={{-220,-60},{-191.6,-60}},
          color={255,0,255},
          smooth=Smooth.None));

      connect(Unavailable.u, Available) annotation (Line(
          points={{-165.6,0},{-220,0}},
          color={255,0,255},
          smooth=Smooth.None));
      connect(duringAny1.y, or1.u1) annotation (Line(
          points={{-79,-10},{-72,-10},{-72,-30},{-62,-30}},
          color={255,0,255},
          smooth=Smooth.None));
      connect(duringAcc1.y, or1.u2) annotation (Line(
          points={{-79,-50},{-72,-50},{-72,-38},{-62,-38}},
          color={255,0,255},
          smooth=Smooth.None));

      connect(duringAny2.y, or2.u1) annotation (Line(
          points={{-79,-90},{-74,-90},{-74,-110},{-62,-110}},
          color={255,0,255},
          smooth=Smooth.None));
      connect(duringAcc2.y, or2.u2) annotation (Line(
          points={{-79,-130},{-74,-130},{-74,-118},{-62,-118}},
          color={255,0,255},
          smooth=Smooth.None));
      connect(or2.y, during3.condition) annotation (Line(
          points={{-39,-110},{-32,-110},{-32,-109.9},{-22,-109.9}},
          color={255,0,255},
          smooth=Smooth.None));
      connect(during3.y, R6.property) annotation (Line(
          points={{21,-110},{37.3333,-110}},
          color={255,0,128},
          smooth=Smooth.None));
      connect(duringAny4.y, during4.condition) annotation (Line(
          points={{-79,-210},{-72.5,-210},{-72.5,-209.9},{-62,-209.9}},
          color={255,0,255},
          smooth=Smooth.None));
      connect(during4.y, R8.property) annotation (Line(
          points={{-19,-210},{17.3333,-210}},
          color={255,0,128},
          smooth=Smooth.None));
      connect(Unavailable.y, edge1.u) annotation (Line(
          points={{-155.2,0},{-146,0},{-146,-250},{-122,-250}},
          color={255,0,255},
          smooth=Smooth.None));
      connect(edge1.y, eLoss) annotation (Line(
          points={{-99,-250},{-80,-250},{-80,-270}},
          color={255,0,255},
          smooth=Smooth.None));
      connect(edge2.y, eRestore) annotation (Line(
          points={{-19,-250},{20,-250},{20,-270}},
          color={255,0,255},
          smooth=Smooth.None));
      connect(whenRising1.y, R1.property) annotation (Line(
          points={{-79,150},{-62.6667,150}},
          color={255,0,128},
          smooth=Smooth.None));
      connect(expr1.y, whenRising1.condition) annotation (Line(
          points={{-139,150},{-128,150},{-128,150.1},{-122,150.1}},
          color={255,0,255},
          smooth=Smooth.None));
      connect(during1.y, R2.property) annotation (Line(
          points={{-79,120},{-62.6667,120}},
          color={255,0,128},
          smooth=Smooth.None));
      connect(expr2.y, during1.condition) annotation (Line(
          points={{-139,120},{-128,120},{-128,120.1},{-122,120.1}},
          color={255,0,255},
          smooth=Smooth.None));
      connect(whenRising2.y, R3.property) annotation (Line(
          points={{-79,90},{-62.6667,90}},
          color={255,0,128},
          smooth=Smooth.None));
      connect(expr3.y, whenRising2.condition) annotation (Line(
          points={{-139,90},{-130,90},{-130,90.1},{-122,90.1}},
          color={255,0,255},
          smooth=Smooth.None));
      connect(expr4.y, during2.condition) annotation (Line(
          points={{-139,60},{-130,60},{-130,60.1},{-122,60.1}},
          color={255,0,255},
          smooth=Smooth.None));

      connect(Available, whenRising4.condition) annotation (Line(
          points={{-220,0},{-174,0},{-174,-150},{-56,-150},{-56,-169.9},{-42,
              -169.9}},
          color={255,0,255},
          smooth=Smooth.None));
      connect(whenRising4.y, R7.property) annotation (Line(
          points={{1,-170},{17.3333,-170}},
          color={255,0,128},
          smooth=Smooth.None));
      connect(whenRising3.y, R5.property) annotation (Line(
          points={{21,-30},{37.3333,-30}},
          color={255,0,128},
          smooth=Smooth.None));
      connect(during2.y, R4.property) annotation (Line(
          points={{-79,60},{-62.6667,60}},
          color={255,0,128},
          smooth=Smooth.None));
      connect(edge2.u, whenRising4.condition) annotation (Line(
          points={{-42,-250},{-70,-250},{-70,-150},{-56,-150},{-56,-169.9},{-42,
              -169.9}},
          color={255,0,255},
          smooth=Smooth.None));
      connect(or1.y, whenRising3.condition) annotation (Line(points={{-39,-30},{-22,
              -30},{-22,-29.9}}, color={255,0,255}));
      annotation (
         Icon(coordinateSystem(preserveAspectRatio=false,extent={{-200,-200},
                {200,200}}),  graphics={
            Text(
              extent={{-190,84},{54,40}},
              lineColor={95,95,95},
              textString="MPSVoltage",
              horizontalAlignment=TextAlignment.Left),
            Text(
              extent={{-188,2},{56,-42}},
              lineColor={95,95,95},
              horizontalAlignment=TextAlignment.Left,
              textString="On"),
            Text(
              extent={{-188,-76},{56,-120}},
              lineColor={95,95,95},
              horizontalAlignment=TextAlignment.Left,
              textString="Available"),
            Text(
              extent={{-208,-146},{-36,-190}},
              lineColor={95,95,95},
              textString="eLoss"),
            Text(
              extent={{30,-148},{202,-192}},
              lineColor={95,95,95},
              textString="eRestore")}), Diagram(coordinateSystem(
              preserveAspectRatio=false, extent={{-200,-260},{120,180}})));
    end MPS;

  end Components;
end BackupPowerSupply;
