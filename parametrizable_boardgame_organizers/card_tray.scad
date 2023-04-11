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

box_width = deck_width+dpadding+dwall;
box_height = deck_height+dpadding+dwall;
box_depth = deck_depth+dwall+wall_overheight;

long_tab_width = box_width/4;
long_tab_height = box_height/2;
long_tab_depth = box_depth*2;

short_tab_width = box_width/2;
short_tab_height = box_height/4;
short_tab_depth = box_depth*2;

tab_radius = box_width/4;

fillet = 5;

module tab(radius=10, lenght=40) {
    hull() {
        circle(10);
        translate([lenght-radius*2,0,0]) circle(10);
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
        cube([box_width, box_height, box_depth]);
        translate([wall,wall,wall]) cube([deck_width+dpadding, deck_height+dpadding, box_depth]);
//        translate([-long_tab_width/2,long_tab_height/2,-dwall]) cube([long_tab_width,long_tab_height,long_tab_depth]);
//        translate([box_width-long_tab_width/2,long_tab_height/2,-dwall]) cube([long_tab_width,long_tab_height,long_tab_depth]);
//        translate([short_tab_width/2,box_height-short_tab_height/2,-dwall]) cube([short_tab_width,short_tab_height,short_tab_depth]);
//        translate([short_tab_width/2,-short_tab_height/2,-dwall]) cube([short_tab_width,short_tab_height,short_tab_depth]);
        translate([-long_tab_width/2,long_tab_height/2,-dwall]) cube([long_tab_width,long_tab_height,long_tab_depth]);
        translate([box_width-long_tab_width/2,long_tab_height/2,-dwall]) cube([long_tab_width,long_tab_height,long_tab_depth]);
        translate([short_tab_width/2,box_height-short_tab_height/2,-dwall]) cube([short_tab_width,short_tab_height,short_tab_depth]);
        translate([short_tab_width/2,-short_tab_height/2,-dwall]) cube([short_tab_width,short_tab_height,short_tab_depth]);        
    }
}

//for (i = [0:n_decks-1]) {
//    translate([i*(box_width-wall),0,0]) deck_holder();
//}

deck_walls();
deck_base();