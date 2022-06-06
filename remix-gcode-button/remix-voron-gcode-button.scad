$fn=50;

/* import gCode Button Base file */
module fileBase()
{
  translate([-102.5,-20.4-(14.2/2),3.4])
    import("STL-original/base.stl",convexity=5);
}

/* import empty button cap */
module fileKeycaps()
{

  translate([-90,-90,-2.5])
    import("STL-original/remix-voron-gcode-button-empty.stl",convexity=5);
}
/* fileKeycaps(); */

/* light  */
iconXmove=-7.0;
iconYmove=-7;
iconZmove=-0.01;
iconXscale=2.5;
iconYscale=2.5;
/* iconZscale=1; */

iconExtrudeHeight=0.6;

module icon()
{
  /* move to center */
  translate([iconXmove,iconYmove,iconZmove])
  scale([iconXscale,iconYscale,1])
  linear_extrude(height = iconExtrudeHeight, center = false, convexity = 10)
  import("svg/heatup.svg");
  /* #import("svg/Zeichnung.svg",convexity=5); */
}

/* translate([0,0,-0.1])
linear_extrude(height=1)
#svgLightOff(scaleVal=0.03); */

/* cutout form for base
    removes the lower part. with this removed,
    these base part fits into new Voron (V2.4 / Trident??) Skirts */
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

module newButtonBase()
{
  difference()
  {
    translate([0,0,0])
      fileBase();

    hexCut(height=14);
  }
}




stemXhalf = 3.5;
stemYhalf = 2.7;
stemZ = 3;
minkRad = 0.75;
module stemNegative()
{
  difference() {

    translate([-(stemXhalf-minkRad),-(stemYhalf-minkRad),0])
    minkowski() {
        cube([(stemXhalf-minkRad)*2,(stemYhalf-minkRad)*2,stemZ-minkRad]);
        sphere(r=minkRad);
    }

    translate([-(stemXhalf),-(stemYhalf),-1])
    cube([stemXhalf*2,stemYhalf*2,1]);

    /* stem cross for cherry style switches */
    translate([-2,-0.7,0])
    cube([4,1.4,3.5]);

    translate([-0.7,-2,0])
    cube([1.4,4,3.5]);

    a=2.2;
    rotate([0,0,45])
    translate([-a/2,-a/2,0])
    cube([a,a,3.5]);
  }
}
/* stemNegative(); */

module newKeycap(height=4)
{
  translate([0,0,height+1])
  mirror([0,0,1])
  union()
  {
    difference() {
      hull()
      {
        translate([0,0,height+1])
        minkowski()
        {
          rotate([0,0,30]) cylinder(r=7,h=0.000001,$fn=6);
          cylinder(r=2.6,h=0.00000001);
        }
        translate([-0.03,-0.03,0])
        minkowski()
        {
          rotate([0,0,30]) cylinder(r=7.7,h=height,$fn=6);
          cylinder(r=2.9,h=0.00000001, $fn=100);
        }
      }

      hull()
      {
        /* translate([0,0,height])
        minkowski()
        {
          rotate([0,0,30]) cylinder(r=6,h=0.1,$fn=6);
          cylinder(r=2.6,h=0.00000001);
        } */
        translate([-0.03,-0.03,-0.005])
        minkowski()
        {
          rotate([0,0,30]) cylinder(r=6.7,h=height-1,$fn=6);
          cylinder(r=2.9,h=0.00000001, $fn=100);
        }
      }
    }

    translate([0,0,stemZ])
    mirror([0,0,1]) stemNegative();
  }
}

/* newKeycap(); */


/* difference() {
  newKeycap();
  cube([10,10,10]);
} */


/* LightOff(); */

module keycap_lowLight(iconScale=1)
{
  difference()
  {
    newKeycap();
    icon();
  }
}

/* -------------------------------------------------- */
/* --------------- PARTS ---------------------------- */


/* newButtonBase(); */

translate([0,0,0])
keycap_lowLight(iconScale=0.03);
