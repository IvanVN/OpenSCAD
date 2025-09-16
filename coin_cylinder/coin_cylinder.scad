coin_diameter=40;//[10:0.1:60]
coin_height=6;//[2:0.1:15]
n_coins=5;//[1:1:25]
use_total_height=false;
total_height=0;//[0:0.1:200]
v_padding=0.5;//[0:0.1:3]
h_padding=0.5;//[0:0.1:1]
thread_height=5;//[2:1:10]
label="COINS";
text_size=3.5;//[2:0.1:10]
label_on_side=true;
label_on_cap=true;

/* [Hidden] */
additional_cap_height=0;//[0:50]
thread_width=1.5;
added_width=2;
extra_width=(thread_width+added_width);
base_height=2;


in_diameter=coin_diameter+h_padding;
in_height= use_total_height ? total_height+v_padding : (coin_height*n_coins)+v_padding;

ir=in_diameter/2;

$fn = $preview ? 32 : 128;

// Container
difference(){
    union(){
        //threads
        translate([0,0,base_height+in_height-thread_height])
            linear_extrude(height=thread_height,twist=-180*thread_height)
            translate([0.5,0])
            circle(r=ir+thread_width)
        ;
        //body
        cylinder(r=ir+extra_width,h=in_height-thread_height+base_height);
    }
    //inner cavity
    translate([0,0,2])
    cylinder(r=ir,h=in_height+0.1);
    //bottom chamfer
    rotate_extrude()
    translate([ir+extra_width,0])
    circle(r=1.6,$fn=4);
    //top chamfer
    translate([0,0,in_height+2])
    rotate_extrude()
    translate([ir+extra_width+0.5,0])
    circle(r=extra_width,$fn=4);
    // Text
    if (label_on_side) {
        rot=atan2(text_size,(ir+extra_width));
        translate([0,0,(in_height+extra_width)/2])
        for (a=[0:3]){
            rotate([0,0,a*90])
            for (i=[0:len(label)-1])
            rotate([0,0,rot*i])
            translate([0,-ir+-3.1,0.6])
            rotate([90,0,0])
            linear_extrude(height=1)
            text(label[i],size=text_size, halign="center", valign="bottom",font ="Liberation Sans:style=Bold");
        }
    }
}

// Cap
translate([in_diameter+10,0,0])
difference(){
    // body
    cylinder(r=ir+extra_width,h=thread_height+2+additional_cap_height);
    // thread
    translate([0,0,2+additional_cap_height])
    linear_extrude(height=thread_height+0.1,twist=-180*thread_height+0.1)
    translate([0.5,0])
    circle(r=ir+thread_width+0.3);
    // chamfer
    rotate_extrude()
    translate([ir+extra_width,0])
    circle(r=1.6,$fn=4);
    // inner chamfer
    translate([0,0,thread_height+additional_cap_height])
    cylinder(r1=ir+1.5,r2=ir+2.5,h=2.1);
    
    translate([0,0,2])
    cylinder(r=ir,h=additional_cap_height+0.1);
    
    if (label_on_cap) {
        mirror([0,180,0])
        translate([0,-(text_size/2),0])
        linear_extrude(height=1) text(label,size=text_size, halign="center", valign="bottom",font ="Liberation Sans:style=Bold");
    }
}

