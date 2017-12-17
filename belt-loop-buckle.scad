//!OpenSCAD
// title      : Belt Loop Buckle
// author     : Stuart P. Bentley (@stuartpb)
// version    : 0.3.0
// file       : belt-loop-buckle.scad

frameWidth = 6;
innerFrameWidth = 4;
fabricThickness = 2;
centerSlotThickness = 4;
beltWidth = 38;
beltThickness = 5;
loopWidth = 12;
buckleThickness = 3;

overallWidth = frameWidth*2+innerFrameWidth*2+beltThickness*2+fabricThickness+loopWidth;
overallHeight = frameWidth*2+beltWidth;

module round2d(OR=3,IR=1){
    offset(OR)offset(-IR-OR)offset(IR)children();
}
$fn=90;
linear_extrude(buckleThickness) round2d(1,.999) difference () {
  square([overallWidth, overallHeight], true);
  // from left edge
  translate([-overallWidth/2,0]) {
    translate([frameWidth/2,0]) square([frameWidth,fabricThickness], true);
    translate([frameWidth+beltThickness/2,0]) square([beltThickness,beltWidth], true);
  }
  // from right edge
  translate([overallWidth/2,0]) {
    translate([-frameWidth/2,0]) square([frameWidth,fabricThickness], true);
    translate([-frameWidth-beltThickness/2,0]) square([beltThickness,beltWidth], true);
  }
  square([loopWidth,centerSlotThickness],true);
  translate([0, beltWidth/2]) square([loopWidth,fabricThickness],true);
  translate([0, -beltWidth/2]) square([loopWidth,fabricThickness],true);
  translate([-loopWidth/2+fabricThickness/2, beltWidth/4]) square([fabricThickness,beltWidth/2],true);
  translate([loopWidth/2-fabricThickness/2, -beltWidth/4]) square([fabricThickness,beltWidth/2],true);
}