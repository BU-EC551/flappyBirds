`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:45:53 03/31/2014 
// Design Name: 
// Module Name:    display_mux 
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
module display_mux(
	 input [2:0]state,
	 input [7:0]bird_pixel,
	 input [7:0]bird_blue_pixel,
	 input [7:0]bg_pixel,
	 input [7:0]pipe_pixel,
	 input [7:0]score_pixel,
	 input [7:0]word_pixel,
	 input [7:0]stripe_pixel,
	 input bird_flag,
	 input bird_blue_flag,
	 input pipe_flag,
	 input score_flag,
	 input word_flag,
	 input stripe_flag,
	 output reg[7:0]display_pixel_out
    );
	 reg [7:0]display_pixel;
	 always @(bird_pixel,bird_blue_pixel,bg_pixel,pipe_pixel,score_pixel,word_pixel,bird_flag,bird_blue_flag,pipe_flag,score_flag,word_flag)begin
	 case(state)
	 3'b000:begin
			  if (stripe_flag==1)display_pixel<=stripe_pixel;
			  else if (word_flag==1)display_pixel<=word_pixel;
		     //else if (pipe_flag==1)display_pixel<=pipe_pixel;
		     else if (bird_flag==1)display_pixel<=bird_pixel;
			  else if (bird_blue_flag==1)display_pixel<=bird_blue_pixel;
		     else display_pixel<=bg_pixel;
			  end
	 3'b011:begin
			  if (stripe_flag==1)display_pixel<=stripe_pixel;
			  else if(score_flag==1)display_pixel<=score_pixel;
		     else if (pipe_flag==1)display_pixel<=pipe_pixel;
		     else if (bird_flag==1)display_pixel<=bird_pixel;
			  else if (bird_blue_flag==1)display_pixel<=bird_blue_pixel;
		     else display_pixel<=bg_pixel;
			  end
	 3'b101:begin
			  if (stripe_flag==1)display_pixel<=stripe_pixel;
			  else if (word_flag==1)display_pixel<=word_pixel;
		     else if (pipe_flag==1)display_pixel<=pipe_pixel;
		     else if (bird_flag==1)display_pixel<=bird_pixel;
			  else if (bird_blue_flag==1)display_pixel<=bird_blue_pixel;
		     else display_pixel<=bg_pixel;
			  end  
			  
	 3'b010:begin
			  if (stripe_flag==1)display_pixel<=stripe_pixel;
			  else if (word_flag==1)display_pixel<=word_pixel;
		     else if (bird_flag==1)display_pixel<=bird_pixel;
			  else if (bird_blue_flag==1)display_pixel<=bird_blue_pixel;
		     else display_pixel<=bg_pixel;
			  end
			  
	 3'b001:begin
			  if (stripe_flag==1)display_pixel<=stripe_pixel;
		     else if (bird_flag==1)display_pixel<=bird_pixel;
			  else if (bird_blue_flag==1)display_pixel<=bird_blue_pixel;
		     else display_pixel<=bg_pixel;
			  end
			  
	 
			  
			  
	 default:begin
			  if (stripe_flag==1)display_pixel<=stripe_pixel;
			  else if(score_flag==1)display_pixel<=score_pixel;
		     else if (pipe_flag==1)display_pixel<=pipe_pixel;
		     else if (bird_flag==1)display_pixel<=bird_pixel;
			  else if (bird_blue_flag==1)display_pixel<=bird_blue_pixel;
		     else display_pixel<=bg_pixel;
			  end
	 endcase
	 end
	 
	 always @(display_pixel,state)
	 case(state)
	 3'b100:begin
		if(display_pixel==8'b00011111)display_pixel_out<=8'b01001111;
		else if(display_pixel==8'b11111111)display_pixel_out<=8'b00011110;
		else if(display_pixel==8'b00011101)display_pixel_out<=8'b10111110;
		else display_pixel_out<=display_pixel;
		end
	 default:
	 display_pixel_out<=display_pixel;
	 
	 endcase
endmodule
