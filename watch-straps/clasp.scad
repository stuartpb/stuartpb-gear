//!OpenSCAD
// Watch clasp by Stuart P. Bentley (https://stuartpb.com/)
// Originally based on a design by isaac budmen @ibudmen:
//   https://www.thingiverse.com/thing:87132

/* [Strap] */

// The radius of the strap (before assembly).
strap_radius = 24; // [12:36]
// The width of the strap (between the arms of the watch).
strap_width = 21.8;
// The thickness of the strap material.
strap_thickness = 0.8;

// The degree to be subtracted from each end of the strap.
separation_angle = 12;

/* [Barholds] */

// The thickness of the material surrounding the spring bars.
barhold_thickness = 0.8;
// The radius of the holes for the spring bars.
barhole_radius = 1.1;
// How deep to cut the notches for access to the spring bars.
notch_length = 2;
// How wide to make the notches to access the spring bars.
notch_width = 1.4;

/* [Latch] */

// The radius of the inside of the latch.
latch_radius = 1.4;
// The thickness of the outside of the latch.
latch_thickness = 1.2;
// How much the radius of the smaller latch piece should be.
latch_play = 0.1;
// How much wider than the strap thickness the outside latch's opening should be.
latch_strap_play = 0.1;

/* [Hidden] */

strap_end = strap_radius * cos(separation_angle);
piece_offset = strap_radius * sin(separation_angle);

notch_depth = 2*(barhole_radius+barhold_thickness);

union() {
  band();
  barholds(); 
  latch();
}

module barholds(){
  difference(){
    translate([-piece_offset,-strap_end,0])
      cylinder(strap_width,r=barhole_radius+barhold_thickness,$fn = 50,center=true);
    translate([-piece_offset,-strap_end,0])
      cylinder(strap_width+2,r=barhole_radius,$fn = 50,center=true);
    translate([-piece_offset,-strap_end,strap_width/2-notch_length]) rotate(-separation_angle)
      translate([-notch_width/2,0,0]) cube([notch_width,notch_depth,notch_length+1]);
    translate([-piece_offset,-strap_end,-strap_width/2-1]) rotate(-separation_angle)
      translate([-notch_width/2,0,0]) cube([notch_width,notch_depth,notch_length+1]);
  }

  difference(){
    translate([piece_offset,strap_end,0])
      cylinder(strap_width,r=barhole_radius+barhold_thickness,$fn = 50,center=true);
    translate([piece_offset,strap_end,0])
      cylinder(strap_width+2,r=barhole_radius,$fn = 50,center=true);
      
    translate([piece_offset,strap_end,strap_width/2-notch_length]) rotate(180-separation_angle)
      translate([-notch_width/2,0,0]) cube([notch_width,notch_depth,notch_length+1]);
    translate([piece_offset,strap_end,-(strap_width/2)-1]) rotate(180-separation_angle)
      translate([-notch_width/2,0,0]) cube([notch_width,notch_depth,notch_length+1]);
  }
}

module latch() {
  difference(){
    // outside latch - body
    translate([piece_offset,-strap_end,0])
      cylinder(strap_width,r=latch_radius+latch_thickness,center=true,$fn = 50);
    // outside latch - clearing cylinder for pin
    translate([piece_offset,-strap_end,0])
      cylinder(strap_width+3,r=latch_radius,center=true,$fn = 50);
    // clearing cube for band
    translate([piece_offset,-strap_end,0]) rotate([0,0,separation_angle])
      translate([-(latch_radius + latch_thickness)/2,0,0])
        cube([latch_radius + latch_thickness,strap_thickness+2*latch_strap_play,30],center=true);
  }
  
  // inside latch pin
  translate([-piece_offset,strap_end,0])
    cylinder(strap_width,r=latch_radius-latch_play,center=true,$fn = 50); 
}

module band(){
  difference(){ 
    cylinder(strap_width,r=strap_radius+strap_thickness/2,center=true, $fn=180);
    cylinder(strap_width+2,r=strap_radius-strap_thickness/2,center=true, $fn=180);
    
    // strip separators
    translate([barhole_radius,strap_radius,0]) cube(size = [2*piece_offset+barhole_radius,strap_radius,24],center=true);
    translate([(latch_radius+latch_play-barhole_radius)/2,-strap_radius,0]) cube(size = [2*piece_offset+latch_radius+latch_play+barhole_radius,strap_radius,24],center=true);
  }
}
