# Xteink X3 fridge-magnet case (v2.4)

A printable open-frame case that turns an Xteink X3 into a fridge/door ticker. **Eight 8 x 3 mm
neodymium disc magnets snap into pockets on the back, no glue needed**, hidden behind a 0.6 mm skin.

![front](images/front.png) ![back](images/back.png)

## Files
- `x3_case.scad` - parametric OpenSCAD source (edit the values at the top)
- `x3_case.stl` - ready to print (v2.4)
- `x3_magnet_test.stl` - small 2-pocket coupon: print it first to check the magnet snap fit
- `old/` - earlier prototypes (v1 is in the git history)

## Magnets
The pockets fit 8 mm diameter x 3 mm thick discs (pocket 8.2 x 3.1 mm). The grade (N35, N42, N52...)
only changes strength, not size, so any 8 x 3 disc fits. N52 is the strongest common grade and is
recommended so the 58 g X3 plus case holds well on a fridge. Check the listed size tolerance; discs
sold as 8 x 3 are usually within +-0.1 mm.

## What's new in v2.4
- **Pockets resized for 8 x 3 mm magnets** (were 10 x 3). Same 8 positions; the test coupon is regenerated.
  Eight N52 8 x 3 discs still hold far more than the ~100 g case plus X3. To use 10 x 3 magnets, set `mag_d = 10.2`.
- **Side button relief**: once seated, both side buttons sit in the open side windows (nothing touches
  them between 23 and 80 mm up the side). New 0.8 mm deep x 4 mm tall grooves in the inner wall of the two
  top corner posts let the buttons slide past without being pressed while the X3 goes in from the top.

## v2.3
- **Flat back**: the v2.2 charging recess is gone. The 24 x 9 mm hole over the pogo connector stays and
  now goes through the full ~6.2 mm back plate. No supports needed.

## v2.2
- **8 magnets**: two side columns of 3, plus top-centre and bottom-centre.
- **Charging recess**: the bottom 17 mm of the back is recessed edge to edge (5.35 mm deep) from the
  fridge side, with a small 24 x 9 mm hole for the plug's contact nose over the X3's 4-pin pogo connector.
  The plug body sits flush wherever it lands and the cable can leave to either side or straight down.
  This replaces v2.1's through-notch, the same way other X3 cases use a small rear opening.
- Wider bottom opening (52 mm) so the corner lips stay clear of the front rocker bars.
- Cleanups: removed dead code, fixed stale comments, regenerated the test coupon.

## Status: untested
Not yet test-printed or fitted to a real device. Dimensions come from the manufacturer spec
(97.6 x 63.7 x 5.1 mm). Button and connector positions were estimated from photos of other X3 cases
(about +-2 mm), not measured on a device. The case only grips the four corners and leaves the sides,
top and bottom centre of the front open. Nothing stops the X3 sliding out of the top; on a fridge,
gravity keeps it seated.

Charging: the hole goes through the whole ~6.2 mm back plate, so the plug has to fit into the
24 x 9 mm hole far enough to touch the contacts. Not checked against a real plug. Otherwise take the
X3 out of the case to charge.

## Print
Back-down, 0.2 mm layers or finer. No supports needed.
With a 0.4 mm nozzle, use Arachne / variable-width walls (default in current PrusaSlicer, OrcaSlicer and
Cura) or a 0.4 mm perimeter width, so the 0.8 mm magnet tongues print as two solid lines. The 0.5 mm
back grooves (magnet rings, border line) may close up on the first layer; that is only cosmetic. **PETG recommended**: the magnet catches
flex once on insertion (hand estimate about 1.4% strain), which PLA may not tolerate.
Tune `clr` (device clearance per side) and `catch_prot` (magnet catch overlap) after a test print.

## Assembly
1. Press the 8 magnets into the back pockets from the cavity side, all with the same face outward
   (check polarity against the X3's own back magnet). They click past the lips.
2. Slide the X3 in from the top, bottom edge first. A thumb notch at the top lets you push it out from behind.
3. To charge, attach the magnetic plug through the hole at the bottom of the back.

To remove a magnet, push it out from the outside by piercing the thin skin, or spread a catch with a pick.
N52 is strong but brittle; keep it below ~60 C and don't let two magnets slam together.
