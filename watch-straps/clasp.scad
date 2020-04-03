//watchband by isaac budmen @ibudmen

// Width of strap?
// TODO: fix as 21.8 - code below removes 2 from everything
// (to compensate for not having notches?)
strap_width = 23.8; // [8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,24,26]
// Length of strap?
strap_length = 24; // [22,24,26,28,30,32,34,36,38,40,42]

//Other variables
pin_radius = 1.2; // Actual pin size divided by 2
strap_thickness = 1; // NOTE: not truly implemented yet
latch_radius = 1.5;
latch_thickness = 1;
latch_play = 0.1;
latch_strap_play = 0.2;
notch_length = 2;
notch_width = 1.4;

piece_offset = 4.4;

//WHERE THE MAGIC HAPPENS
union(){
  band();
  pins(); 
  latch();
}

module pins(){
  difference(){
    translate([-piece_offset,-strap_length,-(strap_width/2)+1])cylinder(strap_width-2,pin_radius+1,pin_radius+1,$fn = 50);
    translate([-piece_offset,-strap_length,-(strap_width/2)])cylinder(strap_width+3,pin_radius,pin_radius,$fn = 50);
    translate([-piece_offset-notch_width/2,-strap_length,strap_width/2-1-notch_length])cube([notch_width,3,notch_length+1]);
    translate([-piece_offset-notch_width/2,-strap_length,-(strap_width/2)])cube([notch_width,3,notch_length+1]);
  }

  difference(){
    translate([piece_offset,strap_length,-(strap_width/2)+1])cylinder(strap_width-2,pin_radius+1,pin_radius+1,$fn = 50);
    translate([piece_offset,strap_length,-(strap_width/2)])cylinder(strap_width+3,pin_radius,pin_radius,$fn = 50);
      
    translate([piece_offset-notch_width/2,strap_length-3,strap_width/2-1-notch_length])cube([notch_width,3,notch_length+1]);
    translate([piece_offset-notch_width/2,strap_length-3,-(strap_width/2)])cube([notch_width,3,notch_length+1]);
  }
}

module pin_holes(){
  translate([0,strap_length,-(strap_width/2)])cylinder(strap_width+3,pin_radius,pin_radius,$fn = 50);
  translate([0,strap_length,(-strap_width/2)])cylinder(strap_width+3,pin_radius,pin_radius,$fn = 50);
}

module inside(){
cylinder(strap_width-2,strap_length+1.25,strap_length+1.25,center=true, $fn=150);
}

module outband(){
inside();
}

module latch() {
  difference(){
    translate([piece_offset,-strap_length-strap_thickness/2,0])cylinder(strap_width-2,latch_radius+latch_thickness,latch_radius+latch_thickness,center=true,$fn = 50); //outside latch - body  
    translate([piece_offset,-strap_length-strap_thickness/2,0])cylinder(strap_width+3,latch_radius,latch_radius,center=true,$fn = 50); // //outside latch - clearing cylinder for pin
    translate([piece_offset,-strap_length-strap_thickness/2,0])rotate([0,0,12])
      translate([-(latch_radius + latch_thickness)/2,0,0])cube([latch_radius + latch_thickness,strap_thickness+2*latch_strap_play,30],center=true);
     // clearing cube for band
  }
    
  translate([-piece_offset,strap_length+strap_thickness/2,0])cylinder(strap_width-2,latch_radius,latch_radius,center=true,$fn = 50); // inside latch pin

}

module band(){
  difference(){ 
    outband();
    scale([0.97,0.97,1.1])outband();
    
    // HACK - strip separators
    translate([.5,strap_length,0])cube(size = [11.5,strap_length,24],center=true);
    translate([.3,-strap_length,0])cube(size = [12,strap_length,24],center=true);
  }
}
