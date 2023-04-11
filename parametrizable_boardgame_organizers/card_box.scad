// Card sizes
// Mitos

//card_width = 60;
//card_height = 92;
//card_depth = 30;

// Daño
// Width of the card deck
card_width = 44;
// Height of the card deck
card_height = 66;
// Depth of the card deck
card_depth = 4.5;
// Text of the label
label = "";
// Add label to the bottom
bottom_label = true;
// Add label to the sides
side_label = true;
// Add label to the top
top_label = true;
// Walls and padding
// Padding between cards and walls
card_padding = 0.5;
d_card_padding = card_padding * 2;
// Padding between walls
wall_padding = 0.5;
d_wall_padding = wall_padding * 2;
// Width of the walls
wall = 2;
dwall = wall * 2;
// Radius of the hinges
hinge_r = 2;
hinge_slot_r = hinge_r+hinge_r*0.25; 
// Sides resolution
sides = 360;
text_margin = 2;
card_box_shorten = 4;

// Sizes of card box and tray
box_width = card_width+dwall+d_card_padding; 
box_height = card_height+wall+d_card_padding;
box_depth = card_depth+dwall+d_card_padding;
tray_width = box_width+dwall+wall_padding;
//tray_height = box_depth+card_height+dwall+dpadding;
tray_height = box_depth+box_height+wall_padding;
tray_depth = box_depth+wall+wall_padding;
box_extension = box_depth-wall;

module tab(tab_heigh=10, parent_width=40){
    linear_extrude (height=tab_heigh) {
        union() {
            square(parent_width/2,center=true);
            translate([0,-parent_width/4,0]) {
                circle(parent_width/4);
            }
        }
    }
}

module text_label(text_heigth=10, text_width=10){
    text_lenght = len(label);
    text_size = (text_width-text_margin*2) / text_lenght;
    echo(text_lenght, text_width, text_size, text_heigth);
    if (text_size < text_heigth-text_margin*2){
        linear_extrude(1) text(label, size=text_size, valign="center", halign="center");
    }    
    else {
        linear_extrude(1) text(label, size=text_heigth-text_margin*2, valign="center", halign="center");
    } 
}

module tray(){
    difference() {
        difference() {
            cube([tray_width, tray_height, tray_depth]);
            translate([wall,wall,wall]){
                cube([tray_width-dwall, tray_height-dwall, tray_depth]);
            }
        }
        translate([-wall,tray_depth/2,tray_depth/2]){
            rotate([0,90,0]){
                cylinder(box_width+dwall*2,hinge_slot_r,hinge_slot_r,$fn=sides);
            }
        }
    }
}

module tray_with_holes(){
    difference() {
        difference() {
            // Tray
            tray();

            // Tray top hole
            translate([tray_width/2,tray_height,-wall]){
                tab(tray_height, tray_width);
            }
        }

        // Tray botton hole
        translate([wall,-wall_padding,-wall]){
            cube([tray_width-dwall, tray_depth+dwall, tray_depth*2]);
        }
    }
}

module card_box(){
    difference() {
        union() {
            difference() {
                cube([box_width, box_height-card_box_shorten, box_depth]);
                translate([wall,wall,wall]) {
                    cube([box_width-dwall, box_height, box_depth-dwall]);
                }
            }
            translate([0,-(box_extension),0]){
                cube([box_width, box_extension, box_depth]);
                // Left hinge
                translate([0, tray_depth / 2, box_depth - tray_depth / 2]){
                    rotate([0,-90,0]){
                        cylinder(wall+card_padding/2,hinge_r,hinge_r,false,$fn=sides);
                    }
                }
                // Right hinge
                translate([box_width, tray_depth / 2, box_depth - tray_depth / 2]){
                    rotate([0,90,0]){
                        cylinder(wall+card_padding/2,hinge_r,hinge_r,false,$fn=sides);
                    }
                }    
            }
        }
        translate([box_width/2,box_height,-wall]){
            tab(dwall*2, box_width);
        }
        if (label != "" && bottom_label){
            translate([box_width/2,-box_extension+0.5,box_depth/2]){
                rotate([90,0,0]){
                    text_label(box_depth,box_width);
                }
            }    
        }
        if (label != "" && top_label){
            translate([box_width/2,box_height/2,box_depth-0.5]){
                rotate([0,0,-90]){
                    text_label(box_width,box_height);
                }
            }    
        }
        if (label != "" && top_label){
            translate([box_width/2,box_height/2-box_height/4,0.5]){
                rotate([0,0,90]){
                    rotate([0,180,0])text_label(box_width,box_height-box_height/4);
                }
            }    
        }
    }
}


tray_with_holes();
//translate([wall+wall_padding/2,box_extension,wall+wall_padding]){
//// Card box
//    card_box();
//}
translate([wall+wall_padding/2,box_depth,box_extension]){
// Card box
    rotate([90,0,0])card_box();
}

//card_box();

//        if (label != "" && top_label){
//            translate([box_width/2,box_height/2-box_height/4,-0.5]){
//                rotate([0,0,90]){
//                    rotate([0,180,0])text_label(box_width,box_height-box_height/4);
//                }
//            }    
//        }
