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