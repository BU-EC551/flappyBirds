`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:37:39 04/27/2014 
// Design Name: 
// Module Name:    bird_select 
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
module bird_select(
	input [2:0]state,
	input [1:0]bird_state_input,bird_state_blue_input,
	input mode,
	input [10:0]bird_h,bird_v,bird_blue_h,bird_blue_v,
	output reg[10:0]bird_h_out,bird_v_out,bird_blue_h_out,bird_blue_v_out,
	output reg[1:0]bird_state,bird_blue_state
    );
	 
	 always @(state,mode)
	 case(state)
	 3'b000:
	 if(mode==0)begin
	 bird_h_out<=320;
	 bird_v_out<=285;
	 bird_blue_h_out<=2000;
	 bird_blue_v_out<=2000;
	 bird_state<=0;bird_blue_state<=0;
	 end
	 else begin
	 bird_h_out<=bird_h;
	 bird_v_out<=bird_v;
	 bird_blue_h_out<=bird_blue_h;
	 bird_blue_v_out<=bird_blue_v;
	 bird_state<=0;bird_blue_state<=0;
	 end
	 
	 3'b001:
	 if(mode==0)begin
	 bird_h_out<=320;
	 bird_v_out<=240;
	 bird_blue_h_out<=2000;
	 bird_blue_v_out<=2000;
	 bird_state<=0;bird_blue_state<=0;
	 end
	 else begin
	 bird_h_out<=320;
	 bird_v_out<=240;
	 bird_blue_h_out<=280;
	 bird_blue_v_out<=240;
	 bird_state<=0;bird_blue_state<=0;
	 end
	 
	 default:
	 if(mode==0)begin
	 bird_h_out<=bird_h;
	 bird_v_out<=bird_v;
	 bird_blue_h_out<=2000;
	 bird_blue_v_out<=2000;
	 bird_state<=bird_state_input;bird_blue_state<=bird_state_blue_input;
	 end
	 else begin
	 bird_h_out<=bird_h;
	 bird_v_out<=bird_v;
	 bird_blue_h_out<=bird_blue_h;
	 bird_blue_v_out<=bird_blue_v;
	 bird_state<=bird_state_input;bird_blue_state<=bird_state_blue_input;
	 end

	 
	 
	 endcase


endmodule
