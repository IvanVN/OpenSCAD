// Tray width
tray_width = 100;
// Tray lenght
tray_lenght = 200;
// Tray depth
tray_depth = 20;
// Columns
n_columns = 3;
// Rows
n_rows = 2;
// Wall width
wall_width = 1;
dwall = wall_width*2;
// Columns lengths
columns = [];
// Rows widths
rows = [];

module slot(width, lenght, depth, wall) {
    difference() {
        cube([width, lenght, depth]);
        translate([wall, wall, wall]) cube([width-wall*2, lenght-wall*2, depth]);
    }
    
}

function add(v) = [for(p=v) 1]*v;
function add_up_to(v, range) = add([for(i=[0:range]) v[i]]);


// Check columns
if (len(columns) != 0) {
    if (len(columns) != n_columns) {
        echo ("Column lenghts not especified for every column.");
    }
    if (add(columns) != 100) {
        echo ("Column lenghts do not add 100.");
    }
}
// Check rows
if (len(rows) != 0) {
    if (len(rows) != n_rows) {
        echo ("Row widths not especified for every row.");
    }
    if (add(rows) != 100) {
        echo ("Ros widths do not add 100.");
    }
}

slot(tray_width, tray_lenght, tray_depth, wall_width);
// Draw rows
if (len(rows) == 0) {
    inner_width = (tray_width - (n_rows + 1)*wall_width) / n_rows;
    for (r = [1:n_rows-1]) {
        current_row_offset = r*(wall_width+inner_width);
        translate([current_row_offset,0,0]) cube([wall_width,tray_lenght,tray_depth]);
    }
}
else{
    for (r = [0:n_rows-2]) {
        current_row_offset = (add_up_to(rows, r)/100 * tray_width)-wall_width/2;
        translate([current_row_offset,0,0]) cube([wall_width,tray_lenght,tray_depth]);
    }
}
// Draw columns
if (len(columns) == 0){
    inner_lenght = (tray_lenght - (n_columns + 1)*wall_width) / n_columns;
    for (c = [1:n_columns-1]){
        current_column_offset = c*(wall_width+inner_lenght);
        translate([0,current_column_offset,0]) cube([tray_width,wall_width,tray_depth]);
    }
}
else {
    for (c = [0:n_columns-2]){
        current_column_offset = (add_up_to(columns, c)/100 * tray_lenght)-wall_width/2;
        translate([0,current_column_offset,0]) cube([tray_width,wall_width,tray_depth]);
    }
}
