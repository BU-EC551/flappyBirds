`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:39:27 04/20/2014 
// Design Name: 
// Module Name:    pipe_rom_interface 
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
module pipe_rom_interface(
    input  [10:0]hcounter, vcounter,
	 input [10:0]pipe_center_0_in,pipe_center_1_in,pipe_center_2_in,
	 input [10:0]pipe_pisiton_0_in,pipe_pisiton_1_in,pipe_pisiton_2_in,
	 input [10:0]pipe_distance_0_in,pipe_distance_1_in,pipe_distance_2_in,
	 output reg[7:0]pipe_pixel,
	 output reg pipe_flag
    );
	 
	 reg [7 : 0] addra;
	 wire [3 : 0] douta;
	
	 wire [10:0]pipe_center_0,pipe_center_1,pipe_center_2;
	 wire [10:0]pipe_pisiton_0,pipe_pisiton_1,pipe_pisiton_2;
	 wire [10:0]pipe_distance_0,pipe_distance_1,pipe_distance_2;
	

	 
	 
	 pipe_rom PIPE_ROM(addra,douta);

		assign pipe_pisiton_0=pipe_pisiton_0_in-25;
	   assign pipe_center_0=pipe_center_0_in-(pipe_distance_0_in/2);
		assign pipe_distance_0=pipe_distance_0_in;

		assign pipe_pisiton_1=pipe_pisiton_1_in-25;
	   assign pipe_center_1=pipe_center_1_in-(pipe_distance_1_in/2);
		assign pipe_distance_1=pipe_distance_1_in;


		assign pipe_pisiton_2=pipe_pisiton_2_in-25;
	   assign pipe_center_2=pipe_center_2_in-(pipe_distance_2_in/2);
		assign pipe_distance_2=pipe_distance_2_in;




	 
	 always @(hcounter,vcounter,pipe_center_0,pipe_pisiton_0,pipe_distance_0,pipe_center_1,pipe_pisiton_1,pipe_distance_1,pipe_center_2,pipe_pisiton_2,pipe_distance_2)begin
		if((hcounter>=pipe_pisiton_0)&&(hcounter<pipe_pisiton_0+50)&&(vcounter>=pipe_center_0+pipe_distance_0)&&(vcounter<480))begin
			if((vcounter==pipe_center_0+pipe_distance_0)||(vcounter==pipe_center_0+pipe_distance_0+1)||(vcounter==pipe_center_0+pipe_distance_0+23))
				addra<=hcounter-pipe_pisiton_0;
			else if((vcounter>pipe_center_0+pipe_distance_0+1)&&(vcounter<pipe_center_0+pipe_distance_0+23))
				addra<=50+hcounter-pipe_pisiton_0;
			else if(vcounter==pipe_center_0+pipe_distance_0+24)
				addra<=100+hcounter-pipe_pisiton_0;
			else if(vcounter==pipe_center_0+pipe_distance_0+25)
				addra<=150+hcounter-pipe_pisiton_0;
			else
				addra<=200+hcounter-pipe_pisiton_0;
		end
	 
		else if((hcounter>=pipe_pisiton_0)&&(hcounter<pipe_pisiton_0+50)&&(vcounter<=pipe_center_0)&&(vcounter>0))begin
			if((vcounter==pipe_center_0)||(vcounter==pipe_center_0-1)||(vcounter==pipe_center_0-23))
				addra<=hcounter-pipe_pisiton_0;
			else if((vcounter>0)&&(vcounter<pipe_center_0-23))
				addra<=200+hcounter-pipe_pisiton_0;
			else
				addra<=50+hcounter-pipe_pisiton_0;
		end
		
		else if((hcounter>=pipe_pisiton_1)&&(hcounter<pipe_pisiton_1+50)&&(vcounter>=pipe_center_1+pipe_distance_1)&&(vcounter<480))begin
			if((vcounter==pipe_center_1+pipe_distance_1)||(vcounter==pipe_center_1+pipe_distance_1+1)||(vcounter==pipe_center_1+pipe_distance_1+23))
				addra<=hcounter-pipe_pisiton_1;
			else if((vcounter>pipe_center_1+pipe_distance_1+1)&&(vcounter<pipe_center_1+pipe_distance_1+23))
				addra<=50+hcounter-pipe_pisiton_1;
			else if(vcounter==pipe_center_1+pipe_distance_1+24)
				addra<=100+hcounter-pipe_pisiton_1;
			else if(vcounter==pipe_center_1+pipe_distance_1+25)
				addra<=150+hcounter-pipe_pisiton_1;
			else
				addra<=200+hcounter-pipe_pisiton_1;
		end
	 
		else if((hcounter>=pipe_pisiton_1)&&(hcounter<pipe_pisiton_1+50)&&(vcounter<=pipe_center_1)&&(vcounter>0))begin
			if((vcounter==pipe_center_1)||(vcounter==pipe_center_1-1)||(vcounter==pipe_center_1-23))
				addra<=hcounter-pipe_pisiton_1;
			else if((vcounter>0)&&(vcounter<pipe_center_1-23))
				addra<=200+hcounter-pipe_pisiton_1;
			else
				addra<=50+hcounter-pipe_pisiton_1;
		end
		
		else if((hcounter>=pipe_pisiton_2)&&(hcounter<pipe_pisiton_2+50)&&(vcounter>=pipe_center_2+pipe_distance_2)&&(vcounter<480))begin
			if((vcounter==pipe_center_2+pipe_distance_2)||(vcounter==pipe_center_2+pipe_distance_2+1)||(vcounter==pipe_center_2+pipe_distance_2+23))
				addra<=hcounter-pipe_pisiton_2;
			else if((vcounter>pipe_center_2+pipe_distance_2+1)&&(vcounter<pipe_center_2+pipe_distance_2+23))
				addra<=50+hcounter-pipe_pisiton_2;
			else if(vcounter==pipe_center_2+pipe_distance_2+24)
				addra<=100+hcounter-pipe_pisiton_2;
			else if(vcounter==pipe_center_2+pipe_distance_2+25)
				addra<=150+hcounter-pipe_pisiton_2;
			else
				addra<=200+hcounter-pipe_pisiton_2;
		end
	 
		else if((hcounter>=pipe_pisiton_2)&&(hcounter<pipe_pisiton_2+50)&&(vcounter<=pipe_center_2)&&(vcounter>0))begin
			if((vcounter==pipe_center_2)||(vcounter==pipe_center_2-1)||(vcounter==pipe_center_2-23))
				addra<=hcounter-pipe_pisiton_2;
			else if((vcounter>0)&&(vcounter<pipe_center_2-23))
				addra<=200+hcounter-pipe_pisiton_2;
			else
				addra<=50+hcounter-pipe_pisiton_2;
		end
	 

		else
			addra<=101;
	 end
	 
	 
	 always @(hcounter,vcounter,pipe_center_0,pipe_pisiton_0,pipe_distance_0,douta)begin
		if((hcounter>=pipe_pisiton_0)&&(hcounter<=pipe_pisiton_0+49)&&(vcounter>=pipe_center_0+pipe_distance_0)&&(vcounter<480))begin
				if(douta==6'b000000)pipe_flag<=1'b0;else pipe_flag<=1'b1;
		end
		else if((hcounter>=pipe_pisiton_0)&&(hcounter<=pipe_pisiton_0+49)&&(vcounter<=pipe_center_0)&&(vcounter>=0))begin
				if(douta==6'b000000)pipe_flag<=1'b0;else pipe_flag<=1'b1;
		end
		else if((hcounter>=pipe_pisiton_1)&&(hcounter<=pipe_pisiton_1+49)&&(vcounter>=pipe_center_1+pipe_distance_1)&&(vcounter<480))begin
				if(douta==6'b000000)pipe_flag<=1'b0;else pipe_flag<=1'b1;
		end
		else if((hcounter>=pipe_pisiton_1)&&(hcounter<=pipe_pisiton_1+49)&&(vcounter<=pipe_center_1)&&(vcounter>=0))begin
				if(douta==6'b000000)pipe_flag<=1'b0;else pipe_flag<=1'b1;
		end
		else if((hcounter>=pipe_pisiton_2)&&(hcounter<=pipe_pisiton_2+49)&&(vcounter>=pipe_center_2+pipe_distance_2)&&(vcounter<480))begin
				if(douta==6'b000000)pipe_flag<=1'b0;else pipe_flag<=1'b1;
		end
		else if((hcounter>=pipe_pisiton_2)&&(hcounter<=pipe_pisiton_2+49)&&(vcounter<=pipe_center_2)&&(vcounter>=0))begin
				if(douta==6'b000000)pipe_flag<=1'b0;else pipe_flag<=1'b1;
		end
		else
				pipe_flag<=1'b0;
	 end
	 
	 
	 /*
	 always @(hcounter,vcounter,pipe_center_0,pipe_pisiton_0,pipe_distance_0,pipe_center_1,pipe_pisiton_1,pipe_distance_1,pipe_center_2,pipe_pisiton_2,pipe_distance_2)begin
		if((hcounter>=pipe_pisiton_0)&&(hcounter<=pipe_pisiton_0+49)&&(vcounter>=pipe_center_0+pipe_distance_0+25)&&(vcounter<480))
			addra<=1250+hcounter-pipe_pisiton_0;
		else if((hcounter>=pipe_pisiton_0)&&(hcounter<=pipe_pisiton_0+49)&&(vcounter>=pipe_center_0+pipe_distance_0)&&(vcounter<pipe_center_0+pipe_distance_0+25))
			addra<=50*(vcounter-pipe_center_0-pipe_distance_0)+hcounter-pipe_center_0;
		else if((hcounter>=pipe_pisiton_0)&&(hcounter<=pipe_pisiton_0+49)&&(vcounter<pipe_center_0-25)&&(vcounter>=0))
			addra<=1300+hcounter-pipe_pisiton_0;
		else if((hcounter>=pipe_pisiton_0)&&(hcounter<=pipe_pisiton_0+49)&&(vcounter<=pipe_center_0)&&(vcounter>=pipe_center_0-25))
			addra<=1300+50*(25-pipe_center_0+vcounter)+hcounter-pipe_center_0;
			
		else if((hcounter>=pipe_pisiton_1)&&(hcounter<=pipe_pisiton_1+49)&&(vcounter>=pipe_center_1+pipe_distance_1+25)&&(vcounter<480))
			addra<=1250+hcounter-pipe_pisiton_1;
		else if((hcounter>=pipe_pisiton_1)&&(hcounter<=pipe_pisiton_1+49)&&(vcounter>=pipe_center_1+pipe_distance_1)&&(vcounter<pipe_center_1+pipe_distance_1+25))
			addra<=50*(vcounter-pipe_center_1-pipe_distance_1)+hcounter-pipe_center_1;
		else if((hcounter>=pipe_pisiton_1)&&(hcounter<=pipe_pisiton_1+49)&&(vcounter<pipe_center_1-25)&&(vcounter>=1))
			addra<=1300+hcounter-pipe_pisiton_1;
		else if((hcounter>=pipe_pisiton_1)&&(hcounter<=pipe_pisiton_1+49)&&(vcounter<=pipe_center_1)&&(vcounter>=pipe_center_1-25))
			addra<=1300+50*(25-pipe_center_1+vcounter)+hcounter-pipe_center_1;
		
		else if((hcounter>=pipe_pisiton_2)&&(hcounter<=pipe_pisiton_2+49)&&(vcounter>=pipe_center_2+pipe_distance_2+25)&&(vcounter<480))
			addra<=1250+hcounter-pipe_pisiton_2;
		else if((hcounter>=pipe_pisiton_2)&&(hcounter<=pipe_pisiton_2+49)&&(vcounter>=pipe_center_2+pipe_distance_2)&&(vcounter<pipe_center_2+pipe_distance_2+25))
			addra<=50*(vcounter-pipe_center_2-pipe_distance_2)+hcounter-pipe_center_2;
		else if((hcounter>=pipe_pisiton_2)&&(hcounter<=pipe_pisiton_2+49)&&(vcounter<pipe_center_2-25)&&(vcounter>=2))
			addra<=1300+hcounter-pipe_pisiton_2;
		else if((hcounter>=pipe_pisiton_2)&&(hcounter<=pipe_pisiton_2+49)&&(vcounter<=pipe_center_2)&&(vcounter>=pipe_center_2-25))
			addra<=1300+50*(25-pipe_center_2+vcounter)+hcounter-pipe_center_2;
		else
			addra<=1301;
	 end
	 
	 
	 always @(hcounter,vcounter,pipe_center_0,pipe_pisiton_0,pipe_distance_0,douta)begin
		if((hcounter>=pipe_pisiton_0)&&(hcounter<=pipe_pisiton_0+49)&&(vcounter>=pipe_center_0+pipe_distance_0)&&(vcounter<480))begin
				if(douta==6'b000000)pipe_flag<=1'b0;else pipe_flag<=1'b1;
		end
		else if((hcounter>=pipe_pisiton_0)&&(hcounter<=pipe_pisiton_0+49)&&(vcounter<=pipe_center_0)&&(vcounter>=0))begin
				if(douta==6'b000000)pipe_flag<=1'b0;else pipe_flag<=1'b1;
		end
		else if((hcounter>=pipe_pisiton_1)&&(hcounter<=pipe_pisiton_1+49)&&(vcounter>=pipe_center_1+pipe_distance_1)&&(vcounter<480))begin
				if(douta==6'b000000)pipe_flag<=1'b0;else pipe_flag<=1'b1;
		end
		else if((hcounter>=pipe_pisiton_1)&&(hcounter<=pipe_pisiton_1+49)&&(vcounter<=pipe_center_1)&&(vcounter>=0))begin
				if(douta==6'b000000)pipe_flag<=1'b0;else pipe_flag<=1'b1;
		end
		else if((hcounter>=pipe_pisiton_2)&&(hcounter<=pipe_pisiton_2+49)&&(vcounter>=pipe_center_2+pipe_distance_2)&&(vcounter<480))begin
				if(douta==6'b000000)pipe_flag<=1'b0;else pipe_flag<=1'b1;
		end
		else if((hcounter>=pipe_pisiton_2)&&(hcounter<=pipe_pisiton_2+49)&&(vcounter<=pipe_center_2)&&(vcounter>=0))begin
				if(douta==6'b000000)pipe_flag<=1'b0;else pipe_flag<=1'b1;
		end
		else
				pipe_flag<=1'b0;
	 end
	 */
	 
	 always @(douta)begin
			case (douta)
			4'b0001:pipe_pixel<=8'b01101001;
			4'b0010:pipe_pixel<=8'b00010000;
			4'b0011:pipe_pixel<=8'b01111000;
			4'b0100:pipe_pixel<=8'b01110100;
			4'b0101:pipe_pixel<=8'b01010100;
			4'b0110:pipe_pixel<=8'b00110000;
			4'b0111:pipe_pixel<=8'b11011100;
			4'b1000:pipe_pixel<=8'b10111100;
			4'b1001:pipe_pixel<=8'b10111000;
			4'b1010:pipe_pixel<=8'b10011000;
			4'b1011:pipe_pixel<=8'b01010000;
			4'b1100:pipe_pixel<=8'b10010100;
			4'b1101:pipe_pixel<=8'b00101100;
			default:pipe_pixel<=8'b01001001;
			endcase;
	 end
	 
	 


endmodule