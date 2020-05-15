var fs = require("fs-sync");
let PNG = require("pngjs").PNG;

const gameSource = "./build/test.p8";
const srcPath = "./src/";
const p8 = fs.read(gameSource);
const lines = p8.split("\n");
const palette = [
  [0, 0, 0],
  [29, 43, 83],
  [126, 37, 83],
  [0, 135, 81],
  [171, 82, 54],
  [95, 87, 79],
  [194, 195, 199],
  [255, 241, 232],
  [255, 0, 77],
  [255, 163, 0],
  [255, 236, 39],
  [0, 228, 54],
  [41, 173, 255],
  [131, 118, 156],
  [255, 119, 168],
  [255, 204, 170],
];
let topData = [];
let luaData = [];
let gfxData = [];
let lblData = [];
let gffData = [];
let mapData = [];
let sfxData = [];

let codePart = "top";

lines.forEach((line) => {
  if (line.includes("__lua__")) codePart = "lua";
  if (line.includes("__gfx__")) codePart = "gfx";
  if (line.includes("__label__")) codePart = "lbl";
  if (line.includes("__gff__")) codePart = "gff";
  if (line.includes("__map__")) codePart = "map";
  if (line.includes("__sfx__")) codePart = "sfx";

  if (
    line !== "" &&
    line !== "__lua__" &&
    line !== "__gfx__" &&
    line !== "__label__" &&
    line !== "__gff__" &&
    line !== "__map__" &&
    line !== "__sfx__"
  ) {
    switch (codePart) {
      case "top":
        topData.push(line);
        break;
      case "lua":
        luaData.push(line);
        break;
      case "gfx":
        gfxData.push(line);
        break;
      case "lbl":
        lblData.push(line);
        break;
      case "gff":
        gffData.push(line);
        break;
      case "map":
        mapData.push(line);
        break;
      case "sfx":
        sfxData.push(line);
        break;
      default:
    }
  }
});

console.log("top:", topData.length);
console.log("lua:", luaData.length);
console.log("gfx:", gfxData.length);
console.log("lbl:", lblData.length);
console.log("gff:", gffData.length);
console.log("map:", mapData.length);
console.log("sfx:", sfxData.length);

function hex2dec(hexstr) {
  return parseInt(Number("0x" + hexstr), 10);
}
function pico8tojson(data, returnString = true) {
  const jsonData = [];
  const dataLines = data;
  dataLines.forEach((line) => {
    let lineArray = line.match(/.{1,1}/g);
    lineArray = lineArray.map((hex) => hex2dec(hex));
    jsonData.push(lineArray);
  });
  if (returnString) {
    return JSON.stringify(jsonData);
  } else {
    return jsonData;
  }
}

fs.write(srcPath + "top.txt", topData.join("\n"));
fs.write(srcPath + "code.lua", luaData.join("\n"));
fs.write(srcPath + "gfx.json", pico8tojson(gfxData));
fs.write(srcPath + "lbl.json", pico8tojson(lblData));
fs.write(srcPath + "gff.json", pico8tojson(gffData));
fs.write(srcPath + "map.json", pico8tojson(mapData));
fs.write(srcPath + "sfx.json", pico8tojson(sfxData));

const gfxObject = pico8tojson(gfxData, false);

// write png image of sprite area
let newfile = new PNG({ width: 127, height: 63 });
for (let y = 0; y < newfile.height; y++) {
  for (let x = 0; x < newfile.width; x++) {
    let idx = (newfile.width * y + x) << 2;
    let col;
    // console.log(palette)
    if (gfxData.length === 32 && y > 31) {
      col = palette[0];
    } else {
      col = palette[gfxObject[y][x]];
    }
    newfile.data[idx] = col[0]; // red
    newfile.data[idx + 1] = col[1]; // green
    newfile.data[idx + 2] = col[2]; // blue
    newfile.data[idx + 3] = 0xff; // alpha
  }
}

let buff = PNG.sync.write(newfile);
fs.write(__dirname + "/gfx.png", buff);
