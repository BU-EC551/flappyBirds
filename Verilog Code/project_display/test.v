`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:16:32 03/31/2014 
// Design Name: 
// Module Name:    test 
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
module test(
	 input clk,
	 input [2:0]state,
	 input [1:0]level,
	 output [2:0]r,g,
	 output [1:0]b,
	 output HS, VS
    );
	 wire [10:0]bird_h,bird_v;
	 wire [10:0]bird_blue_h,bird_blue_v;
	 wire [2:0]bird_state_input,bird_blue_state_input;
	 wire [7:0]score;
	 wire [10:0]pipe_center_0,pipe_pisiton_0,pipe_distance_0,pipe_center_1,pipe_pisiton_1,pipe_distance_1,pipe_center_2,pipe_pisiton_2,pipe_distance_2;
	 display_module M1(
	 clk,
	 bird_state_input,
	 bird_blue_state_input,
	 score,
	 state,
	 level,
	 bird_h,bird_v,
	 bird_blue_h,bird_blue_v,
	 pipe_center_0,pipe_center_1,pipe_center_2,
	 pipe_pisiton_0,pipe_pisiton_1,pipe_pisiton_2,
	 pipe_distance_0,pipe_distance_1,pipe_distance_2,
	 r,g,
	 b,
	 HS, VS
	 );
	 assign bird_h=500;
	 assign bird_v=150;
	 
	 assign bird_blue_h=200;
	 assign bird_blue_v=150;
	 
	 assign bird_state_input=1;
	 assign bird_blue_state_input=3;
	 assign pipe_center_0=250;
	 assign pipe_pisiton_0=100;
	 assign pipe_distance_0=100;
	 
	 assign pipe_center_1=250;
	 assign pipe_pisiton_1=300;
	 assign pipe_distance_1=100;
	 
	 assign pipe_center_2=150;
	 assign pipe_pisiton_2=500;
	 assign pipe_distance_2=50;
	 assign score=209;


endmodule
