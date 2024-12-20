// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.2 (win64) Build 2258646 Thu Jun 14 20:03:12 MDT 2018
// Date        : Sat Nov  2 14:11:37 2024
// Host        : DESKTOP-V0P3PJ5 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               C:/Users/yisoo/Desktop/2024/EE2026/Project/ABCDE_Rnd2.xpr/MODS/MODS.srcs/sources_1/ip/mult_gen/mult_gen_stub.v
// Design      : mult_gen
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a35tcpg236-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "mult_gen_v12_0_14,Vivado 2018.2" *)
module mult_gen(A, B, P)
/* synthesis syn_black_box black_box_pad_pin="A[4:0],B[4:0],P[9:0]" */;
  input [4:0]A;
  input [4:0]B;
  output [9:0]P;
endmodule
