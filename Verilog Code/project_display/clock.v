`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:28:41 02/25/2014 
// Design Name: 
// Module Name:    clock 
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
module clock(output reg clk_96000=0,
					output reg clk_9600=0, 
					output clk_2,clk_4,clk_8,
					input clk
    );
	 reg [30:0]count=0;
	 reg [15:0]count2=0;
	 reg [15:0]count3=0;
	 
	 always@(posedge clk)
	 count<=count+1'b1;
	 
	 always@(posedge clk)
	 begin
	 count2<=count2+1'b1;
	 if (count2==5207)//test x=1->1/4		2(x+1)=10416+2/3   //x=5207+1/3
	 begin
	 clk_9600<=~clk_9600;
	 count2<=0;
	 end
	 end
	 
	 always@(posedge clk)
	 begin
	 count3<=count3+1'b1;
	 if (count3==520)//test x=1->1/4		2(x+1)=1041+2/3   //x=520
	 begin
	 clk_96000<=~clk_96000;
	 count3<=0;
	 end
	 end
	 
	 
	 assign clk_2=count[0];
	 assign clk_4=count[1];
	 assign clk_8=count[2];
	 
	 

endmodule
