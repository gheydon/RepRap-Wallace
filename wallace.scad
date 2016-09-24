include <parts.scad>
include <config.scad>

// defaults that can be overridden in the config.scad
bearing = (bearing==undef ? rod[ 2 ] : bearing);
x_rod_spacing = (x_rod_spacing==undef ? motor[ 1 ] + 3 + rod[ 1 ] : x_rod_spacing);

echo ( "Rod = ", rod[ 0 ] );
echo ( "Bearing = ", bearing[ 0 ] );
echo ( "Threaded Rod = ", threaded_rod[ 0 ]);

// ratio for converting diameter to apothem
da6 = 1 / cos(180 / 6) / 2;
da8 = 1 / cos(180 / 8) / 2;

//Comment out all of the lines in the following section to render the assembled machine. Uncomment one of them to export that part for printing. You can also use the individual files to export each part.

//!base_end();
//!for(b = [0:1]) mirror([0, b, 0]) for(a = [-1,1]) translate([a * bearing[ 1 ] / 4, bearing[ 1 ] - (bearing[ 1 ] * 2/3) * a, 0]) rotate(90 + 90 * a) y_bearing_retainer();
//!for(b = [0:1]) mirror([0, b, 0]) for(a = [-1,1]) translate([a * -7.5, 18 - 5 * a, 0]) rotate(180 + 90 * a) bed_mount();
//!x_end(2);
//!x_end(0);
//!x_carriage();
//!for(side = [-1,1]) translate([0, side * motor[ 1 ] / 2, 0]) leadscrew_coupler();
//!y_idler();
//!for(x = [1, -1]) for(y = [1, -1]) translate([x * (pulley_size / 2 + 3), y * (pulley_size / 2 + 3), 0]) idler_pulley(true);
//!for(x = [1, -1]) for(y = [1, -1]) translate([x * (rod[ 1 ] * 1.5 + 2), y * (rod[ 1 ] * 1.5 + 2), 0]) foot();
//!for(side = [0, 1]) mirror([side, 0, 0]) translate([-rod[ 1 ] * 2.5, 0, 0]) z_top_clamp();


//The following section positions parts for rendering the assembled machine.

  translate([0, 0, -bearing[ 1 ]]) rotate([0, 180, 0]) base_end();
  for(end = [1, -1]) translate([0, end * motor[ 1 ] / 2 + 5, -bearing[ 1 ] + bearing[ 1 ] * sqrt(2) / 4]) rotate([-90, 0, 180]) y_bearing_retainer();
  for(side = [0, 1]) mirror([0, side, 0]) translate([yz_motor_distance / 2 - bearing[ 1 ] / 2, -motor[ 2 ] / 2 - rod[ 1 ] * 2 - 10, -bearing[ 1 ] + bearing[ 1 ] * sqrt(2) / 4]) rotate([90, 0, 0]) bed_mount();
  translate([-yz_motor_distance / 2 + rod[ 1 ] - motor[ 2 ] / 4 - rod[ 1 ] / 2, 0, 60 + (x_rod_spacing + 8 + rod[ 1 ]) / 2]) rotate([0, 180, 0]) x_end(0);
  translate([140, 0, 60 + (x_rod_spacing + 8 + rod[ 1 ]) / 2]) rotate([0, 180, 0]) {
    x_end(2);
    translate([0, 8 + rod[ 1 ], 0]) rotate([90, 0, 0]) translate([0, (x_rod_spacing + 8 + rod[ 1 ]) / 2, rod[ 1 ] / 2 - 2 - bearing[ 1 ] / 2 - 4 - idler_pulley_width - 1.5]) idler_pulley(true);
  }
  translate([40, rod[ 1 ] + bearing[ 1 ] / 2 + 1 - rod[ 1 ] / 2 + 2, 60]) {
    rotate([90, 0, 90]) x_carriage();
    translate([x_carriage_width / 2 + carriage_extruder_offset, -14 - bearing[ 1 ] / 2 - 4, x_rod_spacing / 2 + bearing[ 1 ] / 2 + 4]) {
      rotate([90, 0, 180]) translate([10.57, 30.3, -14]) import("gregs/gregs_accessible_wade-wildseyed_mount.stl", convexity = 5);
      %rotate(180 / 8) cylinder(r = 2, h = 150, center = true, $fn = 8);
    }
  }
  translate([-yz_motor_distance / 2 - motor[ 2 ] / 2, 0, -bearing[ 1 ] / 2]) leadscrew_coupler();
  translate([60, 0, -bearing[ 1 ] - rod[ 1 ] / 2 - bearing[ 1 ] / 2]) {
    rotate([0, 90, 0]) y_idler();
    for(side = [1, -1]) translate([5, side * (motor[ 2 ] / 2 - rod[ 1 ] / 2), idler_pulley_width + 1.5 + rod[ 1 ]]) rotate([180, 0, 0]) idler_pulley(true);
  }
  for(side = [0, 1]) mirror([0, side, 0]) translate([0, -motor[ 2 ] / 2 - rod[ 1 ] * 2 - 10, -bearing[ 1 ] - motor[ 3 ] + rod[ 1 ] * 1.5]) rotate([90, 0, 0]) foot();
  translate([-yz_motor_distance / 2 + rod[ 1 ], 0, 210 - motor[ 3 ]]) rotate([180, 0, 90]) z_top_clamp(0);






