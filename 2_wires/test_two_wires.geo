// Gmsh project created on Mon Oct 21 10:39:37 2024
// define a variable radius
radius = 0.004/2;
lc = radius/5;
b_mult = 5;
boundary = radius * b_mult;
frequency = 50e3;
sigma = 37e6;
mu = 1.25663706212e-6;
delta = Min(Sqrt(2/(2*Pi*frequency*sigma*mu))*2, radius*0.7);
wire_spacing = 0.1 * radius;
structured_mesh_circumfrential_density = 180;
structured_mesh_radial_density = 10;

//+
SetFactory("OpenCASCADE");

//+ wire_1
Point(1) = {0, 0, 0, lc*1.5};
//+
Point(2) = {0, radius, 0, lc};
//+
Point(3) = {radius, 0, 0, lc};
//+
Point(4) = {0, -radius, 0, lc};
//+
Point(5) = {-radius, 0, 0, lc};

Point(22) = {0, radius-delta, 0, lc};
//+
Point(23) = {radius-delta, 0, 0, lc};
//+
Point(24) = {0, -radius+delta, 0, lc};
//+
Point(25) = {-radius+delta, 0, 0, lc};

//+
Point(6) = {0, boundary, 0, lc * b_mult * 0.5};
//+
Point(8) = {0, -boundary, 0, lc * b_mult * 0.5};
//+
Point(9) = {-boundary, 0, 0, lc * b_mult  * 0.5};
//+


//+ wire_2
Point(10) = {0 + wire_spacing, 0, 0, lc *1.5};
//+
//Point(11) = {0 + wire_spacing, radius, 0, lc/2};
//+
//Point(12) = {radius + wire_spacing, 0, 0, lc/2};
//+
//Point(13) = {0+wire_spacing, -radius, 0, lc/2};
//+
Point(14) = {-radius + wire_spacing, 0, 0, lc/2};

Point(26) = {0 + wire_spacing, radius-delta, 0, lc};
//+
Point(27) = {radius-delta+wire_spacing, 0, 0, lc};
//+
Point(28) = {0+wire_spacing, -radius+delta, 0, lc};
//+
Point(29) = {-radius+delta+wire_spacing, 0, 0, lc};

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
//
Circle(21) = {22, 1, 23};
Circle(22) = {23, 1, 24};
Circle(23) = {24, 1, 25};
Circle(24) = {25, 1, 22};

Line(31) = {2, 22};
Line(32) = {3, 23};
Line(33) = {4, 24};
Line(34) = {5, 25};

Transfinite Curve{1, 21, 2, 22, 3, 23, 4, 24} = structured_mesh_circumfrential_density/4;
Transfinite Curve{31, 32, 33, 34} = structured_mesh_radial_density Using Progression 1.0;

//+ wire 2
Circle(11) = {11, 10, 12};
Circle(12) = {12, 10, 13};
Circle(13) = {13, 10, 14};
Circle(14) = {14, 10, 11};

Circle(25) = {26, 10, 27};
Circle(26) = {27, 10, 28};
Circle(27) = {28, 10, 29};
Circle(28) = {29, 10, 26};

Line(35) = {11, 26};
Line(36) = {12, 27};
Line(37) = {13, 28};
Line(38) = {14, 29};

Transfinite Curve{11, 25, 12, 26, 13, 27, 14, 28} = structured_mesh_circumfrential_density/4;
Transfinite Curve{35, 36, 37, 38} = structured_mesh_radial_density Using Progression 1.0;



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
Curve Loop(15) = {-24, -23, -22, -21};
Plane Surface(1) = {15};
Curve Loop(21) = {31, 21, -32, -1};
Curve Loop(22) = {32, 22, -33, -2};
Curve Loop(23) = {33, 23, -34, -3};
Curve Loop(24) = {34, 24, -31, -4};
Curve Loop(25) = {-4, -3, -2, -1};
Plane Surface(21) = {21};
Plane Surface(22) = {22};
Plane Surface(23) = {23};
Plane Surface(24) = {24};

Transfinite Surface{21, 22, 23, 24};
//Recombine Surface{21, 22, 23, 24};


//+ Wire 2
Curve Loop(17) = {-28, -27, -26, -25};
Plane Surface(2) = {17};
Curve Loop(27) = {35, 25, -36,-11};
Curve Loop(28) = {36, 26, -37, -12};
Curve Loop(29) = {37, 27, -38, -13};
Curve Loop(30) = {38, 28, -35, -14};
Curve Loop(31) = {-14, -13, -12, -11};
Plane Surface(27) = {27};
Plane Surface(28) = {28};
Plane Surface(29) = {29};
Plane Surface(30) = {30};

Transfinite Surface{27, 28, 29, 30};
Recombine Surface{27, 28, 29, 30};
//+



// boundary
Curve Loop(19) = {-10, -9, -8,-7,-6,-5};
// air
Plane Surface(3) = {19, 25, 31};

//+
Physical Surface("wire_1", 1) = {1, 21, 22, 23, 24};
//Point{1} In Surface{1} ;
//+
Physical Surface("wire_2", 2) = {2, 27, 28, 29, 30};
Point{10} In Surface{2} ;
//+
Physical Surface("air", 3) = {3};
//+
Physical Curve("boundary", 1) = {5, 6, 7, 8 , 9 ,10};
//+
Mesh.Smoothing = 100;