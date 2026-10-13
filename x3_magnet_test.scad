// Magnet test coupon for the Xteink X3 fridge case, header copied from x3_case.scad  (v2.3: 8 snap-in 8x3 mm magnets, flat back, charging hole)
// Slide the device in from the top, bottom edge first; gravity keeps it seated on a fridge.
// The front lips only touch the four corners, the sides are open between the corner posts
// (side buttons), the bottom centre is open (front rocker bars) and a hole in the back lets the
// magnetic charging plug reach the pogo contacts. Units: mm.
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
// side buttons (right one about 40% down from the top) sit in the open side windows once seated;
// these grooves keep them from being pressed while sliding past the top corner posts
btn_relief = 0.8; btn_relief_h = 4.0;   // groove depth into the wall, groove height
// magnets: 8 x 3 mm round neodymium discs (any grade, N35-N52; the grade only changes strength), inserted from the cavity side before the
// device goes in. A thin skin keeps them hidden and protects the fridge paint.
mag_d = 8.2; mag_t = 3.1; skin = 0.6; mag_x = 22; mag_rows = [-24, 3, 30]; // side columns: y offsets from centre
// 8 magnets: two side columns of 3, plus top and bottom centre (the middle is left for the chart)
mag_pos = concat([for (sx=[-1,1], dy=mag_rows) [sx*mag_x, dy]], [[0, mag_rows[0]], [0, mag_rows[2]]]);
// snap-in catches: 3 flexing tongues per pocket hold the magnet without glue.
// Press the magnet in from the cavity side; the ramped lips click over its edge.
catch_prot = 0.4;   // lip reach into the pocket; overlap on an 8.0 mm magnet = 0.3 mm (= tongue deflection)
tongue_t   = 0.8;   // tongue thickness (2 perimeters)
slot_w     = 0.7;   // relief slot behind each tongue, lets it flex outward
sector     = 40;    // angular width of each tongue/lip, degrees
lip_h      = 0.8;   // lip height
catch_extra = 1.5;  // extra tongue length above the magnet (longer tongue = lower strain)
// charging: the X3's 4-pin magnetic pogo connector sits on the back, centred, about 8 mm up
// from the bottom edge (estimated from photos of other X3 cases). A stadium hole goes straight
// through the flat back plate; the plug has to reach the contacts through the full plate thickness.
pogo_on   = true;
pogo_y    = 10;     // contact centre, from the outer bottom edge
nose_w    = 24; nose_h = 9;   // through-hole for the charging plug (stadium), with tolerance
$fn = 72;

zl = skin + mag_t + 0.15 + catch_extra;   // underside of the catch lips (magnet sits below)
back = zl + lip_h;          // back plate thickness

// Magnet snap test coupon: print this first (PETG), press two magnets in from the top.
module pocket_cut() { translate([0,0,skin]) {
  cylinder(d=mag_d, h=back-skin+0.01);
  for (a=[90,210,330]) rotate([0,0,a-sector/2-5]) rotate_extrude(angle=sector+10, $fn=72)
    translate([mag_d/2+tongue_t, 0]) square([slot_w, back-skin+0.01]);
}}
module lips() {
  for (a=[90,210,330]) rotate([0,0,a-sector/2]) rotate_extrude(angle=sector, $fn=72)
    polygon([[mag_d/2+0.2, zl], [mag_d/2-catch_prot, zl], [mag_d/2-catch_prot, zl+0.25], [mag_d/2+0.2, back]]);
}
for (x=[-1,1]) translate([x*13, 0, 0]) {
  difference() { translate([-12,-12,0]) cube([24,24,back]); pocket_cut(); }
  lips();
}
