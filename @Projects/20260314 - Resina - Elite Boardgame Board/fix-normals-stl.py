import argparse
import os
import vtk

# --- Parse command-line arguments ---
parser = argparse.ArgumentParser(description="Fix normals of an STL file and re-export")
parser.add_argument("input", help="Input STL file path")
parser.add_argument("output", nargs="?", help="Output STL file path (default: same name as input with .stl extension)")
args = parser.parse_args()

if args.output is None:
    base, _ = os.path.splitext(args.input)
    args.output = base + ".stl"

reader = vtk.vtkSTLReader()
reader.SetFileName(args.input)

normals = vtk.vtkPolyDataNormals()
normals.SetInputConnection(reader.GetOutputPort())
normals.ConsistencyOn()
normals.AutoOrientNormalsOn()
normals.NonManifoldTraversalOn()
normals.Update()

writer = vtk.vtkSTLWriter()
writer.SetInputConnection(normals.GetOutputPort())
writer.SetFileName(args.output)
writer.Write()
