`timescale 1ns / 1ps
`include "main.v"
////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:   11:05:39 11/21/2017
// Design Name:   main
// Module Name:   C:/Users/Setsuna/Documents/XilinxWork/pipeline/testPipeline.v
// Project Name:  pipeline
// Target Device:
// Tool versions:
// Description:
//
// Verilog Test Fixture created by ISE for module: main
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
////////////////////////////////////////////////////////////////////////////////

module testPipeline;

	// Inputs
	//reg [31:0] t;
	reg clk;
	reg reset;
	reg [31:0] t;
	// Outputs
	wire [31:0] PC_out;
	wire [31:0] rs0;
	wire [31:0] rs1;
	wire [31:0] rs2;
	wire [31:0] rs3;
	wire [31:0] rs4;
	wire [31:0] rs5;
	wire [31:0] rs6;
	wire [31:0] rs7;
	wire [31:0] rt0;
	wire [31:0] rt1;
	wire [31:0] rt2;
	wire [31:0] rt3;
	wire [31:0] rt4;
	wire [31:0] rt5;
	wire [31:0] rt6;
	wire [31:0] rt7;
	wire [31:0] rt8;
	wire [31:0] rt9;
	wire [31:0] InsPC;
	wire [31:0] InsID;
	wire [31:0] InsEX;
	wire [31:0] ReadData1ID;
	wire [31:0] ReadData1EX;
	wire [31:0] ReadData2ID;
	wire [31:0] ReadData2EX;
	wire RegDstID;
	wire RegWriteID;
	wire MemReadID;
	wire MemtoRegID;
	wire MemWriteID;
	wire ALUSrcID;
	wire [2:0] ALUOpID;
	wire RegDstEX;
	wire RegWriteEX;
	wire MemReadEX;
	wire MemtoRegEX;
	wire MemWriteEX;
	wire [2:0] ALUOpEX;
	wire RegWriteMEM;
	wire MemReadMEM;
	wire MemtoRegMEM;
	wire MemWriteMEM;
	wire ALUSrcMEM;
	wire [2:0] ALUOpMEM;
	wire RegWriteWB;
	wire MemtoRegWB;
	wire [31:0] ALUResult;
	wire [4:0] WriteRegister;
	wire [31:0] WriteData;
	wire [31:0] ALUin1;
	wire [31:0] ALUin2;
	wire [31:0] ALUin2temp;
	wire [1:0] forwardA;
	wire [1:0] forwardB;
	wire [1:0] forwardABranch;
	wire [1:0] forwardBBranch;
	wire [31:0] ReadDataWB;
	wire [31:0] ResultWB;
	wire [31:0] AddressMEM;
	wire [1:0] AddressSelect;
	// Instantiate the Unit Under Test (UUT)
	main uut (
		.clk(clk),
		.reset(reset),
		.PC_out(PC_out),
		.rs0(rs0),
		.rs1(rs1),
		.rs2(rs2),
		.rs3(rs3),
		.rs4(rs4),
		.rs5(rs5),
		.rs6(rs6),
		.rs7(rs7),
		.rt0(rt0),
		.rt1(rt1),
		.rt2(rt2),
		.rt3(rt3),
		.rt4(rt4),
		.rt5(rt5),
		.rt6(rt6),
		.rt7(rt7),
		.rt8(rt8),
		.rt9(rt9),
		.InsPC(InsPC),
		.InsID(InsID),
		.InsEX(InsEX),
		.ReadData1ID(ReadData1ID),
		.ReadData1EX(ReadData1EX),
		.ReadData2ID(ReadData2ID),
		.ReadData2EX(ReadData2EX),
		.RegDstID(RegDstID),
		.RegWriteID(RegWriteID),
		.MemReadID(MemReadID),
		.MemtoRegID(MemtoRegID),
		.MemWriteID(MemWriteID),
		.ALUSrcID(ALUSrcID),
		.ALUOpID(ALUOpID),
		.RegDstEX(RegDstEX),
		.RegWriteEX(RegWriteEX),
		.MemReadEX(MemReadEX),
		.MemtoRegEX(MemtoRegEX),
		.MemWriteEX(MemWriteEX),
		.ALUOpEX(ALUOpEX),
		.RegWriteMEM(RegWriteMEM),
		.MemReadMEM(MemReadMEM),
		.MemtoRegMEM(MemtoRegMEM),
		.MemWriteMEM(MemWriteMEM),
		.ALUSrcMEM(ALUSrcMEM),
		.ALUOpMEM(ALUOpMEM),
		.RegWriteWB(RegWriteWB),
		.MemtoRegWB(MemtoRegWB),
		.ALUResult(ALUResult),
		.WriteRegister(WriteRegister),
		.WriteData(WriteData),
		.ALUin1(ALUin1),
		.ALUin2(ALUin2),
		.ALUin2temp(ALUin2temp),
		.forwardA(forwardA),
		.forwardB(forwardB),
		.forwardABranch(forwardABranch),
		.forwardBBranch(forwardBBranch),
		.ReadDataWB(ReadDataWB),
		.ResultWB(ResultWB),
		.AddressMEM(AddressMEM),
		.AddressSelect(AddressSelect)
	);

	initial begin
		$display("---------------------------------------------------------------");
		$display("              Pipeline MIPS AProcessor Simulation              ");
		$display("---------------------------------------------------------------");
	end
	always begin
		#10 clk = ~clk;
		if (~clk) begin
		$display("Time: %d, clock = %d, PC = %h", t, clk, PC_out);
		$display("InsPC: %h, InsID = %h, InsEX = %h, ALUResult = %h", InsPC, InsID, InsEX, ALUResult);
		$display("ALUin1: %h, ALUin2 = %h,ALUop = %b", ALUin1, ALUin2,ALUOpID);
		$display("forwardA: %h, forwardB = %h", forwardA, forwardB);
		$display("RegWriteID: %d, RegWriteex: %d, RegWriteMEM: %d,RegWriteWB: %d", RegWriteID, RegWriteEX, RegWriteMEM, RegWriteWB);
		$display("WriteRegister: %h, WriteData: %h", WriteRegister, WriteData);
		$display("ReadDataWB=%h,ResultWB=%h",ReadDataWB,ResultWB);
		$display("AddressMEM=%h",AddressMEM);
		$display("AddressSelect=%b",AddressSelect);
		$display("[$s0] = %h, [$s1] = %h, [$s2] = %h", rs0,rs1,rs2);
		$display("[$s3] = %h, [$s4] = %h, [$s5] = %h", rs3,rs4,rs5);
		$display("[$s6] = %h, [$s7] = %h, [$t0] = %h", rs6,rs7,rt0);
		$display("[$t1] = %h, [$t2] = %h, [$t3] = %h", rt1,rt2,rt3);
		$display("[$t4] = %h, [$t5] = %h, [$t6] = %h", rt4,rt5,rt6);
		$display("[$t7] = %h, [$t8] = %h, [$t9] = %h", rt7,rt8,rt9);
		//$display("Branch=%h",test);
		end
	end
	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 0;
		t = 0;
		// Add stimulus here
		#3000 $stop;
	end
   always begin
		#20 t = t+1;
	end

	initial begin
	  $dumpfile("test.vcd");
    $dumpvars(1, uut);
  end

endmodule
