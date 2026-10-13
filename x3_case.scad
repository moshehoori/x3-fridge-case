// Xteink X3 fridge-magnet ticker case  (v2.2: 8 snap-in N52 magnets, charging recess)
// Slide the device in from the top, bottom edge first; gravity keeps it seated on a fridge.
// The front lips only touch the four corners, the sides are open between the corner posts
// (side buttons), the bottom centre is open (front rocker bars) and a recessed bottom strip with a
// small hole lets the magnetic charging plug reach the pogo contacts. Units: mm.
// Device (manufacturer spec): 97.6 x 63.7 x 5.1

dev_h = 97.6; dev_w = 63.7; dev_t = 5.1;
clr    = 0.3;     // clearance per side - tune after a test print
wall   = 2.2;
lip    = 1.6;     // thickness of the front corner lips
lip_o  = 3.0;     // how far the lips overlap the device face
R      = 9;       // outer corner radius
bev    = 2.0;     // outer edge fillet radius
cav_r  = 2.0;     // cavity corner radius (device corners must be >= this)
tab_l  = 18;      // length of each corner post / lip along the side
bot_win = 52;   // open width at the bottom edge: front rocker bars span about +-21 mm
// magnets: 10 x 3 mm round neodymium, inserted from the cavity side before the
// device goes in. A thin skin keeps them hidden and protects the fridge paint.
mag_d = 10.2; mag_t = 3.1; skin = 0.6; mag_x = 22; mag_rows = [-24, 3, 30]; // side columns: y offsets from centre
// 8 magnets: two side columns of 3, plus top and bottom centre (the middle is left for the chart)
mag_pos = concat([for (sx=[-1,1], dy=mag_rows) [sx*mag_x, dy]], [[0, mag_rows[0]], [0, mag_rows[2]]]);
// snap-in catches: 3 flexing tongues per pocket hold the magnet without glue.
// Press the magnet in from the cavity side; the ramped lips click over its edge.
catch_prot = 0.4;   // lip reach into the pocket; overlap on a 10.0 mm magnet = 0.3 mm (= tongue deflection)
tongue_t   = 0.8;   // tongue thickness (2 perimeters)
slot_w     = 0.7;   // relief slot behind each tongue, lets it flex outward
sector     = 40;    // angular width of each tongue/lip, degrees
lip_h      = 0.8;   // lip height
catch_extra = 1.5;  // extra tongue length above the magnet (longer tongue = lower strain)
// charging: the X3's 4-pin magnetic pogo connector sits on the back, centred, about 8 mm up
// from the bottom edge (estimated from photos of other X3 cases). The charging plug is stepped:
// a thin contact nose plus a thicker body with the cable leaving sideways. Only a small hole goes
// through for the nose; the whole bottom strip of the back, edge to edge,
// is recessed from the fridge side, so the plug body sits flush wherever it lands and the cable
// can leave to either side or straight down.
// PRINT NOTE: the recess is open at the bottom and both sides, so it needs supports (build plate only).
pogo_on   = true;
pogo_y    = 10;     // contact centre, from the outer bottom edge
nose_w    = 24; nose_h = 9;   // through-hole for the plug's contact nose (stadium), with tolerance
pogo_skin = 0.8;    // plate left over the recess; the nose must reach through this
band_h    = 17;     // recess height from the outer bottom edge
band_w    = 120;    // recess width; wider than the case = edge to edge, open at both sides
$fn = 72;

zl = skin + mag_t + 0.15 + catch_extra;   // underside of the catch lips (magnet sits below)
back = zl + lip_h;          // back plate thickness
cav_h = dev_h + 2*clr; cav_w = dev_w + 2*clr; cav_t = dev_t + 2*clr;
out_h = cav_h + wall;
out_w = cav_w + 2*wall;
out_t = back + cav_t + lip;

module rrect(w, h, r, t) { // rounded rect, centered x, y from 0
  translate([0, h/2, 0]) hull() for (sx=[-1,1], sy=[-1,1])
    translate([sx*(w/2-r), sy*(h/2-r), 0]) cylinder(r=r, h=t);
}

// outer body: filleted (quarter-round) on the back and front edges
module body() {
  n = 5;
  hull() for (sx=[-1,1], sy=[0,1]) translate([sx*(out_w/2-R), sy*(out_h-2*R)+R, 0]) {
    for (i=[0:n]) {
      a = 90*i/n;
      translate([0,0,bev*(1-cos(a))]) cylinder(r=R-bev+bev*sin(a), h=0.01);
      translate([0,0,out_t-bev*(1-cos(a))-0.01]) cylinder(r=R-bev+bev*sin(a), h=0.01);
    }
  }
}

