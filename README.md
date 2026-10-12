# Xteink X3 fridge-magnet case

A printable open-frame case that turns an Xteink X3 into a fridge/door ticker. Four 10 x 3 mm
neodymium magnets sit hidden behind a 0.6 mm skin on the back.

![front](images/front.png) ![back](images/back.png)

## Files
- `x3_case.scad` - parametric OpenSCAD source (edit the values at the top)
- `x3_case.stl` - ready to print
- `old/` - earlier design iterations

## Status: untested
Not yet test-printed or fitted to a real device. Dimensions come from the manufacturer spec
(97.6 x 63.7 x 5.1 mm). Exact positions of the buttons and the back pogo charging contacts are
**not verified**, so the case only grips the corners and leaves the sides, top and bottom edge open.
The solid back plate covers the pogo contacts (slide the device out to charge).
PRs with measurements are welcome.

## Print
Back-down, no supports, 0.2 mm layers or finer, PETG or PLA. Tune `clr` (clearance per side) after a test fit.

## Assembly
1. Glue the 4 magnets into the back pockets from the cavity side (check polarity vs. the X3's own back magnet).
2. Slide the X3 in from the top, bottom edge first. A thumb notch at the top lets you push it out.
