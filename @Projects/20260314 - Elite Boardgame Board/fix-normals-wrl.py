import argparse
import os
import vtk

# --- 0. Parse command-line arguments ---
parser = argparse.ArgumentParser(description="Fix normals of a VRML/WRL file and export as STL")
parser.add_argument("input", help="Input WRL/VRML file path")
parser.add_argument("output", nargs="?", help="Output STL file path (default: same name as input with .stl extension)")
args = parser.parse_args()

if args.output is None:
    base, _ = os.path.splitext(args.input)
    args.output = base + ".stl"

# --- 1. Set up a renderer (required by the VRML importer) ---
renderer = vtk.vtkRenderer()
render_window = vtk.vtkRenderWindow()
render_window.AddRenderer(renderer)

# --- 2. Import the VRML file ---
importer = vtk.vtkVRMLImporter()
importer.SetRenderWindow(render_window)
importer.SetFileName(args.input)
importer.Update()

# --- 3. Extract PolyData from all actors in the scene ---
actors = renderer.GetActors()
actors.InitTraversal()

append_filter = vtk.vtkAppendPolyData()

actor = actors.GetNextActor()
while actor:
    mapper = actor.GetMapper()
    if mapper:
        mapper.Update()
        poly = mapper.GetInput()
        if poly:
            append_filter.AddInputData(poly)
    actor = actors.GetNextActor()

append_filter.Update()

# --- 4. Optional: Clean duplicate points before recalculating ---
cleaner = vtk.vtkCleanPolyData()
cleaner.SetInputConnection(append_filter.GetOutputPort())
cleaner.Update()

# --- 5. Recalculate normals ---
normals = vtk.vtkPolyDataNormals()
normals.SetInputConnection(cleaner.GetOutputPort())
normals.ConsistencyOn()
normals.AutoOrientNormalsOn()
normals.NonManifoldTraversalOn()
normals.Update()

# --- 6. Export to STL (or use vtkVRMLExporter to keep .wrl format) ---
writer = vtk.vtkSTLWriter()
writer.SetInputConnection(normals.GetOutputPort())
writer.SetFileName(args.output)
writer.Write()

print(f"Done! Normals recalculated and saved to {args.output}.")
