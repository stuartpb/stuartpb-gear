/* [Measurements] */

ware_gauge = 1.5;

// The length of the "wings" of the ware.
ware_depth = 5;

// The distance between the "wings" of the ware.
ware_width = 13.8;

// The increase in distance between the "wings" from the inside to outside.
wing_spread = 0.5;

// The diameter of the chopsticks.
stick_diameter = 7.25;

outer_round_factor = 2/3;
inner_round_radius = 1.5;

/* [Parameters] */

// How much space to leave around the held pieces.
tolerance = 0.25;

// How much material to hold the pieces with.
thickness = 2;

// How far into the ware each end should hold.
// Should be shorter than distance to the hinge.
ware_hold = 10;

// How much of the stick holder width should be open.
stick_space = 1/2;

stick_space_angle = 135;

/* Resolution */

$fn = 90;

/* [Hidden] */

stick_radius = stick_diameter/2;

total_length = 2*ware_hold + thickness;

module ware_inside_trapezoid() {
  inside_ware_bottom_x = (ware_width + wing_spread)/2 - tolerance;
  inside_ware_top_x = ware_width/2 - tolerance;
  inside_ware_y = ware_depth/2 - tolerance;
  
  polygon([
    [-inside_ware_bottom_x, -inside_ware_y],
    [   -inside_ware_top_x,  inside_ware_y],
    [    inside_ware_top_x,  inside_ware_y],
    [ inside_ware_bottom_x, -inside_ware_y]]);
}

module ware_track () {
  offset(r=tolerance) offset(r=-inner_round_radius) offset(r=inner_round_radius)
    difference () {
      offset(r=ware_gauge*outer_round_factor) offset(delta=ware_gauge*(1-outer_round_factor))
        ware_inside_trapezoid();
      translate([0, -ware_gauge/2]) scale([1, ware_depth / (ware_depth - ware_gauge)])
        ware_inside_trapezoid();
    }
}

module ware_holder () {
  linear_extrude(total_length) difference() {
    offset(r=thickness) ware_track();
    ware_track();
  }
  translate([0,0,ware_hold]) linear_extrude(thickness) offset(r=thickness) ware_track();
}

module stick_holder () {
  stick_x = stick_radius + tolerance + thickness/2;
  stick_outer_radius = stick_radius+tolerance+thickness;
  stick_inner_radius = stick_radius+tolerance;
  
  linear_extrude(total_length) difference() {
    union() {
      translate([-stick_x, 0]) circle(r=stick_outer_radius);
      translate([stick_x, 0]) circle(r=stick_outer_radius);
      // fill possible gap on bottom edge
      translate([-stick_x,-stick_outer_radius])
        square([stick_diameter+thickness+tolerance*2,stick_outer_radius]);
    }
    translate([-stick_x, 0]) circle(r=stick_inner_radius);
    translate([stick_x, 0]) circle(r=stick_inner_radius);
    translate([-stick_x, 0])
      rotate([0, 0, 180 - stick_space_angle]) translate([stick_inner_radius + thickness/2,0])
      square([stick_inner_radius*2*stick_space,stick_inner_radius],center=true);
    translate([stick_x, 0])
      rotate([0, 0, stick_space_angle]) translate([stick_inner_radius + thickness/2,0])
      square([stick_inner_radius*2*stick_space,stick_inner_radius],center=true);
  }
}

translate([0,-ware_depth/2-ware_gauge-thickness/2]) ware_holder();
translate([0,stick_radius+tolerance+thickness/2]) stick_holder();