-- @gabrielcrowe
-- an experiment in rotaty things
state = {
  players = {},
  tick = 0,
  mode = 0,
  timer = 0,
  shake = 0
}
playerColours = {
  {1,13,12,7},
  {2,8,14,15},
  {9,4,10,7},
  {0,5,6,7}
}
actorData = {
 tank = {1,2,3,4,5,6,7,8}
}
darken = {0,0,0,0,2,1,5,6,4,8,9,3,13,1,8,14}
fade_black={
 {0,0,0,0,0,0,0,0,0},
 {1,1,1,1,0,0,0,0,0},
 {2,2,2,1,1,1,0,0,0},
 {3,3,3,1,1,1,0,0,0},
 {4,4,2,2,2,1,0,0,0},
 {5,5,5,1,1,1,0,0,0},
 {6,13,13,13,5,5,1,1,0},
 {7,6,6,13,13,5,5,1,0},
 {8,8,2,2,2,2,0,0,0},
 {9,9,4,4,4,5,5,0,0},
 {10,9,9,4,4,5,5,2,0},
 {11,11,3,3,3,3,0,0,0},
 {12,12,12,3,1,1,1,1,0},
 {13,13,5,5,1,1,1,0,0},
 {14,14,4,2,2,2,1,1,0},
 {15,6,13,13,5,5,5,1,0}
}
gravity = 0.9;
function game_start()
 state.players = {
   { x=32, y=32, a=0.9, s=1, c=12, score=0, cool=0, alive=1 },
   { x=32, y=96, a=0.1, s=1, c=8, score=0, cool=0, alive=1 },
   { x=96, y=32, a=0.6, s=1, c=3, score=0, cool=0, alive=1 },
   { x=96, y=96, a=0.4, s=1, c=5, score=0, cool=0, alive=1 }
 }
