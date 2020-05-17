var fs = require("fs-sync");
//PNG = require("pngjs").PNG;
var Jimp = require("jimp");

let fileData = "";
const gameTarget = "./build/built.p8";
const srcPath = "./src/";

// get the pgn images and unpack them into json objects
pngtojson(srcPath + "gfx.png", srcPath + "gfx.json");

const top = fs.read(srcPath + "top.txt");
const lua = fs.read(srcPath + "code.lua");
const gfx = fs.read(srcPath + "gfx.json");
const lbl = fs.read(srcPath + "lbl.json");
const gff = fs.read(srcPath + "gff.json");
const map = fs.read(srcPath + "map.json");
const sfx = fs.read(srcPath + "sfx.json");
const mus = fs.read(srcPath + "mus.json");

function jsontopico8(data) {
  let strData = "";
  const jsonData = JSON.parse(data);
  jsonData.forEach((row) => {
    row.forEach((item) => {
      strData += item.toString(16);
    });
    strData += "\n";
  });

  return strData;
}

async function pngtojson(pngPath, jsonPath) {
  console.log(pngPath);
  try {
    const image = await Jimp.read(pngPath);
    // const buffer = fs.read(pngPath);
    // const png = PNG.sync.read(buffer);
    console.log(image.bitmap.width, image.bitmap.height, image.bitmap.data);
    image.scan(0, 0, image.bitmap.width, image.bitmap.height, function (
      x,
      y,
      idx
    ) {
      // x, y is the position of this pixel on the image
      // idx is the position start position of this rgba tuple in the bitmap Buffer

      var red = this.bitmap.data[idx + 0];
      var green = this.bitmap.data[idx + 1];
      var blue = this.bitmap.data[idx + 2];
      var alpha = this.bitmap.data[idx + 3];
      console.log(red, green, blue, alpha);
    });
  } catch (error) {
    throw error;
  }
  // fs.write(jsonPath, png);
}

fileData = `${top}

__lua__
${lua}

__gfx__
${jsontopico8(gfx)}

__lbl__
${jsontopico8(lbl)}

__gff__
${jsontopico8(gff)}

__map__
${jsontopico8(map)}

__sfx__
${jsontopico8(sfx)}

__music__
${jsontopico8(mus)}
`;

fs.write(gameTarget, fileData);
