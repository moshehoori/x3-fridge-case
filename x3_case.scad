// Xteink X3 fridge-magnet ticker case  (v2)
// Slide the device in from the top, bottom edge first. Units: mm.
// Sides and bottom edge are open between small retaining tabs, so side buttons,
// bottom keys and the magnetic pogo charging contacts stay reachable.
// Device (manufacturer spec): 97.6 x 63.7 x 5.1

dev_h = 97.6; dev_w = 63.7; dev_t = 5.1;
clr    = 0.3;     // clearance per side - tune after a test print
wall   = 2.2;
lip    = 1.6;     // thickness of front tabs
lip_o  = 3.0;     // how far tabs overlap the device face
R      = 9;       // outer corner radius
bev    = 2.0;     // outer edge fillet radius
cav_r  = 2.0;     // cavity corner radius (device corners must be >= this)
tab_l  = 14;      // tab length along the side
bot_win = 46;     // open width at the bottom edge (pogo / bottom keys)
// magnets: N52 10 x 3 mm round neodymium, inserted from the cavity side before the
// device goes in. A thin skin keeps them hidden and protects the fridge paint.
// N52 grade 10 x 3 mm discs
mag_d = 10.2; mag_t = 3.1; skin = 0.6; mag_x = 22; mag_dy = 30; // 6 magnets: 2 columns x 3 rows
// snap-fit: two flexing hooks at the top corners. Hook the bottom edge under the
// bottom lips first, then press the top edge down until the hooks click over it.
snap_t = 1.5;     // beam thickness (flexes sideways, printed flat = strong)
snap_anchor = 5;  // beam root, fixed to the back plate
snap_free = 19;   // free (flexing) length
snap_gap = 0.8;   // air gap under the free part of the beam
snap_hook = 1.0;  // how far the hook overlaps the device face (= deflection)
snap_w = 7;       // hook length along the edge
snap_up = 6;      // hook distance below the top edge (where the rounded corner ends)
$fn = 72;

back = skin + mag_t + 0.2; // back plate: skin + magnet + 0.2 recess
cav_h = dev_h + 2*clr; cav_w = dev_w + 2*clr; cav_t = dev_t + 2*clr;
out_h = cav_h + wall;
out_w = cav_w + 2*wall;
out_t = back + cav_t + lip;
top_l = snap_anchor + snap_free;

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

// one front tab with a chamfered inner edge; extends past the body, which clips it
module tab(x0, x1, y0, y1) {
  c = 0.7;
  z0 = back + cav_t;
  hull() {
    translate([x0, y0, z0 - 0.01]) cube([x1-x0, y1-y0, lip - c]);
    translate([x0 + (x0 < 0 ? 0 : c), y0 + c, z0 - 0.01]) cube([x1-x0 - c, y1-y0 - 2*c, lip + 0.01]);
  }
}

module tabs() {
  yA = wall; 
  ranges = [[wall, wall+tab_l],
            [wall+cav_h/2-tab_l/2, wall+cav_h/2+tab_l/2],
            [wall+cav_h-tab_l, wall+cav_h]];
  for (sx=[-1,1], r=ranges) {
    xin = sx*(cav_w/2 - lip_o);
    xout = sx*(out_w/2 + 5);
    tab(min(xin,xout), max(xin,xout), r[0], r[1]);
  }
  // bottom corner tabs, leaving the middle open
  for (sx=[-1,1]) {
    xin = sx*bot_win/2; xout = sx*(out_w/2+5);
    tab(min(xin,xout), max(xin,xout), -5, wall + lip_o);
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
  for (sx=[-1,1], sy=[-1,0,1]) translate([sx*mag_x, out_h/2+sy*mag_dy, -0.01])
    difference() { cylinder(d=mag_d+4.4, h=0.4); translate([0,0,-1]) cylinder(d=mag_d+3.4, h=3); }
}

module decoration() { // viewed from behind, so mirrored in x
  mirror([1,0,0]) translate([0, out_h/2, 0]) translate([0,0,0]) {
    scale([0.8,0.8,1]) candles();
    translate([0, -43, -0.01]) linear_extrude(0.6)
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
    hull() for (yy=[wall+tab_l+cav_t/2, out_h-top_l-cav_t/2])
      translate([sx>0 ? cav_w/2-0.01 : -cav_w/2-wall-1.01, yy, back+cav_t/2])
        rotate([0,90,0]) cylinder(d=cav_t, h=wall+1.02, $fn=32);
  // flexing beams at the top corners: remove the outer wall skin and the gap under the free part
  for (sx=[-1,1]) {
    translate([sx>0 ? cav_w/2+snap_t : -cav_w/2-wall-1, out_h-top_l-0.3, back]) cube([wall-snap_t+1, top_l+1.3, out_t]);
    translate([sx>0 ? cav_w/2-0.01 : -cav_w/2-snap_t-0.01, out_h-top_l+snap_anchor, back-0.01]) cube([snap_t+0.02, top_l, snap_gap+0.01]);
  }
  // bottom window
  translate([-bot_win/2, -1, back]) cube([bot_win, wall+1.01, cav_t]);
  // magnet pockets, open to the cavity, closed by a thin skin on the outside
  for (sx=[-1,1], sy=[-1,0,1])
    translate([sx*mag_x, out_h/2 + sy*mag_dy, skin]) cylinder(d=mag_d, h=back-skin+0.01);
  // thumb notch to push the device out from behind
  translate([0, out_h, -1]) cylinder(d=14, h=back+2);
  decoration();
  mirror([1,0,0]) translate([0,0,0]) { translate([0,0,0]) border_groove(); }
  mag_rings();
}

// front bezel: one continuous U-shaped frame with rounded inner corners and a
// beveled screen edge; open at the top (slide-in) and the bottom centre (pogo/keys)
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
      // lip only along the bottom edge (tilt-in hook); sides stay free
      translate([-out_w, wall+lip_o+1.0, z0-0.1]) cube([2*out_w, out_h, lip+1]);
    }
  }
}
lip_frame();

// snap hooks (ramp on top for easy press-in, flat underside holds the device)
module hook(sx) {
  z0 = back + cav_t; xi = cav_w/2 - snap_hook; xb = cav_w/2 + snap_t;
  mirror([sx<0 ? 1 : 0, 0, 0])
    translate([0, out_h - snap_up, 0]) rotate([90,0,0]) linear_extrude(snap_w)
      polygon([[xb-0.3, z0-0.2], [cav_w/2+0.3, z0-0.2], [cav_w/2+0.3, z0], [xi, z0], [xi, z0+0.5], [cav_w/2+0.2, z0+lip], [xb-0.3, z0+lip]]);
}
hook(1); hook(-1);
