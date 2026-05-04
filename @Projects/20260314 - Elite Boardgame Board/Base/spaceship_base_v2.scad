// Spaceship Display Base
// Lathe-turned design inspired by chess piece bases
// Cylindrical symmetry throughout — meant to look like it was made on a lathe

// --- Parameters ---
base_diameter   = 25;   // Overall foot diameter (mm)
total_height    = 22;   // Total height, must be ≤ 25 mm
peg_dia         = 3;    // Top peg diameter (fits into ship hole)
stem_dia        = 12;   // Narrowest stem diameter
$fn             = 128;  // Circle smoothness

// --- Derived ---
r_base   = base_diameter / 2;
r_peg    = peg_dia / 2;
r_stem   = stem_dia / 2;

// --- Profile (right half cross-section for rotate_extrude) ---
// x = radius, y = height from bottom

profile = [
    // Bottom center
    [0,              0],

    // Bottom flat sitting surface
    [r_base - 1.5,   0],

    // Bottom edge bead (the "foot ring")
    [r_base - 0.3,   0.4],
    [r_base,         1.0],
    [r_base,         1.8],

    // Foot body — gentle inward curve
    [r_base - 0.3,   2.2],
    [r_base - 1.0,   3.0],
    [r_base - 1.5,   3.5],

    // Concave transition to stem (the "neck")
    [r_base - 3.0,   4.5],
    [r_stem + 1.5,   5.5],
    [r_stem + 0.5,   6.5],

    // Upper stem
    [r_stem,         7.5],
    [r_stem,         9.0],

    // Decorative ring (bead) on stem
    [r_stem + 0.5,   9.3],
    [r_stem + 1.5,   9.8],
    [r_stem + 1.5,  10.2],
    [r_stem + 0.5,  10.7],

    // Stem continues
    [r_stem,        11.0],
    [r_stem,        13.0],

    // Second subtle ring
    [r_stem + 0.3,  13.3],
    [r_stem + 1.0,  13.7],
    [r_stem + 1.0,  14.1],
    [r_stem + 0.3,  14.5],

    // Stem to collar transition
    [r_stem,        14.8],
    [r_stem,        15.5],
    [r_stem + 1.0,  16.0],
    [r_stem + 1.5,  16.5],
    [r_stem + 1.5,  17.0],
    [r_stem,        17.5],

    // Taper down to peg
    [r_stem - 1.0,  18.0],
    [r_peg + 1.0,   18.5],
    [r_peg + 0.3,   19.0],

    // Peg (fits into ship hole)
    [r_peg,         19.5],
    [r_peg,         total_height],
    [0,             total_height],
];

// --- Build the base ---
rotate_extrude()
    polygon(profile);

// --- Optional: center recess / magnet hole ---
// Uncomment to add a 5 mm diameter, 1.5 mm deep recess on top
// translate([0, 0, total_height - 1.5])
//     cylinder(h=1.5, r=2.5, $fn=64);
