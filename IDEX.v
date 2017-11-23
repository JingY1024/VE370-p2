`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:12:17 11/15/2017 
// Design Name: 
// Module Name:    IDEX 
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
module IDEX(clock, reset, flush, 
	regOut1ID, regOut2ID, InstructionID, PC4ID, InstructionExtID,
	RegDstID, RegWriteID, MemReadID, MemWriteID, MemtoRegID, ALUSrcID, ALUOpID,
	regOut1EX, regOut2EX, InstructionEX, InstructionExtEX,
	RegDstEX, RegWriteEX, MemReadEX, MemWriteEX, MemtoRegEX, ALUSrcEX, ALUOpEX
);

	input clock;
	input reset;
	input flush;
	input [31:0] regOut1ID;
	input [31:0] regOut2ID;
	input [31:0] InstructionID;
	input [31:0] PC4ID;
	input [31:0] InstructionExtID;
	//control signal
	
	input RegDstID;
	input RegWriteID;
	input MemReadID;
	input MemWriteID;
	input MemtoRegID;
	input ALUSrcID;
	input [2:0] ALUOpID;
	
	output reg [31:0] regOut1EX;
	output reg [31:0] regOut2EX;
	output reg [31:0] InstructionEX;
	output reg [31:0] InstructionExtEX;
	
	output reg RegDstEX;
	output reg RegWriteEX;
	output reg MemReadEX;
	output reg MemWriteEX;
	output reg MemtoRegEX;
	output reg ALUSrcEX;
	output reg [2:0] ALUOpEX;

	
	initial begin 
		regOut1EX <= 32'b0;
		regOut2EX <= 32'b0;
		InstructionEX <= 32'b0;
		InstructionExtEX <= 32'b0;
		RegDstEX <= 1'b0;
		RegWriteEX <= 1'b0;
		MemReadEX <= 1'b0;
		MemWriteEX <= 1'b0;
		MemtoRegEX <= 1'b0;
		ALUSrcEX <= 1'b0;
		ALUOpEX <= 3'b0;
		
	end
	
	always @(posedge clock) begin
		if (reset || flush) begin
			regOut1EX <= 32'b0;
			regOut2EX <= 32'b0;
			InstructionEX <= 32'b0;
			InstructionExtEX <= 32'b0;
			RegDstEX <= 1'b0;
			RegWriteEX <= 1'b0;
			MemReadEX <= 1'b0;
			MemWriteEX <= 1'b0;
			MemtoRegEX <= 1'b0;
			ALUSrcEX <= 1'b0;
			ALUOpEX <= 3'b0;
		end
		else begin
			regOut1EX <= regOut1ID;
			regOut2EX <= regOut2ID;
			InstructionEX <= InstructionID;
			InstructionExtEX <= InstructionExtID;
			RegDstEX <= RegDstID;
			RegWriteEX <= RegWriteID;
			MemReadEX <= MemReadID;
			MemWriteEX <= MemWriteID;
			MemtoRegEX <= MemtoRegID;
			ALUSrcEX <= ALUSrcID;
			ALUOpEX <= ALUOpID;
		end

	end
	
	
endmodule
