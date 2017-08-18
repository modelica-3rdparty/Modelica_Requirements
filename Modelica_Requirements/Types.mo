within Modelica_Requirements;
package Types "Library of type definitions"
  extends Modelica.Icons.TypesPackage;

 type Property = enumeration(
      Violated,
      Undecided,
      Satisfied) "Enumeration defining literals for three-valued logic"  annotation (
       Documentation(info="<html>
<p>
Enumeration defining literals for three-valued logic to model properties and requirements
(a requirement is a property that should be Satisfied). The second columen (Integer value)
defines the (Modelica) value of the enumeration that is, for example, used when
storing a value in a result file.
</p>

<p>
<table border=1 cellspacing=0 cellpadding=2>
<tr><td valign=\"top\"><b>Literal</b></td>
    <td valign=\"top\"><b>Integer value</b></td>
    <td valign=\"top\"><b>Description</b></td></tr>
<tr><td valign=\"top\">Violated</td>
    <td valign=\"top\" align=\"center\">= 1</td>
    <td valign=\"top\">The property is violated.</td></tr>
<tr><td valign=\"top\">Undecided</td>
    <td valign=\"top\" align=\"center\">= 2</td>
    <td valign=\"top\">The property is neither satisfied nor violated yet.</td></tr>
<tr><td valign=\"top\">Satisfied</td>
    <td valign=\"top\" align=\"center\">= 3</td>
    <td valign=\"top\">The property is satisfied.</td></tr>
</table>
</p>

</html>"));
   type Event = Boolean
    "Boolean that is only used as edge-type to emulate event signals";

end Types;
