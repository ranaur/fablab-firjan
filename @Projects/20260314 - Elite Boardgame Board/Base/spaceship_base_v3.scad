// Spaceship Display Base
// Lathe-turned design inspired by chess piece bases
// Cylindrical symmetry throughout — meant to look like it was made on a lathe

// --- Parameters ---
base_diameter   = 25;   // Overall foot diameter (mm)
total_height    = 22;   // Total height, must be ≤ 25 mm
peg_dia         = 3;    // Top peg diameter (fits into ship hole)
$fn             = 128;  // Circle smoothness

// --- Derived ---
r_base   = base_diameter / 2;
r_peg    = peg_dia / 2;

// --- Profile (right half cross-section for rotate_extrude) ---
// x = radius, y = height from bottom

profile = [
    // Bottom center
    [0,              0],

    // Bottom flat sitting surface
    [r_base - 1.5,   0],

    // Bottom edge bead (the "foot ring") — widest point
    [r_base - 0.3,   0.4],
    [r_base,         1.0],
    [r_base,         1.8],

    // Foot body — start tapering in
    [r_base - 0.3,   2.2],
    [r_base - 1.5,   3.0],
    [r_base - 2.5,   3.8],

    // First decorative ring (bead) — r ≈ 10.5
    [r_base - 3.5,   4.5],
    [r_base - 3.0,   4.8],
    [r_base - 1.5,   5.3],
    [r_base - 1.5,   5.7],
    [r_base - 3.0,   6.2],
    [r_base - 3.5,   6.5],

    // Continue taper
    [r_base - 4.5,   7.5],
    [r_base - 5.5,   8.5],

    // Second ring — r ≈ 8.0
    [r_base - 6.0,   9.0],
    [r_base - 4.5,   9.3],
    [r_base - 4.5,   9.7],
    [r_base - 6.0,  10.0],

    // Continue taper
    [r_base - 6.5,  10.8],
    [r_base - 7.5,  11.8],

    // Third ring — r ≈ 6.0
    [r_base - 8.0,  12.3],
    [r_base - 6.5,  12.6],
    [r_base - 6.5,  13.0],
    [r_base - 8.0,  13.3],

    // Continue taper
    [r_base - 8.5,  14.0],
    [r_base - 9.5,  15.0],
    [r_base - 10.5, 16.0],

    // Fourth ring — r ≈ 4.0
    [r_base - 11.0, 16.5],
    [r_base - 9.5,  16.8],
    [r_base - 9.5,  17.2],
    [r_base - 11.0, 17.5],

    // Taper to peg
    [r_base - 11.5, 18.0],
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
