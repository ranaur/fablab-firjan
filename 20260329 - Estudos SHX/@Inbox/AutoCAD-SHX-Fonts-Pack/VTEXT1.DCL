tcopy : dialog {
	label = "Sao chep dac tinh van ban" ;
	:toggle {
		label = "Van ban (Text)";
			key = "copy_text";
		}
	:toggle {
		label = "Chieu cao (Height)";
		key = "copy_height";
		}
	:toggle {
		label = "Goc dong (Rotation angle)";
		key = "copy_ra";
		}
	:toggle {
		label = "Do rong (Width factor)";
		key = "copy_wf";
		}
	:toggle {
		label = "Goc ki tu (Obliquing angle)";
		key = "copy_oa";
		}
	:toggle {
		label = "Kieu chu (Style)";
		key = "copy_style";
		}
	:toggle {
		label = "Sap hang (Alignment)";
		key = "copy_ali";
		}
	:spacer { height = 1;}
	:row {
		alignment=centered;
		fixed_width=true;
	:button {
		label = "OK (sel.obj.)";
		key="accept";
		width=10;
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

tfont : dialog {
	label = "Xac lap kieu chu Viet" ;
	:row {
		:list_box {
			list = "";
			key = "lfont";
			width=20;
			height = 10;
			}
		:image {
			key = "face";
			color =0;
			width = 20;
			height = 10;
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
	:text {
		key = "used";
		}
}

tabout : dialog {
	label = "TDY Software Library" ;
	:image_button {
		key = "tdy";
		width = 40;
		height = 15;
		color = 0;
		is_default=true;
		allow_accept=true;
		}
}

thelp : dialog {
	label = "Huong dan su dung" ;
	:list_box {
		key = "help_content";
		list = "";
		width = 35;
		height = 10;
		}
	ok_only;
}

tsel_line : dialog {
	label = "Chon van ban";
	:list_box {
		key = "sel_from_list";
		list = "";
		width = 35;
		height = 10;
		}
	ok_cancel;
}
