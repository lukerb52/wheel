//// VARIABLES ////

fc=360; // the number of degrees in a full circle

c=100; //polygon count

acl=0.1; //additional cutting length. It is used to avoid visial glitches when gutting right up to an edge


// GENERAL SIZE
h=2; //thickness of the wheel
r1=3; //radius of the wheel
r2=r1;


// SPOKES
sn=5; //number of spokes
sl=r1-0.4; //spoke length
sh=0.2; //spoke height
sd=0; //spoke distance from 'top' of wheel
sr=90; //roll angle of the spokes	default is 90 degrees
sy=90; //yaw angle of the spokes	default is 90 degrees
sw=0.7; //spokewidth
sp=[
	[0,0],
	[sw*.25,sh],
	[sw*.75,sh],
	[sw,0]
	];

// HUB
//hr=(lnfc+lnr+lnss)/2;
hr=1.2; //hub radius
hh=0.4; //hub height

// LUGNUTS
lnr=0.2; //lugnut radius
lnh=h+1; //make sure the holes go through the whole wheel
lnfc=hr*(2/3); // distance of the lug nuts from the center of the wheel
lnn=5; //number of lug nuts
lnss=0.4; //additional radius around each lug nut saved

// Counterbore & Countersink
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

	rotate_extrude(convexity=c,$fn=c)
	translate([r1,h/2,0])
rotate(270)
	polygon(points=ow);								//The outer pattern of the wheel that will be covered by the tire.

	difference(){
		union(){
			translate([0,0,1-hh+hh/2])
				cylinder(hh,hr,hr,center=true,$fn=c);			//Hub
			for (i=[1:sn])
			{
				rotate(a=[0,sr,(fc/sn)*i])//
					translate([-h/2+sh/2+sd,lnh/2,0]) //
					rotate(a=[sy,270,0])
					//cube([sh,sw,sl],center=true);			//Spokes
					linear_extrude(sl,center=true)
					polygon(points=sp);
			}
		}
		for (i=[1:lnn])
		{
			rotate(a=[0,0,(fc/lnn)*i])
				translate([lnfc,0,0])
				cylinder(lnh,lnr,lnr,center=true,$fn=c);		//Lugnut holes
		}
//}
if (cbd>0) {
	for (i=[1:lnn])
	{
		rotate(a=[0,0,(fc/lnn)*i])
			translate([lnfc,0,cbt])
			cylinder(cbd+acl,cbr,cbr,center=true,$fn=c);		//Counterbore
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
