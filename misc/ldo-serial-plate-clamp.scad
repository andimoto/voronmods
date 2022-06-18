$fn = 100;

/* for rendering */
extra = 0.1;


clampWall = 1;            // 1mm wall on the sides
clampTopThickness = 1;
serialPlateWidth = 20;    // width of extrusion
serialPlateThickness = 1;

clampPlateX = 5;        // 5mm holding the plate
clampPlateY = 5;        // 10mm free clearance in the middle of the side of the plate (only valid for TYPE2)
clampPlateYinner = 10;  // 10mm free clearance in the middle of the side of the plate
clampX = 10;            // 10mm for rest and screw

screwHoleDia = 3.2;     //M3 screw with 0.2mm extra clearance
minkowskiCylinderR = 1; // roundness

module ldoSerialPlate(type = "DEBUG")
{
  difference() {

    if(type == "TYPE1") {
      /* rectangular clamp */
      translate([minkowskiCylinderR,minkowskiCylinderR,0])
      minkowski() {
        cube([clampPlateX+clampX-minkowskiCylinderR*2,      // x width
          serialPlateWidth+clampWall*2-minkowskiCylinderR*2,
          clampTopThickness+serialPlateThickness]);
        cylinder(r=minkowskiCylinderR, h=0.00000001, center=true);
      }
    } else if (type == "TYPE2") {
      /* edgy type */
      minkowski(){
        translate([minkowskiCylinderR,minkowskiCylinderR,0])
        hull()
        {
          cube([clampPlateX+clampWall*2-minkowskiCylinderR*2,
            serialPlateWidth+clampWall*2-minkowskiCylinderR*2,
            clampTopThickness+serialPlateThickness]);
          translate([clampPlateX+clampX-minkowskiCylinderR*2-extra,(serialPlateWidth-clampPlateY)/2+clampWall/2,0])
            cube([extra,clampPlateY+1-minkowskiCylinderR*2,clampTopThickness+serialPlateThickness]);
        }
        cylinder(r=minkowskiCylinderR, h=0.00000001, center=true);
      }
    }

    if (1) // for debugging
    {
      translate([0,clampWall,-extra])
      cube([clampPlateX,serialPlateWidth,serialPlateThickness+extra]);

      /* top cutout for serial plate (trapezial shape) */
      translate([-extra,clampWall,clampWall])
      hull()
      {
        cube([0.1,serialPlateWidth,serialPlateThickness]);
        translate([clampPlateX,(serialPlateWidth-clampPlateYinner)/2,0]) cube([0.1,clampPlateYinner,1.1]);
      }

      /* screw hole */
      translate([clampPlateX+(clampX/2),(serialPlateWidth+minkowskiCylinderR*2)/2,0])
      cylinder(r=screwHoleDia/2,h=serialPlateThickness+clampTopThickness+extra);
    }
  }
}


ldoSerialPlate("TYPE2");

/* translate([30,0,0])
ldoSerialPlate("TYPE1"); */
