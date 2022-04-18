/* gantry-installation-hook.scad
Author: andimoto@posteo.de
----------------------------
for holding gantry ov voron 2.4 at installation into frame.

*/


module hanger(){
  difference() {
    cube([120,30,20]);

    translate([6,5,-0.1]) cube([109,20,21]);
    translate([6,5,-.10]) cube([105,30,21]);
    translate([0,10,-0.1]) cube([6,30,21]);
  }
  translate([0,9,0]) cube([7,1,20]);
}



difference() {
  hanger();
  translate([0,-5.65/2,0]) rotate([0,0,45]) cube([4,4,20]);
  translate([120,-5.65/2,0]) rotate([0,0,45]) cube([4,4,20]);
  translate([120,30-5.65/2,0]) rotate([0,0,45]) cube([4,4,20]);
  translate([0,10-sqrt(2.5^2*2)/2,0]) rotate([0,0,45]) cube([2.5,2.5,20]);

  /* holes for extrusions */
  translate([115,15,10]) rotate([0,90,0]) cylinder(r=3.2/2,h=10,$fn=50);

  /* cutout */
  translate([16,0,10]) cube([89,5,10]);
  translate([6,0,20]) rotate([0,45,0]) cube([sqrt(10^2*2),5,sqrt(10^2*2)]);
  translate([95,0,20]) rotate([0,45,0]) cube([sqrt(10^2*2),5,sqrt(10^2*2)]);
}
