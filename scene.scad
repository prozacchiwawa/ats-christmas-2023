module House() {
    translate([0,0,50]) {
        cube([200,300,100], center=true);
    }
    translate([0,0,100]) {
        rotate([0,45,0]) {
            cube([137,300,137], center=true);
        }
    }
    translate([50,0,140]) {
        rotate([0,45,0]) {
            cube([150,350,20], center=true);
        }
    }
    translate([0,0,195]) {
        cube([20,350,20], center=true);
    }
    translate([-50,0,140]) {
        rotate([0,-45,0]) {
            cube([150,350,20], center=true);
        }
    }
    translate([0,155,35]) {
        cube([40,10,70], center=true);
    }
    translate([0,-155,35]) {
        cube([40,10,70], center=true);
    }
}

module Snow() {
    translate([-5000,0,0]) {
        scale([0.1,1,1]) {
            cylinder(h = 21.0, r1 = 6000.0, r2 = 0.0, center=true, $fn=5);
          
        }
    }
}

translate([12000,0,7000]) {
    rotate([270, 0, 0]) {
        scale([20,20,20]) {
            rotate([0,0,0]) { House(); }
            Snow();
        }
    }
}
