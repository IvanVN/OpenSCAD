inner_dimensions = true;
box_width = 50.0;
box_height = 50.0;
box_length = 200.0;
wall = 1.0;
units = 1;

module unit(width, lenght, height, wall, inside){
    if (inside == true) {
        difference () {
            cube([width+wall*2, lenght+wall*2, height+wall]);
            translate([wall, wall, wall]) cube([width, lenght, height]);
        }
    }
    else {
        difference() {
            cube([width, lenght, height]);
            translate([wall, wall, wall]) cube([width-wall*2, lenght-wall*2, height-wall]);
        }
    }
}

for (u = [0:units-1]) {
    if (inner_dimensions == true) {
        translate([(wall+box_width) * u, 0, 0]) unit(box_width, box_length, box_height, wall, inner_dimensions);
    }
    else {
        translate([(box_width-wall) * u, 0, 0]) unit(box_width, box_length, box_height, wall, inner_dimensions);
    }  
}
