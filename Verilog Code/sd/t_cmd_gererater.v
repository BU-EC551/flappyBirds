`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   20:53:27 04/17/2014
// Design Name:   cmd_generater
// Module Name:   X:/EC551/sd/t_cmd_gererater.v
// Project Name:  sd
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: cmd_generater
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module t_cmd_gererater;

	// Inputs
	reg clk;
	reg state;

	// Outputs
	wire pin_out;

	// Instantiate the Unit Under Test (UUT)
	cmd_generater uut (
		.clk(clk), 
		.state(state), 
		.pin_out(pin_out)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		state = 1;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
	always
	#1 clk=!clk;
      
endmodule

