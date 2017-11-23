`timescale 1ns / 1ps
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
	
	MUX32_4x1 ForwardABranch(ReadData1ID,AddressMEM,WriteData,zero, forwardABranch, BranchCheck1);
	MUX32_4x1 ForwardBBranch(ReadData2ID, AddressMEM,WriteData, zero, forwardBBranch, BranchCheck2);
	
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
	


endmodule
