# stuartpb-loadout

Stuff I wear or otherwise carry with me

## Belt loop buckle

This is a rigid buckle with a middle piece that threads through belt loops, and outer loops, designed to retain belts made of soft fabric. This keeps the fabric straight (instead of letting it bunch up), and makes it possible to thread belts with large clasps / buckles on each end that would otherwise be impractical to thread through belt loops.

I wear seven of these, printed in [AmazingStuffs Black ABS][] with 100% infill, with an elastic [GO Belt (as sold by Meh)][GOBELT].

[AmazingStuffs Black ABS]: https://www.amazon.com/gp/product/B01LYAO0AI/
[GOBELT]: https://meh.com/forum/topics/4-for-tuesday-go-belts-with-pockets

## Watch strap

This watch strap is based on https://www.thingiverse.com/thing:2276049 with the parameters tweaked (resized to fit, render quality bumped to high settings, and the contour switched to a straight sphere), and notches added to the holes and the ends of the strap for collapsing the spring bars (ie. the "helpers" in https://github.com/Stopka/watch-band/blob/master/src/watch-band.scad).

I picked this design because I wanted a breathable, one-piece strap for my Pebble Time. It's sized so that, when relaxed, it gently grips my wrist, and when "stretched", it can fit around my hand to take it off.

The one I'm currently wearing was printed on my Qidi Tech I in [PRILINE Complexion TPU][], sliced in Cura at Extra Fine (0.06mm) with 0 infill, 200C print temperature, 60mm/s travel speed, 40mm/s extrude speed (10mm/s extrude speed for first layer), and 1 normal skirt line. (It *might* have been printable faster, but I didn't want to chance ruining the print.) Keeping the print hollow avoids zits from having the nozzle jump around to add infill, and lets the waves be a bit more flexible: with the printed side facing inward, the final product is fairly comfortable.

[PRILINE Complexion TPU]: https://www.amazon.com/gp/product/B074DTRRXQ/

The final rendered STL for this is 50.8 MiB (which is mostly why I'm not including it in this repo). Rendering it took 6 hours, 47 minutes, 46 seconds on my fairly-beefy AMD FX-8350, probably because it performs sequential hull operations on spheres for *every point in each wave*. There are a *number* of ways this could be refactored for better performance (such as only calculating hulls for a *quarter-cycle* of the wave function, then reusing that form with transformation for each subsequent quarter-wave), but the *best* solution would involve simply extruding a circle along the path (which would also allow for asymmetric inner/outer contours, calculated for a half-cycle), which has been a [long-standing missing feature from OpenSCAD][openscad/openscad#114]: I *could* rewrite the SCAD to use [gringer's module][thing:186660], but, at this point, I already have the STL rendered and the model printed, so I don't particularly care to. (Should I ever need to *re-render* it, I probably would rewrite it, as doing so would probably take less time than waiting for the current implementation to finish rendering again.)

[openscad/openscad#114]: https://github.com/openscad/openscad/issues/114
[thing:186660]: https://www.thingiverse.com/thing:186660
