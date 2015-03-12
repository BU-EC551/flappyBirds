`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:59:56 03/31/2014 
// Design Name: 
// Module Name:    bg_rom_interface 
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
module bg_rom_interface(
	 input clk,
    input  [10:0]hcounter, vcounter,
	 output reg[7:0]bg_pixel
    );
	 parameter bg_upper=310;
	 parameter bg_lower=450;
	 
	 reg [14 : 0] addra;
	 wire [4:0]addr_output;
	 wire [10:0]v,h;

	 bg_rom BG_ROM(clk,addra,addr_output);
	 assign v=vcounter/2;
	 assign h=hcounter/2;

	 
	 always @(vcounter,hcounter,h,v)begin
		
		if ((hcounter<640)&&(hcounter>=0)&&(vcounter>=bg_upper)&&(vcounter<bg_lower))
			addra<=320*(v-155)+h;
		else
			addra<=0;
		end
			
	 always @(addr_output,vcounter)begin
	 if(vcounter<bg_upper)
		bg_pixel<=8'b00011111;
	 else if (vcounter>=bg_lower)
		bg_pixel<=8'b00011101;
	 else
	 case(addr_output)
			5'b00000:bg_pixel<=8'b00011111;
			5'b00001:bg_pixel<=8'b11111111;
			5'b00010:bg_pixel<=8'b10111111;
			5'b00011:bg_pixel<=8'b01111111;
			5'b00100:bg_pixel<=8'b10011111;
			5'b00101:bg_pixel<=8'b11011110;
			5'b00110:bg_pixel<=8'b11111110;
			5'b00111:bg_pixel<=8'b11011111;
			5'b01000:bg_pixel<=8'b11011011;
			5'b01001:bg_pixel<=8'b11111010;
			5'b01010:bg_pixel<=8'b10111110;
			5'b01011:bg_pixel<=8'b10111011;
			5'b01100:bg_pixel<=8'b11111001;
			5'b01101:bg_pixel<=8'b11111100;
			5'b01110:bg_pixel<=8'b11111101;
			5'b01111:bg_pixel<=8'b10011001;
			5'b10000:bg_pixel<=8'b00111001;
			5'b10001:bg_pixel<=8'b00011101;
			5'b10010:bg_pixel<=8'b01111001;
			5'b10011:bg_pixel<=8'b01011001;
			5'b10100:bg_pixel<=8'b01011010;
			5'b10101:bg_pixel<=8'b10011010;
			5'b10110:bg_pixel<=8'b01111010;
			5'b10111:bg_pixel<=8'b10011000;
		default:bg_pixel<=8'b10011000;
		endcase
	 end
	 

endmodule