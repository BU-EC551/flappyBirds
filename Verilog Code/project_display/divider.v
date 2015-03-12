`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:39:34 03/24/2014 
// Design Name: 
// Module Name:    divider 
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
module divider(input clk,output clk1,clk2,clk3);

reg [19:0]counter;
always@ (posedge clk) begin counter=counter+1;end
assign clk1=counter[19];//2^14
assign clk2=counter[16];//2^17
assign clk3=counter[1];//2^2
endmodule