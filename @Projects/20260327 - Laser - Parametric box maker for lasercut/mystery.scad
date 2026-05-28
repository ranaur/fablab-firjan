//parametric case (for Mystery cloud ESC100A)
//measure dims are according to the internal volume of box
//--for example for pcb dims

thickness = 2;
w = 40.0;
d = 70.0;
h = 19.0; // box height
tab = 7.0; // the tab size
separation = 5.0; //2d presentation gap

nw = 0;
nd = 0;
nh = 0;

nw =floor((w+2*thickness)/tab); //tabs on w dimension
nd =floor((d+2*thickness)/tab); //tabs on d dimension
nh =floor((h+2*thickness)/tab); //tabs on height
// watch in case the height is less than tab size...

delta_w = (w+2*thickness - nw*tab)/2; //center align the tabs on each edge
delta_d = (d+2*thickness - nd*tab)/2;
delta_h = (h+2*thickness - nh*tab)/2;

tab= ((nh<1) || (nd<1) || (nw<1))==true ? 3.5 : 7; // attempt to half the tab size
//echo(tab);

if (tab == 3.5){
	//recalculate nw, nd, nh
	//recalculate deltas
}
//****************************************
// choose your options here***************
with_top=true; //you may want an open case without lid, huh?
in3D=false; // set to false to see projection
DXF=false; // set to true to see the DXF projection, for a laser cutter for example
//***************************************

// bottom side
module case_bottom(){
	difference(){
		cube ([w+2*thickness,d+2*thickness,thickness], center =false);
		for(x = [0:nw]){	
			if (x%2==1) translate ([delta_w+x*tab, thickness/2,thickness/2]) cube ([tab, thickness, thickness], center = true);
		}
		for(x = [0:nd]){
			if (x%2==1) translate ([thickness/2,delta_d+x*tab,thickness/2]) cube ([thickness,tab,thickness], center = true);
		}//for
		for(x = [0:nw]){	
			if (x%2==1) translate ([delta_w+x*tab, d+2*thickness-thickness/2,thickness/2]) cube ([tab, thickness, thickness], center = true);
		}
		for(x = [0:nd]){
			if (x%2==1) translate ([w+2*thickness-thickness/2,delta_d+x*tab,thickness/2]) cube ([thickness,tab,thickness], center = true);
		}//for
	}//difference
} 

// side A side
module side_1(){ //left
difference(){
	cube ([thickness,d+2*thickness,2*thickness+h], center =false);
	for(x = [0:nh]){
		if (x%2==1) translate ([thickness/2,thickness/2,delta_h+x*tab]) cube ([thickness,thickness,tab], center = true);
	}//for
	for(x = [0:nh]){
		if (x%2==1) translate ([thickness/2,d+2*thickness-thickness/2,delta_h+x*tab]) cube ([thickness,thickness,tab], center = true);
		}//for
	case_bottom();
	if (with_top == true) translate([0,0,h+thickness]) case_bottom();
	}//difference
} 

module side_2(){//right
	difference(){
		translate([w+thickness,0,0]) cube ([thickness,d+2*thickness,2*thickness+h], center =false);
		for(x = [0:nh]){
			if (x%2==1) translate ([w+2*thickness-thickness/2,thickness/2,delta_h+x*tab]) cube ([thickness,thickness,tab], center = true);
	}//for
		for(x = [0:nh]){
			if (x%2==1) translate ([w+2*thickness-thickness/2,d+2*thickness-thickness/2,delta_h+x*tab]) cube ([thickness,thickness,tab], center = true);
		}//for
		case_bottom();
		if (with_top == true) translate([0,0,h+thickness]) case_bottom();
	}//difference
} 


module side_3(){ //front	
	difference(){
		cube ([w+2*thickness,thickness,2*thickness+h], center =false);
		side_1();
		side_2();
		case_bottom();
		if (with_top == true) translate([0,0,h+thickness]) case_bottom();
	}//difference
} 

module side_4(){//back
	difference(){
		translate([0,d+thickness,0]) cube ([w+2*thickness,thickness,2*thickness+h], center =false);
		side_1();
		side_2();
		case_bottom();
		if (with_top == true) translate([0,0,h+thickness]) case_bottom();
	}
} 

// top side
module case_top(){
	if (with_top == true){
		translate([0,0,h+thickness]) case_bottom();
	}//with top
}


// projection in flat 

module decomp(){
	case_bottom();
	translate ([0, -5, 0]) rotate(a=90, v=[1,0,0]) side_3();
	translate ([-5, 0, 0]) rotate(a=-90, v=[0,1,0]) side_1();
	translate([w+separation + 2*thickness,0, thickness]) rotate(a=90, v=[0,1,0]) translate([-(w+thickness),0,0]) side_2();
	translate([0,d+separation + 2*thickness, thickness]) rotate(a=-90, v=[1,0,0]) translate ([0, -(d+thickness), 0]) side_4();
	if (with_top==true) translate([w+2*separation+4*thickness+h,0, 0]) translate([0,0,-(h+thickness)]) case_top();	
}

//rendering mode 

if (in3D==true) {
	color ("blue", 0.5) case_bottom();
	color ("green", 0.5) side_1();
	color ("green", 0.5) side_2();
	color ("yellow", 0.5) side_3();
	color ("yellow", 0.5) side_4();
	if (with_top==true) color ("orange", 0.5) case_top();
}
 	else if (DXF==false){
		decomp();
}	else {//projection in dxf
	
		projection (cut=false) decomp();

}