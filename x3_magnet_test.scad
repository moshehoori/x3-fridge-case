// Xteink X3 fridge-magnet ticker case  (v2: 6 snap-in N52 magnets)
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
tab_l  = 18;      // tab length along the side
bot_win = 46;     // open width at the bottom edge (pogo / bottom keys)
// magnets: 10 x 3 mm round neodymium, inserted from the cavity side before the
// device goes in. A thin skin keeps them hidden and protects the fridge paint.
mag_d = 10.2; mag_t = 3.1; skin = 0.6; mag_x = 22; mag_dy = 30; // 2 columns x 3 rows
// snap-in catches: 3 flexing tongues per pocket hold the magnet without glue.
// Press the magnet in from the cavity side; the ramped lips click over its edge.
catch_prot = 0.4;   // how far each lip overlaps the magnet edge (= tongue deflection)
tongue_t   = 0.8;   // tongue thickness (2 perimeters)
slot_w     = 0.7;   // relief slot behind each tongue, lets it flex outward
sector     = 40;    // angular width of each tongue/lip, degrees
lip_h      = 0.8;   // lip height
catch_extra = 1.5;  // extra tongue length above the magnet (longer tongue = lower strain)
// charging window through the back plate for the magnetic pogo cable (POSITION IS A GUESS:
// measure the contacts on your unit's back and set pogo_x / pogo_y = window centre from the
// back's centre-line / bottom edge)
pogo_on = true; pogo_x = 0; pogo_y = 18; pogo_w = 24; pogo_h = 14;
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
