include <wallace.scad>;

!for(side = [-1,1]) translate([0, side * motor[ 1 ] / 2, 0]) leadscrew_coupler();