
# PlanAhead Launch Script for Pre-Synthesis Floorplanning, created by Project Navigator

create_project -name tl_bit -dir "/home/ise/Manipal_project/traffic_light_controller_time_manipal_bit/traffic_light/synth/tl_bit/planAhead_run_1" -part xc6slx9tqg144-3
set_param project.pinAheadLayout yes
set srcset [get_property srcset [current_run -impl]]
set_property target_constrs_file "top_traffic_light_cntrl.ucf" [current_fileset -constrset]
set hdlfile [add_files [list {../../rtl/rtl/traffic_light_cntrl.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {../../rtl/rtl/sec_timer.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {../../rtl/rtl/top_traffic_light_cntrl.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set_property top top_traffic_light_cntrl $srcset
add_files [list {top_traffic_light_cntrl.ucf}] -fileset [get_property constrset [current_run]]
open_rtl_design -part xc6slx9tqg144-3
