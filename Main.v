`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:37:59 03/20/2014 
// Design Name: 
// Module Name:    Main 
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
module Main(input clk,pushin,began,paus,quit,input [2:0] choice, output reg [2:0] state,output[7:0] color, output HS,VS,
				//UART
				output STATUS_OUT, input STATUS_IN,output RST,output data_t,output clk_9600,input send_button,input data_r);
parameter birdcolumn=250;
parameter idle=3'b000,set=3'b001,set2=3'b010,play=3'b011,pause=3'b100,fail=3'b101,fail2=3'b110;
parameter set2time=6'b111111;

reg pulse_flap;
reg [8:0] row[2:0];//for obstacle
reg [9:0] column[2:0];//for obstacle
reg [7:0] height;//for obstacle slot,<=127
reg [5:0] score;
reg [8:0] birdrow;
reg [1:0] birdangle;
 //game state
reg [5:0] counter1;//state set2 time
reg [7:0] counter2;//obstacle time
reg collide;
reg [3:0] risetimec;
reg [6:0] falltimec;
wire push1,push,clk1;
wire [8:0] randomR;
wire [7:0] temp;
reg [7:0] temp1;
wire [2:0] Choice;
wire Began,Pause,Quit;
integer i,j;

debouncer D1(clk1,pushin,push1);
Random R(clk1,randomR);
VGA vga(clk,state,score,birdrow,height,row[0],row[1],row[2],column[0],column[1],column[2],birdangle,color,HS,VS);
divider dv2(.clk(clk),.clk1(clk1));

//UART//////////////////////////////////////////////////////////////////////////////


UART uart(
				//PMOD
				STATUS_OUT,//output STATUS_OUT,  //show status on a LED
				STATUS_IN,//input STATUS_IN,
			   RST,//output reg RST=1,
				data_t,//output reg data_t=1,
				clk_9600,//output clk_9600,
				temp,//	output reg	[7:0] temp=0,
				clk,//input clk,
				send_button,//input send_button,
				data_r//input data_r
				);
//////////////////////////////////////////////////////////////////////////////

assign push=push1||temp1[0];
assign Choice=choice;
assign Began=began||temp1[3];
assign Pause=paus||temp1[2];
assign Quit=quit||temp1[1];

always@(temp) begin
 if(temp==8'b00100000) temp1=8'b00000100;else
 if(temp==8'b01100001) temp1=8'b00000010;else
 if(temp==8'b01100110) temp1=8'b00000001;else
 if(temp==8'b01110011) temp1=8'b00001000;else
 temp1=8'b0;
end

always@(posedge clk1) begin //control logic
 if(state==idle&&Began==1'b1)state=set;else
 if(state==set) begin if(Choice==3'b100) begin height=180;state=set2;counter1=set2time;end else
                      if(Choice==3'b010) begin height=140;state=set2;counter1=set2time;end else
							 if(Choice==3'b001) begin height=100;state=set2;counter1=set2time;end else
							 begin state=set;height=0;end 
					 end else
 if(state==set2) begin if(counter1==0) begin state=play;score=6'b0; collide=1'b0; row[0]=0;row[1]=0;row[2]=0;birdangle=2'b00;
                                             column[0]=0;column[1]=0;column[2]=0;birdrow=240;falltimec=0;risetimec=0;counter2=200;
                                       end //inicialize
                       else counter1=counter1-1; end else
 if(state==play) begin if(Pause==1'b1) state=pause; else if(collide==1) state=fail2;else state=play;end else
 if(state==pause) begin if(Quit==1'b1) state=play;else state=pause;end else
 if(state==fail2) begin if(birdrow>440) state=fail;else state=fail2;end else
 if(state==fail) begin if(Quit==1'b1) state=idle;else state=fail;end else
 state=idle;
 
 if(state==play) begin //bird timer
   if(push==1) begin risetimec=4'b1011;falltimec=7'b0;end else
   if(push==0&&risetimec>0) risetimec=risetimec-1; else
   if(push==0&&risetimec==0&&falltimec<7'b1111111) falltimec=falltimec+1;
	else falltimec=7'b1111111;
 end

 if(state==play) begin//bird position control
   if(risetimec>4'b1000 && birdrow>19) begin birdrow=birdrow-5;birdangle=2'b01;end else if(risetimec>4'b0011 && birdrow>19) begin birdrow=birdrow-4;birdangle=2'b01;end else if(risetimec>4'b0000 && birdrow>19) begin birdrow=birdrow-2;birdangle=2'b00;end else if(risetimec>0 && birdrow<=19) begin birdrow=19;birdangle=2'b00;end
	else if(risetimec==0&& birdrow<458) begin birdrow=birdrow+falltimec[6:4];birdangle=2'b10;end else
	begin birdrow=465;birdangle=2'b00;end
 end
 
 if(state==play) begin //obstacle
  if(counter2==119) begin//timer to generate new obstacle
    row[2]=row[1];column[2]=column[1];row[1]=row[0];column[1]=column[0];column[0]=610;row[0]=randomR;
	 end
  if(counter2==0) counter2=120;else counter2=counter2-1;//timer reset
  
  for(i=0;i<3;i=i+1) begin //obstacle move on
    if(column[i]>=25) column[i]=column[i]-2;else column[i]=0;
  end
 end

 if(state==play) begin//score
   for(i=0;i<3;i=i+1) begin if(column[i]==birdcolumn-25-15) score=score+1;else score=score;end
 end
 
 if(state==play) begin //collide control
	if((column[0]>birdcolumn-25-15)&&(column[0]<birdcolumn+25+15)) begin if((birdrow<row[0]+height/2-12)&&(birdrow>row[0]-height/2+12)) collide=1'b0;else collide=1'b1;end else
   if((column[1]>birdcolumn-25-15)&&(column[1]<birdcolumn+25+15)) begin if((birdrow<row[1]+height/2-12)&&(birdrow>row[1]-height/2+12)) collide=1'b0;else collide=1'b1;end else collide=1'b0;
 end
 
 if(state==fail2) begin birdrow=birdrow+4; end 
 
end

endmodule



//////////////////////////////////////////////////////////////////
module Random(input clk,output reg [8:0] random);//random number generator
reg [6:0] counter=0;
reg [4:0] random1;
always@(posedge clk) begin
 counter=counter+1;
 case(counter[3:0])
   3'b000: random1=4'b1101^counter[5:2];
	3'b001: random1=4'b1110^counter[5:2];
	3'b010: random1=4'b1111^counter[6:3];
	3'b011: random1=4'b0111^counter[5:2];
	3'b100: random1=4'b0110^counter[6:3];
	3'b101: random1=4'b1101^counter[5:2];
	3'b110: random1=4'b1110^counter[6:3];
	default: random1=4'b1011^counter[5:2];
 endcase
 random=365-17*random1;
end

endmodule
