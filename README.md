# Modelica_Requirements

Defining requirements formally and checking them when simulating

## Library description

Library Modelica_Requirements is a Modelica package to formally define requirements and checking them automatically when a model is simulated. An overview of this library is given in the publication [Formal  Requirements Modeling for Simulation-Based Verification](http://www.ep.liu.se/ecp/118/067/ecp15118625.pdf) 

In order to define properties and requirements mostly a 2-valued logic is used. There are some functions and blocks based on 3-valued logic using type Property, especially block Requirement. Furthermore, there are cast-operators to map 2-valued to 3-valued logic and vice versa. 3-valued logic is used to define (a) if a property is not tested (because only relevant in a certain situation) and (b) if a requirement was not tested in a simulation run. 

In this package the standard convention is used that names of memory-less operators (implemented as Modelica functions) start with lower-case letters and names of operators with memory (implemented as Modelica blocks) start with upper-case letters.
 
This package uses basically Modelica 3.2 language elements and requires at least version 3.2.2 of the Modelica Standard Library (some parts will not work with 3.2.1 or an earlier version). Additionally, the Modelica extension is used in some examples (but not outside of examples) to pass a model instance as argument to a function (and the function argument is a record). This feature is used to associate requirements in a reasonably convenient way with behavioral models. This approach is currently under discussion at the Modelica Association. Most likely a slightly different concept will be introduced in the next release of the Modelica language by providing the cast of a model to a record. Once this is clear and prototypes are available in Modelica tools, this new concept will be used in this library. Earlier versions of this library contained also examples utilizing the proposed new Modelica language element to "call a block as a function". These examples had been removed from this version. 

The current version of the library uses a buffer for the implementation of sliding windows (Internal.SlidingWindow). The size of this buffer is fixed to 20 (constant nBuffer in package SlidingWindow). If the buffer is too small for a requirement from package ChecksInSlidingWindow, then a warning is printed. The result of the requirement verification might then not be correct. 

**This package is not yet finalized. A redesign is planned. The redesigned library (with improved implementations of models and new functionality) should be backwards compatible to this version, but it is not guaranteed. If non-backwards compatible changes are introduced, most likely automatic conversions will not be provided.**
