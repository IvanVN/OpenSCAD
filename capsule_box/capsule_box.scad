// Diameter of the capsule
diameter=32.0; //[10.0:0.1:50.0]
// Depth of the capsule
depth=3.05;
// Number of coins per row
coins_row=5;
// Width of the box walls
wall=1.2;

// width of the capsule spacer
separator_width=0.5;
// padding of the capsule diameter (space between the capsule and the walls)
di_padding=1.0;
// padding of the capsule depth (space between the capsule and the separators)
de_padding=0.5;
// tolerance for the box lid
fit_tolerance=0.1;

module separator(){
    difference() {
        cube([diameter+di_padding, diameter/2, separator_width]);
        translate([(diameter+di_padding)/2,diameter/2,0]) cylinder(h=separator_width,d=diameter-di_padding);
    };
}

////////
//Holder
////////

// Base
difference() {
cube([diameter+di_padding+2*wall,(depth+de_padding)*coins_row+separator_width*(coins_row-1)+wall*2,(2*wall+diameter+di_padding)/2]);
translate([wall,wall,wall]) cube([diameter+di_padding,(depth+de_padding)*coins_row+separator_width*(coins_row-1),wall+diameter+di_padding]);
}

// Top ring
difference() {
translate([wall/2,wall/2,(2*wall+diameter+di_padding)/2]) cube([diameter+di_padding+wall-fit_tolerance,(depth+de_padding)*coins_row+separator_width*(coins_row-1)+wall-fit_tolerance,2]);
translate([wall,wall,wall]) cube([diameter+di_padding,(depth+de_padding)*coins_row+separator_width*(coins_row-1),wall+diameter+di_padding]);
}

// Separators
for (i = [1:1:coins_row-1])
{
    translate([wall,wall+(depth+de_padding+separator_width)*i,wall]) rotate([90,0,0]) separator();    
}

////////
// Lid
////////
translate([diameter+di_padding+2*wall+10,0,0]) {
    difference() {
        cube([diameter+di_padding+2*wall,(depth+de_padding)*coins_row+separator_width*(coins_row-1)+wall*2,((2*wall+diameter+di_padding)/2)+2]);
        translate([wall,wall,wall]) cube([diameter+di_padding,(depth+de_padding)*coins_row+separator_width*(coins_row-1),wall+diameter+di_padding]);
        translate([wall/2,wall/2,((2*wall+diameter+di_padding)/2)]) cube([diameter+di_padding+wall+fit_tolerance,(depth+de_padding)*coins_row+separator_width*(coins_row-1)+wall+fit_tolerance,wall+diameter+di_padding]);
    }
}

