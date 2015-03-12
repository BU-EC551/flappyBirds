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

module Main(input clk,pushin,paus,quit,output reg [2:0] state,output[2:0] r,g,output [1:0]b, output HS,VS,output test,
				//UART
				output STATUS_OUT, input STATUS_IN,output RST,output data_t,input data_r,
				output data_t2,input data_r2);

parameter set0=3'b000,set=3'b001,set2=3'b010,play=3'b011,pause=3'b100,fail=3'b101;//
parameter set2time=6'b111111;

reg pulse_flap;
reg [8:0] row[2:0];//for obstacle
reg [9:0] column[2:0];//for obstacle
reg [7:0] height,height2;//for obstacle slot,<=127
reg heightdir,heightch;//height increase or decrease, whether change
reg [7:0] score1,score2;
reg [8:0] birdrow1,birdrow2;
reg [7:0] birdcolumn1,birdcolumn2;
reg [1:0] birdangle1,birdangle2;//bird state
 //game state
reg [5:0] counter1;//state "set2" time
reg [7:0] counter2;//new obstacle appear time
reg collide1,collide2;
reg [3:0] risetimec1,risetimec2;//for bird
reg [6:0] falltimec1,falltimec2;//for bird
wire push,push1,push2,clk1; //push is button flappy control
wire [8:0] randomR;
wire [7:0] temp,temp2; //data received
reg [7:0] temp1,temp21;//data temp
wire [2:0] Choice;
wire Pause,Quit;
reg mode;
integer i,j; //loop varieble
reg [1:0] level;


//UART//////////////////////////////////////////////////////////////////////////////


UART uart(
				//PMOD
				STATUS_OUT,//output STATUS_OUT,  //show status on a LED
				STATUS_IN,//input STATUS_IN,
			   RST,//output reg RST=1,
				data_t,//output reg data_t,
				temp,//	output reg	[7:0] temp=0
				clk,//input clk,
				data_r//received data_r from UART
				);
				
UARTKEY uartkey(
				data_t2,
				temp2,
				clk,
				data_r2
				);
//////////////////////////////////////////////////////////////////////////////




debouncer D1(clk1,pushin,push1); 
Random R(clk1,randomR);
//VGA vga(clk,state,mode,score1,score2,birdrow1,birdrow2,birdcolumn1,birdcolumn2,height2,row[0],row[1],row[2],column[0],column[1],column[2],birdangle1,birdangle2,color,HS,VS);
divider dv2(.clk(clk),.clk1(clk1));//clk1=60Hz

display_module VGA(clk,mode,
	 birdangle1,
	 birdangle2,
	 score1,
	 score2,
	 state,
	 level,
	 birdcolumn1,birdrow1,
	 birdcolumn2,birdrow2,
	 row[0],row[1],row[2],
	 column[0],column[1],column[2],
	 height2,height2,height2,
	 r,g,
	 b,
	 HS, VS
    );


assign test=temp1[0];
assign push=STATUS_IN? temp1[0]:push1||temp21[0]; //combine button and UART, for player1
assign push2=temp21[7]; //for player2 
assign Pause=paus||temp1[2]||temp21[2];//combine button and UART and keyboard
assign Quit=STATUS_IN? quit||temp1[1]:quit||temp21[1];//combine button and UART and keyboard

always@(posedge clk1) begin  //decode uart

case(temp)
   0:temp1=8'b0;
	8'b00100000:temp1=8'b00000100;
   8'b01100001:temp1=8'b00000010;
   8'b01100110:temp1=8'b00000001;
	8'b01101100:temp1=8'b10000000;
   8'b01110011:temp1=8'b00001000;
	8'b00110001:temp1=8'b01000000;
	8'b00110010:temp1=8'b00100000;
	8'b00110011:temp1=8'b00010000;
   default:temp1=8'b0; //if using if,too much if will cause synthesize error
endcase
end

always@(posedge clk1) begin  //decode uartkey
   
case(temp2)
   8'b00100000:temp21=8'b00000100; //pause "space"
	8'b01100001:temp21=8'b00000010; //quit  "a"
	8'b01100110:temp21=8'b00000001; //push "f" for player1
	8'b01101100:temp21=8'b10000000; //push2 "l" for player2
	8'b01110011:temp21=8'b00001000; //push "s"
	8'b00110001:temp21=8'b01000000; //easy
	8'b00110010:temp21=8'b00100000; //midium
	8'b00110011:temp21=8'b00010000; //hard
default:temp21=8'b0; 
endcase	

end

