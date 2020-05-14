var fs = require("fs-sync");

const gameSource = "./build/game.p8";
const srcPath = "./src/";
const p8 = fs.read(gameSource);
const lines = p8.split("\n");

let topData = [];
let luaData = [];
let gfxData = [];
let gffData = [];
let mapData = [];
let sfxData = [];

let codePart = "top";

lines.forEach((line) => {
  if (line.includes("__lua__")) codePart = "lua";
  if (line.includes("__gfx__")) codePart = "gfx";
  if (line.includes("__gff__")) codePart = "gff";
  if (line.includes("__map__")) codePart = "map";
  if (line.includes("__sfx__")) codePart = "sfx";

  if (
    line !== "" &&
    line !== "__lua__" &&
    line !== "__gfx__" &&
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
console.log("gff:", gffData.length);
console.log("map:", mapData.length);
console.log("sfx:", sfxData.length);

function hex2dec(hexstr) {
    return parseInt(Number("0x" + hexstr), 10);
}
function pico8tojson(data) {
  const jsonData = [];
  const dataLines = data;
  dataLines.forEach((line) => {
    let lineArray = line.match(/.{1,1}/g);
    lineArray = lineArray.map((hex) => hex2dec(hex));
    jsonData.push(lineArray);
  });
  return JSON.stringify(jsonData);
}

fs.write(srcPath + "top.txt", topData.join("\n"));
fs.write(srcPath + "code.lua", luaData.join("\n"));
fs.write(srcPath + "gfx.json", pico8tojson(gfxData));
fs.write(srcPath + "gff.json", pico8tojson(gffData));
fs.write(srcPath + "map.json", pico8tojson(mapData));
fs.write(srcPath + "sfx.json", pico8tojson(sfxData));
