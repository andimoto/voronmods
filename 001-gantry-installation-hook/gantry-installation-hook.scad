/* gantry-installation-hook.scad
Author: andimoto@posteo.de
----------------------------
for holding gantry ov voron 2.4 at installation into frame.

*/
$fn=70;

extra = 0.01;

filamentDia=1.75;


module hanger(){
  difference() {
    cube([120,30,20]);

    translate([6,5,-0.1]) cube([109,20,21]);
    translate([6,5,-.10]) cube([105,30,21]);
    translate([-extra,10,-0.1]) cube([6+extra*2,30,21]);
  }
  translate([0,9,0]) cube([7,1,20]);
}


module voronGantryHook()
{
  difference() {
    hanger();
    /* champfers */
    translate([0,-5.65/2,-extra]) rotate([0,0,45]) cube([4,4,20+extra*2]);
    translate([120,-5.65/2,-extra]) rotate([0,0,45]) cube([4,4,20+extra*2]);
    translate([120,30-5.65/2,-extra]) rotate([0,0,45]) cube([4,4,20+extra*2]);
    translate([0,10-sqrt(2.5^2*2)/2,-extra]) rotate([0,0,45]) cube([2.5,2.5,20+extra*2]);

    /* holes for extrusions */
    translate([115,15,10]) rotate([0,90,0]) cylinder(r=3.2/2,h=10,$fn=50);

    /* cutout */
    translate([16,-extra,10]) cube([89,5+extra*2,10+extra]);
    translate([6,-extra,20]) rotate([0,45,0]) cube([sqrt(10^2*2),5+extra*2,sqrt(10^2*2)]);
    translate([95,-extra,20]) rotate([0,45,0]) cube([sqrt(10^2*2),5+extra*2,sqrt(10^2*2)]);
  }
}

module screw(dia=3,lenght=25)
{
  cylinder(r=dia/2,h=lenght);
  cylinder(r=6.2/2,h=3);
}

module nut()
{
cylinder(r=6/2 + 0.2, h=3, $fn=6);
}
/* nut(); */

module hookPart1()
{
  difference()
  {
    union()
    {
      difference()
      {
        voronGantryHook();
        translate([50,-extra,-extra]) cube([70+extra,30+extra*2,20+extra*2]);
      }
      hull()
      {
        translate([40,5,0])
        cube([20,0.1,10]);
        translate([45,5+5-0.1,0])
        cube([15,0.1,10]);
      }
    }

    translate([50+5,10+extra,5])
    rotate([90,0,0]) screw(dia=3.4);
  }
}

module hookPart2()
{
  difference()
  {
    voronGantryHook();
    translate([-extra,-extra,-extra]) cube([50+extra,30+extra*2,20+extra*2]);

    translate([50+5,10+extra,5])
    rotate([90,0,0]) screw(dia=3.4);

    translate([50+5,3-extra,5])
    rotate([90,0,0]) nut();
  }
}

color("silver")
translate([50+5,3-extra-0.2,5])
rotate([90,0,0]) nut();

color("silver")
translate([50+5,10+extra,5])
rotate([90,0,0]) screw(dia=3.2,lenght=12);

hookPart1();
translate([0,-0.1,0])
hookPart2();
