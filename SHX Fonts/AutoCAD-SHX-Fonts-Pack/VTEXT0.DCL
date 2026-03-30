tedit : dialog {
	label = "Thay doi van ban tieng Viet" ;
	:edit_box {
		label = "Van ban";
			width = 40;
			key = "text_str";
		}
	:boxed_column {
		label = "Cac dac tinh";
		:row {
			:edit_box {
				label = "Chieu cao";
				key = "htext";
				width = 10;
				}
			:edit_box {
				label = "Goc dong ";
				key = "rtext";
				width=10;
				}
			}
		:row {
			:edit_box {
				label = "Do rong  ";
				key = "sfwidth";
				width=10;
				}
			:edit_box {
				label = "Goc ki tu";
				key = "oa";
				width=10;
				}
			}	
		:popup_list {
			label = "Can chinh";
			list = "Can trai (Left)\nTam diem (Center)\nCan phai (Right)\nSap hang (Align)\nChinh giua (Middle)\nTra vua (Fit)";
			key = "justi";
			width=30;
			}
		:popup_list {
			label = "Kieu chu ";
			list = "";
			key = "font";
			width=30;
			}
	}		
	:boxed_column {
	:row {
		:button {
			label = "Chep dac tinh...";
			key = "copyfeatures";
			height =3.3;
			}
		:column {	
			:button {
				label = "   Chu HOA(All caps)  ";
				key = "allcaps";
				width=20;
				alignment=left;
				fixed_width=true;
				}
			:button {
				label ="Chu thuong(Small caps)";
				key = "smcaps";	
				width=20;
				alignment=left;
				fixed_width=true;
				}
		}
	}
	}
	:spacer { height = 1;}
	:row {
		alignment=centered;
		fixed_width=true;
	:button {
		label = "OK";
		key="accept";
		width=10;
		is_default=true;
		}
	:spacer { width=3;}
	:button	{
		label ="Cancel";
		is_cancel=true;
		width=10;
		}
	}
	:spacer {height = 0.5;}
}
