`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:08:38 03/23/2014 
// Design Name: 
// Module Name:    debouncer 
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
module debouncer(input clk,input button1,output reg button2);

 reg [3:0] cnt1=0;
 reg [1:0]  cnt2=0;
 
always @(posedge clk) begin
  if(cnt1==0&&button1==1'b1) begin
  button2=1'b1;cnt2=2'b11;cnt1=4'b1011;end
  else if(button2==1'b1&&cnt2!=0) begin
  cnt2=cnt2-1'b1;cnt1=cnt1-1'b1;end
  else if (cnt2==0&&cnt1!=0) begin button2=1'b0;cnt1=cnt1-1;end
  else button2=1'b0;
end


endmodule
