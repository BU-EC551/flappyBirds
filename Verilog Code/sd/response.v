`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:43:26 04/18/2014 
// Design Name: 
// Module Name:    response 
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
module response(
	 input clk,
	 input flag,
	 input response,
	 output reg receive_state
    );
	 reg [47:0]sequence;
	 initial begin 
	 receive_state<=0;
	 sequence<=48'b111111111111111111111111111111111111111111111111;
	 end
	 
	 always @(posedge clk)begin
	 if(flag==1)begin
	 sequence<={sequence[46:0],response};
	 if(sequence==48'b000000000000000000000000000000000000000000000001)receive_state<=1'b1;
	 receive_state<=response;
	 end
	 //else
	 sequence<=48'b111111111111111111111111111111111111111111111111;
	 end


endmodule
