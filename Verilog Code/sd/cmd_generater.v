`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:03:11 04/17/2014 
// Design Name: 
// Module Name:    cmd_generater 
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
module cmd_generater(
	 input clk,
	 input state,
	 output reg pin_out
    );
	 reg [47:0]cmd0;
	 reg [6:0]count;
	 reg output_flag;
	 initial begin
	 //cmd0<=48'b010000000000000000000000000000000000000010010101;
	 cmd0=0;
	 count<=47;
	 output_flag<=1;
	 end
	 
	 always @(posedge clk)begin
	 if(state==1&&output_flag==1)begin
	 pin_out<=cmd0[count];
	 count<=count-1'b1;
	 end
	 
	 if(count==0)
	 output_flag<=0;
	 end


endmodule
