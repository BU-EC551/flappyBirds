
# PlanAhead Launch Script for Pre-Synthesis Floorplanning, created by Project Navigator

create_project -name project_display -dir "E:/project_display/planAhead_run_1" -part xc6slx16csg324-3
set_param project.pinAheadLayout yes
set srcset [get_property srcset [current_run -impl]]
set_property target_constrs_file "test.ucf" [current_fileset -constrset]
add_files [list {ipcore_dir/bg_rom.ngc}]
add_files [list {ipcore_dir/bird_rom.ngc}]
add_files [list {ipcore_dir/pipe_rom.ngc}]
add_files [list {ipcore_dir/number_rom.ngc}]
add_files [list {ipcore_dir/word_rom.ngc}]
set hdlfile [add_files [list {ipcore_dir/word_rom.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {ipcore_dir/pipe_rom.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {ipcore_dir/number_rom.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {ipcore_dir/bird_rom.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {ipcore_dir/bg_rom.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {BCD.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {word_rom.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {vga_output.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {VGAcontrol.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {pipe_rom_interface.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {number_rom_interface.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {display_mux.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {clk_vga.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {bird_state_generater.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {bird_rom_interface.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {bg_rom_interface.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {display_module.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {test.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set_property top test $srcset
add_files [list {test.ucf}] -fileset [get_property constrset [current_run]]
add_files [list {ipcore_dir/bg_rom.ncf}] -fileset [get_property constrset [current_run]]
add_files [list {ipcore_dir/bird_rom.ncf}] -fileset [get_property constrset [current_run]]
add_files [list {ipcore_dir/number_rom.ncf}] -fileset [get_property constrset [current_run]]
add_files [list {ipcore_dir/pipe_rom.ncf}] -fileset [get_property constrset [current_run]]
add_files [list {ipcore_dir/word_rom.ncf}] -fileset [get_property constrset [current_run]]
open_rtl_design -part xc6slx16csg324-3
