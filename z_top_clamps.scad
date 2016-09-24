include <wallace.scad>;

!for(side = [0, 1]) mirror([side, 0, 0]) translate([-rod[ 1 ] * 2.5, 0, 0]) z_top_clamp();