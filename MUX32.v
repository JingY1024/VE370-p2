`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:17:22 11/19/2017 
// Design Name: 
// Module Name:    MUX32 
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
module MUX32(in0, in1, sel, out);
	input [31:0]in0;
	input [31:0]in1;
	input sel;
	output [31:0]out;
	assign out=(sel)?in1:in0;
endmodule