module z_top_clamp() difference() {
  union() {
    linear_extrude(height = rod[ 1 ] * 2 + gusset_size, convexity = 5) difference() {
      union() {
        circle(r = rod[ 1 ] * da6 * 2, $fn = 6);
        translate([0, -rod[ 1 ], 0]) square([rod[ 1 ] * (1 + da6), rod[ 1 ] * 2]);
        translate([rod[ 1 ] - rod[ 1 ] * da6, rod[ 1 ] / 2, rod[ 1 ]]) square([rod[ 1 ] * da6 * 2, rod[ 1 ] / 2 + gusset_size]);
      }
    }
    translate([rod[ 1 ], -rod[ 1 ] - 1, rod[ 1 ]]) rotate([-90, 0, 0]) cylinder(r = rod[ 1 ] / cos(180 / 6), h = rod[ 1 ] * 2 + gusset_size + 2, $fn = 6);
  }
  translate([rod[ 1 ], -rod[ 1 ] - 2, rod[ 1 ]]) rotate([-90, 0, 0]) cylinder(r = rod[ 1 ] * da6, h = gusset_size + rod[ 1 ] * 2 + 4, $fn = 6);
  translate([rod[ 1 ], rod[ 1 ] + gusset_size, rod[ 1 ] * 2 + gusset_size]) rotate([45, 0, 0]) cube([rod[ 1 ] * 2, gusset_size * sqrt(2), gusset_size * sqrt(2)], center = true);
  translate([0, 0, -1]) linear_extrude(height = rod[ 1 ] * 2 + gusset_size + 2, convexity = 5) {
    circle(r = rod[ 1 ] * da6, $fn = 6);
    %translate([rod[ 1 ], -10, rod[ 1 ] * da6 * 2]) rotate([-90, 0, 0]) cylinder(r = rod[ 1 ] * da6, h = 160, $fn = 6);
    translate([0, -rod[ 1 ] / 2, 0]) square([gusset_size + rod[ 1 ] * 2 + 1, rod[ 1 ]]);
  }
}

module foot() difference() {
  linear_extrude(height = rod[ 1 ], convexity = 5) difference() {
    minkowski() {
      square(rod[ 1 ] + 2, center = true);
      circle(rod[ 1 ], $fn = 16);
    }
    circle(rod[ 1 ] / 2, $fn = 12);
  }
  translate([0, 0, -rod[ 1 ] / 16]) cylinder(r1 = rod[ 1 ] * 3/4, r2 = rod[ 1 ] / 4, h = rod[ 1 ] / 2, $fn = 12);
  translate([0, 0, rod[ 1 ] / 2 + rod[ 1 ] / 16]) cylinder(r2 = rod[ 1 ] * 3/4, r1 = rod[ 1 ] / 4, h = rod[ 1 ] / 2, $fn = 12);
}

module idler_pulley(double_bearing = true) difference() {
  intersection() {
    linear_extrude(height = idler_pulley_width + 1, convexity = 5) difference() {
      circle(pulley_size / 2 + 2);
      circle(5, $fn = 4);
    }
    union() {
      translate([0, 0, idler_pulley_width / 2 + 1]) scale([1, 1, 1.25]) sphere(pulley_size / 2);
      cylinder(r = pulley_size / 2 + 5, h = 1);
    }
  }
  for(h = [-idler_pulley_width + 4, idler_pulley_width * 2 + 1 - 4]) rotate(180 / 8) translate([0, 0, (double_bearing) ? h:0]) cylinder(r = 10 * da8, h = idler_pulley_width * 2, center = true, $fn = 8);
}

