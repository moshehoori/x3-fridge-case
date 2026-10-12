# Xteink X3 fridge-magnet case

A printable snap-fit, open-frame case that turns an Xteink X3 into a fridge/door ticker. Six N52
10 x 3 mm neodymium disc magnets sit hidden behind a 0.6 mm skin on the back.

![front](images/front.png) ![back](images/back.png)

## Files
- `x3_case.scad` - parametric OpenSCAD source (edit the values at the top)
- `x3_case.stl` - ready to print
- `old/` - earlier design iterations

## Status: untested
Not yet test-printed or fitted to a real device. Dimensions come from the manufacturer spec
(97.6 x 63.7 x 5.1 mm). Exact positions of the buttons and the back pogo charging contacts are
**not verified**, so the case only touches the bottom corners and two top-corner hooks, leaving the sides, top and most of the bottom edge open.
The solid back plate covers the pogo contacts (slide the device out to charge).
PRs with measurements are welcome.

## Print
Back-down, no supports, 0.2 mm layers or finer. **PETG recommended** for the snap hooks (PLA works but is more brittle).
Tune `clr` (clearance per side) and `snap_hook` (hook overlap) after a test fit.

## Assembly
1. Glue the 6 N52 magnets into the back pockets from the cavity side (check polarity vs. the X3's own back magnet).
2. Hook the X3's bottom edge under the two bottom lips, tilted slightly, then press the top edge down until the two
   flexing hooks at the top corners click over it.
3. To remove: spread a top hook sideways with a fingernail, or push the device out through the thumb notch from behind.

## Snap-fit details
Two cantilever beams (1.5 mm thick, ~19 mm free length, deflection 1.0 mm, about 1% strain) are printed flat in the XY
plane so they flex along the layer lines. Each has a ramped hook: ramp for easy press-in, flat underside to hold.
N52 is the strongest common grade but brittle; keep it below ~60 C and don't let two magnets snap together.