module candles() { // recessed candlestick chart, rising trend
  // [x, wick_lo, wick_hi, body_lo, body_hi]
  c = [[-12,-8,2,-5,0],[-6,-6,5,-2,3],[0,-3,4,-1,2],[6,-1,10,2,8],[12,3,15,5,13]];
  for (k=c) {
    translate([k[0], k[1], -0.01]) cube([0.9, k[2]-k[1], 0.6], center=false);
    translate([k[0]-0.45, 0, 0]) translate([-1.6, k[3], -0.01]) cube([4.1, k[4]-k[3], 0.6]);
  }
}
module border_groove() { // thin line 2.2 mm in from the back edge
  g = 2.2;
  translate([0,0,-0.01]) difference() {
    rrect(out_w-2*g, out_h-2*g, R-g, 0.4+0.01) ;
    translate([0,0,-1]) rrect(out_w-2*g-1.0, out_h-2*g-1.0, R-g-0.5, 3);
  }
}
module mag_rings() {
  for (m=mag_pos) translate([m[0], out_h/2+m[1], -0.01])
    difference() { cylinder(d=mag_d+4.4, h=0.4); translate([0,0,-1]) cylinder(d=mag_d+3.4, h=3); }
}

module decoration() { // viewed from behind, so mirrored in x
  mirror([1,0,0]) translate([0, out_h/2, 0]) {
    scale([0.8,0.8,1]) candles();
    translate([0, -13.5, -0.01]) linear_extrude(0.6)
      text("X3 TICKER", size=3.8, halign="center", valign="center", font="Liberation Sans:style=Bold");
  }
}

difference() {
  body();
  // cavity, open at the top
  translate([0, wall, back]) hull() {
    for (sx=[-1,1]) translate([sx*(cav_w/2-cav_r), cav_r, 0]) cylinder(r=cav_r, h=cav_t);
    translate([-cav_w/2, cav_h, 0]) cube([cav_w, 1, cav_t]);
  }
  // open the whole front layer; the tabs are added back afterwards
  translate([-out_w, -1, back+cav_t-0.01]) cube([2*out_w, out_h+2, lip+1]);
  // one long side window between the bottom and top corner posts
  for (sx=[-1,1])
    hull() for (yy=[wall+tab_l+cav_t/2, wall+cav_h-tab_l-cav_t/2])
      translate([sx>0 ? cav_w/2-0.01 : -cav_w/2-wall-1.01, yy, back+cav_t/2])
        rotate([0,90,0]) cylinder(d=cav_t, h=wall+1.02, $fn=32);
  // bottom window
  translate([-bot_win/2, -1, back]) cube([bot_win, wall+1.01, cav_t]);
  // magnet pockets, open to the cavity, closed by a thin skin on the outside
  for (m=mag_pos)
    translate([m[0], out_h/2 + m[1], skin]) {
      cylinder(d=mag_d, h=back-skin+0.01);
      // relief slots behind the three tongues
      for (a=[90,210,330]) rotate([0,0,a-sector/2-5]) rotate_extrude(angle=sector+10, $fn=72)
        translate([mag_d/2+tongue_t, 0]) square([slot_w, back-skin+0.01]);
    }
  // charging: bottom recess from the fridge side + small through-hole for the plug nose
  if (pogo_on) {
    translate([0, -1, -1]) hull() {
      for (sx=[-1,1]) translate([sx*(band_w/2-3), band_h+1-3, 0]) cylinder(r=3, h=back-pogo_skin+1);
      translate([-band_w/2, 0, 0]) cube([band_w, 1, back-pogo_skin+1]);
    }
    translate([0, pogo_y, -1]) hull() for (sx=[-1,1])
      translate([sx*(nose_w-nose_h)/2, 0, 0]) cylinder(d=nose_h, h=back+2);
  }
  // thumb notch to push the device out from behind
  translate([0, out_h, -1]) cylinder(d=14, h=back+2);
  decoration();
  mirror([1,0,0]) border_groove();
  mag_rings();
}

// front corner lips: cut from a bezel outline with rounded inner corners and a beveled
// edge, then trimmed to the four corners (open top for slide-in, open sides and bottom centre)
module win2d(c) { // screen window outline, grown by c; runs off the top edge
  offset(r=c) union() {
    hull() for (sx=[-1,1])
      translate([sx*(cav_w/2-lip_o-5), wall+lip_o+5]) circle(r=5);
    translate([-(cav_w/2-lip_o), wall+lip_o+5]) square([cav_w-2*lip_o, out_h]);
  }
}
module lip_frame() {
  z0 = back + cav_t; bv = 0.9;
  intersection() {
    body();
    difference() {
      translate([-out_w, -5, z0-0.01]) cube([2*out_w, out_h+10, lip+0.01]);
      hull() {
        translate([0,0,z0-0.02]) linear_extrude(0.01) win2d(0);
        translate([0,0,z0+lip-0.01]) linear_extrude(0.02) win2d(bv);
      }
      translate([-bot_win/2, -5, z0-0.1]) cube([bot_win, wall+lip_o+5.5, lip+1]);
      // no lip along the middle of the sides: side buttons stay free
      translate([-out_w, wall+tab_l, z0-0.1]) cube([2*out_w, cav_h-2*tab_l, lip+1]);
    }
  }
}
lip_frame();

// snap-in lips: ramp on top for easy press-in, flat underside holds the magnet
module mag_catches() {
  for (m=mag_pos) translate([m[0], out_h/2 + m[1], skin])
    for (a=[90,210,330]) rotate([0,0,a-sector/2]) translate([0,0,-skin]) rotate_extrude(angle=sector, $fn=72)
      polygon([[mag_d/2+0.2, zl], [mag_d/2-catch_prot, zl], [mag_d/2-catch_prot, zl+0.25], [mag_d/2+0.2, back]]);
}
mag_catches();
