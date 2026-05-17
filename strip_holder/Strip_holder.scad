width = 30;
height = 217 + 13;
depth = 5;
wall = 1;
padding = 0.5;
top_window_size = 60;
lateral_window_size = 10;
label = "30";
text_size = 6.0;

difference () {
cube([width+wall*2+padding*2, height, depth+wall*2]);
translate([wall,wall,wall])cube([width+padding*2, height-wall, depth]);
translate([0,height-top_window_size,wall])cube([width+wall*2+padding*2,top_window_size,depth+wall]);
translate([wall*2,wall,depth-wall]) cube([lateral_window_size, height, depth]);
translate([wall*2, height-text_size/2, wall/2]) linear_extrude(1) text(label,size=text_size, halign="left", valign="top",font ="Liberation Sans:style=Bold");
}