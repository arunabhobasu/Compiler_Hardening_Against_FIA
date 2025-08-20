`timescale 1ns / 1ps
module done_fanin ( rst, ld, done, clk );
  input rst, ld, clk;
  output  done;
  wire   N23, n1764, n1765, n1766, n1767, n1768, n1769, n1770, n1771, n1772,
         n1773, n1774, n1775, n4589, n4590, n9041, n9042, n9178, n9179, n9181,
         n9182, n9183, n9184, n9473, n9474, n9472, n9471, n9468, n9467, n9448, n9446, n9437;

  NAND2X0_RVT U4483 ( .A1(n9041), .A2(n9042), .Y(n4589) );
  NOR4X0_RVT U4481 ( .A1(n4589), .A2(n4590), .A3(n9179), .A4(n9446), .Y(N23) );
  DFFX2_RVT done_reg ( .D(N23), .CLK(clk), .Q(done) );
  OAI21X1_RVT U2018 ( .A1(n9179), .A2(n9178), .A3(n1771), .Y(n1769) );
  AO21X1_RVT U2017 ( .A1(n1768), .A2(n1769), .A3(n1770), .Y(n9182) );
  INVX0_RVT U2022 ( .A(n1772), .Y(n1770) );
  AO21X1_RVT U2021 ( .A1(n1768), .A2(n9179), .A3(n1770), .Y(n9184) );
  INVX1_RVT U9822 ( .A(n9473), .Y(n9471) );
  INVX2_RVT U9594 ( .A(n9471), .Y(n9448) );
  INVX1_RVT U9831 ( .A(n9448), .Y(n9468) );
  INVX0_RVT U2024 ( .A(n1766), .Y(n1768) );
  INVX1_RVT U9614 ( .A(n9468), .Y(n9467) );
  NAND3X0_RVT U2020 ( .A1(n1764), .A2(n1774), .A3(n1768), .Y(n1773) );
  NAND2X0_RVT U2023 ( .A1(rst), .A2(n9467), .Y(n1772) );
  NAND2X0_RVT U2019 ( .A1(n1772), .A2(n1773), .Y(n9183) );
  INVX1_RVT U10300 ( .A(ld), .Y(n9474) );
  INVX1_RVT U10281 ( .A(n9474), .Y(n9473) );
  INVX1_RVT U9821 ( .A(n9473), .Y(n9472) );
  DFFX1_RVT dcnt_reg_0_ ( .D(n9184), .CLK(clk), .QN(n9179) );
  DFFX1_RVT dcnt_reg_1_ ( .D(n9182), .CLK(clk), .Q(n4590), .QN(n9178) );
  INVX2_RVT U9593 ( .A(n9472), .Y(n9446) );
  DFFX1_RVT dcnt_reg_3_ ( .D(n9183), .CLK(clk), .Q(n1774), .QN(n9041) );
  NAND2X0_RVT U2030 ( .A1(n9178), .A2(n9179), .Y(n1771) );
  INVX0_RVT U10562 ( .A(n9446), .Y(n9437) );
  OR2X1_RVT U2027 ( .A1(n1774), .A2(n1764), .Y(n1775) );
  INVX0_RVT U2029 ( .A(n1771), .Y(n1767) );
  NAND3X0_RVT U2025 ( .A1(n1775), .A2(n9437), .A3(rst), .Y(n1766) );
  OR2X1_RVT U2016 ( .A1(n1767), .A2(n9042), .Y(n1765) );
  NAND2X0_RVT U2028 ( .A1(n9042), .A2(n1767), .Y(n1764) );
  AOI21X1_RVT U2015 ( .A1(n1764), .A2(n1765), .A3(n1766), .Y(n9181) );
  DFFX1_RVT dcnt_reg_2_ ( .D(n9181), .CLK(clk), .QN(n9042) );
endmodule

