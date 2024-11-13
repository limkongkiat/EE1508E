// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.2 (win64) Build 2258646 Thu Jun 14 20:03:12 MDT 2018
// Date        : Sat Nov  2 14:11:37 2024
// Host        : DESKTOP-V0P3PJ5 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               C:/Users/yisoo/Desktop/2024/EE2026/Project/ABCDE_Rnd2.xpr/MODS/MODS.srcs/sources_1/ip/mult_gen/mult_gen_sim_netlist.v
// Design      : mult_gen
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7a35tcpg236-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "mult_gen,mult_gen_v12_0_14,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "mult_gen_v12_0_14,Vivado 2018.2" *) 
(* NotValidForBitStream *)
module mult_gen
   (A,
    B,
    P);
  (* x_interface_info = "xilinx.com:signal:data:1.0 a_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME a_intf, LAYERED_METADATA undef" *) input [4:0]A;
  (* x_interface_info = "xilinx.com:signal:data:1.0 b_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME b_intf, LAYERED_METADATA undef" *) input [4:0]B;
  (* x_interface_info = "xilinx.com:signal:data:1.0 p_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME p_intf, LAYERED_METADATA undef" *) output [9:0]P;

  wire [4:0]A;
  wire [4:0]B;
  wire [9:0]P;
  wire [47:0]NLW_U0_PCASC_UNCONNECTED;
  wire [1:0]NLW_U0_ZERO_DETECT_UNCONNECTED;

  (* C_A_TYPE = "0" *) 
  (* C_A_WIDTH = "5" *) 
  (* C_B_TYPE = "0" *) 
  (* C_B_VALUE = "10000001" *) 
  (* C_B_WIDTH = "5" *) 
  (* C_CCM_IMP = "0" *) 
  (* C_CE_OVERRIDES_SCLR = "0" *) 
  (* C_HAS_CE = "0" *) 
  (* C_HAS_SCLR = "0" *) 
  (* C_HAS_ZERO_DETECT = "0" *) 
  (* C_LATENCY = "0" *) 
  (* C_MODEL_TYPE = "0" *) 
  (* C_MULT_TYPE = "1" *) 
  (* C_OPTIMIZE_GOAL = "0" *) 
  (* C_OUT_HIGH = "9" *) 
  (* C_OUT_LOW = "0" *) 
  (* C_ROUND_OUTPUT = "0" *) 
  (* C_ROUND_PT = "0" *) 
  (* C_VERBOSITY = "0" *) 
  (* C_XDEVICEFAMILY = "artix7" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  mult_gen_mult_gen_v12_0_14 U0
       (.A(A),
        .B(B),
        .CE(1'b1),
        .CLK(1'b1),
        .P(P),
        .PCASC(NLW_U0_PCASC_UNCONNECTED[47:0]),
        .SCLR(1'b0),
        .ZERO_DETECT(NLW_U0_ZERO_DETECT_UNCONNECTED[1:0]));
endmodule

(* C_A_TYPE = "0" *) (* C_A_WIDTH = "5" *) (* C_B_TYPE = "0" *) 
(* C_B_VALUE = "10000001" *) (* C_B_WIDTH = "5" *) (* C_CCM_IMP = "0" *) 
(* C_CE_OVERRIDES_SCLR = "0" *) (* C_HAS_CE = "0" *) (* C_HAS_SCLR = "0" *) 
(* C_HAS_ZERO_DETECT = "0" *) (* C_LATENCY = "0" *) (* C_MODEL_TYPE = "0" *) 
(* C_MULT_TYPE = "1" *) (* C_OPTIMIZE_GOAL = "0" *) (* C_OUT_HIGH = "9" *) 
(* C_OUT_LOW = "0" *) (* C_ROUND_OUTPUT = "0" *) (* C_ROUND_PT = "0" *) 
(* C_VERBOSITY = "0" *) (* C_XDEVICEFAMILY = "artix7" *) (* ORIG_REF_NAME = "mult_gen_v12_0_14" *) 
(* downgradeipidentifiedwarnings = "yes" *) 
module mult_gen_mult_gen_v12_0_14
   (CLK,
    A,
    B,
    CE,
    SCLR,
    ZERO_DETECT,
    P,
    PCASC);
  input CLK;
  input [4:0]A;
  input [4:0]B;
  input CE;
  input SCLR;
  output [1:0]ZERO_DETECT;
  output [9:0]P;
  output [47:0]PCASC;

  wire \<const0> ;
  wire [4:0]A;
  wire [4:0]B;
  wire [9:0]P;
  wire [47:0]NLW_i_mult_PCASC_UNCONNECTED;
  wire [1:0]NLW_i_mult_ZERO_DETECT_UNCONNECTED;

  assign PCASC[47] = \<const0> ;
  assign PCASC[46] = \<const0> ;
  assign PCASC[45] = \<const0> ;
  assign PCASC[44] = \<const0> ;
  assign PCASC[43] = \<const0> ;
  assign PCASC[42] = \<const0> ;
  assign PCASC[41] = \<const0> ;
  assign PCASC[40] = \<const0> ;
  assign PCASC[39] = \<const0> ;
  assign PCASC[38] = \<const0> ;
  assign PCASC[37] = \<const0> ;
  assign PCASC[36] = \<const0> ;
  assign PCASC[35] = \<const0> ;
  assign PCASC[34] = \<const0> ;
  assign PCASC[33] = \<const0> ;
  assign PCASC[32] = \<const0> ;
  assign PCASC[31] = \<const0> ;
  assign PCASC[30] = \<const0> ;
  assign PCASC[29] = \<const0> ;
  assign PCASC[28] = \<const0> ;
  assign PCASC[27] = \<const0> ;
  assign PCASC[26] = \<const0> ;
  assign PCASC[25] = \<const0> ;
  assign PCASC[24] = \<const0> ;
  assign PCASC[23] = \<const0> ;
  assign PCASC[22] = \<const0> ;
  assign PCASC[21] = \<const0> ;
  assign PCASC[20] = \<const0> ;
  assign PCASC[19] = \<const0> ;
  assign PCASC[18] = \<const0> ;
  assign PCASC[17] = \<const0> ;
  assign PCASC[16] = \<const0> ;
  assign PCASC[15] = \<const0> ;
  assign PCASC[14] = \<const0> ;
  assign PCASC[13] = \<const0> ;
  assign PCASC[12] = \<const0> ;
  assign PCASC[11] = \<const0> ;
  assign PCASC[10] = \<const0> ;
  assign PCASC[9] = \<const0> ;
  assign PCASC[8] = \<const0> ;
  assign PCASC[7] = \<const0> ;
  assign PCASC[6] = \<const0> ;
  assign PCASC[5] = \<const0> ;
  assign PCASC[4] = \<const0> ;
  assign PCASC[3] = \<const0> ;
  assign PCASC[2] = \<const0> ;
  assign PCASC[1] = \<const0> ;
  assign PCASC[0] = \<const0> ;
  assign ZERO_DETECT[1] = \<const0> ;
  assign ZERO_DETECT[0] = \<const0> ;
  GND GND
       (.G(\<const0> ));
  (* C_A_TYPE = "0" *) 
  (* C_A_WIDTH = "5" *) 
  (* C_B_TYPE = "0" *) 
  (* C_B_VALUE = "10000001" *) 
  (* C_B_WIDTH = "5" *) 
  (* C_CCM_IMP = "0" *) 
  (* C_CE_OVERRIDES_SCLR = "0" *) 
  (* C_HAS_CE = "0" *) 
  (* C_HAS_SCLR = "0" *) 
  (* C_HAS_ZERO_DETECT = "0" *) 
  (* C_LATENCY = "0" *) 
  (* C_MODEL_TYPE = "0" *) 
  (* C_MULT_TYPE = "1" *) 
  (* C_OPTIMIZE_GOAL = "0" *) 
  (* C_OUT_HIGH = "9" *) 
  (* C_OUT_LOW = "0" *) 
  (* C_ROUND_OUTPUT = "0" *) 
  (* C_ROUND_PT = "0" *) 
  (* C_VERBOSITY = "0" *) 
  (* C_XDEVICEFAMILY = "artix7" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  mult_gen_mult_gen_v12_0_14_viv i_mult
       (.A(A),
        .B(B),
        .CE(1'b0),
        .CLK(1'b0),
        .P(P),
        .PCASC(NLW_i_mult_PCASC_UNCONNECTED[47:0]),
        .SCLR(1'b0),
        .ZERO_DETECT(NLW_i_mult_ZERO_DETECT_UNCONNECTED[1:0]));
endmodule
`pragma protect begin_protected
`pragma protect version = 1
`pragma protect encrypt_agent = "XILINX"
`pragma protect encrypt_agent_info = "Xilinx Encryption Tool 2015"
`pragma protect key_keyowner="Cadence Design Systems.", key_keyname="cds_rsa_key", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=64)
`pragma protect key_block
Xy0rQtyFjlVkbWfeQXwuqraA3MiYyL0eFNjbY4iEa+s0Iy4tsgQeJeqb8F2nyNFI15QQro+xjbie
m+gt7LRqSA==

`pragma protect key_keyowner="Synopsys", key_keyname="SNPS-VCS-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
ket885wFwjDLqC97HI68cpTwpD1hGBIJdkMh+rsfw+vPf59MdHJNNbcLh5jkiDAOhjCAn8l7Pljd
OAdA4DPaB1th3EEcK28Uhm8xkCE8u1JeKM+cTawL1ZqM7f5vFJDMTdaQdo2ODraPwf63iOc4O7I1
Jp0iW8w4eq4dmJxUtLQ=

`pragma protect key_keyowner="Aldec", key_keyname="ALDEC15_001", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
0sLRbF/nd38eurlUzps5D+y+9REEleMhJud3+B55Wgm1hYo1ntzC4vdMFNHAcAq1l46fEiE/D85o
eYPC/WuBoZraAAbt+2vzvO+6NgUIpKKrii5bWkc7zSRBw4OUgkdgOToRQnup7uEq7pNL5gER2W2q
jpbl57Ks7667W7TbtoCx+55cY2wmHeQ+Fi9eAhxvopt9UQ7JhiAITU32QV0QOUo0C5DuMrCOfUPt
Q4mY/sCujPAsGwpHpQOH6JmVeTJ9/9FBANFdHkzv6F+8T8a1pEE2+YcJXysHrFHMtW27J1ZZCZGA
hChjmCakAGz4Jve6Njfz9RKNiLrrvv0gHwgvEw==

`pragma protect key_keyowner="ATRENTA", key_keyname="ATR-SG-2015-RSA-3", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
Z45gwqdZGpYP0Kv2lPvhL9t/dewTJD5ANS61F5BSLbdhMd8PVbRummT3J9CrH0Xrbuzjih6sOpQw
kP9SCPfkWk0LECt8HjobCatSEoRRONU79HyCEoDk93VT8CY8JL1BVS13wUngEWn6CIfitTyUUXR/
CxyxtdDZQFDUfHXEX4XQ0Yn12IXvHzgVAVLyG8UmGQWtQl4u7U/ZvMszHbCI4hHi6FW2kYvzBYlf
e14GZYOKCoOlqFp/3u2vs2rSSE9ciWV/SYIJDbOxsQCcBEM+UYYOzWikcZxKJAlJhndq92g1JKTL
sQcp7SBbbJ1O6Xynuz0MZ47Dfl+F87qkHSjwDQ==

`pragma protect key_keyowner="Xilinx", key_keyname="xilinxt_2017_05", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
AeZ3V4sxDArImz8Q4W0bdOLintyw5zFj71qsxS4fYZUiRz8fNjC87lJzQ+YnUM13/42C5tAz/W5B
5De7uFmIgyIiHZ7Y1Ljeaa49Hank9rJJwKCFDSSNL8oJL51I1jWnn7YQnA7UX2zo1TTkepqKq7HW
QLVQHxdIfz7XQJ1KYPLfGQXcsGEecPlraNmNXeykJAgtAFm5XnR8iyVOGbjm9W9BUx0070wOpVoK
DNLr58vy3yAgTwtSBr+RexJEsBPZIUDyrA9NgYHy91GC6l4e/tQMTkA5GUgHnQd/YiVINSR358nO
A3j+0MMXq+Hrg0TJtfXsqD7mdjD7gjs4pqa1Vw==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VELOCE-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
BTz6m4RfoEciTWA22aqSQ7leYhQBT580p+3gUMnEkDKrl8y/O8yBG9prYh9eaBfxpy/1/zsYPTfE
O0sD3klOHeyC81JjLy2AWCWL1sk9/7n5I9vvSHXaQP4PHYRjAzqZC2XENPD0SKyVkobaEQpad+o8
VjB8RI608B9GgMaZvYA=

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VERIF-SIM-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
D7Hbf96be8hL6h8aH9GXSy4IzBK9xG0ri9cVSVfA+REat+znGl+3rKoWJP3Y8xVsMkc1boG+wuph
DvXt9Y8VIRQAHNgamdZlVmWFc7YNNoioXwxsiPQUGQ033qF9EQryRyyXiVxfPqJOSfqv7PrbvgOT
5UDZUXtmOWGVrgoDlz45TFPs5v+lO6i3RYt0nujylzKTS8VLhLp7chpkjrCdjQc8hZGNDkUI5WPz
T16PgMtr8+aqlEn030MgQ09L5vJki+2qisAmejQVoQ30QbY0N/13XTb4LdaYF1u53Ib59hKf/1nP
//1d/wsq1f4QJoIkaVIa2ngZqWphjv4BhaOjtw==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-PREC-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
b13mvcHsz/k9H/2/VmiFvoDSEC4WagPNTxQCAAuQJN9t9d2mqnDRH/RXcoWy7THMQb2AIkxC1bOe
5F1b2VFd9T9UVleq060Nrhk36rQGz6C0f/a0sBGvk0/ZbfUvm58b0fPemMqB8Ltz5yPpUD+AN8uN
+pc1saOUZcaZ0bneibJ7mcenrtLgWBa+BxWbgCMu9PomqyFVmFXnRXGdzZ66nAoU696G4bIPOUva
JAqct8o45K9ErXjtR4R0+Mwnrpn/qwJo0mFgkigD9D0hgEl7Recchx3xQ1eXCU7c2cEHaGB8Jl/W
GHoLY4zFivhjNXMMy8JeevW19EInbEJjUx4wvA==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
kJfNkKPoR/0ou/NfMVGlm/KrKUc5+sNJAyPDZXetq/4eJooEFpA8Nju4WjEg1CgMJZes5JsRy6Fk
nWBjS1+N22gmsv86CH9akbzElF10EM+KdKVUl8Bwypw7BdSA+CLabs1WRwCdBxweDt8KC5is+phM
l1kGIrMf19SJd3UvB+xqX64ob+TEOg7Td0kX7NT6T9JjXzT14+ojlf4X0xMD3kYOH2ZbZt6guYBv
ELiOMXaAlR1EKtbF2Hg3wAYgM5NbfMPQxa2ZWvpBo8orbJLWaFZYHG5VPS40LdeyLY6+D7SCsTZv
GdQr8QTCkIUa8IuNPwU5ljdeJ4xJ0WjTIM4u9g==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 6896)
`pragma protect data_block
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
`pragma protect end_protected
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

endmodule
`endif
