//// VARIABLES ////

fc=360; // the number of degrees in a full circle

c=100; //polygon count

acl=0.3; //additional cutting length. It is used to avoid visial glitches when gutting right up to an edge


// GENERAL SIZE
h=2; //thickness of the wheel
r1=3; //radius of the wheel
r2=r1;

// HUB
hr=1.2; //hub radius
hh=0.4; //hub height
hd=0; //hub distance from the top/edge of the wheel

// SPOKES
sn=5; //number of spokes
sl=r1-0.4; //spoke length
sh=0.2; //spoke height
sd=0; //spoke distance from top of hub
sed=0; //the distance from the top of the hub
sr=0; //roll angle of the spokes
sy=0; //yaw angle of the spokes
sw=0.8; //spoke width
se=1.5; //spoke extension length
sp=[
	[0,0],
	[sw*.25,sh],
	[sw*.75,sh],
	[sw,0]
];
sfc=hr*(3/4);

// LUGNUTS
lnn=5; //number of lug nuts
lnr=0.2; //lugnut radius
lnh=h+1; //make sure the holes go through the whole wheel
lnfc=hr*(2/3); // distance of the lug nuts from the center of the wheel
lnss=0.4; //additional radius around each lug nut saved

// COUNTERBORE & COUNTERSINK
//bore=true;
//sink=false;
//if (bore==true&&sink=true){sink=false;}
cbd=0.2; //counterbore depth
cbr=0.3; //counterbore radius
csd=0.2; //countersink depth
csa=35; //countersink angle
cbt=h/2-cbd/2+acl/2;//hh-(cbd/2)+hh/2; //countersink vertical translation
cst=h/2; //countersink vertical translation


// OUTER WHEEL
owt=0.2;
ow=[ //outer-wheel pattern where the tire will meet.
	[0,	0],
	[0.05*h,	-0.05],
	[0.12*h,	-0.25],
	[0.15*h,	-0.25],
	[0.20*h,	-0.40],
	[0.40*h,	-0.40],
	[0.50*h,	-0.15],
	[0.90*h,	-0.15],
	[1.00*h,	0.00],
	[1.00*h,	0.00-owt],
	[0.90*h,	-0.15-owt],
	[0.50*h,	-0.15-owt],
	[0.40*h,	-0.40-owt],
	[0.20*h,	-0.40-owt],
	[0.15*h,	-0.25-owt],
	[0.12*h,	-0.25-owt],
	[0.05*h,	-0.05-owt],
	[0,	-owt]
];

//// GENERATION CODE ////

// OUTER WHEEL
	rotate_extrude(convexity=c,$fn=c)
	translate([r1,h/2,0])
rotate(270)
	polygon(points=ow);
	difference(){
		union(){
			// HUB
			translate([0,0,h/2-hh+hh/2-hd])
				cylinder(hh,hr,hr,center=true,$fn=c);
			// SPOKES
			sa=90-atan(sfc/hd); //spoke angle
			for (i=[0:sn-1])
			{
				rotate([0,0,(fc/sn)*i])
					translate([se,0,h/2-sh/2-hd])
					rotate([90-sa,sr,sy+90])
					translate([-sw/2,-sh/2,sfc])
					linear_extrude(sl,center=true)
					polygon(points=sp);
			}
		}
		// LUGNUT HOLES
		for (i=[1:lnn])
		{
			rotate(a=[0,0,(fc/lnn)*i])
				translate([lnfc,0,-hd])
				cylinder(lnh,lnr,lnr,center=true,$fn=c);
		}
		//}
		// COUNTERBORE
if (cbd>0) {
	for (i=[1:lnn])
	{
		rotate(a=[0,0,(fc/lnn)*i])
			translate([lnfc,0,cbt-hd])
			cylinder(cbd+acl,cbr,cbr,center=true,$fn=c);
	}
}
}
//ex=csd*tan(csa);
//if (csd>0) {
//	for (i=[1:lnn])
//	{
//		rotate(a=[0,0,(fc/lnn)*i])
//			translate([lnfc,0,cst+2])//cst+0.5])
//			rotate_extrude(angle = 360, convexity = 2,$fn=c)
//			polygon([[lnr,csd],[lnr,csd],[lnr,0]]);				//Countersink TEMPORARILY DEPTECATED

//	}
//}

//}
