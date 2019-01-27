module ScanseToActobotics() {
    bracket_radius_mm = 25.0;
    bracket_height_mm = 5.0;

    difference() {
        cylinder(h=bracket_height_mm, r=bracket_radius_mm, $fn=256);

        // Actobotics center bore diameter is 0.5 inches (12.7 millimeters)
        // (radius is 0.25 inches (6.35 millimeters))
        cylinder(h=bracket_height_mm, r=6.35, $fn=128);

        // 0.77 Inch hole pattern
        // https://www.servocity.com/hole-pattern-information
        for(angle = [45:90:315]) {
            rotate(a=angle, v=[0,0,1]) {
                // Actobotics 0.77 Inch pattern screw holes are 9.779mm
                // from the center of the center bore
                translate([9.779, 0, 0]) {
                    // Actobotics standard screw hole diameter is 0.14 inches (3.556 millimeters)
                    // (radius is 0.07 inches (1.778 millimeters))
                    cylinder(h=bracket_height_mm, r=1.778, $fn=64);
                }
            }
        }

        // Space for Small Square Screw Plate
        // https://www.servocity.com/small-square-screw-plate
        screw_plate_dimensions = [20.1, 20.1, 3.2];
        screw_plate_z_pos = bracket_height_mm - screw_plate_dimensions.z;
        translate([(-(screw_plate_dimensions.x/2.0)), (-(screw_plate_dimensions.y/2.0)), screw_plate_z_pos]) {
            cube(screw_plate_dimensions);
        }

        // Cutout for Sweep cable to route through center bore
        cable_channel_dimensions = [17.0, 8.0, bracket_height_mm];
        translate([0, -(cable_channel_dimensions.y/2.0), 0]) {
            cube(cable_channel_dimensions);
        }

        // Scanse Sweep mounting holes
        for(angle = [45:90:315]) {
            rotate(a=angle, v=[0,0,1]) {
                // The Sweep mounting holes are 30mm from each other
                // horizontally and vertically, 42.4264mm diagonally.
                translate([21.2132, 0, 0]) {
                    // M2.5 screw holes (2.9mm clearance)
                    cylinder(h=bracket_height_mm, r=1.45, $fn=64);
                    // M2.5 Countersink
                    cylinder(h=2.5, r1=2.6, r2=0, $fn=64);
                }
            }
        }
    }
}

ScanseToActobotics();
