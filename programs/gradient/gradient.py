from PIL import Image

def generate_gradient_png(filename, width):
    height = 1

    # Create a new grayscale image ("L" mode = 8-bit pixels)
    img = Image.new("L", (width, height))
    pixels = img.load()

    for x in range(width):
        # Linear interpolation: 0 → 255
        value = int(255 * x / (width - 1)) if width > 1 else 0
        pixels[x, 0] = value

    img.save(filename, "PNG")

# Example usage
generate_gradient_png("gradient.png", 256)
