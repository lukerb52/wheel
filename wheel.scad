//// VARIABLES ////

fc=360; // the number of degrees in a full circle

c=50; //polygon count

// GENERAL SIZE
h=2; //thickness of the wheel
r1=3; //radius of the wheel
r2=r1;

// LUGNUTS
lnr=0.2; //lugnut radius
lnh=h+1; //make sure the holes go through the whole wheel
lnfc=1; // distance of the lug nuts from the center of the wheel
lnn=6; //number of lug nuts
lnss=0.4; //additional radius around each lug nut saved

// SPOKES
sn=4; //number of spokes
sl=r1-0.7; //spoke length
sh=0.2; //spoke height
sd=0; //spoke distance from 'top' of wheel
sr=90; //roll angle of the spokes	default is 90 degrees
sy=90; //yaw angle of the spokes	default is 90 degrees

// HUB
cor=r1-0.5; //'chunk out' radius. FROM POLYGON POINTS OF OUTER PATTERN
//hr=(lnfc+lnr+lnss)/2;
hr=1.5; //hub radius
hh=1; //hub height

// OUTER PATTERN
//opo=[ //outer-wheel pattern where the tire will meet.
//	[0,	0],
//	[1.00*h,	0],
//	[0.90*h,	-0.15],
//	[0.50*h,	-0.15],
//	[0.40*h,	-0.40],
//	[0.20*h,	-0.40],
//	[0.15*h,	-0.25],
//	[0.12*h,	-0.25],
//	[0.05*h,	-0.05]];

op=[ h*[
0.00,
1.00,
0.90,
0.50,
0.40,
0.20,
0.15,
0.15,
0.05
],[
0,
-0.15,
-0.15,
-0.40,
-0.40,
-0.25,
-0.25,
-0.05] ];

lol=concat(op[0][1],op[1][1]);
lol2=concat(op[0][2],op[1][2]);
echo(lol,lol2);
loli=[lol,lol2];
echo(loli);

//// GENERATION CODE ////

union(){
	difference(){
		union(){
			cylinder(h,r1,r1,center=true,$fn=c); 			//Big Cylinder. Just about all the wheel is cut from this.
		}
		//}
//	rotate_extrude(convexity=c,$fn=c)
//		translate([r1,h/2,0])
//		rotate(270)
//		polygon(points=[op.x,op.y]);			//The outer pattern of the wheel that will be covered by the tire.
	//}
cylinder(lnh,cor,cor,center=true,$fn=c);
}

difference(){
	union(){
		translate([0,0,hh/2])
		cylinder(hh,hr,hr,center=true,$fn=c);					//Hub
		for (i=[1:sn])
		{
			rotate(a=[0,sr,(fc/sn)*i])//
				translate([-h/2+sh/2+sd,lnh/2,0]) //
				rotate(a=[sy,0,0])
				cube([sh,1,sl],center=true);				//Spokes
		}
	}
	for (i=[1:lnn])
	{
		rotate(a=[0,0,(fc/lnn)*i])
			translate([lnfc,0,0])
			cylinder(lnh,lnr,lnr,center=true,$fn=c);		//Lugnut holes
	}

}

}
