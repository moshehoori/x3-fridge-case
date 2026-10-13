# Xteink X3 fridge-magnet case (v2.1)

A printable open-frame case that turns an Xteink X3 into a fridge/door ticker. **Six N52 10 x 3 mm
neodymium disc magnets snap into pockets on the back, no glue needed**, hidden behind a 0.6 mm skin.

![front](images/front.png) ![back](images/back.png)

## Files
- `x3_case.scad` - parametric OpenSCAD source (edit the values at the top)
- `x3_case.stl` - ready to print (v2.1)
- `x3_magnet_test.stl` - small 2-pocket coupon: print it first to check the magnet snap fit
- `old/` - earlier prototypes (v1 is in the git history)

## What's new in v2.1
- **Charging notch**: 30 x 17 mm notch in the back plate, open at the bottom edge, over the X3's 4-pin
  magnetic pogo connector (centred, about 8 mm up from the bottom edge). The flat plug drops in and the
  cable leaves downwards. The plug must be no thicker than the back plate (about 6.2 mm), or it will lift
  the case off the fridge.
- **Longer magnet catches** (tongues 1.5 mm longer) to cut bending strain from about 2.6% to about 1.4%
  (hand estimate). The back plate is about 1.5 mm thicker as a result.
- **Wider bottom opening** (52 mm) so the corner lips stay clear of the front rocker bars.
- Positions were estimated from photos of other X3 cases (about +-2 mm) and are not measured on a device.

## What's new in v2
- 6 magnets (2 x 3) instead of 4, N52 grade.
- **Snap-in magnet pockets**: each pocket has three flexing tongues with ramped lips (0.4 mm overlap, 0.7 mm relief slots).
  Press a magnet in from the cavity side and it clicks in place. The device snap-hook experiment was dropped
  (see `old/proto_6_device_snap_hooks.scad`); the device is held by the corner lips and gravity as before.
- Re-laid-out back: candlestick chart + "X3 TICKER", clear of the magnet rings.

## Status: untested
Not yet test-printed or fitted to a real device. Dimensions come from the manufacturer spec
(97.6 x 63.7 x 5.1 mm). Exact positions of the buttons and the back pogo charging contacts are
**not verified**, so the case only grips the corners and leaves the sides, top and most of the bottom edge open.
The bottom-row N52 magnets are about 7 mm from the notch and may tug on the magnetic charging plug.
PRs with measurements are welcome.

## Print
Back-down, no supports, 0.2 mm layers or finer. **PETG recommended**: the magnet catches flex about 3-4% strain
once on insertion, which PLA may not tolerate. Tune `clr` (device clearance per side) and `catch_prot`
(magnet catch overlap) after a test print.

## Assembly
1. Press the 6 magnets into the back pockets from the cavity side, all with the same face outward
   (check polarity against the X3's own back magnet). They click past the lips.
2. Slide the X3 in from the top, bottom edge first. A thumb notch at the top lets you push it out from behind.

To remove a magnet, push it out from the outside by piercing the thin skin, or spread a catch with a pick.
N52 is strong but brittle; keep it below ~60 C and don't let two magnets slam together.
