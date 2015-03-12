`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:29:10 03/23/2014 
// Design Name: 
// Module Name:    VGA 
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
module VGA(input clk,input[2:0]state,input[5:0]score,input[8:0] birdrow,input[7:0]height,input[8:0] row0,row1,row2,input[9:0]column0,column1,column2,input[1:0] birdangle,output reg[7:0] color,output reg HS,VS);

parameter H=525;
parameter W=800;
 integer i,j;
 reg [7:0] m;
 wire clk3;
  divider dv(.clk(clk),.clk3(clk3));

  
 always @ (posedge clk3) begin
  if(i<W) i<=i+1;else i<=0;   //HS 
 end
 
 always @ (posedge clk3) begin
  if(j<H&&i==W) j<=j+1;else  //VS
  if(j==H&&i==W) j<=0;  
  end
  
 always @ (posedge clk3) begin 
   if(i>648&&i<744) HS<=0;else HS<=1;
 end
	
 always @ (posedge clk3) begin 
   if(j>482&&j<484) VS<=0;else VS<=1;
 end

always @(posedge clk3) begin //draw
 if (state==3'b000) begin if(i>200&&i<400&&j>100&&j<200) color=8'b11100000;else color=8'b0;end else //idle
 if (state==3'b001) begin if(i>200&&i<400&&j>100&&j<200) color=8'b00011100;end else //set
 if (state==3'b010) begin if(height==100&&i>300&&i<400&&j>100&&j<200) color=8'b00000100;else// show chosen difficulty
                          if(height==80&&i>300&&i<400&&j>100&&j<200) color=8'b00001100;else 
                          if(height==60&&i>300&&i<400&&j>100&&j<200) color=8'b00010100;else
                				color=8'b0;				  
						  end else
 if (state==3'b011||state==3'b110) begin //playing
   if(i>column0-25&&i<column0+25&&(j<row0-height/2||j>row0+height/2)&&j>0&&j<480) color=8'b11100000;else
	if(i>column1-25&&i<column1+25&&(j<row1-height/2||j>row1+height/2)&&j>0&&j<480) color=8'b11100000;else
 	if(i>column2-25&&i<column2+25&&(j<row2-height/2||j>row2+height/2)&&j>0&&j<480) color=8'b11100000;else
	if(i>235&&i<265&&j>birdrow-12&&j<birdrow+12&&birdangle==2'b00) color=8'b00011100;else
	if(i>235&&i<265&&j>birdrow-12&&j<birdrow+12&&birdangle==2'b01) color=8'b00000011;else
   if(i>235&&i<265&&j>birdrow-12&&j<birdrow+12&&birdangle==2'b10) color=8'b00001010;else 
	color=8'b0;
  end else
 if (state==3'b100) begin //for pause
   if(i>column0-25&&i<column0+25&&(j<row0-height/2||j>row0+height/2)&&j>0&&j<480) color=8'b01000000;else
	if(i>column1-25&&i<column1+25&&(j<row1-height/2||j>row1+height/2)&&j>0&&j<480) color=8'b01000000;else
 	if(i>column2-25&&i<column2+25&&(j<row2-height/2||j>row2+height/2)&&j>0&&j<480) color=8'b01000000;else
	if(i>235&&i<265&&j>birdrow-12&&j<birdrow+12) color=8'b00001000;else
   color=8'b0;end else
 if (state==3'b101) begin if(i>200&&i<400&&j>100&&j<200) color=8'b00011111;else color=8'b0;end //show score on it
 
end


endmodule





