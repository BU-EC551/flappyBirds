
# PlanAhead Launch Script for Pre-Synthesis Floorplanning, created by Project Navigator

create_project -name sd -dir "/ad/eng/users/b/a/bangbang/EC551/sd/planAhead_run_1" -part xc6slx16csg324-3
set_param project.pinAheadLayout yes
set srcset [get_property srcset [current_run -impl]]
set_property target_constrs_file "command.ucf" [current_fileset -constrset]
set hdlfile [add_files [list {command.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set_property top command $srcset
add_files [list {command.ucf}] -fileset [get_property constrset [current_run]]
open_rtl_design -part xc6slx16csg324-3
