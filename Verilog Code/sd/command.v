`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:09:23 04/17/2014 
// Design Name: 
// Module Name:    command 
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
module command(
	 input clk,
	 inout CS,
	 inout cmd,
	 output led1,
	 output clk_out
    );
	 reg [5:0]count;
	 reg state;
	 initial begin
	 count<=58;
	 state<=1;
	 end
	 
	 cmd_generater CMD_GENERATER(clk,state,cmd);
	 response REPSONSE(clk,~state,cmd,led1);
	 
	 always @(posedge clk)
		if(state==1)count<=count-1'b1;
	 
	 always @(posedge clk)
		if(count==0)state<=0;
		
		
	 assign clk_out=clk;
	 assign CS=1;
	 
	 
	 


endmodule
