
//choose a rendering quality

//$fa=10;$fs=0.5; step=0.5; //not so slow medium quality
$fa=3;$fs=0.2; step=0.2; //slow high quality rendering


//measurements in millimeters!


//this controls the end points
width1=21.8; //width of the part connecting to the watch
te=5; //thickness of the part connecting to the watch
hole=2.5; //hole diameter
notchLength=2;
notchWidth=1.4;


//this controls the size of each line
t=2.5; w=2.5;

//this controls the general size and apperance
length=125; //length between the holes
width2=33; //outer width 
waves=12; //number of full waves
lines=2; //number of pairs of wavy lines
touch=0; //controls how they touch

//this fine tunes how the wavy lines are attached to the ends 
phase=0.08;


//built in brim function
brimX=15;
brimY=7;
brimZ=0;
brimTouch=0.05;


//the basic shape for each line. A plain cylinder would result in a square line, a sphere would result in a round.
module prim()
{
//	intersection(){cylinder(d=w+1,h=t); translate([0,0,t/2]) scale([w/t,w/t,1.3])sphere(d=t);}
//	cylinder(d=w,h=t);
	translate([0,0,t/2])sphere(d=t);
}



//adjust the curviness by selecting one of those functions

//plain sine
//function ms(a) = sin(a);

//square root of sine
function ms(a) = (sin(a)<0)?-sqrt(-sin(a)):sqrt(sin(a));

//square root of square root of sine
//function ms(a) = (sin(a)<0)?-sqrt(sqrt(-sin(a))):sqrt(sqrt(sin(a)));


//*****************************************************
//you probably don't need to adjust anything below this
//*****************************************************


w3=width2/lines;
offs=(width1-width2-w3)/2;

echo(w3);
echo(offs);

//brim
if (brimX>0 && brimY>0 && brimZ>0)
	difference()
	{
		translate([-brimX,-(width2-width1)/2-brimY,0])
			cube([brimX*2+length,brimY*2+width2,brimZ]);
		translate([te,brimTouch-(width2-width1)/2,-1])
			cube([length-te*2,width2-2*brimTouch,brimZ+2]);
	}


difference()
{
    union()
    {
        for (i=[1:lines])
        {
            translate([0,offs+i*w3-w3/4,0])s(length,(w3-touch*w)/4,waves+0.5-2*phase,step);
            translate([0,offs+i*w3+w3/4,0])s(length,-(w3-touch*w)/4,waves+0.5-2*phase,step);
        }


        hull()
        {
            translate([0,0,te/2])rotate([-90,0,0])
                cylinder(d=te,h=width1);
            translate([te/2+t/2,0,t/2])rotate([-90,0,0])
                cylinder(d=t,h=width1);
        }
        hull()
        {
            translate([length,0,te/2])rotate([-90,0,0])
                cylinder(d=te,h=width1);
            translate([length-(te/2+t/2),0,t/2])rotate([-90,0,0])
                cylinder(d=t,h=width1);
        }

    }

	translate([0,-1,te/2])rotate([-90,0,0])
		cylinder(d=hole,h=width1+2);
	translate([length,-1,te/2])rotate([-90,0,0])
		cylinder(d=hole,h=width1+2);
	translate([0,notchLength/2-1,0])
		cube([notchWidth,notchLength+2,te], center=true);
	translate([0,width1-notchLength/2+1,0])
		cube([notchWidth,notchLength+2,te], center=true);
	translate([length,notchLength/2-1,0])
		cube([notchWidth,notchLength+2,te], center=true);
	translate([length,width1-notchLength/2,0])
		cube([notchWidth,notchLength+2,te], center=true);
}


module s(l,amp,n,step)
{
	for (a=[te-t/2+step:step:l-te+t/2])
	{
		hull()
		{
			translate([(a-step),amp*ms((a-step)*360*n/l+phase*360),0])prim();
			translate([(a),amp*ms((a)*360*n/l+phase*360),0])prim();
		}
	}
}