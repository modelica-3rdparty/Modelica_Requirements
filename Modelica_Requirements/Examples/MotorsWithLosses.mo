within Modelica_Requirements.Examples;
package MotorsWithLosses
  "Demonstrate requirements definition and checking at hand of a electrical motors"
  extends Modelica.Icons.ExamplesPackage;

  model CheckMotorWithLosses
    "Check model Modelica.Electrical.Machines.Examples.DCMachines.DCPM_withLosses"
    extends Modelica.Icons.Example;

    Modelica.Electrical.Machines.Examples.DCMachines.DCPM_withLosses DCPM_withLosses
      annotation (Placement(transformation(extent={{-60,60},{-40,80}})));

    Components.Verify checkRequirements(
       dcmotorWatching={Components.watchDCMotor(name="DCPM_withLosses.dcpm1",obj=DCPM_withLosses.dcpm1),
                        Components.watchDCMotor(name="DCPM_withLosses.dcpm2",obj=DCPM_withLosses.dcpm2)})
      annotation (Placement(transformation(extent={{60,60},{80,80}})));

    annotation (experiment(StopTime=2));
  end CheckMotorWithLosses;

  package Components "Utility components needed for example"
    extends Modelica.Icons.UtilitiesPackage;

    record DCMotorWatching
      "Signals observed from a DC motor as needed by DCMotorRequirements block"
       extends Modelica_Requirements.Interfaces.PartialWatching;

       parameter Modelica.SIunits.Voltage VaNominal;
       parameter Modelica.SIunits.Current IaNominal;
       parameter Modelica.SIunits.AngularVelocity wNominal;

       Modelica.SIunits.Voltage v annotation(Dialog);
       Modelica.SIunits.Current i annotation(Dialog);
       Modelica.SIunits.AngularVelocity w annotation(Dialog);
    end DCMotorWatching;

    block DCMotorRequirements "Requirements for one DC Motor"
      import Modelica_Requirements;
      extends Modelica_Requirements.Interfaces.PartialRequirements;

      input DCMotorWatching watch "Signals observed from source" annotation (Dialog,
          Placement(transformation(extent={{-74,80},{-54,100}})));
      Sources.BooleanExpression speed(y=abs(watch.w) <= 1.2*watch.wNominal)
        annotation (Placement(transformation(extent={{-100,30},{-40,50}})));
      Modelica_Requirements.Verify.BooleanRequirement R_SpeedMax(text="Maximum speed is limited")
        annotation (Placement(transformation(extent={{0,30},{60,50}})));
      Modelica.Blocks.Math.Abs abs1
        annotation (Placement(transformation(extent={{-26,-10},{-6,10}})));
      Sources.RealExpression current(y=watch.i)
        annotation (Placement(transformation(extent={{-100,-10},{-40,10}})));
      LogicalBlocks.LessEqualThreshold le(threshold=watch.IaNominal*1.5)
        annotation (Placement(transformation(extent={{8,-10},{48,10}})));
      Modelica_Requirements.Verify.BooleanRequirement R_IaMax(text="Maximum current is limited")
        annotation (Placement(transformation(extent={{40,-36},{100,-16}})));
    equation

      connect(speed.y, R_SpeedMax.u) annotation (Line(
          points={{-38.5,40},{-2,40}},
          color={255,0,255},
          smooth=Smooth.None));
      connect(abs1.u, current.y) annotation (Line(
          points={{-28,0},{-38.5,0}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(abs1.y, le.u) annotation (Line(
          points={{-5,0},{6,0}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(le.y, R_IaMax.u) annotation (Line(
          points={{49,0},{60,0},{60,-12},{26,-12},{26,-26},{38,-26}},
          color={255,0,255},
          smooth=Smooth.None));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent=
                {{-100,-100},{100,100}}), graphics));
    end DCMotorRequirements;

    function watchDCMotor
      "Map data from Modelica.Electrical.Machines.BasicMachines.DCMachines.DC_PermanentMagnet to DCMotor"
      input String name "Full name of DCmotor instance";
      input MotorData obj "DCmotor model data to be watched";
      output DCMotorWatching watchObj=DCMotorWatching(
          name=name,
          VaNominal=obj.VaNominal,
          IaNominal=obj.IaNominal,
          wNominal=obj.wNominal,
          v=obj.va,
          i=obj.ia,
          w=obj.inertiaRotor.w) "Data in DCmotor format";

    protected
     record InertiaData
        "Data needed from Modelica.Mechanics.Rotational.Components.Inertia"
       Modelica.SIunits.AngularVelocity w;
     end InertiaData;

     record MotorData
        "Data needed Modelica.Electrical.Machines.BasicMachines.DCMachines.DC_PermanentMagnet"
       parameter Modelica.SIunits.Voltage VaNominal;
       parameter Modelica.SIunits.Current IaNominal;
       parameter Modelica.SIunits.AngularVelocity wNominal;
       Modelica.SIunits.Voltage va;
       Modelica.SIunits.Current ia;
       InertiaData inertiaRotor;
     end MotorData;

    algorithm
      annotation(Inline=true);
    end watchDCMotor;

    block Verify "Check requirements of OpenTanks and of Pumps"
      import Modelica_Requirements.Examples.MotorsWithLosses.Components;

      extends Modelica_Requirements.Interfaces.PartialVerify;

      Components.DCMotorWatching dcmotorWatching[:]=fill(Components.DCMotorWatching(
                                                 name="Unknown",
                                                 VaNominal=100,
                                                 IaNominal=10,
                                                 wNominal=100,
                                                 v=100,
                                                 i=10,
                                                 w=100),0)
        "Vector of DCMotorWatching records"
        annotation (Dialog, Placement(transformation(extent={{-40,20},{-20,40}})));

      Components.DCMotorRequirements dcmotorRequirements[size(dcmotorWatching,1)](
                                                              watch=dcmotorWatching)
        annotation (Placement(transformation(extent={{-40,-20},{-20,0}})));

    end Verify;
  end Components;
end MotorsWithLosses;
