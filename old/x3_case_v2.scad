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
R      = 7;       // outer corner radius
bev    = 1.0;     // outer chamfer
cav_r  = 2.0;     // cavity corner radius (device corners must be >= this)
tab_l  = 16;      // tab length along the side
bot_win = 38;     // open width at the bottom edge (pogo / bottom keys)
// magnets: 10 x 3 mm round neodymium, inserted from the cavity side before the
// device goes in. A thin skin keeps them hidden and protects the fridge paint.
mag_d = 10.2; mag_t = 3.1; skin = 0.6; mag_x = 21; mag_dy = 17;
$fn = 72;

back = skin + mag_t + 0.2; // back plate: skin + magnet + 0.2 recess
cav_h = dev_h + 2*clr; cav_w = dev_w + 2*clr; cav_t = dev_t + 2*clr;
out_h = cav_h + wall;
out_w = cav_w + 2*wall;
out_t = back + cav_t + lip;

module rrect(w, h, r, t) { // rounded rect, centered x, y from 0
  translate([0, h/2, 0]) hull() for (sx=[-1,1], sy=[-1,1])
    translate([sx*(w/2-r), sy*(h/2-r), 0]) cylinder(r=r, h=t);
}

// outer body: chamfered on the back and front edges
module body() {
  hull() for (sx=[-1,1], sy=[0,1]) translate([sx*(out_w/2-R), sy*(out_h-2*R)+R, 0]) {
    cylinder(r1=R-bev, r2=R, h=bev);
    translate([0,0,bev]) cylinder(r=R, h=out_t-2*bev);
    translate([0,0,out_t-bev]) cylinder(r1=R, r2=R-bev, h=bev);
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

module sparkline() { // recessed ticker trend line + dot on the back face
  pts = [[-12,-9],[-8,-4],[-5,-7],[-1,1],[3,-2],[7,6],[12,3]];
  d = 1.4; h = 0.6;
  for (i=[0:len(pts)-2]) hull() {
    translate([pts[i][0],   pts[i][1],   -0.01]) cylinder(d=d, h=h);
    translate([pts[i+1][0], pts[i+1][1], -0.01]) cylinder(d=d, h=h);
  }
  translate([12, 3, -0.01]) cylinder(d=3.4, h=h);
}

module decoration() { // viewed from behind, so mirrored in x
  mirror([1,0,0]) translate([0, out_h/2, 0]) {
    sparkline();
    translate([0, -25, -0.01]) linear_extrude(0.6)
      text("X3 TICKER", size=4.2, halign="center", valign="center", font="Liberation Sans:style=Bold");
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
  // side windows between the tabs
  for (sx=[-1,1], w=[[wall+tab_l, wall+cav_h/2-tab_l/2],
                     [wall+cav_h/2+tab_l/2, wall+cav_h-tab_l]])
    translate([sx>0 ? cav_w/2-0.01 : -cav_w/2-wall-1.01, w[0]+1.5, back])
      cube([wall+1.02, w[1]-w[0]-3, cav_t]);
  // bottom window
  translate([-bot_win/2, -1, back]) cube([bot_win, wall+1.01, cav_t]);
  // magnet pockets, open to the cavity, closed by a thin skin on the outside
  for (sx=[-1,1], sy=[-1,1])
    translate([sx*mag_x, out_h/2 + sy*mag_dy, skin]) cylinder(d=mag_d, h=back-skin+0.01);
  // thumb notch to push the device out from behind
  translate([0, out_h, -1]) cylinder(d=14, h=back+2);
  decoration();
}

// front tabs, clipped to the body outline
intersection() { tabs(); body(); }

// retention bumps near the top of the upper tabs
for (sx=[-1,1]) translate([sx*(cav_w/2), wall+cav_h-6, back+cav_t/2]) sphere(d=1.0, $fn=24);