module y_idler() difference() {
  linear_extrude(height = 10, convexity = 5) difference() {
    union() {
      square([rod[ 1 ] * 2, motor[ 2 ] + rod[ 1 ] * 2], center = true);
      for(side = [1, -1]) translate([0, side * (motor[ 2 ] / 2 + rod[ 1 ]), rod[ 1 ] / 2 + bearing[ 1 ] / 2]) rotate(180 / 8) circle(rod[ 1 ] * 13/12, h = yz_motor_distance + motor[ 2 ] + 20, center = true, $fn = 8);
    }
    for(side = [1, -1]) translate([0, side * (motor[ 2 ] / 2 + rod[ 1 ]), rod[ 1 ] / 2 + bearing[ 1 ] / 2]) rotate(180 / 8) circle(rod[ 1 ] * da8, h = yz_motor_distance + motor[ 2 ] + 20, center = true, $fn = 8);

  }
  rotate([90, 0, 90]) {
    for(side = [1, -1]) translate([side * (motor[ 2 ] / 2 - rod[ 1 ] / 2), 5, -3]) {
      cylinder(r = m3 [ 1 ] * da6, h = rod[ 1 ] * 2, center = true, $fn = 6);
      translate([0, 0, rod[ 1 ]]) cylinder(r = m3 [ 2 ] * da6, h = 4, $fn = 6);
    }
    //belt
    %translate([0, 5, -rod[ 1 ] - idler_pulley_width / 2]) linear_extrude(height = 5, center = true, convexity = 5) for(side = [1, 0]) mirror([side, 0, 0]) {
      translate([-(motor[ 2 ] / 2 - rod[ 1 ] / 2), 0, 0]) {
        intersection() {
          difference() {
            circle(pulley_size / 2 + 2);
            circle(pulley_size / 2);
          }
          square(pulley_size);
        }
        rotate(90) difference() {
          translate([2, 0, 0]) square([pulley_size / 2, 40]);
          square([pulley_size / 2, 40]);
        }
        rotate(-90) difference() {
          translate([0, 2, 0]) square([60 - yz_motor_distance / 2 - motor[ 1 ] / 2, pulley_size / 2]);
          square([60, pulley_size / 2]);
        }
      }
      translate([0, -(60 - yz_motor_distance / 2 - motor[ 1 ] / 2), 0]) difference() {
        circle(motor[ 2 ] / 2 - rod[ 1 ] / 2 - pulley_size / 2);
        circle(motor[ 2 ] / 2 - rod[ 1 ] / 2 - pulley_size / 2 - 2);
        translate([-(motor[ 2 ] / 2 - rod[ 1 ] / 2 - pulley_size / 2), 0, 0]) square(motor[ 2 ] - rod[ 1 ] - pulley_size);
      }
    }
  }
}

module leadscrew_coupler() difference() {
  linear_extrude(height = 10 + threaded_rod[ 2 ] / 2 + 1, convexity = 5) difference() {
    circle(motor[ 1 ] / 2 - 1);
    circle(motor[ 4 ] * da6, $fn = 6);
  }
  translate([0, 0, m3 [ 2 ] / 2]) rotate([-90, 0, 90]) {
    cylinder(r = m3 [ 1 ] * da6, h = motor[ 1 ] / 2 + 1);
    %rotate(90) cylinder(r = m3 [ 2 ] / 2, h = 5.5, $fn = 6);
    translate([0, 0, 12]) cylinder(r = m3 [ 1 ] * da6 * 2, h = motor[ 1 ] / 2);
    translate([-m3 [ 2 ] / da6 / 4, -m3 [ 2 ] / 2, 0]) cube([m3 [ 2 ] / da6 / 2, m3 [ 2 ] + 1, 5.7]);
  }
  translate([0, 0, 10]) cylinder(r = threaded_rod[ 2 ] / 2, h = threaded_rod[ 2 ] + 1, $fn = 6);
  //translate([0, 0, -1]) cube(100);
}

