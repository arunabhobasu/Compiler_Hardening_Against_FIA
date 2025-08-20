/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : Q-2019.12-SP4
// Date      : Wed Jul 29 11:10:07 2020
/////////////////////////////////////////////////////////////

`timescale 1ns/1ps
module RSA_binary_v2 ( clk, start, finished );
  input clk, start;
  output finished;
  wire   n4, n5, n6, n7, n8, n9, n10, n11, n12, n14, n15, n16, n18, n19, n20,
         n21, n22, n23, n24, n25, n26, n27, n28, n29, n30, n31, n32, n33, n34;
  wire   [2:0] FSM;
  wire   [3:0] round_index;

  DFFSSRX1_RVT FSM_reg_0_ ( .D(n12), .SETB(n19), .RSTB(1'b1), .CLK(clk), .Q(
        FSM[0]), .QN(n6) );
  DFFSSRX1_RVT FSM_reg_2_ ( .D(n34), .SETB(n14), .RSTB(start), .CLK(clk), .Q(
        FSM[2]), .QN(n4) );
  DFFSSRX1_RVT FSM_reg_1_ ( .D(n33), .SETB(n18), .RSTB(start), .CLK(clk), .Q(
        FSM[1]), .QN(n5) );
  NAND3X0_RVT U8 ( .A1(FSM[0]), .A2(n4), .A3(FSM[1]), .Y(n14) );
  AO21X1_RVT U10 ( .A1(n16), .A2(n6), .A3(n5), .Y(n15) );
  NAND3X0_RVT U11 ( .A1(n6), .A2(n4), .A3(FSM[1]), .Y(n18) );
  AO21X1_RVT U13 ( .A1(n7), .A2(n20), .A3(FSM[0]), .Y(n19) );
  NAND4X0_RVT U14 ( .A1(round_index[1]), .A2(n11), .A3(n9), .A4(n8), .Y(n16)
         );
  AO22X1_RVT U15 ( .A1(round_index[2]), .A2(n21), .A3(n22), .A4(n23), .Y(n29)
         );
  AND2X1_RVT U16 ( .A1(round_index[1]), .A2(n9), .Y(n22) );
  AO22X1_RVT U17 ( .A1(round_index[1]), .A2(n24), .A3(n23), .A4(n10), .Y(n30)
         );
  AO21X1_RVT U18 ( .A1(round_index[3]), .A2(n25), .A3(n26), .Y(n31) );
  AND4X1_RVT U19 ( .A1(round_index[2]), .A2(n23), .A3(round_index[1]), .A4(n8), 
        .Y(n26) );
  AND2X1_RVT U20 ( .A1(round_index[0]), .A2(n27), .Y(n23) );
  AO21X1_RVT U21 ( .A1(n27), .A2(n9), .A3(n21), .Y(n25) );
  AO21X1_RVT U22 ( .A1(n27), .A2(n10), .A3(n24), .Y(n21) );
  AO21X1_RVT U23 ( .A1(n27), .A2(n11), .A3(n28), .Y(n24) );
  AO22X1_RVT U24 ( .A1(n28), .A2(round_index[0]), .A3(n27), .A4(n11), .Y(n32)
         );
  AND2X1_RVT U25 ( .A1(n20), .A2(n6), .Y(n27) );
  AND2X1_RVT U26 ( .A1(FSM[2]), .A2(FSM[1]), .Y(n20) );
  AND2X1_RVT U27 ( .A1(FSM[2]), .A2(FSM[0]), .Y(n28) );
  AND3X1_RVT U28 ( .A1(n5), .A2(n4), .A3(n6), .Y(finished) );
  DFFX1_RVT round_index_reg_1_ ( .D(n30), .CLK(clk), .Q(round_index[1]), .QN(
        n10) );
  DFFX1_RVT round_index_reg_3_ ( .D(n31), .CLK(clk), .Q(round_index[3]), .QN(
        n8) );
  DFFX1_RVT round_index_reg_2_ ( .D(n29), .CLK(clk), .Q(round_index[2]), .QN(
        n9) );
  DFFX1_RVT round_index_reg_0_ ( .D(n32), .CLK(clk), .Q(round_index[0]), .QN(
        n11) );
  AND2X1_RVT U29 ( .A1(FSM[0]), .A2(n5), .Y(n33) );
  AND2X1_RVT U30 ( .A1(FSM[2]), .A2(n15), .Y(n34) );
  INVX1_RVT U31 ( .A(n16), .Y(n7) );
  INVX1_RVT U32 ( .A(start), .Y(n12) );
endmodule

