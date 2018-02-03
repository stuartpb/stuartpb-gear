/* [Measurements] */

ware_gauge = 1.5;

// The length of the "wings" of the ware.
ware_depth = 4;

// The distance between the "wings" of the ware.
ware_width = 14.5;

// The increase in distance between the "wings" from the inside to outside.
wing_spread = 1;

// The diameter of the chopsticks.
stick_diameter = 7.25;

// The diameter of the circles to hold the ware.
ware_circle_diameter = 8.25;

outer_round_factor = 2/3;
inner_round_radius = 1.5;

/* [Parameters] */

// How much space to leave around the held pieces.
tolerance = 0.325;

// How much material to hold the pieces with.
thickness = 2;

// How far into the ware each end should hold.
// Should be shorter than distance to the hinge.
total_length = 10;

// How much of the stick holder width should be open.
ware_circle_space = 1/2;
stick_space = 1/2;

ware_circle_space_angle = 135;

stick_space_angle = 0;

/* Resolution */

$fn = 90;

/* [Hidden] */

ware_circle_radius = ware_circle_diameter/2;
stick_radius = stick_diameter/2;

module ware_holder () {
  ware_circle_x = ware_circle_radius + thickness/2;
  ware_circle_outer_radius = ware_circle_radius+thickness;
  ware_circle_inner_radius = ware_circle_radius;
  
  translate([0, ware_circle_x]) linear_extrude(total_length) difference() {
    union() {
      translate([-ware_circle_x, 0]) circle(r=ware_circle_outer_radius);
      translate([ware_circle_x, 0]) circle(r=ware_circle_outer_radius);
      // fill possible gap on bottom edge
      translate([-ware_circle_x,-ware_circle_outer_radius])
        square([ware_circle_diameter+thickness,ware_circle_outer_radius]);
    }
    translate([-ware_circle_x, 0]) circle(r=ware_circle_inner_radius);
    translate([ware_circle_x, 0]) circle(r=ware_circle_inner_radius);
    translate([-ware_circle_x, 0])
      rotate([0, 0, 180 - ware_circle_space_angle]) translate([ware_circle_inner_radius + thickness/2,0])
      square([ware_circle_inner_radius*2*ware_circle_space,ware_circle_inner_radius],center=true);
    translate([ware_circle_x, 0])
      rotate([0, 0, ware_circle_space_angle]) translate([ware_circle_inner_radius + thickness/2,0])
      square([ware_circle_inner_radius*2*ware_circle_space,ware_circle_inner_radius],center=true);
  }
}

module stick_holder() {
  stick_x = ware_circle_diameter + thickness + stick_radius;
  stick_outer_radius = stick_radius+thickness+tolerance;
  stick_inner_radius = stick_radius+tolerance;
  intersection () {
    rotate([-2,0,0]) translate([stick_x, 0, -total_length/2])
      linear_extrude(total_length*2) difference () {
        circle(r=stick_outer_radius);
        circle(r=stick_inner_radius);
        rotate([0, 0, stick_space_angle]) translate([stick_inner_radius + thickness/2,0])
          square([stick_inner_radius*2*stick_space,stick_inner_radius],center=true);
    }
    translate([stick_x,0,total_length/2])
      cube([4*stick_outer_radius, 4*stick_outer_radius, total_length], center=true);
  }
}

ware_holder();
difference() {
  mirror([0,1,0]) ware_holder();
  translate([0,0,total_length/2])
    cube([2*ware_circle_radius + thickness, 4*ware_circle_radius, 2*total_length], center=true);
}
stick_holder();
mirror([1,0,0]) stick_holder();
