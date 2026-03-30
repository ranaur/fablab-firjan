import { readFile } from 'fs/promises';
import { ShxFont } from '@mlightcad/shx-parser';

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