module x_carriage() difference() {
  intersection() {
    linear_extrude(height = x_carriage_width, convexity = 5) difference() {
      union() {
        square([bearing[ 1 ] + 8, x_rod_spacing], center = true);
        translate([0, -x_rod_spacing / 2 - bearing[ 1 ] / 2 - 4, 0]) square([bearing[ 1 ] / 2 + 4 + 15, x_rod_spacing / 2 + bearing[ 1 ] / 2 + 4 - 2 - pulley_size / 2]);
        translate([0, -pulley_size / 2, 0]) {
          square([bearing[ 1 ] / 2 + 4 + 15, 8]);
          translate([bearing[ 1 ] / 2 + 4 + 15, 4, 0]) circle(4);
        }
        rotate(180) translate([0, -x_rod_spacing / 2 - bearing[ 1 ] / 2 - 4, 0]) square([bearing[ 1 ] / 2 + 4 + 28, bearing[ 1 ] / 2 + 4 + 3]);
        for(side = [1, -1]) translate([0, side * x_rod_spacing / 2, 0]) circle(bearing[ 1 ] / 2 + 4, $fn = 30);
      }
      translate([bearing[ 1 ] / 2 + 4, 2 - pulley_size / 2, 0]) {
        square([15, 4]);
        translate([0, -3, 0]) square([2, 4]);
        translate([15, 2, 0]) circle(2);
      }
      for(side = [1, -1]) translate([0, side * x_rod_spacing / 2, 0]) {
        circle(bearing[ 1 ] / 2 -1, $fn = 30);
        rotate(90 * side) square([2, bearing[ 1 ] / 2 + 40]);
      }
    }
    difference() {
      rotate([0, -90, 0]) linear_extrude(height = bearing[ 1 ] + 100, convexity = 5, center = true) difference() {
        polygon([
          [
            0,
            (x_rod_spacing / 2 + bearing[ 1 ] / 2 + 4)
          ],[
            0,
            -(x_rod_spacing / 2 + bearing[ 1 ] / 2 + 4)
          ],[
            bearing[ 2 ] + 4,
            -(x_rod_spacing / 2 + bearing[ 1 ] / 2 + 4)
          ],[
            bearing[ 2 ] + 4,
            -(x_rod_spacing / 2 - bearing[ 1 ] / 2 - 4)
          ],[
            x_carriage_width,
            (x_rod_spacing / 2 - bearing[ 1 ] / 2 - 4)
          ],[
            x_carriage_width,
            (x_rod_spacing / 2 + bearing[ 1 ] / 2 + 4)
          ]
        ]);
      }
      translate([bearing[ 1 ] / 2 + 4, -50, bearing[ 2 ] + 4]) cube(100);
    }
  }
  // linear bearings
  translate([0, x_rod_spacing / 2, 0]) rotate([0, 0, 0]) {
    %translate([0, 0, 20]) rotate(180 / 8) cylinder(r = rod[ 1 ] * da8, h = 200, center = true, $fn = 8);
    for(end = [0, 1]) mirror([0, 0, end]) translate([0, 0, end * -x_carriage_width - 1]) cylinder(r = bearing[ 1 ] / 2, h = bearing[ 2 ], $fn = 30);
  }
  translate([0, -x_rod_spacing / 2, 0]) rotate([0, 0, 0]) {
    translate([0, 0, 4]) cylinder(r = bearing[ 1 ] / 2, h = x_carriage_width + 1, center = false, $fn = 30);
    %translate([0, 0,20]) rotate(180 / 8) cylinder(r = rod[ 1 ] * da8, h = 200, center = true, $fn = 8);
  }
  // screw holes
  translate([bearing[ 1 ] / 2 + 4 + 10, 5 - pulley_size / 2, bearing[ 2 ] / 2 + 2]) rotate([90, 0, 0]) {
    cylinder(r = m3 [ 1 ] * da6, h = x_rod_spacing + bearing[ 1 ] + 10, center = true, $fn = 6);
    rotate([180, 0, 0]) cylinder(r = m3 [ 1 ] * da6 * 2, h = x_rod_spacing + bearing[ 1 ] + 10, center = false, $fn = 6);
    translate([0, 0, x_rod_spacing / 2 + bearing[ 1 ] / 2 + 6 - pulley_size / 2]) cylinder(r = m3 [ 2 ] * da6, h = x_rod_spacing + bearing[ 1 ] + 10, center = false, $fn = 6);
  }
  //#for(side = [1, -1]) translate([-bearing[ 1 ] / 2 - 4 - 14, 0, x_carriage_width / 2 + carriage_extruder_offset + side * 25]) rotate([90, 0, 0]) cylinder(r = 4.1, h = x_rod_spacing - 10, center = true, $fn = 6);
  translate([-bearing[ 1 ] / 2 - 4 - 14, 0, x_carriage_width / 2 + carriage_extruder_offset]) rotate([90, 0, 0]) linear_extrude(height = bearing[ 1 ] + x_rod_spacing + 10, center = true, convexity = 5) {
    *translate([-14, 0, 0]) {
      circle(20);
      rotate(45) square(5);
    }
    intersection() {
      translate([18, 0, 0]) rotate(135) square(100);
      translate([-14, 0, 0]) square([56, 100], center = true);
    }
    for(side = [1, -1]) translate([0, side * 25, 0]) circle(m4 [ 1 ] * da6, $fn = 6);
  }
}

