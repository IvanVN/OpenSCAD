inner_dimensions = true;
box_width = 50.0;
box_height = 50.0;
box_length = 200.0;
wall = 1.5;
units = 1;
anti_slip_lines = true;
depth = 0.2;
separation = 1;
print_box = true;
print_lid = true;

tolerance = 0.2;

// One compartment
module unit(width, lenght, height, wall, inside){
    if (inside == true) {
        difference () {
            // Outer dimensions
            cube([width+wall*2, lenght+wall*2, height+wall]);
            // Inner dimensions
            translate([wall, wall, wall]) cube([width, lenght, height]);
            // Draw anti-slip lines
            if (anti_slip_lines == true) {
                slip_lines(depth, separation, box_width, box_length);
            }
        }
    }
    else {
        difference() {
            // Outer dimensions
            cube([width, lenght, height]);
            // Inner dimensions
            translate([wall, wall, wall]) cube([width-wall*2, lenght-wall*2, height-wall]);
            // Draw anti-slip lines
            if (anti_slip_lines == true) {
                slip_lines(depth, separation, box_width-wall*2, box_length-wall*2);
            }
        }
    }
}

// Anti-slip lines
module slip_lines(depth, separation, width, length)
{
    for (i = [1:1+separation:length-wall]) {
        translate([wall, i, wall-depth]) cube([width, 1, depth]);
    }
}

// Generate the full box
if (print_box == true) {
    difference (){
        // Draw as the wanted number of containers
        for (u = [0:units-1]) {
            if (inner_dimensions == true) {
                translate([(wall+box_width) * u, 0, 0]) unit(box_width, box_length, box_height, wall, inner_dimensions);
            }
            else {
                translate([(box_width-wall) * u, 0, 0]) unit(box_width, box_length, box_height, wall, inner_dimensions);
            }  
        }
        // Make separators smaller
        for (u = [1:units-1]) {
            translate([(wall+box_width)*u, wall, wall]) rotate([0,-90,0]) linear_extrude(wall*2, center=true) polygon([[box_height,0],[box_height/2,10],[box_height/2,box_length-10],[box_height,box_length]]);
        }
    }
}


if (print_lid == true) {
    translate([box_width*units+wall*units+wall+10, 0, 0]) {
        if (inner_dimensions == true) {
            lid_width = box_width*units+wall*4+wall*(units-1)+tolerance;
            lid_length = box_length+wall*4+tolerance;
            difference() {
                cube([lid_width, lid_length, 10]);
                translate([wall,wall,wall]) cube([lid_width-wall*2-tolerance, lid_length-wall*2-tolerance, 10-wall]);
            }
        }
    }
}

//translate([wall+box_width, wall, 0]) rotate([0,-90,0]) linear_extrude(5, center=true) polygon([[box_height,0],[box_height/2,10],[box_height/2,box_length-10],[box_height,box_length]]);
//slip_lines(0.5, 2, box_width, box_length);
