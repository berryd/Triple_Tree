style = 1; //1 or 2
pattern = 2; //0-5...0 for off
pattern_depth = 3; //mm
boss_style = 1; //1-2
half = false;

smooth = 0; //0-360
pattern_3_inset_percent = 0.9;
pattern_5_bridge = 2.5;

//Note:  all units metric
center_to_center_fork = 214;
outer_clamp_dia = 60;
fork_tube_dia = 50;
c2c_lock_stem = 67;
stem_to_lock_edge = 60.5;
lock_cyl = 30;
lock_od = 40;
lock_flange_thickness = 13;
height = 112;
stem_dia = 22.5;

stem_inner_ring = 20; //default 20
stem_outer_ring = 25; //default 25

base_tree_thickness = 30; //thickness of top half
fork_extension_length = 30;

//FORK CLAMP BOSS
boss_extension_offcenter = 42;
boss_extension_abs = c2c_lock_stem/2;
boss_extension_beef = 8;  //default 8, 0-18
clamp_outer_tang = 14;

//GAUGE MOUNT
gauge_boss_width = 25;
gauge_boss_center_from_edge = 2.5;
gauge_boss_x_offset = 51;

gap = 3;
bevel = 10;

inset_width = 144;

bar_mount_v = 18.5;
bar_mount_h = 45;
bar_mount_large_id = 24;
bar_mount_small_id = 18;
bar_mount_space = 2;

module prism(l, w, h) {
    translate([0, l, 0]) rotate( a= [90, 0, 0])
    linear_extrude(height = l) polygon(points = [
        [0, 0],
        [w, 0],
        [0, h]
    ], paths=[[0,1,2,0]]);
}

module front_bevel() {
    if(boss_style == 1) {
        hull() {
            translate([lock_od/2+bevel-1,-(stem_to_lock_edge/2+bevel),0]) circle(r=bevel, $fn=smooth);
            translate([center_to_center_fork/2-(bevel*2)-boss_extension_beef,-(stem_to_lock_edge/2+bevel),0]) 
                           circle(r=bevel, $fn=smooth);
            translate([lock_od/2,-(stem_to_lock_edge/2+bevel*3),0]) 
                square([(center_to_center_fork/2)-(lock_od/2+bevel)-boss_extension_beef,bevel*2]);    
        }
        difference() {
            translate([0,-(c2c_lock_stem/2)-lock_od/2-bevel/2,0]) square(lock_od,center=true);
            translate([0,-(c2c_lock_stem/2),0]) circle(r=lock_od/2, $fn=smooth);
        }
    }
    if(boss_style == 2) {
        hull() {
            translate([lock_od/2+bevel-1,-(stem_to_lock_edge/2+bevel),0]) circle(r=bevel, $fn=smooth);
            translate([center_to_center_fork/2-(bevel*3)-boss_extension_beef,-(stem_to_lock_edge/2+bevel),0]) 
                           circle(r=bevel, $fn=smooth);
            translate([lock_od/2+bevel,-(stem_to_lock_edge/2+bevel*3),0]) 
                square([(center_to_center_fork/2)-(lock_od/2+bevel)-boss_extension_beef-bevel,bevel*2]);    
        }
        difference() {
            translate([0,-(c2c_lock_stem/2)-lock_od/2-bevel/2,0]) square(lock_od,center=true);
            translate([0,-(c2c_lock_stem/2),0]) circle(r=lock_od/2, $fn=smooth);
        }
    }
}

module basic_shape_half() {
    difference() {
        union() {
            hull() {
                translate([(center_to_center_fork/2),0,0]) circle(r=outer_clamp_dia/2, $fn=smooth);
                translate([0,(c2c_lock_stem/2),0]) circle(r=stem_inner_ring, $fn=smooth);
                translate([-stem_inner_ring,-(outer_clamp_dia/2)]) square([stem_inner_ring,(outer_clamp_dia/2)]);
            }
            translate([0,-(c2c_lock_stem/2),0]) circle(r=lock_od/2, $fn=smooth);
            translate([0,(c2c_lock_stem/2),0]) circle(r=stem_outer_ring, $fn=smooth);
            translate([0,-boss_extension_offcenter]) 
                           square([center_to_center_fork/2+clamp_outer_tang,boss_extension_offcenter]);
        }
        translate([0,(c2c_lock_stem/2),0]) circle(r=stem_dia/2, $fn=smooth);        
        translate([(center_to_center_fork/2),0,0]) circle(r=fork_tube_dia/2, $fn=smooth);
        translate([0,-(c2c_lock_stem/2),0]) circle(r=lock_cyl/2, $fn=smooth);
        translate([(center_to_center_fork/2)-gap,-boss_extension_offcenter-5,0]) square([gap,boss_extension_offcenter]);  
    }
}

