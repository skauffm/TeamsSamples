const pkg = require("./package.json")
require("esbuild").build({
    entryPoints: ['server.js'],
    bundle: true,
    platform: 'node',
    outfile: 'dist/index.js'
})
.then((r) => {
    console.log(`Build succeeded.`);
})
.catch((e) => {
    console.log("Error building:", e.message);
    process.exit(1);
});