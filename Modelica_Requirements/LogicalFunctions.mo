within Modelica_Requirements;
package LogicalFunctions
  "Library of logical functions (2-/3-valued logical operators without memory)"
  extends Modelica.Icons.Package;

  function card
    "Returns the number of elements of a Boolean vector that are true"
    extends Modelica.Icons.Function;
    input Boolean b[:] "Boolean vector";
    output Integer result "Number of true entries";
  algorithm
    result :=sum(if e then 1 else 0 for e in b);
    annotation(Inline=true, Documentation(info="<html>

<h4>Syntax</h4>

<blockquote><p>
<b>card</b>(b);
</p></blockquote>

<h4>Description</h4>
<p>
The function returns the number of true-elements of Boolean vector b.
</p>

<h4>Example</h4>
<p>
The property is demonstrated with the following
<a href=\"modelica://Modelica_Requirements.Examples.Textual.Elementary.LogicalFunctions.card\">example</a> calling the function as:
</p>

<blockquote>
nTrueElements = card( b )<br>
</blockquote>

<table border=0 cellspacing=0 cellpadding=2>
<tr><td width=\"50\"></td>
    <td valign=\"bottom\"><img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/Textual/Elementary/LogicalFunctions/card.png\"></td>
    </tr>
<tr><td></td>
    <td align=\"center\">simulation result</td>
   </tr>
</table>

</html>"));
  end card;

  function exists
    "Returns true if at least one element of a Boolean vector is true ('or' of all elements)"
    extends Modelica.Icons.Function;
    input Boolean b[:] "Boolean vector";
    output Boolean result "= true, if at least one element of b is true";
  algorithm
    result :=card(b) > 0;
    annotation(Inline=true, Documentation(info="<html>

<h4>Syntax</h4>

<blockquote><p>
<b>exists</b>(b);
</p></blockquote>

<h4>Description</h4>
<p>
The function returns true if at least one element of the Boolean vector b is true.
Otherwise, the function returns false.
</p>

<h4>Example</h4>

<p>
The property is demonstrated with the following
<a href=\"modelica://Modelica_Requirements.Examples.Textual.Elementary.LogicalFunctions.exists\">example</a> calling the function as:
</p>

<blockquote>
Boolean atleastOnePumpActive = exists({p.isActive <b>for</b> p <b>in</b> pumps})
</blockquote>

<p>
results in
</p>

<table border=0 cellspacing=0 cellpadding=2>
<tr><td width=\"50\"></td>
    <td valign=\"bottom\"><img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/Textual/Elementary/LogicalFunctions/exists.png\"></td>
    </tr>
<tr><td></td>
    <td align=\"center\">simulation result</td>
   </tr>
</table>

<p>
Note, the same result can be achieved with the max(..) built-in operator:
</p>

<p>
<blockquote>
Boolean atleastOnePumpActive2 = max(p.isActive <b>for</b> p <b>in</b> pumps)
</blockquote>
</p>
</html>"));
  end exists;

  function forall
    "Returns true if all elements of a Boolean vector are true ('and' of all elements)"
    extends Modelica.Icons.Function;
    input Boolean b[:] "Boolean vector";
    output Boolean result "= true, if all elements of b are true";
  algorithm
    result :=card(b) == size(b, 1);
    annotation(Inline=true, Documentation(info="<html>

<h4>Syntax</h4>

<blockquote><p>
<b>forall</b>(b);
</p></blockquote>

<h4>Description</h4>
<p>
The function returns true if all elements of the Boolean vector b are true.
Otherwise, the function returns false.
</p>

<h4>Example</h4>

<p>
The property is demonstrated with the following
<a href=\"modelica://Modelica_Requirements.Examples.Textual.Elementary.LogicalFunctions.forall\">example</a> calling the function as:
</p>

<blockquote>
<p>
Boolean noCavitation = forall({p.p_a > p_cavitate <b>for</b> p <b>in</b> pumps})
</p>
</blockquote>


<p>
results in
</p>

<table border=0 cellspacing=0 cellpadding=2>
<tr><td width=\"50\"></td>
    <td valign=\"bottom\"><img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/Textual/Elementary/LogicalFunctions/forall.png\"></td>
    </tr>
<tr><td></td>
    <td align=\"center\">simulation result</td>
   </tr>
</table>

<p>
Note, the same result can be achieved with the min(..) built-in operator:
</p>

<p>
<blockquote>
Boolean noCavitation2 = min(p.p_a > p_cavitate <b>for</b> p <b>in</b> pumps);
</blockquote>
</p>
</html>"));
  end forall;

  function implies
    "Returns check as long as the condition is true, otherwise returns true"
    extends Modelica.Icons.Function;
    input Boolean condition;
    input Boolean check;
    output Boolean result;
  algorithm
    result :=if condition then check else true;

    annotation (Inline=true, Documentation(info="<html>

<h4>Syntax</h4>

<blockquote><p>
<b>implies</b>(condition, check);
</p></blockquote>

<h4>Description</h4>
<p>
If condition is true, the function returns check. Otherwise, it returns true.
</p>


<h4>Example</h4>
<p>
The property is demonstrated with the following
<a href=\"modelica://Modelica_Requirements.Examples.Textual.Elementary.LogicalFunctions.implies\">example</a> calling the function as:
</p>

<blockquote>
property = implies(condition,check)<br>
</blockquote>

<table border=0 cellspacing=0 cellpadding=2>
<tr><td width=\"50\"></td>
    <td valign=\"bottom\"><img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/Textual/Elementary/LogicalFunctions/implies.png\"></td>
    </tr>
<tr><td></td>
    <td align=\"center\">simulation result</td>
   </tr>
</table>
</html>"));
  end implies;

  function first "Returns the value of the first element of a Boolean vector"
    extends Modelica.Icons.Function;
    input Boolean b[:] "Boolean vector";
    output Boolean result "Value of the first entry";
  algorithm
    result := b[1];
    annotation(Inline=true, Documentation(info="<html>
<h4>Syntax</h4>

<blockquote><p>
<b>first</b>(b);
</p></blockquote>

<h4>Description</h4>
<p>
The function returns the value of the first element of a Boolean vector b.
</p>

<h4>Example</h4>
<p>
The property is demonstrated with the following
<a href=\"modelica://Modelica_Requirements.Examples.Textual.Elementary.LogicalFunctions.first\">example</a> calling the function as:
</p>

<blockquote>
firstBooleanElement = first( b ) <br>
</blockquote>

<table border=0 cellspacing=0 cellpadding=2>
<tr><td width=\"50\"></td>
    <td valign=\"bottom\"><img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/Textual/Elementary/LogicalFunctions/first.png\"></td>
    </tr>
<tr><td></td>
    <td align=\"center\">simulation result</td>
   </tr>
</table>
</html>"));
  end first;

  function last "Returns the value of the last element of a Boolean vector"
    extends Modelica.Icons.Function;
    input Boolean b[:] "Boolean vector";
    output Boolean result "Value of last entry";
  algorithm
    result := b[size(b, 1)];
    annotation(Inline=true, Documentation(info="<html>
<h4>Syntax</h4>

<blockquote><p>
<b>last</b>(b);
</p></blockquote>

<h4>Description</h4>
<p>
The function returns the value of the last element of a Boolean vector b.
</p>

<h4>Example</h4>
<p>
The property is demonstrated with the following
<a href=\"modelica://Modelica_Requirements.Examples.Textual.Elementary.LogicalFunctions.last\">example</a> calling the function as:
</p>

<blockquote>
lastBooleanElement = last( b )<br>
</blockquote>

<table border=0 cellspacing=0 cellpadding=2>
<tr><td width=\"50\"></td>
    <td valign=\"bottom\"><img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/Textual/Elementary/LogicalFunctions/last.png\"></td>
    </tr>
<tr><td></td>
    <td align=\"center\">simulation result</td>
   </tr>
</table>
</html>"));
  end last;

  function oneTrue
    "Returns true if exactly one element of a Boolean vector is true ('xor' of all elements)"
    extends Modelica.Icons.Function;
    input Boolean b[:] "Boolean vector";
    output Boolean result "= true, if exactly one element of b is true";
  algorithm
    result := card(b) == 1;
    annotation(Inline=true, Documentation(info="<html>
<h4>Syntax</h4>

<blockquote><p>
<b>oneTrue</b>(b);
</p></blockquote>

<h4>Description</h4>
<p>
The function returns  true if exactly one element of a Boolean vector is true ('xor' of all elements).
</p>

<h4>Example</h4>
<p>
The property is demonstrated with the following
<a href=\"modelica://Modelica_Requirements.Examples.Textual.Elementary.LogicalFunctions.oneTrue\">example</a> calling the function as:
</p>

<blockquote>
oneTrueElement = oneTrue( b )<br>
</blockquote>

<table border=0 cellspacing=0 cellpadding=2>
<tr><td width=\"50\"></td>
    <td valign=\"bottom\"><img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/Textual/Elementary/LogicalFunctions/oneTrue.png\"></td>
    </tr>
<tr><td></td>
    <td align=\"center\">simulation result</td>
   </tr>
</table>

</html>"));
  end oneTrue;

  function PropertyToBoolean
    "Convert  Property (Violated, Undecided, Satisfied) to Boolean (false, true)"
     import Modelica_Requirements.Types.Property;
     extends Modelica.Icons.Function;

     input Modelica_Requirements.Types.Property u
      "Property to be mapped to Boolean";
     input Boolean undecided=false "Boolean value of Property.Undecided";
    output Boolean y "Boolean as Property";
  algorithm
    y :=if u == Property.Satisfied then true else (if u == Property.Undecided
       then undecided else false);

    annotation (Documentation(info="<html>
</html>"));
  end PropertyToBoolean;

  function PropertyToInteger
    "Convert  Property (Violated, Undecided, Satisfied) to Integer (1,2,3)"
     import Modelica_Requirements.Types.Property;
     extends Modelica.Icons.Function;

     input Modelica_Requirements.Types.Property u
      "Property to be mapped to Boolean";
    output Integer y "Integer as Property";
  algorithm
    y :=Integer(u);

    annotation (Documentation(info="<html>
</html>"));
  end PropertyToInteger;

  function BooleanToProperty
    "Convert Boolean (false,true) to Property (Violated, Satisfied)"
     import Modelica_Requirements.Types.Property;

     extends Modelica_Requirements.Interfaces.PropertyFunction;
     input Boolean u "Boolean to be mapped to Property";
    output Modelica_Requirements.Types.Property y "Boolean as Property";
  algorithm
     y :=if u then Property.Satisfied else Property.Violated;

    annotation (Inline=true, Documentation(info="<html>

<h4>Syntax</h4>

<blockquote><p>
<b>BooleanToProperty</b>(check);
</p></blockquote>

<h4>Description</h4>
<p>
The function returns Satisfied if check=true and returns Violated, if check=false.
Satisfied and Violated are elements of enumeration
<a href=\"modelica://Modelica_Requirements.Types.Property\">Property</a>
</p>

<h4>Example</h4>
<p>
The property is demonstrated with the following
<a href=\"modelica://Modelica_Requirements.Examples.Textual.Elementary.LogicalFunctions.toProperty\">example</a> calling the function as:
</p>

<blockquote>
property = BooleanToProperty(check)<br>
</blockquote>

<p>
results in
</p>

<table border=0 cellspacing=0 cellpadding=2>
<tr><td width=\"50\"></td>
    <td valign=\"bottom\"><img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/Textual/Elementary/LogicalFunctions/toProperty.png\"></td>
    </tr>
<tr><td></td>
    <td align=\"center\">simulation result</td>
   </tr>
</table>

</html>"));

  end BooleanToProperty;

  function IntegerToProperty
    "Convert Integer (1,2,3) to Property (Violated, Undecided, Satisfied)"
     import Modelica_Requirements.Types.Property;

     extends Modelica_Requirements.Interfaces.PropertyFunction;
     input Integer u "Integer to be mapped to Property";
    output Modelica_Requirements.Types.Property y "Integer as Property";
  algorithm
    assert(u>=1 and u<=3, "Integer input u (=" + String(u) + ") cannot be converted to Property output (u = 1, 2 or 3 required)");
    y :=if u == 3 then Property.Satisfied else (if u == 2 then Property.Undecided
       else Property.Violated);

    annotation (Documentation(info="<html>
</html>"));
  end IntegerToProperty;

  function during
    "Return Satisfied when check is true as long as condition is true"
    import Modelica_Requirements.Types.Property;
    extends Modelica_Requirements.Interfaces.PropertyFunction;
    input Boolean condition "Verify check as long as condition = true";
    input Boolean check "As long as condition is true, check should be true";
    output Modelica_Requirements.Types.Property result;
  algorithm
    result :=if condition then
                (if check then Property.Satisfied else Property.Violated) else Property.Undecided;

    annotation (Inline=true, Documentation(info="<html>

<h4>Syntax</h4>

<blockquote><p>
<b>during</b>(condition, check);
</p></blockquote>

<h4>Description</h4>
<p>
If condition is true, the function returns \"<a href=\"modelica://Modelica_Requirements.Types.Property\">Property</a>(check)\"
(so either Satisfied or Violated). Otherwise, it returns Undecided.
Violated, Undecided, and Satisfied are the elements of enumeration
<a href=\"modelica://Modelica_Requirements.Types.Property\">Property</a>
</p>

<h4>Example</h4>
<p>
The property is demonstrated with the following
<a href=\"modelica://Modelica_Requirements.Examples.Textual.Elementary.LogicalFunctions.during\">example</a> calling the function as:
</p>

<blockquote>
property = during(condition,check)<br>
</blockquote>

<p>
results in
</p>

<table border=0 cellspacing=0 cellpadding=2>
<tr><td width=\"50\"></td>
    <td valign=\"bottom\"><img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/Textual/Elementary/LogicalFunctions/during.png\"></td>
    </tr>
<tr><td></td>
    <td align=\"center\">simulation result</td>
   </tr>
</table>

</html>"),
      Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
          graphics));
  end during;

  function during3
    "Return Satisfied when check is Satisfied as long as condition is true (check: 3-valued logic)"
    extends Modelica_Requirements.Interfaces.PropertyFunction;
    import Modelica_Requirements.Types.Property;
    input Boolean condition "Verify check as long as condition = true";
    input Modelica_Requirements.Types.Property check
      "As long as condition is true, check should be Satisfied";
    output Modelica_Requirements.Types.Property result;
  algorithm
    result :=if condition then check else Property.Undecided;

    annotation (Inline=true, Documentation(info="<html>

<h4>Syntax</h4>

<blockquote><p>
<b>during3</b>(condition, check);
</p></blockquote>

<h4>Description</h4>
<p>
If condition is true, the function returns check (which must be of type
<a href=\"modelica://Modelica_Requirements.Types.Property\">Property</a>). Otherwise, it returns Undecided.
</p>

<h4>Example</h4>
<p>
The property is demonstrated with the following
<a href=\"modelica://Modelica_Requirements.Examples.Textual.Elementary.LogicalFunctions.during3\">example</a> calling the function as:
</p>

<blockquote>
property = during3(condition,check)<br>
</blockquote>

<p>
results in
</p>

<table border=0 cellspacing=0 cellpadding=2>
<tr><td width=\"50\"></td>
    <td valign=\"bottom\"><img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/Textual/Elementary/LogicalFunctions/during3.png\"></td>
    </tr>
<tr><td></td>
    <td align=\"center\">simulation result</td>
   </tr>
</table>

</html>"));
  end during3;

  function forall3
    "Returns Violated, if at least one element of the Property vector is Violated (vector: 3-valued logic)"
    extends Modelica_Requirements.Interfaces.PropertyFunction;
    import Modelica_Requirements.Types.Property;

    input Types.Property p[:] "Property vector";
    output Types.Property result
      "= Violated, if at least one element is Violated. Satisfied if all elements are Satisfied. Otherwise Undecided.";
  algorithm
    if size(p,1) < 1 then
       result :=Property.Undecided;
       return;
    end if;

    result :=p[1];
    if result == Property.Violated then
       return;
    end if;

    for i in 2:size(p,1) loop
       if p[i] == Property.Violated then
          result :=Property.Violated;
          return;
       elseif p[i] == Property.Undecided then
          result :=Property.Undecided;
       end if;
    end for;

    annotation(Documentation(info="<html>

<h4>Syntax</h4>

<blockquote><p>
<b>forall3</b>(p);
</p></blockquote>

<h4>Description</h4>
<p>
The function returns Property.Violated, if at least <b>one element</b> of Property vector p has value Violated.<br>
The function returns Property.Undecided, if either <b>all elements</b> of Property vector p have value Undecided,
or the dimension of p is 0.<br>
Otherwise, the function returns Property.Satisfied.
</p>

<h4>Example</h4>

<p>
The property is demonstrated with the following
<a href=\"modelica://Modelica_Requirements.Examples.Textual.Elementary.LogicalFunctions.forall3\">example</a> calling the function as:
</p>

<blockquote>
properties = {during(p.isActive, check=p.p_a > p_cavitate) for p in pumps};<br>
result = forall3(properties);
</blockquote>

<p>
results in
</p>

<table border=0 cellspacing=0 cellpadding=2>
<tr><td width=\"50\"></td>
    <td valign=\"bottom\"><img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/Textual/Elementary/LogicalFunctions/forall3_1.png\"></td>
    </tr>
<tr><td width=\"50\"></td>
    <td valign=\"bottom\"><img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/Textual/Elementary/LogicalFunctions/forall3_2.png\"></td>
    </tr>
<tr><td></td>
    <td align=\"center\">simulation result</td>
   </tr>
</table>
</html>"));
  end forall3;

  function cardSatisfied
    "Returns the number of elements of a Property vector that are Satisfied"
    extends Modelica_Requirements.Interfaces.PropertyFunction;
    import Modelica_Requirements.Types.Property;
    input Property p[:] "Property vector";
    output Integer result "Number of Property.Satisfied entries";
  algorithm
    result :=sum(if e == Property.Satisfied then 1 else 0 for e in p);
    annotation(Inline=true, Documentation(info="<html>

<h4>Syntax</h4>

<blockquote><p>
nSatisfied = <b>cardSatisfied</b>(p);
</p></blockquote>

<h4>Description</h4>
<p>
This function returns the number of Satisfied-elements of Property vector p.
</p>

<p>
Violated, Undecided, and Satisfied are elements of enumeration
<a href=\"modelica://Modelica_Requirements.Types.Property\">Property</a>.
</p>

<h4>Example</h4>
<p>
This function is demonstrated with the following
<a href=\"modelica://Modelica_Requirements.Examples.Textual.Elementary.LogicalFunctions.cardSatisfied\">example</a> calling the function as:
</p>

<blockquote>
nSatisfied = cardSatisfied( p )<br>
</blockquote>

<table border=0 cellspacing=0 cellpadding=2>
<tr><td width=\"50\"></td>
    <td valign=\"bottom\"><img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/Textual/Elementary/LogicalFunctions/cardSatisfied.png\"></td>
    </tr>
<tr><td></td>
    <td align=\"center\">simulation result</td>
   </tr>
</table>
</html>"));
  end cardSatisfied;

  function cardUndecided
    "Returns the number of elements of a Property vector that are Undecided"
    extends Modelica_Requirements.Interfaces.PropertyFunction;
    import Modelica_Requirements.Types.Property;
    input Property p[:] "Property vector";
    output Integer result "Number of Property.Undecided entries";
  algorithm
    result :=sum(if e == Property.Undecided then 1 else 0 for e in p);
    annotation(Inline=true, Documentation(info="<html>

<h4>Syntax</h4>

<blockquote><p>
nUndecided = <b>cardUndecided</b>(p);
</p></blockquote>

<h4>Description</h4>
<p>
This function returns the number of Undecided-elements of Property vector p.
</p>

<p>
Violated, Undecided, and Satisfied are elements of enumeration
<a href=\"modelica://Modelica_Requirements.Types.Property\">Property</a>.
</p>

<h4>Example</h4>
<p>
This function is demonstrated with the following
<a href=\"modelica://Modelica_Requirements.Examples.Textual.Elementary.LogicalFunctions.cardUndecided\">example</a> calling the function as:
</p>

<blockquote>
nUndecided = cardUndecided( p )<br>
</blockquote>

<table border=0 cellspacing=0 cellpadding=2>
<tr><td width=\"50\"></td>
    <td valign=\"bottom\"><img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/Textual/Elementary/LogicalFunctions/cardUndecided.png\"></td>
    </tr>
<tr><td></td>
    <td align=\"center\">simulation result</td>
   </tr>
</table>
</html>"));
  end cardUndecided;

  function cardViolated
    "Returns the number of elements of a Property vector that are Violated"
    extends Modelica_Requirements.Interfaces.PropertyFunction;
    import Modelica_Requirements.Types.Property;
    input Property p[:] "Property vector";
    output Integer result "Number of Property.Violated entries";
  algorithm
    result :=sum(if e == Property.Violated then 1 else 0 for e in p);
    annotation(Inline=true, Documentation(info="<html>

<h4>Syntax</h4>

<blockquote><p>
nViolated = <b>cardViolated</b>(p);
</p></blockquote>

<h4>Description</h4>
<p>
This function returns the number of Violated-elements of Property vector p.
</p>

<p>
Violated, Undecided, and Satisfied are elements of enumeration
<a href=\"modelica://Modelica_Requirements.Types.Property\">Property</a>.
</p>

<h4>Example</h4>
<p>
This function is demonstrated with the following
<a href=\"modelica://Modelica_Requirements.Examples.Textual.Elementary.LogicalFunctions.cardViolated\">example</a> calling the function as:
</p>

<blockquote>
nViolated = cardViolated( p )<br>
</blockquote>

<table border=0 cellspacing=0 cellpadding=2>
<tr><td width=\"50\"></td>
    <td valign=\"bottom\"><img src=\"modelica://Modelica_Requirements/Resources/Images/Examples/Textual/Elementary/LogicalFunctions/cardViolated.png\"></td>
    </tr>
<tr><td></td>
    <td align=\"center\">simulation result</td>
   </tr>
</table>
</html>"));
  end cardViolated;
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}),
                   graphics={
                          Line(
          points={{-86,-12},{-50,-12},{-50,32},{48,32},{48,-12},{88,-12}},
          color={135,135,135})}),           Documentation(info="<html>
<p>
Sublibrary LogicalFunctions contains operators without memory, implemented as Modelica functions. 
The input arguments of these functions have 2-valued logic type (Boolean).
The output arguments of these functions have 2-valued or 3-valued logic type
(Boolean or <a href=\"modelica://Modelica_Requirements.Types.Property\">Property</a>).
The provided operators reason about their input arguments based on Boolean algebra.
The icon of a function depends on the the type of its output argument
(whether it is Boolean or <a href=\"modelica://Modelica_Requirements.Types.Property\">Property</a>).
</p>
</html>"));
end LogicalFunctions;
