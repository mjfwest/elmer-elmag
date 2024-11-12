// Gmsh project created on Mon Oct 21 10:39:37 2024
// define a variable radius
radius = 0.001/2;
lc = radius/5;
b_mult = 10;
boundary = radius * b_mult;
wire_spacing = 5 * radius;
//+
SetFactory("OpenCASCADE");

//+ wire_1
Point(1) = {0, 0, 0, lc *2};
//+
Point(2) = {0, radius, 0, lc/2};
//+
Point(3) = {radius, 0, 0, lc/2};
//+
Point(4) = {0, -radius, 0, lc/2};
//+
Point(5) = {-radius, 0, 0, lc/2};

//+
Point(6) = {0, boundary, 0, lc * b_mult * 0.5};
//+
Point(8) = {0, -boundary, 0, lc * b_mult * 0.5};
//+
Point(9) = {-boundary, 0, 0, lc * b_mult * 0.5};
//+
Point(10) = {0 + wire_spacing, 0, 0, lc *2};

//+ wire_2
Point(11) = {0 + wire_spacing, radius, 0, lc/2};
//+
Point(12) = {radius + wire_spacing, 0, 0, lc/2};
//+
Point(13) = {0+wire_spacing, -radius, 0, lc/2};
//+
Point(14) = {-radius + wire_spacing, 0, 0, lc/2};

//+
Point(15) = {0+wire_spacing, boundary, 0, lc * b_mult * 0.5};
//+
Point(16) = {boundary+wire_spacing, 0, 0, lc * b_mult * 0.5};
//+
Point(17) = {0+wire_spacing, -boundary, 0, lc * b_mult * 0.5};
//+


//+ wire 1
Circle(1) = {2, 1, 3};
//+
Circle(2) = {3, 1, 4};
//+
Circle(3) = {4, 1, 5};
//+
Circle(4) = {5, 1, 2};

//+ wire 2
Circle(11) = {11, 10, 12};
//+
Circle(12) = {12, 10, 13};
//+
Circle(13) = {13, 10, 14};
//+
Circle(14) = {14, 10, 11};


//+ right hand boundary
Circle(5) = {15, 10, 16};
Circle(6) = {16, 10, 17};
//+ Bottom
Line(7) = {17, 8};
//+ left hand boundary
Circle(8) = {8, 1, 9};
Circle(9) = {9, 1, 6};
//+ Top boundary
Line(10) = {6, 15};
//+ 

//+ Wire 1
Curve Loop(15) = {-4, -3, -2, -1};
Plane Surface(1) = {15};
//+ Wire 2
Curve Loop(17) = {-14, -13, -12, -11};
Plane Surface(2) = {17};

// boundary
Curve Loop(19) = {-10, -9, -8,-7,-6,-5};
// air
Plane Surface(3) = {19, 15, 17};

//+
Physical Surface("wire_1", 1) = {1};
//+
Physical Surface("wire_2", 2) = {2};
//+
Physical Surface("air", 3) = {3};
//+
Physical Curve("boundary", 1) = {5, 6, 7, 8 , 9 ,10};
//+

//+
Show "*";
