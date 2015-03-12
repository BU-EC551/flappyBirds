`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:33:17 02/27/2014 
// Design Name: 
// Module Name:    clk_vga 
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
module clk_vga(clk_in,clk_out
    );
	 input clk_in;
	 output reg clk_out;
	 reg [1:0]counter;
	 //1--slow  2--fast
	 always @(posedge clk_in)begin
		counter<=counter+1'b1;
		clk_out<=counter[1];
	 end
	 

endmodule
