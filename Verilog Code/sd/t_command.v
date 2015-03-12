`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   17:57:37 04/18/2014
// Design Name:   command
// Module Name:   X:/EC551/sd/t_command.v
// Project Name:  sd
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: command
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module t_command;

	// Inputs
	reg clk;

	// Outputs
	wire led1;
	wire clk_out;

	// Bidirs
	wire cmd;

	// Instantiate the Unit Under Test (UUT)
	command uut (
		.clk(clk), 
		.led1(led1), 
		.clk_out(clk_out), 
		.cmd(cmd)
	);

	initial begin
		// Initialize Inputs
		clk = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
	always 
	#1 clk=!clk;
      
endmodule