module pattern() {
    d =(center_to_center_fork/2-(bevel*2))-(lock_od/2+bevel-2);
    if(pattern == 1) {
        translate([0,0,base_tree_thickness+fork_extension_length-pattern_depth]) 
        linear_extrude(height=pattern_depth) {
            difference() {
                union() {
                    hull() {
                        translate([lock_od/1.25,-lock_od/3,base_tree_thickness+fork_extension_length]) 
                                       circle(r=lock_od/4, $fn=smooth);
                        translate([lock_od*1.675,0,base_tree_thickness+fork_extension_length]) circle(r=lock_od/4, $fn=smooth);
                        translate([lock_od*1.675,-lock_od/3,base_tree_thickness+fork_extension_length]) 
                                       circle(r=lock_od/4, $fn=smooth);
                    }
                    hull() {
                        translate([lock_od/1.25,-lock_od/3,base_tree_thickness+fork_extension_length]) 
                                       circle(r=lock_od/4, $fn=smooth);
                        translate([0,lock_od/5,base_tree_thickness+fork_extension_length]) circle(r=lock_od/4, $fn=smooth);
                        translate([lock_od/2,lock_od/5,base_tree_thickness+fork_extension_length]) 
                                       circle(r=lock_od/4, $fn=smooth);
                    }

                    translate([lock_od+.5,lock_od/3.5-.5,0])
                    rotate([0,0,200])
                    difference() {
                        square(lock_od/2);
                        circle(r=lock_od/4, $fn=smooth);
                    }
                    translate([0,-lock_od/2.5+.5,0])
                    rotate([0,0,45])
                    difference() {
                        square(lock_od/2);
                        circle(r=lock_od/4, $fn=smooth);
                    }
                }
                translate([lock_od+(lock_od/6-3),lock_od/2.5,0]) circle(r=lock_od/2.5, $fn=smooth);
            }
        }
    }
    if(pattern == 2) {
        translate([0,0,base_tree_thickness+fork_extension_length-pattern_depth]) 
        linear_extrude(height=pattern_depth) {
            difference() {
                union() {
                    hull() {
                        translate([lock_od/1.25,-lock_od/3,base_tree_thickness+fork_extension_length]) 
                                       circle(r=lock_od/4, $fn=smooth);
                        translate([lock_od*1.675,0,base_tree_thickness+fork_extension_length]) circle(r=lock_od/4, $fn=smooth);
                        translate([lock_od*1.675,-lock_od/3,base_tree_thickness+fork_extension_length]) 
                                       circle(r=lock_od/4, $fn=smooth);

                        translate([lock_od/1.25,-lock_od/3,base_tree_thickness+fork_extension_length]) 
                                       circle(r=lock_od/4, $fn=smooth);
                        translate([0,lock_od/5,base_tree_thickness+fork_extension_length]) circle(r=lock_od/4, $fn=smooth);
                        translate([lock_od/2,lock_od/5,base_tree_thickness+fork_extension_length]) 
                                       circle(r=lock_od/4, $fn=smooth);
                    }
                    translate([0,-lock_od/2.5+.5,0])
                    rotate([0,0,45])
                    difference() {
                        square(lock_od/2);
                        circle(r=lock_od/4, $fn=smooth);
                    }
                }
                translate([bar_mount_h, bar_mount_v, 0]) circle(r=bar_mount_large_id/2+bevel/2, $fn=smooth);
            }
        }
    }
    if(pattern == 3) {
        translate([0,0,base_tree_thickness+fork_extension_length-pattern_depth])
        linear_extrude(height=pattern_depth) {
            union() {
                difference() {
                    scale([pattern_3_inset_percent, pattern_3_inset_percent-0.01, 0]) {
                        difference() {
                            basic_shape_half();
                            front_bevel();
                            translate([center_to_center_fork/2-(bevel*2)-boss_extension_beef,-(stem_to_lock_edge/2+bevel*2),0]) 
                                             square([d-boss_extension_beef,bevel*2]);
                            translate([bevel*4,-stem_to_lock_edge/2+bevel*2-1,5]) {
                                rotate([0,0,180]) {
                                    translate([0,0,0]) {
                                        difference() {
                                            square([bevel*2,bevel*3]);
                                            translate([bevel/4,0,0]) circle(r=bevel*2, $fn=smooth);
                                        }   
                                    }
                                }
                            }
                        }
                    }
                    translate([(center_to_center_fork/2),0,0]) 
                                   circle(r=outer_clamp_dia/2*(1.1), $fn=smooth);
                    translate([0,-c2c_lock_stem/2,base_tree_thickness+lock_flange_thickness]) 
                                   circle(r=lock_od/2*(1.25), $fn=smooth);
                    translate([0,(c2c_lock_stem/2),0]) circle(r=stem_outer_ring*.95, $fn=smooth);
                    translate([bar_mount_h, bar_mount_v, 0]) circle(r=bar_mount_large_id/2+bevel/2, $fn=smooth);
                }
            }
        }
    }
    if(pattern == 4) {
        translate([0,0,base_tree_thickness+fork_extension_length-pattern_depth])
        linear_extrude(height=pattern_depth) {
            union() {
                difference() {
                    scale([pattern_3_inset_percent, pattern_3_inset_percent-0.01, 0]) {
                        difference() {
                            basic_shape_half();
                            front_bevel();
                            translate([center_to_center_fork/2-(bevel*2)-boss_extension_beef,-(stem_to_lock_edge/2+bevel*2),0]) 
                                             square([d-boss_extension_beef,bevel*2]);
                            translate([bevel*4,-stem_to_lock_edge/2+bevel*2-1,5]) {
                                rotate([0,0,180]) {
                                    translate([0,0,0]) {
                                        difference() {
                                            square([bevel*2,bevel*3]);
                                            translate([bevel/4,0,0]) circle(r=bevel*2, $fn=smooth);
                                        }   
                                    }
                                }
                            }
                        }
                    }
                    translate([(center_to_center_fork/2),0,0]) 
                                   circle(r=outer_clamp_dia/2*(1.1), $fn=smooth);
                    hull() {
                        translate([0,-c2c_lock_stem/2,base_tree_thickness+lock_flange_thickness]) 
                                       circle(r=lock_od/2*(1.25), $fn=smooth);
                        translate([0,(c2c_lock_stem/2),0]) circle(r=stem_outer_ring*.95, $fn=smooth);
                        translate([bar_mount_h, bar_mount_v, 0]) circle(r=bar_mount_large_id/2+bevel/2, $fn=smooth);
                    }
                }
            }
        }
    }
    if(pattern == 5) {
        translate([0,0,base_tree_thickness+fork_extension_length-pattern_depth])
        linear_extrude(height=pattern_depth) {
            union() {
                difference() {
                    scale([pattern_3_inset_percent, pattern_3_inset_percent-0.01, 0]) {
                        difference() {
                            basic_shape_half();
                            front_bevel();
                            translate([center_to_center_fork/2-(bevel*2)-boss_extension_beef,-(stem_to_lock_edge/2+bevel*2),0]) 
                                             square([d-boss_extension_beef,bevel*2]);
                            translate([bevel*4,-stem_to_lock_edge/2+bevel*2-1,5]) {
                                rotate([0,0,180]) {
                                    translate([0,0,0]) {
                                        difference() {
                                            square([bevel*2,bevel*3]);
                                            translate([bevel/4,0,0]) circle(r=bevel*2, $fn=smooth);
                                        }   
                                    }
                                }
                            }
                        }
                    }
                    translate([(center_to_center_fork/2),0,0]) 
                                   circle(r=outer_clamp_dia/2*(1.1), $fn=smooth);
                    translate([0,-c2c_lock_stem/2,base_tree_thickness+lock_flange_thickness]) 
                                   circle(r=lock_od/2*(1.25), $fn=smooth);
                    hull() {
                        translate([0,(c2c_lock_stem/2),0]) circle(r=stem_outer_ring*.95, $fn=smooth);
                        translate([bar_mount_h, bar_mount_v, 0]) circle(r=bar_mount_large_id/2+bevel/2, $fn=smooth);
                    }
                    translate([-height/4+pattern_5_bridge,0,0]) square(height/2, center=true);
                }
            }
        }
    }
}

