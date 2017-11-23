`timescale 1ns / 1ps
`include "MUX32_4x1.v"
`include "PC.v"
`include "Add.v"
`include "InstructionMemory.v"
`include "IFID.v"
`include "registers.v"
`include "Sign-extend.v"
`include "Control.v"
`include "Branch.v"
`include "Shift32.v"
`include "Shift26.v"
`include "HazardDetect.v"
`include "BranchForward.v"
`include "IDEX.v"
`include "MUX32.v"
`include "ALUcontrol.v"
`include "ALU.v"
`include "MUX5.v"
`include "Forward.v"
`include "EXMEM.v"
`include "Data_memory.v"
`include "MEMWB.v"
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:    14:39:20 11/16/2017
// Design Name:
// Module Name:    main
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
module main(clk, reset,
		PC_out, rs0, rs1, rs2, rs3, rs4, rs5, rs6, rs7, rt0, rt1, rt2, rt3, rt4, rt5, rt6, rt7, rt8, rt9,
		InsPC, InsID, InsEX,
		ReadData1ID, ReadData1EX,
		ReadData2ID, ReadData2EX,
		RegDstID, RegWriteID, MemReadID, MemtoRegID, MemWriteID, ALUSrcID,
		ALUOpID,
		RegDstEX, RegWriteEX, MemReadEX, MemtoRegEX, MemWriteEX,
		ALUOpEX,
		RegWriteMEM, MemReadMEM, MemtoRegMEM, MemWriteMEM, ALUSrcMEM,
		ALUOpMEM,
		RegWriteWB, MemtoRegWB,
		ALUResult, WriteRegister, WriteData,
		ALUin1, ALUin2, ALUin2temp,
		forwardA, forwardB, forwardABranch, forwardBBranch,
		ResultWB, ReadDataWB,
		AddressMEM,
		AddressSelect
);

	input clk, reset;

	output [31:0] PC_out, rs0, rs1, rs2, rs3, rs4, rs5, rs6, rs7, rt0, rt1, rt2, rt3, rt4, rt5, rt6, rt7, rt8, rt9;
	output [31:0] InsPC, InsID, InsEX;
	output [31:0] ReadData1ID, ReadData1EX;
	output [31:0] ReadData2ID, ReadData2EX;

	output RegDstID, RegWriteID, MemReadID, MemtoRegID, MemWriteID, ALUSrcID;
	output [2:0] ALUOpID;
	output RegDstEX, RegWriteEX, MemReadEX, MemtoRegEX, MemWriteEX;
	output [2:0] ALUOpEX;
	output RegWriteMEM, MemReadMEM, MemtoRegMEM, MemWriteMEM, ALUSrcMEM;
	output [2:0] ALUOpMEM;
	output RegWriteWB, MemtoRegWB;

	wire [31:0] NextPCAdd, NextPCAddID;
	wire [31:0] BranchAddress, JumpAddress;
	output [1:0] AddressSelect;
	wire [31:0] add_inPC, add_outPC;

	wire [31:0] extInsID, extInsEX;

	wire [31:0] BranchAdd;
	wire [27:0] JumpAddTemp;
	output [4:0] WriteRegister;
	output [31:0] WriteData;
	wire ifJump;

	assign PC_out = add_outPC;


	output [31:0] ALUin1, ALUin2, ALUin2temp;
	output [1:0] forwardA, forwardB, forwardABranch, forwardBBranch;
	wire [3:0] ALUControl;
	output [31:0] ALUResult;
	wire [4:0] WriteRegEX, WriteRegMEM;
	wire IFID_flush, IFID_hold, IDEX_flush, PC_hold;

	output [31:0] AddressMEM;
	wire [31:0] WriteDataMEM;
	wire [31:0] ReadDataMEM;

	output [31:0] ReadDataWB;
	output [31:0] ResultWB;
	wire [31:0] BranchCheck1, BranchCheck2;



	parameter four = 4;
	parameter zero = 0;
	assign PC_out = add_outPC;

	// IF

	MUX32_4x1 MUXadd(NextPCAdd, BranchAddress, JumpAddress, zero, AddressSelect, add_inPC);

	PC pc(clk, add_inPC, PC_hold, add_outPC);
	Add add4(add_outPC, four, NextPCAdd);

	Instruction_memory insMemory(add_outPC, InsPC);

	// IF/ID
	IFID IFID(clk, reset, InsPC, NextPCAdd, InsID, NextPCAddID, IFID_hold, IFID_flush);

	// ID

	registers register(InsID[25:21], InsID[20:16], WriteRegister, WriteData, RegWriteWB, ReadData1ID, ReadData2ID,
		clk, rs0, rs1, rs2, rs3, rs4, rs5, rs6, rs7, rt0, rt1, rt2, rt3, rt4, rt5, rt6, rt7, rt8, rt9
	);
	SignExtend signext(InsID[15:0], extInsID);
	Control control(InsID[31:26], RegDstID, RegWriteID,
		MemReadID, MemtoRegID, MemWriteID, ALUSrcID, ALUOpID
	);
	assign ifJump = (InsID[31:26] == 6'b000010);
	wire ifBranch = (InsID[31:26] == 6'b000100 || (InsID[31:26] == 6'b000101));

	MUX32_4x1 ForwardABranch(ReadData1ID, zero, AddressMEM, zero, forwardABranch, BranchCheck1);
	MUX32_4x1 ForwardBBranch(ReadData2ID, zero ,AddressMEM, zero, forwardBBranch, BranchCheck2);

	Branch branchAndJump(BranchCheck1, BranchCheck2, InsID[31:26], ifJump, AddressSelect, IFID_flush);

	Shift32 ShiftBranchAdd(extInsID, BranchAdd);
	Shift26 ShiftJumpAdd(InsID[25:0], JumpAddTemp);
	Add BranchAddressResult(BranchAdd, NextPCAddID, BranchAddress);

	assign JumpAddress={NextPCAddID[31:28],JumpAddTemp};

	HazardDetect HazardDetect(ifBranch, MemReadEX, MemReadMEM, RegWriteEX,
		WriteRegEX, WriteRegMEM, InsID,
		PC_hold, IDEX_flush, IFID_hold
	);

	BranchForward BranchForward(RegWriteMEM, RegWriteWB,
		WriteRegMEM, WriteRegister, InsID[25:21], InsID[20:16], forwardABranch, forwardBBranch
	);

	// ID/EX
	IDEX IDEX(clk, reset, IDEX_flush,
		ReadData1ID, ReadData2ID, InsID, NextPCAddID, extInsID,
		RegDstID, RegWriteID, MemReadID, MemWriteID, MemtoRegID, ALUSrcID, ALUOpID,
		ReadData1EX, ReadData2EX, InsEX, extInsEX,
		RegDstEX, RegWriteEX, MemReadEX, MemWriteEX, MemtoRegEX, ALUSrcEX, ALUOpEX
	);

	// EX

	MUX32_4x1 ForwardA(ReadData1EX, AddressMEM, WriteData, zero, forwardA, ALUin1);
	MUX32_4x1 ForwardB(ReadData2EX, AddressMEM, WriteData, zero, forwardB, ALUin2temp);

	MUX32 selectALUinputB(ALUin2temp, extInsEX, ALUSrcEX, ALUin2);

	ALUcontrol ALUcontrol(InsEX[5:0], ALUOpEX, ALUControl);

	ALU ALU(ALUin1, ALUin2, ALUControl, ALUResult);

	MUX5 ChooseWriteReg(InsEX[20:16], InsEX[15:11], RegDstEX, WriteRegEX); // Rt or Rd

	Forward Forward(RegWriteMEM, RegWriteWB,
		WriteRegMEM, WriteRegister, InsEX[25:21], InsEX[20:16], forwardA, forwardB
	);

	// EX/MEM

	EXMEM EXMEM(clk, reset,
		ALUResult, ALUin2temp, WriteRegEX,
		RegWriteEX, MemReadEX, MemWriteEX, MemtoRegEX,
		AddressMEM, WriteDataMEM, WriteRegMEM,
		RegWriteMEM, MemReadMEM, MemWriteMEM, MemtoRegMEM
	);

	// MEM

	Data_memory DataMemory(clk, AddressMEM, WriteDataMEM, ReadDataMEM, MemWriteMEM, MemReadMEM);

	// MEM/WB

	MEMWB MEMWB(clk, reset,
		ReadDataMEM, AddressMEM, WriteRegMEM, RegWriteMEM, MemtoRegMEM,
		ReadDataWB, ResultWB, WriteRegister, RegWriteWB, MemtoRegWB
	);

	// WB

	MUX32 MUXresult(ResultWB, ReadDataWB, MemtoRegWB, WriteData);

	// on board

	divider_500 M1 (clock, Q1, reset, clock_1);

	ring_counter M3 (clock_1, Q5, reset);

	always @(*)
		A <= Q5;

	always @(A) begin
		if (test == 5'b00000) Q2 <= PC_out;
		else if (test == 5'b01000) Q2 <= rt0;
		else if (test == 5'b01001) Q2 <= rt1;
		else if (test == 5'b01010) Q2 <= rt2;
		else if (test == 5'b01011) Q2 <= rt3;
		else if (test == 5'b01100) Q2 <= rt4;
		else if (test == 5'b01101) Q2 <= rt5;
		else if (test == 5'b01110) Q2 <= rt6;
		else if (test == 5'b01111) Q2 <= rt7;
		else if (test == 5'b10000) Q2 <= rs0;
		else if (test == 5'b10001) Q2 <= rs1;
		else if (test == 5'b10010) Q2 <= rs2;
		else if (test == 5'b10011) Q2 <= rs3;
		else if (test == 5'b10100) Q2 <= rs4;
		else if (test == 5'b10101) Q2 <= rs5;
		else if (test == 5'b10110) Q2 <= rs6;
		else if (test == 5'b10111) Q2 <= rs7;
		else if (test == 5'b11000) Q2 <= rt8;
		else if (test == 5'b11001) Q2 <= rt9;
	end

	always @ (A) begin
		if (A == 4'b1110) Q <= Q2[3:0];
		else if (A == 4'b1101) Q <= Q2[7:4];
		else if (A == 4'b1011) Q <= Q2[11:8];
		else if (A == 4'b0111) Q <= Q2[15:12];
	end

	always @ (Q)
		  if (Q == 4'b0000) begin a<=0;b<=0;c<=0;d<=0;e<=0;f<=0;g<=1;  end
	else if (Q == 4'b0001) begin a<=1;b<=0;c<=0;d<=1;e<=1;f<=1;g<=1;  end
	else if (Q == 4'b0010) begin a<=0;b<=0;c<=1;d<=0;e<=0;f<=1;g<=0;  end
	else if (Q == 4'b0011) begin a<=0;b<=0;c<=0;d<=0;e<=1;f<=1;g<=0;  end
	else if (Q == 4'b0100) begin a<=1;b<=0;c<=0;d<=1;e<=1;f<=0;g<=0;  end
	else if (Q == 4'b0101) begin a<=0;b<=1;c<=0;d<=0;e<=1;f<=0;g<=0;  end
	else if (Q == 4'b0110) begin a<=0;b<=1;c<=0;d<=0;e<=0;f<=0;g<=0;  end
	else if (Q == 4'b0111) begin a<=0;b<=0;c<=0;d<=1;e<=1;f<=1;g<=1;  end
	else if (Q == 4'b1000) begin a<=0;b<=0;c<=0;d<=0;e<=0;f<=0;g<=0;  end
	else if (Q == 4'b1001) begin a<=0;b<=0;c<=0;d<=0;e<=1;f<=0;g<=0;  end
	else if (Q == 4'b1010) begin a<=0;b<=0;c<=0;d<=1;e<=0;f<=0;g<=0;  end
	else if (Q == 4'b1011) begin a<=1;b<=1;c<=0;d<=0;e<=0;f<=0;g<=0;  end
	else if (Q == 4'b1100) begin a<=0;b<=1;c<=1;d<=0;e<=0;f<=0;g<=1;  end
	else if (Q == 4'b1101) begin a<=1;b<=0;c<=0;d<=0;e<=0;f<=1;g<=0;  end
	else if (Q == 4'b1110) begin a<=0;b<=1;c<=1;d<=0;e<=0;f<=0;g<=0;  end
	else begin a<=0;b<=0;c<=0;d<=0;e<=1;f<=1;g<=1; end


endmodule

module divider_500(clock,Q,reset,clock_out);
	input clock, reset;
	output [25:0]Q;
	output clock_out;
	reg [25:0]Q;
	reg clock_out1;

	initial begin Q <= 0; end

	always @ (posedge reset or posedge clock)
		begin
			if (reset == 1'b1) Q <= 0;
			else if (Q == 99999) begin clock_out1 <= 1; Q <= 0; end
			else begin clock_out1 <= 0; Q <= Q + 1; end
		end
	assign clock_out = clock_out1;
endmodule


module ring_counter(clock, Q, reset);
	input clock, reset;
	output [3:0]Q;
	reg [3:0]Q;

	initial begin Q <= 4'b1110; end

	always @ (posedge reset or posedge clock)
		begin
			if (reset == 1'b1) Q <= 4'b1110;
			else if (Q == 4'b1110) Q <= 4'b0111;
			else if (Q == 4'b1101) Q <= 4'b1110;
			else if (Q == 4'b1011) Q <= 4'b1101;
			else if (Q == 4'b0111) Q <= 4'b1011;
			//else Q <= Q/2;
		end
endmodule

