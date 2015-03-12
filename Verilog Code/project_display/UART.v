`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:53:38 03/21/2014 
// Design Name: 
// Module Name:    UART 
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
module UART(
				//PMOD
				output STATUS_OUT,  //show status on a LED
				input STATUS_IN,
				output reg RST=1,
				output reg data_t=1,
				output reg	[7:0] temp=0,
				input clk,
				input data_r
				);
	parameter sample_num =10; //10 ;
	parameter NMH=8;//7;
	parameter NML=2;//3;
	reg [3:0] count_t=0,count_r=9;
	reg [7:0] pack_t=8'b01011000;//info bits
	reg [7:0] pack_r,pack_r_sta;//=8'b11111111;	
	reg [7:0] count_debug=0;
	reg send_button=0;
	
	assign STATUS_OUT=STATUS_IN;
	clock C1(	clk_96000,//output reg clk_96000=0,
					clk_9600,//output  clk_9600=0, 
					clk_2,clk_4,clk_8,//output clk_2,clk_4,clk_8,
					clk//input clk
				);
//VGA//////////////////////////////////////////////////////////////////////////////

//RXD//////////////////////////////////////////////////////////////////////////////
	reg [14:0] count_30=0;
	reg [9:0] count_10=0;
	reg [3:0] arbiter=0;
	
	always@(posedge clk_96000)
	begin
		if (temp!=0)
		count_30<=count_30+1'b1;
		if (count_30==3199)//x=3199   (x+1)/96000=1/30 Tpp=1/30s
			begin
			temp<=0;	
			count_30<=0;
			end
			
			
		
		case(count_r)
		8:	begin //first info bit
			count_10<=count_10+1;
			arbiter<=arbiter+data_r;
				if (count_10==sample_num-1)
				begin
					if (arbiter>=NMH)
						begin
						pack_r[0]<=1;
						count_r<=count_r-1;
						end
					else if (arbiter<=NML)
						begin
						pack_r[0]<=0;
						count_r<=count_r-1;
						end
					else
						begin
						send_button<=1;
						count_r<=15;
						end
					arbiter<=0;
					count_10<=0;
				end
			end
		7:	begin 
			count_10<=count_10+1;
			arbiter<=arbiter+data_r;
				if (count_10==sample_num-1)
				begin
					if (arbiter>=NMH)
						begin
						pack_r[1]<=1;
						count_r<=count_r-1;
						end
					else if (arbiter<=NML)
						begin
						pack_r[1]<=0;
						count_r<=count_r-1;
						end
					else
						begin
						send_button<=1;
						count_r<=15;
						end
					arbiter<=0;
					count_10<=0;
				end
			end
		6:	begin 
			count_10<=count_10+1;
			arbiter<=arbiter+data_r;
				if (count_10==sample_num-1)
				begin
					if (arbiter>=NMH)
						begin
						pack_r[2]<=1;
						count_r<=count_r-1;
						end
					else if (arbiter<=NML)
						begin
						pack_r[2]<=0;
						count_r<=count_r-1;
						end
					else
						begin
						send_button<=1;
						count_r<=15;
						end
					arbiter<=0;
					count_10<=0;
				end
			end
		5:	begin 
			count_10<=count_10+1;
			arbiter<=arbiter+data_r;
				if (count_10==sample_num-1)
				begin
					if (arbiter>=NMH)
						begin
						pack_r[3]<=1;
						count_r<=count_r-1;
						end
					else if (arbiter<=NML)
						begin
						pack_r[3]<=0;
						count_r<=count_r-1;
						end
					else
						begin
						send_button<=1;
						count_r<=15;
						end
					arbiter<=0;
					count_10<=0;
				end
			end
		4:	begin 
			count_10<=count_10+1;
			arbiter<=arbiter+data_r;
				if (count_10==sample_num-1)
				begin
					if (arbiter>=NMH)
						begin
						pack_r[4]<=1;
						count_r<=count_r-1;
						end
					else if (arbiter<=NML)
						begin
						pack_r[4]<=0;
						count_r<=count_r-1;
						end
					else
						begin
						send_button<=1;
						count_r<=15;
						end
					arbiter<=0;
					count_10<=0;
				end
			end
		3:	begin 
			count_10<=count_10+1;
			arbiter<=arbiter+data_r;
				if (count_10==sample_num-1)
				begin
					if (arbiter>=NMH)
						begin
						pack_r[5]<=1;
						count_r<=count_r-1;
						end
					else if (arbiter<=NML)
						begin
						pack_r[5]<=0;
						count_r<=count_r-1;
						end
					else
						begin
						send_button<=1;
						count_r<=15;
						end
					arbiter<=0;
					count_10<=0;
				end
			end
		2:	begin 
			count_10<=count_10+1;
			arbiter<=arbiter+data_r;
				if (count_10==sample_num-1)
				begin
					if (arbiter>=NMH)
						begin
						pack_r[6]<=1;
						count_r<=count_r-1;
						end
					else if (arbiter<=NML)
						begin
						pack_r[6]<=0;
						count_r<=count_r-1;
						end
					else
						begin
						send_button<=1;
						count_r<=15;
						end
					arbiter<=0;
					count_10<=0;
				end
			end
		1:	begin //last info bit
			count_10<=count_10+1;
			arbiter<=arbiter+data_r;
				if (count_10==sample_num-1)
				begin
					if (arbiter>=NMH)
						begin
						pack_r[7]<=1;
						count_r<=count_r-1;
						end
					else if (arbiter<=NML)
						begin
						pack_r[7]<=0;
						count_r<=count_r-1;
						end
					else
						begin
						send_button<=1;
						count_r<=15;
						end
					arbiter<=0;
					count_10<=0;
				end
			end
		0:	begin
			count_r<=count_r-1;
			pack_r_sta<=pack_r;
			temp<=pack_r;
			end
		15:
			begin
			count_10<=count_10+1;
			
			
			send_button<=1;
			pack_t<=pack_r;

				if (count_10==10*sample_num)
				begin
				count_r<=count_r-1;
				send_button<=0;			
				count_10<=0;
				end
			end
		default:
			begin
					if (!data_r)
					count_10<=count_10+1;

					if (count_10==sample_num-1)
					begin
					count_r<=8;
					count_10<=0;
					end
			end
		endcase
		end
	
	
//TXD//////////////////////////////////////////////////////////////////////////////
	always@(posedge clk_9600)
	begin
		if (send_button)
		begin
		count_t<=9;
		end
		case(count_t)
		9:	begin //start bit
			count_t<=count_t-1;
			data_t<=0;
			end
		8:	begin //first info bit
			count_t<=count_t-1;
			data_t<=pack_t[0];
			end
		7:	begin 
			count_t<=count_t-1;
			data_t<=pack_t[1];
			end
		6:	begin 
			count_t<=count_t-1;
			data_t<=pack_t[2];
			end
		5:	begin 
			count_t<=count_t-1;
			data_t<=pack_t[3];
			end
		4:	begin 
			count_t<=count_t-1;
			data_t<=pack_t[4];
			end
		3:	begin 
			count_t<=count_t-1;
			data_t<=pack_t[5];
			end
		2:	begin 
			count_t<=count_t-1;
			data_t<=pack_t[6];
			end
		1:	begin //last info bit
			count_t<=count_t-1;
			data_t<=pack_t[7];
			end
		0:	begin 
			data_t<=1;
			end
		default: ;
		endcase
		end
			
endmodule
