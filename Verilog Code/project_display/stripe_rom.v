`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:58:25 04/25/2014 
// Design Name: 
// Module Name:    stripe_rom 
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
module stripe_rom_interface(
	 input clk,
	 input [2:0]state,
    input  [10:0]hcounter, vcounter,
	 output reg[7:0]stripe_pixel,
	 output reg stripe_flag
    );
	 
		reg [8 : 0] a;
		wire [3 : 0] spo;
		reg [19:0]counter;
	   reg divided_clk;
		reg [4:0]offset;
		reg [4:0]offset_state;
		reg [5:0]index;

	  stripe_rom STRIPE_ROM(a,spo);
	  
	  
	 always @(posedge clk)begin
		if(state==3'b011)
		counter<=counter+1'b1;
	 end
	 
	 always @(posedge counter[19])begin	
		if(offset_state==19)offset_state<=0;
		else offset_state<=offset_state+1'b1;
	 end
	 
	 always @(vcounter,hcounter)begin
		index<=hcounter/19;
	 end
	 
	 always @(offset_state,hcounter,index)begin
		if(hcounter-index*19<=19-offset_state)
		offset<=hcounter-index*19+offset_state;
		else
		offset<=hcounter-index*19+offset_state-19;
	 end
	 
	 always @(vcounter,hcounter)begin
		
		if ((hcounter<640)&&(hcounter>=0)&&(vcounter>=460)&&(vcounter<480))
			a<=20*(vcounter-460)+offset;
		else
			a<=0;
		end
			
	 always @(a)begin

	 case(spo)
			4'b0000:stripe_pixel<=8'b01101001;
			4'b0001:stripe_pixel<=8'b01001001;
			4'b0010:stripe_pixel<=8'b11011001;
			4'b0011:stripe_pixel<=8'b11011110;
			4'b0100:stripe_pixel<=8'b11011101;
			4'b0101:stripe_pixel<=8'b10011101;
			4'b0110:stripe_pixel<=8'b01111100;
			4'b0111:stripe_pixel<=8'b01111000;
			4'b1000:stripe_pixel<=8'b10011100;
			4'b1001:stripe_pixel<=8'b01110100;
			4'b1010:stripe_pixel<=8'b01110000;
			4'b1011:stripe_pixel<=8'b11110100;
			4'b1100:stripe_pixel<=8'b11111001;
			4'b1101:stripe_pixel<=8'b11111010;
		default:stripe_pixel<=8'b10011000;
		endcase
	 end
	 
	 	always @(vcounter,hcounter)begin
		
		if ((hcounter<640)&&(hcounter>=0)&&(vcounter>=460)&&(vcounter<480))
			stripe_flag<=1;
		else
			stripe_flag<=0;
		end
	 

endmodule