import pyvista as pv

# --- Parse command-line arguments ---
parser = argparse.ArgumentParser(description="Fix normals of an STL file and re-export")
parser.add_argument("input", help="Input STL file path")
parser.add_argument("output", nargs="?", help="Output STL file path (default: same name as input with .stl extension)")
args = parser.parse_args()

if args.output is None:
    base, _ = os.path.splitext(args.input)
    args.output = base + ".stl"


# Works directly with VRML too (via meshio)
mesh = pv.read(args.input)   # or "input.stl"

# Fix normals
fixed = mesh.compute_normals(consistent_normals=True, auto_orient_normals=True)

# Save
fixed.save(args.output)