module x_end(motor_end = 0) mirror([(motor_end == 0) ? 1 : 0, 0, 0]) difference() {
  union() {
    if(motor_end > 0) translate([-(motor[ 2 ] / 2 + rod[ 1 ] + bearing[ 1 ] + 8) / 2 - motor[ 2 ], 8 + rod[ 1 ], 0]) rotate([90, 0, 0]) {
      // Motor holder
      linear_extrude(height = 7) difference() {
        square([motor[ 2 ] + 3, x_rod_spacing + 8 + rod[ 1 ]]);
        translate([motor[ 2 ] / 2, (x_rod_spacing + 8 + rod[ 1 ]) / 2, 0]) {
          circle(motor[ 1 ] / 2);
          for(x = [1, -1]) for(y = [1, -1]) translate([x * motor[ 1 ] / 2, y * motor[ 1 ] / 2, 0]) circle(m3 [ 1 ] * da6, $fn = 6);
          translate([-(motor[ 2 ] * 1.5 - motor[ 1 ]), (motor_end > 1) ? (motor[ 2 ] / 2 - motor[ 1 ]) : 0, 0]) square([motor[ 2 ], x_rod_spacing + 8 + rod[ 1 ]]);
        }
      }
      // Belt
      %translate([motor[ 2 ] / 2, (x_rod_spacing + 8 + rod[ 1 ]) / 2, rod[ 1 ] / 2 - 2 - bearing[ 1 ] / 2 - 2 - idler_pulley_width / 2]) rotate([180, 0, 0]) linear_extrude(height = 5, convexity = 5) difference() {
        union() {
          circle(pulley_size / 2 + 2);
          translate([0, -pulley_size / 2 - 2, 0]) square([200.5, pulley_size + 4]);
          translate([200.5, 0, 0]) circle(pulley_size / 2 + 2);
        }
        circle(pulley_size / 2);
        translate([0, -pulley_size / 2, 0]) square([200.5, pulley_size]);
        translate([200.5, 0, 0]) circle(pulley_size / 2);
      }

    }
    max_rod_size = rod[ 1 ]>threaded_rod[ 1 ] ? rod[ 1 ] : threaded_rod[ 1 ];
    max_bearing_size = bearing[ 1 ]>threaded_rod[ 2 ] ? bearing[ 1 ] : threaded_rod[ 2 ];

