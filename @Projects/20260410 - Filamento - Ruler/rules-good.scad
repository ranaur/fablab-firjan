// Ruler with Inches and Centimeters
// Default length: 15cm / ~6 inches

// Parameters
length_cm = 20;
width = 3;
top_width = 2;           // Width of flat top section
thickness = 0.5;       // Height in the middle (at top_width)
min_thickness = 0.45;   // Height at the outer edges
mark_depth = 0.3;
// Mark dimensions (width = thickness of line, height = length inward from edge)
mark_width_mm = 0.02;      // Width of cm marks
mark_height_mm_major = 0.5;   // Height of major cm marks
mark_height_mm_half = 0.35;     // Height of half-cm marks
mark_height_mm_minor = 0.15;  // Height of mm marks
mark_width_in = 0.02;      // Width of inch marks
mark_height_in_major = 0.5;   // Height of major inch marks
mark_height_in_half = 0.35;   // Height of half-inch marks
mark_height_in_quarter = 0.25; // Height of quarter-inch marks
mark_height_in_eighth = 0.15;  // Height of eighth-inch marks
font_size_mm = 0.3;
font_size_in = 0.3;
font_family = "Arial"; // Font for all text
lead_space_cm = 1; // Left margin for cm scale (cm)
lead_space_in = 1; // Left margin for inch scale (cm)
flip_inches = true; // If true, inches read right-to-left (upside down use)

// Convert cm to inches and round up to nearest 1/4 inch for inch ruler length
length_in_cm = length_cm / 2.54;  // Exact conversion
inches_mark_count = ceil(length_in_cm);  // Number of major inch marks (integer for loop)
inches_total = ceil(length_in_cm * 4) / 4;  // Total inch scale length (rounded up to 1/4)

// Compute scale extents
cm_scale_end = length_cm + lead_space_cm;
in_scale_end = inches_total * 2.54 + lead_space_in;
ruler_right = max(cm_scale_end, in_scale_end) + max(lead_space_cm, lead_space_in);

// Profile calculations
trap_inset = (width - top_width) / 2;

// Surface height at given Y position
function surface_z(y) = 
    y < trap_inset ? min_thickness + y * (thickness - min_thickness) / trap_inset :
    y > width - trap_inset ? thickness - (y - (width - trap_inset)) * (thickness - min_thickness) / trap_inset :
    thickness;

// Main ruler body
module ruler_body() {
    trap_inset = (width - top_width) / 2;
    // Cross-section: flat middle section with sloped sides
    rotate([90, 0, 90]) // Cross-section in Y-Z, extrude along X
        linear_extrude(height = ruler_right, center = false)
            polygon([
                [0, 0],                              // bottom-left corner
                [width, 0],                          // bottom-right corner
                [width, min_thickness],              // outer right edge (min thickness)
                [width - trap_inset, thickness],     // flat top right
                [trap_inset, thickness],             // flat top left
                [0, min_thickness]                   // outer left edge (min thickness)
            ]);
}

// Centimeter marks (top edge)
module cm_marks() {
    ruler_end = cm_scale_end;
    cm_surface_z = surface_z(width - 0.25);

    for (i = [0:length_cm]) {
        x = i + lead_space_cm;

        // Major mark every cm - start below surface, extend up through surface
        translate([x, width - mark_height_mm_major, cm_surface_z - mark_depth])
            cube([mark_width_mm, mark_height_mm_major + 0.01, mark_depth + 0.01]);

        // Number every cm - use surface height at text position
        cm_text_y = width - 1.2;
        cm_text_z = surface_z(cm_text_y);
        translate([x - 0.2, cm_text_y, cm_text_z - mark_depth])
            linear_extrude(height = mark_depth + 0.01)
                text(str(i), size = font_size_mm, font = font_family);

        // Half-cm marks
        if (i < length_cm && x + 0.5 <= ruler_end) {
            translate([x + 0.5, width - mark_height_mm_half, cm_surface_z - mark_depth])
                cube([mark_width_mm * 0.6, mark_height_mm_half + 0.01, mark_depth + 0.01]);
        }

        // Millimeter marks
        for (j = [1:9]) {
            if (j != 5) {
                mm_mark_height = (j == 1 || j == 9) ? mark_height_mm_half * 0.7 : mark_height_mm_minor;
                if (x + j/10 <= ruler_end) {
                    translate([x + j/10, width - mm_mark_height, cm_surface_z - mark_depth])
                        cube([mark_width_mm * 0.4, mm_mark_height + 0.01, mark_depth + 0.01]);
                }
            }
        }
    }
}

