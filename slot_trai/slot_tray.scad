// Number of rows
rows=4;
// Number of columns
columns=4;
// Separation between slots
slot_separation=2.0;

// Size of the slots
size=50.0;
// Inner padding for the slots
size_padding = 1.0;
// Depth of the slots
depth=7.0;

// Width of the walls
wall=1.5;

print_box = true;
print_lid = false;

/* [Hidden] */
inner_size = size+size_padding;
total_size = inner_size + slot_separation;
external_x_size = inner_size*rows+slot_separation*rows;
external_y_size = inner_size*columns+slot_separation*columns;
tolerance = 0.1;

module pieSlice(a, r, h){
  // a:angle, r:radius, h:height
  rotate_extrude(angle=a) square([r,h]);
}

module slot() {
    union() {
        difference() {
            cube([inner_size+slot_separation, inner_size+slot_separation, depth+wall]);
            translate([slot_separation/2,slot_separation/2,wall])cube([inner_size, inner_size, depth]);
            translate([(slot_separation/2)+inner_size/4,0,wall])cube([inner_size/2,inner_size+slot_separation, depth]);
        }
        //linear_extrude(wall)circle(depth);
        translate([(slot_separation/2)+inner_size/4,slot_separation/2,wall]) rotate([90,0,0]) pieSlice(90, depth, slot_separation/2);
        translate([(slot_separation/2)+inner_size/4,slot_separation+inner_size,wall]) rotate([90,0,0]) pieSlice(90, depth, slot_separation/2);
        translate([(inner_size+slot_separation)-slot_separation/2-inner_size/4,0,wall])rotate([90,0,180]) pieSlice(90, depth, slot_separation/2);
        translate([(inner_size+slot_separation)-slot_separation/2-inner_size/4,slot_separation/2+inner_size,wall])rotate([90,0,180]) pieSlice(90, depth, slot_separation/2);
    }
}

module outer_wall(lenght) {
    linear_extrude(lenght) {
        polygon(points = [[0,0],[wall,0],[wall,depth+size_padding],[0,depth+size_padding+wall]]);
    }   
}

module row () {
    for (i = [0:columns-1]) {
        translate([total_size*i,0,tolerance]) slot();
    }    
}

module base() {
polyhedron(points=[[tolerance,tolerance,0],
                   [external_x_size-tolerance,tolerance,0],
                   [external_x_size-tolerance,external_y_size-tolerance,0],
                   [tolerance,external_y_size-tolerance,0],
                   [-wall+tolerance,-wall+tolerance,wall],
                   [external_x_size+wall-tolerance,-wall+tolerance,wall],
                   [external_x_size+wall-tolerance,external_y_size+wall-tolerance,wall],
                   [-wall+tolerance,external_y_size+wall-tolerance,wall]],
           faces=[[0,1,2,3],
                  [7,6,5,4],
                  [5,6,2,1],
                  [6,7,3,2],
                  [7,4,0,3],
                  [4,5,1,0]]);
}

if (print_box == true) {

for (i = [0:rows-1]) {  
    translate([0,total_size*i,0])row();
}

// Base
base();

// External walls
translate([-wall,-wall,wall]) rotate([90,0,90]) outer_wall(external_x_size+wall*2);
translate([external_x_size+wall,external_y_size+wall,wall]) rotate([90,0,-90]) outer_wall(external_x_size+wall*2);
translate([-wall,external_y_size+wall,wall]) rotate([90,0,0]) outer_wall(external_x_size+wall*2);
translate([external_x_size+wall,-wall,wall]) rotate([90,0,180]) outer_wall(external_x_size+wall*2);

}

if (print_lid == true) {
    translate ([external_x_size+wall*2+15,0,0])
    union() {
        base();
        translate([-wall,-wall,wall]) cube([external_x_size+wall*2, external_y_size+wall*2, wall/2]);
    }
}
