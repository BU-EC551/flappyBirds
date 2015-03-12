`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:51:50 03/31/2014 
// Design Name: 
// Module Name:    display_module 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module display_module(
	 input clk,
	 input mode,
	 input [1:0]bird_state_input,
	 input [1:0]bird_blue_state_input,
	 input [7:0]score,
	 input [7:0]score1,
	 input [2:0]state,
	 input [1:0]level,
	 input [10:0]bird_h_in,bird_v_in,
	 input [10:0]bird_blue_h_in,bird_blue_v_in,
	 input [10:0]pipe_center_0,pipe_center_1,pipe_center_2,
	 input [10:0]pipe_pisiton_0,pipe_pisiton_1,pipe_pisiton_2,
	 input [10:0]pipe_distance_0,pipe_distance_1,pipe_distance_2,
	 output [2:0]r,g,
	 output [1:0]b,

	 output HS, VS
    );
	 wire [10:0] hcounter, vcounter;
	 wire clk_vga;
	 wire [7:0]display_pixel,bird_pixel,pipe_pixel,bg_pixel,number_pixel,word_pixel,stripe_pixel,bird_blue_pixel;
	 wire bird_flag,pipe_flag,num_flag,word_flag,stripe_flag;
	 wire blank;
	 wire [2:0]bird_index;
	 wire [10:0]bird_h,bird_v,bird_blue_h,bird_blue_v;
	 wire [1:0]bird_state,bird_blue_state;

	 
	 
	 bg_rom_interface BG_ROM_INTERFACE(clk,hcounter,vcounter,bg_pixel);
	 bird_rom_interface BIRD_ROM_INTERFACE(clk,bird_state,hcounter,vcounter,bird_h,bird_v,bird_pixel,bird_flag);
	 bird_blue_rom_interface BIRD_BLUE_ROM_INTERFACE(clk,bird_blue_state,hcounter,vcounter,bird_blue_h,bird_blue_v,bird_blue_pixel,bird_blue_flag);
	 pipe_rom_interface PIPE_ROM_INTERFACE(hcounter,vcounter,pipe_center_0,pipe_center_1,pipe_center_2,pipe_pisiton_0,pipe_pisiton_1,pipe_pisiton_2,pipe_distance_0,pipe_distance_1,pipe_distance_2,pipe_pixel,pipe_flag);
	 number_rom_interface NUM_ROM_INTERFACE(clk,score,score1,mode,hcounter, vcounter,number_pixel,num_flag);
	 word_rom_interface WORD_ROM_INTERFACE(clk,state,level,hcounter, vcounter,word_pixel,word_flag);
	 stripe_rom_interface STRIPE_ROM_INTERFACE(clk,state,hcounter, vcounter,stripe_pixel,stripe_flag);
	 
    display_mux DISPLAY_MUX(state,bird_pixel,bird_blue_pixel,bg_pixel,pipe_pixel,number_pixel,word_pixel,stripe_pixel,bird_flag,bird_blue_flag,pipe_flag,num_flag,word_flag,stripe_flag,display_pixel);
    
	 vga_output VGA_OUTPUT(r,g,b,clk_vga,hcounter,vcounter,blank,display_pixel);
	 vga_controller_640_60 VGA_CONTROLLER(clk_vga,HS,VS,hcounter,vcounter,blank);
	 //bird_state_generater BIRD_STATE_GENERATER(clk,bird_state_input,bird_index);
	 clk_vga CLK_VGA(clk,clk_vga);
	 
	 bird_select BIRD_SELECTION(state,bird_state_input,bird_blue_state_input,mode,bird_h_in,bird_v_in,bird_blue_h_in,bird_blue_v_in,bird_h,bird_v,bird_blue_h,bird_blue_v,bird_state,bird_blue_state);


endmodule