module triple_tree() {

    module bottom_bevel() {

        y1_path = c2c_lock_stem/2+stem_inner_ring+.5;
        y2_path = outer_clamp_dia/2-y1_path+.5;

        module create_prism() {
            val = 20-stem_inner_ring;
            l = (val !=0 ) ? 100-100*abs(1/(val))-5 :100;
            translate([inset_width/2+bevel/2-1,-l/2,fork_extension_length]) rotate( a= [0, 180, 0]) prism(l, bevel, bevel);
        }

        difference() {
            create_prism();
            translate([.5,0,-1]) linear_extrude(height=base_tree_thickness+fork_extension_length+2)
            polygon(points=[[0,y1_path],[center_to_center_fork/2,y1_path],[center_to_center_fork/2,y1_path+y2_path]], 
                          paths=[[0,1,2]]);
        }

    }

    module extruded() {
        module round_corner() {
            translate([(center_to_center_fork/2)-bevel*2,-bevel*2,-1]) {
                difference() {
                    cube([bevel*2, bevel*2, fork_extension_length+2]);
                    translate([bevel*2, bevel*2, -2]) 
                                   cylinder(base_tree_thickness+fork_extension_length+2,bevel, bevel, $fn=smooth);
                }
            }

        }

        module lock_area_bevel() {
            translate([0,-c2c_lock_stem/2,base_tree_thickness+lock_flange_thickness]) 
                           cylinder(base_tree_thickness-lock_flange_thickness, lock_od/2+1, lock_od/2+1, $fn=smooth);
            translate([bevel*4-bevel/2+1,-stem_to_lock_edge/2+bevel*2-.5,fork_extension_length+5+3]) {
                rotate([0,0,180]) {
                    translate([0,0,5]) {
                        difference() {
                            cube([bevel*2,bevel*3,fork_extension_length+5-lock_flange_thickness]);
                            translate([bevel/4,0,-2.5]) cylinder(fork_extension_length+10, bevel*2, bevel*2, $fn=smooth);
                            translate([bevel*1.5,-bevel/2-2,0]) 
                                           cube([bevel*2,bevel*2,fork_extension_length+5-lock_flange_thickness]);
                        }   
                    }
                }
            }
        }

