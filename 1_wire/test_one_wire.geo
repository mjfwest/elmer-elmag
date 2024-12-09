// Gmsh project created on Mon Oct 21 10:39:37 2024
// define a variable radius
radius = 0.004/2;
lc = radius/30;
b_mult = 10;
boundary = radius * b_mult;
frequency = 1e3;
sigma = 37e6;
mu = 1.25663706212e-6;
delta = Min(Sqrt(2/(2*Pi*frequency*sigma*mu))*2, radius*0.7);
outside_mesh = 2.5;
skin_mesh = 1;
origin_mesh = 2 ;

//+
SetFactory("OpenCASCADE");

//+ wire_1
Point(1) = {0, 0, 0, lc*origin_mesh};
//+
Point(2) = {0, radius, 0, lc};
//+
Point(3) = {radius, 0, 0, lc};
//+
Point(4) = {0, -radius, 0, lc};
//+
Point(5) = {-radius, 0, 0, lc};


Point(10) = {(radius-delta) * Sin(0*Pi/8), (radius-delta)* Cos(0*Pi/8), 0, lc*skin_mesh};
Point(11) = {(radius-delta) * Sin(1*Pi/8), (radius-delta)* Cos(1*Pi/8), 0, lc*skin_mesh};
Point(12) = {(radius-delta) * Sin(2*Pi/8), (radius-delta)* Cos(2*Pi/8), 0, lc*skin_mesh};
Point(13) = {(radius-delta) * Sin(3*Pi/8), (radius-delta)* Cos(3*Pi/8), 0, lc*skin_mesh};
Point(14) = {(radius-delta) * Sin(4*Pi/8), (radius-delta)* Cos(4*Pi/8), 0, lc*skin_mesh};
Point(15) = {(radius-delta) * Sin(5*Pi/8), (radius-delta)* Cos(5*Pi/8), 0, lc*skin_mesh};
Point(16) = {(radius-delta) * Sin(6*Pi/8), (radius-delta)* Cos(6*Pi/8), 0, lc*skin_mesh};
Point(17) = {(radius-delta) * Sin(7*Pi/8), (radius-delta)* Cos(7*Pi/8), 0, lc*skin_mesh};
Point(18) = {(radius-delta) * Sin(8*Pi/8), (radius-delta)* Cos(8*Pi/8), 0, lc*skin_mesh};
Point(19) = {(radius-delta) * Sin(9*Pi/8), (radius-delta)* Cos(9*Pi/8), 0, lc*skin_mesh};
Point(20) = {(radius-delta) * Sin(10*Pi/8), (radius-delta)* Cos(10*Pi/8), 0, lc*skin_mesh};
Point(21) = {(radius-delta) * Sin(11*Pi/8), (radius-delta)* Cos(11*Pi/8), 0, lc*skin_mesh};
Point(22) = {(radius-delta) * Sin(12*Pi/8), (radius-delta)* Cos(12*Pi/8), 0, lc*skin_mesh};
Point(23) = {(radius-delta) * Sin(13*Pi/8), (radius-delta)* Cos(13*Pi/8), 0, lc*skin_mesh};
Point(24) = {(radius-delta) * Sin(14*Pi/8), (radius-delta)* Cos(14*Pi/8), 0, lc*skin_mesh};
Point(25) = {(radius-delta) * Sin(15*Pi/8), (radius-delta)* Cos(15*Pi/8), 0, lc*skin_mesh};



//+
Point(6) = {0, boundary, 0, lc * b_mult * outside_mesh};
//+
Point(7) = {boundary, 0, 0, lc * b_mult * outside_mesh};
//+
Point(8) = {0, -boundary, 0, lc * b_mult * outside_mesh};
//+
Point(9) = {-boundary, 0, 0, lc * b_mult  * outside_mesh};




//+ wire 1
Circle(1) = {2, 1, 3};
//+
Circle(2) = {3, 1, 4};
//+
Circle(3) = {4, 1, 5};
//+
Circle(4) = {5, 1, 2};

//+ right hand boundary
Circle(5) = {6, 1, 7};
Circle(6) = {7, 1, 8};
//+ left hand boundary
Circle(8) = {8, 1, 9};
Circle(9) = {9, 1, 6};


//+ 

//+ Wire 1

Curve Loop(25) = {-4, -3, -2, -1};
Plane Surface(1) = {25};

// boundary
Curve Loop(19) = {-9, -8,-6, -5};
// air
Plane Surface(3) = {19, 25};

//+
Physical Surface("wire_1", 1) = {1};
Point{1} In Surface{1} ;
Point{10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25} In Surface{1} ;
//
Physical Surface("air", 3) = {3};
//+
Physical Curve("boundary", 1) = {5, 6, 8 ,9 };
//+
Mesh.Smoothing = 100;