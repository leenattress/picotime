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
let musData = [];

let codePart = "top";

lines.forEach((line) => {
  if (line.includes("__lua__")) codePart = "lua";
  if (line.includes("__gfx__")) codePart = "gfx";
  if (line.includes("__label__")) codePart = "lbl";
  if (line.includes("__gff__")) codePart = "gff";
  if (line.includes("__map__")) codePart = "map";
  if (line.includes("__sfx__")) codePart = "sfx";
  if (line.includes("__music__")) codePart = "mus";

  if (
    line !== "" &&
    line !== "__lua__" &&
    line !== "__gfx__" &&
    line !== "__label__" &&
    line !== "__gff__" &&
    line !== "__map__" &&
    line !== "__sfx__" &&
    line !== "__music__"
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
      case "mus":
        musData.push(line);
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
console.log("mus:", musData.length);

function hex2dec(hexstr) {
  if (hexstr === " ") {
    return " ";
  }
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

function writePng(gfxObject, file, forceHeight = 128) {
  const width = gfxObject[0].length;
  const height = Math.min(gfxObject.length, forceHeight);
  const newfile = new PNG({ width, height });
  for (let y = 0; y < height; y++) {
    for (let x = 0; x < width; x++) {
      let idx = (width * y + x) << 2;
      let col;
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
  fs.write(file, buff);
}

fs.write(srcPath + "top.txt", topData.join("\n"));
fs.write(srcPath + "code.lua", luaData.join("\n"));
fs.write(srcPath + "gfx.json", pico8tojson(gfxData));
fs.write(srcPath + "lbl.json", pico8tojson(lblData));
fs.write(srcPath + "gff.json", pico8tojson(gffData));
fs.write(srcPath + "map.json", pico8tojson(mapData));
fs.write(srcPath + "sfx.json", pico8tojson(sfxData));
fs.write(srcPath + "mus.json", pico8tojson(musData));

const gfxObject = pico8tojson(gfxData, false);
writePng(gfxObject, srcPath + "gfx.png", 64);

const lblObject = pico8tojson(lblData, false);
writePng(lblObject, srcPath + "lbl.png");