`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:43:43 03/31/2014 
// Design Name: 
// Module Name:    bird_rom_interface 
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
module bird_rom_interface(
	 input clk,
	 input [1:0]state_input,
    input  [10:0]hcounter, vcounter,
	 input [10:0]bird_h_in,bird_v_in,
	 output reg[7:0]bird_pixel,
	 output reg bird_flag
    );
	 
    wire [5 : 0] douta;
	 reg [12 : 0] addra;
	 wire [10:0]bird_h,bird_v;
	 wire [2:0]index;
	 
	
	 
	 bird_rom BIRD_ROM(clk,addra,douta);
	 bird_state_generater BIRD_STATE_GENERATER(clk,state_input,index);
	 
	 assign bird_h=bird_h_in-16;
	 assign bird_v=bird_v_in-16;
	 
	 always @(hcounter,vcounter,bird_h,bird_v,index)begin
		if((hcounter>=bird_h)&&(hcounter<bird_h+32)&&(vcounter>=bird_v)&&(vcounter<bird_v+32))begin
			addra<=1024*index+32*(vcounter-bird_v)+hcounter-bird_h;
		end
		else
			addra<=0;
	 end
	 
	 always @(douta)begin
			case (douta)
			6'b000001:bird_pixel<=8'b01101101;
			6'b000010:bird_pixel<=8'b01001001;
			6'b000011:bird_pixel<=8'b10001101;
			6'b000100:bird_pixel<=8'b10001001;
			6'b000101:bird_pixel<=8'b01101001;
			6'b000110:bird_pixel<=8'b10010010;
			6'b000111:bird_pixel<=8'b11001100;
			6'b001000:bird_pixel<=8'b11110000;
			6'b001001:bird_pixel<=8'b11101100;
			6'b001010:bird_pixel<=8'b11011011;
			6'b001011:bird_pixel<=8'b11111111;
			6'b001100:bird_pixel<=8'b01000101;
			6'b001101:bird_pixel<=8'b10010001;
			6'b001110:bird_pixel<=8'b10110010;
			6'b001111:bird_pixel<=8'b10001110;
			6'b010000:bird_pixel<=8'b11101000;
			6'b010001:bird_pixel<=8'b11100100;
			6'b010010:bird_pixel<=8'b10110110;
			6'b010011:bird_pixel<=8'b11001000;
			6'b010100:bird_pixel<=8'b11011010;
			6'b010101:bird_pixel<=8'b10101001;
			6'b010110:bird_pixel<=8'b01101110;
			6'b010111:bird_pixel<=8'b11010110;
			6'b011000:bird_pixel<=8'b11010101;
			6'b011001:bird_pixel<=8'b11110101;
			6'b011010:bird_pixel<=8'b10110001;
			6'b011011:bird_pixel<=8'b11000100;
			6'b011100:bird_pixel<=8'b11111001;
			6'b011101:bird_pixel<=8'b11010001;
			6'b011110:bird_pixel<=8'b10100100;
			6'b011111:bird_pixel<=8'b10101000;
			6'b100000:bird_pixel<=8'b10001000;
			6'b100001:bird_pixel<=8'b10101101;
			6'b100010:bird_pixel<=8'b10101100;
			6'b100011:bird_pixel<=8'b11111011;
			6'b100100:bird_pixel<=8'b10000100;
			6'b100101:bird_pixel<=8'b10010110;
			6'b100110:bird_pixel<=8'b10111010;
			6'b100111:bird_pixel<=8'b01100101;
			6'b101000:bird_pixel<=8'b01001101;
			6'b101001:bird_pixel<=8'b10000101;
			6'b101010:bird_pixel<=8'b01110010;
			6'b101011:bird_pixel<=8'b11001101;
			default:bird_pixel<=8'b01101101;
			endcase;
	 end
	 
	 always @(hcounter,vcounter,bird_h,bird_v,douta)begin
		if((hcounter>=bird_h)&&(hcounter<bird_h+32)&&(vcounter>=bird_v)&&(vcounter<bird_v+32))begin
			if(douta==6'b000000)bird_flag<=1'b0;
			else bird_flag<=1'b1;
		end
		else bird_flag<=1'b0;
	 end
	 
	 
	 

endmodule