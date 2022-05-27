$fn=50;


module file()
{
  import("2020Endcap.stl");
}


difference()
{
  file();
  cylinder(r=5/2,h=5);
  translate([-10,-10,0]) cube([20,20,1]);
  translate([-1,-1,0]) cube([20,20,5]);
}
