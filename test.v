`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   20:21:10 03/23/2014
// Design Name:   Main
// Module Name:   D:/Study/BU/EC551/Project/Flappybirdmain/test.v
// Project Name:  Flappybirdmain
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Main
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test;

	// Inputs
	reg clk;
	reg pushin;
	reg began;
	reg paus;
	reg quit;
	reg [2:0] choice;

	// Outputs
	wire [2:0] state;
	wire [7:0] color;
	wire HS;
	wire VS;

	// Instantiate the Unit Under Test (UUT)
	Main uut (
		.clk(clk), 
		.pushin(pushin), 
		.began(began), 
		.paus(paus), 
		.quit(quit), 
		.choice(choice), 
		.state(state), 
		.color(color), 
		.HS(HS), 
		.VS(VS)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		pushin = 0;
		began = 0;
		paus = 0;
		quit = 0;
		choice = 0;
#10  began=1;
		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
	
   initial begin 
	clk=0;
	forever #2 clk=~clk;
end
  
endmodule