// Inch marks (bottom edge)
module inch_marks() {
    subdiv_end = ruler_right;
    inch_scale_right = flip_inches ? ruler_right - lead_space_in : lead_space_in + inches_total * 2.54;
    inch_surface_z = surface_z(0.25);

    for (i = [0:inches_mark_count]) {
        inch_pos = flip_inches
            ? inch_scale_right - i * 2.54
            : lead_space_in + i * 2.54;

        // Major inch mark - start below surface, extend up through surface
        translate([inch_pos, -0.01, inch_surface_z - mark_depth])
            cube([mark_width_in, mark_height_in_major + 0.01, mark_depth + 0.01]);

        // Inch numbers - use surface height at text position
        inch_text_y = flip_inches ? 0.7 + font_size_in : 0.7;
        inch_text_z = surface_z(inch_text_y);
        if (flip_inches) {
            translate([inch_pos + 0.2, inch_text_y, inch_text_z - mark_depth])
                rotate([0, 0, 180])
                linear_extrude(height = mark_depth + 0.01)
                    text(str(i), size = font_size_in, font = font_family);
        } else {
            translate([inch_pos - 0.2, inch_text_y, inch_text_z - mark_depth])
                linear_extrude(height = mark_depth + 0.01)
                    text(str(i), size = font_size_in, font = font_family);
        }

        step = flip_inches ? -1 : 1;

        // Half-inch marks (skip if would be beyond last inch or outside ruler)
        half_pos = inch_pos + step * 1.27;
        if (half_pos >= 0 && half_pos <= subdiv_end) {
            // Only draw if half_pos is within the inch scale area
            in_inch_scale = half_pos >= lead_space_in && half_pos <= (flip_inches ? inch_scale_right : lead_space_in + inches_total * 2.54);
            if (in_inch_scale) {
                translate([half_pos, -0.01, inch_surface_z - mark_depth])
                    cube([mark_width_in * 0.75, mark_height_in_half + 0.01, mark_depth + 0.01]);
            }
        }

        // Quarter-inch marks
        for (q = [1:3]) {
            if (q != 2) {
                q_pos = inch_pos + step * q * 0.635;
                if (q_pos >= 0 && q_pos <= subdiv_end) {
                    // Only draw if within the inch scale area
                    in_inch_scale = q_pos >= lead_space_in && q_pos <= (flip_inches ? inch_scale_right : lead_space_in + inches_total * 2.54);
                    if (in_inch_scale) {
                        translate([q_pos, -0.01, inch_surface_z - mark_depth])
                            cube([mark_width_in * 0.5, mark_height_in_quarter + 0.01, mark_depth + 0.01]);
                    }
                }
            }
        }

        // Eighth-inch marks
        for (e = [1:7]) {
            if (e % 2 != 0) {
                e_pos = inch_pos + step * e * 0.3175;
                if (e_pos >= 0 && e_pos <= subdiv_end) {
                    // Only draw if within the inch scale area
                    in_inch_scale = e_pos >= lead_space_in && e_pos <= (flip_inches ? inch_scale_right : lead_space_in + inches_total * 2.54);
                    if (in_inch_scale) {
                        translate([e_pos, -0.01, inch_surface_z - mark_depth])
                            cube([mark_width_in * 0.375, mark_height_in_eighth + 0.01, mark_depth + 0.01]);
                    }
                }
            }
        }
    }
}

// Unit labels
module unit_labels() {
    // CM label
    cm_label_y = width - 1.3;
    cm_label_z = surface_z(cm_label_y);
    translate([lead_space_cm + 0.2, cm_label_y, cm_label_z - mark_depth])
        linear_extrude(height = mark_depth + 0.01)
            text("cm", size = font_size_mm, font = font_family);

    // Inch label position and rotation depends on flip
    inch_label_x = flip_inches
        ? ruler_right - lead_space_in - 0.8
        : lead_space_in + 0.2;
    inch_label_y = flip_inches ? 0.8 + font_size_in : 0.8;
    inch_label_z = surface_z(inch_label_y);
    if (flip_inches) {
        translate([inch_label_x + 0.6, inch_label_y, inch_label_z - mark_depth])
            rotate([0, 0, 180])
            linear_extrude(height = mark_depth + 0.01)
                text("inches", size = font_size_in, font = font_family);
    } else {
        translate([inch_label_x, inch_label_y, inch_label_z - mark_depth])
            linear_extrude(height = mark_depth + 0.01)
                text("inches", size = font_size_in, font = font_family);
    }
}

// Assembly
difference() {
    ruler_body();
    cm_marks();
    inch_marks();
    unit_labels();
}
