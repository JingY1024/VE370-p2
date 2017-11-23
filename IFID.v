`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:57:16 11/15/2017 
// Design Name: 
// Module Name:    IFID 
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
module IFID(clk, reset, InstructionIF, PC4IF, InstructionID, PC4ID, hold, flush);

	input [31:0] InstructionIF;
	input	[31:0] PC4IF;
	input	clk, reset, flush, hold;
	output reg [31:0] InstructionID;
	output reg [31:0] PC4ID;
	
	//reg flag;

	initial begin
		InstructionID <= 32'b0;
		PC4ID <= 32'b0;
		//flag <= 1'b0;
	end

	always @(posedge clk) begin
		//if (hold) begin
		//	flag <= 1'b1;
		//end
		//else 
		if (reset || (flush && ~hold)) begin
			PC4ID <= 32'b0;
			InstructionID <= 32'b0;
			//flag <= 1'b0;
		end
		//else if (~hold && flag == 1'b1) begin
		//	PC4ID <= 32'b0;
		//	InstructionID <= 32'b0;
		//	flag <= 1'b0;
		//end
		else if (~hold) begin
			PC4ID <= PC4IF;
			InstructionID <= InstructionIF;
			//flag <= 1'b0;
		end
	end

endmodule
