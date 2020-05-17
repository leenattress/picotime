pico-8 cartridge // http://www.pico-8.com
version 18

__lua__
-- alien breed demake
-- by @gabrielcrowe
-- [ warning: main power low ]
-- [ unable to send message ]
-- [ transponder offline ]
-- [ command// re-route,
-- [ secondary power ]
-- [ transponder online ]
-- [ message begin// ]
--
-- i've managed to get some
-- power to my transponder in
-- order to send this message
-- to anybody who is listening.
--
-- i am a soldier in the
-- interstellar marine corps.
-- my ship, the imc durham was
-- overrun by something we
-- picked up on ix538. some
-- wicked fast alien creatures
-- with big teeth and ferocious
-- appetites. these things came
-- bursting out of the the decks
-- where they had been hiding
-- below. they moved quick
-- and bit hard. everybody was
-- butchered, we had to scuttle
-- the ship.
--
-- i was sorry to see her go.
--
-- i made it to a shuttle and
-- got away. as i was leaving i
-- detected a distress signal.
-- i'll attach it to this
-- message.
--
-- [attachment]
-- \\dstrs_sgnl_relay_#6527
-- "anybody out there? this is
-- the mining ship callisto.
-- we have an alien on board.
-- its murdered half the crew
-- and we are barricaded in
-- the engine room. they are
-- smart. very smart. they
-- have set the ship on
-- course for earth. somebody
-- needs to blow us out of
-- the sky. if these things
-- get to earth then it's all
-- over for the human race."
--    //transmission_end
-- [/attachment]
--
-- so as you can probably
-- tell i'm on my way to
-- the callisto. i've
-- completely run out of
-- ammo for my rifle. i
-- can only hope that i
-- can find some ammo when
-- i breach the docking bay
-- or this is going to be one
-- hell of a short mission.
--
-- i've accessed the computer
-- on the callisto and i
-- know that their main power
-- is offline. the transwarp
-- drive is powered completely
-- from the backup generators,
-- positioned throughout
-- the ship. if i can just
-- get the them and shut
-- them all down then the
-- queen feeding off the
-- power will be much
-- weaker and easier to
-- send straight to hell.
--
-- i've remotely powered
-- the lights in the shuttle
-- bay and i've got my access
-- codes the the backup
-- consoles ready.
--
-- hopefully i can get to
-- the deck lift before the
-- queen reaches earth.
-- i'm going to take down
-- every one of these ugly
-- green bastards. if i
-- don't make it, tell my
-- family...
--
-- i love them.
--
-- [ /message end ]
cartdata("crowe_hmg_1")
function _init()
difficulty = 0.5;
  timr = 0
  pody=0;
  -- stars
  stars={}
  s_col={1,5,6,7}
  s_mult = 1;
  for star=0,100 do
    s={}
    s.x = rnd(128)
    s.y = rnd(128)
    s.px = s.x;
    s.py = s.y;
    s.col = s_col[flr(rnd(4))+1]
    add(stars,s)
  end
  title_screen = true;
  speedrun_frame = 0
  speedrun_s = 0;
  speedrun_m = 0;
  finish=false
  escaped=0
  dead = false;
  gover_t = 0;
  cd = false;
  cd_t = 60;
  cd_sec = 0;
  intex_num = 0;
  action_t = 0;
  alert_t = 0;
  dlg_txt = ""
  dlg_y = 0
  weapon_upgrade = false
  id=0
  max_enemies = 10
  c1_x=0
  c1_y=0
  c2_x = 64
  c2_y = 64
  shake=0;
  c1_x_s=0
  c1_y_s=0
  c2_x_s=0
  c2_y_s=0
  ammo = 0
  t_spawn_lg = 102
  t_spawn_sm = 32
  t_key = 40;
  t_ammo = 22;
  t_heal = 23;
  t_dr1 = 114;
  t_dr2 = 115;
  t_blnk = 97
  e_count = 0; --enemy count
  actor = {}
  parts = {}
  spawners = {}
  bosses = {}
  boss_spawned = false;
  exists_eye1 = true; exists_eye2 = true; exists_eye3 = true;
  key_n = 0
  hurting = 0
  darkness = 8
  bld = { 98,99,100,101 }
  log = {0,0,0,0,0,0,0,0,0,0,1,2,3,4,5,6}
  room_cols = {
    {0,0,0,4,4,4,4,4,4,0,0,0,0,0,0,0},
    {0,0,0,4,4,4,4,4,4,0,0,0,0,0,0,0},
    {0,0,0,0,0,0,4,4,4,0,0,0,0,0,0,0},
    {0,0,0,0,0,0,4,4,0,0,0,0,0,0,0,0},
    {0,0,0,4,0,0,0,4,0,0,0,0,0,0,0,0},
    {0,0,0,4,0,0,0,0,0,0,0,0,0,0,0,0},
    {3,3,3,3,3,0,0,0,0,0,0,0,0,0,0,0},
    {3,3,3,3,3,0,0,0,0,0,0,0,0,0,0,0}
  }
  fade_red ={
   {0,0,0,2,2,2,2,8,8},
   {1,1,2,2,2,2,2,8,8},
   {2,2,2,2,2,8,8,8,8},
   {3,5,5,5,2,2,4,8,8},
   {4,4,4,4,4,8,8,8,8},
   {5,2,2,2,4,4,8,8,8},
   {6,6,14,14,14,14,8,8,8},
   {7,15,15,14,14,14,14,8,8},
   {8,8,8,8,8,8,8,8,8},
   {9,9,9,9,4,8,8,8,8},
   {10,10,9,9,9,4,8,8,8},
   {11,11,5,5,5,4,4,4,8},
   {12,12,13,13,13,13,2,8,8},
   {13,13,13,4,4,4,8,8,8},
   {14,14,14,14,8,8,8,8,8},
   {15,15,14,14,14,14,8,8,8}
  }
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
   {10,9,9,4,4,5,5,0,0},
   {11,11,3,3,3,3,0,0,0},
   {12,12,12,3,1,1,1,1,0},
   {13,13,5,5,1,1,1,0,0},
   {14,14,4,2,2,2,1,1,0},
   {15,6,13,13,5,5,5,1,0}
  }
  auto_tile()
  music(0)
 -- make player top left
 --pl = mk_actor(0,84,44) -- 3,3
 set_dlg('find consoles, shut down engines',30);
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
function fade(i,tbl,base)
 for c=0,15 do
  if flr(i+1)>=8 then
   pal(c,base)
  else
   pal(c,tbl[c+1][flr(i+1)])
  end
 end
end
function count_enemies()
  e_count = 0;
  foreach(actor, function(b)
    if(b.enemy == true) e_count+=1
  end)
end
function set_dlg(txt,t)
  dlg_txt = txt
  dlg_y = t
end
function mk_actor(mode, x, y)
 a={}
 a.x = x
 a.y = y
 a.f_x = 0
 a.f_y = 0
 a.spr = 16
 a.frame = 0
 a.t = 0
 a.inertia = 0.5
 a.enemy = false
 a.mode = mode
 a.hit = {x=0, y=0, w=8/8, h=8/8}
 a.dx = 0
 a.dy = 0
 a.fac = 0
 a.life = -1
 a.is_plr = false
 a.nrg = 100
 a.nrg_max = 100
 a.id = id
 id = id+1
 a.perm = false;
 a.eyenum = 0;
 a.w = 0.1
 a.h = 0.1
 add(actor,a)
 return a
end
function end_game()
music(-1);
c1_x=0;c1_y=0;
camera(0,0)
timr +=1;
foreach(parts,draw_part)
if(timr<100) then
  mk_part(5,64,64);
  if(timr%2==0) circfill(64,64,10+rnd(10),7)
  spr(38,64-9,64-10)
  spr(39,64,64-8)
  spr(54,64-10,64)
  spr(55,64,64)
end
if(timr==1) sfx(15)
if(timr==100) mk_part(9,64,64);
if(timr>100 and escaped==1) then
  pody += 0.2;
  spr(56,64+pody,64)
  pset(64+3+pody,64+4,rnd(16))
end
print('[ self destruct enabled ]',2,2,8)
print('[ threat eliminated ]',2,10,8)
print('thank you soldier',2,90,7)
if(timr<100 or escaped==0) print('you will be remembered',2,90,7)
if(timr>100 and escaped==1)  print('you made it!!',2,90,rnd(16))
print('- mission complete in:',2,100,11)
timestring = 'speedrun- '..speedrun_m..":"..speedrun_s..":"..speedrun_frame
print(timestring,2,110,11)
 if(timr>300) set_dlg('insert disk 2...',30);
end
function mk_part(type,x,y)
 p={}
 p.x = x
 p.y = y
 p.dx = ld_x(rnd(10)/3,rnd(359))
 p.dy = ld_y(rnd(10)/3,rnd(359))
 p.t = 0
 p.l = 4 --frames life
 p.c = 7 --default is white
 p.s = 1 --part
 p.s_v = 0
 p.g = { p.c }
 --bright little sparkles
 if(type==4) then
   p.s = 2
   p.s_v = 0.25
   p.l = 4
   p.g = { 7,10,7,10 }
 end
 --smallish explosion
  if(type==5) then
    p.s = 10
    p.s_v = -0.5
    p.l = 16
    p.dx = ld_x(rnd(10)/5,rnd(359))
    p.dy = ld_y(rnd(10)/5,rnd(359))
    p.g = { 5,5,6,5,6,5,6,9,10,10 }
  end
--green blood
 if(type==6) then
   p.s = 5
   p.dx = ld_x(rnd(10)/3,rnd(359))
   p.dy = ld_y(rnd(10)/3,rnd(359))
   p.l = 6
   p.s_v = -0.75
   p.g = { 11,11,3,3,5,1 }
 end
 --collect item
 if(type==7) then
   p.s = 3
   p.s_v = -0.5
   p.l = 6
   p.g = { 12,8 }
 end
 --red blood
  if(type==8) then
    p.s = 4
    p.s_v = -0.5
    p.g = { 8 }
  end
 if(type==9) then
   p.s = 64
   p.s_v = -2
   p.l = 10
   p.dx = 0; p.dy = 0;
   p.g = { 5,5,6,5,6,5,6,9,10,10 }
 end
 p.type = type
 add(parts,p)
 return p
end
function mk_boss(x,y)
 b={}
 b.x = x
 b.y = y
 b.active = false
 b.ganked = false
 b.nrg = 2000;
 b.gt = 0; --timer global
 b.t = 0; --timer tentacle
 b.a1x = x-2; --arm x
 b.a1y = y-2; --arm y
 b.a1 = true; --alive/dead
 b.t1 = 0; --fire_timer
 a1xr = 0;
 a1yr = 0;
 b.a2x = x-3; --arm 2
 b.a2y = y-0;
 b.a2 = true;
 b.t2 = 0;
 a2xr = 0;
 a2yr = 0;
 b.a3x = x-2; --arm 3
 b.a3y = y+2;
 b.a3 = true;
 b.t3 = 0;
 a3xr = 0;
 a3yr = 0;
 --eyes
 eye1 = mk_actor(0,b.a1x,b.a1y);
 eye1.spr = 60;
 eye1.enemy = true;
 eye1.nrg = 500;
 eye1.perm = true;
 eye1.eyenum = 1;
 eye2 = mk_actor(0,b.a2x,b.a2y);
 eye2.spr = 60;
 eye2.enemy = true;
 eye2.nrg = 500;
 eye2.perm = true;
 eye2.eyenum = 2;
 eye3 = mk_actor(0,b.a3x,b.a3y);
 eye3.spr = 60;
 eye3.enemy = true;
 eye3.nrg = 500;
 eye3.perm = true;
 eye3.eyenum = 3;
 if(type==1) b.hit = {x=0, y=0, w=2, h=2}
 add(bosses,b)
 return b
end
function mk_spawn(freq,type,x,y)
 s={}
 s.x = x
 s.y = y
 s.type = type
 s.dist = 0
 s.freq = freq+rnd(20) --in frames
 s.t = freq --start countdown
 s.active = true
 s.ganked = false
 s.nrg = 200;
 if(type==1) s.hit = {x=0, y=0, w=2, h=2}
 if(type==2) s.hit = {x=0, y=0, w=1, h=1}
 add(spawners,s)
 return s
end
function p_burst(type,x,y,num)
  for i=0,num do
    part = mk_part(type,x,y)
  end
end
function collide(obj, o)
  if o.x+o.hit.x+o.hit.w > obj.x+obj.hit.x and
      o.y+o.hit.y+o.hit.h > obj.y+obj.hit.y and
      o.x+o.hit.x < obj.x+obj.hit.x+obj.hit.w and
      o.y+o.hit.y < obj.y+obj.hit.y+obj.hit.h then
    return true
  end
end
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
     if(f_x*i+w>5 or f_y*j+h>5) then colt=fade_black[col+1]; col=colt[5]; end
     pset(x+f_x*i+w,y+f_y*j+h,col)
     --fade()
    end
   end
  end
 end
end
function blood(x, y)
 val=mget(x, y)
 if(val==t_blnk) mset(x,y,bld[flr(rnd(#bld))+1])
end
function security(x,y)
  local dr_fnd = false
  for i=-4,4 do
    for j=-4,4 do
      dr = mget(x+i,y+j)
      if(dr==24 or dr==25) then mset(x+i,y+j,t_blnk); dr_fnd = true; p_burst(7,(x+i)*8,(y+j)*8,20) end
    end
  end
end
function intex_go(x,y)
  intex_num += 1;
  if(intex_num>=10) then cd = true; music(4); open_drs(); end
  s_mult = 0;
  shake = 10;
  set_dlg(intex_num..'/10 console deactivated',30);  -- to do: count consoles
  p_burst(5,(x*8),(y*8)-4,15)
  bm = mk_part(9,(x*8),(y*8)-4);
  bm.s = 32
   bm.s_v = -2
   bm.l = 8
  sfx(12);
  for i=-4,4 do
    for j=-4,4 do
      dr = mget(x+i,y+j)
      if(dr==24 or dr==25) then mset(x+i,y+j,t_blnk); dr_fnd = true; set_dlg('dr hacked',30); p_burst(7,(x+i)*8,(y+j)*8,20) end
    end
  end
  darkness=8;
end
function gameover()
    rectfill(c1_x, c1_y+32, c1_x+128, c1_y+96, 8)
    line(c1_x, c1_y+32, c1_x+128, c1_y+32, 7)
    line(c1_x, c1_y+96, c1_x+128, c1_y+96, 7)
    print('-=# game over #=-',c1_x+30,c1_y+60,7)
    print('press \151 to restart',c1_x+26,c1_y+68,14)
    timestring = 'speedrun- '..speedrun_m..":"..speedrun_s..":"..speedrun_frame
    print('you lasted',c1_x+42,c1_y+78,14)
    print(timestring,c1_x+20,c1_y+88,14)
    if(btn(5)) run();
end
function obj_here(x, y)
  menuitem(1)
  --menuitem(2)
intex=false;
sec=false;
 val=mget(x, y)
 val_u=mget(x, y-1)
 local get = false
 if(val==t_key) key_n = key_n + 1; get = true; set_dlg('+1 key',20); sfx(4)
 if(val==t_ammo) ammo = 100; get = true; set_dlg('ammo refilled',20); sfx(9);
 if(val==t_heal) pl.nrg = 100; get = true; set_dlg('health up',20); sfx(11);
 if(val==104 or val==105 or val==120 or val==121) then escaped=1; finish=true; end
 if(val_u==117) intex=true;
 if(val_u==117 or val_u==116) sec=true;
 if(val==37) then
   weapon_upgrade = true;
   set_dlg('weapon upgraded!',20);
   sfx(9)
   --mset(x, y, t_blnk);
   p_burst(4,x*8,y*8,10)
 end
 --
-- if(sec==true) then
--   menuitem(2,"* hack dr",function() security(x,y) end)
--end
 if(intex==true) then
   if(btn(4)) then action_t+=1; else action_t=0; end
   if(action_t==100) then mset(x, y-1, 116); intex_go(x,y); action_t=0; end
   if (intex_num==0) set_dlg('hold \142 to disable power',20);
   --menuitem(1,"* disable power",function() mset(x, y-1, 116) intex_go(x,y) end)
 end
if(get==true) then
  mset(x, y, t_blnk)
  p_burst(7,x*8,y*8,10)
end
   v_u=mget(x, y-1)
   v_d=mget(x, y+1)
   v_l=mget(x-1, y)
   v_r=mget(x+1, y)
   if v_u==t_dr1 or v_u==t_dr2 then
     if key_n>0 then sfx(8); mset(x, y-1, t_blnk); key_n-=1; end
   end
   if v_d==t_dr1 or v_d==t_dr2 then
     if key_n>0 then sfx(8); mset(x, y+1, t_blnk); key_n-=1; end
   end
   if v_l==t_dr1 or v_l==t_dr2 then
     if key_n>0 then sfx(8); mset(x-1, y, t_blnk); key_n-=1; end
   end
   if v_r==t_dr1 or v_r==t_dr2 then
     if key_n>0 then sfx(8); mset(x+1, y, t_blnk); key_n-=1; end
   end
end
function solid(x, y)
 val=mget(x, y)
 return fget(val, 1)
end
function solid_area(x,y,w,h)
 return
  solid(x-w,y-h) or
  solid(x+w,y-h) or
  solid(x-w,y+h) or
  solid(x+w,y+h)
end
function move_part(p)
  if p.l != -1 then
    p.l -= 1
    if p.l == 0 then del(parts, p) end
  end
  p.s += p.s_v;
  p.t += 1
  p.x = p.x+p.dx
  p.y = p.y+p.dy
end
function boss_bullet(x,y)
  local enemy = mk_actor(0,x,y);
  enemy.spr = 11;
  enemy.enemy = true;
  enemy.nrg = 20; --bullet health
  enemy.fac = point_ang(pl.x, pl.y,x, y)
  enemy.dx = ld_x(0.1,enemy.fac)
  enemy.dy = ld_y(0.1,enemy.fac)
  sfx(22)
end
function move_boss(b)
  if(boss_spawned) then
    local lx = b.x*8
    local ly = b.y*8
    b.t += 0.02;
    b.t1 += 0.01;
    b.t2 += 0.015;
    b.t3 += 0.02;
    if(b.t>1) then
      b.t=0; b.gt+=1;
      --local enemy = mk_actor(0,lx/8,(ly+4)/8); enemy.spr = 33; enemy.enemy = true; enemy.nrg = 75*difficulty;
    end
    a1xr = b.a1x+ld_x(0.6,b.t);
    a1yr = b.a1y+ld_y(0.6,b.t);
    if(exists_eye1 and b.t1>1) then
      boss_bullet(a1xr,a1yr)
      b.t1 = 0;
    end
    if(exists_eye1) then eye1.x=a1xr+0.5; eye1.y=a1yr+0.5; end
    a2xr = b.a2x+ld_x(0.6,b.t);
    a2yr = b.a2y+ld_y(0.6,b.t);
    if(exists_eye2 and b.t2>1) then
      boss_bullet(a2xr,a2yr)
      b.t2 = 0;
    end
    if(exists_eye2) then eye2.x=a2xr+0.5; eye2.y=a2yr+0.5; end
    a3xr = b.a3x+ld_x(0.6,b.t);
    a3yr = b.a3y+ld_y(0.6,b.t);
    if(exists_eye3 and b.t3>1) then
      boss_bullet(a3xr,a3yr)
      b.t3 = 0;
    end
    if(exists_eye3) then eye3.x=a3xr+0.5; eye3.y=a3yr+0.5; end
    if(exists_eye1==false and exists_eye2==false and exists_eye3==false) then
      del(bosses,b)
      mset(113,43,110)
      mset(113,44,110) --clear the way
    end
  end --boss_spawned
end
function move_spawner(s)
  if(s.ganked == false and s.nrg<0) then
    s.ganked = true;
    p_burst(5,(s.x*8)+4,(s.y*8)+4,10)
    del(spawners,s)
  end
  if(s.ganked == false) then
    s.dist = point_dist(s.x,s.y,pl.x,pl.y)
    if(s.dist<10) then s.active = true else s.active = false end
    if (s.active == true) then
        s.t -= 1
        if s.t <= 0 then
          s.t = flr(s.freq / difficulty)
          count_enemies()
          if(e_count < max_enemies) then
            if(s.type==1) then local enemy = mk_actor(0,s.x+1,s.y+1); enemy.spr = 33; enemy.enemy = true; enemy.nrg = 75*difficulty; end
            if(s.type==2) then local enemy = mk_actor(0,s.x+0.5,s.y+0.5); enemy.spr = 49; enemy.enemy = true; enemy.nrg = 25*difficulty; end
            sfx(6)
          end
      end
    end
  end
end
function move_actor(a)
  --item has life
  if a.life != -1 then
    a.life -= 1
    if a.life == 0 then del(actor, a) end
  end
  if a.is_plr == true then
    obj_here(a.x, a.y)
  end
  if a.mode == 1 then
    if(weapon_upgrade) mk_part(4,a.x*8,a.y*8)
    foreach(spawners, function(s)
      if(s.ganked == false) then
        if collide(a, s) then
          if(weapon_upgrade) then
            s.nrg -= 100;
          else
            s.nrg -= 20;
          end
          p_burst(6,(s.x*8)+4,(s.y*8)+4,5)
          del(actor, a)
        end
      end
    end)
  end
  --enemy related
  if a.enemy == true then
    if(point_dist(a.x,a.y,pl.x,pl.y)>12 and a.perm==false) del(actor, a)
    if a.nrg < 0 then
      del(actor, a)
      sfx(3)
      p_burst(6,a.x*8,a.y*8,10)
      difficulty+=0.05;
      if(a.eyenum==1) exists_eye1 = false;
      if(a.eyenum==2) exists_eye2 = false;
      if(a.eyenum==3) exists_eye3 = false;
    end
    if(a.spr != 11) then
      if pl.x < a.x then a.dx = -0.1*difficulty end
      if pl.x > a.x then a.dx = 0.1*difficulty end
      if pl.y < a.y then a.dy = -0.1*difficulty  end
      if pl.y > a.y then a.dy = 0.1*difficulty end
      a.fac = point_ang(pl.x, pl.y, a.x, a.y)
    end
      foreach(actor, function(b)
        if collide(a, b) and a.id != b.id then
          if(a.spr!=11) then
            if(b.spr!=11) then
              if a.x >= b.x then b.dx = -0.2; a.dx = 0.1; else b.dx = 0.2; a.dx = -0.2; end
              if a.y >= b.y then b.dy = -0.1; a.dy = 0.2 else b.dy = 0.1; a.dy = -0.1; end
            end
          end
            if b.is_plr == true then
              p_burst(8,b.x*8,b.y*8,10)
              sfx(10)
              if(a.spr==11) then
                b.nrg = b.nrg - 5;
              else
                b.nrg = b.nrg - 3;
              end
              hurting = 7 -- for screen flash
              blood(b.x, b.y)
              difficulty-=0.1;
              if(a.spr==11) then
                del(actor, a) --special case, boss bullet
              end
            end
        end
        if b.mode == 1 then
          if (collide(a, b)) then
            del(actor, b)
            if(weapon_upgrade) then
              a.nrg = a.nrg - 66;
            else
              a.nrg = a.nrg - 34;
            end
            sfx(7)
            p_burst(6,a.x*8,a.y*8,5)
          end
        end
      end)
  else
    if a.nrg < 0 then
      del(actor, a)
      --sfx(3)
      dead=true;
      p_burst(6,a.x*8,a.y*8,10)
      sfx(42)
    end
  end
  if(a.spr == 11) then
    a.x += a.dx
  else
    if not solid_area(a.x + a.dx,a.y, a.w, a.h) then
      a.x += a.dx
    else
      if a.mode == 1 then
        --bullets splode
        p_burst(4,a.x*8,a.y*8,5)
        del(actor,a)
        sfx(5)
      else
        a.dx *= -1
      end
    end
  end
 -- ditto for y
 if(a.spr == 11) then
   a.y += a.dy
 else
 if not solid_area(a.x,
  a.y + a.dy, a.w, a.h) then
  a.y += a.dy
 else
   --bullets splode
  if a.mode == 1 then
    p_burst(4,a.x*8,a.y*8,5)
    del(actor,a)
    sfx(5)
  else
    a.dy *= -1
    --sfx(2)
  end
 end
 end
 if a.mode == 0 and a.spr != 11 then
   a.dx *= a.inertia
   a.dy *= a.inertia
 end
 a.frame += abs(a.dx) * 4
 a.frame += abs(a.dy) * 4
 a.frame %= 3 -- always 3 frames
 a.t += 1
end
function draw_nrgbar(x,y,w,h,c1,c2,hp,hpmax)
  rectfill(x,y,x+w,y+h,c1)
  rectfill(x,y,ceil(x+(hp/hpmax*(w))),y+h,c2)
  rect(x,y,x+w,y+h,c1)
end
function mk_bullet(x,y,fx,fy,fac)
  if(ammo>0) then
    shake=2
    pl.dx -= (pl.f_x/5); --recoil
    pl.dy -= (pl.f_y/5);
    f = mk_actor(0,pl.x+(pl.f_x),pl.y+(pl.f_y))
    f.fac = pl.fac;
    f.spr = 21;
    f.life=3;
  p_burst(1,x*8,y*8,10)
  b = mk_actor(1,x,y)
  spd = 0.5
  if(fx<0) b.dx = -spd
  if(fx>0) b.dx = spd
  if(fy<0) b.dy = -spd
  if(fy>0) b.dy = spd
  if(weapon_upgrade) then
    b.spr = 26;
    sfx(21)
    ammo-=0.5;
  else
    b.spr = 20;
    sfx(0)
    ammo-=1;
  end
  b.fac = fac;
else
  sfx(2)
  set_dlg('ammo low! find ammo clips',20);
end
end
function control_player(pl)
 accel = 0.1
 if (btn(0)) then
   pl.dx -= accel
   if not btn(4) then
   pl.f_x=-1
   pl.f_y=0
   pl.fac=0.5
  end
 end
 if (btn(1)) then
   pl.dx += accel
   if not btn(4) then
     pl.f_x=1
     pl.f_y=0
     pl.fac=0
   end
 end
 if (btn(2)) then
   --left
   pl.dy -= accel
    if not btn(4) then
      pl.f_x=0
      pl.f_y=-1
      pl.fac=0.25
    end
 end
 if (btn(3)) then
   --right
   pl.dy += accel
    if not btn(4) then
      pl.f_x=0
      pl.f_y=1
      pl.fac=0.75
    end
 end
if not btn(4) then
 if (btn(0) and btn(2)) then pl.f_x=-1; pl.f_y=-1; pl.fac=0.375 end
 if (btn(0) and btn(3)) then pl.f_x=-1; pl.f_y=1; pl.fac=0.625 end
 if (btn(1) and btn(2)) then pl.f_x=1; pl.f_y=-1; pl.fac=0.125 end
 if (btn(1) and btn(3)) then pl.f_x=1; pl.f_y=1; pl.fac=0.875 end
end
 if (btnp(5)) then
   mk_bullet(pl.x,pl.y,pl.f_x,pl.f_y,pl.fac)
 end
 if (abs(pl.dx)+abs(pl.dy) > 0.1
     and (pl.t%4) == 0) then
  sfx(1)
 end
end
function _update()
  if(title_screen==true) then
    if(btn(5)) then
      title_screen=false;
      p_burst(7,pl.x*8,pl.y*8,20)
      for i=0,30 do
        p = mk_part(7,(pl.x*8)-8+rnd(16),(pl.y*8)-8+rnd(16))
        p.s = 5
        p.dx = ld_x(rnd(10)/30,rnd(359))
        p.dy = ld_y(rnd(10)/30,rnd(359))
        p.s_v = -0.1
        p.l = 60
      end
    end
  else
    if(dead==false) then
      if(pl.x>90) then
        if(boss_spawned==false) then
          music(8)
          mk_boss(113,43); --113,43
          cd=true; --scary boss fight effects
          mset(88,43,25) --close door
          mset(88,44,25)
          boss_spawned = true;
        end
      end
      if(cd==true and finish==false) then
        mk_part(6,c1_x+rnd(128),c1_y+rnd(128));
        shake = 3;
        cd_sec+=1;
        alert_t+=0.01;
        if(alert_t>0.5) alert_t=0;
        if(cd_sec>30) then cd_t-=1; cd_sec=0; end
        set_dlg('self destruct in: '..cd_t,20);
      end
      if(cd_t<0) then finish=true; escaped=0; end
      if(shake>0) then shake -= 0.5; c1_x_s=rnd(shake); c1_y_s=rnd(shake); end
      if(shake<=0) then c1_x_s=0; c1_y_s=0; shake=0; end
      if(finish==false) then
        speedrun_frame+=33.33;
        if(speedrun_frame>999) then speedrun_s+=1; speedrun_frame=0; end
        if(speedrun_s==60) then speedrun_m+=1; speedrun_s=0; end
      end
      control_player(pl)
      foreach(actor, move_actor)
      foreach(spawners, move_spawner)
      foreach(bosses, move_boss)
      foreach(parts, move_part)
      if(difficulty<0.5) difficulty=0.5;
      if(difficulty>2) difficulty=2;
    end
  end
end
function draw_dlg()
  if(dlg_y>9) then this_y = 9 else this_y = dlg_y end
  dlg_c = 13;
  grd = fade_red[dlg_c];
  pal(dlg_c,grd[ceil(-this_y+10)])
  rectfill(c1_x, c1_y+128-this_y, c1_x+128, c1_y+128, dlg_c)
  line(c1_x, c1_y+128-this_y-1, c1_x+128, c1_y+128-this_y-1, 1)
  print(dlg_txt,c1_x+2,c1_y+128-this_y+2,7)
  print(dlg_txt,c1_x+1,c1_y+128-this_y+2,1)
  if(dlg_y>0) dlg_y-=0.5;
  pal()
end
function draw_actor(a)
 local sx = (a.x * 8) - 4
 local sy = (a.y * 8) - 4
  if a.mode == 0 then
    spra(a.fac,flr(a.spr + a.frame),sx,sy)
  elseif a.mode == 1 then
    spra(a.fac,a.spr,sx,sy)
  end
end
function draw_tentacle(blob,x1,y1,x2,y2)
  ang = point_ang(x1,y1,x2,y2)
  dist = point_dist(x1,y1,x2,y2)/blob
  for i=0,blob do
    local tx = x1-ld_x(i*dist,ang)
    local ty = y1-ld_y(i*dist,ang)
    spr(15,tx,ty)
  end
end
function draw_boss(b)
  local sx = b.x*8;
  local sy = b.y*8;
  spr(30,sx,sy); --body
  spr(46,sx,sy+8);
  if(exists_eye1) then
    draw_tentacle(6,sx-4,sy,a1xr*8,a1yr*8)
  end
  if(exists_eye2) then
    draw_tentacle(6,sx-4,sy+4,a2xr*8,a2yr*8)
  end
  if(exists_eye3) then
    draw_tentacle(6,sx-4,sy+8,a3xr*8,a3yr*8)
  end
end
function draw_spawner(s)
  local sx = s.x*8;
  local sy = s.y*8;
  if(s.type==1) then spr(102,sx,sy); spr(103,sx+8,sy); spr(118,sx,sy+8); spr(119,sx+8,sy+8); end
  if(s.type==2) then spr(32,sx,sy); end
end
function draw_part(p)
  if(p.t>#p.g) p.t = 0
  circfill(p.x,p.y,p.s,p.g[p.t])
end
function open_drs()
  for i=0,128 do
    for j=0,64 do
      if(mget(i, j)==24) mset(i, j, t_blnk)
    end
  end
end
function auto_tile()
  for i=0,128 do
    for j=0,64 do
      tile=mget(i, j)
      flags=fget(tile)
      if (tile == 102) then mk_spawn(45,1,i,j); mset(i, j, 125); mset(i+1, j, 111); mset(i, j+1, 125); mset(i+1, j+1, 110); end
      if (tile == 32) then mk_spawn(45,2,i,j); mset(i, j, 125); end
      if (tile == 17) then
        pl = mk_actor(0,i,j) -- 3,3
        pl.spr = 17
        pl.nrg = 10
        pl.fac = 0
        pl.is_plr = true
        mset(i, j, t_blnk);
      end
      if tile == 64 or tile == 80 then
        this_flag=fget(mget(i, j), 2)
        if this_flag then
          if fget(mget(i, j-1), 2) then flag_above = 1 else flag_above = 0 end
          if fget(mget(i, j+1), 2) then flag_below = 1 else flag_below = 0 end
          if fget(mget(i-1, j), 2) then flag_left = 1 else flag_left = 0 end
          if fget(mget(i+1, j), 2) then flag_right = 1 else flag_right = 0 end
          new_tile = (1*flag_above) + (2*flag_left) + (4*flag_right) + (8*flag_below)
          mset(i, j, new_tile+tile)
        end
      end
    end
  end
end
function gui()
  --nrg
  rx=1; ry=1; l=30; h=7;
  spr(1,c1_x+rx,c1_y+ry)
  draw_nrgbar(c1_x+rx+8,c1_y+ry,l,h,7,8,pl.nrg,pl.nrg_max)
  spr(2,c1_x+l+rx+8,c1_y+ry)
  --ammo
  rx=44; ry=1; l=30; h=7;
  spr(3,c1_x+rx,c1_y+ry)
  draw_nrgbar(c1_x+rx+8,c1_y+ry,l,h,7,11,ammo,100)
  spr(2,c1_x+l+rx+8,c1_y+ry)
  --keys
  rx=87; ry=1; l=30; h=7;
  spr(4,c1_x+rx,c1_y+ry)
  rectfill(c1_x+rx+8,c1_y+ry,c1_x+rx+8+l,c1_y+ry+h,7)
  spr(2,c1_x+l+rx+8,c1_y+ry)
  print("keys:"..key_n,c1_x+rx+10,c1_y+ry+2,5)

end
function _draw()
  cls()
  for s in all(stars) do
    s.x -= s.col*s_mult;
    if(s.x<0) then
      s.x = 128;
      s.px = s.x;
      if (s_mult>0.9) line(c1_x+0,c1_y+s.y,c1_x+128,c1_y+s.y,rnd(16))
    end
    if(s_mult<1) s_mult+=0.00005;
    line(c1_x+s.x,c1_y+s.y,c1_x+s.px,c1_y+s.py,s.col)
   s.px = s.x; s.py = s.y;
  end
  if(title_screen==true) then
      s_mult = 0.05;
    if(btn(5)) then title_screen=false; end
    circfill(118,172,65+rnd(2),7);
    circfill(118,172,64,10);
    circfill(118,172,61+rnd(2),8);
    spr(56,48,64)
    pset(48+3,64+4,rnd(16))
    circfill(64+21,64+11,1+rnd(2),12);
    spr(38,64+16,64)
    spr(39,64+24,64)
    spr(54,66+16,64+8)
    spr(55,64+24,64+8)
    print('mission directives:',2,2,7)
    print('1) disable all backup consoles',2,10,11)
    print('2) get to deck lift',2,18,11)
    print('3) survive',2,26,11)
    print('press \151 to enter shuttle bay',2,50,7)
  else
    if(dead==true) then gover_t+=1; hurting=7; end
    if(gover_t>60) then
        gameover()
    else
      if finish == false then
        --red screen flash
        if(hurting>0) then
          hurting-= 0.25
          fade(hurting,fade_red,8)
          end
        if(alert_t>0) fade(ceil(4*-sin(alert_t))-1,fade_red,8)
        --red screen flash
        if(darkness>0) then
          darkness-= 0.25
          fade(darkness,fade_black,0)
        end
        --pal()
        palt(14, true) -- beige
        palt(0, false) -- black
        for m_x=0,15 do
          --if(m_x>=4) then pal(5,1);pal(6,13); end --blue
          --if(m_x>=8) then pal(5,2);pal(6,15); end --red
          --if(m_x>=12) then pal(5,0);pal(6,5); end --dark
          if( m_x>flr(c1_x/8/8)-3 and m_x<flr(c1_x/8/8)+3) then
            for m_y=0,7 do
              if( m_y>flr(c1_y/8/8)-3 and m_y<flr(c1_y/8/8)+3) then
                local rm_coly = room_cols[m_y+1];
                local rm_cl = rm_coly[m_x+1]
                --if(rm_cl==4) then pal(5,1);pal(6,13); pal(0,0);end --blue
                --if(rm_cl==3) then pal(5,2);pal(6,15); pal(0,0);end --red
                --if(rm_cl==7) then pal(5,6);pal(6,7); pal(0,5); end --bright
                --if(rm_cl==0) then pal(5,5);pal(6,6); pal(0,0);end --normal
                map(m_x*8, m_y*8, m_x*8*8, m_y*8*8, 8, 8)
              end
            end
          end
        end
        foreach(bosses,draw_boss)
        foreach(spawners,draw_spawner)
        pal()
        foreach(actor,draw_actor)
        foreach(parts,draw_part)
        if(action_t>0) then
          draw_nrgbar((pl.x*8)-4,(pl.y*8)-8,8,4,7,8,action_t,110)
        end
if(dead==false) then
  c1_x += (((pl.x*8)-60)-c1_x) * 0.1
  c1_y += (((pl.y*8)-60)-c1_y) * 0.1
  c2_x = 64
  c2_y = 64;
  --camera(c2_x+c2_x_s,c2_y+c2_y_s)
  --memcpy(0x6000, 0x6000+4096, 4096)
  camera(c1_x+c1_x_s,c1_y+c1_y_s)
end
        gui()
      else
        s_mult = 0.1;
        end_game()
      end
      draw_dlg()
    end
  end -- title
end

__gfx__
0000000056777777650000005677777756777677500000000000000000000000000000000000000000000000eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
1110000067722777760000006777777767776567055555550000000000000000000000000000000000000000eeeeeeeeeeeeeeeeeeeeeeeeee1222eeee1212ee
2211000077728777770000007797979777765a52055565550000000000000000000000000000000000000000eeee288eeeee288eeeee288ee2288ffee1228f2e
33311000722888e7770000007787878777655527055666550000000000000000000000000000000000000000122888881228888812288888e288288ee228288e
4221100072888ee7770000007787878772555277056565650000000000000000000000000000000000000000eeee278eeeee278eeeee278ee28f88fee18f88fe
522110007778e777770000007787878777252777055565550000000000000000000000000000000000000000eeeeeeeeeeeeeeeeeeeeeeeee288882ee2888f2e
6d521000677ee777760000006777777767727777055565550000000000000000000000000000000000000000eeeeeeeeeeeeeeeeeeeeeeeeeef288eeee228fee
76d5100056777777650000005677777756777777055555550000000000000000000000000000000000000000eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
84221000e0550eee0550eeeeee0550eeeeeeeeeee070eeee50000000500000009999999998800010eeeeeeee00000000b333333300000000eeeeee22eeeeee22
94221000016660ee16660eeee016610eeeeeeeee0700eeee05555555055555558855558898500010eeee777e000000003bbbbbbb00000000eeeeee8ee2eeee8e
a94210000111160e111160000111160ee655500e7777000005559555057777758880505895000210e666dcd7000000003bbbbbbb00000000222ee28ee22ee28e
b333100001cc160001cc149401cc16006499a7709a777707059585850577877588880000955022106dcdcdc7000000003bbbbb7b00000000ee2228eeee2228ee
ccd5100001cc149401cc155001cc14946499a770a9777070058585850578887502222000950822106cdcdcd7000000003bbbbbbb00000000ee288888ee288888
dd511000011116600111160e01111550e655500e7777000e05858585057787750022220095882210e666cdc7000000003b7bbbbb00000000eee8288fee882888
ee2210000166600ee016660e1666600eeeeeeeee0700eeee05855595057777751111111198882010eeee777e000000003bbbbbbb00000000eee8828fee88828f
f9421000e0550eeeee0550ee05500eeeeeeeeeeee070eeee05555555055555550000000098880010eeeeeeee000000003bbbbbbb00000000eee2888fee82888f
50000000ee00b070ee00b070e00b070e50000000500000000000077700000000500000000000000000000000000000000000000000000000eee82882ee882882
05533355e0333b0ee0333b000333b0ee055555550555c5550000776650008000055557550000000000000000000000000000000000000000ee888828ee88882f
053bbbb50b3b000e0b3b00070b3b000e05557555055c7c550007766550066660055576750050505050505050505050500000000000000000ee82888fee82888f
05b7b7b30333387003333870033383700557c75505c777c5007766660606666605576a6005050a0000000505050505050000000000000000ee8828feee88288e
03bbbbb3033338700333837003333870057c7c750c77c77c0078566660077a8a057666000050aaaaaaaa0550000055550000000000000000ee8888eeee8888ee
03b7bb350b3b000e0b3b000e0b3b00070557c75505c777c50088666c6075a99a006660050550999900000000111005050000000000000000ee2ef8fee2feff2e
05bb3355e0333b0e0333b0eee0333b0005557555055c7c550000667a7aa509a7050600550055000011111111110555550000000000000000ee8eeefeefeeee2e
05335555ee00b070e00b070eee00b070055555550555c55507606775555099700550055505501111117c7ccdd10005550000000000000000eeeeef8eeeeeeeff
00000000eeeeeeeeeeeeeeeeeeeeeeee600000000000000507666c55c55569000000000000001d1d17c7ccc1ddddd000eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
00000000eeeee0eeeeeee0eeeeeeee0e0777657556676560077667555006990000000000055011dddc7cccc1ddddd055eee222eeeee222eeeee222eeeeeeeeee
00077000e0e0070eeee0070ee00000700655566665665750000c6659506990000000000005501d1ddd11111ddd000550ee2fff8eee2fff8eee2fff8eeeee288e
007887000b0bb0eee008b0ee0bbbbb0e0777677766766560000cc66900a900990000500005550000dddddddddd055055e2ff7778e2ff8878e2ff777812288888
00788700e0b8b0ee0bbbbb0ee008b0ee06666666666566600d00c9999990009a00006c600550aaaa00000000ddd00555e2f78878e2f78878e2f88778eeee278e
00077000ee00070ee0000070eee0070e0000000006665650000009a0999909a700005000055099999999005000005555e2f78878e2f77778e2f88778eeeeeeee
00000000eeeee0eeeeeee00eeeeee0ee05555555006676700000707790999a7000000000055509000000550505050555ee87778eee87778eee87778eeeeeeeee
00000000eeeeeeeeeeeeeeeeeeeeeeee055555550500000500000000000aa70000000000055050550505055555555555eee888eeeee888eeeee888eeeeeeeeee
77777777776666557777777766666655777777777766666677777777666666667777777777666655777777776666665577777777776666667777777766666666
77666655776666556666665566656650776666667766656666666666666656667766665577666650666666556665665077666666776666566666666665666066
77665655776656556666665566666655776666667766666666656666666666667766665577656655666666556666665577666666776666666666666666666666
77666655776666556566665565666650776566667766665666666666656666667765665577666650666566556666665077666656776666666665666666666656
77656655776566556666565566665655776666567765666665666656666666567766665577666655666666556666665577666666776566666666666666606666
77666655776666556666665566666650776666667766666666666666666666667766665077666650666666506566665077656666776666666666666666666666
77555555775555555555555555555555775555557755555555555555555555557766565577665655666656556666565577666666776666666656665665666656
70505050705050505050505050505050705050507050505050505050505050507766665077666650566666506666665077666665776666656666666666666666
3bbbbbbbbbb36300bbbbbbbb63333300bbbbbbbbbb336333bbbbbbbb36333363bbbbbbbbbb336300bbbbbbbb333333003bbbbbbbbbb33333bbbbbbbb33633363
bbbbb330bb33330033bbbbb033363300bb33bbb3bbb333363bb33bbb33333333bbbbbb00bbb330003bbb3b0063333000bb3b3333bbb3333333bbbbbb33336333
b3633300b33363306333330033333330b3333333b33333333336333333336333bb333000bbb3350033b3330033633350bbb33336bb3b33363b33bb3333333333
b3333630b36333003333333063336300b3363333b33333633333333333633363bbb63500bbb363303336335033330000b3333333bbb336333336333333633336
b3363330b33333006333633033333330b3333363bb3633333633336333333333bb333350bb3333006333300033335000bb336333bb3333333333333363336333
bb333350bb3353003333330033053330bb333333bb3330533305533353350035b3333300b33335003333350033333500bb333333b33333363333363333333333
bb550300bb5305000055350000005350bb055350bb0550000500035003500350b3336500b33335003333635063363000bbb33336bbb333333333333333333333
b0000000b00000000000000000000000b0000000b00000000000000000000000bb333350bb3633503363335033333350bbb33333bbbb33333363336333336333
00000000500000005000000050000000500000005000000050000000500000000005555555555555500000005000000050000000b3333333b3333333b3030003
000000000555555505555555055555550555555505888855055bbbbb0bbbbb550577007a00aa00a90555555505555555000000553bbbbbbb3bbbbbbb35bbbbbb
00505050055555550555855805885885058555550888888505bb0b0b0b0b0bb507a00aa00aa00aa00555555005050505000055553b3bb3bb3bbbbbbb35b555bb
0505050505555555055888550588588505555558088888880b0b30300030bb5b570d6d6d666666000555555005555555005555553bbbbbbb3bbbbb7b05b5555b
00505050055555550555855505885558055555550888588805b0333333333bbb50060000000006090555555005050505000555553bbbbb3b3bbbbbbb0bbb555b
0555555505555555055855550558858505555555088588850b0330303030330b50ad0505050506a90055550005555555000555553bb3bbbb3b7bbbbb05bbb55b
0505050505555555055555550585858505558555088888550b330505050503bb57a60050505056a00000550005050505000055553bbbbbbb3bbbbbbb0b5bbbbb
0555555505555555055555550555555505555555055888580b305000000033bb5a0d0505050506000000000005555555000055553bbbb3bb3bbbbbbb3b5b555b
09999990699999957777777777a00050000000050000000560300808000003005006005050505609eeeeeeee0888888050000000500000000000000077777777
9444494092222224a75555a77a500050566765601cc7c1c00b3000000000033b50a60505050506a9eeeeeeee8222282009999955055555550303030377666655
9999944592282c24aaa0505a7500045065665750c1cc17100b3000000808033b5aa60050505056a0eeeeeeee8888822102929255055b5bb50030303077666655
9449445092c22224aaaa00007550945066766560cc7cc1c00b308080000003bb5a06050505050600eeeeeeee8228221002222255055b55b503b3b3b377666655
9494454592222c2409999000750a945066656660ccc1ccc00b3300000000330b5006005050505604eeeeeeee82822121000009950b5555550b0b0b0b77666655
99445550928282240044440075aa9450066656500ccc1c100b3333333333303b50a6666666666694eeeeeeee88221110029599290555555bbbbbbbbb77666655
94454445922222245555555577aa90500066767000cc7c70050330bb0b0b0bb55aa00aa00aa00990eeeeeeee822122210925922905bb555b0bbbbbbb77555555
0050505054444446000000007aaa0050050000050500000505b00bbb0bb5b5555900990099004400eeeeeeee0010101000050000055b5555bbbbbbbb70505050
041607b70782070707b6b707071606040416040404040404040404040404040404040404040404060606060427045704060606060606060404040405e6050404
0404b6b6b6b604040404041604040404040405050505050504a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7
041607b7070707070707b7b70716160604160606060606040606060606060606060604060606041616161604270416161616161616161604040606e7d6e70604
0406b6b6b6c606040406061606060604040606e7e7e7e70504a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7
0416060606060606060606060616d716371616161616160416040404040404040416041604160416c6021604270416160216a6160216160404d716d7f6d71604
04b6b6b6b6b6b60404161616161616040416f6d6f6f6d60504a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7
0416b707b7b6b707b7b6b707f6161616041616161616163716060606060606040416041604160416161616160216161616161616161616040416d7161616d7f7
f7b6a6b6b6b6b604041616021616160404d7d66676d6d60504a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7
041607b707b607b707b607b7e6d6e6d60416160404040404161616161616160404160416041604161616161616161616161616161616c60404161616d7161604
04b6b6b6b6b6b63706160216021616040416d66777d6d60504a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7
0416b707b707b707b7b6b707d666760505161604a7a7a704161716171617160404160416041604160216c61616160216a6161602161616040416161616161604
04b6b6b6b6b6b604041616021616160404d7f6d7d6f6d60504a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7
0416060606060606061606e7d667770582161604a7a7a70416171617161716040416061604160416161616161616161616161616161616040416161616161604
04b6b6b6b6b6a6f7f7161616161616040416d7161616d70504a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7040405050505050505a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7
0416040404040404040405050505050505040404a7a7a7041617161716171604040404040416040404040404040404040416161616b716040404041604040404
04040481040404040404041604040404040404041604040404040404040404040404040404040404060606e7e7e766760505a7a7a7a7a7a7a7a7a7a7a7a7a7a7
040404040404040404050505050505050505040404040404161716171617160606060606061604a7a7a7a7a7a7a7a7a704161616160616040404041604040404
040404160457040404040416040404040404040416040404040606060606060606060606060606061616d7e6f6d66777e70505a7a7a7a7a7a7a7a7a7a7a7a7a7
a7a704b7b7b7b7040406e7e7e7e7e7e7e706060606060604161716171617160404040404040404a7a7a7a7a7a7a7a7a70416b716b716b7040443531606435304
0406061606060604040606d70606060406060606160604040416161616161616161616161616161616f60404d6e6d6e6d6050505a7a7a7a760a7a7a7a7a7a7a7
a7a70471b6b6820404d716d66676e6d616c60404040416041617161716171604a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a704610616061606040416161616161604
04d71616161616040416f6e6d6f6d7041616161616160457041616b616b616b616b616b616b6161616d70404d6d6d6d6d605050505a7a7a7a7a7a7a7a7a7a7a7
0404040404b6b604041616f66777d616f6160461710482046117161716171604a7a704040404040404040404040404040416b716b716b7040416161616161604
0416d7b6b6d7610404d7f66676d616041616160216161616911616161616161616161616161616161616f6e6d6e6e6e6d6e1869605a7a7a7a7a7a7a7a7a7a7a7
0461045704b6b6040416d716d6f616d716160416160416041717171716171704a7a7045206060606060606060606060606160616061606040416d71616d71604
041602b6b61671040416e66777d6d716161616161602161691161616161616161616161616161616d71616d7d6f6e6e6d6e6879705a7a7a7a7a7a7a7a7a7a7a7
04810416040427040416c616d716d71616160404270416040606060616060604a7a70404040404040404040404040404041616b716b76104041602d7f6021604
04161616d702160404d726d6e6f616041616021616161616041616b616b616b616b616b616b6161616160404d6d6d6e6d605050505a7a7a7a7a7a7a7a7a7a7a7
04161616161616060616161616161616a6161616161616041616161616161604a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a704161606160616040416d7161616d704
04d716161616d7040416d7d7d716d70416161602161602160416161616161616161616161616161616f60404f6d6d6e6e6050505a7a7a7a7a7a7a7a7a7a7a7a7
0404048104040404040404040404040404040404160404041616161616161604a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7046116b716b716040404041604040404
0404041604040404040404041604040416161616161616160471161661042704270427042704270416161616f6d66676e60505a7a7a7a7a7a7a7a7a7a7a7a7a7
04040416040404040404040404040404040404042704040404041604040404040404040404040404050505050505050504161606160404040404041604040404
040404160404040404040404160404040404040404040404040404040404610461047104610461041616d7e6f6d667770505a7a7a7a7a7a7a7a7a7a7a7a7a7a7
0406061606060606060606060606060405060606160606040406160606060604040606060606060405e7e7e7e7e70605041646161604a7a70406061616060604
04e7e7e6e7e7e7040406060616060604040606060606060404a7a7a7a70404040404040404040404040405050505050505a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7
0416040404040404040404040404160405f6c6b6b6b6b6040416b6b6b6b61604041616160416160405d66676e6d71605041616561604a7a70416161616161604
04f6d66676d6f60404161616b7b71604041616161616d70504a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7
0416040606060606060606060604160405d6f6b6b6a6b6040416b61717b61604041616160416170405f66777f6d71605042616161604a7a70416d702f6161604
04d7e66777e6d7040416161616b71604041616d716f6160504a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7
041604160404040404040404160416040502b6b6b6b6b6161616b61717b6160404828216041616040516f61616161605041616163604a7a7041616d716161604
0416d7e6d6f616040416b7161616160404d71616f6d6d60504a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7
0416041604060606060606061604160405d6d7b6b6b6b6040416b6b6f6b6d70404828261041716040516d716d716d705051661161604a7a70416161602d71604
041616d702d716040416b7b71616161616161616d666760504a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7
0416041604160404040416041604160505f6b6b6b6b6b60404d702f6e602820404828271041616040516161616161605051616161604a7a70416161616161604
04161616161616040416161616161604041616f6e667770504a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7
041604160416047182041604160416050505050404040404041616d716d7160404040404041617040505051616050505050505051604a7a70404040404041604
04040416040404040404040416160404040405050505050504a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7
041604160416061616041604d705d705040404040404040404040404040404040404040404161604050505161605050505050505160404040406060606061604
04040416040404040404040416160404040404040404040404a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7
0416041604160404040416051605e60504b7b7b70406c7c7040606170407b7c7040707c70417160405e706d716060605056676e7160606040416040404040404
04060616060606040406060616060604040606060606060404a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7
04160416041606060606d705d705d6d6378282160416167104611616041616160416161604d7160505f616161616d705056777e6f61616040416060606060604
04161616b707c7040416b7b7c7b7160404b7b7b7b7b7160404a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7
041604160404040404050505d6e6f60504040427042704040404042704270404040404270416160505d71616d716160505e6f616161616040416161616021604
041616b707b7c7040416b7c7c7b71604040606060606160404a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7
041604160606060606e7d7f6f6e6d605040606b606b60606060606b606b60606060606b60616d7163716d71616e6f6d6f61616d716d716040416b70716161616
1616b707b707c7040416b782c7b716040416161616b7b70404a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7
0416041604040404050505e6d6667605041616161616161616161616d7161616161616161616160505d616161666760505d7161616161604041607b71607b704
04b707b707b7c7040416b7b7b7b70204041616b7b7b7570404a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7
0416061606060606e7e7e7d6f66777050416161616161616d7f6021616161616f602d716f6e6d60505e6d6f6e667770505161616161616040416161616b70704
0407b707b707c7f7f7161616161616f7f71616060606060404a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7
04040404040405050505050505050505040404040404040505050505040404050505050505050505050505050505050505050505050505040404040404040404
04040404040404040404040404040404040404040404040404a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7


__lbl__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
05677777777777777777777777777777777777765100567777777777777777777777777777777777776500056777677777777777777777777777777777777650
06772277778888777777777777777777777777776000677777777b77777777777777777777777777777666667776567777777777777777777777777777777760
07772877778888777777777777777777777777777000779797977b77777777777777777777777777777700077765a52775757555757577557777755577777770
0722888e778888777777777777777777777777777000778787877b77777777777777777777777777777700077655527775757577757575777757757577777770
072888ee778888777777777777777777777777777000778787877b77777777777777777777777777777700072555277775577557755575557777757577777770
07778e77778888777777777777777777777777777000778787877b77777777777777777777777777777700077252777775757577777577757757757577777770
0677ee77778888777777777777777777777777776000677777777b77777777777777777777777777777600067727777775757555755575577777755577777760
05677777777777777777777777777777777777765000567777777777777777777777777777777777776500056777777777777777777777777777777777777650
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000005555550000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000666666600000000000000000000000000000000000000000000000666666600000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000666666600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000055666666600000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000666666
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000777777770000007777777700000000000000000000
00000000000000000000000000000000055777777777777777777777777777777777777777777777777777777770000000000000000000000555555000000000
00000000000000000000000000000000000776666666666666666666666666666666666666666666666666666550000000000000000000000000000000000000
f0000000000000000000000000000000000776666666665666666656666666566666665666666656666666666550000000000000000000000000000000000000
00000000000000000000000000000000000776566666666666666666666666666666666666666666666666566550000000000000000000000000000000000000
00000000000000000000000000000000000776666566566665665666656656666566566665665666656666666551100000000000000000000000000000000000
00000000000000000000000000000000000776666666666666666666666666666666666666666666666666666500000000000000000000000000000000000000
00000000000000000000000000000000000775555555555555555555555555555555555555555555555666656550077777555555000000000000000000000000
00000000000000000000000000000000000705050505050505050505050505050505050505050505050566666500000000000000000000000000000000000000
0000000000000000000000000000000000098800010000000000000ff00000000000000000000000000776666550000000000000000000000000000000000000
00000000000000000000000000000000000985000100000000000000000000000000000000000000000776666500000000000000000000000000000000000000
00000000000000000000000000000000000950002100050505000505050505050505050505000505050776566550000000000000000000000000000000000000
00000000000000000000000000000000000955022100505050505050a00000005050505050505050505776666500000000000000000000666666600000000000
0000000000000000000000000000000000095082210005050500050aaaaaaaa05500000555500505050776666550000000000000000000000000000000000000
00000000000000000000000000000000000958822100555555505509999000000001110050505555555776666500000000000000000000000000000000000000
00000000000000000000000000000000000988820100505050500550000111111111105555505050505776656550000000000000000000000000000000000000
00000000000000000000000000000000000988800100555555505501111117c7ccdd100055505555555776666500000000000000000000000000000000000000
00000000000000000000000000000000000988000105000000000001d1d17c7ccc1ddddd00050000000776666667777777777777777777777777777777777777
000000000000000000000000000000000009850001005555555055011dddc7cccc1ddddd05505555555776666566666666666666666666666666666666666666
00000000000000000000000000000000000950002100505050505501d1ddd11111ddd00055005050505776666666665666666666666666566666666666666656
00000000000000000000000000000000000955022100555555505550000dddddddddd05505505555555776666666666666666656666666666666665666666666
0000000000000000000000000000000000095082210050505050550aaaa00000000ddd0055505050505776566666566665666666666656666566666666665666
00000000000000000000000000000000000958822100555555505509999999900500000555505555555776666666666666666666666666666666666666666666
00000000000000000000000000000000000988820100505050505550900000055050505055505050505776666665555555566566656555555556656665655555
00000000000000000000000000011000000988800100555555505505055050505555555555505555555776666655050505066666666505050506666666650505
00000000000000000000000011000000000988000105000000050000000500000005000000050000000776666550000000577666655699999957766665500000
01100000000000000000000000000000000985000100555555505555555055555550555555505555555776666551cc7c1c077666650922222247766665000000
0000000000000000000000000000000000095000210055555550555555505555555055555550555555577665655c1cc17107765665592282c247765665500505
0000000000000000000000000000000000095502210055555550555555505555555055555550555555577666655cc7cc1c07766665092c222247766665005050
0000000000000000000000000000000000095082210055555550555555505555555055555550555555577656655ccc1ccc07766665592222c247766665500505
00000000000000000000000555555000000958822100555555505555555055555550555555505555555776666550ccc1c1077666650928282247766665005555
000000000000000000000000000000000009888201005555555055555550555555505555555055555557755555500cc7c7077665655922222247766565505050
00777777770005555550000000000000000988800100555555505555555055555550555555505555555705050500500000577666650544444467766665005555
00000000000000000000000000000000000988000105000000050000000515000005000000050000000500000005000000077666666777777776666665550000
000000000000000000000000000000f0000985f0f100555555505555555166155550555555505555555055555550555555577666566666666666665665005555
00000000000000000000000000000000000950002100555555505555550116505550555555505555555050505050555655577666666666566666666665505050
000000000000000000000000000000777779550221005555555055555011c1505550555555505555555055555550556665577666656666666666566665005555
00000000000000000000000000000000000950822100555555505555501ccc555550555555505555555050505050565656577656666656666566666565505050
000000000000000000000000000000000009588221005555555055555011c1205550555555505555555055555550555655577666666666666666666665005555
00000000000000000000000000000000000988820100555555505555505501140550555555505555555050505050555655577555555555555555555555505050
00000000000000000000000000000000000988800100555555505555551550105550555555505555555055555550555555570505050505050505050505005555
00000000000000000000000000000000000777777776999999550000000000000005000000050000000500000005000000098800010500000005000000050000
00000000000000000000000000000000000776666559222222405555555055555550555555505555555055555550555555598500010055555550555555505555
000000000000000000000000000000000007766665592282c2405555555055555550555555505555555050505050555555595000210057777750555955505555
000000000000000000000000000000000007765665592c2222405555555055555550555555505555555055555550555555595502210057787750595858505555
000000000000000000000000000000000007766665592222c2405555555055555550555555505555555050505050555555595082210057888750585858505555
00000000000000000000000000000000000776666509282822405555555055555550555555505555555055555550555555595882210057787750585858505555
00000000000000000000000000000000000776656559222222405555555055555550555555505555555050505050555555598882010057777750585559505555
00000000000000000000000000000000000776666505444444605555555055555550555555505555555055555550555555598880010055555550555555505555
00000000000000000000000000000000000776666556999999569999995699999955000000050000000500000005000000077777777777777777777777750000
00000000000000000000000000000000000776666509222222492222224922222240555555505555555055555550555555577666666666666666666665505555
000000000000000000000000000000000007765665592282c2492282c2492282c240555555505555555050505050505050577666666666566666666665505050
000000000000055555500000000000000007766665092c2222492c2222492c222240555555505555555055555550555555577666656666666666665665505555
000000000000000000000000000000000007766665592222c2492222c2492222c240555555505555555050505050505050577666666656666566666665505050
00000000000005555550000000000000000776666509282822492828224928282240555555505555555055555550555555577656666666666666666665005555
00011000000000000000000000000000000776656559222222492222224922222240555555505555555050505050505050577666666555555556666565505050
00000000000000000000000000000000000776666505444444654444446544444460555555505555555055555550555555577666665505050505666665005555
00000000000000000000000000000000000776666667777777777777777777777777777777777777777777777777777777766666655699999957766665550000
00000000000000000000000000000000000776666566666666666666666666666666666666666666666666666666666666666656650922222247766665005555
0000000000000000000000000000000000077666666666666666666666666666666666666666666666666666666666666666666665592282c247765665505050
0000000000000000000000000000000000077666666666566666665666666656666666566666665666666656666666566666666665092c222247766665005555
000000f000110000000000000000000000077656666666666666666666666666666666666666666666666666666666666666666665592222c247766665505050
00000000000000000000000000000000000776666666666666666666666666666666666666666666666666666666666666665666650928282247766665005555
000000000000000000000f0000000000000776666666656665666566656665666566656665666566656665666566656665666665655922222247766565505050
00000000000000000000000000000000000776666656666666666666666666666666666666666666666666666666666666666666650544444467766665005555
0000000000000f000000000000000000000bbb333333633336336333363363333633633336336333363363333633363336366666666777777776666666677777
00000000000000000000000000000000000bbb333333333333333333333333333333333333333333333333333333333633365666066666666666666566666666
00000000000000000000000000000000000bb3b33363333633333336333333363333333633333336333333363333333333366666666666566666666666666666
00000000000000000000000000000000000bbb336333363336333633363336333633363336333633363336333633363333666666656666666666566666666656
00000000000000000000000000000000000bb3333333333333333333333333333333333333333333333333333336333633366606666656666566666665666666
0000000000000000000000000f000000000b33333365335003553350035500d00355335003553350035533500353333333366666666666666666666666666666
00000000000000000000000000000000000bbb333330350f350f350f30007700d500350035003500350035003503333333365666656555555555555555566566
00000000000000000000000000000000000bbbb33330000000000000070038030000000000000000000000000003333633366666666505050505050505066666
00000000000000000000000000000000000bb336300000000000000000b08301300000000f00000000000000000bbb3333333333300000000000000000077666
0000000000f000000000000000000f00000bbb3300003030303030303b3b3331003030303030303030303f30303bbb3333363333000000000000000000077666
00000000000000000000000000000000000bbb33500003030300030300111111030003030300030303000303030bb3b333633633350005050500050505077666
00000000000000000000000000000000000bbb3633003b3b3b303b3b301311303b303b3b3b303b3b3b303b3b3b3bbb33633333300000505f5050505050577666
0000000000000000000000f000000000000bb3333000b0b0b0b0b0b0b0000000b0b0b0b0b0b0b0b0b0b0b0b0b0bbb33333333335000005050500050505077656
00777777770000000000000000000000000b3333500bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb333333633333500055555550555555577666
00000000000f0000000000000000000f000b33335000bbbbbbb0bbb00d00bbbbbbb0bbbbbbb0bbbbbbb0bbbbbbbbbb3333363363000050505050505050577555
00000000000000000000000000000000000bb363350bbbbbbbbb0bf7700dbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb333333333350055555550555555570505
00000000000000000000000000000000000bb336300b33333335700380300000000b3333333b3030003b3333333bbb3333333333300500000005000000077a00
00000000000000000000000000000000000bbb330003bbbbbbb00b083013bbbbb553bbbbbbb35bbbbbb3bbbbbbbbbb333336333300005555555055555557a500
000000000000000000000000f0000000000bbb335003b3bb3bb0b3b33310b0b0bb53bbbbbbb35b555bb3b3bb3bbbb3b333633633350055555550555555575000
00000000000000f00000000000000000000bbb363303bbbbbbb001111110030bb5b3bbbbb7b05b5555b3bbbbbbbbbb3363333330000055555550555555575509
55555555555555555555555555555555555bb3333003bbbbb3b0013113033333bbb3bbbbbbbfbbb555b3bbbbb3bbb333333333350000555555505555555750a9
00000f00000011000000000000000000000b333350f3bb3bbbb0b0000003030330b3b7bbbbb05bbb55b3bb3bbbbb333333633333500055555550555555575aa9
0f00f00000000000000f000000000000000b33335003bbbbbbb0b330505050503bb3bbbbbbb0b5bbbbb3bbbbbbbbbb3333363363000055555550555555577aa9
00000000000000000000000000000000000bb3633503bbbb3bb0b305000000030bb3bbbbbbb3b5b555b3bbbb3bbbbbb33333333335005555555055555557aaa0
00000000000000000000000000000000000bb33630fb33333336030f87007700d00b303000350000000b3333333bbb33333333333005000000050000000bbbbb
00000000000000000000000000000000000bbb330003bbbbbbb0b30000b0880303b35bbbbbb055555553bbbbbbbbbb33333633330000555555505555555bb33b
00000000000000000000000000000000000bbb335003b3bb3bb0b3000b30330133b35b555bb055555553b3bb3bbbb3b3336336333500555555505555555b3333
00000000000000000000000000000000000bbb363303bbbbbbb0b308003b33310bb05b5555b055555553bbbbbbbbbb33633333300000555555505555555b3363
00000000000000000000000001100000000bb3333003bbbbb3b0b3300011111100b0bbb555b055555553bbbbb3bbb333333333350000555555505555555b3333
88888888888888888888888888888888888b33335003bb3bbbb0b3333303113003b05bbb55b055555553bb3bbbbb3333336333335000555555505555555bb333
0f000000000000000000000000000000000b33335003bbbbbbb050330bb00000bb50b5bbbbb055555553bbbbbbbbbb33333633630000555555505555555bb055
00000000000000000000000000000000000bb3633503bbbb3bb05b00bbb0bb5b5553b5b555b055555553bbbb3bbbbbb3333333333500555555505555555b0000
00000000000000000000000000000000000bb33630050000000b3333333500000005000000050000000b3030003bb33633363333300500000005000000050000
000000000000000000000000f0000000000bbb33000055555553bbbbbbb05555555055555550555555535bbbbbbbbb3333633363300055555550555555505555
00000000000000000000000000000000000bbb33500055b5bb53bbbbbbb055b5bb5055555550555855835b555bbb333333333333330055555550555555505555
00000000000000000000000000000000000bbb36330055b55b53bbbbb7b055b55b5055555550558885505b5555bb33333636333630005555555f555555505555
00000000000000000000000000000000000bb3333000b5555553bbbbbbb0b55555505555555055585550bbb555bbb36333333333330055555550555555505555
0000000f00000000000f000000005555550b33335000555555b3b7bbbbb0555555b055555550558555505bbb55bbb33305333053330055555550555555505555
000000f0000000000000000000000000000b333350005bb555b3bbbbbbbf5bb555b05555555055555550b5bbbbbbb05500000005350055555550555555505555
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111


__gff__
000202020000000000000000000000000000000000000000020200000200000000000000000000000002020200000000000000000202060602020202000000000606060606060606060606060606060606060606060606060606060606060606000000000000c080000000000000000012120202020280800000021a00000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000


__map__
404040404040407a7a7a7a7a7a7a7a7a40404040404040407a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a505050505050505050505050505050505050505050505050505050505050505040404050505040404040404040404040407a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a
1960292a2b60407a7a7a7a7a7a7a7a7a4070706060606040407a7a7a7a7a7a7a7a7a7a7a7a7a7a40507e7e7e66677e50507e7e7e7e666750507e7e7e7e7e7e50507e7e7e7e7e7e50406060607e7e60504060606060606040407a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a
196b393a3b6b40404040404040404040407070616161616a40404040404040407a7a7a7a7a7a7a40406f6e6e76776d50506d6d6d6d767750506d6d6e6d6d6d50506e6d6d6e6d6d504061616e6d6e6f50406b716b6b716b40407a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a
1961616161614075407140606060606040606061616461616174747474707040407a7a7a7a7a4040407d6e6e6d6e6e50506d6e6d6e6d6e50506e6d6d6d6e6e50506d6e6d6d7d6f5040617d6f66676e50406b716161716b40407a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a
1961611161616b054040406b6b6b6b6b4061616b616b61626161616161707040407a7a7a7a7a40177d616f6e6e6d6e50506d6d6d6e6d6d50506d6d6e6d6e6d6d6d6d6e6d6f616140407d6f6d76776d50406b711617716b40407a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a
4071616161616b61191716616128616173616161616163614061616165707040407a7a7a7a7a4040406e6d6e6e6e6e6d6d6d6d6e6d6d6d6e6d6e6d6d6d666750506d6d6d7d6117404061616f6d6e6d50406b717171716b40407a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a
4071717161616b6b4040406b6b6b6b6b40617b7b61617061407b7b7070707040407a7a7a7a7a7a40406e6e6e6e6d6e50506d6e6d6d6d6e50506d6e6d6e767750506e6d6e6f61167f7f617d61617d6f50406b6b6b6b6b6b40407a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a
40404040404040404071406b6b6b6b6b40617b7b6161707040404040404040404040404040404040404040406d505050505050506d5050505050506d50505050505050504040404040404040614040404040406b40404040407a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a
50505050505050504040404040404040406161646161606040404040404040404040404040404040404040406e505050505050506d5050505050506d505050505050505050505050505050506b5050504040406b40404040407a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a
507e7e7e7e7e7e50506060404040407540616161616161617c606060606060606060606060707b4040607e7e6d7e7e50507e7e7e6d7e7e50507e7e6e7e7e7e50507e7e7e7e6667505066677e6f7e7e504071606b60606071407a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a
506d66676e6f6d5050616173611961616161616162616361404040404040404040616161617c714040617d6e6e6d6e50506d6d6d6d6d6e50506d6e6d6d6d6e50506d6d6d6d7677505076776e7d6667504060716b6b6b7160407a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a
506d76776f616d505061615050406161616161616161616140717171717171714061616161617c4040616f6d6d6d6d50506d6e6d6d6d6d50506e6d6d6e6d6d50506d6e6d6e6d6d50506e6d7d6f767750406b60716b71606b407a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a
507d6e7d61626f50506161616140707070616161612061614071404040714071407070706161614040617d6d6e6d6d50506d6d6d6e6d6d50506d6d6d6d6d6e50506d6d6d6d6d6e50507d6f6b6b6e6f7e606b6b6b256b6b6b407a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a
506d6f616f6161606061616161407070706161616161616140714071404040714070707061286140407d6f6d6d6e6d50506d6e6d6d6d6e505066676d6e6d6d6d6d6d6d6e6d6d6d50506b6b6b6b6b6b50406b6b716b716b6b407a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a
506f617d61646161616161616140606060616161616161614071717171717171406060606161614040617d6e6d6d6d50506d6d6d6d6d6d505076776e6d6d6e50506e6d6d6d6e6d50406b6b6b6b6b6b40406b71606b60716b407a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a
50505061616161616161616161402861616161614040404040404040404040404040404040404040404040506d50505050505050505050505050505050505050505050506d5050504040406b404040404071606b6b6b6071407a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a
7a505050616161616161616161404040404040404040404040404040404040404040404040404040404075501850505050505050505050505050505050505050505050506d5050504040406b404040404040404040404040407a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a
7a7a7a5061616161406161616160717c406060606060744040406060606040404040406060606060606060606d506050507e7e7e7e7e7e7e7e7e7e7e7e7e7e7e7e7e7e506d507e504040406b404040404060606040404040407a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a
7a7a7a4061616161406161616161607c7c61616c6161614040606b6b6b6b604040406061616161616161616161506150506e6d6e6d6d6d6e6d6e6d6e6d6e6d6d6d6e6d506e506d504040406b404040404028616140404040407a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a
7a7a7a406161616140616161617b7b4040616161616a6140406b6b6b166b6b4040616161404040404040404050506150506d6e50505050505050505050505050505050506d506e504040406b404040404040406140404040407a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a
7a7a7a4070616161407b7b61617b7c40406161616f616140406b6b176b6b6b7373616161606060606060606060606150506d6d506e6d6d6e6d6e6f6f7d611617617d6f7d6f506d504040406b404040404040406140404040407a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a
7a7a7a407070616140757b616160604040616a7d20626140406b6b6b6b6b6b4040614040404061404040404040406150506e6d506d50505050505050505050505050505050506d504040406b404040404040406140404040407a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a
7a7a40404040401840606061616116404061616d6e6f614040406b6b6b6b404040616060606061606060606060606150506e6d506d506e6d6d6d6e6d6d6d6e6d6d6e6d6d6e6d6e504040406b404040404040406140404040407a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a
7a4040606060606140404040404040404040505050505040404040404040404040614040404040404040614040406150505050506e5050505050505050505050505050505050505040404061404040404040406140404040407a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a
404060616161616160606060606040404040404040404040404040404040404040616060606060606060616060606140505050506d5050505050505050505050505050505050404040404061404040404040406140404040407a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a
40606161616a616161616161616140404060606060606040406070707070704040614040406140404040404040406140505050506e7e5050507e7e7e7e7e7e505066677e7e7e604040606061606060404060606160606040407a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a
4061616161616161616161616c6140404028282861616173736160707070704040616060606160606060606060606140505050506d6d5050506e6d6e6d6d6e505076776e6d6f7d40406b6b6b6b6b6b404061616161616140407a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a
40617070706b70707b617070707b4040407171716161614040616160606070404061404040404040406140404040614050505050506e7e50506d6d6d6d6d6d50506e6d6e6b6a6b40406b6b6b6b6c6b404061616120616140407a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a
40617070706b70707b17707b7b7b404040717171616161404061616116177040406160606060606060616060606061405050505050506d7e7e6d6e6d50505050506d6b6f6b7d6b6b6b6b6b6b6b6b6b616161616161616140407a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a
4061707b7b6b70707b707b7b7b7b404040606060616161404061617070707040406140404040404040404040404061405050505050505050506e6d6d50755050506f6b6c6b6b6b40406b6b6a6b6b6b404061612061616140407a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a
4061606060616060606060606060404040616161616161404061617070707040406160606060606060606060606061405050505050505050506d6e6d6d6e5050406b7d6b6b6b6b40406b6b6b6b6b6b404061616161616140407a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a
4061707070617b7b7b6b70707061404040724040404040404040404040404040404040404040404040404040184040404040404040404040505050501850505040406b6b6b6b404040404061614040404040404040404040407a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a7a


__sfx__
0001000033670325702c460284601d250192501624015230103300932004320013102630027300273002430006300013000000000000000000000000000000000000000000000000000000000000000000000000
000100000c6501f640056100050000500005000050000500005000050000500005000050000500005000050000500005000050000500005000050000500005000050000500005000050000500005000050000500
000100000243003650046200361003650036500070000700007000070000700007000070000700007000070000700007000070000700007000070000700007000070000700007000070000700007000070000700
00010000000003f7703c770117703e7703f7703f770137703c7703a760197603a7503d7403f7403f7403c7503a760187503b740103500e3500d3500c3500a3500835007350053500435003350013500000000000
000400002c57024570365702e570000000000000000000002c52024520365202e520000000000000000000002c51024510365102e510000000000000000000000000000000000000000000000000000000000000
000100003e6303e5303d7303c7303a73037730357203472033720327203272031720307202f7202f7102f7102e7102e7102d7102d7102d7102d7102d7102c7102b7102b710020000100001000000000000000000
000100001a050387503b0503c3500e0503a3503a050367501a0503e0500f05007350063500635006350063500735008350093500a3500c3500d3500e350103501135011350043000330001300013000000000000
000100003f7503f7503e7503a75033750267500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000300000f4703f630000001d4703f630000002e4703f6303f6203f6103f6100f4300f4000f4001d4301d4001d4002e4302d5002d5000f400000000f4101d4001f4001d4102e4002f4002e410000000000000000
00030000223702267005600256003237032670326700a6000a6000c6000c60022320226200e6000e6003232032620326200e6000d6000c6000b60022310226100960008600323103261032610056000360001600
00020000300503505034050302502e2502b25027250242501f2401724012220227002770028700201001e10000000000000000000000000000000000000000000000000000000000000000000000000000000000
000300002777001700007001d7703f70000700347703f7003f7003f7003f700277300f7000f7001d7301d7001d700347302d7002d7000f70000700277101d7001f7001d7102e7002f70034710002000020000000
000a00003867028170166500f3400e6300c1200d6100c4100b610091100661004010036100111001600016000160001000010000200002000030000400005000050000600006000060000700009000090000a000
010e00003037101271002110127100271012000110001200303710127100211012710027101200011000000030371012710021101271002710120000000011003037101271002110127100271012000000000000
001600002161001630016301d610016301c6300163001630016301b6101c610016300163019610026300263002630196200263012610026301c62002630026301f620026300263002630026301d6100263002630
0018000004650046400364003640036400464004650046500465004650046500465004650056400464004640356402d640236401b6401764013640106400d6300c6300c6200b6200a62008620066100161001610
010c0000180733c6063c6363460318073186033c63624600180733c6063c6363460318073186033c63624600180733c6063c6363460318073186033c63624600180733c60618073180731807318603180733c636
010c00000036500265003550025500345002450033500235003250022500335002350034500245003550025501365012650135501255013450124501335012350034500245003550025500365002650c3650c265
011800000073000741007510075100751007410073100731007300074100751007510075100741007310073100730007410075100751007510074100731007310073000741007510075100751007410073100731
011800000041300413004230042300433004330044300443004430044300433004330042300423004130041300232007003c2022430200222007003c1020070000212241023c1020030500212002052030500205
011800000017500005001552800500135240050011524005007050000500705280050070524005000052400500005000050011528005001352400500155240050017500005001552800500135240050011524005
000100003d37039460343602f4602a36026450223501b4501935015450113500a4400734004430013300000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000300003f3603a360314502b450244401a4401043006430014200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000c0000283502735025350243502235021340203401f3301d3301b330183301733015330143301333012330113300f3200e32007650075400864007530066300552005620055200462001510016100151001610


__music__
01 50515212
00 41514312
00 50515212
00 50511312
00 4d4e5412
02 41421412
00 41424344
00 41424344
03 10114344

