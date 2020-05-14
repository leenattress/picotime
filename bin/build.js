var fs = require("fs-sync");

let fileData = "";
const gameTarget = "./build/built.p8";
const srcPath = "./src/";
const top = fs.read(srcPath + "top.txt");
const lua = fs.read(srcPath + "code.lua");
const gfx = fs.read(srcPath + "gfx.json");
const gff = fs.read(srcPath + "gff.json");
const map = fs.read(srcPath + "map.json");
const sfx = fs.read(srcPath + "sfx.json");

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

fileData = `${top}

__lua__
${lua}

__gfx__
${jsontopico8(gfx)}

__gff__
${jsontopico8(gff)}

__map__
${jsontopico8(map)}

__sfx__
${jsontopico8(sfx)}
`;

fs.write(gameTarget, fileData);