    linear_extrude(height = x_rod_spacing + 8 + rod[ 1 ], convexity = 5) difference() {
      union() {
        translate([motor[ 2 ] / 4 + max_rod_size / 2, 0, 0]) circle(bearing[ 1 ] / 2 + 3, $fn = 30);
        translate([-(motor[ 2 ] / 4 + max_rod_size / 2), 0, 0]) circle(threaded_rod[ 2 ] / 2 + 3, $fn = 30);
        square([motor[ 2 ] / 2 + max_rod_size, max_bearing_size / 2 + 3], center = true);
        translate([-(motor[ 2 ] / 2 + threaded_rod[ 1 ] + threaded_rod[ 2 ] + (max_rod_size - threaded_rod[ 1 ]) + 6) / 2, 0, 0]) square([(motor[ 2 ] / 2 + max_rod_size + max_bearing_size / 2 + 3 + 3) / 2, max_bearing_size / 2 + 4 + max_rod_size / 2]);
        translate([-(motor[ 2 ] / 2 + threaded_rod[ 1 ] + threaded_rod[ 2 ] + (max_rod_size - threaded_rod[ 1 ]) + 6) / 2, 0, 0]) square([motor[ 2 ] / 2 + max_rod_size + max_bearing_size / 2 + 3 + 3, max_bearing_size / 2 + 3 + max_rod_size / 2]);
        translate([-(motor[ 2 ] / 4 + max_rod_size / 2 + threaded_rod[ 2 ] / 2 + 3 - (rod[ 1 ] / 2 + 2)), 0, 0]) square([(motor[ 2 ] / 4 + max_rod_size / 2 + threaded_rod[ 2 ] / 2 + 3 - (rod[ 1 ] / 2 + 2)), max_bearing_size / 2 + rod[ 1 ] + 6]);
        translate([-(motor[ 2 ] / 4 + max_rod_size / 2 + threaded_rod[ 2 ] / 2 + 3 - (rod[ 1 ] / 2 + 2)), max_bearing_size / 2 + rod[ 1 ] / 2 + 4, 0]) circle(rod[ 1 ] / 2 + 2);
        translate([0, max_bearing_size / 2 + rod[ 1 ] + 5.5, 0]) square(10, center = true);
      }
      square([motor[ 2 ] / 2 + max_rod_size, 3], center = true);
      translate([(motor[ 2 ] / 4 + max_rod_size / 2), 0, 0]) circle(bearing[ 1 ] / 2 - .5, $fn = 30);
      translate([-(motor[ 2 ] / 4 + max_rod_size / 2), 0, 0]) circle(threaded_rod[ 2 ] * 6/14, $fn = 6); // threaded rod insert
      translate([4 + max_rod_size / 2, max_bearing_size / 2 + max_rod_size / 2 + 3, 0]) {
        square([motor[ 2 ] / 2 + threaded_rod[ 1 ] + threaded_rod[ 2 ] + 8, max_rod_size / 2], center = true);
        translate([-(motor[ 2 ] / 2 + threaded_rod[ 1 ] + threaded_rod[ 2 ] + 8) / 2, .5, 0]) circle(rod[ 1 ] / 4 + .5, $fn = 12);
      }
    }
  }
  translate([0, 0, (x_rod_spacing + rod[ 1 ] + 8) / 2]) {
    for(end = [0, 1]) mirror([0, 0, end]) translate([motor[ 2 ] / 4 + rod[ 1 ] / 2, 0, -(x_rod_spacing + rod[ 1 ] + 8) / 2 - 1]) cylinder(r = bearing[ 1 ] / 2 - .05, h = bearing[ 2 ], $fn = 30);
    for(side = [1, -1]) render(convexity = 5) translate([0, bearing[ 1 ] / 2 + rod[ 1 ] / 2 + 3, side * x_rod_spacing / 2]) rotate([0, 90, 0]) {
      //cylinder(r = rod[ 1 ] / 2, h = motor[ 2 ] / 2 + rod[ 1 ] + bearing[ 1 ] + 10, center = true, $fn = 30);
      difference() {
        translate([0, 0, (motor_end > -1) ? rod[ 1 ] / 2 + 2 : 0]) intersection() {
          rotate(45) cube([rod[ 1 ] + 2, rod[ 1 ] + 2, motor[ 2 ] / 2 + threaded_rod[ 1 ] + threaded_rod[ 2 ] + 10], center = true);
          cube([rod[ 1 ] * 2, rod[ 1 ] + 2, motor[ 2 ] / 2 + threaded_rod[ 1 ] + threaded_rod[ 2 ] + 10], center = true);
        }
        translate([0, rod[ 1 ], 0]) cube([rod[ 1 ] * 2, rod[ 1 ] * 2, 6], center = true);
        for(end = [1, -1]) translate([0, -rod[ 1 ], end * (motor[ 2 ] / 4 + rod[ 1 ] / 2)]) cube([rod[ 1 ] * 2, rod[ 1 ] * 2, 6], center = true);
      }
      translate([0, 0, rod[ 1 ] / 2 + 2]) intersection() {
        rotate(45) cube([rod[ 1 ], rod[ 1 ], motor[ 2 ] / 2 + threaded_rod[ 1 ] + threaded_rod[ 2 ] + 10], center = true);
        cube([rod[ 1 ] * 2, rod[ 1 ] + 1, motor[ 2 ] / 2 + threaded_rod[ 1 ] + threaded_rod[ 2 ] + 10], center = true);
      }
    }
    // holes for clamping screws
    rotate([90, 0, 0]) {
      cylinder(r = m3 [ 1 ] * da6, h = 100, center = true, $fn = 6);
      translate([0, 0, bearing[ 1 ] / 4 + .5]) cylinder(r = m3 [ 2 ] * da6, h = 100, center = false, $fn = 6);
    }
  }
  translate([-(motor[ 2 ] / 4 + rod[ 1 ] / 2), 0, 5]) rotate(90) cylinder(r = threaded_rod[ 2 ] / 2, h = x_rod_spacing + 8 + rod[ 1 ], $fn = 6);
  translate([(motor[ 2 ] / 4 + rod[ 1 ] / 2), 0, 5]) %rotate(180 / 8) cylinder(r = rod[ 1 ] * da8, h = 200, center = true, $fn = 8);
}