always@(posedge clk1) begin //control logic

 if(state==set0) begin 
                if(STATUS_IN==1) begin 
					                      if(temp1[0]) begin mode=1'b0;state=set;end //single player
												 else if(temp1[7]||temp21[7]) begin mode=1'b1;state=set;end //multi
												 else state=set0;
											end
					 else begin
					         if(temp21[0]) begin mode=1'b0;state=set;end 
							   else if(temp21[7]) begin mode=1'b1;state=set;end
								else state=set0;
					      end
					 end 
					 
 if(state==set) begin 
                if(Quit==1'b1)     begin state=set0;end else
                if(temp1[6:4]==3'b100||temp21[6:4]==3'b100) begin state=set2;height=210;level=2'b0;heightch=0;counter1=set2time;end else
                if(temp1[6:4]==3'b010||temp21[6:4]==3'b010) begin state=set2;height=150;level=2'b01;heightch=0;counter1=set2time;end else
					 if(temp1[6:4]==3'b001||temp21[6:4]==3'b001) begin state=set2;height=130;level=2'b10;heightch=1;counter1=set2time;end else
						                 begin state=set;height=0;end 
					 end 
 else
 if(state==set2) begin 
                    if(counter1==0) begin state=play;
					                           score1=8'b0;score2=8'b0;collide1=1'b0; birdangle1=2'b00;birdangle2=2'b00;
													   row[0]=1'b0;row[1]=1'b0;row[2]=1'b0;column[0]=1'b0;column[1]=1'b0;column[2]=1'b0;
                                          birdrow1=240;falltimec1=0;falltimec2=0;risetimec1=0;risetimec2=0;counter2=140;
														birdcolumn1=250;birdcolumn2=150;heightdir=1'b1;height2=height;
														collide2=mode?1'b0:1'b1;
														birdrow2=mode?240:511;
														
                                    end //inicialize
                    else counter1=counter1-1; //show difficulty for one second
					  end 
 else
 if(state==play) begin 
                    if(Pause==1'b1) state=pause; else 
						  if(birdrow1>470&&birdrow2>470)  state=fail; else 
						   state=play;
					  end 
 else
 if(state==pause) begin 
                     if(Quit==1'b1) state=play; else 
						                  state=pause;
						end 
 else
 
 if(state==fail) begin 
                     if(Quit==1'b1) state=set; else 
							               state=fail;
					  end 
 else
 state=set0;
 //////////////////////////////////////////////////////////////////////
 
 if(state==play) begin //bird timer
                    if(push==1) begin risetimec1=4'b1011;falltimec1=7'b0;end 
						  else
                    if(push==0&&risetimec1>0) risetimec1=risetimec1-1; 
						  else
                    if(push==0&&risetimec1==0&&falltimec1<7'b1111111) falltimec1=falltimec1+1;
	                 else falltimec1=7'b1111111;
						  
						  if(mode==1'b1) begin 
						                       if(push2==1) begin risetimec2=4'b1011;falltimec2=7'b0;end 
						                       else
                                         if(push2==0&&risetimec2>0) risetimec2=risetimec2-1; 
						                       else
                                         if(push2==0&&risetimec2==0&&falltimec2<7'b1111111) falltimec2=falltimec2+1;
	                                      else falltimec2=7'b1111111; 
												 end
                 end

 if(state==play&&collide1==1'b0) begin  //bird1 position control
                    if(risetimec1>4'b1000 && birdrow1>19)  begin birdrow1=birdrow1-5;birdangle1=2'b01;end 
						  else 
						  if(risetimec1>4'b0011 && birdrow1>19)  begin birdrow1=birdrow1-4;birdangle1=2'b01;end 
						  else 
						  if(risetimec1>4'b0000 && birdrow1>19)  begin birdrow1=birdrow1-2;birdangle1=2'b01;end 
						  else 
						  if(risetimec1>4'b0000 && birdrow1<=19) begin birdrow1=19;birdangle1=2'b00;end
	                 else 
						  if(risetimec1==0&&falltimec1<20&& birdrow1<500)       begin birdrow1=birdrow1+falltimec1[6:4];birdangle1=2'b00;end 
						  else 
						  if(risetimec1==0&&falltimec1>19&& birdrow1<500)       begin birdrow1=birdrow1+falltimec1[6:4];birdangle1=2'b10;end
						  else  begin birdrow1=511;birdangle1=2'b00;end
                 end
		
 if(state==play&&collide2==1'b0) begin  //bird2 position control
                    if(risetimec2>4'b1000 && birdrow2>19)  begin birdrow2=birdrow2-5;birdangle2=2'b01;end 
						  else 
						  if(risetimec2>4'b0011 && birdrow2>19)  begin birdrow2=birdrow2-4;birdangle2=2'b01;end 
						  else 
						  if(risetimec2>4'b0000 && birdrow2>19)  begin birdrow2=birdrow2-2;birdangle2=2'b01;end 
						  else 
						  if(risetimec2>4'b0000 && birdrow2<=19) begin birdrow2=19;birdangle2=2'b00;end
	                 else 
						  if(risetimec2==0&&falltimec2<20&& birdrow2<500)       begin birdrow2=birdrow2+falltimec2[6:4];birdangle2=2'b00;end
                    else 
						  if(risetimec2==0&&falltimec2>19&& birdrow2<500)       begin birdrow2=birdrow2+falltimec2[6:4];birdangle2=2'b10;end						  
						  else  begin birdrow2=511;birdangle2=2'b00;end
						  
						  
                 end
					  
 if(state==play&&(collide1==0||collide2==0)) begin //obstacle
                   if(counter2==119) begin//time to generate new obstacle
                                        row[2]=row[1];column[2]=column[1];row[1]=row[0];column[1]=column[0];
													 column[0]=610;row[0]=randomR; counter2=counter2-1;//new barrier,the last sentance is important
	                                  end
						 else
                   if(counter2==0) begin counter2=120; end //timer reset
						 else begin 
						         counter2=counter2-1'b1;
									for(i=0;i<3;i=i+1) begin //obstacle move backwards
                                              if(column[i]>=25) column[i]=column[i]-2;else column[i]=0;
                                             end
									if(heightch==1) begin //obstacle change dimension
									                   if(height2>160) begin heightdir=0;height2=height2-2;end else
															 if(height2<130) begin heightdir=1;height2=height2+2;end else
															 height2=heightdir? height2+1:height2-1;
									                end
						        
							   end
                 end



 if(state==play) begin//score
                    for(i=1;i<3;i=i+1) begin 
						                       if(column[i]>birdcolumn2-25-16&&column[i]<birdcolumn2-25-13&&collide2==1'b0) score2=score2+1;else 
						                       if(column[i]==birdcolumn1-25-15&&collide1==1'b0) score1=score1+1;else
													  
													  begin score2=score2;score1=score1; end
													end
                 end

 
 if(state==play) begin //collide control 1
	                 if((column[0]>birdcolumn1-25-15)&&(column[0]<birdcolumn1+25+15)) 
						        begin 
								      if((birdrow1<row[0]+height/2-12)&&(birdrow1>row[0]-height/2+12)) collide1=collide1;
										else collide1=1'b1;
								  end 
						  else
                    if((column[1]>birdcolumn1-25-15)&&(column[1]<birdcolumn1+25+15)) 
						        begin 
								      if((birdrow1<row[1]+height/2-12)&&(birdrow1>row[1]-height/2+12)) collide1=collide1;
										else collide1=1'b1;
								  end 
						  else collide1=collide1;
						  
                 end
					  
 if(state==play&&mode==1'b1) begin //collide control 2
                     if((column[0]>birdcolumn2-25-15)&&(column[0]<birdcolumn2+25+15)) 
						        begin 
								      if((birdrow2<row[0]+height/2-12)&&(birdrow2>row[0]-height/2+12)) collide2=collide2;
										else collide2=1'b1;
								  end 
						  else
                    if((column[1]>birdcolumn2-25-15)&&(column[1]<birdcolumn2+25+15)) 
						        begin 
								      if((birdrow2<row[1]+height/2-12)&&(birdrow2>row[1]-height/2+12)) collide2=collide2;
										else collide2=1'b1;
								  end 
						  else collide2=collide2;
						  
                 end
					  
					  
//after collide
 if(state==play&&collide1==1'b1&&birdrow1<505&&collide2==1'b0) begin 
                                                                  if(column[1]>birdcolumn1+25+15-2&&column[1]<birdcolumn1+25+15+2)
																						   begin birdrow1=birdrow1+4;birdcolumn1=birdcolumn1-2;end else
																						if(column[1]<birdcolumn1-25-15||column[1]>birdcolumn1+25+15) birdrow1=birdrow1+4;
																																		 							  
																					end 
 if(state==play&&collide2==1'b1&&birdrow2<505&&collide1==1'b0) begin 
                                                                if(column[2]>birdcolumn2+25+15-2&&column[2]<birdcolumn2+25+15+2)
																					     begin birdrow2=birdrow2+4;birdcolumn2=birdcolumn2-2; end else
																				    if(column[2]<birdcolumn2-25-15||column[2]>birdcolumn2+25+15) birdrow2=birdrow2+4;
																					 end
 if(state==play&&collide1==1'b1&&collide2==1'b1) begin 
                                                 if(birdrow1<505) birdrow1=birdrow1+4;
																 if(birdrow2<505) birdrow2=birdrow2+4;
																end
 
end

endmodule



//////////////////////////////////////////////////////////////////
module Random(input clk,output reg [8:0] random);//random number generator
reg [6:0] counter=0;
reg [4:0] random1;
always@(posedge clk) begin
  counter=counter+1;
  case(counter[4:1])
    3'b000: random1=4'b1101^counter[5:2];
	 3'b001: random1=4'b1010^counter[5:2];
  	 3'b010: random1=4'b1111^counter[6:3];
	 3'b011: random1=4'b0111^counter[5:2];
	 3'b100: random1=4'b0110^counter[6:3];
	 3'b101: random1=4'b1101^counter[5:2];
	 3'b110: random1=4'b1110^counter[6:3];
	 default: random1=4'b1011^counter[5:2];
 endcase
 
  random=365-17*random1; //convert to coordinate 
end

endmodule
