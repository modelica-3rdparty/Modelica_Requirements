within Modelica_Requirements.Examples;
package SimplePumpingSystem
  "Simple example system to demonstrate requirements definition and checking"
  model CheckPumpingSystem "Check model PumpingSystem"
    import
      Modelica_Requirements.Examples.SimplePumpingSystem.Components.Bindings;
    extends
      Modelica_Requirements.Examples.SimplePumpingSystem.Components.PumpingSystem;

    inner Verify.PrintViolations printViolations(printSatisfied=true)
      annotation (Placement(transformation(extent={{120,80},{140,100}})));

    SimplePumpingSystem.Components.Requirements.TankRequirements tankRequirements(
        observationName="reservoir",
        observation=Bindings.TankObservation_from_OpenTank( reservoir))
      annotation (Placement(transformation(extent={{120,40},{140,60}})));

    SimplePumpingSystem.Components.Requirements.PumpRequirements pumpRequirements(
        observationName="pumps",
        observation=Bindings.PumpObservation_from_PrescribedPump(pumps))
      annotation (Placement(transformation(extent={{120,0},{140,20}})));
    Components.Requirements.SourceRequirements sourceRequirements1(
        observationName="source",
        observation=Bindings.SourceObservation_from_PartialSource(source))
      annotation (Placement(transformation(extent={{120,-40},{140,-20}})));
    Components.Requirements.SourceRequirements sourceRequirements2(
        observationName="sink",
        observation=Bindings.SourceObservation_from_PartialSource(sink))
      annotation (Placement(transformation(extent={{120,-82},{140,-62}})));
    annotation(experiment(StopTime=2000, Tolerance=1e-006),
      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{160,
              100}})),
      Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}})));
  end CheckPumpingSystem;
  extends Modelica.Icons.ExamplesPackage;


  package Components "Utility components needed for example"
    extends Modelica.Icons.UtilitiesPackage;

    model PumpingSystem "Model of a pumping system for drinking water"
      extends Modelica.Fluid.Examples.PumpingSystem(pumps(p_b_start=600000, T_start=system.T_start));
    equation

      annotation (Documentation(info="<html>
<p>
Water is pumped from a source by a pump (fitted with check valves), through a pipe whose outlet is 50 m higher than the source, into a reservoir. The users are represented by an equivalent valve, connected to the reservoir.
</p>
<p>
The water controller is a simple on-off controller, regulating on the gauge pressure measured at the base of the tower; the output of the controller is the rotational speed of the pump, which is represented by the output of a first-order system. A small but nonzero rotational speed is used to represent the standby state of the pumps, in order to avoid singularities in the flow characteristic.
</p>
<p>
Simulate for 2000 s. When the valve is opened at time t=200, the pump starts turning on and off to keep the reservoir level around 2 meters, which roughly corresponds to a gauge pressure of 200 mbar.
</p>

<p><blockquote>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Examples/PumpingSystem.png\" border=\"1\"
     alt=\"PumpingSystem.png\">
</blockquote></p>
</html>", revisions="<html>
<ul>
<li><i>Jan 2009</i>
    by R&uuml;diger Franke:<br>
       Reduce diameters of pipe and reservoir ports; use separate port for measurement of reservoirPressure, avoiding disturbances due to pressure losses.</li>
<li><i>1 Oct 2007</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       Parameters updated.</li>
<li><i>2 Nov 2005</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       Created.</li>
</ul>
</html>"),
        experiment(StopTime=2000, Interval=0.4, Tolerance=1e-006));
    end PumpingSystem;

    package Requirements "Observation records"
      package Records
        "Records containing observation variables needed by the Requirement models"
           extends Modelica.Icons.Package;
         record Tank "Observation variables from a tank"
           extends Modelica.Icons.Record;
           Modelica.SIunits.Height level "Tank level" annotation(Dialog);
         end Tank;

         record Pump "Observation variables from a pump"
            import NonSI = Modelica.SIunits.Conversions.NonSIunits;
            extends Modelica.Icons.Record;

            NonSI.AngularVelocity_rpm speed "Pump speed";
            Modelica.SIunits.AbsolutePressure p_port_a "Pressure at port_a" annotation(Dialog);
            Modelica.SIunits.AbsolutePressure p_port_b "Pressure at port_b" annotation(Dialog);
         end Pump;

         record Source "Observation variables from a source component"
            import NonSI = Modelica.SIunits.Conversions.NonSIunits;
            extends Modelica.Icons.Record;

            Modelica.SIunits.AbsolutePressure p[:] "Pressures at vector port" annotation(Dialog);
         end Source;
      end Records;
       extends Modelica.Icons.Package;

      block TankRequirements "Requirements for a Tank"
        extends Modelica_Requirements.Interfaces.PartialRequirements;

        parameter Modelica.SIunits.Height levelMax=2.21 "Maximum allowed level";
        parameter Modelica.SIunits.Height levelMin=1.8 "Minimum allowed level";
        parameter Modelica.SIunits.Height limLevel=2.0
          "Level cannot be lower as LimLevel for more as LimDuration";
        parameter Modelica.SIunits.Time limDuration=300
          "Maximum allowed duration for LimLevel";

        input Records.Tank observation
          "Observation variables record from a tank" annotation (Dialog(group=
                "Observation variables"), Placement(transformation(extent={{-100,
                  80},{-80,100}})));

        Modelica.Blocks.MathBoolean.Not not1
          annotation (Placement(transformation(extent={{2,6},{10,14}})));
        Modelica_Requirements.Verify.BooleanRequirement R_InBand(text="Tank level must be within given bounds")
          annotation (Placement(transformation(extent={{20,50},{80,70}})));
        Modelica_Requirements.Verify.BooleanRequirement R_LimLevel(text="Tank level cannot be below " + String(limLevel) +
                                                                         " m for more as " + String(limDuration) + " s")
          annotation (Placement(transformation(extent={{20,0},{80,20}})));
        Sources.RealExpression o_level(y=observation.level)
          annotation (Placement(transformation(extent={{-100,50},{-60,70}})));
        LogicalBlocks.WithinBand band1(u_max=levelMax, u_min=levelMin)
          annotation (Placement(transformation(extent={{-40,50},{0,70}})));
        LogicalBlocks.DelayedRising delayedRising1(duration=limDuration, u=
              observation.level < limLevel)
          annotation (Placement(transformation(extent={{-50,0},{-10,20}})));
      equation
        connect(not1.y, R_LimLevel.u) annotation (Line(
            points={{10.8,10},{18,10}},
            color={255,0,255},
            smooth=Smooth.None));
        connect(o_level.y, band1.u) annotation (Line(
            points={{-59,60},{-42,60}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(band1.y, R_InBand.u) annotation (Line(
            points={{1,60},{18,60}},
            color={255,0,255},
            smooth=Smooth.None));
        connect(not1.u, delayedRising1.y)
          annotation (Line(points={{0.4,10},{-4,10},{-9,10}}, color={255,0,255}));
        annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                  -100},{100,100}}), graphics), Icon(coordinateSystem(
                preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
                Rectangle(
                  extent={{-4,52},{90,-18}},
                  lineColor={255,255,255},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.VerticalCylinder),
                Rectangle(
                  extent={{-4,-48},{90,16}},
                  lineColor={0,0,0},
                  fillColor={85,170,255},
                  fillPattern=FillPattern.VerticalCylinder)}));
      end TankRequirements;

      block PumpRequirements "Requirements for one pump"
        import NonSI = Modelica.SIunits.Conversions.NonSIunits;
        extends Modelica_Requirements.Interfaces.PartialRequirements;

        parameter Real max_rpm(unit="rev/min") = 1000 "Maximum pump speed";
        parameter Modelica.SIunits.Pressure p_min = 100 "Cavitation pressure";

        input Records.Pump observation
          "Observation variables record from a pump" annotation (Dialog(group=
                "Observation variables"), Placement(transformation(extent={{-100,
                  80},{-80,100}})));

        Modelica_Requirements.Verify.BooleanRequirement R_speedMax(text="Pump speed is limited by " + String(max_rpm) + " rpm")
          annotation (Placement(transformation(extent={{20,50},{80,70}})));
        Modelica_Requirements.Verify.BooleanRequirement R_cavPortA(text="Pump must not cavitate at port_a")
          annotation (Placement(transformation(extent={{20,20},{80,40}})));
        Modelica_Requirements.Verify.BooleanRequirement R_cavPortB(text="Pump must not cavitate at port_b")
          annotation (Placement(transformation(extent={{20,-20},{80,0}})));
        Sources.BooleanExpression p_speed(y=observation.speed <= max_rpm)
          annotation (Placement(transformation(extent={{-90,50},{-40,70}})));
        Sources.BooleanExpression p_pa(y=observation.p_port_a >= p_min)
          annotation (Placement(transformation(extent={{-88,20},{-40,40}})));
        Sources.BooleanExpression p_pb(y=observation.p_port_b >= p_min)
          annotation (Placement(transformation(extent={{-88,-20},{-40,0}})));
      equation
        connect(p_speed.y, R_speedMax.u) annotation (Line(
            points={{-38.75,60},{18,60}},
            color={255,0,255},
            smooth=Smooth.None));
        connect(p_pa.y, R_cavPortA.u) annotation (Line(
            points={{-38.8,30},{18,30}},
            color={255,0,255},
            smooth=Smooth.None));
        connect(p_pb.y, R_cavPortB.u) annotation (Line(
            points={{-38.8,-10},{18,-10}},
            color={255,0,255},
            smooth=Smooth.None));
        annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                  -100},{100,100}}), graphics), Icon(coordinateSystem(
                preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
                Bitmap(extent={{-18,50},{90,-52}}, fileName="modelica://Modelica_Requirements/Resources/Images/Examples/PumpingSystem/pump.png")}));
      end PumpRequirements;

      block SourceRequirements "Requirements for a Source component"
        import NonSI = Modelica.SIunits.Conversions.NonSIunits;
        extends Modelica_Requirements.Interfaces.PartialRequirements;

        parameter Modelica.SIunits.Pressure p_min = 100 "Cavitation pressure";
        input Records.Source observation
          "Observation variables record from a source" annotation (Dialog(group=
               "Observation variables"), Placement(transformation(extent={{-100,
                  80},{-80,100}})));

        Modelica_Requirements.Verify.BooleanRequirement R_source[size(observation.p,1)](
           each text="Fixed boundary must not cavitate at port");
      equation
        for i in 1:size(observation.p,1) loop
           R_source[i].u = observation.p[i] >= p_min;
        end for;

        annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                  -100},{100,100}}), graphics), Icon(coordinateSystem(
                preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
                                                         Ellipse(
                extent={{-4,30},{84,-58}},
                lineColor={0,0,0},
                fillPattern=FillPattern.Sphere,
                fillColor={0,127,255})}));
      end SourceRequirements;
    end Requirements;

    package Bindings
      "Functions to map variables from the target to the requirement component"
      package Records
        "Records containing observation variables used as inputs to the binding functions"
           extends Modelica.Icons.Package;

         record FluidPort_p
          "Observation variables from a Modelica.Fluid.Interfaces.FluidPort component (only pressure p)"
            extends Modelica.Icons.Record;

            Modelica.SIunits.AbsolutePressure p
            "Thermodynamic pressure in the connection point";
         end FluidPort_p;

         record PrescribedPump
          "Observation variables from a Modelica.Fluid.Machines.PrescribedPump component"
            import NonSI = Modelica.SIunits.Conversions.NonSIunits;
            extends Modelica.Icons.Record;

            NonSI.AngularVelocity_rpm N_in "Pump speed";
          Bindings.Records.FluidPort_p port_a "Connector variables at port_a";
          Bindings.Records.FluidPort_p port_b "Connector variables at port_b";
         end PrescribedPump;

         record PartialSource
          "Observation variables from a model derived from Modelica.Fluid.Sources.BaseClasses.PartialSource"
            import NonSI = Modelica.SIunits.Conversions.NonSIunits;
            extends Modelica.Icons.Record;

            // parameter Integer nPorts=0;
          Bindings.Records.FluidPort_p ports[:] "Pressures at port";
         end PartialSource;
      end Records;
       extends Modelica.Icons.Package;

      function TankObservation_from_OpenTank
        "Map OpenTank variables to Tank observations record"
        input Requirements.Records.Tank openTank
          "Observation variables from an OpenTank";
        output Requirements.Records.Tank tankObservation=openTank
          "OpenTank observation variables in requirements model";
      algorithm

         annotation(Inline=true);
      end TankObservation_from_OpenTank;

      function PumpObservation_from_PrescribedPump
        "Map PrescribedPump variables to pump observations record"
        input Bindings.Records.PrescribedPump prescribedPump
          "Observation variables from a PrescribedPump";
        output Requirements.Records.Pump pumpObservation=Requirements.Records.Pump(
            speed=prescribedPump.N_in,
            p_port_a=prescribedPump.port_a.p,
            p_port_b=prescribedPump.port_b.p)
          "Pump observation variables in requirements model";
      algorithm

         annotation(Inline=true);
      end PumpObservation_from_PrescribedPump;

      function SourceObservation_from_PartialSource
        "Map PartialSource variables to Source observations record"
        input Bindings.Records.PartialSource partialSource
          "Observation variables from a PartialSource";
        output Requirements.Records.Source sourceObservation=
            Requirements.Records.Source(p=partialSource.ports.p)
          "Source observation variables in requirements model";
      algorithm

         annotation(Inline=true);
      end SourceObservation_from_PartialSource;
    end Bindings;
  end Components;
end SimplePumpingSystem;
