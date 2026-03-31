tentry : dialog {
	label = "Van ban tieng Viet" ;
	:row {
		:edit_box {
			label = "Van ban";
//			width = 30;
			key = "text_str";
			}
		:button {
			label = "?";
			key="helpkey";
			fixed_width=true;
			}
		}
	:boxed_column {
		label = "Cac dac tinh";
		:row {
			:edit_box {
				label = "Chieu cao";
				key = "h";
				width = 10;
				}
			:edit_box {
				label = "Goc dong ";
				key = "r";
				width=10;
				}
			}
		:popup_list {
			label = "Can chinh";
			list = "Can trai (Left)\nTam diem (Center)\nCan phai (Right)\nSap hang (Align)\nChinh giua (Middle)\nTra vua (Fit)";
			key = "ali";
			width=30;
			}
		:spacer { height=0.5;}
		:row {
			:button {
				fixed_width=true;
				label = "Kieu chu...";
				key = "style_button";
				width = 20;
				}
			:text {
				fixed_width=true;
				key ="show_font";
				width=20;
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
	:button	{
		label ="Cancel";
		is_cancel=true;
		width=10;
		}
	:button {
		label = "Edit";
		key = "edit_push";
		width=10;
		}
	:button {
		label = "About...";
		key = "about";
		width=10;
		}
	}
	:spacer {height = 0.5;}
}
			