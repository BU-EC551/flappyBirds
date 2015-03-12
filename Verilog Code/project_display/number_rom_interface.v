`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:17:08 04/23/2014 
// Design Name: 
// Module Name:    number_rom_interface 
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
module number_rom_interface(
	 input clk,
	 input [7:0]binary,
	 input [7:0]binary_1,
	 input mode,
    input  [10:0]hcounter, vcounter,
	 output reg[7:0]number_pixel,
	 output reg num_flag
    );
	 
    wire [1 : 0] douta;
	 reg [13 : 0] addra;
	 wire [3:0] Hundreds;
	 wire [3:0] Tens;
	 wire [3:0] Ones;
	 
	 wire [3:0] Hundreds_1;
	 wire [3:0] Tens_1;
	 wire [3:0] Ones_1;
	 
	 reg [10:0]position_hun,position_ten,position_one;
	 reg [10:0]position_hun_1,position_ten_1,position_one_1;
	 wire [10:0]v,h;
	 
	 BCD BCD(binary,Hundreds,Tens,Ones);
	 BCD BCD_1(binary_1,Hundreds_1,Tens_1,Ones_1);
	 number_rom NUMBER_ROM(clk,addra,douta);
	 
	 
	 assign v=vcounter/2;
	 assign h=hcounter/2;
	 
	 
	 
	 always @(binary,mode)begin
	 case(mode)
	 0:
		if(binary>99)begin
		  position_hun<=265;//265
		  position_ten<=300;//300
		  position_one<=335;//335
		  position_hun_1<=2000;//265
		  position_ten_1<=2000;
		  position_one_1<=2000;
		  end
		else if(binary>9)begin
		  position_hun<=2000;//265
		  position_ten<=287;
		  position_one<=322;
		  position_hun_1<=2000;//265
		  position_ten_1<=2000;
		  position_one_1<=2000;
		  end
		else begin
		  position_hun<=2000;//265
		  position_ten<=2000;
		  position_one<=300;
		  position_hun_1<=2000;//265
		  position_ten_1<=2000;
		  position_one_1<=2000;
	 end 
	 1:begin
	 if(binary>99)begin
		  position_hun<=65;//265
		  position_ten<=100;//300
		  position_one<=135;//335
		  end
		else if(binary>9)begin
		  position_hun<=2000;//265
		  position_ten<=87;
		  position_one<=122;
		  end
		else begin
		  position_hun<=2000;//265
		  position_ten<=2000;
		  position_one<=100;
		  
	if(binary_1>99)begin
		  position_hun_1<=465;//265
		  position_ten_1<=500;//300
		  position_one_1<=535;//335
		  end
		else if(binary>9)begin
		  position_hun_1<=2000;//265
		  position_ten_1<=487;
		  position_one_1<=522;
		  end
		else begin
		  position_hun_1<=2000;//265
		  position_ten_1<=2000;
		  position_one_1<=500;
	 end 

	 end 

	 end
	 
	 endcase
	 
	 end
	 
	 always @(douta)begin
	 case(douta)
         2'b01:number_pixel<=8'b00000000;
			2'b10:number_pixel<=8'b11111111;
		default:number_pixel<=8'b00000000;
		endcase
	 end
	 
	 
	 
	 
	 always @(hcounter,vcounter,Hundreds,Tens,Ones,position_hun,position_ten,position_one,Hundreds_1,Tens_1,Ones_1,position_hun_1,position_ten_1,position_one_1,v,h,binary_1)begin
		if((vcounter>=70)&&(vcounter<118))begin
		
			if((hcounter>=position_one)&&(hcounter<position_one+32))begin
			addra<=Ones*1536+32*(vcounter-70)+hcounter-(position_one);
			end
		
		
			else if((hcounter>=position_ten)&&(hcounter<position_ten+32))begin
			if(binary>9)begin addra<=Tens*1536+32*(vcounter-70)+hcounter-(position_ten);end
			end
		
			else if((hcounter>=position_hun)&&(hcounter<position_hun+32))begin
			if(binary>99)begin addra<=Hundreds*1536+32*(vcounter-70)+hcounter-(position_hun);end
			end
			
			else if((hcounter>=position_one_1)&&(hcounter<position_one_1+32))begin
			addra<=Ones_1*1536+32*(vcounter-70)+hcounter-(position_one_1);
			end
		
		
			else if((hcounter>=position_ten_1)&&(hcounter<position_ten_1+32))begin
			if(binary_1>9)begin addra<=Tens_1*1536+32*(vcounter-70)+hcounter-(position_ten_1);end
			end
		
			else if((hcounter>=position_hun_1)&&(hcounter<position_hun_1+32_1))begin
			if(binary_1>99)begin addra<=Hundreds_1*1536+32*(vcounter-70)+hcounter-(position_hun_1);end
			end
			else addra<=0;
			end
		
	 else addra<=0;
	 end
	 
	 
	 
	 always @(hcounter,vcounter,position_hun,position_ten,position_one,position_hun_1,position_ten_1,position_one_1,douta)begin
		if((vcounter>=70)&&(vcounter<118))begin
		
			if((hcounter>=position_one)&&(hcounter<position_one+32))begin
			if(douta==0)num_flag<=0;else num_flag<=1;
			end
		
			else if((hcounter>=position_ten)&&(hcounter<position_ten+32))begin
			if(douta==0)num_flag<=0;else num_flag<=1;
			end
		
			else if((hcounter>=position_hun)&&(hcounter<position_hun+32))begin
			if(douta==0)num_flag<=0;else num_flag<=1;
			end
			
			else if((hcounter>=position_one_1)&&(hcounter<position_one_1+32))begin
			if(douta==0)num_flag<=0;else num_flag<=1;
			end
		
			else if((hcounter>=position_ten_1)&&(hcounter<position_ten_1+32))begin
			if(douta==0)num_flag<=0;else num_flag<=1;
			end
		
			else if((hcounter>=position_hun_1)&&(hcounter<position_hun_1+32))begin
			if(douta==0)num_flag<=0;else num_flag<=1;
			end
			
			else num_flag<=0;
		
		
	 end
	 else num_flag<=0;
	 end


endmodule
