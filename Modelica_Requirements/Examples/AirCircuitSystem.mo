within Modelica_Requirements.Examples;
package AirCircuitSystem
  "Simple air circuit example system to demonstrate requirements definition, binding and checking"
  extends Modelica.Icons.ExamplesPackage;

  model CheckAirCircuitSystem
    extends Components.AirCircuitSystem_B;
    inner Verify.PrintViolations printViolations
      annotation (Placement(transformation(extent={{40,80},{60,100}})));
    Components.Requirements.PipeRequirements pipe2Requirements(
      observationName="pipe2",
      observation=Components.Bindings.PipeObservation_from_DynamicPipe(pipe2),
      pMax=200000)
      annotation (Placement(transformation(extent={{40,40},{60,60}})));
  end CheckAirCircuitSystem;

  package Components "Utility components needed for example"
    extends Modelica.Icons.UtilitiesPackage;

    model AirCircuitSystem_B "Behavioral model ofair circuit system"
      extends Modelica.Icons.Example;

      inner Modelica.Fluid.System system
        annotation (Placement(transformation(extent={{-80,40},{-60,60}})));
      Modelica.Fluid.Pipes.DynamicPipe pipe2(
        redeclare package Medium = Medium,
        modelStructure=Modelica.Fluid.Types.ModelStructure.a_vb,
        length=0.1,
        diameter=0.03,
        nNodes=5)
        annotation (Placement(transformation(extent={{-46,0},{-26,20}})));
      Modelica.Fluid.Sources.FixedBoundary boundary2(
        redeclare package Medium = Medium,
        use_T=false,
        nPorts=1) annotation (Placement(transformation(extent={{-80,0},{-60,20}})));
      Modelica.Fluid.Sources.FixedBoundary boundary1(
        redeclare package Medium = Medium,
        use_T=false,
        nPorts=1)    annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={42,10})));
      replaceable package Medium = Modelica.Media.Air.SimpleAir;
      Modelica.Fluid.Pipes.StaticPipe  pipe1(
        redeclare package Medium = Medium,
        length=0.15,
        diameter=0.03)
        annotation (Placement(transformation(extent={{-8,0},{12,20}})));
    equation
      connect(pipe2.port_b, pipe1.port_a)
        annotation (Line(points={{-26,10},{-16,10},{-8,10}},
                                                        color={0,127,255}));
      connect(pipe1.port_b, boundary1.ports[1])
        annotation (Line(points={{12,10},{22,10},{32,10}},
                                                        color={0,127,255}));
      connect(boundary2.ports[1], pipe2.port_a)
        annotation (Line(points={{-60,10},{-53,10},{-46,10}}, color={0,127,255}));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}})));
    end AirCircuitSystem_B;

    package Requirements "Observation records"
       extends Modelica.Icons.Package;

      package Records
        "Records containing observation variables needed by the Requirement models"
           extends Modelica.Icons.Package;

        record Medium "Observation variables from a medium"
          extends Modelica.Icons.Record;
          Modelica.Units.SI.Pressure p "Medium pressure" annotation (Dialog);
          Modelica.Units.SI.Temperature T "Medium temperature"
            annotation (Dialog);
        end Medium;

        record MediumVector
          "Observation variables from a vector of medium properties"
          extends Modelica.Icons.Record;
          Medium mediums[:] "Vector of medium properties" annotation(Dialog);
        end MediumVector;
      end Records;

      block PipeRequirements "Requirements for a Pipe"
         extends Modelica_Requirements.Interfaces.PartialRequirements;

        parameter Modelica.Units.SI.Pressure pMax=1e5
          "Maximal allowed pressure";
        parameter Modelica.Units.SI.Temperature Tmin=255
          "Minimum pipe temperature";
        parameter Modelica.Units.SI.Temperature Tmax=300
          "Maximum pipe temperature";

        input Records.MediumVector observation
          "Observation variables record from a pipe"
          annotation (Dialog(group="Observation variables"), Placement(transformation(
                extent={{-100,80},{-80,100}})));

        PipeNodeRequirements mediums[size(observation.mediums,1)](observation=observation.mediums,
          each pMax=pMax, each Tmin=Tmin, each Tmax=Tmax)
          annotation (Placement(transformation(extent={{-60,60},{-40,80}})));
        annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                  -100},{100,100}}), graphics), Icon(coordinateSystem(
                preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
              Rectangle(
                extent={{-16,20},{92,-26}},
                lineColor={0,0,0},
                fillPattern=FillPattern.HorizontalCylinder,
                fillColor={0,127,255}),
              Ellipse(
                extent={{86,14},{96,-19}},
                lineColor={0,0,0},
                fillColor={0,0,0},
                fillPattern=FillPattern.Solid),
              Ellipse(
                extent={{-22,14},{-12,-19}},
                lineColor={0,0,0},
                fillColor={0,0,0},
                fillPattern=FillPattern.Solid)}));
      end PipeRequirements;

      block PipeNodeRequirements "Requirements for a a node of a pipe"
         extends Modelica.Blocks.Icons.Block;
        parameter Modelica.Units.SI.Pressure pMax=1e5
          "Maximal allowed pressure";
        parameter Modelica.Units.SI.Temperature Tmin=255
          "Minimum pipe temperature";
        parameter Modelica.Units.SI.Temperature Tmax=300
          "Maximum pipe temperature";

        input Records.Medium observation
          "Observation variables record for a node of a pipe"
          annotation (Dialog(group="Observation variables"), Placement(transformation(
                extent={{-100,80},{-80,100}})));

        Modelica_Requirements.Verify.BooleanRequirement R_pMax(text="The maximal pressure in a pipe of
the air distribution circuit shall not
exceed %pMax bars")
          annotation (Placement(transformation(extent={{20,40},{80,60}})));
        Modelica_Requirements.LogicalBlocks.LessThreshold lt1(threshold=
              pMax) annotation (Placement(transformation(extent={{-38,40},{2,60}})));
        Sources.RealExpression                 PipePressure(y=observation.p)
          annotation (Placement(transformation(extent={{-94,40},{-54,60}})));

         Modelica_Requirements.Verify.BooleanRequirement R_InBand1(text="The operating temperature range
of a pipe shall be between
%Tmin°C to %Tmax°C
(cruising in ISA conditions).")
           annotation (Placement(transformation(extent={{20,0},{80,20}})));
         Modelica_Requirements.LogicalBlocks.WithinBand band2(u_max=Tmax, u_min=
             Tmin)
           annotation (Placement(transformation(extent={{-38,0},{2,20}})));
         Sources.RealExpression                 PipeTemperature(y=observation.T)
           annotation (Placement(transformation(extent={{-94,0},{-54,20}})));
      equation
        connect(PipePressure.y,lt1. u)
          annotation (Line(points={{-53,50},{-53,50},{-40,50}},   color={0,0,127}));
        connect(lt1.y,R_pMax. u)
          annotation (Line(points={{3,50},{10.5,50},{18,50}},color={255,0,255}));
         connect(PipeTemperature.y,band2. u) annotation (Line(points={{-53,10},{-53,10},
                {-40,10}},        color={0,0,127}));
         connect(band2.y, R_InBand1.u)
           annotation (Line(points={{3,10},{10.5,10},{18,10}}, color={255,0,255}));
        annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                  -100},{100,100}}), graphics), Icon(coordinateSystem(
                preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
              Rectangle(
                extent={{-56,60},{52,14}},
                lineColor={0,0,0},
                fillPattern=FillPattern.HorizontalCylinder,
                fillColor={0,127,255}),
              Ellipse(
                extent={{46,54},{56,21}},
                lineColor={0,0,0},
                fillColor={0,0,0},
                fillPattern=FillPattern.Solid),
              Ellipse(
                extent={{-62,54},{-52,21}},
                lineColor={0,0,0},
                fillColor={0,0,0},
                fillPattern=FillPattern.Solid),
              Line(
                points={{-18,-52},{0,-72},{12,-20}},
                color={0,127,0},
                smooth=Smooth.None,
                thickness=0.5),
              Ellipse(
                extent={{-10,44},{2,32}},
                lineColor={0,0,0},
                fillColor={0,0,0},
                fillPattern=FillPattern.Solid)}));
      end PipeNodeRequirements;
    end Requirements;

    package Bindings
      "Functions to map variables from the target to the requirement component"
       extends Modelica.Icons.Package;

      function PipeObservation_from_DynamicPipe
        "Map DynamicPipe variables to Pipe observations record"
        import  Modelica_Requirements.Examples.AirCircuitSystem.Components.*;
        input Requirements.Records.MediumVector dynamicPipe
          "Observation variables from a DynamicPipe";
        output Requirements.Records.MediumVector pipeObservation=dynamicPipe
          "Pipe observation variables in requirements model";
      algorithm

         annotation(Inline=true);
      end PipeObservation_from_DynamicPipe;
    end Bindings;
  end Components;
end AirCircuitSystem;
