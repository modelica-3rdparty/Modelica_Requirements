within Modelica_Requirements;
package Utilities "Library of utility functions"
  extends Modelica.Icons.UtilitiesPackage;

  function distancePointToPolygon
    "Return minimum distance between a point and a polygon"
     import Modelica.Math.Vectors.length;

     input Real polygon[:,2] "Polygon points (x,y)";
     input Real point[2] "Point inside, outside or on polygon";
     output Real distance "Minimum distance of point to polygon";
     output Real polygonPoint[2] "Point on polygon that is closest to point";
  protected
     Integer nPoly = size(polygon,1) "Number of polygon points";
     Real p1[2];
     Real p2[2];
     Real p1p[2];
     Real p12[2];
     Real p12_squared;
     Real eps = 100*Modelica.Constants.eps;
     Real polygonPoint_temp[2];
     Real d_temp;
     Real lambda;
  algorithm
     assert(nPoly > 1, "Polygon must have at least 2 points");

     /* Determine minimum distance to polygon:
      p1 and p2 are two points of the polygon connected by a straight line.
      Then all points on this line are described by:

         p12 = p2-p1
         p1p = point - p1  
         polygonPoint = p1 + lambda*p12  with  0 <= lambda <= 1
   
      The cosine of the angle between vectors p12 and p1p is computed with
      the dot product and with the relationships in a triangle, where lambda
      characterizes the point on the line with the shortest distance to point:

         cos(phi) = lambda*length(p12)/length(p1p) 
                  = p12*p1p/(length(p12)*length(p1p))

      and therefore

         lambda = p12*p1p/length(p12)^2
                = p12*p1p/(p12*p12)
   */
     for i in 1:nPoly loop
        p1  := polygon[i, :];
        p2  := if i < nPoly then polygon[i + 1, :] else polygon[1, :];
        p1p := point - p1;
        p12 := p2- p1;

        // Compute point on polygon segment that is closest to point: polygonPoint = p1 + lambda*p12
        p12_squared :=p12*p12;
        lambda :=if p12_squared > eps then p1p*p12/p12_squared else 0;
        lambda :=max(min(lambda,1),0) "Restrict lambda to the range 0..1";
        polygonPoint_temp :=p1 + lambda*p12;
        d_temp :=length(p1p - lambda*p12);

        // Select point with minimum distance so far
        if i == 1 then
           polygonPoint :=polygonPoint_temp;
           distance :=d_temp;
        else
           if d_temp < distance then
              polygonPoint :=polygonPoint_temp;
              distance :=d_temp;
           end if;
        end if;
     end for;

     // Determine whether point is inside or outside of polygon
     if not isInsidePolygon(polygon, point) then
        distance :=-distance;
     end if;

    annotation (Documentation(info="<html>
<h4>Syntax</h4>

<blockquote><p>
(distance, polygonPoint) = <b>minimumDistanceToPolygon</b>(polygon, point);
</p></blockquote>

<h4>Description</h4>
<p>
This function computes the minimum distance of a point to a polygon.
</p>

<p>
The polygon is defined by a set of points <b>polygon</b>[:,2],
where polygon[i,1] is the x-coordinate of
polygon point i and polygon[i,2] is the y-coordinate. The last point of the polygon
can be identical to the first point, so polygon[1,:] = polygon[end,:].
If this is not the case, the function assumes that the last point
polygon[end,:] is connected implicitely to the first point polygon[1,:].
</p>

<p>
The goal is to compute the minimum distance of the vector input <b>point</b> 
to polygon, where point[1] is the x-coordinate and point[2] the y-coordinate.
</p>

<p>
The function returns the minimum distance as <b>distance</b>. <br>
If distance &gt; 0, then point is inside of the polygon.<br>
If distance &lt; 0, then point is outside of the polygon.<br>
If distance = 0, then point is on the polygon.<br>
Furthermore, the point polygonPoint[2] is returned, which is a point
on polygon (either on an edge or a vertex of the polygon) 
that is closest to input argument point.
</p>
</html>"));
  end distancePointToPolygon;

  function isInsidePolygon
    "Return true if a point is inside or on a polygon (otherwise return false)"
    input Real polygon[:, 2] "Polygon points (x,y)";
    input Real point[2] "Point inside, outside or on polygon";
    output Boolean inside
      "= true, if point is inside or on polygon, otherwise point is outside of polygon";

  protected
    Real x,y;
    Real x_old, y_old;
    Real x_new, y_new;
    Real x1, y1;
    Real x2, y2;

  algorithm
    inside := false;
    x := point[1];
    y := point[2];

    x_old := polygon[end, 1];
    y_old := polygon[end, 2];

    for i in 1:size(polygon,1) loop
      x_new := polygon[i, 1];
      y_new := polygon[i, 2];
      if x_new > x_old then
        x1 := x_old;
        x2 := x_new;
        y1 := y_old;
        y2 := y_new;
      else
        x1 := x_new;
        x2 := x_old;
        y1 := y_new;
        y2 := y_old;
      end if;

      if (x_new < x) == (x <= x_old) and
         (y - y1)*(x2 - x1) < (y2 - y1)*(x - x1) then
        /* first line: edge "open" at left end */
        inside := not inside;
      end if;
      x_old := x_new;
      y_old := y_new;
    end for;

    annotation (Documentation(revisions="<html>
<pre>2009/12/04 creation by E. Thomas from c code INPOLY.C (Freeware source code http://www.visibone.com/inpoly/inpoly.c)</pre>
</html>",   info="<html>

</html>"));
  end isInsidePolygon;
end Utilities;
