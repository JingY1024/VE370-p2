`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:59:19 11/19/2017 
// Design Name: 
// Module Name:    HazardDetect 
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
module HazardDetect(ifBranch, MemReadEX, MemReadMEM, RegWriteEX, 
		WriteRegEX, WriteRegMEM, InsID, 
		PC_hold, IDEX_flush, IFID_hold 
);

	input ifBranch;
	input MemReadEX, MemReadMEM, RegWriteEX;
	input [4:0] WriteRegEX, WriteRegMEM;
	input [31:0] InsID;

	output reg PC_hold, IDEX_flush, IFID_hold;
	
	always @ * begin
		// load use detect
		if (MemReadEX && ( WriteRegEX == InsID[25:21] || WriteRegEX == InsID[20:16])) begin
			PC_hold = 1'b1;
			IDEX_flush = 1'b1;
			IFID_hold = 1'b1;
		end
		// control (not lw) detect
		else if (ifBranch && RegWriteEX && WriteRegEX != 0 && (WriteRegEX == InsID[25:21] || WriteRegEX == InsID[20:16]) && (InsID[31:26] == 6'b000100 || InsID[31:26] == 6'b000101)) begin
			PC_hold = 1'b1;
			IDEX_flush = 1'b1;
			IFID_hold = 1'b1;
		end
		// control (lw) for lw, ???, branch situation detect
		else if (ifBranch && MemReadMEM && (WriteRegMEM == InsID[25:21] || WriteRegMEM == InsID[20:16])) begin
			PC_hold = 1'b1;
			IDEX_flush = 1'b1;
			IFID_hold = 1'b1;
		end
		else begin
			PC_hold = 1'b0;
			IDEX_flush = 1'b0;
			IFID_hold = 1'b0;
		end
	end

endmodule