end
parts = {};
function make_part(type,x,y,dx,dy)
 if(#parts<50) then
  p={}
  p.x = x
  p.y = y
  p.dx = dx
  p.dy = dy
  p.t = 0
  p.l = 4 --frames life
  p.c = 7 --default is white
  p.s = 1 --part
  p.s_v = 0
  p.g = { p.c }
  --cannon shot
  if(type==4) then
    p.s = 5
    p.s_v = -0.5
    p.l = 11
    p.g = { 10,9,9,4,4,5,5,2,0 }
  end
  --smallish explosion
  if(type==5) then
    p.s = 5
    p.s_v = -0.5
    p.l = 16
    p.dx = ld_x(rnd(10)/10,rnd(359))
    p.dy = ld_y(rnd(10)/10,rnd(359))
    p.g = { 7,0,7,0,10,9,9,4,4,5,5,2,0 }
  end
  --big explosion
  if(type==6) then
    p.s = 12
    p.s_v = -1
    p.l = 12
    p.dx = ld_x(rnd(10)/8,rnd(359))
    p.dy = ld_y(rnd(10)/8,rnd(359))
    p.g = { 7,0,7,0,10,9,9,4,4,5,5,2,0 }
  end
  --collect item
  if(type==7) then
    p.s = 3
    p.s_v = -0.3
    p.l = 9
    p.g = { 15,14,13,12,11,10,9,8,7 }
  end
  --upwards smoke
  if(type==8) then
    p.s = 5
    p.s_v = 0.3
    p.l = 10
    p.dx = rnd(1)-0.5
    p.dy = -0.5
    p.g = { 5,5,5,6,6,6,0,0,0,0 }
  end
  --large explosion flash
  if(type==9) then
    p.s = 20
    p.s_v = -2
    p.l = 6
    p.dx = 0
    p.dy = 0
    p.g = { 7,5 }
  end
  -- line based effects below
  if(type==104) then
    p.s = 0
    p.s_v = 0
    p.l = 6
    p.dx = ld_x(rnd(10)/5,rnd(359))
    p.dy = ld_y(rnd(10)/5,rnd(359))
    p.g = { 10,7,12 }
  end
  p.type = type
  add(parts,p)
  return p
 end
end
function update_part(p)
  if p.l != -1 then
    p.l -= 1
    if p.l == 0 then del(parts, p) end
  end
  p.s += p.s_v;
  p.t += 1
  p.x = p.x+p.dx
  p.y = p.y+p.dy
end
function draw_part(p)
  if(p.t>#p.g) p.t = 1
  if p.type > 99 then
   line(p.x,p.y,p.x+(p.dx*2),p.y+(p.dy*2),p.g[p.t])
  else
   circfill(p.x,p.y,p.s,p.g[p.t])
  end
end
bullets = {};
function make_bullet(x,y,dx,dy, owner)
  b={}
  b.x = x
  b.y = y
  b.dx = dx
  b.dy = dy
  b.l = 60 --frames life
  b.spr = 0 --sprite
  b.owner = owner
  add(bullets,b)
  return b
end
function update_bullet(b)
  if b.l > 0 then
    b.l -= 1
  else del(bullets, b) end
  if solid(b.x, b.y) then
   make_part(5,b.x, b.y, 0, -0.5)
   for bull=1,3 do
    make_part(104,b.x,b.y,0,0);
   end
   del(bullets, b)
   sfx(1)
  end
  b.x = b.x+b.dx
  b.y = b.y+b.dy
end
function draw_bullet(b)
 circfill(b.x,b.y+5,1,3)
 circfill(b.x,b.y+4,1,0)
  spr(b.spr,b.x-4,b.y-4)
end
function do_scores()
 c_size = 11;
--p1
circfill(1,1,c_size,0)
circfill(0,0,c_size,12)
print(state.players[1].score,1,1,7)
--p2
circfill(1,127,c_size,0)
circfill(0,128,c_size,8)
print(state.players[2].score,1,122,7)
--p3
circfill(127,1,c_size,0)
circfill(128,0,c_size,9)
print(state.players[3].score,120,1,7)
--p4
circfill(126,127,c_size,0)
circfill(127,128,c_size,5)
print(state.players[4].score,120,122,7)
end
function draw_player(data, i)
 if(state.players[i].alive==1) then
   --set colour pal
   colours = playerColours[i];
   pal(2, colours[1]);
   pal(8, colours[2]);
   pal(9, colours[3]);
   pal(10, colours[4]);
   x = flr(state.players[i].x)
   y = flr(state.players[i].y)
   a = state.players[i].a
   circfill(x+4,y+4,4,3)
   circfill(x+4,y+3,4,0)
  for i=1,6 do
   if (data[i]) then
    spra(a,data[i],x,y-i)
   end
  end
 end
end
function _init()
 palreset()
 game_start()
end
function _update()
  state.timer +=1;
  state.tick += 0.05; --globally abused timer
  if(state.tick>1) state.tick = 0;
  --super cheap camer shaker
  if(state.shake>0) then
   camera(flr(rnd(state.shake)),flr(rnd(state.shake)))
   state.shake -= 0.1;
  end
  for i=1,4 do
   if(state.players[i].cool>0) then state.players[i].cool -= 1 end --weapon cooldown reset
    handle_controls(i);
    if(state.players[i].alive == 1) then
    foreach(bullets, function(b)
     if(b.owner != i) then
     --is this bullet close to a player that did not fire it?
     if point_dist(b.x,b.y,state.players[i].x+4,state.players[i].y+4) < 4 then
      del(bullets, b)
      make_part(9,state.players[i].x+4,state.players[i].y+4,0,0);
      for b=1,10 do
       make_part(8,state.players[i].x+4,state.players[i].y+4,0,0);
       make_part(6,state.players[i].x+4,state.players[i].y+4,0,0);
      end
      --move player off camera
      sfx(3)
      state.players[i].alive = 0
      state.shake = 3; --cheap screen shake
      --now score for bulet owner
      state.players[b.owner].score += 1;
      end --bullet is close to player
     end --bullet is not mine
    end)
   end --player is alive
  end
  foreach(parts,update_part)
  foreach(bullets,update_bullet)
end
function _draw()
  --cls();
  map(0, 0, 0, 0, 16, 16)
  for i=1,4 do
    draw_player(actorData.tank, i);
  end
  palreset();
  foreach(bullets,draw_bullet)
  map(0, 16, 0, -6, 16, 16)
  foreach(parts,draw_part)
  if state.timer < 120 then
   for i=1,4 do
    draw_dialog("p-"..i,state.players[i].c,state.players[i].x,state.players[i].y)
   end
  end
do_scores()
  --print('cpu:'..stat(1)..'', 10, 18, 8)
  --print('bul:'..#bullets..'', 10, 10, 8)
end
function handle_controls(i)
if(state.players[i].alive == 1) then
 x_previous = flr(state.players[i].x);
 y_previous = flr(state.players[i].y);
 movespeed = 0;
 if(btn(0,i-1)) then state.players[i].a+=0.02 end --left
 if(btn(1,i-1)) then state.players[i].a-=0.02 end --right
 if(btn(2,i-1)) then
  movespeed = state.players[i].s;
 end --up
 if(btn(3,i-1)) then
  movespeed = -state.players[i].s;
 end --down
 if(btnp(4,i-1) and state.players[i].cool==0) then
  turret_x = state.players[i].x+4+ld_x(4,state.players[i].a);
  turret_y = state.players[i].y-2+ld_y(4,state.players[i].a);
  make_part(4,turret_x,turret_y, 0, -0.5)
  for b=1,5 do
   make_part(104,turret_x,turret_y,0,0);
  end
  make_bullet(turret_x,turret_y,ld_x(1.3,state.players[i].a),ld_y(1.3,state.players[i].a), i)
  state.players[i].cool = 15
  sfx(0)
  --movespeed = -state.players[i].s; --recoil?
 end
 if(movespeed!=0) then
  old_x = state.players[i].x + 4;
  old_y = state.players[i].y + 4;
  new_x = state.players[i].x + ld_x(movespeed,state.players[i].a) + 4;
  new_y = state.players[i].y + ld_y(movespeed,state.players[i].a) + 4
  if(solid_area(new_x, old_y,3,3)==false) then
   state.players[i].x = state.players[i].x + ld_x(movespeed,state.players[i].a)
  end
  if(solid_area(old_x, new_y,3,3)==false) then
   state.players[i].y = state.players[i].y + ld_y(movespeed,state.players[i].a)
  end
  --wall sparks scraping hack
  x_current = flr(state.players[i].x);
  y_current = flr(state.players[i].y);
  if x_current!=x_previous or y_current != y_previous then
   if solid(new_x+3,new_y) then make_part(104,new_x+3,new_y, 0, 0); sfx(2) end
   if solid(new_x-3,new_y) then make_part(104,new_x-3,new_y, 0, 0); sfx(2) end
   if solid(new_x,new_y+3) then make_part(104,new_x,new_y-2, 0, 0); sfx(2) end
   if solid(new_x,new_y-3) then make_part(104,new_x,new_y-6, 0, 0); sfx(2) end
  end
 end
 --other button is free for gameplay features
 --if(btn(5)) then e.spd=3; cam_dist=64; else e.spd=1; cam_dist=32; end
end --ifplayer is alive
end
function draw_dialog(text,col,x,y)
 dlgWidth = (#text * 4); --text string length, with padding left and right
 dlgHeight = 6; --text height and 1 px padding
 dlgX = x;
 dlgY = y;
 padd = 6;
 push = 7;
 center = 2;
 floaty = sin(state.tick)*4+4;
 rectfill(dlgX-1-center, dlgY-padd-push-1-floaty, dlgX+dlgWidth+1-center, dlgY+dlgHeight-padd-push+1-floaty, 0)
 rectfill(dlgX-center, dlgY-padd-push-floaty, dlgX+dlgWidth-center, dlgY+dlgHeight-padd-push-floaty, 7)
 spr(48,x,y-padd-floaty)
 print(text,x+1-center,y+1-padd-push-floaty,col)
end
-- bounding box collider
function collide(obj, o)
  if o.x+o.hit.x+o.hit.w > obj.x+obj.hit.x and
      o.y+o.hit.y+o.hit.h > obj.y+obj.hit.y and
      o.x+o.hit.x < obj.x+obj.hit.x+obj.hit.w and
      o.y+o.hit.y < obj.y+obj.hit.y+obj.hit.h then
    return true
  end
end
--tile colliders
function solid(x, y)
 val=mget(flr(x/8), flr(y/8))
 return fget(val, 0)
end
function solid_area(x,y,w,h)
 return
  solid(x-w,y-h) or
  solid(x+w,y-h) or
  solid(x-w,y+h) or
  solid(x+w,y+h)
end
--sprite draw on angle
function spra(angle,n,x,y,w,h,f_x,f_y)
  if w==nil or h==nil then
   w,h=8,8
  else
   w=w*8
   h=h*8
  end
  local diag,w,h=flr(sqrt(w*w+h*h))/2,w/2,h/2
  f_x,f_y=f_x and -1 or 1,f_y and -1 or 1
  local cosa,sina,nx,ny=cos(angle),sin(angle),n%16*8,flr(n/16)*8
  for i=-diag,diag do
   for j=-diag,diag do
    local ox,oy=(cosa*i + sina*j),(cosa*j - sina*i)
    if ox==mid(-w,ox,w) and oy==mid(-h,oy,h) then
     local col=sget(ox+w+nx,oy+h+ny)
     if col!=14 then
      --if(f_x*i+w>5) then col = darken[col]; end --shading and light hack
      pset(x+f_x*i+w,y+f_y*j+h,col)
     end
    end
   end
  end
 end
 function palreset()
  pal()
  palt(14, true) -- beige color as transparency is true
  palt(0, false) -- black color as transparency is false
 end
 function ceil(num) return -flr(-num) end
 function ld_x(len,dir) return cos(dir)*len end
 function ld_y(len,dir) return sin(dir)*len end
 function point_ang(cx, cy, ex, ey) return atan2(cx-ex, cy-ey) end
 function point_dist(x1,y1,x2,y2)
   x3 = abs(x2 - x1)
   y3 = abs(y2 - y1)
   return sqrt((x3*x3)+(y3*y3))
 end