module bed_mount() difference() {
  linear_extrude(height = 10, convexity = 5) difference() {
    union() {
      rotate(180 / 8) circle((rod[ 1 ] + 8) * da8, $fn = 8);
      translate([0, -rod[ 1 ] / 2 - 4, 0]) square([rod[ 1 ] / 2 + 8, max(rod[ 1 ] + 8, rod[ 1 ] / 2 + 4 + bed_mount_height)]);
    }
    rotate(180 / 8) circle(rod[ 1 ] * da8, $fn = 8);
    translate([0, -rod[ 1 ] / (1 + sqrt(2)) / 2, 0]) square([rod[ 1 ] + 10, rod[ 1 ] / (1 + sqrt(2))]);
  }
  translate([rod[ 1 ] / 2 + 1.5, -rod[ 1 ] / 2 - 6, 5]) rotate([-90, 0, 0]) {
    cylinder(r = m3 [ 1 ] * da6, h = max(rod[ 1 ] + 12, rod[ 1 ] / 2 + 7 + bed_mount_height, $fn = 6));
    cylinder(r = m3 [ 2 ] * da6, h = 4, $fn = 6);
  }
}

module y_bearing_retainer() intersection() {
  difference() {
    linear_extrude(height = 10, convexity = 5) difference() {
      union() {
        intersection() {
          translate([-yz_motor_distance / 2 + bearing[ 1 ] / 2, 0, 0]) circle(bearing[ 1 ] / 2 + 4);
          translate([-yz_motor_distance / 2 + bearing[ 1 ] / 2 - bearing[ 1 ] / 2 - 4, -bearing[ 1 ], 0]) square([bearing[ 1 ] + 8, bearing[ 1 ]]);
        }
        translate([-yz_motor_distance / 2 + bearing[ 1 ] / 2 - bearing[ 1 ] / 2 - 4, 0, 0]) square([bearing[ 1 ] + 8, bearing[ 1 ] * sqrt(2) / 4 - 1]);
        translate([0, bearing[ 1 ] * sqrt(2) / 4 - 3, 0]) square([yz_motor_distance + motor[ 2 ] - motor[ 1 ] + 10, 4], center = true);
      }
      translate([-yz_motor_distance / 2 + bearing[ 1 ] / 2, 0, 0]) circle(bearing[ 1 ] / 2);
      translate([-yz_motor_distance / 2 + bearing[ 1 ] / 2 - bearing[ 1 ] / 2, 0, 0]) square(bearing[ 1 ]);
    }
    //screw holes
    for(side = [1, -1]) translate([side * (yz_motor_distance + motor[ 2 ] - motor[ 1 ]) / 2, 0, 5]) rotate(90) rotate([90, 0, 90]) {
      cylinder(r = m3 [ 1 ] * da6, h = bearing[ 1 ], center = true, $fn = 6);
      translate([0, 0, bearing[ 1 ] * sqrt(2) / 4 - 5]) rotate([180, 0, 0]) cylinder(r = m3 [ 1 ], h = bearing[ 1 ], $fn = 30);
    }
  }
  translate([0, 0, 5]) rotate(90) rotate([90, 0, 90]) cylinder(r = (yz_motor_distance + motor[ 2 ] - motor[ 1 ] + 10) / 2, h = bearing[ 1 ] + 10, center = true, $fn = 6);
}

