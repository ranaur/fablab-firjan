// DWGTEST.DCL 
// Copyright by Dinh Cao Dai

DTest_Dcl: dialog {
        label = " Drawing test ";
        key = "label";
        spacer;
        initial_focus    = "next";
        : row {
            : column {
                : row {
                    : image {
                      width = 90;
                      aspect_ratio = 0.66;
                      color = 0;
                      allow_accept = true;
                      key     = "Imagen";
                    }
                   : column {
                       :button {
                        label = "Create Slb";
                        key = "Create_Slb";
                        width = 15;
                        height = 2;
                       }
                       :button {
                        label = "Erase Slb";
                        key = "Erase_Slb";
                        width = 15;
                        height = 2;
                       }
                       :button {
                        label = "Create file";
                        key = "F_Create";
                        width = 15;
                        height = 2;
                       }
                       :button {
                        label = "Image input";
                        key = "F_Browse";
                        width = 15;
                        height = 2;
                       }
                      : text {
                        edit_width = 15;
                        label = "File name";
                      }
                      : edit_box {
                        edit_width = 15;
                        key = "File_Name";
                        fixed_width = true;
                        edit_limit = 259;
                        height = 1;
                      }
                      : text {
                        edit_width = 15;
                        key = "middle_text";
                        label = "Image name";
                      }
                       : popup_list {
                        width               = 14;
                        height              = 14;
                        fixed_height        = true;
                        key                 = "Image_list";
                        allow_accept        = true;
                       }
                      : text {
                        edit_width = 15;
                        label = "Image number";
                      }
                       : edit_box {
                        edit_width = 15;
                        height = 1;
                        key = "Image_Num";
                        fixed_width = true;
                        edit_limit = 259;
                      }
                      : text {
                        edit_width = 15;
                        label = "Drawing source";
                      }
                       : edit_box {
                        edit_width = 15;
                        height = 1;
                        key = "Dwg_Source";
                        fixed_width = true;
                        edit_limit = 259;
                      }
                      : text {
                        edit_width = 15;
                        label = "Create times";
                      }
                       : edit_box {
                        edit_width = 15;
                        height = 1;
                        key = "Create_time";
                        fixed_width = true;
                        edit_limit = 259;
                      }
                   } 
                }
            }
        }
        : row {
            : row {
                spacer_1;
                : row {
                    fixed_width = true;
                    : button {
                        label = "&Bottom";
                        key = "bottm";
                        width = 8;
                    }
                    spacer;
                    spacer;
                    : button {
                        label = "&Previous";
                        key = "prev";
                        width = 8;
                    }
                    spacer_1;
                    spacer_1;
                    :button {
                        label = "  &Next  ";
                        key = "next";
                        width = 8;
                    }
                    spacer_1;
                    spacer_1;
                    :button {
                        label = "  &Top   ";
                        key = "top";
                        width = 8;
                    }
                }
            }
            ok_cancel;
            spacer;
        }
        spacer;
}
///////////////////
DTest_Alert: dialog {
        width = 38;
        label = " Alert";
        spacer;
       : text {
         edit_width = 10;
         key = "St-Alert";
       }
       spacer;
       spacer;
       ok_cancel; 
       spacer;    
}