        module bar_mount() {
            module bar_mount_hole() {
                translate([0,0,base_tree_thickness/2+fork_extension_length+bar_mount_space/2]) 
                               cylinder(base_tree_thickness/2-bar_mount_space/2, bar_mount_small_id/2,
                                             bar_mount_large_id/2, $fn=smooth);
                translate([0,0,fork_extension_length]) 
                               cylinder(base_tree_thickness/2-bar_mount_space/2,bar_mount_large_id/2, 
                                             bar_mount_small_id/2, $fn=smooth);
                translate([0,0,fork_extension_length]) 
                               cylinder(base_tree_thickness,bar_mount_small_id/2, bar_mount_small_id/2, $fn=smooth);
            }
            translate([bar_mount_h, bar_mount_v, 0]) bar_mount_hole();
            translate([-bar_mount_h, bar_mount_v, 0]) bar_mount_hole();
        }

        module gauge_boss() {













        }

        difference() {
            union() {
                difference() {
                    linear_extrude(height=base_tree_thickness+fork_extension_length) {
                        basic_shape_half();
                    }
                    translate([-lock_od,-height/2,-5]) 
                                   cube([inset_width/2+lock_od+4,2*(height+5-height/2),fork_extension_length+5]);
                }
                if( style == 1) {
                    bottom_bevel();
                }
            }
            if (style == 2) {
                difference() {
                    translate([(center_to_center_fork/2)-(inset_width/2+lock_od),0,-5]) 
                                    cube([inset_width/2+lock_od,2*(height+5-height/2),fork_extension_length+5]);
                    translate([(center_to_center_fork/2),0,-10]) cylinder(base_tree_thickness+fork_extension_length+10,
                                    outer_clamp_dia/2+1,outer_clamp_dia/2+1, $fn=smooth);
                }
                translate([-(outer_clamp_dia/4)-6,-(outer_clamp_dia/4)-9,-1]) round_corner();
            }else {
                //Round corner on stem side of lower fork extension
                translate([(center_to_center_fork/2)-outer_clamp_dia/2+bevel-1,outer_clamp_dia/2-bevel+bevel/2,0]) {
                    rotate([0,0,90]) {
                        translate([.5,0,-5]) {
                            difference() {
                                cube([bevel*2,bevel*2,fork_extension_length+5-bevel]);
                                translate([0,0,-2.5]) cylinder(fork_extension_length+10, bevel, bevel, $fn=smooth);
                            }   
                        }
                    }
                }
                //Round corner on lock side of lower fork extension
                if (boss_extension_beef < 11) {
                    translate([((center_to_center_fork/2)-outer_clamp_dia/2+bevel-1)-boss_extension_beef/4,
                                   -outer_clamp_dia/2+bevel-bevel/2+1-boss_extension_beef/6,0]) {
                        rotate([0,0,180]) {
                            translate([0,0,-5]) {
                                difference() {
                                    cube([bevel*2,bevel*2,fork_extension_length+5-bevel]);
                                    translate([0,0,-2.5]) cylinder(fork_extension_length+10, bevel, bevel, $fn=smooth);
                                }   
                            }
                        }
                    }
                }
            }

            translate([0,0,-1]) linear_extrude(height=base_tree_thickness+fork_extension_length+2) {
                front_bevel();
            }

            //slice it in half to get rid of artifacts when mirroring
            translate([-height/2,-height/2-height/4,-5])
                cube([height/2,height+height/2,fork_extension_length+base_tree_thickness+10]);

            bar_mount();
            lock_area_bevel();
        }

    }

    module base_tree() {
        difference() {
            union() {
                extruded();
                if (!half) {
                    mirror([1,0,0]) extruded();
                }
            } 
            union() {
                pattern();
                if (!half) {
                    mirror([1,0,0]) pattern();
                }
            } 
        }
    }
    color("Silver") base_tree();
}

triple_tree();

//translate([0,0,10]) pattern();  mirror([1,0,0]) translate([0,0,10]) pattern();