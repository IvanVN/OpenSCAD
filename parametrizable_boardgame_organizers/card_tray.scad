// Use tray size instead of deck size
use_tray_size = false;
// Deck width
deck_width = 60;
// Deck height
deck_height = 92;
// Deck depth
deck_depth = 30;
// Number of decks
n_decks = 1;
// Wall width
wall = 1;
dwall = wall * 2;
// Padding between deck and walls
padding = 0.5;
dpadding = padding * 2;
// Wall overheghht over deck
wall_overheight = 2;

box_width = use_tray_size ? deck_width / n_decks + wall : deck_width+dpadding+dwall;
box_height = use_tray_size ? deck_height : deck_height+dpadding+dwall;
box_depth = use_tray_size ? deck_depth : deck_depth+dwall+wall_overheight;

fillet = 5;

module tab(radius=10, lenght=40, depth=2) {
    linear_extrude(depth) {
        hull() {
            circle(radius);
            translate([lenght-radius*2,0,0]) circle(radius);
        }
    }
}

module rounded_wall (height=10, width=10, radius=2, depth=1) {
    $fn=360; 
    linear_extrude(depth){
        union() {
            square([height-radius, width]);
            square([height, width-radius]);
            translate([height-radius, width-radius]) circle(radius);
        }
    }
}

module corner() {
    translate([0,wall,0]) rotate([90,0,0]) rounded_wall(box_width/4,box_depth,fillet,wall);
    rotate([90,0,90]) rounded_wall(box_width/4,box_depth,fillet,wall);
}

module deck_walls() {
    corner();
    translate([box_width,0,0]) rotate([0,0,90]) corner();
    translate([box_width,box_height,0]) rotate([0,0,180]) corner();
    translate([0,box_height,0]) rotate([0,0,-90]) corner();
}

module deck_base() {
    cube([box_width, box_height, wall]);
}

module deck_holder() {
    difference() {
        union() {
            deck_walls();
            deck_base();
        }
        translate([0,box_width/2-box_width/8,-wall/2]) rotate([0,0,90]) tab(radius=box_width/8, lenght=box_height-box_width/2, depth=dwall);
        translate([box_width,box_width/2-box_width/8,-wall/2]) rotate([0,0,90]) tab(radius=box_width/8, lenght=box_height-box_width/2, depth=dwall);
        translate([box_width/4+box_width/8,box_height,-wall/2]) tab(radius=box_width/8, lenght=box_width/2, depth=dwall);
        translate([box_width/4+box_width/8,0,-wall/2]) tab(radius=box_width/8, lenght=box_width/2, depth=dwall);        
        translate([box_width/2,box_width/2-box_width/8,-wall/2]) rotate([0,0,90]) tab(radius=box_width/8, lenght=box_height-box_width/2, depth=dwall);
    }
}

for (i = [0:n_decks-1]) {
    translate([i*(box_width-wall),0,0]) deck_holder();
}

