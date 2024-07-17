
# PlanAhead Launch Script for Pre-Synthesis Floorplanning, created by Project Navigator

create_project -name es_bit -dir "/home/ise/Manipal_project/escalator_fsm_4floor_manipal_bit/synth/es_bit/planAhead_run_1" -part xc6slx9tqg144-3
set_param project.pinAheadLayout yes
set srcset [get_property srcset [current_run -impl]]
set_property target_constrs_file "elevator.ucf" [current_fileset -constrset]
set hdlfile [add_files [list {../../rtl/escalator_4floor.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set_property top elevator $srcset
add_files [list {elevator.ucf}] -fileset [get_property constrset [current_run]]
open_rtl_design -part xc6slx9tqg144-3
