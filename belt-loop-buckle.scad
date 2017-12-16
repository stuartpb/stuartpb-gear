//!OpenSCAD
// title      : Belt Loop Buckle
// author     : Stuart P. Bentley (@stuartpb)
// version    : 0.1.0
// file       : belt-loop-buckle.scad

frameWidth = 6;
innerFrameWidth = 4;
slotWidth = 2;
beltWidth = 38;
loopWidth = 12;
buckleThickness = 3;

overallWidth = frameWidth*2+innerFrameWidth*2+slotWidth*3+loopWidth;
overallHeight = frameWidth*2+beltWidth;

module round2d(OR=3,IR=1){
    offset(OR)offset(-IR-OR)offset(IR)children();
}
$fn=90;
linear_extrude(buckleThickness) round2d(1,.999) difference () {
  square([overallWidth, overallHeight], true);
  // from left edge
  translate([-overallWidth/2,0]) {
    translate([frameWidth/2,0]) square([frameWidth,slotWidth], true);
    translate([frameWidth+slotWidth/2,0]) square([slotWidth,beltWidth], true);
  }
  // from right edge
  translate([overallWidth/2,0]) {
    translate([-frameWidth/2,0]) square([frameWidth,slotWidth], true);
    translate([-frameWidth-slotWidth/2,0]) square([slotWidth,beltWidth], true);
  }
  square([loopWidth,slotWidth],true);
  translate([0, beltWidth/2]) square([loopWidth,slotWidth],true);
  translate([0, -beltWidth/2]) square([loopWidth,slotWidth],true);
  translate([-loopWidth/2+slotWidth/2, beltWidth/4]) square([slotWidth,beltWidth/2],true);
  translate([loopWidth/2-slotWidth/2, -beltWidth/4]) square([slotWidth,beltWidth/2],true);
}