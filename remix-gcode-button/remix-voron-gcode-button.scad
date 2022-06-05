$fn=50;


module file()
{
  translate([-102.5,-20.4-(14.2/2),3.4])
    import("STL-original/base.stl");
}



module hexCut(height=12)
{
  difference()
  {
    minkowski()
    {
      rotate([0,0,30]) cylinder(r=12-0.5,h=height-0.1,$fn=6);
      cylinder(r=2.6,h=0.00000001);
    }
    translate([0,0,-0.1])
    minkowski()
    {
      rotate([0,0,30]) cylinder(r=10-0.88,h=height+0.1,$fn=6);
      cylinder(r=2.9,h=0.00000001);
    }

    difference() {
      translate([-12.6,-6,-1])
      cube([25.2,25.2,height+1]);

      translate([10.41,-6,-1]) rotate([0,0,-28])  cube([5,5,15]);
      mirror([1,0,0]) translate([10.41,-6,-1]) rotate([0,0,-28])  cube([5,5,15]);
    }
  }
}

difference()
{
  translate([0,0,0])
    file();

  hexCut(height=14);

  /* translate([-12.6,-6,-1])
  cube([25.2,25.2,12+1]); */
}
