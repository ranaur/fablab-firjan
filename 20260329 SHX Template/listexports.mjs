// In a file, e.g., listExports.mjs

import * as myModule from '@mlightcad/shx-parser';

console.log("Exports of the module:");
// Use Object.keys to get an array of exported names
Object.keys(myModule).forEach(exportName => {
    console.log(`- ${exportName}`);
    // You can also inspect the type of the export
    // console.log(`  Type: ${typeof myModule[exportName]}`);
});
