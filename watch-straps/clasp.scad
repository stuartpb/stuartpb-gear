//watchband by isaac budmen @ibudmen

// Width of strap?
strap_width = 21.8; // [8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,24,26]
// Length of strap?
// NOTE_ This is actually the outer radius
strap_length = 24; // [22,24,26,28,30,32,34,36,38,40,42]

//Other variables
strap_thickness = 0.8;
pin_radius = 1.1; // Spring pin diameter divided by 2
pin_thickness = 0.8;
latch_radius = 1.4;
latch_thickness = 1.2;
latch_play = 0.1;
latch_strap_play = 0.1;
notch_length = 2;
notch_width = 1.4;
separation_angle = 12;

strap_end = strap_length * cos(12);
piece_offset = strap_length * sin(12);

notch_depth = 2*(pin_radius+pin_thickness);
//WHERE THE MAGIC HAPPENS
union(){
  band();
  pins(); 
  latch();
}

module pins(){
  difference(){
    translate([-piece_offset,-strap_end,0])
      cylinder(strap_width,r=pin_radius+pin_thickness,$fn = 50,center=true);
    translate([-piece_offset,-strap_end,0])
      cylinder(strap_width+2,r=pin_radius,$fn = 50,center=true);
    translate([-piece_offset,-strap_end,strap_width/2-notch_length]) rotate(-separation_angle)
      translate([-notch_width/2,0,0]) cube([notch_width,notch_depth,notch_length+1]);
    translate([-piece_offset,-strap_end,-strap_width/2-1]) rotate(-separation_angle)
      translate([-notch_width/2,0,0]) cube([notch_width,notch_depth,notch_length+1]);
  }

  difference(){
    translate([piece_offset,strap_end,0])
      cylinder(strap_width,r=pin_radius+pin_thickness,$fn = 50,center=true);
    translate([piece_offset,strap_end,0])
      cylinder(strap_width+2,r=pin_radius,$fn = 50,center=true);
      
    translate([piece_offset,strap_end,strap_width/2-notch_length]) rotate(180-separation_angle)
      translate([-notch_width/2,0,0]) cube([notch_width,notch_depth,notch_length+1]);
    translate([piece_offset,strap_end,-(strap_width/2)-1]) rotate(180-separation_angle)
      translate([-notch_width/2,0,0]) cube([notch_width,notch_depth,notch_length+1]);
  }
}

module latch() {
  difference(){
    translate([piece_offset,-strap_end,0])
      cylinder(strap_width,r=latch_radius+latch_thickness,center=true,$fn = 50); //outside latch - body  
    translate([piece_offset,-strap_end,0])
      cylinder(strap_width+3,r=latch_radius,center=true,$fn = 50); // //outside latch - clearing cylinder for pin
    translate([piece_offset,-strap_end,0]) rotate([0,0,separation_angle])
      translate([-(latch_radius + latch_thickness)/2,0,0])
        cube([latch_radius + latch_thickness,strap_thickness+2*latch_strap_play,30],center=true);
     // clearing cube for band
  }
    
  translate([-piece_offset,strap_end,0])
    cylinder(strap_width,r=latch_radius-latch_play,center=true,$fn = 50); // inside latch pin
}

module band(){
  difference(){ 
    cylinder(strap_width,r=strap_length+strap_thickness/2,center=true, $fn=180);
    cylinder(strap_width+2,r=strap_length-strap_thickness/2,center=true, $fn=180);
    
    // strip separators
    translate([pin_radius,strap_length,0]) cube(size = [2*piece_offset+pin_radius,strap_length,24],center=true);
    translate([(latch_radius+latch_play-pin_radius)/2,-strap_length,0]) cube(size = [2*piece_offset+latch_radius+latch_play+pin_radius,strap_length,24],center=true);
  }
}
