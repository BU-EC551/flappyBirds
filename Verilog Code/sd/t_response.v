`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   14:15:37 04/18/2014
// Design Name:   response
// Module Name:   X:/EC551/sd/t_response.v
// Project Name:  sd
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: response
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module t_response;

	// Inputs
	reg flag;
	reg response;
	reg clk;

	// Outputs
	wire receive_state;

	// Instantiate the Unit Under Test (UUT)
	response uut (
		.flag(flag), 
		.response(response), 
		.clk(clk), 
		.receive_state(receive_state)
	);

	initial begin
		// Initialize Inputs
		flag = 1;
		response = 0;
		clk = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
	always
	#1 clk=!clk;
      
endmodule

