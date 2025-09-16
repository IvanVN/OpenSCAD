// Deck width
deck_width = 60;
// Deck height
deck_height = 92;
// Deck depth
deck_depth = 37;
// Number of decks
n_decks = 3;
// Wall width
wall = 1;
dwall = wall * 2;
// Padding between deck and walls
padding = 0.5;
dpadding = padding * 2;
// Wall overheghht over deck
wall_overheight = 2;

box_width = deck_depth+dpadding+dwall;
box_lenght = deck_height+dpadding+dwall;
box_depth = deck_width+dwall+wall_overheight;

fillet = 4;

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

module side() {
    rotate([90,0,90]) rounded_wall(box_lenght/4,box_depth,fillet,wall);
    translate([box_width-wall, 0, 0]) rotate([90,0,90]) rounded_wall(box_lenght/4,box_depth,fillet,wall);
    cube([box_width, wall, box_depth]);
}

module deck_walls() {
      side();
      translate([box_width,box_lenght,0]) rotate([0,0,180]) side();
}

module deck_base() {
    cube([box_width, box_lenght, wall]);
}

module deck_holder() {
    difference() {
        union() {
            deck_walls();
            deck_base();
        }
        translate([0,box_lenght/4+fillet+wall,-wall/2]) rotate([0,0,90]) tab(radius=box_width/8, lenght=box_lenght/2, depth=dwall);
        translate([box_width,box_lenght/4+fillet+wall,-wall/2]) rotate([0,0,90]) tab(radius=box_width/8, lenght=box_lenght/2, depth=dwall);
//        translate([box_width/4+box_width/8,box_lenght,-wall/2]) tab(radius=box_width/8, lenght=box_width/2, depth=dwall);
//        translate([box_width/4+box_width/8,0,-wall/2]) tab(radius=box_width/8, lenght=box_width/2, depth=dwall);        
        translate([box_width/2,box_width/2-box_width/8,-wall/2]) rotate([0,0,90]) tab(radius=box_width/8, lenght=box_lenght-box_width/2, depth=dwall);
    }
}

module separator() {
    difference() {
        union() {
            cube([deck_width-wall_overheight, deck_height, wall]);
            translate([0,deck_height/4,0]) rotate([0,0,90]) tab(radius=wall_overheight, lenght=deck_height/2, depth=wall);
        }
        translate([deck_width/2,deck_height/3, -wall/2]) rotate([0,0,90]) tab(radius=deck_width/4, lenght=2*deck_height/3, depth=dwall);
    }
}

for (i = [0:n_decks-1]) {
    translate([i*(box_width-wall),0,0]) deck_holder();
    translate([wall+i*box_depth, -(box_lenght+10), 0]) separator();
}

