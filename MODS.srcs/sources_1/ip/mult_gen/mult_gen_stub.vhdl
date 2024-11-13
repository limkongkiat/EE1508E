-- Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2018.2 (win64) Build 2258646 Thu Jun 14 20:03:12 MDT 2018
-- Date        : Sat Nov  2 14:11:37 2024
-- Host        : DESKTOP-V0P3PJ5 running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub
--               C:/Users/yisoo/Desktop/2024/EE2026/Project/ABCDE_Rnd2.xpr/MODS/MODS.srcs/sources_1/ip/mult_gen/mult_gen_stub.vhdl
-- Design      : mult_gen
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7a35tcpg236-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mult_gen is
  Port ( 
    A : in STD_LOGIC_VECTOR ( 4 downto 0 );
    B : in STD_LOGIC_VECTOR ( 4 downto 0 );
    P : out STD_LOGIC_VECTOR ( 9 downto 0 )
  );

end mult_gen;

architecture stub of mult_gen is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "A[4:0],B[4:0],P[9:0]";
attribute x_core_info : string;
attribute x_core_info of stub : architecture is "mult_gen_v12_0_14,Vivado 2018.2";
begin
end;
