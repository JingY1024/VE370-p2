`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:56:25 11/19/2017 
// Design Name: 
// Module Name:    MEMWB 
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
module MEMWB(clk, reset, 
		ReadDataMEM, ResultMEM, WriteRegMEM, RegWriteMEM, MemtoRegMEM, 
		ReadDataWB, ResultWB, WriteRegWB, RegWriteWB, MemtoRegWB
);

	input clk, reset;
	input [31:0] ReadDataMEM;
	input [31:0] ResultMEM;
	input [4:0] WriteRegMEM;
	input RegWriteMEM, MemtoRegMEM;
	
	output reg [31:0] ReadDataWB;
	output reg [31:0] ResultWB;
	output reg [4:0] WriteRegWB;
	output reg RegWriteWB, MemtoRegWB;

	initial begin 
		ReadDataWB <= 32'b0;
		ResultWB <= 32'b0;
		WriteRegWB <= 5'b0;
		RegWriteWB <= 1'b0;
		MemtoRegWB <=1'b0;
	end

	always @(posedge clk) begin
		if (reset) begin
			ReadDataWB <= 32'b0;
			ResultWB <= 32'b0;
			WriteRegWB <= 5'b0;
			RegWriteWB <= 1'b0;
			MemtoRegWB <=1'b0;
		end
		else begin
			ReadDataWB <= ReadDataMEM;
			ResultWB <= ResultMEM;
			WriteRegWB <= WriteRegMEM;
			RegWriteWB <= RegWriteMEM;
			MemtoRegWB <= MemtoRegMEM;
		end
	end

endmodule
