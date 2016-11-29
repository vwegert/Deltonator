// GENERATED FILE, DO NOT EDIT MANUALLY
include <../../conf/part_sizes.scad>
include <../../conf/derived_sizes.scad>
echo("----- conf/part_sizes.scad ----------------------------------------");
echo(vslot_2020_depth = vslot_2020_depth());
echo(vslot_2020_width = vslot_2020_width());
echo(vslot_2020_edge_radius = vslot_2020_edge_radius());
echo(vslot_2020_edge_resolution = vslot_2020_edge_resolution());
echo(vslot_2020_slot_offset = vslot_2020_slot_offset());
echo(makerslide_base_depth = makerslide_base_depth());
echo(makerslide_base_width = makerslide_base_width());
echo(makerslide_rail_depth = makerslide_rail_depth());
echo(makerslide_rail_width = makerslide_rail_width());
echo(makerslide_depth = makerslide_depth());
echo(makerslide_width = makerslide_width());
echo(makerslide_rail_edge_distance = makerslide_rail_edge_distance());
echo(makerslide_edge_radius = makerslide_edge_radius());
echo(makerslide_edge_resolution = makerslide_edge_resolution());
echo(makerslide_slot_offset = makerslide_slot_offset());
echo(insert_outer_diameter_m3 = insert_outer_diameter_m3());
echo(insert_inner_diameter_m3 = insert_inner_diameter_m3());
echo(vmotor_size = vmotor_size());
echo(vmotor_width = vmotor_width());
echo(vmotor_height = vmotor_height());
echo(vmotor_shaft_length = vmotor_shaft_length());
echo(vmotor_mounting_hole_diameter = vmotor_mounting_hole_diameter());
echo(vmotor_mounting_hole_resolution = vmotor_mounting_hole_resolution());
echo(vmotor_screw_distance = vmotor_screw_distance());
echo(vmotor_screw_size = vmotor_screw_size());
echo(gt2_belt_width = gt2_belt_width());
echo(gt2_belt_thickness_max = gt2_belt_thickness_max());
echo(gt2_belt_groove_depth = gt2_belt_groove_depth());
echo(gt2_belt_thickness_min = gt2_belt_thickness_min());
echo(gt2_pulley_diameter = gt2_pulley_diameter());
echo(gt2_pulley_depth = gt2_pulley_depth());
echo(gt2_pulley_base_depth = gt2_pulley_base_depth());
echo(gt2_pulley_inner_diameter_max = gt2_pulley_inner_diameter_max());
echo(gt2_pulley_inner_diameter_min = gt2_pulley_inner_diameter_min());
echo(bearing_625_bore_diameter = bearing_625_bore_diameter());
echo(bearing_625_outer_diameter = bearing_625_outer_diameter());
echo(bearing_625_width = bearing_625_width());
echo(bearing_f623_bore_diameter = bearing_f623_bore_diameter());
echo(bearing_f623_outer_diameter = bearing_f623_outer_diameter());
echo(bearing_f623_flange_diameter = bearing_f623_flange_diameter());
echo(bearing_f623_width = bearing_f623_width());
echo(vwheel_spacer_hex_height = vwheel_spacer_hex_height());
echo(vwheel_spacer_inset_height = vwheel_spacer_inset_height());
echo(vwheel_spacer_total_height = vwheel_spacer_total_height());
echo(vwheel_spacer_hex_size = vwheel_spacer_hex_size());
echo(vwheel_spacer_inset_diameter = vwheel_spacer_inset_diameter());
echo(vwheel_spacer_bore_diameter = vwheel_spacer_bore_diameter());
echo(vwheel_width = vwheel_width());
echo(vwheel_inner_bevel_width = vwheel_inner_bevel_width());
echo(vwheel_bearing_inset = vwheel_bearing_inset());
echo(vwheel_assembly_thickness = vwheel_assembly_thickness());
echo(vwheel_assembly_overhang = vwheel_assembly_overhang());
echo(vwheel_pair_center_distance = vwheel_pair_center_distance());
echo(vwheel_depth_offset = vwheel_depth_offset());
echo(vwheel_width_offset = vwheel_width_offset());
echo(vwheel_max_mounting_hole_size = vwheel_max_mounting_hole_size());
echo(ball_diameter = ball_diameter());
echo(magnet_outer_diameter = magnet_outer_diameter());
echo(magnet_height = magnet_height());
echo(magnet_bore_diameter = magnet_bore_diameter());
echo(magnet_bevel_diameter = magnet_bevel_diameter());
echo(magnet_bevel_angle = magnet_bevel_angle());
echo(rod_outer_diameter = rod_outer_diameter());
echo(rod_inner_diameter = rod_inner_diameter());
echo(switch_ss5gl_thickness = switch_ss5gl_thickness());
echo(switch_ss5gl_width = switch_ss5gl_width());
echo(switch_ss5gl_body_height = switch_ss5gl_body_height());
echo(switch_ss5gl_hole_edge_distance = switch_ss5gl_hole_edge_distance());
echo(switch_ss5gl_hole_bottom_distance = switch_ss5gl_hole_bottom_distance());
echo(switch_ss5gl_hole_distance = switch_ss5gl_hole_distance());
echo(switch_ss5gl_hole_diameter = switch_ss5gl_hole_diameter());
echo("----- conf/derived_sizes.scad ----------------------------------------");
echo(vertical_extrusion_length = vertical_extrusion_length());
echo(horizontal_extrusion_length = horizontal_extrusion_length());
echo(horizontal_extrusion_offset = horizontal_extrusion_offset());
echo(horizontal_base_length = horizontal_base_length());
echo(horizontal_base_height = horizontal_base_height());
echo(horizontal_distance_center_edge = horizontal_distance_center_edge());
echo(horizontal_distance_center_corner = horizontal_distance_center_corner());
echo(makerslide_clearance = makerslide_clearance());
echo(rod_distance = rod_distance());
echo(magnet_bevel_depth = magnet_bevel_depth());
echo(ball_contact_circle_diameter = ball_contact_circle_diameter());
echo(ball_contact_circle_height = ball_contact_circle_height());
echo(magnet_contact_circle_depth = magnet_contact_circle_depth());
echo(ball_center_magnet_base_distance = ball_center_magnet_base_distance());
echo(horizontal_vertical_extrusion_gap = horizontal_vertical_extrusion_gap());
echo(frame_wall_thickness = frame_wall_thickness());
echo(horizontal_recess_depth = horizontal_recess_depth());
echo(horizontal_screw_distance = horizontal_screw_distance());
echo(foot_makerslide_recess_depth = foot_makerslide_recess_depth());
echo(motor_bracket_height = motor_bracket_height());
echo(motor_bracket_edge_radius = motor_bracket_edge_radius());
echo(motor_bracket_edge_resolution = motor_bracket_edge_resolution());
echo(motor_bracket_z_offset = motor_bracket_z_offset());
echo(bed_bracket_height = bed_bracket_height());
echo(bed_bracket_z_offset = bed_bracket_z_offset());
echo(bed_bracket_top_level = bed_bracket_top_level());
echo(bed_working_height = bed_working_height());
echo(head_makerslide_recess_depth = head_makerslide_recess_depth());
echo(head_guide_width = head_guide_width());
echo(head_guide_depth = head_guide_depth());
echo(head_guide_clearance = head_guide_clearance());
echo(head_z_offset = head_z_offset());
echo(carriage_plate_thickness = carriage_plate_thickness());
echo(carriage_plate_border_width = carriage_plate_border_width());
echo(carriage_wheel_distance_x = carriage_wheel_distance_x());
echo(carriage_wheel_distance_y = carriage_wheel_distance_y());
echo(carriage_plate_width = carriage_plate_width());
echo(carriage_plate_height = carriage_plate_height());
echo(carriage_plate_edge_radius = carriage_plate_edge_radius());
echo(carriage_plate_edge_resolution = carriage_plate_edge_resolution());
echo(carriage_wheel1_y = carriage_wheel1_y());
echo(carriage_wheel1_z = carriage_wheel1_z());
echo(carriage_wheel2_y = carriage_wheel2_y());
echo(carriage_wheel2_z = carriage_wheel2_z());
echo(carriage_wheel3_y = carriage_wheel3_y());
echo(carriage_wheel3_z = carriage_wheel3_z());
echo(carriage_wheel1_hole_diameter = carriage_wheel1_hole_diameter());
echo(carriage_wheel2_hole_diameter = carriage_wheel2_hole_diameter());
echo(carriage_wheel3_hole_diameter = carriage_wheel3_hole_diameter());
echo(carriage_wheel_hole_resolution = carriage_wheel_hole_resolution());
echo(carriage_belt_holder_depth = carriage_belt_holder_depth());
echo(carriage_belt_holder_height = carriage_belt_holder_height());
echo(carriage_belt_holder_width = carriage_belt_holder_width());
echo(carriage_belt_holder_center_offset = carriage_belt_holder_center_offset());
echo(carriage_belt_holder_outer_width = carriage_belt_holder_outer_width());
echo(carriage_belt_holder_channel_height = carriage_belt_holder_channel_height());
echo(carriage_belt_holder_channel_width = carriage_belt_holder_channel_width());
echo(carriage_belt_holder_path_width = carriage_belt_holder_path_width());
echo(carriage_belt_holder_center_height = carriage_belt_holder_center_height());
echo(carriage_belt_holder_edge_radius = carriage_belt_holder_edge_radius());
echo(carriage_belt_holder_small_edge_radius = carriage_belt_holder_small_edge_radius());
echo(carriage_belt_holder_edge_resolution = carriage_belt_holder_edge_resolution());
echo(carriage_lower_belt_holder_z = carriage_lower_belt_holder_z());
echo(carriage_upper_belt_holder_z = carriage_upper_belt_holder_z());
echo(carriage_belt_holder_insert_hole_diameter = carriage_belt_holder_insert_hole_diameter());
echo(carriage_belt_holder_insert_hole_distance = carriage_belt_holder_insert_hole_distance());
echo(carriage_belt_holder_insert_x = carriage_belt_holder_insert_x());
echo(carriage_belt_holder_insert_y = carriage_belt_holder_insert_y());
echo(carriage_tensioner_gap_width = carriage_tensioner_gap_width());
echo(carriage_tensioner_gap_height = carriage_tensioner_gap_height());
echo(carriage_x_offset = carriage_x_offset());
echo(carriage_ball_holder_width = carriage_ball_holder_width());
echo(carriage_ball_holder_height = carriage_ball_holder_height());
echo(carriage_ball_holder_depth = carriage_ball_holder_depth());
echo(carriage_ball_holder_angle = carriage_ball_holder_angle());
echo(carriage_ball_holder_joint_inner_width = carriage_ball_holder_joint_inner_width());
echo(carriage_ball_holder_joint_outer_width = carriage_ball_holder_joint_outer_width());
echo(carriage_ball_holder_joint_depth = carriage_ball_holder_joint_depth());
echo(carriage_ball_holder_recess_depth = carriage_ball_holder_recess_depth());
echo(carriage_ball_holder_ball_position = carriage_ball_holder_ball_position());
echo(carriage_ball_holder_distance_origin_joint = carriage_ball_holder_distance_origin_joint());
echo(carriage_ball_holder_angle_joint_ball_center = carriage_ball_holder_angle_joint_ball_center());
echo(carriage_ball_holder_distance_joint_ball_center = carriage_ball_holder_distance_joint_ball_center());
echo(carriage_ball_holder_resolution = carriage_ball_holder_resolution());
echo(tensioner_range = tensioner_range());
echo(tensioner_idler_gap_depth = tensioner_idler_gap_depth());
echo(tensioner_flange_width = tensioner_flange_width());
echo(tensioner_separator_thickness = tensioner_separator_thickness());
echo(tensioner_depth = tensioner_depth());
echo(tensioner_width = tensioner_width());
echo(tensioner_vertical_screw_min_length = tensioner_vertical_screw_min_length());
echo(tensioner_vertical_screw_length = tensioner_vertical_screw_length());
echo(tensioner_idler_z_offset = tensioner_idler_z_offset());
echo(tensioner_screw_bracket_inner_height = tensioner_screw_bracket_inner_height());
echo(head_tensioner_groove_width = head_tensioner_groove_width());
echo(head_tensioner_groove_depth = head_tensioner_groove_depth());
echo(head_tensioner_groove_height = head_tensioner_groove_height());
echo(tensioner_x_offset = tensioner_x_offset());
echo(tensioner_screw_position = tensioner_screw_position());
echo(tensioner_z_offset = tensioner_z_offset());
echo(end_switch_bracket_thickness = end_switch_bracket_thickness());
echo(end_switch_bracket_foot_depth = end_switch_bracket_foot_depth());
echo(end_switch_bracket_foot_height = end_switch_bracket_foot_height());
echo(end_switch_bracket_screw_hole_diameter = end_switch_bracket_screw_hole_diameter());
echo(end_switch_bracket_top_height = end_switch_bracket_top_height());
echo(end_switch_bracket_top_depth = end_switch_bracket_top_depth());
echo(end_switch_bracket_top_width = end_switch_bracket_top_width());
echo(end_switch_bracket_top_nutcatch_height = end_switch_bracket_top_nutcatch_height());
echo(end_switch_bracket_edge_radius = end_switch_bracket_edge_radius());
echo(end_switch_bracket_edge_resolution = end_switch_bracket_edge_resolution());
echo(end_switch_bracket_total_height = end_switch_bracket_total_height());
echo(end_switch_bracket_spring_height = end_switch_bracket_spring_height());
echo(end_switch_bracket_screw_length = end_switch_bracket_screw_length());
echo(end_switch_bracket_x_offset = end_switch_bracket_x_offset());
echo(end_switch_bracket_y_offset = end_switch_bracket_y_offset());
echo(end_switch_bracket_z_offset = end_switch_bracket_z_offset());
echo(magnet_holder_top_diameter = magnet_holder_top_diameter());
echo(magnet_holder_top_thickness = magnet_holder_top_thickness());
echo(magnet_holder_pin_diameter = magnet_holder_pin_diameter());
echo(magnet_holder_pin_height = magnet_holder_pin_height());
echo(magnet_holder_arm_clearance = magnet_holder_arm_clearance());
echo(magnet_holder_top_ball_clearance = magnet_holder_top_ball_clearance());
echo(magnet_holder_bottom_ball_clearance = magnet_holder_bottom_ball_clearance());
echo(magnet_holder_arm_width = magnet_holder_arm_width());
echo(magnet_holder_arm_thickness = magnet_holder_arm_thickness());
echo(magnet_holder_rod_wall_thickness = magnet_holder_rod_wall_thickness());
echo(magnet_holder_rod_holder_depth = magnet_holder_rod_holder_depth());
echo(magnet_holder_rod_clearance = magnet_holder_rod_clearance());
echo(magnet_holder_magnet_clearance = magnet_holder_magnet_clearance());
echo(magnet_holder_arm_thickness = magnet_holder_arm_thickness());
echo(magnet_holder_resolution = magnet_holder_resolution());
echo(effector_tool_height = effector_tool_height());
echo(effector_base_ball_recess_depth = effector_base_ball_recess_depth());
echo(effector_base_ball_add_distance = effector_base_ball_add_distance());
echo(effector_base_ball_distance = effector_base_ball_distance());
echo(effector_base_thickness = effector_base_thickness());
echo(effector_base_cutoff_edge_length = effector_base_cutoff_edge_length());
echo(effector_base_cutoff_height = effector_base_cutoff_height());
echo(effector_base_triangle_edge_length = effector_base_triangle_edge_length());
echo(effector_base_triangle_height = effector_base_triangle_height());
echo(effector_base_center_long_edge_distance = effector_base_center_long_edge_distance());
echo(effector_base_center_short_edge_distance = effector_base_center_short_edge_distance());
echo(effector_base_center_corner_distance = effector_base_center_corner_distance());
echo(effector_base_long_short_edge_distance = effector_base_long_short_edge_distance());
echo(effector_base_ball_position_a_left = effector_base_ball_position_a_left());
echo(effector_base_ball_position_a_right = effector_base_ball_position_a_right());
echo(effector_base_ball_position_b_left = effector_base_ball_position_b_left());
echo(effector_base_ball_position_b_right = effector_base_ball_position_b_right());
echo(effector_base_ball_position_c_left = effector_base_ball_position_c_left());
echo(effector_base_ball_position_c_right = effector_base_ball_position_c_right());
echo(effector_base_ball_holder_height = effector_base_ball_holder_height());
echo(effector_base_ball_holder_diameter = effector_base_ball_holder_diameter());
echo(effector_base_resolution = effector_base_resolution());
echo(arm_min_angle = arm_min_angle());
echo(arm_rod_round_up_factor = arm_rod_round_up_factor());
echo(arm_max_ground_distance = arm_max_ground_distance());
echo(arm_exact_overall_length = arm_exact_overall_length());
echo(arm_rod_exact_length = arm_rod_exact_length());
echo(arm_rod_length = arm_rod_length());
echo(arm_overall_length = arm_overall_length());
echo(frame_screw_size = frame_screw_size());
echo(frame_screw_head_size = frame_screw_head_size());
echo(frame_screw_hole_resolution = frame_screw_hole_resolution());
echo(horizontal_extrusion_outward_offset = horizontal_extrusion_outward_offset());
echo(vmotor_rail_distance = vmotor_rail_distance());
echo(vmotor_z_offset = vmotor_z_offset());
echo(vmotor_gt2_pulley_reversed = vmotor_gt2_pulley_reversed());
echo(vmotor_gt2_pulley_rail_distance = vmotor_gt2_pulley_rail_distance());
echo(vmotor_gt2_belt_rail_distance = vmotor_gt2_belt_rail_distance());
echo(belt_center_distance = belt_center_distance());
echo(ball_plane_distance_center_corner = ball_plane_distance_center_corner());
echo(ball_plane_distance_center_edge = ball_plane_distance_center_edge());
echo(ball_plane_base_height = ball_plane_base_height());
echo(ball_plane_base_length = ball_plane_base_length());
echo(epsilon = epsilon());
