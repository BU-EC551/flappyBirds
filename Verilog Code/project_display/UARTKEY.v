`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:46:38 04/17/2014 
// Design Name: 
// Module Name:    UARTKEY 
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
module UARTKEY(
				output reg data_t=1,
				output reg	[7:0] temp=0,
				input clk,
				input data_r
				);
	reg [3:0] count_t=0,count_r=0;
	//reg [7:0] temp=0;
	


	clock C2(	.clk_9600(clk_9600),//output  clk_9600=0, 
					.clk(clk)//input clk
				);


//RXD//////////////////////////////////////////////////////////////////////////////
	reg [9:0] count_30=0;
	
	always@(posedge clk_9600)
	begin
	
		if (temp!=8'b0) count_30<=count_30+1'b1;
		if (count_30==800)//x=319   (x+1)/9600=1/30 Tpp=1/30s
			begin
			temp<=0;	
			count_30<=0;
			end
		
		
		case(count_r)
		8:	begin //first info bit
			count_r<=count_r-1;
			temp[0]<=data_r;
			end
		7:	begin 
			count_r<=count_r-1;
			temp[1]<=data_r;
			end
		6:	begin 
			count_r<=count_r-1;
			temp[2]<=data_r;
			end
		5:	begin 
			count_r<=count_r-1;
			temp[3]<=data_r;
			end
		4:	begin 
			count_r<=count_r-1;
			temp[4]<=data_r;
			end
		3:	begin 
			count_r<=count_r-1;
			temp[5]<=data_r;
			end
		2:	begin 
			count_r<=count_r-1;
			temp[6]<=data_r;
			end
		1:	begin //last info bit
			count_r<=count_r-1;
			temp[7]<=data_r;
			end
		default: 		
			if (!data_r)
			begin
			count_r<=8;
			end
		endcase
		end
		
endmodule
