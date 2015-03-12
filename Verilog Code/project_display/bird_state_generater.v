`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:04:48 04/02/2014 
// Design Name: 
// Module Name:    bird_state_generater 
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
module bird_state_generater(
	 input clk,
	 input [1:0]state_input,
	 output reg[2:0]state
    );
	 
	 reg [21:0]counter;
	 reg divided_clk;
	 reg [2:0]hor_state;
	 reg [2:0]fly_state;
	 //1--slow  2--fast
	 always @(posedge clk)begin
		counter<=counter+1'b1;
	 end
	 
	 always @(state_input,hor_state,fly_state)begin
	 case(state_input)
	 2'b00: state<=hor_state;
	 2'b01: state<=fly_state;
	 2'b10: state<=6;
	 2'b11: state<=7;
	 default:state<=state_input;
	 endcase
	 end
	 
	 always @(posedge counter[21])begin
	 case(state_input)
	 2'b00:begin
			if((hor_state==3'b000)||(hor_state==3'b001))hor_state<=hor_state+1'b1;
			else hor_state<=3'b000;
			end
	 2'b01:begin
			if((fly_state==3'b011)||(fly_state==3'b100))fly_state<=fly_state+1'b1;
			else fly_state<=3'b011;
			end
	default: begin
			hor_state<=3'b000;
			fly_state<=3'b011;
			end
			endcase

	 
	 end
		


endmodule
