import { readFile } from 'fs/promises';
import { ShxFont } from './shx-parser.cjs';

//console.log(ShxParser);

async function loadFont(filePath: string) {
  const buffer = await readFile(filePath);
  const font = new ShxFont(buffer.buffer);
  
  // Display font information
  const fontData = font.fontData;
  console.log('Font Information:');
  console.log('----------------');
  console.log('Font Type:', fontData.header.fontType);
  console.log('Header:', fontData.header.fileHeader);
  console.log('Version:', fontData.header.fileVersion);
  console.log('Info:', fontData.content.info);
  console.log('Orientation:', fontData.content.orientation);
  console.log('Height:', fontData.content.height);
  console.log('Width:', fontData.content.width);
  console.log('Number of shapes:', Object.keys(fontData.content.data).length);
  
  return font;
}


function shapeToSvgPath(shape: ShxShape, x: number = 0, y: number = 0): string {
  if (!shape?.polylines.length) return '';
  
  return shape.polylines.map(polyline => {
    if (!Array.isArray(polyline) || polyline.length === 0) return '';
    
    return polyline.map((point, i) => {
      const scaledX = (Number(point.x) || 0) + x;
      const scaledY = -(Number(point.y) || 0) + y; // Flip Y coordinate for SVG
      const command = i === 0 ? 'M' : 'L';
      return `${command} ${scaledX.toFixed(2)} ${scaledY.toFixed(2)}`;
    }).join(' ');
  }).filter(Boolean).join(' ');
}

interface SvgOptions {
  width?: number;
  height?: number;
  strokeWidth?: string;
  strokeColor?: string;
  isAutoFit?: boolean;
}

function renderTextToSvg(
  font: ShxFont,
  text: string,
  fontSize: number,
  options: SvgOptions = {}
): SVGElement {
  const {
    width = 1000,
    height = 1000,
    strokeWidth = '0.1%',
    strokeColor = 'black',
    isAutoFit = false
  } = options;

  // Create SVG element
  const svg = document.createElementNS('http://www.w3.org/2000/svg', 'svg');
  svg.setAttribute('width', width.toString());
  svg.setAttribute('height', height.toString());
  svg.setAttribute('viewBox', `0 0 ${width} ${height}`);

  const padding = fontSize;
  let currentX = padding;
  let maxHeight = 0;

  // Process each character
  for (const char of text) {
    const charCode = char.charCodeAt(0);
    const shape = font.getCharShape(charCode, fontSize);
    
    if (shape) {
      const group = document.createElementNS('http://www.w3.org/2000/svg', 'g');
      
      if (isAutoFit) {
        // Auto-fit positioning
        const bbox = shape.bbox;
        const padding = 0.2; // 20% padding
        const charBBoxWidth = bbox.maxX - bbox.minX;
        const charBBoxHeight = bbox.maxY - bbox.minY;
        const centerX = (bbox.minX + bbox.maxX) / 2;
        const centerY = (bbox.minY + bbox.maxY) / 2;
        group.setAttribute('transform', `translate(${currentX - centerX}, ${-centerY})`);
      } else {
        // Fixed positioning
        group.setAttribute('transform', `translate(${currentX + width / 2}, ${height / 2})`);
      }

      // Create path for the character
      const pathData = shapeToSvgPath(shape);
      const path = document.createElementNS('http://www.w3.org/2000/svg', 'path');
      path.setAttribute('d', pathData);
      path.setAttribute('fill', 'none');
      path.setAttribute('stroke', strokeColor);
      path.setAttribute('stroke-width', strokeWidth);
      
      group.appendChild(path);
      svg.appendChild(group);

      // Update position for next character
      if (shape.lastPoint) {
        currentX += shape.lastPoint.x + fontSize * 0.5;
      } else {
        currentX += fontSize;
      }
      
      maxHeight = Math.max(maxHeight, fontSize);
    }
  }

  return svg;
}

// Example usage:
async function main() {
  try {
    const font = await loadFont('font.shx');
    
    // Example 1: Basic rendering
    const svgElement1 = renderTextToSvg(font, "Hello", 12);
    document.body.appendChild(svgElement1);
    
    // Example 2: Auto-fit rendering with custom options
    const svgElement2 = renderTextToSvg(font, "Hello", 12, {
      width: 1000,
      height: 1000,
      strokeWidth: '0.1%',
      strokeColor: 'black',
      isAutoFit: true
    });
    document.body.appendChild(svgElement2);
    
    // Clean up resources when done
    font.release();
  } catch (error) {
    console.error('Error:', error instanceof Error ? error.message : 'An unknown error occurred');
  }
}

await main();