module base_end() difference() {
  linear_extrude(height = motor[ 3 ], convexity = 5) difference() {
    square([yz_motor_distance + motor[ 2 ] - motor[ 1 ] + 10, motor[ 2 ] + rod[ 1 ] * 4], center = true);
    for(end = [1, -1]) {
      for(side = [1, -1]) translate([end * (yz_motor_distance + motor[ 2 ] - motor[ 1 ]) / 2, side * motor[ 1 ] / 2, 0]) circle(m3 [ 1 ] * da6, $fn = 6);
      translate([end * (yz_motor_distance + motor[ 2 ]) / 2, 0, 0]) circle(motor[ 1 ] / 2);
    }
  }
  for(end = [1, -1]) translate([end * (yz_motor_distance + motor[ 2 ]) / 2, 0, 3]) linear_extrude(height = motor[ 3 ], convexity = 5) square(motor[ 2 ], center = true);
  for(side = [1, -1]) translate([0, side * (motor[ 2 ] / 2 + rod[ 1 ]), rod[ 1 ] / 2 + bearing[ 1 ] / 2]) rotate([90, 180 / 8, 90]) {
    cylinder(r = rod[ 1 ] * da8, h = yz_motor_distance + motor[ 2 ] + 20, center = true, $fn = 8);
    %translate([0, 0, -70]) cylinder(r = rod[ 1 ] * da8, h = 200, center = true, $fn = 8);
  }
  translate([0, 0, motor[ 3 ]]) scale([1, 1, .5]) rotate([90, 0, 90]) cylinder(r = motor[ 2 ] / 2, h = yz_motor_distance + 20, center = true);
  translate([yz_motor_distance / 2 - rod[ 1 ], 0, 0]) {
    translate([0, 0, -3]) linear_extrude(height = motor[ 3 ] - motor[ 2 ] / 4, convexity = 5) {
      rotate(180 / 8) circle(rod[ 1 ] * da8, $fn = 8);
      translate([0, -rod[ 1 ] / 4, 0]) square([rod[ 1 ] * .6, rod[ 1 ] / 2]);
    }
    // z axis clamping
    for(h = [8, motor[ 3 ] - motor[ 2 ] / 4 - 8]) translate([0, 0, h]) rotate([90, 0, 90]) {
      cylinder(r = m3 [ 1 ] * da6, h = yz_motor_distance + motor[ 2 ], center = true, $fn = 6);
      translate([0, 0, -rod[ 1 ] / 2 - 3]) cylinder(r = m3 [ 2 ]* da6, h = yz_motor_distance + motor[ 2 ], $fn = 6);
      translate([0, 0, 0]) cylinder(r = m3 [ 2 ] / 2 + 0.5, h = yz_motor_distance + motor[ 2 ], $fn = 6);
      translate([0, 0, -rod[ 1 ] / 2 - 8]) rotate([0, 180, 0]) cylinder(r = m3 [ 1 ] * da6 * 2, h = yz_motor_distance + motor[ 2 ], $fn = 6);
    }
  }
  translate([-yz_motor_distance / 2 + bearing[ 1 ] / 2, 0, -bearing[ 1 ] * sqrt(2) / 4]) rotate([90, -45, 0]) {
    %cylinder(r = rod[ 1 ] * da8, h = 100, center = true, $fn = 8);
    for(side = [0, 1]) mirror([0, 0, side]) translate([0, 0, rod[ 1 ] / 2 + 2]) {
      cylinder(r = bearing[ 1 ] / 2, h = bearing[ 2 ], center = false, $fn = 80);
      cube([bearing[ 1 ] / 2, bearing[ 1 ] / 2, bearing[ 2 ]]);
    }
  }
  translate([0, 0, motor[ 3 ] - rod[ 1 ] * 1.5]) rotate([90, 180 / 8, 0]) cylinder(r = rod[ 1 ] * da8, h = motor[ 2 ] + rod[ 1 ] * 5, $fn = 8, center = true);
  %translate([0, 0, motor[ 3 ] - rod[ 1 ] * 1.5]) rotate([90, 180 / 8, 0]) cylinder(r = rod[ 1 ] * da8, h = 100, $fn = 8, center = true);
}