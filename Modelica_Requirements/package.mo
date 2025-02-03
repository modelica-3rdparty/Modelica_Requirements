within ;
package Modelica_Requirements "Modelica_Requirements (Version 0.6) - Defining requirements formally and checking them when simulating"
  extends Modelica.Icons.Package;


package UsersGuide "User's Guide"
  extends Modelica.Icons.Information;

package ReleaseNotes "Release notes"
  extends Modelica.Icons.ReleaseNotes;

  class Version_0_6_1 "Version 0.6.1 (Feb. 3, 2025)"
  extends Modelica.Icons.ReleaseNotes;

    annotation (Documentation(info="<html>
<p>
License changed to BSD 3-Clause license.
</p>
</html>"));
  end Version_0_6_1;

  class Version_0_6 "Version 0.6 (April 19, 2016)"
  extends Modelica.Icons.ReleaseNotes;

    annotation (Documentation(info="<html>
<p>
First version of the library provided to the public.
</p>
</html>"));
  end Version_0_6;

 annotation (Documentation(info="<html>

<p>
This section summarizes the changes that have been performed
on package Modelica_Requirements.
</p>
</html>"));
end ReleaseNotes;

class Contact "Contact"
  extends Modelica.Icons.Contact;

 annotation (Documentation(info="<html>
<dl>
<dt><b>Main Author</b></dt>
<dd>Martin Otter<br>
    German Aerospace Center (DLR)<br>
    Robotics and Mechatronics Center<br>
    <a href=\"http://www.dlr.de/rmc/sr/en/desktopdefault.aspx/tabid-8018/\">Institute of System Dynamics and Control</a><br>
    Postfach 1116<br>
    D-82230 Wessling<br>
    Germany<br>
    email: <a href=\"mailto:Martin.Otter@dlr.de\">Martin.Otter@dlr.de</a><br></dd>
</dl>
<p><b>Acknowledgements:</b></p>

<ul>
<li> The structuring and most operators/models of this library are based on
     the informally defined <b>FORM-L</b> language by Nguyen Thuy from EDF.
     The backup-power-supply example is based on a description by
     Nguyen Thuy from EDF.</li>

<li> The example models in sublibrary <a href=\"modelica://Modelica_Requirements.Examples.AircraftRequirements\">AircraftRequirements</a>
     have been provided by the aircraft manufacturer Dassault Aviation and implemented by Dassault Aviation and DLR.</li>

<li> Some operators/models are based on work
     by Dassault Aviation (such as <a href=\"modelica://Modelica_Requirements.SignalAnalysis\">SignalAnalysis</a>)
     and by DLR (such as <a href=\"modelica://Modelica_Requirements.ChecksInFixedWindow_withFFT\">ChecksInFixedWindow_withFFT</a>).
     </li>

<li> The functions \"card\", \"forall\" and \"exists\" are based on a design
     by Hilding Elmqvist from Dassault Syst&egrave;mes Lund.</li>

<li> The functions \"first\", \"last\", \"oneTrue\"
     and the blocks \"WhenFalling\", \"WhenChanging\" are from Andrea Tunis (UNICAL).</li>

<li> Wladimir Schamai suggested to use a mix of 2- and 3-valued logic.</li>

<li> Earlier versions of this library have been tested with Dymola, OpenModelica and SimulationX.</li>

<li> Most of this library was developed within the ITEA2 project
     <a href=\"https://www.modelica.org/external-projects/modrio\">MODRIO</a>. Partial financial support of
     the German BMBF, the French DGE, and the Swedish VINNOVA are highly appreciated.</li>

<li> The FFT-based property blocks of this library
     (<a href=\"modelica://Modelica_Requirements.ChecksInFixedWindow_withFFT\">ChecksInFixedWindow_withFFT</a>)
     have been developed and implemented with help of partial funding in the European Union’s Seventh Framework Programme
     (FP7/2007-2016) for the Clean Sky Joint Technology Initiative under grant agreement no. CSJU-GAM-SGO-2008-001.
     This support is highly appreciated.</li>
</ul>
</html>"));

end Contact;

annotation (DocumentationClass=true, Documentation(info="<html>
<p>
Library <b>Modelica_Requirements</b> is a Modelica package
using temporal logic to formally define requirements
and automatically test these requirements when a model
is simulated.
</p>
</html>"));
end UsersGuide;


  annotation (preferredView="info",
  uses(Modelica(version="3.2.2")),
version="0.6",
versionBuild=1,
versionDate="2016-06-21",
dateModified = "2016-06-21 08:44:41Z",
revisionId="$Id:: package.mo 9390 2016-06-21 06:35:11Z #$",
Documentation(info="<html>
<p>
Library <b>Modelica_Requirements</b> is a Modelica package
to formally define requirements and checking them automatically
when a model is simulated. An overview of this library is given in the publication
<a href=\"modelica://Modelica_Requirements/Resources/Documentation/ecp15118625.pdf\">Formal Requirements Modeling for Simulation-Based Verification</a>
</p>

<p>
In order to define properties and requirements mostly a 2-valued logic is used.
There are some functions and blocks based on 3-valued logic using type
<a href=\"modelica://Modelica_Requirements.Types.Property\">Property</a>, especially
block <a href=\"modelica://Modelica_Requirements.Verify.Requirement\">Requirement</a>.
Furthermore, there are cast-operators to map 2-valued to 3-valued logic and vice versa.
3-valued logic is used to define (a) if a property is not tested (because only relevant
in a certain situation) and (b) if a requirement was not tested in a simulation run.
</p>

<p>
In this package the standard convention is used that names of
memory-less operators (implemented as Modelica functions)
start with lower-case letters and names of operators
with memory (implemented as Modelica blocks) start with
upper-case letters.
</p>

<p>
This package uses basically Modelica 3.2 language elements and requires at least version 3.2.2 of
the Modelica Standard Library (some parts will not work with 3.2.1 or an earlier version).
Additionally, the Modelica extension is used in some examples (but not outside of examples) to
pass a model instance as argument to a function (and the function argument is a record).
This feature is used to associate requirements in a reasonably convenient way with
behavioral models. This approach is currently under discussion at the Modelica Association.
Most likely a slightly different concept will be introduced in the next release of the
Modelica language by providing the cast of a model to a record. Once this is clear and
prototypes are available in Modelica tools, this new concept will be used in this library.
Earlier versions of this library contained also examples utilizing
the proposed new Modelica language element to \"call a block as a function\". These examples had been
removed from this version.
</p>

<p>
The current version of the library uses a buffer for the implementation of
sliding windows (<a href=\"modelica://Modelica_Requirements.Internal.SlidingWindow\">Internal.SlidingWindow</a>).
The size of this buffer is fixed to 20 (constant nBuffer in package SlidingWindow).
If the buffer is too small for a requirement from package
<a href=\"modelica://Modelica_Requirements.ChecksInSlidingWindow\">ChecksInSlidingWindow</a>,
then a warning is printed.
The result of the requirement verification might then not be correct.
</p>

<p>
<b>This package is not yet finalized. A redesign is planned. The redesigned library (with improved implementations
of models and new functionality) should be backwards compatible to this version, but
it is not guaranteed. If non-backwards compatible changes are introduced, most likely
automatic conversions will not be provided.</b>.
</p>

<p>
<i>This Modelica package is <u>free</u> software and
the use is completely at <u>your own risk</u>;
it can be redistributed and/or modified under the terms of the
3-Clause BSD license, see the license conditions (including the
disclaimer of warranty) at
<a href=\"https://github.com/modelica-3rdparty/Modelica_Requirements/blob/master/LICENSE\">
https://github.com/modelica-3rdparty/Modelica_Requirements/blob/master/LICENSE</a>.</i>
</p>


<p>
<b>Copyright &copy; 2014-2016, DLR, Dassault Aviation and UNICAL</b>
</p>
</html>"),
  Icon(graphics));
end Modelica_Requirements;
