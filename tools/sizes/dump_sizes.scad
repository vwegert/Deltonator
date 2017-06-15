// GENERATED FILE, DO NOT EDIT MANUALLY
include <../../conf/part_sizes.scad>
include <../../conf/derived_sizes.scad>
echo("----- conf/part_sizes.scad ----------------------------------------");
echo(vslot_2020_depth = vslot_2020_depth());
echo(vslot_2020_width = vslot_2020_width());
echo(vslot_2020_edge_radius = vslot_2020_edge_radius());
echo(vslot_2020_edge_resolution = vslot_2020_edge_resolution());
echo(vslot_2020_slot_offset = vslot_2020_slot_offset());
echo(rail_bracket_side_length = rail_bracket_side_length());
echo(rail_bracket_width = rail_bracket_width());
echo(rail_bracket_outer_wall_thickness = rail_bracket_outer_wall_thickness());
echo(rail_bracket_side_wall_thickness = rail_bracket_side_wall_thickness());
echo(rail_bracket_hole_width = rail_bracket_hole_width());
echo(rail_bracket_hole_length = rail_bracket_hole_length());
echo(rail_bracket_hole_corner_offset = rail_bracket_hole_corner_offset());
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
echo(t_slot_nut_clearance = t_slot_nut_clearance());
echo(t_slot_nut_holder_width = t_slot_nut_holder_width());
echo(t_slot_nut_holder_depth = t_slot_nut_holder_depth());
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
echo(emotor_size = emotor_size());
echo(emotor_width = emotor_width());
echo(emotor_height = emotor_height());
echo(emotor_shaft_length = emotor_shaft_length());
echo(emotor_screw_distance = emotor_screw_distance());
echo(emotor_screw_size = emotor_screw_size());
echo(extruder_mount_thickness = extruder_mount_thickness());
echo(extruder_mount_bracket_width = extruder_mount_bracket_width());
echo(extruder_mount_motor_length = extruder_mount_motor_length());
echo(extruder_mount_base_length = extruder_mount_base_length());
echo(extruder_mount_hole_size = extruder_mount_hole_size());
echo(extruder_mount_motor_screw_hole_size = extruder_mount_motor_screw_hole_size());
echo(extruder_mount_base_screw_hole_size = extruder_mount_base_screw_hole_size());
echo(extruder_mount_base_screw_dist_width = extruder_mount_base_screw_dist_width());
echo(extruder_mount_base_screw_dist_length = extruder_mount_base_screw_dist_length());
echo(extruder_mount_base_screw_edge_dist_width = extruder_mount_base_screw_edge_dist_width());
echo(extruder_mount_base_screw_edge_dist_length = extruder_mount_base_screw_edge_dist_length());
echo(escher_ir_sensor_pcb_width = escher_ir_sensor_pcb_width());
echo(escher_ir_sensor_pcb_height = escher_ir_sensor_pcb_height());
echo(escher_ir_sensor_hole_size = escher_ir_sensor_hole_size());
echo(escher_ir_sensor_hole_offset_side = escher_ir_sensor_hole_offset_side());
echo(escher_ir_sensor_hole_offset_top = escher_ir_sensor_hole_offset_top());
echo(escher_ir_sensor_pcb_thickness = escher_ir_sensor_pcb_thickness());
echo(escher_ir_sensor_pcb_max_pin_length = escher_ir_sensor_pcb_max_pin_length());
echo(escher_ir_sensor_pcb_max_component_height = escher_ir_sensor_pcb_max_component_height());
echo(escher_ir_sensor_pcb_bottom_side_clearance = escher_ir_sensor_pcb_bottom_side_clearance());
echo(escher_ir_sensor_pcb_top_edge_clearance = escher_ir_sensor_pcb_top_edge_clearance());
echo(escher_ir_sensor_magnet_diameter = escher_ir_sensor_magnet_diameter());
echo(escher_ir_sensor_magnet_height = escher_ir_sensor_magnet_height());
echo(escher_ir_sensor_nozzle_offset = escher_ir_sensor_nozzle_offset());
echo(pc_fan_side_length = pc_fan_side_length());
echo(pc_fan_inner_diameter = pc_fan_inner_diameter());
echo(pc_fan_depth = pc_fan_depth());
echo(pc_fan_corner_radius = pc_fan_corner_radius());
echo(pc_fan_hole_diameter = pc_fan_hole_diameter());
echo(pc_fan_hole_offset = pc_fan_hole_offset());
echo(hotend_e3d_v6lite_cutout_width = hotend_e3d_v6lite_cutout_width());
echo(hotend_e3d_v6lite_cutout_depth_front = hotend_e3d_v6lite_cutout_depth_front());
echo(hotend_e3d_v6lite_cutout_depth_back = hotend_e3d_v6lite_cutout_depth_back());
echo(hotend_e3d_v6lite_mounting_hole_distance = hotend_e3d_v6lite_mounting_hole_distance());
echo(hotend_e3d_v6lite_mounting_hole_size = hotend_e3d_v6lite_mounting_hole_size());
echo(hotend_e3d_v6lite_overall_height = hotend_e3d_v6lite_overall_height());
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
echo(build_area_max_radius = build_area_max_radius());
echo(magnet_bevel_depth = magnet_bevel_depth());
echo(ball_contact_circle_diameter = ball_contact_circle_diameter());
echo(ball_contact_circle_height = ball_contact_circle_height());
echo(magnet_contact_circle_depth = magnet_contact_circle_depth());
echo(ball_center_magnet_base_distance = ball_center_magnet_base_distance());
echo(ball_center_magnet_top_distance = ball_center_magnet_top_distance());
echo(horizontal_vertical_extrusion_gap = horizontal_vertical_extrusion_gap());
echo(frame_wall_thickness = frame_wall_thickness());
echo(horizontal_recess_depth = horizontal_recess_depth());
echo(horizontal_screw_distance = horizontal_screw_distance());
echo(foot_with_rail = foot_with_rail());
echo(foot_rail_makerslide_recess_depth = foot_rail_makerslide_recess_depth());
echo(foot_norail_makerslide_recess_depth = foot_norail_makerslide_recess_depth());
echo(foot_rail_vertical_back_screw_height = foot_rail_vertical_back_screw_height());
echo(foot_norail_vertical_back_screw_height = foot_norail_vertical_back_screw_height());
echo(foot_vertical_back_screw_height = foot_vertical_back_screw_height());
echo(foot_rail_plate_depth = foot_rail_plate_depth());
echo(foot_rail_plate_height = foot_rail_plate_height());
echo(foot_rail_plate_hole_y_offset = foot_rail_plate_hole_y_offset());
echo(foot_plate_screw_size = foot_plate_screw_size());
echo(foot_plate_screw_min_length = foot_plate_screw_min_length());
echo(foot_plate_screw_head_clearance = foot_plate_screw_head_clearance());
echo(foot_plate_screw_hole_resolution = foot_plate_screw_hole_resolution());
echo(foot_plate_diameter = foot_plate_diameter());
echo(foot_plate_sides = foot_plate_sides());
echo(foot_plate_thickness = foot_plate_thickness());
echo(foot_plate_screw_recess_depth = foot_plate_screw_recess_depth());
echo(foot_plate_x_offset = foot_plate_x_offset());
echo(foot_plate_z_offset = foot_plate_z_offset());
echo(motor_bracket_height = motor_bracket_height());
echo(motor_bracket_edge_radius = motor_bracket_edge_radius());
echo(motor_bracket_edge_resolution = motor_bracket_edge_resolution());
echo(motor_bracket_z_offset = motor_bracket_z_offset());
echo(motor_bracket_screw_z_offset = motor_bracket_screw_z_offset());
echo(motor_bracket_screw_height = motor_bracket_screw_height());
echo(bed_bracket_height = bed_bracket_height());
echo(bed_bracket_z_offset = bed_bracket_z_offset());
echo(bed_bracket_top_level = bed_bracket_top_level());
echo(bed_bracket_back_screw_z_offset = bed_bracket_back_screw_z_offset());
echo(bed_bracket_back_screw_height = bed_bracket_back_screw_height());
echo(bed_thickness = bed_thickness());
echo(bed_diameter = bed_diameter());
echo(bed_holder_spring_height = bed_holder_spring_height());
echo(bed_screw_min_length = bed_screw_min_length());
echo(bed_inner_bracket_offset = bed_inner_bracket_offset());
echo(bed_center_hole_distance = bed_center_hole_distance());
echo(bed_mounting_hole_size = bed_mounting_hole_size());
echo(bed_mounting_hole_resolution = bed_mounting_hole_resolution());
echo(bed_mounting_height = bed_mounting_height());
echo(bed_working_height = bed_working_height());
echo(head_makerslide_recess_depth = head_makerslide_recess_depth());
echo(head_guide_width = head_guide_width());
echo(head_guide_depth = head_guide_depth());
echo(head_guide_clearance = head_guide_clearance());
echo(head_z_offset = head_z_offset());
echo(head_back_screw_z_offset = head_back_screw_z_offset());
echo(head_back_screw_height = head_back_screw_height());
echo(carriage_plate_thickness = carriage_plate_thickness());
echo(carriage_plate_border_width = carriage_plate_border_width());
echo(carriage_wheel_distance_extra_clearance = carriage_wheel_distance_extra_clearance());
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
echo(carriage_belt_holder_guard_hole_diameter = carriage_belt_holder_guard_hole_diameter());
echo(carriage_belt_holder_guard_hole_distance = carriage_belt_holder_guard_hole_distance());
echo(carriage_belt_holder_guard_x = carriage_belt_holder_guard_x());
echo(carriage_belt_holder_guard_y = carriage_belt_holder_guard_y());
echo(carriage_tensioner_gap_width = carriage_tensioner_gap_width());
echo(carriage_tensioner_gap_height = carriage_tensioner_gap_height());
echo(carriage_x_offset = carriage_x_offset());
echo(carriage_groove_width = carriage_groove_width());
echo(carriage_groove_depth = carriage_groove_depth());
echo(carriage_groove_resolution = carriage_groove_resolution());
echo(carriage_ball_holder_width = carriage_ball_holder_width());
echo(carriage_ball_holder_height = carriage_ball_holder_height());
echo(carriage_ball_holder_depth = carriage_ball_holder_depth());
echo(carriage_ball_holder_angle = carriage_ball_holder_angle());
echo(carriage_ball_holder_joint_depth = carriage_ball_holder_joint_depth());
echo(carriage_ball_holder_recess_depth = carriage_ball_holder_recess_depth());
echo(carriage_ball_holder_ball_position = carriage_ball_holder_ball_position());
echo(carriage_ball_holder_distance_origin_joint = carriage_ball_holder_distance_origin_joint());
echo(carriage_ball_holder_angle_joint_ball_center = carriage_ball_holder_angle_joint_ball_center());
echo(carriage_ball_holder_distance_joint_ball_center = carriage_ball_holder_distance_joint_ball_center());
echo(carriage_ball_holder_resolution = carriage_ball_holder_resolution());
echo(tensioner_range = tensioner_range());
echo(tensioner_inner_clearance = tensioner_inner_clearance());
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
echo(magnet_holder_text_size = magnet_holder_text_size());
echo(magnet_holder_text_depth = magnet_holder_text_depth());
echo(magnet_holder_text_resolution = magnet_holder_text_resolution());
echo(magnet_holder_rod_clearance = magnet_holder_rod_clearance());
echo(magnet_holder_magnet_clearance = magnet_holder_magnet_clearance());
echo(magnet_holder_arm_thickness = magnet_holder_arm_thickness());
echo(magnet_holder_resolution = magnet_holder_resolution());
echo(effector_type = effector_type());
echo(effector_z_clearance = effector_z_clearance());
echo(effector_base_ball_recess_depth = effector_base_ball_recess_depth());
echo(effector_base_ball_recess_diamenter = effector_base_ball_recess_diamenter());
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
echo(effector_base_ball_holder_additional_height = effector_base_ball_holder_additional_height());
echo(effector_base_ball_z_offset = effector_base_ball_z_offset());
echo(effector_base_ball_position_a_left = effector_base_ball_position_a_left());
echo(effector_base_ball_position_a_right = effector_base_ball_position_a_right());
echo(effector_base_ball_position_b_left = effector_base_ball_position_b_left());
echo(effector_base_ball_position_b_right = effector_base_ball_position_b_right());
echo(effector_base_ball_position_c_left = effector_base_ball_position_c_left());
echo(effector_base_ball_position_c_right = effector_base_ball_position_c_right());
echo(effector_base_center_long_edge_center_dx = effector_base_center_long_edge_center_dx());
echo(effector_base_center_long_edge_center_dy = effector_base_center_long_edge_center_dy());
echo(effector_base_ball_holder_height = effector_base_ball_holder_height());
echo(effector_base_ball_holder_diameter = effector_base_ball_holder_diameter());
echo(effector_base_resolution = effector_base_resolution());
echo(effector_e3d_v6lite_spacer_height = effector_e3d_v6lite_spacer_height());
echo(effector_e3d_v6lite_spacer_width = effector_e3d_v6lite_spacer_width());
echo(effector_e3d_v6lite_spacer_depth = effector_e3d_v6lite_spacer_depth());
echo(effector_e3d_v6lite_nozzle_height = effector_e3d_v6lite_nozzle_height());
echo(effector_e3d_v6lite_pc_airbox_clearance = effector_e3d_v6lite_pc_airbox_clearance());
echo(effector_e3d_v6lite_pc_airbox_bottom_wall = effector_e3d_v6lite_pc_airbox_bottom_wall());
echo(effector_e3d_v6lite_pc_airbox_height = effector_e3d_v6lite_pc_airbox_height());
echo(effector_e3d_v6lite_pc_nozzle_block_depth = effector_e3d_v6lite_pc_nozzle_block_depth());
echo(effector_e3d_v6lite_pcf_screw_depth = effector_e3d_v6lite_pcf_screw_depth());
echo(effector_e3d_v6lite_pc_nozzle_height = effector_e3d_v6lite_pc_nozzle_height());
echo(effector_e3d_v6lite_pc_nozzle_width = effector_e3d_v6lite_pc_nozzle_width());
echo(effector_e3d_v6lite_pc_nozzle_center_distance = effector_e3d_v6lite_pc_nozzle_center_distance());
echo(effector_e3d_v6lite_pc_flow_angle = effector_e3d_v6lite_pc_flow_angle());
echo(effector_e3d_v6lite_pc_nozzle_center_z_offset = effector_e3d_v6lite_pc_nozzle_center_z_offset());
echo(effector_e3d_v6lite_pc_nozzle_path_z_offset = effector_e3d_v6lite_pc_nozzle_path_z_offset());
echo(effector_e3d_v6lite_pc_airbox_depth = effector_e3d_v6lite_pc_airbox_depth());
echo(arm_min_angle = arm_min_angle());
echo(arm_rod_round_up_factor = arm_rod_round_up_factor());
echo(arm_rod_fixed_length = arm_rod_fixed_length());
echo(arm_max_ground_distance = arm_max_ground_distance());
echo(arm_exact_overall_length = arm_exact_overall_length());
echo(arm_rod_exact_length = arm_rod_exact_length());
echo(arm_rod_length = arm_rod_length());
echo(arm_overall_length = arm_overall_length());
echo(frame_screw_size = frame_screw_size());
echo(frame_screw_head_size = frame_screw_head_size());
echo(frame_screw_hole_resolution = frame_screw_hole_resolution());
echo(horizontal_extrusion_outward_offset = horizontal_extrusion_outward_offset());
echo(head_horizontal_extrusion_center_height = head_horizontal_extrusion_center_height());
echo(bed_horizontal_extrusion_center_height = bed_horizontal_extrusion_center_height());
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
echo(enclosure_solid_thickness = enclosure_solid_thickness());
echo(enclosure_round_down_factor = enclosure_round_down_factor());
echo(enclosure_insulation_thickness = enclosure_insulation_thickness());
echo(enclosure_long_side_gap = enclosure_long_side_gap());
echo(enclosure_long_side_base_distance = enclosure_long_side_base_distance());
echo(enclosure_short_side_width_exact = enclosure_short_side_width_exact());
echo(enclosure_short_side_width = enclosure_short_side_width());
echo(enclosure_short_side_height = enclosure_short_side_height());
echo(enclosure_short_side_thickness = enclosure_short_side_thickness());
echo(enclosure_long_side_width_exact = enclosure_long_side_width_exact());
echo(enclosure_long_side_width = enclosure_long_side_width());
echo(enclosure_long_side_height = enclosure_long_side_height());
echo(enclosure_long_side_thickness = enclosure_long_side_thickness());
echo(enclosure_long_side_inner_hole_offset = enclosure_long_side_inner_hole_offset());
echo(enclosure_long_side_outer_hole_offset = enclosure_long_side_outer_hole_offset());
echo(enclosure_door_side_clearance = enclosure_door_side_clearance());
echo(enclosure_door_width = enclosure_door_width());
echo(enclosure_door_height = enclosure_door_height());
echo(enclosure_glass_width = enclosure_glass_width());
echo(enclosure_glass_height = enclosure_glass_height());
echo(enclosure_glass_gap_width = enclosure_glass_gap_width());
echo(enclosure_glass_bevel_width = enclosure_glass_bevel_width());
echo(enclosure_window_width = enclosure_window_width());
echo(enclosure_window_height = enclosure_window_height());
echo(enclosure_door_wood_thickness = enclosure_door_wood_thickness());
echo(enclosure_door_glass_thickness = enclosure_door_glass_thickness());
echo(enclosure_door_outer_vertical_part_size = enclosure_door_outer_vertical_part_size());
echo(enclosure_door_outer_horizontal_part_size = enclosure_door_outer_horizontal_part_size());
echo(enclosure_door_inner_vertical_part_size = enclosure_door_inner_vertical_part_size());
echo(enclosure_door_inner_horizontal_part_size = enclosure_door_inner_horizontal_part_size());
echo(enclosure_hole_resolution = enclosure_hole_resolution());
echo(enclosure_bracket_thickness = enclosure_bracket_thickness());
echo(enclosure_bracket_height = enclosure_bracket_height());
echo(enclosure_bracket_foot_width = enclosure_bracket_foot_width());
echo(enclosure_bracket_body_width = enclosure_bracket_body_width());
echo(enclosure_bracket_depth = enclosure_bracket_depth());
echo(enclosure_bracket_total_width = enclosure_bracket_total_width());
echo(enclosure_bracket_screw_distance = enclosure_bracket_screw_distance());
echo(enclosure_bracket_horizontal_offset = enclosure_bracket_horizontal_offset());
echo(enclosure_bracket_center_horizontal_offset = enclosure_bracket_center_horizontal_offset());
echo(enclosure_bracket_resolution = enclosure_bracket_resolution());
echo(escher_ir_sensor_housing_wall_thickness = escher_ir_sensor_housing_wall_thickness());
echo(escher_ir_sensor_housing_top_bottom_clearance = escher_ir_sensor_housing_top_bottom_clearance());
echo(escher_ir_sensor_housing_pcb_clearance = escher_ir_sensor_housing_pcb_clearance());
echo(escher_ir_sensor_adjustment_screw_size = escher_ir_sensor_adjustment_screw_size());
echo(escher_ir_sensor_housing_body_width = escher_ir_sensor_housing_body_width());
echo(escher_ir_sensor_housing_body_height = escher_ir_sensor_housing_body_height());
echo(escher_ir_sensor_housing_body_depth = escher_ir_sensor_housing_body_depth());
echo(escher_ir_sensor_cutout_distance_solder = escher_ir_sensor_cutout_distance_solder());
echo(escher_ir_sensor_cutout_distance_components = escher_ir_sensor_cutout_distance_components());
echo(escher_ir_sensor_cutout_depth = escher_ir_sensor_cutout_depth());
echo(escher_ir_sensor_cutout_width = escher_ir_sensor_cutout_width());
echo(escher_ir_sensor_screw_z_offset = escher_ir_sensor_screw_z_offset());
echo(escher_ir_sensor_screw_y_offset = escher_ir_sensor_screw_y_offset());
echo(escher_ir_sensor_screw_min_length = escher_ir_sensor_screw_min_length());
echo(escher_ir_sensor_magnet_clearance = escher_ir_sensor_magnet_clearance());
echo(escher_ir_sensor_magnet_holder_width = escher_ir_sensor_magnet_holder_width());
echo(escher_ir_sensor_magnet_holder_height = escher_ir_sensor_magnet_holder_height());
echo(escher_ir_sensor_magnet_holder_depth = escher_ir_sensor_magnet_holder_depth());
echo(escher_ir_sensor_resolution = escher_ir_sensor_resolution());
echo(epsilon = epsilon());
