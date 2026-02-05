/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : S-2021.06-SP2
// Date      : Thu Feb  5 12:46:39 2026
/////////////////////////////////////////////////////////////


module FSM ( clk, reset, isstring, ispattern, match_enable, rst_read_count );
  input clk, reset, isstring, ispattern;
  output match_enable, rst_read_count;
  wire   \next_state[0] , N30, n4, n6, n7, n8, n9, n2, n3, n5;
  wire   [2:0] cur_state;
  assign match_enable = N30;

  DFFRX1 \cur_state_reg[1]  ( .D(n2), .CK(clk), .RN(n3), .Q(cur_state[1]), 
        .QN(n4) );
  DFFRX1 \cur_state_reg[0]  ( .D(\next_state[0] ), .CK(clk), .RN(n3), .Q(
        cur_state[0]) );
  NOR2BX2 U3 ( .AN(cur_state[0]), .B(n4), .Y(N30) );
  CLKINVX1 U4 ( .A(n6), .Y(n2) );
  AOI32X1 U5 ( .A0(cur_state[0]), .A1(n4), .A2(ispattern), .B0(cur_state[1]), 
        .B1(n7), .Y(n6) );
  NAND2X1 U6 ( .A(isstring), .B(cur_state[0]), .Y(n7) );
  OAI22XL U7 ( .A0(n8), .A1(n5), .B0(ispattern), .B1(n9), .Y(\next_state[0] )
         );
  NOR2X1 U8 ( .A(n8), .B(N30), .Y(n9) );
  CLKINVX1 U9 ( .A(isstring), .Y(n5) );
  XOR2X1 U10 ( .A(cur_state[0]), .B(cur_state[1]), .Y(n8) );
  CLKINVX1 U11 ( .A(reset), .Y(n3) );
  CLKBUFX3 U12 ( .A(N30), .Y(rst_read_count) );
endmodule


module read_chardata ( clk, reset, isstring, ispattern, chardata, 
        rst_read_count, .string_buffer({\string_buffer[0][7] , 
        \string_buffer[0][6] , \string_buffer[0][5] , \string_buffer[0][4] , 
        \string_buffer[0][3] , \string_buffer[0][2] , \string_buffer[0][1] , 
        \string_buffer[0][0] , \string_buffer[1][7] , \string_buffer[1][6] , 
        \string_buffer[1][5] , \string_buffer[1][4] , \string_buffer[1][3] , 
        \string_buffer[1][2] , \string_buffer[1][1] , \string_buffer[1][0] , 
        \string_buffer[2][7] , \string_buffer[2][6] , \string_buffer[2][5] , 
        \string_buffer[2][4] , \string_buffer[2][3] , \string_buffer[2][2] , 
        \string_buffer[2][1] , \string_buffer[2][0] , \string_buffer[3][7] , 
        \string_buffer[3][6] , \string_buffer[3][5] , \string_buffer[3][4] , 
        \string_buffer[3][3] , \string_buffer[3][2] , \string_buffer[3][1] , 
        \string_buffer[3][0] , \string_buffer[4][7] , \string_buffer[4][6] , 
        \string_buffer[4][5] , \string_buffer[4][4] , \string_buffer[4][3] , 
        \string_buffer[4][2] , \string_buffer[4][1] , \string_buffer[4][0] , 
        \string_buffer[5][7] , \string_buffer[5][6] , \string_buffer[5][5] , 
        \string_buffer[5][4] , \string_buffer[5][3] , \string_buffer[5][2] , 
        \string_buffer[5][1] , \string_buffer[5][0] , \string_buffer[6][7] , 
        \string_buffer[6][6] , \string_buffer[6][5] , \string_buffer[6][4] , 
        \string_buffer[6][3] , \string_buffer[6][2] , \string_buffer[6][1] , 
        \string_buffer[6][0] , \string_buffer[7][7] , \string_buffer[7][6] , 
        \string_buffer[7][5] , \string_buffer[7][4] , \string_buffer[7][3] , 
        \string_buffer[7][2] , \string_buffer[7][1] , \string_buffer[7][0] , 
        \string_buffer[8][7] , \string_buffer[8][6] , \string_buffer[8][5] , 
        \string_buffer[8][4] , \string_buffer[8][3] , \string_buffer[8][2] , 
        \string_buffer[8][1] , \string_buffer[8][0] , \string_buffer[9][7] , 
        \string_buffer[9][6] , \string_buffer[9][5] , \string_buffer[9][4] , 
        \string_buffer[9][3] , \string_buffer[9][2] , \string_buffer[9][1] , 
        \string_buffer[9][0] , \string_buffer[10][7] , \string_buffer[10][6] , 
        \string_buffer[10][5] , \string_buffer[10][4] , \string_buffer[10][3] , 
        \string_buffer[10][2] , \string_buffer[10][1] , \string_buffer[10][0] , 
        \string_buffer[11][7] , \string_buffer[11][6] , \string_buffer[11][5] , 
        \string_buffer[11][4] , \string_buffer[11][3] , \string_buffer[11][2] , 
        \string_buffer[11][1] , \string_buffer[11][0] , \string_buffer[12][7] , 
        \string_buffer[12][6] , \string_buffer[12][5] , \string_buffer[12][4] , 
        \string_buffer[12][3] , \string_buffer[12][2] , \string_buffer[12][1] , 
        \string_buffer[12][0] , \string_buffer[13][7] , \string_buffer[13][6] , 
        \string_buffer[13][5] , \string_buffer[13][4] , \string_buffer[13][3] , 
        \string_buffer[13][2] , \string_buffer[13][1] , \string_buffer[13][0] , 
        \string_buffer[14][7] , \string_buffer[14][6] , \string_buffer[14][5] , 
        \string_buffer[14][4] , \string_buffer[14][3] , \string_buffer[14][2] , 
        \string_buffer[14][1] , \string_buffer[14][0] , \string_buffer[15][7] , 
        \string_buffer[15][6] , \string_buffer[15][5] , \string_buffer[15][4] , 
        \string_buffer[15][3] , \string_buffer[15][2] , \string_buffer[15][1] , 
        \string_buffer[15][0] , \string_buffer[16][7] , \string_buffer[16][6] , 
        \string_buffer[16][5] , \string_buffer[16][4] , \string_buffer[16][3] , 
        \string_buffer[16][2] , \string_buffer[16][1] , \string_buffer[16][0] , 
        \string_buffer[17][7] , \string_buffer[17][6] , \string_buffer[17][5] , 
        \string_buffer[17][4] , \string_buffer[17][3] , \string_buffer[17][2] , 
        \string_buffer[17][1] , \string_buffer[17][0] , \string_buffer[18][7] , 
        \string_buffer[18][6] , \string_buffer[18][5] , \string_buffer[18][4] , 
        \string_buffer[18][3] , \string_buffer[18][2] , \string_buffer[18][1] , 
        \string_buffer[18][0] , \string_buffer[19][7] , \string_buffer[19][6] , 
        \string_buffer[19][5] , \string_buffer[19][4] , \string_buffer[19][3] , 
        \string_buffer[19][2] , \string_buffer[19][1] , \string_buffer[19][0] , 
        \string_buffer[20][7] , \string_buffer[20][6] , \string_buffer[20][5] , 
        \string_buffer[20][4] , \string_buffer[20][3] , \string_buffer[20][2] , 
        \string_buffer[20][1] , \string_buffer[20][0] , \string_buffer[21][7] , 
        \string_buffer[21][6] , \string_buffer[21][5] , \string_buffer[21][4] , 
        \string_buffer[21][3] , \string_buffer[21][2] , \string_buffer[21][1] , 
        \string_buffer[21][0] , \string_buffer[22][7] , \string_buffer[22][6] , 
        \string_buffer[22][5] , \string_buffer[22][4] , \string_buffer[22][3] , 
        \string_buffer[22][2] , \string_buffer[22][1] , \string_buffer[22][0] , 
        \string_buffer[23][7] , \string_buffer[23][6] , \string_buffer[23][5] , 
        \string_buffer[23][4] , \string_buffer[23][3] , \string_buffer[23][2] , 
        \string_buffer[23][1] , \string_buffer[23][0] , \string_buffer[24][7] , 
        \string_buffer[24][6] , \string_buffer[24][5] , \string_buffer[24][4] , 
        \string_buffer[24][3] , \string_buffer[24][2] , \string_buffer[24][1] , 
        \string_buffer[24][0] , \string_buffer[25][7] , \string_buffer[25][6] , 
        \string_buffer[25][5] , \string_buffer[25][4] , \string_buffer[25][3] , 
        \string_buffer[25][2] , \string_buffer[25][1] , \string_buffer[25][0] , 
        \string_buffer[26][7] , \string_buffer[26][6] , \string_buffer[26][5] , 
        \string_buffer[26][4] , \string_buffer[26][3] , \string_buffer[26][2] , 
        \string_buffer[26][1] , \string_buffer[26][0] , \string_buffer[27][7] , 
        \string_buffer[27][6] , \string_buffer[27][5] , \string_buffer[27][4] , 
        \string_buffer[27][3] , \string_buffer[27][2] , \string_buffer[27][1] , 
        \string_buffer[27][0] , \string_buffer[28][7] , \string_buffer[28][6] , 
        \string_buffer[28][5] , \string_buffer[28][4] , \string_buffer[28][3] , 
        \string_buffer[28][2] , \string_buffer[28][1] , \string_buffer[28][0] , 
        \string_buffer[29][7] , \string_buffer[29][6] , \string_buffer[29][5] , 
        \string_buffer[29][4] , \string_buffer[29][3] , \string_buffer[29][2] , 
        \string_buffer[29][1] , \string_buffer[29][0] , \string_buffer[30][7] , 
        \string_buffer[30][6] , \string_buffer[30][5] , \string_buffer[30][4] , 
        \string_buffer[30][3] , \string_buffer[30][2] , \string_buffer[30][1] , 
        \string_buffer[30][0] , \string_buffer[31][7] , \string_buffer[31][6] , 
        \string_buffer[31][5] , \string_buffer[31][4] , \string_buffer[31][3] , 
        \string_buffer[31][2] , \string_buffer[31][1] , \string_buffer[31][0] 
        }), .pattern_buffer({\pattern_buffer[0][7] , \pattern_buffer[0][6] , 
        \pattern_buffer[0][5] , \pattern_buffer[0][4] , \pattern_buffer[0][3] , 
        \pattern_buffer[0][2] , \pattern_buffer[0][1] , \pattern_buffer[0][0] , 
        \pattern_buffer[1][7] , \pattern_buffer[1][6] , \pattern_buffer[1][5] , 
        \pattern_buffer[1][4] , \pattern_buffer[1][3] , \pattern_buffer[1][2] , 
        \pattern_buffer[1][1] , \pattern_buffer[1][0] , \pattern_buffer[2][7] , 
        \pattern_buffer[2][6] , \pattern_buffer[2][5] , \pattern_buffer[2][4] , 
        \pattern_buffer[2][3] , \pattern_buffer[2][2] , \pattern_buffer[2][1] , 
        \pattern_buffer[2][0] , \pattern_buffer[3][7] , \pattern_buffer[3][6] , 
        \pattern_buffer[3][5] , \pattern_buffer[3][4] , \pattern_buffer[3][3] , 
        \pattern_buffer[3][2] , \pattern_buffer[3][1] , \pattern_buffer[3][0] , 
        \pattern_buffer[4][7] , \pattern_buffer[4][6] , \pattern_buffer[4][5] , 
        \pattern_buffer[4][4] , \pattern_buffer[4][3] , \pattern_buffer[4][2] , 
        \pattern_buffer[4][1] , \pattern_buffer[4][0] , \pattern_buffer[5][7] , 
        \pattern_buffer[5][6] , \pattern_buffer[5][5] , \pattern_buffer[5][4] , 
        \pattern_buffer[5][3] , \pattern_buffer[5][2] , \pattern_buffer[5][1] , 
        \pattern_buffer[5][0] , \pattern_buffer[6][7] , \pattern_buffer[6][6] , 
        \pattern_buffer[6][5] , \pattern_buffer[6][4] , \pattern_buffer[6][3] , 
        \pattern_buffer[6][2] , \pattern_buffer[6][1] , \pattern_buffer[6][0] , 
        \pattern_buffer[7][7] , \pattern_buffer[7][6] , \pattern_buffer[7][5] , 
        \pattern_buffer[7][4] , \pattern_buffer[7][3] , \pattern_buffer[7][2] , 
        \pattern_buffer[7][1] , \pattern_buffer[7][0] }), read_string_count, 
        read_pattern_count );
  input [7:0] chardata;
  output [4:0] read_string_count;
  output [2:0] read_pattern_count;
  input clk, reset, isstring, ispattern, rst_read_count;
  output \string_buffer[0][7] , \string_buffer[0][6] , \string_buffer[0][5] ,
         \string_buffer[0][4] , \string_buffer[0][3] , \string_buffer[0][2] ,
         \string_buffer[0][1] , \string_buffer[0][0] , \string_buffer[1][7] ,
         \string_buffer[1][6] , \string_buffer[1][5] , \string_buffer[1][4] ,
         \string_buffer[1][3] , \string_buffer[1][2] , \string_buffer[1][1] ,
         \string_buffer[1][0] , \string_buffer[2][7] , \string_buffer[2][6] ,
         \string_buffer[2][5] , \string_buffer[2][4] , \string_buffer[2][3] ,
         \string_buffer[2][2] , \string_buffer[2][1] , \string_buffer[2][0] ,
         \string_buffer[3][7] , \string_buffer[3][6] , \string_buffer[3][5] ,
         \string_buffer[3][4] , \string_buffer[3][3] , \string_buffer[3][2] ,
         \string_buffer[3][1] , \string_buffer[3][0] , \string_buffer[4][7] ,
         \string_buffer[4][6] , \string_buffer[4][5] , \string_buffer[4][4] ,
         \string_buffer[4][3] , \string_buffer[4][2] , \string_buffer[4][1] ,
         \string_buffer[4][0] , \string_buffer[5][7] , \string_buffer[5][6] ,
         \string_buffer[5][5] , \string_buffer[5][4] , \string_buffer[5][3] ,
         \string_buffer[5][2] , \string_buffer[5][1] , \string_buffer[5][0] ,
         \string_buffer[6][7] , \string_buffer[6][6] , \string_buffer[6][5] ,
         \string_buffer[6][4] , \string_buffer[6][3] , \string_buffer[6][2] ,
         \string_buffer[6][1] , \string_buffer[6][0] , \string_buffer[7][7] ,
         \string_buffer[7][6] , \string_buffer[7][5] , \string_buffer[7][4] ,
         \string_buffer[7][3] , \string_buffer[7][2] , \string_buffer[7][1] ,
         \string_buffer[7][0] , \string_buffer[8][7] , \string_buffer[8][6] ,
         \string_buffer[8][5] , \string_buffer[8][4] , \string_buffer[8][3] ,
         \string_buffer[8][2] , \string_buffer[8][1] , \string_buffer[8][0] ,
         \string_buffer[9][7] , \string_buffer[9][6] , \string_buffer[9][5] ,
         \string_buffer[9][4] , \string_buffer[9][3] , \string_buffer[9][2] ,
         \string_buffer[9][1] , \string_buffer[9][0] , \string_buffer[10][7] ,
         \string_buffer[10][6] , \string_buffer[10][5] ,
         \string_buffer[10][4] , \string_buffer[10][3] ,
         \string_buffer[10][2] , \string_buffer[10][1] ,
         \string_buffer[10][0] , \string_buffer[11][7] ,
         \string_buffer[11][6] , \string_buffer[11][5] ,
         \string_buffer[11][4] , \string_buffer[11][3] ,
         \string_buffer[11][2] , \string_buffer[11][1] ,
         \string_buffer[11][0] , \string_buffer[12][7] ,
         \string_buffer[12][6] , \string_buffer[12][5] ,
         \string_buffer[12][4] , \string_buffer[12][3] ,
         \string_buffer[12][2] , \string_buffer[12][1] ,
         \string_buffer[12][0] , \string_buffer[13][7] ,
         \string_buffer[13][6] , \string_buffer[13][5] ,
         \string_buffer[13][4] , \string_buffer[13][3] ,
         \string_buffer[13][2] , \string_buffer[13][1] ,
         \string_buffer[13][0] , \string_buffer[14][7] ,
         \string_buffer[14][6] , \string_buffer[14][5] ,
         \string_buffer[14][4] , \string_buffer[14][3] ,
         \string_buffer[14][2] , \string_buffer[14][1] ,
         \string_buffer[14][0] , \string_buffer[15][7] ,
         \string_buffer[15][6] , \string_buffer[15][5] ,
         \string_buffer[15][4] , \string_buffer[15][3] ,
         \string_buffer[15][2] , \string_buffer[15][1] ,
         \string_buffer[15][0] , \string_buffer[16][7] ,
         \string_buffer[16][6] , \string_buffer[16][5] ,
         \string_buffer[16][4] , \string_buffer[16][3] ,
         \string_buffer[16][2] , \string_buffer[16][1] ,
         \string_buffer[16][0] , \string_buffer[17][7] ,
         \string_buffer[17][6] , \string_buffer[17][5] ,
         \string_buffer[17][4] , \string_buffer[17][3] ,
         \string_buffer[17][2] , \string_buffer[17][1] ,
         \string_buffer[17][0] , \string_buffer[18][7] ,
         \string_buffer[18][6] , \string_buffer[18][5] ,
         \string_buffer[18][4] , \string_buffer[18][3] ,
         \string_buffer[18][2] , \string_buffer[18][1] ,
         \string_buffer[18][0] , \string_buffer[19][7] ,
         \string_buffer[19][6] , \string_buffer[19][5] ,
         \string_buffer[19][4] , \string_buffer[19][3] ,
         \string_buffer[19][2] , \string_buffer[19][1] ,
         \string_buffer[19][0] , \string_buffer[20][7] ,
         \string_buffer[20][6] , \string_buffer[20][5] ,
         \string_buffer[20][4] , \string_buffer[20][3] ,
         \string_buffer[20][2] , \string_buffer[20][1] ,
         \string_buffer[20][0] , \string_buffer[21][7] ,
         \string_buffer[21][6] , \string_buffer[21][5] ,
         \string_buffer[21][4] , \string_buffer[21][3] ,
         \string_buffer[21][2] , \string_buffer[21][1] ,
         \string_buffer[21][0] , \string_buffer[22][7] ,
         \string_buffer[22][6] , \string_buffer[22][5] ,
         \string_buffer[22][4] , \string_buffer[22][3] ,
         \string_buffer[22][2] , \string_buffer[22][1] ,
         \string_buffer[22][0] , \string_buffer[23][7] ,
         \string_buffer[23][6] , \string_buffer[23][5] ,
         \string_buffer[23][4] , \string_buffer[23][3] ,
         \string_buffer[23][2] , \string_buffer[23][1] ,
         \string_buffer[23][0] , \string_buffer[24][7] ,
         \string_buffer[24][6] , \string_buffer[24][5] ,
         \string_buffer[24][4] , \string_buffer[24][3] ,
         \string_buffer[24][2] , \string_buffer[24][1] ,
         \string_buffer[24][0] , \string_buffer[25][7] ,
         \string_buffer[25][6] , \string_buffer[25][5] ,
         \string_buffer[25][4] , \string_buffer[25][3] ,
         \string_buffer[25][2] , \string_buffer[25][1] ,
         \string_buffer[25][0] , \string_buffer[26][7] ,
         \string_buffer[26][6] , \string_buffer[26][5] ,
         \string_buffer[26][4] , \string_buffer[26][3] ,
         \string_buffer[26][2] , \string_buffer[26][1] ,
         \string_buffer[26][0] , \string_buffer[27][7] ,
         \string_buffer[27][6] , \string_buffer[27][5] ,
         \string_buffer[27][4] , \string_buffer[27][3] ,
         \string_buffer[27][2] , \string_buffer[27][1] ,
         \string_buffer[27][0] , \string_buffer[28][7] ,
         \string_buffer[28][6] , \string_buffer[28][5] ,
         \string_buffer[28][4] , \string_buffer[28][3] ,
         \string_buffer[28][2] , \string_buffer[28][1] ,
         \string_buffer[28][0] , \string_buffer[29][7] ,
         \string_buffer[29][6] , \string_buffer[29][5] ,
         \string_buffer[29][4] , \string_buffer[29][3] ,
         \string_buffer[29][2] , \string_buffer[29][1] ,
         \string_buffer[29][0] , \string_buffer[30][7] ,
         \string_buffer[30][6] , \string_buffer[30][5] ,
         \string_buffer[30][4] , \string_buffer[30][3] ,
         \string_buffer[30][2] , \string_buffer[30][1] ,
         \string_buffer[30][0] , \string_buffer[31][7] ,
         \string_buffer[31][6] , \string_buffer[31][5] ,
         \string_buffer[31][4] , \string_buffer[31][3] ,
         \string_buffer[31][2] , \string_buffer[31][1] ,
         \string_buffer[31][0] , \pattern_buffer[0][7] ,
         \pattern_buffer[0][6] , \pattern_buffer[0][5] ,
         \pattern_buffer[0][4] , \pattern_buffer[0][3] ,
         \pattern_buffer[0][2] , \pattern_buffer[0][1] ,
         \pattern_buffer[0][0] , \pattern_buffer[1][7] ,
         \pattern_buffer[1][6] , \pattern_buffer[1][5] ,
         \pattern_buffer[1][4] , \pattern_buffer[1][3] ,
         \pattern_buffer[1][2] , \pattern_buffer[1][1] ,
         \pattern_buffer[1][0] , \pattern_buffer[2][7] ,
         \pattern_buffer[2][6] , \pattern_buffer[2][5] ,
         \pattern_buffer[2][4] , \pattern_buffer[2][3] ,
         \pattern_buffer[2][2] , \pattern_buffer[2][1] ,
         \pattern_buffer[2][0] , \pattern_buffer[3][7] ,
         \pattern_buffer[3][6] , \pattern_buffer[3][5] ,
         \pattern_buffer[3][4] , \pattern_buffer[3][3] ,
         \pattern_buffer[3][2] , \pattern_buffer[3][1] ,
         \pattern_buffer[3][0] , \pattern_buffer[4][7] ,
         \pattern_buffer[4][6] , \pattern_buffer[4][5] ,
         \pattern_buffer[4][4] , \pattern_buffer[4][3] ,
         \pattern_buffer[4][2] , \pattern_buffer[4][1] ,
         \pattern_buffer[4][0] , \pattern_buffer[5][7] ,
         \pattern_buffer[5][6] , \pattern_buffer[5][5] ,
         \pattern_buffer[5][4] , \pattern_buffer[5][3] ,
         \pattern_buffer[5][2] , \pattern_buffer[5][1] ,
         \pattern_buffer[5][0] , \pattern_buffer[6][7] ,
         \pattern_buffer[6][6] , \pattern_buffer[6][5] ,
         \pattern_buffer[6][4] , \pattern_buffer[6][3] ,
         \pattern_buffer[6][2] , \pattern_buffer[6][1] ,
         \pattern_buffer[6][0] , \pattern_buffer[7][7] ,
         \pattern_buffer[7][6] , \pattern_buffer[7][5] ,
         \pattern_buffer[7][4] , \pattern_buffer[7][3] ,
         \pattern_buffer[7][2] , \pattern_buffer[7][1] ,
         \pattern_buffer[7][0] ;
  wire   N110, N111, N112, N113, N114, n4, n5, n11, n21, n22, n24, n26, n28,
         n30, n32, n34, n36, n37, n40, n41, n42, n44, n45, n47, n48, n50, n51,
         n53, n54, n56, n57, n59, n60, n62, n63, n65, n66, n68, n70, n72, n74,
         n76, n78, n80, n82, n83, n85, n87, n89, n91, n93, n95, n97, n99, n100,
         n102, n104, n106, n108, n110, n112, n114, n115, n116, n117, n118,
         n119, n120, n121, n122, n123, n124, n125, n126, n127, n128, n129,
         n130, n131, n132, n133, n134, n135, n136, n137, n138, n139, n140,
         n141, n142, n143, n144, n145, n146, n147, n148, n149, n150, n151,
         n152, n153, n154, n155, n156, n157, n158, n159, n160, n161, n162,
         n163, n164, n165, n166, n167, n168, n169, n170, n171, n172, n173,
         n174, n175, n176, n177, n178, n179, n180, n181, n182, n183, n184,
         n185, n186, n187, n188, n189, n190, n191, n192, n193, n194, n195,
         n196, n197, n198, n199, n200, n201, n202, n203, n204, n205, n206,
         n207, n208, n209, n210, n211, n212, n213, n214, n215, n216, n217,
         n218, n219, n220, n221, n222, n223, n224, n225, n226, n227, n228,
         n229, n230, n231, n232, n233, n234, n235, n236, n237, n238, n239,
         n240, n241, n242, n243, n244, n245, n246, n247, n248, n249, n250,
         n251, n252, n253, n254, n255, n256, n257, n258, n259, n260, n261,
         n262, n263, n264, n265, n266, n267, n268, n269, n270, n271, n272,
         n273, n274, n275, n276, n277, n278, n279, n280, n281, n282, n283,
         n284, n285, n286, n287, n288, n289, n290, n291, n292, n293, n294,
         n295, n296, n297, n298, n299, n300, n301, n302, n303, n304, n305,
         n306, n307, n308, n309, n310, n311, n312, n313, n314, n315, n316,
         n317, n318, n319, n320, n321, n322, n323, n324, n325, n326, n327,
         n328, n329, n330, n331, n332, n333, n334, n335, n336, n337, n338,
         n339, n340, n341, n342, n343, n344, n345, n346, n347, n348, n349,
         n350, n351, n352, n353, n354, n355, n356, n357, n358, n359, n360,
         n361, n362, n363, n364, n365, n366, n367, n368, n369, n370, n371,
         n372, n373, n374, n375, n376, n377, n378, n379, n380, n381, n382,
         n383, n384, n385, n386, n387, n388, n389, n390, n391, n392, n393,
         n394, n395, n396, n397, n398, n399, n400, n401, n402, n403, n404,
         n405, n406, n407, n408, n409, n410, n411, n412, n413, n414, n415,
         n416, n417, n418, n419, n420, n421, n422, n423, n424, n425, n426,
         n427, n428, n429, n430, n431, n432, n433, n434, n435, n436, n437,
         n438, n439, n440, n441, n442, n443, n444, n445, n446, n447, n448,
         n449, n450, n451, n452, n454, n455, n456, n457, n458, n459, n460,
         n461, n462, n463, n464, n465, n466, n467, n468, n469, n470, n471,
         n472, n473, n474, n475, n476, n477, n478, n479, n480, n481, n482,
         n483, n484, n485, n486, n487, n488, n489, n490, n491, n492, n493,
         n494, n495, n496, n497, n498, n499, n500, n501, n502, n503, n504,
         n505, n506, n507, n508, n509, n510, n511, n512, n513, n514, n515,
         n516, n517, n518, n519, n520, n521, n522, n523, n524, n525, n526,
         n527, n528, n529, n530, n531, n532, n533, n534, n535, n536, n537,
         n538, n539, n540, n541, n542, n543, n544, n545, n546, n547, n548,
         n549, n550, n551, n552, n553, n554, n555, n556, n557, n558, n559,
         n560, n561, n562, n563, n564, n565, n566, n567, n568, n569, n570,
         n571, n572, n573, n574, n575, n576, n577, n578, n579, n580, n581,
         n582, n583, n584, n585, n586, n587, n588, n589, n590, n591, n592,
         n593, n594, n595, n596, n597, n598, n599, n600, n601, n602, n603,
         n604, n605, n606, n607, n608, n609, n610, n611, n612, n613, n614,
         n615, n616, n617, n618, n619, n620, n621, n622, n623, n624, n625,
         n626, n627, n628, n629, n630, n631, n632, n633, n634, n635, n636,
         n637, n638, n639, n640, n641, n642, n643, n644, n645, n646, n647,
         n648, n649, n650, n651, n652, n653, n654, n655, n656, n657, n658,
         n659, n660, n661, n662, n663, n664, n665, n666, n667, n668, n669,
         n670, n671, n672, n673, n674, n675, n676, n677, n678, n679, n680,
         n681, n682, n683, n684, n685, n686, n687, n688, n689, n690, n691,
         n692, n693, n694, n695, n696, n697, n698, n699, n700, n701, n702,
         n703, n704, n705, n706, n707, n708, n709, n710, n711, n712, n713,
         n714, n715, n716, n717, n718, n719, n720, n721, n722, n723, n724,
         n725, n726, n727, n728, n729, n730, n731, n732, n733, n734, n735,
         n736, n737, n738, n739, n740, n741, n742, n743, n744, n745, n746,
         n747, n748, n749, n750, n751, n752, n753, n754, n755, n756, n757,
         n758, n759, n760, n761, n762, n763, n764, n765, n766, n767, n768,
         n769, n770, n771, n772, n773, n774, n775, n776, n777, n778, n779,
         n780, n781, \add_192/carry[4] , \add_192/carry[3] ,
         \add_192/carry[2] , n1, n2, n3, n6, n7, n8, n9, n10, n12, n13, n14,
         n15, n16, n17, n18, n19, n20, n23, n25, n27, n29, n31, n33, n35, n38,
         n39, n43, n46, n49, n52, n55, n58, n61, n64, n67, n69, n71, n73, n75,
         n77, n79, n81, n84, n86, n88, n90, n92, n94, n96, n98, n101, n103,
         n105, n107, n109, n111, n113, n453, n782, n783, n784, n785, n786,
         n787, n788, n789, n790, n791, n792, n793, n794, n795, n796, n797,
         n798, n799, n800, n801, n802, n803, n804, n805, n806, n807, n808,
         n809, n810, n811, n812, n813, n814, n815, n816, n817, n818, n819,
         n820, n821, n822, n823, n824, n825, n826, n827, n828, n829, n830,
         n831, n832, n833, n834, n835, n836, n837, n838, n839, n840, n841,
         n842, n843, n844, n845, n846, n847, n848, n849, n850, n851, n852,
         n853, n854, n855, n856, n857, n858, n859, n860, n861, n862, n863,
         n864, n865, n866, n867, n868, n869, n870, n871, n872, n873, n874,
         n875, n876, n877, n878;
  wire   [4:0] temp_read_string_count;
  wire   [2:0] temp_read_pattern_count;

  DFFRX4 \read_pattern_count_reg[0]  ( .D(n447), .CK(clk), .RN(n105), .Q(
        read_pattern_count[0]), .QN(n442) );
  DFFRX1 \temp_read_pattern_count_reg[0]  ( .D(n520), .CK(clk), .RN(n105), .Q(
        temp_read_pattern_count[0]), .QN(n2) );
  DFFRX1 \string_buffer_reg[0][7]  ( .D(n527), .CK(clk), .RN(n786), .Q(
        \string_buffer[0][7] ), .QN(n365) );
  DFFRX1 \read_string_count_reg[0]  ( .D(n452), .CK(clk), .RN(n798), .Q(
        read_string_count[0]), .QN(n437) );
  DFFRX1 \read_string_count_reg[2]  ( .D(n450), .CK(clk), .RN(n798), .Q(
        read_string_count[2]), .QN(n439) );
  DFFRX1 \string_buffer_reg[0][5]  ( .D(n525), .CK(clk), .RN(n787), .Q(
        \string_buffer[0][5] ), .QN(n367) );
  DFFRX1 \string_buffer_reg[0][4]  ( .D(n524), .CK(clk), .RN(n787), .Q(
        \string_buffer[0][4] ), .QN(n368) );
  DFFRX1 \string_buffer_reg[0][6]  ( .D(n526), .CK(clk), .RN(n787), .Q(
        \string_buffer[0][6] ), .QN(n366) );
  DFFRX1 \read_string_count_reg[3]  ( .D(n449), .CK(clk), .RN(n798), .Q(
        read_string_count[3]), .QN(n440) );
  DFFRX1 \string_buffer_reg[0][0]  ( .D(n528), .CK(clk), .RN(n786), .Q(
        \string_buffer[0][0] ), .QN(n364) );
  DFFRX1 \string_buffer_reg[0][1]  ( .D(n521), .CK(clk), .RN(n787), .Q(
        \string_buffer[0][1] ), .QN(n371) );
  DFFRX1 \read_string_count_reg[1]  ( .D(n451), .CK(clk), .RN(n798), .Q(
        read_string_count[1]), .QN(n438) );
  DFFRX1 \string_buffer_reg[0][3]  ( .D(n523), .CK(clk), .RN(n787), .Q(
        \string_buffer[0][3] ), .QN(n369) );
  DFFRX1 \string_buffer_reg[0][2]  ( .D(n522), .CK(clk), .RN(n787), .Q(
        \string_buffer[0][2] ), .QN(n370) );
  DFFRX1 \read_string_count_reg[4]  ( .D(n448), .CK(clk), .RN(n798), .Q(
        read_string_count[4]), .QN(n441) );
  DFFRX1 \string_buffer_reg[31][0]  ( .D(n776), .CK(clk), .RN(n787), .Q(
        \string_buffer[31][0] ), .QN(n116) );
  DFFRX1 \string_buffer_reg[24][2]  ( .D(n714), .CK(clk), .RN(n785), .Q(
        \string_buffer[24][2] ), .QN(n178) );
  DFFRX1 \string_buffer_reg[23][2]  ( .D(n706), .CK(clk), .RN(n788), .Q(
        \string_buffer[23][2] ), .QN(n186) );
  DFFRX1 \string_buffer_reg[16][2]  ( .D(n650), .CK(clk), .RN(n786), .Q(
        \string_buffer[16][2] ), .QN(n242) );
  DFFRX1 \string_buffer_reg[15][2]  ( .D(n642), .CK(clk), .RN(n789), .Q(
        \string_buffer[15][2] ), .QN(n250) );
  DFFRX1 \string_buffer_reg[31][2]  ( .D(n770), .CK(clk), .RN(n788), .Q(
        \string_buffer[31][2] ), .QN(n122) );
  DFFRX1 \string_buffer_reg[8][2]  ( .D(n586), .CK(clk), .RN(n786), .Q(
        \string_buffer[8][2] ), .QN(n306) );
  DFFRX1 \string_buffer_reg[7][2]  ( .D(n578), .CK(clk), .RN(n790), .Q(
        \string_buffer[7][2] ), .QN(n314) );
  DFFRX1 \string_buffer_reg[31][1]  ( .D(n769), .CK(clk), .RN(n788), .Q(
        \string_buffer[31][1] ), .QN(n123) );
  DFFRX1 \string_buffer_reg[26][2]  ( .D(n730), .CK(clk), .RN(n782), .Q(
        \string_buffer[26][2] ), .QN(n162) );
  DFFRX1 \string_buffer_reg[25][2]  ( .D(n722), .CK(clk), .RN(n796), .Q(
        \string_buffer[25][2] ), .QN(n170) );
  DFFRX1 \string_buffer_reg[24][1]  ( .D(n713), .CK(clk), .RN(n785), .Q(
        \string_buffer[24][1] ), .QN(n179) );
  DFFRX1 \string_buffer_reg[23][1]  ( .D(n705), .CK(clk), .RN(n788), .Q(
        \string_buffer[23][1] ), .QN(n187) );
  DFFRX1 \string_buffer_reg[18][2]  ( .D(n666), .CK(clk), .RN(n783), .Q(
        \string_buffer[18][2] ), .QN(n226) );
  DFFRX1 \string_buffer_reg[17][2]  ( .D(n658), .CK(clk), .RN(n796), .Q(
        \string_buffer[17][2] ), .QN(n234) );
  DFFRX1 \string_buffer_reg[16][1]  ( .D(n649), .CK(clk), .RN(n786), .Q(
        \string_buffer[16][1] ), .QN(n243) );
  DFFRX1 \string_buffer_reg[15][1]  ( .D(n641), .CK(clk), .RN(n789), .Q(
        \string_buffer[15][1] ), .QN(n251) );
  DFFRX1 \string_buffer_reg[10][2]  ( .D(n602), .CK(clk), .RN(n784), .Q(
        \string_buffer[10][2] ), .QN(n290) );
  DFFRX1 \string_buffer_reg[9][2]  ( .D(n594), .CK(clk), .RN(n797), .Q(
        \string_buffer[9][2] ), .QN(n298) );
  DFFRX1 \string_buffer_reg[8][1]  ( .D(n585), .CK(clk), .RN(n786), .Q(
        \string_buffer[8][1] ), .QN(n307) );
  DFFRX1 \string_buffer_reg[7][1]  ( .D(n577), .CK(clk), .RN(n790), .Q(
        \string_buffer[7][1] ), .QN(n315) );
  DFFRX1 \string_buffer_reg[2][2]  ( .D(n538), .CK(clk), .RN(n784), .Q(
        \string_buffer[2][2] ), .QN(n354) );
  DFFRX1 \string_buffer_reg[1][2]  ( .D(n530), .CK(clk), .RN(n798), .Q(
        \string_buffer[1][2] ), .QN(n362) );
  DFFRX1 \string_buffer_reg[28][2]  ( .D(n746), .CK(clk), .RN(n113), .Q(
        \string_buffer[28][2] ), .QN(n146) );
  DFFRX1 \string_buffer_reg[27][2]  ( .D(n738), .CK(clk), .RN(n793), .Q(
        \string_buffer[27][2] ), .QN(n154) );
  DFFRX1 \string_buffer_reg[24][0]  ( .D(n720), .CK(clk), .RN(n784), .Q(
        \string_buffer[24][0] ), .QN(n172) );
  DFFRX1 \string_buffer_reg[23][0]  ( .D(n712), .CK(clk), .RN(n788), .Q(
        \string_buffer[23][0] ), .QN(n180) );
  DFFRX1 \string_buffer_reg[20][2]  ( .D(n682), .CK(clk), .RN(n113), .Q(
        \string_buffer[20][2] ), .QN(n210) );
  DFFRX1 \string_buffer_reg[19][2]  ( .D(n674), .CK(clk), .RN(n794), .Q(
        \string_buffer[19][2] ), .QN(n218) );
  DFFRX1 \string_buffer_reg[16][0]  ( .D(n656), .CK(clk), .RN(n785), .Q(
        \string_buffer[16][0] ), .QN(n236) );
  DFFRX1 \string_buffer_reg[26][1]  ( .D(n729), .CK(clk), .RN(n782), .Q(
        \string_buffer[26][1] ), .QN(n163) );
  DFFRX1 \string_buffer_reg[30][2]  ( .D(n762), .CK(clk), .RN(n107), .Q(
        \string_buffer[30][2] ), .QN(n130) );
  DFFRX1 \string_buffer_reg[15][0]  ( .D(n648), .CK(clk), .RN(n788), .Q(
        \string_buffer[15][0] ), .QN(n244) );
  DFFRX1 \string_buffer_reg[25][1]  ( .D(n721), .CK(clk), .RN(n796), .Q(
        \string_buffer[25][1] ), .QN(n171) );
  DFFRX1 \string_buffer_reg[12][2]  ( .D(n618), .CK(clk), .RN(n453), .Q(
        \string_buffer[12][2] ), .QN(n274) );
  DFFRX1 \string_buffer_reg[29][2]  ( .D(n754), .CK(clk), .RN(n790), .Q(
        \string_buffer[29][2] ), .QN(n138) );
  DFFRX1 \string_buffer_reg[11][2]  ( .D(n610), .CK(clk), .RN(n794), .Q(
        \string_buffer[11][2] ), .QN(n282) );
  DFFRX1 \string_buffer_reg[8][0]  ( .D(n592), .CK(clk), .RN(n786), .Q(
        \string_buffer[8][0] ), .QN(n300) );
  DFFRX1 \string_buffer_reg[7][0]  ( .D(n584), .CK(clk), .RN(n789), .Q(
        \string_buffer[7][0] ), .QN(n308) );
  DFFRX1 \string_buffer_reg[4][2]  ( .D(n554), .CK(clk), .RN(n782), .Q(
        \string_buffer[4][2] ), .QN(n338) );
  DFFRX1 \string_buffer_reg[3][2]  ( .D(n546), .CK(clk), .RN(n795), .Q(
        \string_buffer[3][2] ), .QN(n346) );
  DFFRX1 \string_buffer_reg[18][1]  ( .D(n665), .CK(clk), .RN(n783), .Q(
        \string_buffer[18][1] ), .QN(n227) );
  DFFRX1 \string_buffer_reg[22][2]  ( .D(n698), .CK(clk), .RN(n109), .Q(
        \string_buffer[22][2] ), .QN(n194) );
  DFFRX1 \string_buffer_reg[17][1]  ( .D(n657), .CK(clk), .RN(n796), .Q(
        \string_buffer[17][1] ), .QN(n235) );
  DFFRX1 \string_buffer_reg[21][2]  ( .D(n690), .CK(clk), .RN(n791), .Q(
        \string_buffer[21][2] ), .QN(n202) );
  DFFRX1 \string_buffer_reg[10][1]  ( .D(n601), .CK(clk), .RN(n784), .Q(
        \string_buffer[10][1] ), .QN(n291) );
  DFFRX1 \string_buffer_reg[14][2]  ( .D(n634), .CK(clk), .RN(n109), .Q(
        \string_buffer[14][2] ), .QN(n258) );
  DFFRX1 \string_buffer_reg[9][1]  ( .D(n593), .CK(clk), .RN(n797), .Q(
        \string_buffer[9][1] ), .QN(n299) );
  DFFRX1 \string_buffer_reg[13][2]  ( .D(n626), .CK(clk), .RN(n792), .Q(
        \string_buffer[13][2] ), .QN(n266) );
  DFFRX1 \string_buffer_reg[2][1]  ( .D(n537), .CK(clk), .RN(n784), .Q(
        \string_buffer[2][1] ), .QN(n355) );
  DFFRX1 \string_buffer_reg[6][2]  ( .D(n570), .CK(clk), .RN(n111), .Q(
        \string_buffer[6][2] ), .QN(n322) );
  DFFRX1 \string_buffer_reg[5][2]  ( .D(n562), .CK(clk), .RN(n792), .Q(
        \string_buffer[5][2] ), .QN(n330) );
  DFFRX1 \string_buffer_reg[1][1]  ( .D(n529), .CK(clk), .RN(n798), .Q(
        \string_buffer[1][1] ), .QN(n363) );
  DFFRX1 \string_buffer_reg[28][1]  ( .D(n745), .CK(clk), .RN(n113), .Q(
        \string_buffer[28][1] ), .QN(n147) );
  DFFRX1 \string_buffer_reg[26][0]  ( .D(n736), .CK(clk), .RN(n782), .Q(
        \string_buffer[26][0] ), .QN(n156) );
  DFFRX1 \string_buffer_reg[27][1]  ( .D(n737), .CK(clk), .RN(n793), .Q(
        \string_buffer[27][1] ), .QN(n155) );
  DFFRX1 \string_buffer_reg[25][0]  ( .D(n728), .CK(clk), .RN(n795), .Q(
        \string_buffer[25][0] ), .QN(n164) );
  DFFRX1 \string_buffer_reg[20][1]  ( .D(n681), .CK(clk), .RN(n113), .Q(
        \string_buffer[20][1] ), .QN(n211) );
  DFFRX1 \string_buffer_reg[18][0]  ( .D(n672), .CK(clk), .RN(n782), .Q(
        \string_buffer[18][0] ), .QN(n220) );
  DFFRX1 \string_buffer_reg[19][1]  ( .D(n673), .CK(clk), .RN(n794), .Q(
        \string_buffer[19][1] ), .QN(n219) );
  DFFRX1 \string_buffer_reg[17][0]  ( .D(n664), .CK(clk), .RN(n796), .Q(
        \string_buffer[17][0] ), .QN(n228) );
  DFFRX1 \string_buffer_reg[30][1]  ( .D(n761), .CK(clk), .RN(n107), .Q(
        \string_buffer[30][1] ), .QN(n131) );
  DFFRX1 \string_buffer_reg[29][1]  ( .D(n753), .CK(clk), .RN(n790), .Q(
        \string_buffer[29][1] ), .QN(n139) );
  DFFRX1 \string_buffer_reg[12][1]  ( .D(n617), .CK(clk), .RN(n453), .Q(
        \string_buffer[12][1] ), .QN(n275) );
  DFFRX1 \string_buffer_reg[10][0]  ( .D(n608), .CK(clk), .RN(n783), .Q(
        \string_buffer[10][0] ), .QN(n284) );
  DFFRX1 \string_buffer_reg[11][1]  ( .D(n609), .CK(clk), .RN(n794), .Q(
        \string_buffer[11][1] ), .QN(n283) );
  DFFRX1 \string_buffer_reg[9][0]  ( .D(n600), .CK(clk), .RN(n796), .Q(
        \string_buffer[9][0] ), .QN(n292) );
  DFFRX1 \string_buffer_reg[4][1]  ( .D(n553), .CK(clk), .RN(n782), .Q(
        \string_buffer[4][1] ), .QN(n339) );
  DFFRX1 \string_buffer_reg[2][0]  ( .D(n544), .CK(clk), .RN(n784), .Q(
        \string_buffer[2][0] ), .QN(n348) );
  DFFRX1 \string_buffer_reg[3][1]  ( .D(n545), .CK(clk), .RN(n795), .Q(
        \string_buffer[3][1] ), .QN(n347) );
  DFFRX1 \string_buffer_reg[31][4]  ( .D(n772), .CK(clk), .RN(n787), .Q(
        \string_buffer[31][4] ), .QN(n120) );
  DFFRX1 \string_buffer_reg[22][1]  ( .D(n697), .CK(clk), .RN(n109), .Q(
        \string_buffer[22][1] ), .QN(n195) );
  DFFRX1 \string_buffer_reg[1][0]  ( .D(n536), .CK(clk), .RN(n797), .Q(
        \string_buffer[1][0] ), .QN(n356) );
  DFFRX1 \string_buffer_reg[21][1]  ( .D(n689), .CK(clk), .RN(n791), .Q(
        \string_buffer[21][1] ), .QN(n203) );
  DFFRX1 \string_buffer_reg[28][0]  ( .D(n752), .CK(clk), .RN(n111), .Q(
        \string_buffer[28][0] ), .QN(n140) );
  DFFRX1 \string_buffer_reg[27][0]  ( .D(n744), .CK(clk), .RN(n792), .Q(
        \string_buffer[27][0] ), .QN(n148) );
  DFFRX1 \string_buffer_reg[14][1]  ( .D(n633), .CK(clk), .RN(n109), .Q(
        \string_buffer[14][1] ), .QN(n259) );
  DFFRX1 \string_buffer_reg[13][1]  ( .D(n625), .CK(clk), .RN(n792), .Q(
        \string_buffer[13][1] ), .QN(n267) );
  DFFRX1 \string_buffer_reg[6][1]  ( .D(n569), .CK(clk), .RN(n111), .Q(
        \string_buffer[6][1] ), .QN(n323) );
  DFFRX1 \string_buffer_reg[20][0]  ( .D(n688), .CK(clk), .RN(n113), .Q(
        \string_buffer[20][0] ), .QN(n204) );
  DFFRX1 \string_buffer_reg[5][1]  ( .D(n561), .CK(clk), .RN(n792), .Q(
        \string_buffer[5][1] ), .QN(n331) );
  DFFRX1 \string_buffer_reg[19][0]  ( .D(n680), .CK(clk), .RN(n793), .Q(
        \string_buffer[19][0] ), .QN(n212) );
  DFFRX1 \string_buffer_reg[30][0]  ( .D(n768), .CK(clk), .RN(n105), .Q(
        \string_buffer[30][0] ), .QN(n124) );
  DFFRX1 \string_buffer_reg[12][0]  ( .D(n624), .CK(clk), .RN(n113), .Q(
        \string_buffer[12][0] ), .QN(n268) );
  DFFRX1 \string_buffer_reg[29][0]  ( .D(n760), .CK(clk), .RN(n790), .Q(
        \string_buffer[29][0] ), .QN(n132) );
  DFFRX1 \string_buffer_reg[11][0]  ( .D(n616), .CK(clk), .RN(n794), .Q(
        \string_buffer[11][0] ), .QN(n276) );
  DFFRX1 \string_buffer_reg[4][0]  ( .D(n560), .CK(clk), .RN(n453), .Q(
        \string_buffer[4][0] ), .QN(n332) );
  DFFRX1 \string_buffer_reg[3][0]  ( .D(n552), .CK(clk), .RN(n794), .Q(
        \string_buffer[3][0] ), .QN(n340) );
  DFFRX1 \string_buffer_reg[31][5]  ( .D(n773), .CK(clk), .RN(n787), .Q(
        \string_buffer[31][5] ), .QN(n119) );
  DFFRX1 \string_buffer_reg[22][0]  ( .D(n704), .CK(clk), .RN(n107), .Q(
        \string_buffer[22][0] ), .QN(n188) );
  DFFRX1 \string_buffer_reg[21][0]  ( .D(n696), .CK(clk), .RN(n790), .Q(
        \string_buffer[21][0] ), .QN(n196) );
  DFFRX1 \string_buffer_reg[14][0]  ( .D(n640), .CK(clk), .RN(n109), .Q(
        \string_buffer[14][0] ), .QN(n252) );
  DFFRX1 \string_buffer_reg[13][0]  ( .D(n632), .CK(clk), .RN(n791), .Q(
        \string_buffer[13][0] ), .QN(n260) );
  DFFRX1 \string_buffer_reg[6][0]  ( .D(n576), .CK(clk), .RN(n109), .Q(
        \string_buffer[6][0] ), .QN(n316) );
  DFFRX1 \string_buffer_reg[5][0]  ( .D(n568), .CK(clk), .RN(n792), .Q(
        \string_buffer[5][0] ), .QN(n324) );
  DFFRX1 \string_buffer_reg[31][3]  ( .D(n771), .CK(clk), .RN(n787), .Q(
        \string_buffer[31][3] ), .QN(n121) );
  DFFRX1 \string_buffer_reg[15][5]  ( .D(n645), .CK(clk), .RN(n789), .Q(
        \string_buffer[15][5] ), .QN(n247) );
  DFFRX1 \string_buffer_reg[11][5]  ( .D(n613), .CK(clk), .RN(n794), .Q(
        \string_buffer[11][5] ), .QN(n279) );
  DFFRX1 \string_buffer_reg[31][7]  ( .D(n775), .CK(clk), .RN(n787), .Q(
        \string_buffer[31][7] ), .QN(n117) );
  DFFRX1 \string_buffer_reg[7][5]  ( .D(n581), .CK(clk), .RN(n789), .Q(
        \string_buffer[7][5] ), .QN(n311) );
  DFFRX1 \string_buffer_reg[27][5]  ( .D(n741), .CK(clk), .RN(n793), .Q(
        \string_buffer[27][5] ), .QN(n151) );
  DFFRX1 \string_buffer_reg[23][5]  ( .D(n709), .CK(clk), .RN(n788), .Q(
        \string_buffer[23][5] ), .QN(n183) );
  DFFRX1 \string_buffer_reg[31][6]  ( .D(n774), .CK(clk), .RN(n787), .Q(
        \string_buffer[31][6] ), .QN(n118) );
  DFFRX1 \string_buffer_reg[3][5]  ( .D(n549), .CK(clk), .RN(n795), .Q(
        \string_buffer[3][5] ), .QN(n343) );
  DFFRX1 \string_buffer_reg[19][5]  ( .D(n677), .CK(clk), .RN(n793), .Q(
        \string_buffer[19][5] ), .QN(n215) );
  DFFRX1 \string_buffer_reg[16][5]  ( .D(n653), .CK(clk), .RN(n785), .Q(
        \string_buffer[16][5] ), .QN(n239) );
  DFFRX1 \string_buffer_reg[12][5]  ( .D(n621), .CK(clk), .RN(n453), .Q(
        \string_buffer[12][5] ), .QN(n271) );
  DFFRX1 \string_buffer_reg[28][5]  ( .D(n749), .CK(clk), .RN(n111), .Q(
        \string_buffer[28][5] ), .QN(n143) );
  DFFRX1 \string_buffer_reg[8][5]  ( .D(n589), .CK(clk), .RN(n786), .Q(
        \string_buffer[8][5] ), .QN(n303) );
  DFFRX1 \string_buffer_reg[4][5]  ( .D(n557), .CK(clk), .RN(n453), .Q(
        \string_buffer[4][5] ), .QN(n335) );
  DFFRX1 \string_buffer_reg[24][5]  ( .D(n717), .CK(clk), .RN(n785), .Q(
        \string_buffer[24][5] ), .QN(n175) );
  DFFRX1 \string_buffer_reg[29][5]  ( .D(n757), .CK(clk), .RN(n790), .Q(
        \string_buffer[29][5] ), .QN(n135) );
  DFFRX1 \string_buffer_reg[20][5]  ( .D(n685), .CK(clk), .RN(n113), .Q(
        \string_buffer[20][5] ), .QN(n207) );
  DFFRX1 \string_buffer_reg[24][4]  ( .D(n716), .CK(clk), .RN(n785), .Q(
        \string_buffer[24][4] ), .QN(n176) );
  DFFRX1 \string_buffer_reg[23][4]  ( .D(n708), .CK(clk), .RN(n788), .Q(
        \string_buffer[23][4] ), .QN(n184) );
  DFFRX1 \string_buffer_reg[30][5]  ( .D(n765), .CK(clk), .RN(n107), .Q(
        \string_buffer[30][5] ), .QN(n127) );
  DFFRX1 \string_buffer_reg[16][4]  ( .D(n652), .CK(clk), .RN(n785), .Q(
        \string_buffer[16][4] ), .QN(n240) );
  DFFRX1 \string_buffer_reg[15][4]  ( .D(n644), .CK(clk), .RN(n789), .Q(
        \string_buffer[15][4] ), .QN(n248) );
  DFFRX1 \string_buffer_reg[8][4]  ( .D(n588), .CK(clk), .RN(n786), .Q(
        \string_buffer[8][4] ), .QN(n304) );
  DFFRX1 \string_buffer_reg[7][4]  ( .D(n580), .CK(clk), .RN(n789), .Q(
        \string_buffer[7][4] ), .QN(n312) );
  DFFRX1 \string_buffer_reg[14][5]  ( .D(n637), .CK(clk), .RN(n109), .Q(
        \string_buffer[14][5] ), .QN(n255) );
  DFFRX1 \string_buffer_reg[26][4]  ( .D(n732), .CK(clk), .RN(n782), .Q(
        \string_buffer[26][4] ), .QN(n160) );
  DFFRX1 \string_buffer_reg[25][4]  ( .D(n724), .CK(clk), .RN(n795), .Q(
        \string_buffer[25][4] ), .QN(n168) );
  DFFRX1 \string_buffer_reg[10][5]  ( .D(n605), .CK(clk), .RN(n783), .Q(
        \string_buffer[10][5] ), .QN(n287) );
  DFFRX1 \string_buffer_reg[24][3]  ( .D(n715), .CK(clk), .RN(n785), .Q(
        \string_buffer[24][3] ), .QN(n177) );
  DFFRX1 \string_buffer_reg[23][3]  ( .D(n707), .CK(clk), .RN(n788), .Q(
        \string_buffer[23][3] ), .QN(n185) );
  DFFRX1 \string_buffer_reg[6][5]  ( .D(n573), .CK(clk), .RN(n111), .Q(
        \string_buffer[6][5] ), .QN(n319) );
  DFFRX1 \string_buffer_reg[18][4]  ( .D(n668), .CK(clk), .RN(n783), .Q(
        \string_buffer[18][4] ), .QN(n224) );
  DFFRX1 \string_buffer_reg[13][5]  ( .D(n629), .CK(clk), .RN(n791), .Q(
        \string_buffer[13][5] ), .QN(n263) );
  DFFRX1 \string_buffer_reg[17][4]  ( .D(n660), .CK(clk), .RN(n796), .Q(
        \string_buffer[17][4] ), .QN(n232) );
  DFFRX1 \string_buffer_reg[26][5]  ( .D(n733), .CK(clk), .RN(n782), .Q(
        \string_buffer[26][5] ), .QN(n159) );
  DFFRX1 \string_buffer_reg[16][3]  ( .D(n651), .CK(clk), .RN(n785), .Q(
        \string_buffer[16][3] ), .QN(n241) );
  DFFRX1 \string_buffer_reg[10][4]  ( .D(n604), .CK(clk), .RN(n783), .Q(
        \string_buffer[10][4] ), .QN(n288) );
  DFFRX1 \string_buffer_reg[22][5]  ( .D(n701), .CK(clk), .RN(n107), .Q(
        \string_buffer[22][5] ), .QN(n191) );
  DFFRX1 \string_buffer_reg[15][3]  ( .D(n643), .CK(clk), .RN(n789), .Q(
        \string_buffer[15][3] ), .QN(n249) );
  DFFRX1 \string_buffer_reg[9][5]  ( .D(n597), .CK(clk), .RN(n797), .Q(
        \string_buffer[9][5] ), .QN(n295) );
  DFFRX1 \string_buffer_reg[9][4]  ( .D(n596), .CK(clk), .RN(n797), .Q(
        \string_buffer[9][4] ), .QN(n296) );
  DFFRX1 \string_buffer_reg[8][3]  ( .D(n587), .CK(clk), .RN(n786), .Q(
        \string_buffer[8][3] ), .QN(n305) );
  DFFRX1 \string_buffer_reg[5][5]  ( .D(n565), .CK(clk), .RN(n792), .Q(
        \string_buffer[5][5] ), .QN(n327) );
  DFFRX1 \string_buffer_reg[18][5]  ( .D(n669), .CK(clk), .RN(n783), .Q(
        \string_buffer[18][5] ), .QN(n223) );
  DFFRX1 \string_buffer_reg[2][4]  ( .D(n540), .CK(clk), .RN(n784), .Q(
        \string_buffer[2][4] ), .QN(n352) );
  DFFRX1 \string_buffer_reg[7][3]  ( .D(n579), .CK(clk), .RN(n789), .Q(
        \string_buffer[7][3] ), .QN(n313) );
  DFFRX1 \string_buffer_reg[1][4]  ( .D(n532), .CK(clk), .RN(n797), .Q(
        \string_buffer[1][4] ), .QN(n360) );
  DFFRX1 \string_buffer_reg[25][5]  ( .D(n725), .CK(clk), .RN(n795), .Q(
        \string_buffer[25][5] ), .QN(n167) );
  DFFRX1 \string_buffer_reg[28][4]  ( .D(n748), .CK(clk), .RN(n111), .Q(
        \string_buffer[28][4] ), .QN(n144) );
  DFFRX1 \string_buffer_reg[27][4]  ( .D(n740), .CK(clk), .RN(n793), .Q(
        \string_buffer[27][4] ), .QN(n152) );
  DFFRX1 \string_buffer_reg[21][5]  ( .D(n693), .CK(clk), .RN(n791), .Q(
        \string_buffer[21][5] ), .QN(n199) );
  DFFRX1 \string_buffer_reg[24][7]  ( .D(n719), .CK(clk), .RN(n784), .Q(
        \string_buffer[24][7] ), .QN(n173) );
  DFFRX1 \string_buffer_reg[23][7]  ( .D(n711), .CK(clk), .RN(n788), .Q(
        \string_buffer[23][7] ), .QN(n181) );
  DFFRX1 \string_buffer_reg[17][5]  ( .D(n661), .CK(clk), .RN(n796), .Q(
        \string_buffer[17][5] ), .QN(n231) );
  DFFRX1 \string_buffer_reg[20][4]  ( .D(n684), .CK(clk), .RN(n113), .Q(
        \string_buffer[20][4] ), .QN(n208) );
  DFFRX1 \string_buffer_reg[19][4]  ( .D(n676), .CK(clk), .RN(n793), .Q(
        \string_buffer[19][4] ), .QN(n216) );
  DFFRX1 \string_buffer_reg[16][7]  ( .D(n655), .CK(clk), .RN(n785), .Q(
        \string_buffer[16][7] ), .QN(n237) );
  DFFRX1 \string_buffer_reg[30][4]  ( .D(n764), .CK(clk), .RN(n107), .Q(
        \string_buffer[30][4] ), .QN(n128) );
  DFFRX1 \string_buffer_reg[15][7]  ( .D(n647), .CK(clk), .RN(n788), .Q(
        \string_buffer[15][7] ), .QN(n245) );
  DFFRX1 \string_buffer_reg[12][4]  ( .D(n620), .CK(clk), .RN(n453), .Q(
        \string_buffer[12][4] ), .QN(n272) );
  DFFRX1 \string_buffer_reg[26][3]  ( .D(n731), .CK(clk), .RN(n782), .Q(
        \string_buffer[26][3] ), .QN(n161) );
  DFFRX1 \string_buffer_reg[29][4]  ( .D(n756), .CK(clk), .RN(n790), .Q(
        \string_buffer[29][4] ), .QN(n136) );
  DFFRX1 \string_buffer_reg[24][6]  ( .D(n718), .CK(clk), .RN(n785), .Q(
        \string_buffer[24][6] ), .QN(n174) );
  DFFRX1 \string_buffer_reg[11][4]  ( .D(n612), .CK(clk), .RN(n794), .Q(
        \string_buffer[11][4] ), .QN(n280) );
  DFFRX1 \string_buffer_reg[25][3]  ( .D(n723), .CK(clk), .RN(n795), .Q(
        \string_buffer[25][3] ), .QN(n169) );
  DFFRX1 \string_buffer_reg[23][6]  ( .D(n710), .CK(clk), .RN(n788), .Q(
        \string_buffer[23][6] ), .QN(n182) );
  DFFRX1 \string_buffer_reg[8][7]  ( .D(n591), .CK(clk), .RN(n786), .Q(
        \string_buffer[8][7] ), .QN(n301) );
  DFFRX1 \string_buffer_reg[7][7]  ( .D(n583), .CK(clk), .RN(n789), .Q(
        \string_buffer[7][7] ), .QN(n309) );
  DFFRX1 \string_buffer_reg[4][4]  ( .D(n556), .CK(clk), .RN(n453), .Q(
        \string_buffer[4][4] ), .QN(n336) );
  DFFRX1 \string_buffer_reg[2][5]  ( .D(n541), .CK(clk), .RN(n784), .Q(
        \string_buffer[2][5] ), .QN(n351) );
  DFFRX1 \string_buffer_reg[3][4]  ( .D(n548), .CK(clk), .RN(n795), .Q(
        \string_buffer[3][4] ), .QN(n344) );
  DFFRX1 \string_buffer_reg[22][4]  ( .D(n700), .CK(clk), .RN(n107), .Q(
        \string_buffer[22][4] ), .QN(n192) );
  DFFRX1 \string_buffer_reg[18][3]  ( .D(n667), .CK(clk), .RN(n783), .Q(
        \string_buffer[18][3] ), .QN(n225) );
  DFFRX1 \string_buffer_reg[21][4]  ( .D(n692), .CK(clk), .RN(n791), .Q(
        \string_buffer[21][4] ), .QN(n200) );
  DFFRX1 \string_buffer_reg[16][6]  ( .D(n654), .CK(clk), .RN(n785), .Q(
        \string_buffer[16][6] ), .QN(n238) );
  DFFRX1 \string_buffer_reg[17][3]  ( .D(n659), .CK(clk), .RN(n796), .Q(
        \string_buffer[17][3] ), .QN(n233) );
  DFFRX1 \string_buffer_reg[15][6]  ( .D(n646), .CK(clk), .RN(n789), .Q(
        \string_buffer[15][6] ), .QN(n246) );
  DFFRX1 \string_buffer_reg[14][4]  ( .D(n636), .CK(clk), .RN(n109), .Q(
        \string_buffer[14][4] ), .QN(n256) );
  DFFRX1 \string_buffer_reg[10][3]  ( .D(n603), .CK(clk), .RN(n783), .Q(
        \string_buffer[10][3] ), .QN(n289) );
  DFFRX1 \string_buffer_reg[13][4]  ( .D(n628), .CK(clk), .RN(n791), .Q(
        \string_buffer[13][4] ), .QN(n264) );
  DFFRX1 \string_buffer_reg[8][6]  ( .D(n590), .CK(clk), .RN(n786), .Q(
        \string_buffer[8][6] ), .QN(n302) );
  DFFRX1 \string_buffer_reg[9][3]  ( .D(n595), .CK(clk), .RN(n797), .Q(
        \string_buffer[9][3] ), .QN(n297) );
  DFFRX1 \string_buffer_reg[7][6]  ( .D(n582), .CK(clk), .RN(n789), .Q(
        \string_buffer[7][6] ), .QN(n310) );
  DFFRX1 \string_buffer_reg[6][4]  ( .D(n572), .CK(clk), .RN(n111), .Q(
        \string_buffer[6][4] ), .QN(n320) );
  DFFRX1 \string_buffer_reg[5][4]  ( .D(n564), .CK(clk), .RN(n792), .Q(
        \string_buffer[5][4] ), .QN(n328) );
  DFFRX1 \string_buffer_reg[2][3]  ( .D(n539), .CK(clk), .RN(n784), .Q(
        \string_buffer[2][3] ), .QN(n353) );
  DFFRX1 \string_buffer_reg[26][7]  ( .D(n735), .CK(clk), .RN(n782), .Q(
        \string_buffer[26][7] ), .QN(n157) );
  DFFRX1 \string_buffer_reg[1][3]  ( .D(n531), .CK(clk), .RN(n797), .Q(
        \string_buffer[1][3] ), .QN(n361) );
  DFFRX1 \string_buffer_reg[28][3]  ( .D(n747), .CK(clk), .RN(n111), .Q(
        \string_buffer[28][3] ), .QN(n145) );
  DFFRX1 \string_buffer_reg[25][7]  ( .D(n727), .CK(clk), .RN(n795), .Q(
        \string_buffer[25][7] ), .QN(n165) );
  DFFRX1 \string_buffer_reg[27][3]  ( .D(n739), .CK(clk), .RN(n793), .Q(
        \string_buffer[27][3] ), .QN(n153) );
  DFFRX1 \string_buffer_reg[18][7]  ( .D(n671), .CK(clk), .RN(n782), .Q(
        \string_buffer[18][7] ), .QN(n221) );
  DFFRX1 \string_buffer_reg[20][3]  ( .D(n683), .CK(clk), .RN(n113), .Q(
        \string_buffer[20][3] ), .QN(n209) );
  DFFRX1 \string_buffer_reg[17][7]  ( .D(n663), .CK(clk), .RN(n796), .Q(
        \string_buffer[17][7] ), .QN(n229) );
  DFFRX1 \string_buffer_reg[26][6]  ( .D(n734), .CK(clk), .RN(n782), .Q(
        \string_buffer[26][6] ), .QN(n158) );
  DFFRX1 \string_buffer_reg[19][3]  ( .D(n675), .CK(clk), .RN(n793), .Q(
        \string_buffer[19][3] ), .QN(n217) );
  DFFRX1 \string_buffer_reg[25][6]  ( .D(n726), .CK(clk), .RN(n795), .Q(
        \string_buffer[25][6] ), .QN(n166) );
  DFFRX1 \string_buffer_reg[1][5]  ( .D(n533), .CK(clk), .RN(n797), .Q(
        \string_buffer[1][5] ), .QN(n359) );
  DFFRX1 \string_buffer_reg[10][7]  ( .D(n607), .CK(clk), .RN(n783), .Q(
        \string_buffer[10][7] ), .QN(n285) );
  DFFRX1 \string_buffer_reg[30][3]  ( .D(n763), .CK(clk), .RN(n107), .Q(
        \string_buffer[30][3] ), .QN(n129) );
  DFFRX1 \string_buffer_reg[9][7]  ( .D(n599), .CK(clk), .RN(n796), .Q(
        \string_buffer[9][7] ), .QN(n293) );
  DFFRX1 \string_buffer_reg[12][3]  ( .D(n619), .CK(clk), .RN(n453), .Q(
        \string_buffer[12][3] ), .QN(n273) );
  DFFRX1 \string_buffer_reg[29][3]  ( .D(n755), .CK(clk), .RN(n790), .Q(
        \string_buffer[29][3] ), .QN(n137) );
  DFFRX1 \string_buffer_reg[11][3]  ( .D(n611), .CK(clk), .RN(n794), .Q(
        \string_buffer[11][3] ), .QN(n281) );
  DFFRX1 \string_buffer_reg[2][7]  ( .D(n543), .CK(clk), .RN(n784), .Q(
        \string_buffer[2][7] ), .QN(n349) );
  DFFRX1 \string_buffer_reg[18][6]  ( .D(n670), .CK(clk), .RN(n783), .Q(
        \string_buffer[18][6] ), .QN(n222) );
  DFFRX1 \string_buffer_reg[4][3]  ( .D(n555), .CK(clk), .RN(n453), .Q(
        \string_buffer[4][3] ), .QN(n337) );
  DFFRX1 \string_buffer_reg[1][7]  ( .D(n535), .CK(clk), .RN(n797), .Q(
        \string_buffer[1][7] ), .QN(n357) );
  DFFRX1 \string_buffer_reg[3][3]  ( .D(n547), .CK(clk), .RN(n795), .Q(
        \string_buffer[3][3] ), .QN(n345) );
  DFFRX1 \string_buffer_reg[17][6]  ( .D(n662), .CK(clk), .RN(n796), .Q(
        \string_buffer[17][6] ), .QN(n230) );
  DFFRX1 \string_buffer_reg[28][7]  ( .D(n751), .CK(clk), .RN(n111), .Q(
        \string_buffer[28][7] ), .QN(n141) );
  DFFRX1 \string_buffer_reg[22][3]  ( .D(n699), .CK(clk), .RN(n107), .Q(
        \string_buffer[22][3] ), .QN(n193) );
  DFFRX1 \string_buffer_reg[21][3]  ( .D(n691), .CK(clk), .RN(n791), .Q(
        \string_buffer[21][3] ), .QN(n201) );
  DFFRX1 \string_buffer_reg[27][7]  ( .D(n743), .CK(clk), .RN(n792), .Q(
        \string_buffer[27][7] ), .QN(n149) );
  DFFRX1 \string_buffer_reg[10][6]  ( .D(n606), .CK(clk), .RN(n783), .Q(
        \string_buffer[10][6] ), .QN(n286) );
  DFFRX1 \string_buffer_reg[9][6]  ( .D(n598), .CK(clk), .RN(n797), .Q(
        \string_buffer[9][6] ), .QN(n294) );
  DFFRX1 \string_buffer_reg[14][3]  ( .D(n635), .CK(clk), .RN(n109), .Q(
        \string_buffer[14][3] ), .QN(n257) );
  DFFRX1 \string_buffer_reg[13][3]  ( .D(n627), .CK(clk), .RN(n791), .Q(
        \string_buffer[13][3] ), .QN(n265) );
  DFFRX1 \string_buffer_reg[2][6]  ( .D(n542), .CK(clk), .RN(n784), .Q(
        \string_buffer[2][6] ), .QN(n350) );
  DFFRX1 \string_buffer_reg[20][7]  ( .D(n687), .CK(clk), .RN(n113), .Q(
        \string_buffer[20][7] ), .QN(n205) );
  DFFRX1 \string_buffer_reg[19][7]  ( .D(n679), .CK(clk), .RN(n793), .Q(
        \string_buffer[19][7] ), .QN(n213) );
  DFFRX1 \string_buffer_reg[1][6]  ( .D(n534), .CK(clk), .RN(n797), .Q(
        \string_buffer[1][6] ), .QN(n358) );
  DFFRX1 \string_buffer_reg[6][3]  ( .D(n571), .CK(clk), .RN(n111), .Q(
        \string_buffer[6][3] ), .QN(n321) );
  DFFRX1 \string_buffer_reg[28][6]  ( .D(n750), .CK(clk), .RN(n111), .Q(
        \string_buffer[28][6] ), .QN(n142) );
  DFFRX1 \string_buffer_reg[5][3]  ( .D(n563), .CK(clk), .RN(n792), .Q(
        \string_buffer[5][3] ), .QN(n329) );
  DFFRX1 \string_buffer_reg[30][7]  ( .D(n767), .CK(clk), .RN(n105), .Q(
        \string_buffer[30][7] ), .QN(n125) );
  DFFRX1 \string_buffer_reg[27][6]  ( .D(n742), .CK(clk), .RN(n793), .Q(
        \string_buffer[27][6] ), .QN(n150) );
  DFFRX1 \string_buffer_reg[12][7]  ( .D(n623), .CK(clk), .RN(n113), .Q(
        \string_buffer[12][7] ), .QN(n269) );
  DFFRX1 \string_buffer_reg[29][7]  ( .D(n759), .CK(clk), .RN(n790), .Q(
        \string_buffer[29][7] ), .QN(n133) );
  DFFRX1 \string_buffer_reg[11][7]  ( .D(n615), .CK(clk), .RN(n794), .Q(
        \string_buffer[11][7] ), .QN(n277) );
  DFFRX1 \string_buffer_reg[4][7]  ( .D(n559), .CK(clk), .RN(n453), .Q(
        \string_buffer[4][7] ), .QN(n333) );
  DFFRX1 \string_buffer_reg[20][6]  ( .D(n686), .CK(clk), .RN(n113), .Q(
        \string_buffer[20][6] ), .QN(n206) );
  DFFRX1 \string_buffer_reg[3][7]  ( .D(n551), .CK(clk), .RN(n794), .Q(
        \string_buffer[3][7] ), .QN(n341) );
  DFFRX1 \string_buffer_reg[22][7]  ( .D(n703), .CK(clk), .RN(n107), .Q(
        \string_buffer[22][7] ), .QN(n189) );
  DFFRX1 \string_buffer_reg[19][6]  ( .D(n678), .CK(clk), .RN(n793), .Q(
        \string_buffer[19][6] ), .QN(n214) );
  DFFRX1 \string_buffer_reg[21][7]  ( .D(n695), .CK(clk), .RN(n790), .Q(
        \string_buffer[21][7] ), .QN(n197) );
  DFFRX1 \string_buffer_reg[30][6]  ( .D(n766), .CK(clk), .RN(n107), .Q(
        \string_buffer[30][6] ), .QN(n126) );
  DFFRX1 \string_buffer_reg[29][6]  ( .D(n758), .CK(clk), .RN(n790), .Q(
        \string_buffer[29][6] ), .QN(n134) );
  DFFRX1 \string_buffer_reg[12][6]  ( .D(n622), .CK(clk), .RN(n453), .Q(
        \string_buffer[12][6] ), .QN(n270) );
  DFFRX1 \string_buffer_reg[14][7]  ( .D(n639), .CK(clk), .RN(n109), .Q(
        \string_buffer[14][7] ), .QN(n253) );
  DFFRX1 \string_buffer_reg[11][6]  ( .D(n614), .CK(clk), .RN(n794), .Q(
        \string_buffer[11][6] ), .QN(n278) );
  DFFRX1 \string_buffer_reg[13][7]  ( .D(n631), .CK(clk), .RN(n791), .Q(
        \string_buffer[13][7] ), .QN(n261) );
  DFFRX1 \string_buffer_reg[4][6]  ( .D(n558), .CK(clk), .RN(n453), .Q(
        \string_buffer[4][6] ), .QN(n334) );
  DFFRX1 \string_buffer_reg[6][7]  ( .D(n575), .CK(clk), .RN(n109), .Q(
        \string_buffer[6][7] ), .QN(n317) );
  DFFRX1 \string_buffer_reg[3][6]  ( .D(n550), .CK(clk), .RN(n795), .Q(
        \string_buffer[3][6] ), .QN(n342) );
  DFFRX1 \string_buffer_reg[22][6]  ( .D(n702), .CK(clk), .RN(n107), .Q(
        \string_buffer[22][6] ), .QN(n190) );
  DFFRX1 \string_buffer_reg[5][7]  ( .D(n567), .CK(clk), .RN(n792), .Q(
        \string_buffer[5][7] ), .QN(n325) );
  DFFRX1 \string_buffer_reg[21][6]  ( .D(n694), .CK(clk), .RN(n791), .Q(
        \string_buffer[21][6] ), .QN(n198) );
  DFFRX1 \string_buffer_reg[14][6]  ( .D(n638), .CK(clk), .RN(n109), .Q(
        \string_buffer[14][6] ), .QN(n254) );
  DFFRX1 \string_buffer_reg[13][6]  ( .D(n630), .CK(clk), .RN(n791), .Q(
        \string_buffer[13][6] ), .QN(n262) );
  DFFRX1 \string_buffer_reg[6][6]  ( .D(n574), .CK(clk), .RN(n111), .Q(
        \string_buffer[6][6] ), .QN(n318) );
  DFFRX1 \string_buffer_reg[5][6]  ( .D(n566), .CK(clk), .RN(n792), .Q(
        \string_buffer[5][6] ), .QN(n326) );
  DFFRX1 \pattern_buffer_reg[5][7]  ( .D(n500), .CK(clk), .RN(n103), .Q(
        \pattern_buffer[5][7] ), .QN(n389) );
  DFFRX1 \pattern_buffer_reg[4][7]  ( .D(n492), .CK(clk), .RN(n103), .Q(
        \pattern_buffer[4][7] ), .QN(n397) );
  DFFRX1 \pattern_buffer_reg[7][7]  ( .D(n516), .CK(clk), .RN(n94), .Q(
        \pattern_buffer[7][7] ), .QN(n373) );
  DFFRX1 \pattern_buffer_reg[4][6]  ( .D(n491), .CK(clk), .RN(n105), .Q(
        \pattern_buffer[4][6] ), .QN(n398) );
  DFFRX1 \pattern_buffer_reg[5][6]  ( .D(n499), .CK(clk), .RN(n103), .Q(
        \pattern_buffer[5][6] ), .QN(n390) );
  DFFRX1 \pattern_buffer_reg[7][6]  ( .D(n515), .CK(clk), .RN(n94), .Q(
        \pattern_buffer[7][6] ), .QN(n374) );
  DFFRX1 \pattern_buffer_reg[6][7]  ( .D(n508), .CK(clk), .RN(n94), .Q(
        \pattern_buffer[6][7] ), .QN(n381) );
  DFFRX1 \pattern_buffer_reg[6][6]  ( .D(n507), .CK(clk), .RN(n94), .Q(
        \pattern_buffer[6][6] ), .QN(n382) );
  DFFRX1 \pattern_buffer_reg[3][7]  ( .D(n484), .CK(clk), .RN(n96), .Q(
        \pattern_buffer[3][7] ), .QN(n405) );
  DFFRX1 \pattern_buffer_reg[2][7]  ( .D(n476), .CK(clk), .RN(n98), .Q(
        \pattern_buffer[2][7] ), .QN(n413) );
  DFFRX1 \pattern_buffer_reg[2][6]  ( .D(n475), .CK(clk), .RN(n98), .Q(
        \pattern_buffer[2][6] ), .QN(n414) );
  DFFRX1 \pattern_buffer_reg[3][6]  ( .D(n483), .CK(clk), .RN(n96), .Q(
        \pattern_buffer[3][6] ), .QN(n406) );
  DFFRX1 \pattern_buffer_reg[7][4]  ( .D(n513), .CK(clk), .RN(n94), .Q(
        \pattern_buffer[7][4] ), .QN(n376) );
  DFFRX1 \pattern_buffer_reg[5][4]  ( .D(n497), .CK(clk), .RN(n103), .Q(
        \pattern_buffer[5][4] ), .QN(n392) );
  DFFRX1 \pattern_buffer_reg[0][6]  ( .D(n459), .CK(clk), .RN(n101), .Q(
        \pattern_buffer[0][6] ), .QN(n430) );
  DFFRX1 \pattern_buffer_reg[7][0]  ( .D(n517), .CK(clk), .RN(n94), .Q(
        \pattern_buffer[7][0] ), .QN(n372) );
  DFFRX1 \pattern_buffer_reg[0][7]  ( .D(n460), .CK(clk), .RN(n101), .Q(
        \pattern_buffer[0][7] ), .QN(n429) );
  DFFRX1 \pattern_buffer_reg[5][0]  ( .D(n501), .CK(clk), .RN(n103), .Q(
        \pattern_buffer[5][0] ), .QN(n388) );
  DFFRX1 \pattern_buffer_reg[4][4]  ( .D(n489), .CK(clk), .RN(n105), .Q(
        \pattern_buffer[4][4] ), .QN(n400) );
  DFFRX1 \pattern_buffer_reg[6][4]  ( .D(n505), .CK(clk), .RN(n96), .Q(
        \pattern_buffer[6][4] ), .QN(n384) );
  DFFRX1 \pattern_buffer_reg[4][0]  ( .D(n493), .CK(clk), .RN(n103), .Q(
        \pattern_buffer[4][0] ), .QN(n396) );
  DFFRX1 \pattern_buffer_reg[6][0]  ( .D(n509), .CK(clk), .RN(n94), .Q(
        \pattern_buffer[6][0] ), .QN(n380) );
  DFFRX1 \pattern_buffer_reg[3][0]  ( .D(n485), .CK(clk), .RN(n96), .Q(
        \pattern_buffer[3][0] ), .QN(n404) );
  DFFRX1 \pattern_buffer_reg[3][4]  ( .D(n481), .CK(clk), .RN(n96), .Q(
        \pattern_buffer[3][4] ), .QN(n408) );
  DFFRX1 \pattern_buffer_reg[0][4]  ( .D(n457), .CK(clk), .RN(n101), .Q(
        \pattern_buffer[0][4] ), .QN(n432) );
  DFFRX1 \pattern_buffer_reg[2][4]  ( .D(n473), .CK(clk), .RN(n98), .Q(
        \pattern_buffer[2][4] ), .QN(n416) );
  DFFRX1 \pattern_buffer_reg[2][0]  ( .D(n477), .CK(clk), .RN(n98), .Q(
        \pattern_buffer[2][0] ), .QN(n412) );
  DFFRX1 \pattern_buffer_reg[0][0]  ( .D(n461), .CK(clk), .RN(n101), .Q(
        \pattern_buffer[0][0] ), .QN(n428) );
  DFFRX1 \pattern_buffer_reg[7][5]  ( .D(n514), .CK(clk), .RN(n94), .Q(
        \pattern_buffer[7][5] ), .QN(n375) );
  DFFRX1 \pattern_buffer_reg[7][3]  ( .D(n512), .CK(clk), .RN(n94), .Q(
        \pattern_buffer[7][3] ), .QN(n377) );
  DFFRX1 \pattern_buffer_reg[7][1]  ( .D(n510), .CK(clk), .RN(n94), .Q(
        \pattern_buffer[7][1] ), .QN(n379) );
  DFFRX1 \pattern_buffer_reg[5][5]  ( .D(n498), .CK(clk), .RN(n103), .Q(
        \pattern_buffer[5][5] ), .QN(n391) );
  DFFRX1 \pattern_buffer_reg[5][3]  ( .D(n496), .CK(clk), .RN(n103), .Q(
        \pattern_buffer[5][3] ), .QN(n393) );
  DFFRX1 \pattern_buffer_reg[5][1]  ( .D(n494), .CK(clk), .RN(n103), .Q(
        \pattern_buffer[5][1] ), .QN(n395) );
  DFFRX1 \pattern_buffer_reg[4][5]  ( .D(n490), .CK(clk), .RN(n105), .Q(
        \pattern_buffer[4][5] ), .QN(n399) );
  DFFRX1 \pattern_buffer_reg[4][3]  ( .D(n488), .CK(clk), .RN(n105), .Q(
        \pattern_buffer[4][3] ), .QN(n401) );
  DFFRX1 \pattern_buffer_reg[4][1]  ( .D(n486), .CK(clk), .RN(n105), .Q(
        \pattern_buffer[4][1] ), .QN(n403) );
  DFFRX1 \pattern_buffer_reg[6][5]  ( .D(n506), .CK(clk), .RN(n94), .Q(
        \pattern_buffer[6][5] ), .QN(n383) );
  DFFRX1 \pattern_buffer_reg[6][3]  ( .D(n504), .CK(clk), .RN(n96), .Q(
        \pattern_buffer[6][3] ), .QN(n385) );
  DFFRX1 \pattern_buffer_reg[6][1]  ( .D(n502), .CK(clk), .RN(n96), .Q(
        \pattern_buffer[6][1] ), .QN(n387) );
  DFFRX1 \pattern_buffer_reg[7][2]  ( .D(n511), .CK(clk), .RN(n94), .Q(
        \pattern_buffer[7][2] ), .QN(n378) );
  DFFRX1 \pattern_buffer_reg[3][5]  ( .D(n482), .CK(clk), .RN(n96), .Q(
        \pattern_buffer[3][5] ), .QN(n407) );
  DFFRX1 \pattern_buffer_reg[3][3]  ( .D(n480), .CK(clk), .RN(n96), .Q(
        \pattern_buffer[3][3] ), .QN(n409) );
  DFFRX1 \pattern_buffer_reg[5][2]  ( .D(n495), .CK(clk), .RN(n103), .Q(
        \pattern_buffer[5][2] ), .QN(n394) );
  DFFRX1 \pattern_buffer_reg[3][1]  ( .D(n478), .CK(clk), .RN(n96), .Q(
        \pattern_buffer[3][1] ), .QN(n411) );
  DFFRX1 \pattern_buffer_reg[1][5]  ( .D(n466), .CK(clk), .RN(n98), .Q(
        \pattern_buffer[1][5] ), .QN(n423) );
  DFFRX1 \pattern_buffer_reg[1][3]  ( .D(n464), .CK(clk), .RN(n101), .Q(
        \pattern_buffer[1][3] ), .QN(n425) );
  DFFRX1 \pattern_buffer_reg[4][2]  ( .D(n487), .CK(clk), .RN(n105), .Q(
        \pattern_buffer[4][2] ), .QN(n402) );
  DFFRX1 \pattern_buffer_reg[0][3]  ( .D(n456), .CK(clk), .RN(n101), .Q(
        \pattern_buffer[0][3] ), .QN(n433) );
  DFFRX1 \pattern_buffer_reg[2][5]  ( .D(n474), .CK(clk), .RN(n98), .Q(
        \pattern_buffer[2][5] ), .QN(n415) );
  DFFRX1 \pattern_buffer_reg[2][3]  ( .D(n472), .CK(clk), .RN(n98), .Q(
        \pattern_buffer[2][3] ), .QN(n417) );
  DFFRX1 \pattern_buffer_reg[0][1]  ( .D(n454), .CK(clk), .RN(n101), .Q(
        \pattern_buffer[0][1] ), .QN(n435) );
  DFFRX1 \pattern_buffer_reg[2][1]  ( .D(n470), .CK(clk), .RN(n98), .Q(
        \pattern_buffer[2][1] ), .QN(n419) );
  DFFRX1 \pattern_buffer_reg[6][2]  ( .D(n503), .CK(clk), .RN(n96), .Q(
        \pattern_buffer[6][2] ), .QN(n386) );
  DFFRX1 \pattern_buffer_reg[0][5]  ( .D(n458), .CK(clk), .RN(n101), .Q(
        \pattern_buffer[0][5] ), .QN(n431) );
  DFFRX1 \pattern_buffer_reg[3][2]  ( .D(n479), .CK(clk), .RN(n96), .Q(
        \pattern_buffer[3][2] ), .QN(n410) );
  DFFRX1 \pattern_buffer_reg[0][2]  ( .D(n455), .CK(clk), .RN(n101), .Q(
        \pattern_buffer[0][2] ), .QN(n434) );
  DFFRX1 \pattern_buffer_reg[2][2]  ( .D(n471), .CK(clk), .RN(n98), .Q(
        \pattern_buffer[2][2] ), .QN(n418) );
  DFFRX1 \temp_read_string_count_reg[4]  ( .D(n777), .CK(clk), .RN(n798), .Q(
        temp_read_string_count[4]) );
  DFFRX1 \temp_read_pattern_count_reg[2]  ( .D(n518), .CK(clk), .RN(n103), .Q(
        temp_read_pattern_count[2]), .QN(n867) );
  DFFRX1 \temp_read_string_count_reg[3]  ( .D(n778), .CK(clk), .RN(n798), .Q(
        temp_read_string_count[3]), .QN(n1) );
  DFFRX1 \pattern_buffer_reg[1][7]  ( .D(n468), .CK(clk), .RN(n98), .Q(
        \pattern_buffer[1][7] ), .QN(n421) );
  DFFRX1 \pattern_buffer_reg[1][6]  ( .D(n467), .CK(clk), .RN(n98), .Q(
        \pattern_buffer[1][6] ), .QN(n422) );
  DFFRX1 \pattern_buffer_reg[1][4]  ( .D(n465), .CK(clk), .RN(n101), .Q(
        \pattern_buffer[1][4] ), .QN(n424) );
  DFFRX1 \pattern_buffer_reg[1][0]  ( .D(n469), .CK(clk), .RN(n98), .Q(
        \pattern_buffer[1][0] ), .QN(n420) );
  DFFRX1 \pattern_buffer_reg[1][1]  ( .D(n462), .CK(clk), .RN(n101), .Q(
        \pattern_buffer[1][1] ), .QN(n427) );
  DFFRX1 \pattern_buffer_reg[1][2]  ( .D(n463), .CK(clk), .RN(n101), .Q(
        \pattern_buffer[1][2] ), .QN(n426) );
  DFFRX1 \temp_read_string_count_reg[2]  ( .D(n779), .CK(clk), .RN(n868), .Q(
        temp_read_string_count[2]), .QN(n857) );
  DFFRX1 \temp_read_string_count_reg[1]  ( .D(n780), .CK(clk), .RN(n868), .Q(
        temp_read_string_count[1]), .QN(n856) );
  DFFRX1 \temp_read_string_count_reg[0]  ( .D(n781), .CK(clk), .RN(n798), .Q(
        temp_read_string_count[0]), .QN(N110) );
  DFFRX1 \temp_read_pattern_count_reg[1]  ( .D(n519), .CK(clk), .RN(n105), .Q(
        n436), .QN(n866) );
  DFFRX1 \read_pattern_count_reg[2]  ( .D(n445), .CK(clk), .RN(n868), .Q(
        read_pattern_count[2]), .QN(n444) );
  DFFRX2 \read_pattern_count_reg[1]  ( .D(n446), .CK(clk), .RN(n105), .Q(
        read_pattern_count[1]), .QN(n443) );
  CLKINVX1 U3 ( .A(isstring), .Y(n877) );
  INVX3 U4 ( .A(reset), .Y(n868) );
  NOR3X1 U5 ( .A(n856), .B(n857), .C(N110), .Y(n63) );
  NOR2X2 U6 ( .A(n5), .B(temp_read_string_count[3]), .Y(n83) );
  NOR3X2 U7 ( .A(temp_read_string_count[3]), .B(temp_read_string_count[4]), 
        .C(n877), .Y(n42) );
  NOR3X2 U8 ( .A(n877), .B(temp_read_string_count[4]), .C(n1), .Y(n66) );
  NAND2X1 U9 ( .A(temp_read_pattern_count[0]), .B(ispattern), .Y(n4) );
  NAND2X1 U10 ( .A(ispattern), .B(n2), .Y(n21) );
  CLKINVX1 U11 ( .A(chardata[0]), .Y(n876) );
  CLKINVX1 U12 ( .A(chardata[7]), .Y(n869) );
  CLKINVX1 U13 ( .A(chardata[6]), .Y(n870) );
  CLKINVX1 U14 ( .A(chardata[5]), .Y(n871) );
  CLKINVX1 U15 ( .A(chardata[4]), .Y(n872) );
  CLKINVX1 U16 ( .A(chardata[3]), .Y(n873) );
  CLKINVX1 U17 ( .A(chardata[2]), .Y(n874) );
  CLKINVX1 U18 ( .A(chardata[1]), .Y(n875) );
  NOR3X1 U19 ( .A(n856), .B(temp_read_string_count[2]), .C(N110), .Y(n51) );
  NOR3X1 U20 ( .A(temp_read_string_count[1]), .B(temp_read_string_count[2]), 
        .C(N110), .Y(n45) );
  NOR3X1 U21 ( .A(n857), .B(temp_read_string_count[1]), .C(N110), .Y(n57) );
  NOR3X1 U22 ( .A(temp_read_string_count[0]), .B(temp_read_string_count[1]), 
        .C(n857), .Y(n54) );
  NOR3X1 U23 ( .A(n857), .B(temp_read_string_count[0]), .C(n856), .Y(n60) );
  NOR3X1 U24 ( .A(temp_read_string_count[0]), .B(temp_read_string_count[2]), 
        .C(n856), .Y(n48) );
  NOR3X1 U25 ( .A(temp_read_string_count[1]), .B(temp_read_string_count[2]), 
        .C(temp_read_string_count[0]), .Y(n41) );
  INVX3 U26 ( .A(n3), .Y(n836) );
  CLKBUFX3 U27 ( .A(n92), .Y(n94) );
  CLKBUFX3 U28 ( .A(n92), .Y(n96) );
  CLKBUFX3 U29 ( .A(n807), .Y(n98) );
  CLKBUFX3 U30 ( .A(n807), .Y(n101) );
  CLKBUFX3 U31 ( .A(n90), .Y(n103) );
  CLKBUFX3 U32 ( .A(n804), .Y(n105) );
  CLKBUFX3 U33 ( .A(n806), .Y(n107) );
  CLKBUFX3 U34 ( .A(n806), .Y(n109) );
  CLKBUFX3 U35 ( .A(n805), .Y(n111) );
  CLKBUFX3 U36 ( .A(n805), .Y(n113) );
  CLKBUFX3 U37 ( .A(n804), .Y(n453) );
  CLKBUFX3 U38 ( .A(n804), .Y(n782) );
  CLKBUFX3 U39 ( .A(n803), .Y(n783) );
  CLKBUFX3 U40 ( .A(n803), .Y(n784) );
  CLKBUFX3 U41 ( .A(n88), .Y(n785) );
  CLKBUFX3 U42 ( .A(n806), .Y(n786) );
  CLKBUFX3 U43 ( .A(n86), .Y(n787) );
  CLKBUFX3 U44 ( .A(n803), .Y(n788) );
  CLKBUFX3 U45 ( .A(n802), .Y(n789) );
  CLKBUFX3 U46 ( .A(n802), .Y(n790) );
  CLKBUFX3 U47 ( .A(n801), .Y(n791) );
  CLKBUFX3 U48 ( .A(n801), .Y(n792) );
  CLKBUFX3 U49 ( .A(n800), .Y(n793) );
  CLKBUFX3 U50 ( .A(n800), .Y(n794) );
  CLKBUFX3 U51 ( .A(n799), .Y(n795) );
  CLKBUFX3 U52 ( .A(n799), .Y(n796) );
  CLKBUFX3 U53 ( .A(n84), .Y(n797) );
  CLKBUFX3 U54 ( .A(n805), .Y(n798) );
  INVX3 U55 ( .A(n46), .Y(n855) );
  INVX3 U56 ( .A(n52), .Y(n851) );
  INVX3 U57 ( .A(n58), .Y(n847) );
  INVX3 U58 ( .A(n64), .Y(n843) );
  INVX3 U59 ( .A(n43), .Y(n839) );
  INVX3 U60 ( .A(n49), .Y(n835) );
  INVX3 U61 ( .A(n55), .Y(n831) );
  INVX3 U62 ( .A(n61), .Y(n827) );
  INVX3 U63 ( .A(n27), .Y(n854) );
  INVX3 U64 ( .A(n31), .Y(n850) );
  INVX3 U65 ( .A(n35), .Y(n846) );
  INVX3 U66 ( .A(n39), .Y(n842) );
  INVX3 U67 ( .A(n25), .Y(n838) );
  INVX3 U68 ( .A(n29), .Y(n834) );
  INVX3 U69 ( .A(n33), .Y(n830) );
  INVX3 U70 ( .A(n38), .Y(n826) );
  INVX3 U71 ( .A(n6), .Y(n852) );
  INVX3 U72 ( .A(n15), .Y(n853) );
  INVX3 U73 ( .A(n8), .Y(n848) );
  INVX3 U74 ( .A(n17), .Y(n849) );
  INVX3 U75 ( .A(n10), .Y(n844) );
  INVX3 U76 ( .A(n19), .Y(n845) );
  INVX3 U77 ( .A(n13), .Y(n840) );
  INVX3 U78 ( .A(n23), .Y(n841) );
  INVX3 U79 ( .A(n14), .Y(n837) );
  INVX3 U80 ( .A(n7), .Y(n832) );
  INVX3 U81 ( .A(n16), .Y(n833) );
  INVX3 U82 ( .A(n9), .Y(n828) );
  INVX3 U83 ( .A(n18), .Y(n829) );
  INVX3 U84 ( .A(n12), .Y(n824) );
  INVX3 U85 ( .A(n20), .Y(n825) );
  CLKBUFX3 U86 ( .A(n114), .Y(n3) );
  NAND2X1 U87 ( .A(n100), .B(n63), .Y(n114) );
  INVX3 U88 ( .A(n69), .Y(n863) );
  INVX3 U89 ( .A(n71), .Y(n858) );
  CLKBUFX3 U90 ( .A(n92), .Y(n807) );
  CLKBUFX3 U91 ( .A(n90), .Y(n806) );
  CLKBUFX3 U92 ( .A(n90), .Y(n805) );
  CLKBUFX3 U93 ( .A(n88), .Y(n804) );
  CLKBUFX3 U94 ( .A(n88), .Y(n803) );
  CLKBUFX3 U95 ( .A(n86), .Y(n802) );
  CLKBUFX3 U96 ( .A(n86), .Y(n801) );
  CLKBUFX3 U97 ( .A(n84), .Y(n800) );
  CLKBUFX3 U98 ( .A(n84), .Y(n799) );
  CLKBUFX3 U99 ( .A(n59), .Y(n46) );
  NAND2X1 U100 ( .A(n60), .B(n42), .Y(n59) );
  CLKBUFX3 U101 ( .A(n53), .Y(n52) );
  NAND2X1 U102 ( .A(n54), .B(n42), .Y(n53) );
  CLKBUFX3 U103 ( .A(n47), .Y(n58) );
  NAND2X1 U104 ( .A(n48), .B(n42), .Y(n47) );
  CLKBUFX3 U105 ( .A(n40), .Y(n64) );
  NAND2X1 U106 ( .A(n41), .B(n42), .Y(n40) );
  CLKBUFX3 U107 ( .A(n62), .Y(n43) );
  NAND2X1 U108 ( .A(n63), .B(n42), .Y(n62) );
  CLKBUFX3 U109 ( .A(n56), .Y(n49) );
  NAND2X1 U110 ( .A(n57), .B(n42), .Y(n56) );
  CLKBUFX3 U111 ( .A(n50), .Y(n55) );
  NAND2X1 U112 ( .A(n51), .B(n42), .Y(n50) );
  CLKBUFX3 U113 ( .A(n44), .Y(n61) );
  NAND2X1 U114 ( .A(n45), .B(n42), .Y(n44) );
  CLKBUFX3 U115 ( .A(n78), .Y(n27) );
  NAND2X1 U116 ( .A(n66), .B(n60), .Y(n78) );
  CLKBUFX3 U117 ( .A(n74), .Y(n31) );
  NAND2X1 U118 ( .A(n66), .B(n54), .Y(n74) );
  CLKBUFX3 U119 ( .A(n70), .Y(n35) );
  NAND2X1 U120 ( .A(n66), .B(n48), .Y(n70) );
  CLKBUFX3 U121 ( .A(n65), .Y(n39) );
  NAND2X1 U122 ( .A(n66), .B(n41), .Y(n65) );
  CLKBUFX3 U123 ( .A(n80), .Y(n25) );
  NAND2X1 U124 ( .A(n66), .B(n63), .Y(n80) );
  CLKBUFX3 U125 ( .A(n76), .Y(n29) );
  NAND2X1 U126 ( .A(n66), .B(n57), .Y(n76) );
  CLKBUFX3 U127 ( .A(n72), .Y(n33) );
  NAND2X1 U128 ( .A(n66), .B(n51), .Y(n72) );
  CLKBUFX3 U129 ( .A(n68), .Y(n38) );
  NAND2X1 U130 ( .A(n66), .B(n45), .Y(n68) );
  NOR2X2 U131 ( .A(n5), .B(n1), .Y(n100) );
  CLKBUFX3 U132 ( .A(n112), .Y(n6) );
  NAND2X1 U133 ( .A(n100), .B(n60), .Y(n112) );
  CLKBUFX3 U134 ( .A(n95), .Y(n15) );
  NAND2X1 U135 ( .A(n83), .B(n60), .Y(n95) );
  CLKBUFX3 U136 ( .A(n108), .Y(n8) );
  NAND2X1 U137 ( .A(n100), .B(n54), .Y(n108) );
  CLKBUFX3 U138 ( .A(n91), .Y(n17) );
  NAND2X1 U139 ( .A(n83), .B(n54), .Y(n91) );
  CLKBUFX3 U140 ( .A(n104), .Y(n10) );
  NAND2X1 U141 ( .A(n100), .B(n48), .Y(n104) );
  CLKBUFX3 U142 ( .A(n87), .Y(n19) );
  NAND2X1 U143 ( .A(n83), .B(n48), .Y(n87) );
  CLKBUFX3 U144 ( .A(n99), .Y(n13) );
  NAND2X1 U145 ( .A(n100), .B(n41), .Y(n99) );
  CLKBUFX3 U146 ( .A(n82), .Y(n23) );
  NAND2X1 U147 ( .A(n83), .B(n41), .Y(n82) );
  CLKBUFX3 U148 ( .A(n97), .Y(n14) );
  NAND2X1 U149 ( .A(n83), .B(n63), .Y(n97) );
  CLKBUFX3 U150 ( .A(n110), .Y(n7) );
  NAND2X1 U151 ( .A(n100), .B(n57), .Y(n110) );
  CLKBUFX3 U152 ( .A(n93), .Y(n16) );
  NAND2X1 U153 ( .A(n83), .B(n57), .Y(n93) );
  CLKBUFX3 U154 ( .A(n106), .Y(n9) );
  NAND2X1 U155 ( .A(n100), .B(n51), .Y(n106) );
  CLKBUFX3 U156 ( .A(n89), .Y(n18) );
  NAND2X1 U157 ( .A(n83), .B(n51), .Y(n89) );
  CLKBUFX3 U158 ( .A(n102), .Y(n12) );
  NAND2X1 U159 ( .A(n100), .B(n45), .Y(n102) );
  CLKBUFX3 U160 ( .A(n85), .Y(n20) );
  NAND2X1 U161 ( .A(n83), .B(n45), .Y(n85) );
  CLKBUFX3 U162 ( .A(n34), .Y(n69) );
  NOR3X1 U163 ( .A(n866), .B(n867), .C(n4), .Y(n34) );
  INVX3 U164 ( .A(n79), .Y(n865) );
  INVX3 U165 ( .A(n73), .Y(n864) );
  INVX3 U166 ( .A(n81), .Y(n861) );
  INVX3 U167 ( .A(n77), .Y(n860) );
  CLKBUFX3 U168 ( .A(n32), .Y(n71) );
  NOR3X1 U169 ( .A(n866), .B(n867), .C(n21), .Y(n32) );
  INVX3 U170 ( .A(n75), .Y(n859) );
  INVX3 U171 ( .A(n67), .Y(n862) );
  CLKBUFX3 U172 ( .A(n876), .Y(n823) );
  CLKBUFX3 U173 ( .A(n869), .Y(n809) );
  CLKBUFX3 U174 ( .A(n870), .Y(n811) );
  CLKBUFX3 U175 ( .A(n871), .Y(n813) );
  CLKBUFX3 U176 ( .A(n872), .Y(n815) );
  CLKBUFX3 U177 ( .A(n873), .Y(n817) );
  CLKBUFX3 U178 ( .A(n874), .Y(n819) );
  CLKBUFX3 U179 ( .A(n875), .Y(n821) );
  CLKBUFX3 U180 ( .A(n876), .Y(n822) );
  CLKBUFX3 U181 ( .A(n869), .Y(n808) );
  CLKBUFX3 U182 ( .A(n870), .Y(n810) );
  CLKBUFX3 U183 ( .A(n871), .Y(n812) );
  CLKBUFX3 U184 ( .A(n872), .Y(n814) );
  CLKBUFX3 U185 ( .A(n873), .Y(n816) );
  CLKBUFX3 U186 ( .A(n874), .Y(n818) );
  CLKBUFX3 U187 ( .A(n875), .Y(n820) );
  CLKBUFX3 U188 ( .A(n868), .Y(n90) );
  CLKBUFX3 U189 ( .A(n868), .Y(n88) );
  CLKBUFX3 U190 ( .A(n868), .Y(n86) );
  CLKBUFX3 U191 ( .A(n868), .Y(n84) );
  CLKBUFX3 U192 ( .A(n868), .Y(n92) );
  OAI22XL U193 ( .A0(n855), .A1(n316), .B0(n822), .B1(n46), .Y(n576) );
  OAI22XL U194 ( .A0(n855), .A1(n317), .B0(n808), .B1(n46), .Y(n575) );
  OAI22XL U195 ( .A0(n855), .A1(n318), .B0(n810), .B1(n46), .Y(n574) );
  OAI22XL U196 ( .A0(n855), .A1(n319), .B0(n812), .B1(n46), .Y(n573) );
  OAI22XL U197 ( .A0(n855), .A1(n320), .B0(n814), .B1(n46), .Y(n572) );
  OAI22XL U198 ( .A0(n855), .A1(n321), .B0(n816), .B1(n46), .Y(n571) );
  OAI22XL U199 ( .A0(n855), .A1(n322), .B0(n818), .B1(n46), .Y(n570) );
  OAI22XL U200 ( .A0(n855), .A1(n323), .B0(n820), .B1(n46), .Y(n569) );
  OAI22XL U201 ( .A0(n851), .A1(n332), .B0(n823), .B1(n52), .Y(n560) );
  OAI22XL U202 ( .A0(n851), .A1(n333), .B0(n809), .B1(n52), .Y(n559) );
  OAI22XL U203 ( .A0(n851), .A1(n334), .B0(n811), .B1(n52), .Y(n558) );
  OAI22XL U204 ( .A0(n851), .A1(n335), .B0(n813), .B1(n52), .Y(n557) );
  OAI22XL U205 ( .A0(n851), .A1(n336), .B0(n815), .B1(n52), .Y(n556) );
  OAI22XL U206 ( .A0(n851), .A1(n337), .B0(n817), .B1(n52), .Y(n555) );
  OAI22XL U207 ( .A0(n851), .A1(n338), .B0(n819), .B1(n52), .Y(n554) );
  OAI22XL U208 ( .A0(n851), .A1(n339), .B0(n821), .B1(n52), .Y(n553) );
  OAI22XL U209 ( .A0(n847), .A1(n348), .B0(n823), .B1(n58), .Y(n544) );
  OAI22XL U210 ( .A0(n847), .A1(n349), .B0(n809), .B1(n58), .Y(n543) );
  OAI22XL U211 ( .A0(n847), .A1(n350), .B0(n811), .B1(n58), .Y(n542) );
  OAI22XL U212 ( .A0(n847), .A1(n351), .B0(n813), .B1(n58), .Y(n541) );
  OAI22XL U213 ( .A0(n847), .A1(n352), .B0(n815), .B1(n58), .Y(n540) );
  OAI22XL U214 ( .A0(n847), .A1(n353), .B0(n817), .B1(n58), .Y(n539) );
  OAI22XL U215 ( .A0(n847), .A1(n354), .B0(n819), .B1(n58), .Y(n538) );
  OAI22XL U216 ( .A0(n847), .A1(n355), .B0(n821), .B1(n58), .Y(n537) );
  OAI22XL U217 ( .A0(n843), .A1(n364), .B0(n823), .B1(n64), .Y(n528) );
  OAI22XL U218 ( .A0(n843), .A1(n365), .B0(n809), .B1(n64), .Y(n527) );
  OAI22XL U219 ( .A0(n843), .A1(n366), .B0(n811), .B1(n64), .Y(n526) );
  OAI22XL U220 ( .A0(n843), .A1(n367), .B0(n813), .B1(n64), .Y(n525) );
  OAI22XL U221 ( .A0(n843), .A1(n368), .B0(n815), .B1(n64), .Y(n524) );
  OAI22XL U222 ( .A0(n843), .A1(n369), .B0(n817), .B1(n64), .Y(n523) );
  OAI22XL U223 ( .A0(n843), .A1(n370), .B0(n819), .B1(n64), .Y(n522) );
  OAI22XL U224 ( .A0(n843), .A1(n371), .B0(n821), .B1(n64), .Y(n521) );
  OAI22XL U225 ( .A0(n839), .A1(n308), .B0(n822), .B1(n43), .Y(n584) );
  OAI22XL U226 ( .A0(n839), .A1(n309), .B0(n808), .B1(n43), .Y(n583) );
  OAI22XL U227 ( .A0(n839), .A1(n310), .B0(n810), .B1(n43), .Y(n582) );
  OAI22XL U228 ( .A0(n839), .A1(n311), .B0(n812), .B1(n43), .Y(n581) );
  OAI22XL U229 ( .A0(n839), .A1(n312), .B0(n814), .B1(n43), .Y(n580) );
  OAI22XL U230 ( .A0(n839), .A1(n313), .B0(n816), .B1(n43), .Y(n579) );
  OAI22XL U231 ( .A0(n839), .A1(n314), .B0(n818), .B1(n43), .Y(n578) );
  OAI22XL U232 ( .A0(n839), .A1(n315), .B0(n820), .B1(n43), .Y(n577) );
  OAI22XL U233 ( .A0(n835), .A1(n324), .B0(n823), .B1(n49), .Y(n568) );
  OAI22XL U234 ( .A0(n835), .A1(n325), .B0(n809), .B1(n49), .Y(n567) );
  OAI22XL U235 ( .A0(n835), .A1(n326), .B0(n811), .B1(n49), .Y(n566) );
  OAI22XL U236 ( .A0(n835), .A1(n327), .B0(n813), .B1(n49), .Y(n565) );
  OAI22XL U237 ( .A0(n835), .A1(n328), .B0(n815), .B1(n49), .Y(n564) );
  OAI22XL U238 ( .A0(n835), .A1(n329), .B0(n817), .B1(n49), .Y(n563) );
  OAI22XL U239 ( .A0(n835), .A1(n330), .B0(n819), .B1(n49), .Y(n562) );
  OAI22XL U240 ( .A0(n835), .A1(n331), .B0(n821), .B1(n49), .Y(n561) );
  OAI22XL U241 ( .A0(n831), .A1(n340), .B0(n823), .B1(n55), .Y(n552) );
  OAI22XL U242 ( .A0(n831), .A1(n341), .B0(n809), .B1(n55), .Y(n551) );
  OAI22XL U243 ( .A0(n831), .A1(n342), .B0(n811), .B1(n55), .Y(n550) );
  OAI22XL U244 ( .A0(n831), .A1(n343), .B0(n813), .B1(n55), .Y(n549) );
  OAI22XL U245 ( .A0(n831), .A1(n344), .B0(n815), .B1(n55), .Y(n548) );
  OAI22XL U246 ( .A0(n831), .A1(n345), .B0(n817), .B1(n55), .Y(n547) );
  OAI22XL U247 ( .A0(n831), .A1(n346), .B0(n819), .B1(n55), .Y(n546) );
  OAI22XL U248 ( .A0(n831), .A1(n347), .B0(n821), .B1(n55), .Y(n545) );
  OAI22XL U249 ( .A0(n827), .A1(n356), .B0(n823), .B1(n61), .Y(n536) );
  OAI22XL U250 ( .A0(n827), .A1(n357), .B0(n809), .B1(n61), .Y(n535) );
  OAI22XL U251 ( .A0(n827), .A1(n358), .B0(n811), .B1(n61), .Y(n534) );
  OAI22XL U252 ( .A0(n827), .A1(n359), .B0(n813), .B1(n61), .Y(n533) );
  OAI22XL U253 ( .A0(n827), .A1(n360), .B0(n815), .B1(n61), .Y(n532) );
  OAI22XL U254 ( .A0(n827), .A1(n361), .B0(n817), .B1(n61), .Y(n531) );
  OAI22XL U255 ( .A0(n827), .A1(n362), .B0(n819), .B1(n61), .Y(n530) );
  OAI22XL U256 ( .A0(n827), .A1(n363), .B0(n821), .B1(n61), .Y(n529) );
  OAI22XL U257 ( .A0(n854), .A1(n252), .B0(n823), .B1(n27), .Y(n640) );
  OAI22XL U258 ( .A0(n854), .A1(n253), .B0(n809), .B1(n27), .Y(n639) );
  OAI22XL U259 ( .A0(n854), .A1(n254), .B0(n811), .B1(n27), .Y(n638) );
  OAI22XL U260 ( .A0(n854), .A1(n255), .B0(n813), .B1(n27), .Y(n637) );
  OAI22XL U261 ( .A0(n854), .A1(n256), .B0(n815), .B1(n27), .Y(n636) );
  OAI22XL U262 ( .A0(n854), .A1(n257), .B0(n817), .B1(n27), .Y(n635) );
  OAI22XL U263 ( .A0(n854), .A1(n258), .B0(n819), .B1(n27), .Y(n634) );
  OAI22XL U264 ( .A0(n854), .A1(n259), .B0(n821), .B1(n27), .Y(n633) );
  OAI22XL U265 ( .A0(n850), .A1(n268), .B0(n822), .B1(n31), .Y(n624) );
  OAI22XL U266 ( .A0(n850), .A1(n269), .B0(n808), .B1(n31), .Y(n623) );
  OAI22XL U267 ( .A0(n850), .A1(n270), .B0(n810), .B1(n31), .Y(n622) );
  OAI22XL U268 ( .A0(n850), .A1(n271), .B0(n812), .B1(n31), .Y(n621) );
  OAI22XL U269 ( .A0(n850), .A1(n272), .B0(n814), .B1(n31), .Y(n620) );
  OAI22XL U270 ( .A0(n850), .A1(n273), .B0(n816), .B1(n31), .Y(n619) );
  OAI22XL U271 ( .A0(n850), .A1(n274), .B0(n818), .B1(n31), .Y(n618) );
  OAI22XL U272 ( .A0(n850), .A1(n275), .B0(n820), .B1(n31), .Y(n617) );
  OAI22XL U273 ( .A0(n846), .A1(n284), .B0(n823), .B1(n35), .Y(n608) );
  OAI22XL U274 ( .A0(n846), .A1(n285), .B0(n809), .B1(n35), .Y(n607) );
  OAI22XL U275 ( .A0(n846), .A1(n286), .B0(n811), .B1(n35), .Y(n606) );
  OAI22XL U276 ( .A0(n846), .A1(n287), .B0(n813), .B1(n35), .Y(n605) );
  OAI22XL U277 ( .A0(n846), .A1(n288), .B0(n815), .B1(n35), .Y(n604) );
  OAI22XL U278 ( .A0(n846), .A1(n289), .B0(n817), .B1(n35), .Y(n603) );
  OAI22XL U279 ( .A0(n846), .A1(n290), .B0(n819), .B1(n35), .Y(n602) );
  OAI22XL U280 ( .A0(n846), .A1(n291), .B0(n821), .B1(n35), .Y(n601) );
  OAI22XL U281 ( .A0(n842), .A1(n300), .B0(n876), .B1(n39), .Y(n592) );
  OAI22XL U282 ( .A0(n842), .A1(n301), .B0(n869), .B1(n39), .Y(n591) );
  OAI22XL U283 ( .A0(n842), .A1(n302), .B0(n870), .B1(n39), .Y(n590) );
  OAI22XL U284 ( .A0(n842), .A1(n303), .B0(n871), .B1(n39), .Y(n589) );
  OAI22XL U285 ( .A0(n842), .A1(n304), .B0(n872), .B1(n39), .Y(n588) );
  OAI22XL U286 ( .A0(n842), .A1(n305), .B0(n873), .B1(n39), .Y(n587) );
  OAI22XL U287 ( .A0(n842), .A1(n306), .B0(n874), .B1(n39), .Y(n586) );
  OAI22XL U288 ( .A0(n842), .A1(n307), .B0(n875), .B1(n39), .Y(n585) );
  OAI22XL U289 ( .A0(n838), .A1(n244), .B0(n876), .B1(n25), .Y(n648) );
  OAI22XL U290 ( .A0(n838), .A1(n245), .B0(n869), .B1(n25), .Y(n647) );
  OAI22XL U291 ( .A0(n838), .A1(n246), .B0(n870), .B1(n25), .Y(n646) );
  OAI22XL U292 ( .A0(n838), .A1(n247), .B0(n871), .B1(n25), .Y(n645) );
  OAI22XL U293 ( .A0(n838), .A1(n248), .B0(n872), .B1(n25), .Y(n644) );
  OAI22XL U294 ( .A0(n838), .A1(n249), .B0(n873), .B1(n25), .Y(n643) );
  OAI22XL U295 ( .A0(n838), .A1(n250), .B0(n874), .B1(n25), .Y(n642) );
  OAI22XL U296 ( .A0(n838), .A1(n251), .B0(n875), .B1(n25), .Y(n641) );
  OAI22XL U297 ( .A0(n834), .A1(n260), .B0(n876), .B1(n29), .Y(n632) );
  OAI22XL U298 ( .A0(n834), .A1(n261), .B0(n869), .B1(n29), .Y(n631) );
  OAI22XL U299 ( .A0(n834), .A1(n262), .B0(n870), .B1(n29), .Y(n630) );
  OAI22XL U300 ( .A0(n834), .A1(n263), .B0(n871), .B1(n29), .Y(n629) );
  OAI22XL U301 ( .A0(n834), .A1(n264), .B0(n872), .B1(n29), .Y(n628) );
  OAI22XL U302 ( .A0(n834), .A1(n265), .B0(n873), .B1(n29), .Y(n627) );
  OAI22XL U303 ( .A0(n834), .A1(n266), .B0(n874), .B1(n29), .Y(n626) );
  OAI22XL U304 ( .A0(n834), .A1(n267), .B0(n875), .B1(n29), .Y(n625) );
  OAI22XL U305 ( .A0(n830), .A1(n276), .B0(n876), .B1(n33), .Y(n616) );
  OAI22XL U306 ( .A0(n830), .A1(n277), .B0(n869), .B1(n33), .Y(n615) );
  OAI22XL U307 ( .A0(n830), .A1(n278), .B0(n870), .B1(n33), .Y(n614) );
  OAI22XL U308 ( .A0(n830), .A1(n279), .B0(n871), .B1(n33), .Y(n613) );
  OAI22XL U309 ( .A0(n830), .A1(n280), .B0(n872), .B1(n33), .Y(n612) );
  OAI22XL U310 ( .A0(n830), .A1(n281), .B0(n873), .B1(n33), .Y(n611) );
  OAI22XL U311 ( .A0(n830), .A1(n282), .B0(n874), .B1(n33), .Y(n610) );
  OAI22XL U312 ( .A0(n830), .A1(n283), .B0(n875), .B1(n33), .Y(n609) );
  OAI22XL U313 ( .A0(n826), .A1(n292), .B0(n876), .B1(n38), .Y(n600) );
  OAI22XL U314 ( .A0(n826), .A1(n293), .B0(n869), .B1(n38), .Y(n599) );
  OAI22XL U315 ( .A0(n826), .A1(n294), .B0(n870), .B1(n38), .Y(n598) );
  OAI22XL U316 ( .A0(n826), .A1(n295), .B0(n871), .B1(n38), .Y(n597) );
  OAI22XL U317 ( .A0(n826), .A1(n296), .B0(n872), .B1(n38), .Y(n596) );
  OAI22XL U318 ( .A0(n826), .A1(n297), .B0(n873), .B1(n38), .Y(n595) );
  OAI22XL U319 ( .A0(n826), .A1(n298), .B0(n874), .B1(n38), .Y(n594) );
  OAI22XL U320 ( .A0(n826), .A1(n299), .B0(n875), .B1(n38), .Y(n593) );
  NAND2X1 U321 ( .A(temp_read_string_count[4]), .B(isstring), .Y(n5) );
  OAI22XL U322 ( .A0(n852), .A1(n124), .B0(n822), .B1(n6), .Y(n768) );
  OAI22XL U323 ( .A0(n852), .A1(n125), .B0(n808), .B1(n6), .Y(n767) );
  OAI22XL U324 ( .A0(n852), .A1(n126), .B0(n810), .B1(n6), .Y(n766) );
  OAI22XL U325 ( .A0(n852), .A1(n127), .B0(n812), .B1(n6), .Y(n765) );
  OAI22XL U326 ( .A0(n852), .A1(n128), .B0(n814), .B1(n6), .Y(n764) );
  OAI22XL U327 ( .A0(n852), .A1(n129), .B0(n816), .B1(n6), .Y(n763) );
  OAI22XL U328 ( .A0(n852), .A1(n130), .B0(n818), .B1(n6), .Y(n762) );
  OAI22XL U329 ( .A0(n852), .A1(n131), .B0(n820), .B1(n6), .Y(n761) );
  OAI22XL U330 ( .A0(n853), .A1(n188), .B0(n822), .B1(n15), .Y(n704) );
  OAI22XL U331 ( .A0(n853), .A1(n189), .B0(n808), .B1(n15), .Y(n703) );
  OAI22XL U332 ( .A0(n853), .A1(n190), .B0(n810), .B1(n15), .Y(n702) );
  OAI22XL U333 ( .A0(n853), .A1(n191), .B0(n812), .B1(n15), .Y(n701) );
  OAI22XL U334 ( .A0(n853), .A1(n192), .B0(n814), .B1(n15), .Y(n700) );
  OAI22XL U335 ( .A0(n853), .A1(n193), .B0(n816), .B1(n15), .Y(n699) );
  OAI22XL U336 ( .A0(n853), .A1(n194), .B0(n818), .B1(n15), .Y(n698) );
  OAI22XL U337 ( .A0(n853), .A1(n195), .B0(n820), .B1(n15), .Y(n697) );
  OAI22XL U338 ( .A0(n848), .A1(n140), .B0(n822), .B1(n8), .Y(n752) );
  OAI22XL U339 ( .A0(n848), .A1(n141), .B0(n808), .B1(n8), .Y(n751) );
  OAI22XL U340 ( .A0(n848), .A1(n142), .B0(n810), .B1(n8), .Y(n750) );
  OAI22XL U341 ( .A0(n848), .A1(n143), .B0(n812), .B1(n8), .Y(n749) );
  OAI22XL U342 ( .A0(n848), .A1(n144), .B0(n814), .B1(n8), .Y(n748) );
  OAI22XL U343 ( .A0(n848), .A1(n145), .B0(n816), .B1(n8), .Y(n747) );
  OAI22XL U344 ( .A0(n848), .A1(n146), .B0(n818), .B1(n8), .Y(n746) );
  OAI22XL U345 ( .A0(n848), .A1(n147), .B0(n820), .B1(n8), .Y(n745) );
  OAI22XL U346 ( .A0(n849), .A1(n204), .B0(n822), .B1(n17), .Y(n688) );
  OAI22XL U347 ( .A0(n849), .A1(n205), .B0(n808), .B1(n17), .Y(n687) );
  OAI22XL U348 ( .A0(n849), .A1(n206), .B0(n810), .B1(n17), .Y(n686) );
  OAI22XL U349 ( .A0(n849), .A1(n207), .B0(n812), .B1(n17), .Y(n685) );
  OAI22XL U350 ( .A0(n849), .A1(n208), .B0(n814), .B1(n17), .Y(n684) );
  OAI22XL U351 ( .A0(n849), .A1(n209), .B0(n816), .B1(n17), .Y(n683) );
  OAI22XL U352 ( .A0(n849), .A1(n210), .B0(n818), .B1(n17), .Y(n682) );
  OAI22XL U353 ( .A0(n849), .A1(n211), .B0(n820), .B1(n17), .Y(n681) );
  OAI22XL U354 ( .A0(n844), .A1(n156), .B0(n822), .B1(n10), .Y(n736) );
  OAI22XL U355 ( .A0(n844), .A1(n157), .B0(n808), .B1(n10), .Y(n735) );
  OAI22XL U356 ( .A0(n844), .A1(n158), .B0(n810), .B1(n10), .Y(n734) );
  OAI22XL U357 ( .A0(n844), .A1(n159), .B0(n812), .B1(n10), .Y(n733) );
  OAI22XL U358 ( .A0(n844), .A1(n160), .B0(n814), .B1(n10), .Y(n732) );
  OAI22XL U359 ( .A0(n844), .A1(n161), .B0(n816), .B1(n10), .Y(n731) );
  OAI22XL U360 ( .A0(n844), .A1(n162), .B0(n818), .B1(n10), .Y(n730) );
  OAI22XL U361 ( .A0(n844), .A1(n163), .B0(n820), .B1(n10), .Y(n729) );
  OAI22XL U362 ( .A0(n845), .A1(n220), .B0(n822), .B1(n19), .Y(n672) );
  OAI22XL U363 ( .A0(n845), .A1(n221), .B0(n808), .B1(n19), .Y(n671) );
  OAI22XL U364 ( .A0(n845), .A1(n222), .B0(n810), .B1(n19), .Y(n670) );
  OAI22XL U365 ( .A0(n845), .A1(n223), .B0(n812), .B1(n19), .Y(n669) );
  OAI22XL U366 ( .A0(n845), .A1(n224), .B0(n814), .B1(n19), .Y(n668) );
  OAI22XL U367 ( .A0(n845), .A1(n225), .B0(n816), .B1(n19), .Y(n667) );
  OAI22XL U368 ( .A0(n845), .A1(n226), .B0(n818), .B1(n19), .Y(n666) );
  OAI22XL U369 ( .A0(n845), .A1(n227), .B0(n820), .B1(n19), .Y(n665) );
  OAI22XL U370 ( .A0(n840), .A1(n172), .B0(n822), .B1(n13), .Y(n720) );
  OAI22XL U371 ( .A0(n840), .A1(n173), .B0(n808), .B1(n13), .Y(n719) );
  OAI22XL U372 ( .A0(n840), .A1(n174), .B0(n810), .B1(n13), .Y(n718) );
  OAI22XL U373 ( .A0(n840), .A1(n175), .B0(n812), .B1(n13), .Y(n717) );
  OAI22XL U374 ( .A0(n840), .A1(n176), .B0(n814), .B1(n13), .Y(n716) );
  OAI22XL U375 ( .A0(n840), .A1(n177), .B0(n816), .B1(n13), .Y(n715) );
  OAI22XL U376 ( .A0(n840), .A1(n178), .B0(n818), .B1(n13), .Y(n714) );
  OAI22XL U377 ( .A0(n840), .A1(n179), .B0(n820), .B1(n13), .Y(n713) );
  OAI22XL U378 ( .A0(n841), .A1(n236), .B0(n823), .B1(n23), .Y(n656) );
  OAI22XL U379 ( .A0(n841), .A1(n237), .B0(n809), .B1(n23), .Y(n655) );
  OAI22XL U380 ( .A0(n841), .A1(n238), .B0(n811), .B1(n23), .Y(n654) );
  OAI22XL U381 ( .A0(n841), .A1(n239), .B0(n813), .B1(n23), .Y(n653) );
  OAI22XL U382 ( .A0(n841), .A1(n240), .B0(n815), .B1(n23), .Y(n652) );
  OAI22XL U383 ( .A0(n841), .A1(n241), .B0(n817), .B1(n23), .Y(n651) );
  OAI22XL U384 ( .A0(n841), .A1(n242), .B0(n819), .B1(n23), .Y(n650) );
  OAI22XL U385 ( .A0(n841), .A1(n243), .B0(n821), .B1(n23), .Y(n649) );
  OAI22XL U386 ( .A0(n836), .A1(n116), .B0(n822), .B1(n3), .Y(n776) );
  OAI22XL U387 ( .A0(n836), .A1(n117), .B0(n808), .B1(n3), .Y(n775) );
  OAI22XL U388 ( .A0(n836), .A1(n118), .B0(n810), .B1(n3), .Y(n774) );
  OAI22XL U389 ( .A0(n836), .A1(n119), .B0(n812), .B1(n3), .Y(n773) );
  OAI22XL U390 ( .A0(n836), .A1(n120), .B0(n814), .B1(n3), .Y(n772) );
  OAI22XL U391 ( .A0(n836), .A1(n121), .B0(n816), .B1(n3), .Y(n771) );
  OAI22XL U392 ( .A0(n836), .A1(n122), .B0(n818), .B1(n3), .Y(n770) );
  OAI22XL U393 ( .A0(n836), .A1(n123), .B0(n820), .B1(n3), .Y(n769) );
  OAI22XL U394 ( .A0(n837), .A1(n180), .B0(n822), .B1(n14), .Y(n712) );
  OAI22XL U395 ( .A0(n837), .A1(n181), .B0(n808), .B1(n14), .Y(n711) );
  OAI22XL U396 ( .A0(n837), .A1(n182), .B0(n810), .B1(n14), .Y(n710) );
  OAI22XL U397 ( .A0(n837), .A1(n183), .B0(n812), .B1(n14), .Y(n709) );
  OAI22XL U398 ( .A0(n837), .A1(n184), .B0(n814), .B1(n14), .Y(n708) );
  OAI22XL U399 ( .A0(n837), .A1(n185), .B0(n816), .B1(n14), .Y(n707) );
  OAI22XL U400 ( .A0(n837), .A1(n186), .B0(n818), .B1(n14), .Y(n706) );
  OAI22XL U401 ( .A0(n837), .A1(n187), .B0(n820), .B1(n14), .Y(n705) );
  OAI22XL U402 ( .A0(n832), .A1(n132), .B0(n822), .B1(n7), .Y(n760) );
  OAI22XL U403 ( .A0(n832), .A1(n133), .B0(n808), .B1(n7), .Y(n759) );
  OAI22XL U404 ( .A0(n832), .A1(n134), .B0(n810), .B1(n7), .Y(n758) );
  OAI22XL U405 ( .A0(n832), .A1(n135), .B0(n812), .B1(n7), .Y(n757) );
  OAI22XL U406 ( .A0(n832), .A1(n136), .B0(n814), .B1(n7), .Y(n756) );
  OAI22XL U407 ( .A0(n832), .A1(n137), .B0(n816), .B1(n7), .Y(n755) );
  OAI22XL U408 ( .A0(n832), .A1(n138), .B0(n818), .B1(n7), .Y(n754) );
  OAI22XL U409 ( .A0(n832), .A1(n139), .B0(n820), .B1(n7), .Y(n753) );
  OAI22XL U410 ( .A0(n833), .A1(n196), .B0(n822), .B1(n16), .Y(n696) );
  OAI22XL U411 ( .A0(n833), .A1(n197), .B0(n808), .B1(n16), .Y(n695) );
  OAI22XL U412 ( .A0(n833), .A1(n198), .B0(n810), .B1(n16), .Y(n694) );
  OAI22XL U413 ( .A0(n833), .A1(n199), .B0(n812), .B1(n16), .Y(n693) );
  OAI22XL U414 ( .A0(n833), .A1(n200), .B0(n814), .B1(n16), .Y(n692) );
  OAI22XL U415 ( .A0(n833), .A1(n201), .B0(n816), .B1(n16), .Y(n691) );
  OAI22XL U416 ( .A0(n833), .A1(n202), .B0(n818), .B1(n16), .Y(n690) );
  OAI22XL U417 ( .A0(n833), .A1(n203), .B0(n820), .B1(n16), .Y(n689) );
  OAI22XL U418 ( .A0(n828), .A1(n148), .B0(n822), .B1(n9), .Y(n744) );
  OAI22XL U419 ( .A0(n828), .A1(n149), .B0(n808), .B1(n9), .Y(n743) );
  OAI22XL U420 ( .A0(n828), .A1(n150), .B0(n810), .B1(n9), .Y(n742) );
  OAI22XL U421 ( .A0(n828), .A1(n151), .B0(n812), .B1(n9), .Y(n741) );
  OAI22XL U422 ( .A0(n828), .A1(n152), .B0(n814), .B1(n9), .Y(n740) );
  OAI22XL U423 ( .A0(n828), .A1(n153), .B0(n816), .B1(n9), .Y(n739) );
  OAI22XL U424 ( .A0(n828), .A1(n154), .B0(n818), .B1(n9), .Y(n738) );
  OAI22XL U425 ( .A0(n828), .A1(n155), .B0(n820), .B1(n9), .Y(n737) );
  OAI22XL U426 ( .A0(n829), .A1(n212), .B0(n822), .B1(n18), .Y(n680) );
  OAI22XL U427 ( .A0(n829), .A1(n213), .B0(n808), .B1(n18), .Y(n679) );
  OAI22XL U428 ( .A0(n829), .A1(n214), .B0(n810), .B1(n18), .Y(n678) );
  OAI22XL U429 ( .A0(n829), .A1(n215), .B0(n812), .B1(n18), .Y(n677) );
  OAI22XL U430 ( .A0(n829), .A1(n216), .B0(n814), .B1(n18), .Y(n676) );
  OAI22XL U431 ( .A0(n829), .A1(n217), .B0(n816), .B1(n18), .Y(n675) );
  OAI22XL U432 ( .A0(n829), .A1(n218), .B0(n818), .B1(n18), .Y(n674) );
  OAI22XL U433 ( .A0(n829), .A1(n219), .B0(n820), .B1(n18), .Y(n673) );
  OAI22XL U434 ( .A0(n824), .A1(n164), .B0(n822), .B1(n12), .Y(n728) );
  OAI22XL U435 ( .A0(n824), .A1(n165), .B0(n808), .B1(n12), .Y(n727) );
  OAI22XL U436 ( .A0(n824), .A1(n166), .B0(n810), .B1(n12), .Y(n726) );
  OAI22XL U437 ( .A0(n824), .A1(n167), .B0(n812), .B1(n12), .Y(n725) );
  OAI22XL U438 ( .A0(n824), .A1(n168), .B0(n814), .B1(n12), .Y(n724) );
  OAI22XL U439 ( .A0(n824), .A1(n169), .B0(n816), .B1(n12), .Y(n723) );
  OAI22XL U440 ( .A0(n824), .A1(n170), .B0(n818), .B1(n12), .Y(n722) );
  OAI22XL U441 ( .A0(n824), .A1(n171), .B0(n820), .B1(n12), .Y(n721) );
  OAI22XL U442 ( .A0(n825), .A1(n228), .B0(n822), .B1(n20), .Y(n664) );
  OAI22XL U443 ( .A0(n825), .A1(n229), .B0(n808), .B1(n20), .Y(n663) );
  OAI22XL U444 ( .A0(n825), .A1(n230), .B0(n810), .B1(n20), .Y(n662) );
  OAI22XL U445 ( .A0(n825), .A1(n231), .B0(n812), .B1(n20), .Y(n661) );
  OAI22XL U446 ( .A0(n825), .A1(n232), .B0(n814), .B1(n20), .Y(n660) );
  OAI22XL U447 ( .A0(n825), .A1(n233), .B0(n816), .B1(n20), .Y(n659) );
  OAI22XL U448 ( .A0(n825), .A1(n234), .B0(n818), .B1(n20), .Y(n658) );
  OAI22XL U449 ( .A0(n825), .A1(n235), .B0(n820), .B1(n20), .Y(n657) );
  OAI22XL U450 ( .A0(n69), .A1(n372), .B0(n823), .B1(n863), .Y(n517) );
  OAI22XL U451 ( .A0(n69), .A1(n373), .B0(n809), .B1(n863), .Y(n516) );
  OAI22XL U452 ( .A0(n69), .A1(n374), .B0(n811), .B1(n863), .Y(n515) );
  OAI22XL U453 ( .A0(n69), .A1(n375), .B0(n813), .B1(n863), .Y(n514) );
  OAI22XL U454 ( .A0(n69), .A1(n376), .B0(n815), .B1(n863), .Y(n513) );
  OAI22XL U455 ( .A0(n69), .A1(n377), .B0(n817), .B1(n863), .Y(n512) );
  OAI22XL U456 ( .A0(n69), .A1(n378), .B0(n819), .B1(n863), .Y(n511) );
  OAI22XL U457 ( .A0(n69), .A1(n379), .B0(n821), .B1(n863), .Y(n510) );
  OAI22XL U458 ( .A0(n79), .A1(n420), .B0(n823), .B1(n865), .Y(n469) );
  OAI22XL U459 ( .A0(n79), .A1(n421), .B0(n809), .B1(n865), .Y(n468) );
  OAI22XL U460 ( .A0(n79), .A1(n422), .B0(n811), .B1(n865), .Y(n467) );
  OAI22XL U461 ( .A0(n79), .A1(n423), .B0(n813), .B1(n865), .Y(n466) );
  OAI22XL U462 ( .A0(n79), .A1(n424), .B0(n815), .B1(n865), .Y(n465) );
  OAI22XL U463 ( .A0(n79), .A1(n425), .B0(n817), .B1(n865), .Y(n464) );
  OAI22XL U464 ( .A0(n79), .A1(n426), .B0(n819), .B1(n865), .Y(n463) );
  OAI22XL U465 ( .A0(n79), .A1(n427), .B0(n821), .B1(n865), .Y(n462) );
  CLKBUFX3 U466 ( .A(n22), .Y(n79) );
  NOR3X1 U467 ( .A(n436), .B(temp_read_pattern_count[2]), .C(n4), .Y(n22) );
  OAI22XL U468 ( .A0(n73), .A1(n388), .B0(n823), .B1(n864), .Y(n501) );
  OAI22XL U469 ( .A0(n73), .A1(n389), .B0(n809), .B1(n864), .Y(n500) );
  OAI22XL U470 ( .A0(n73), .A1(n390), .B0(n811), .B1(n864), .Y(n499) );
  OAI22XL U471 ( .A0(n73), .A1(n391), .B0(n813), .B1(n864), .Y(n498) );
  OAI22XL U472 ( .A0(n73), .A1(n392), .B0(n815), .B1(n864), .Y(n497) );
  OAI22XL U473 ( .A0(n73), .A1(n393), .B0(n817), .B1(n864), .Y(n496) );
  OAI22XL U474 ( .A0(n73), .A1(n394), .B0(n819), .B1(n864), .Y(n495) );
  OAI22XL U475 ( .A0(n73), .A1(n395), .B0(n821), .B1(n864), .Y(n494) );
  CLKBUFX3 U476 ( .A(n30), .Y(n73) );
  NOR3X1 U477 ( .A(n867), .B(n436), .C(n4), .Y(n30) );
  OAI22XL U478 ( .A0(n81), .A1(n428), .B0(n861), .B1(n823), .Y(n461) );
  OAI22XL U479 ( .A0(n81), .A1(n429), .B0(n861), .B1(n809), .Y(n460) );
  OAI22XL U480 ( .A0(n81), .A1(n430), .B0(n861), .B1(n811), .Y(n459) );
  OAI22XL U481 ( .A0(n81), .A1(n431), .B0(n861), .B1(n813), .Y(n458) );
  OAI22XL U482 ( .A0(n81), .A1(n432), .B0(n861), .B1(n815), .Y(n457) );
  OAI22XL U483 ( .A0(n81), .A1(n433), .B0(n861), .B1(n817), .Y(n456) );
  OAI22XL U484 ( .A0(n81), .A1(n434), .B0(n861), .B1(n819), .Y(n455) );
  OAI22XL U485 ( .A0(n81), .A1(n435), .B0(n861), .B1(n821), .Y(n454) );
  CLKBUFX3 U486 ( .A(n11), .Y(n81) );
  NOR3X1 U487 ( .A(n436), .B(temp_read_pattern_count[2]), .C(n21), .Y(n11) );
  OAI22XL U488 ( .A0(n71), .A1(n380), .B0(n823), .B1(n858), .Y(n509) );
  OAI22XL U489 ( .A0(n71), .A1(n381), .B0(n809), .B1(n858), .Y(n508) );
  OAI22XL U490 ( .A0(n71), .A1(n382), .B0(n811), .B1(n858), .Y(n507) );
  OAI22XL U491 ( .A0(n71), .A1(n383), .B0(n813), .B1(n858), .Y(n506) );
  OAI22XL U492 ( .A0(n71), .A1(n384), .B0(n815), .B1(n858), .Y(n505) );
  OAI22XL U493 ( .A0(n71), .A1(n385), .B0(n817), .B1(n858), .Y(n504) );
  OAI22XL U494 ( .A0(n71), .A1(n386), .B0(n819), .B1(n858), .Y(n503) );
  OAI22XL U495 ( .A0(n71), .A1(n387), .B0(n821), .B1(n858), .Y(n502) );
  OAI22XL U496 ( .A0(n77), .A1(n412), .B0(n823), .B1(n860), .Y(n477) );
  OAI22XL U497 ( .A0(n77), .A1(n413), .B0(n809), .B1(n860), .Y(n476) );
  OAI22XL U498 ( .A0(n77), .A1(n414), .B0(n811), .B1(n860), .Y(n475) );
  OAI22XL U499 ( .A0(n77), .A1(n415), .B0(n813), .B1(n860), .Y(n474) );
  OAI22XL U500 ( .A0(n77), .A1(n416), .B0(n815), .B1(n860), .Y(n473) );
  OAI22XL U501 ( .A0(n77), .A1(n417), .B0(n817), .B1(n860), .Y(n472) );
  OAI22XL U502 ( .A0(n77), .A1(n418), .B0(n819), .B1(n860), .Y(n471) );
  OAI22XL U503 ( .A0(n77), .A1(n419), .B0(n821), .B1(n860), .Y(n470) );
  CLKBUFX3 U504 ( .A(n24), .Y(n77) );
  NOR3X1 U505 ( .A(n866), .B(temp_read_pattern_count[2]), .C(n21), .Y(n24) );
  OAI22XL U506 ( .A0(n75), .A1(n396), .B0(n823), .B1(n859), .Y(n493) );
  OAI22XL U507 ( .A0(n75), .A1(n397), .B0(n809), .B1(n859), .Y(n492) );
  OAI22XL U508 ( .A0(n75), .A1(n398), .B0(n811), .B1(n859), .Y(n491) );
  OAI22XL U509 ( .A0(n75), .A1(n399), .B0(n813), .B1(n859), .Y(n490) );
  OAI22XL U510 ( .A0(n75), .A1(n400), .B0(n815), .B1(n859), .Y(n489) );
  OAI22XL U511 ( .A0(n75), .A1(n401), .B0(n817), .B1(n859), .Y(n488) );
  OAI22XL U512 ( .A0(n75), .A1(n402), .B0(n819), .B1(n859), .Y(n487) );
  OAI22XL U513 ( .A0(n75), .A1(n403), .B0(n821), .B1(n859), .Y(n486) );
  CLKBUFX3 U514 ( .A(n28), .Y(n75) );
  NOR3X1 U515 ( .A(n867), .B(n436), .C(n21), .Y(n28) );
  OAI22XL U516 ( .A0(n67), .A1(n404), .B0(n823), .B1(n862), .Y(n485) );
  OAI22XL U517 ( .A0(n67), .A1(n405), .B0(n809), .B1(n862), .Y(n484) );
  OAI22XL U518 ( .A0(n67), .A1(n406), .B0(n811), .B1(n862), .Y(n483) );
  OAI22XL U519 ( .A0(n67), .A1(n407), .B0(n813), .B1(n862), .Y(n482) );
  OAI22XL U520 ( .A0(n67), .A1(n408), .B0(n815), .B1(n862), .Y(n481) );
  OAI22XL U521 ( .A0(n67), .A1(n409), .B0(n817), .B1(n862), .Y(n480) );
  OAI22XL U522 ( .A0(n67), .A1(n410), .B0(n819), .B1(n862), .Y(n479) );
  OAI22XL U523 ( .A0(n67), .A1(n411), .B0(n821), .B1(n862), .Y(n478) );
  CLKBUFX3 U524 ( .A(n26), .Y(n67) );
  NOR3X1 U525 ( .A(n866), .B(temp_read_pattern_count[2]), .C(n4), .Y(n26) );
  OAI2BB1X1 U526 ( .A0N(temp_read_pattern_count[2]), .A1N(n36), .B0(n862), .Y(
        n518) );
  OAI21XL U527 ( .A0(n436), .A1(n878), .B0(n37), .Y(n36) );
  OA21XL U528 ( .A0(rst_read_count), .A1(ispattern), .B0(n21), .Y(n37) );
  OAI22XL U529 ( .A0(n37), .A1(n866), .B0(n436), .B1(n4), .Y(n519) );
  OAI31XL U530 ( .A0(n2), .A1(rst_read_count), .A2(ispattern), .B0(n21), .Y(
        n520) );
  OAI21XL U531 ( .A0(ispattern), .A1(n442), .B0(n4), .Y(n447) );
  CLKINVX1 U532 ( .A(ispattern), .Y(n878) );
  NOR2X1 U533 ( .A(isstring), .B(rst_read_count), .Y(n115) );
  AO22X1 U534 ( .A0(N110), .A1(isstring), .B0(n115), .B1(
        temp_read_string_count[0]), .Y(n781) );
  AO22X1 U535 ( .A0(N111), .A1(isstring), .B0(n115), .B1(
        temp_read_string_count[1]), .Y(n780) );
  AO22X1 U536 ( .A0(N112), .A1(isstring), .B0(n115), .B1(
        temp_read_string_count[2]), .Y(n779) );
  AO22X1 U537 ( .A0(N114), .A1(isstring), .B0(n115), .B1(
        temp_read_string_count[4]), .Y(n777) );
  AO22X1 U538 ( .A0(N113), .A1(isstring), .B0(n115), .B1(
        temp_read_string_count[3]), .Y(n778) );
  OAI22XL U539 ( .A0(n877), .A1(n1), .B0(isstring), .B1(n440), .Y(n449) );
  OAI22XL U540 ( .A0(n877), .A1(n857), .B0(isstring), .B1(n439), .Y(n450) );
  OAI22XL U541 ( .A0(n877), .A1(n856), .B0(isstring), .B1(n438), .Y(n451) );
  OAI22XL U542 ( .A0(n877), .A1(N110), .B0(isstring), .B1(n437), .Y(n452) );
  OAI21XL U543 ( .A0(isstring), .A1(n441), .B0(n5), .Y(n448) );
  OAI22XL U544 ( .A0(n878), .A1(n866), .B0(ispattern), .B1(n443), .Y(n446) );
  OAI22XL U545 ( .A0(n878), .A1(n867), .B0(ispattern), .B1(n444), .Y(n445) );
  ADDHXL U546 ( .A(temp_read_string_count[1]), .B(temp_read_string_count[0]), 
        .CO(\add_192/carry[2] ), .S(N111) );
  ADDHXL U547 ( .A(temp_read_string_count[2]), .B(\add_192/carry[2] ), .CO(
        \add_192/carry[3] ), .S(N112) );
  ADDHXL U548 ( .A(temp_read_string_count[3]), .B(\add_192/carry[3] ), .CO(
        \add_192/carry[4] ), .S(N113) );
  XOR2X1 U549 ( .A(\add_192/carry[4] ), .B(temp_read_string_count[4]), .Y(N114) );
endmodule


module match_controller ( clk, reset, isstring, ispattern, .string_buffer({
        \string_buffer[0][7] , \string_buffer[0][6] , \string_buffer[0][5] , 
        \string_buffer[0][4] , \string_buffer[0][3] , \string_buffer[0][2] , 
        \string_buffer[0][1] , \string_buffer[0][0] , \string_buffer[1][7] , 
        \string_buffer[1][6] , \string_buffer[1][5] , \string_buffer[1][4] , 
        \string_buffer[1][3] , \string_buffer[1][2] , \string_buffer[1][1] , 
        \string_buffer[1][0] , \string_buffer[2][7] , \string_buffer[2][6] , 
        \string_buffer[2][5] , \string_buffer[2][4] , \string_buffer[2][3] , 
        \string_buffer[2][2] , \string_buffer[2][1] , \string_buffer[2][0] , 
        \string_buffer[3][7] , \string_buffer[3][6] , \string_buffer[3][5] , 
        \string_buffer[3][4] , \string_buffer[3][3] , \string_buffer[3][2] , 
        \string_buffer[3][1] , \string_buffer[3][0] , \string_buffer[4][7] , 
        \string_buffer[4][6] , \string_buffer[4][5] , \string_buffer[4][4] , 
        \string_buffer[4][3] , \string_buffer[4][2] , \string_buffer[4][1] , 
        \string_buffer[4][0] , \string_buffer[5][7] , \string_buffer[5][6] , 
        \string_buffer[5][5] , \string_buffer[5][4] , \string_buffer[5][3] , 
        \string_buffer[5][2] , \string_buffer[5][1] , \string_buffer[5][0] , 
        \string_buffer[6][7] , \string_buffer[6][6] , \string_buffer[6][5] , 
        \string_buffer[6][4] , \string_buffer[6][3] , \string_buffer[6][2] , 
        \string_buffer[6][1] , \string_buffer[6][0] , \string_buffer[7][7] , 
        \string_buffer[7][6] , \string_buffer[7][5] , \string_buffer[7][4] , 
        \string_buffer[7][3] , \string_buffer[7][2] , \string_buffer[7][1] , 
        \string_buffer[7][0] , \string_buffer[8][7] , \string_buffer[8][6] , 
        \string_buffer[8][5] , \string_buffer[8][4] , \string_buffer[8][3] , 
        \string_buffer[8][2] , \string_buffer[8][1] , \string_buffer[8][0] , 
        \string_buffer[9][7] , \string_buffer[9][6] , \string_buffer[9][5] , 
        \string_buffer[9][4] , \string_buffer[9][3] , \string_buffer[9][2] , 
        \string_buffer[9][1] , \string_buffer[9][0] , \string_buffer[10][7] , 
        \string_buffer[10][6] , \string_buffer[10][5] , \string_buffer[10][4] , 
        \string_buffer[10][3] , \string_buffer[10][2] , \string_buffer[10][1] , 
        \string_buffer[10][0] , \string_buffer[11][7] , \string_buffer[11][6] , 
        \string_buffer[11][5] , \string_buffer[11][4] , \string_buffer[11][3] , 
        \string_buffer[11][2] , \string_buffer[11][1] , \string_buffer[11][0] , 
        \string_buffer[12][7] , \string_buffer[12][6] , \string_buffer[12][5] , 
        \string_buffer[12][4] , \string_buffer[12][3] , \string_buffer[12][2] , 
        \string_buffer[12][1] , \string_buffer[12][0] , \string_buffer[13][7] , 
        \string_buffer[13][6] , \string_buffer[13][5] , \string_buffer[13][4] , 
        \string_buffer[13][3] , \string_buffer[13][2] , \string_buffer[13][1] , 
        \string_buffer[13][0] , \string_buffer[14][7] , \string_buffer[14][6] , 
        \string_buffer[14][5] , \string_buffer[14][4] , \string_buffer[14][3] , 
        \string_buffer[14][2] , \string_buffer[14][1] , \string_buffer[14][0] , 
        \string_buffer[15][7] , \string_buffer[15][6] , \string_buffer[15][5] , 
        \string_buffer[15][4] , \string_buffer[15][3] , \string_buffer[15][2] , 
        \string_buffer[15][1] , \string_buffer[15][0] , \string_buffer[16][7] , 
        \string_buffer[16][6] , \string_buffer[16][5] , \string_buffer[16][4] , 
        \string_buffer[16][3] , \string_buffer[16][2] , \string_buffer[16][1] , 
        \string_buffer[16][0] , \string_buffer[17][7] , \string_buffer[17][6] , 
        \string_buffer[17][5] , \string_buffer[17][4] , \string_buffer[17][3] , 
        \string_buffer[17][2] , \string_buffer[17][1] , \string_buffer[17][0] , 
        \string_buffer[18][7] , \string_buffer[18][6] , \string_buffer[18][5] , 
        \string_buffer[18][4] , \string_buffer[18][3] , \string_buffer[18][2] , 
        \string_buffer[18][1] , \string_buffer[18][0] , \string_buffer[19][7] , 
        \string_buffer[19][6] , \string_buffer[19][5] , \string_buffer[19][4] , 
        \string_buffer[19][3] , \string_buffer[19][2] , \string_buffer[19][1] , 
        \string_buffer[19][0] , \string_buffer[20][7] , \string_buffer[20][6] , 
        \string_buffer[20][5] , \string_buffer[20][4] , \string_buffer[20][3] , 
        \string_buffer[20][2] , \string_buffer[20][1] , \string_buffer[20][0] , 
        \string_buffer[21][7] , \string_buffer[21][6] , \string_buffer[21][5] , 
        \string_buffer[21][4] , \string_buffer[21][3] , \string_buffer[21][2] , 
        \string_buffer[21][1] , \string_buffer[21][0] , \string_buffer[22][7] , 
        \string_buffer[22][6] , \string_buffer[22][5] , \string_buffer[22][4] , 
        \string_buffer[22][3] , \string_buffer[22][2] , \string_buffer[22][1] , 
        \string_buffer[22][0] , \string_buffer[23][7] , \string_buffer[23][6] , 
        \string_buffer[23][5] , \string_buffer[23][4] , \string_buffer[23][3] , 
        \string_buffer[23][2] , \string_buffer[23][1] , \string_buffer[23][0] , 
        \string_buffer[24][7] , \string_buffer[24][6] , \string_buffer[24][5] , 
        \string_buffer[24][4] , \string_buffer[24][3] , \string_buffer[24][2] , 
        \string_buffer[24][1] , \string_buffer[24][0] , \string_buffer[25][7] , 
        \string_buffer[25][6] , \string_buffer[25][5] , \string_buffer[25][4] , 
        \string_buffer[25][3] , \string_buffer[25][2] , \string_buffer[25][1] , 
        \string_buffer[25][0] , \string_buffer[26][7] , \string_buffer[26][6] , 
        \string_buffer[26][5] , \string_buffer[26][4] , \string_buffer[26][3] , 
        \string_buffer[26][2] , \string_buffer[26][1] , \string_buffer[26][0] , 
        \string_buffer[27][7] , \string_buffer[27][6] , \string_buffer[27][5] , 
        \string_buffer[27][4] , \string_buffer[27][3] , \string_buffer[27][2] , 
        \string_buffer[27][1] , \string_buffer[27][0] , \string_buffer[28][7] , 
        \string_buffer[28][6] , \string_buffer[28][5] , \string_buffer[28][4] , 
        \string_buffer[28][3] , \string_buffer[28][2] , \string_buffer[28][1] , 
        \string_buffer[28][0] , \string_buffer[29][7] , \string_buffer[29][6] , 
        \string_buffer[29][5] , \string_buffer[29][4] , \string_buffer[29][3] , 
        \string_buffer[29][2] , \string_buffer[29][1] , \string_buffer[29][0] , 
        \string_buffer[30][7] , \string_buffer[30][6] , \string_buffer[30][5] , 
        \string_buffer[30][4] , \string_buffer[30][3] , \string_buffer[30][2] , 
        \string_buffer[30][1] , \string_buffer[30][0] , \string_buffer[31][7] , 
        \string_buffer[31][6] , \string_buffer[31][5] , \string_buffer[31][4] , 
        \string_buffer[31][3] , \string_buffer[31][2] , \string_buffer[31][1] , 
        \string_buffer[31][0] }), .pattern_buffer({\pattern_buffer[0][7] , 
        \pattern_buffer[0][6] , \pattern_buffer[0][5] , \pattern_buffer[0][4] , 
        \pattern_buffer[0][3] , \pattern_buffer[0][2] , \pattern_buffer[0][1] , 
        \pattern_buffer[0][0] , \pattern_buffer[1][7] , \pattern_buffer[1][6] , 
        \pattern_buffer[1][5] , \pattern_buffer[1][4] , \pattern_buffer[1][3] , 
        \pattern_buffer[1][2] , \pattern_buffer[1][1] , \pattern_buffer[1][0] , 
        \pattern_buffer[2][7] , \pattern_buffer[2][6] , \pattern_buffer[2][5] , 
        \pattern_buffer[2][4] , \pattern_buffer[2][3] , \pattern_buffer[2][2] , 
        \pattern_buffer[2][1] , \pattern_buffer[2][0] , \pattern_buffer[3][7] , 
        \pattern_buffer[3][6] , \pattern_buffer[3][5] , \pattern_buffer[3][4] , 
        \pattern_buffer[3][3] , \pattern_buffer[3][2] , \pattern_buffer[3][1] , 
        \pattern_buffer[3][0] , \pattern_buffer[4][7] , \pattern_buffer[4][6] , 
        \pattern_buffer[4][5] , \pattern_buffer[4][4] , \pattern_buffer[4][3] , 
        \pattern_buffer[4][2] , \pattern_buffer[4][1] , \pattern_buffer[4][0] , 
        \pattern_buffer[5][7] , \pattern_buffer[5][6] , \pattern_buffer[5][5] , 
        \pattern_buffer[5][4] , \pattern_buffer[5][3] , \pattern_buffer[5][2] , 
        \pattern_buffer[5][1] , \pattern_buffer[5][0] , \pattern_buffer[6][7] , 
        \pattern_buffer[6][6] , \pattern_buffer[6][5] , \pattern_buffer[6][4] , 
        \pattern_buffer[6][3] , \pattern_buffer[6][2] , \pattern_buffer[6][1] , 
        \pattern_buffer[6][0] , \pattern_buffer[7][7] , \pattern_buffer[7][6] , 
        \pattern_buffer[7][5] , \pattern_buffer[7][4] , \pattern_buffer[7][3] , 
        \pattern_buffer[7][2] , \pattern_buffer[7][1] , \pattern_buffer[7][0] 
        }), read_string_count, read_pattern_count, match_enable, match, 
        match_index, valid );
  input [4:0] read_string_count;
  input [2:0] read_pattern_count;
  output [4:0] match_index;
  input clk, reset, isstring, ispattern, \string_buffer[0][7] ,
         \string_buffer[0][6] , \string_buffer[0][5] , \string_buffer[0][4] ,
         \string_buffer[0][3] , \string_buffer[0][2] , \string_buffer[0][1] ,
         \string_buffer[0][0] , \string_buffer[1][7] , \string_buffer[1][6] ,
         \string_buffer[1][5] , \string_buffer[1][4] , \string_buffer[1][3] ,
         \string_buffer[1][2] , \string_buffer[1][1] , \string_buffer[1][0] ,
         \string_buffer[2][7] , \string_buffer[2][6] , \string_buffer[2][5] ,
         \string_buffer[2][4] , \string_buffer[2][3] , \string_buffer[2][2] ,
         \string_buffer[2][1] , \string_buffer[2][0] , \string_buffer[3][7] ,
         \string_buffer[3][6] , \string_buffer[3][5] , \string_buffer[3][4] ,
         \string_buffer[3][3] , \string_buffer[3][2] , \string_buffer[3][1] ,
         \string_buffer[3][0] , \string_buffer[4][7] , \string_buffer[4][6] ,
         \string_buffer[4][5] , \string_buffer[4][4] , \string_buffer[4][3] ,
         \string_buffer[4][2] , \string_buffer[4][1] , \string_buffer[4][0] ,
         \string_buffer[5][7] , \string_buffer[5][6] , \string_buffer[5][5] ,
         \string_buffer[5][4] , \string_buffer[5][3] , \string_buffer[5][2] ,
         \string_buffer[5][1] , \string_buffer[5][0] , \string_buffer[6][7] ,
         \string_buffer[6][6] , \string_buffer[6][5] , \string_buffer[6][4] ,
         \string_buffer[6][3] , \string_buffer[6][2] , \string_buffer[6][1] ,
         \string_buffer[6][0] , \string_buffer[7][7] , \string_buffer[7][6] ,
         \string_buffer[7][5] , \string_buffer[7][4] , \string_buffer[7][3] ,
         \string_buffer[7][2] , \string_buffer[7][1] , \string_buffer[7][0] ,
         \string_buffer[8][7] , \string_buffer[8][6] , \string_buffer[8][5] ,
         \string_buffer[8][4] , \string_buffer[8][3] , \string_buffer[8][2] ,
         \string_buffer[8][1] , \string_buffer[8][0] , \string_buffer[9][7] ,
         \string_buffer[9][6] , \string_buffer[9][5] , \string_buffer[9][4] ,
         \string_buffer[9][3] , \string_buffer[9][2] , \string_buffer[9][1] ,
         \string_buffer[9][0] , \string_buffer[10][7] , \string_buffer[10][6] ,
         \string_buffer[10][5] , \string_buffer[10][4] ,
         \string_buffer[10][3] , \string_buffer[10][2] ,
         \string_buffer[10][1] , \string_buffer[10][0] ,
         \string_buffer[11][7] , \string_buffer[11][6] ,
         \string_buffer[11][5] , \string_buffer[11][4] ,
         \string_buffer[11][3] , \string_buffer[11][2] ,
         \string_buffer[11][1] , \string_buffer[11][0] ,
         \string_buffer[12][7] , \string_buffer[12][6] ,
         \string_buffer[12][5] , \string_buffer[12][4] ,
         \string_buffer[12][3] , \string_buffer[12][2] ,
         \string_buffer[12][1] , \string_buffer[12][0] ,
         \string_buffer[13][7] , \string_buffer[13][6] ,
         \string_buffer[13][5] , \string_buffer[13][4] ,
         \string_buffer[13][3] , \string_buffer[13][2] ,
         \string_buffer[13][1] , \string_buffer[13][0] ,
         \string_buffer[14][7] , \string_buffer[14][6] ,
         \string_buffer[14][5] , \string_buffer[14][4] ,
         \string_buffer[14][3] , \string_buffer[14][2] ,
         \string_buffer[14][1] , \string_buffer[14][0] ,
         \string_buffer[15][7] , \string_buffer[15][6] ,
         \string_buffer[15][5] , \string_buffer[15][4] ,
         \string_buffer[15][3] , \string_buffer[15][2] ,
         \string_buffer[15][1] , \string_buffer[15][0] ,
         \string_buffer[16][7] , \string_buffer[16][6] ,
         \string_buffer[16][5] , \string_buffer[16][4] ,
         \string_buffer[16][3] , \string_buffer[16][2] ,
         \string_buffer[16][1] , \string_buffer[16][0] ,
         \string_buffer[17][7] , \string_buffer[17][6] ,
         \string_buffer[17][5] , \string_buffer[17][4] ,
         \string_buffer[17][3] , \string_buffer[17][2] ,
         \string_buffer[17][1] , \string_buffer[17][0] ,
         \string_buffer[18][7] , \string_buffer[18][6] ,
         \string_buffer[18][5] , \string_buffer[18][4] ,
         \string_buffer[18][3] , \string_buffer[18][2] ,
         \string_buffer[18][1] , \string_buffer[18][0] ,
         \string_buffer[19][7] , \string_buffer[19][6] ,
         \string_buffer[19][5] , \string_buffer[19][4] ,
         \string_buffer[19][3] , \string_buffer[19][2] ,
         \string_buffer[19][1] , \string_buffer[19][0] ,
         \string_buffer[20][7] , \string_buffer[20][6] ,
         \string_buffer[20][5] , \string_buffer[20][4] ,
         \string_buffer[20][3] , \string_buffer[20][2] ,
         \string_buffer[20][1] , \string_buffer[20][0] ,
         \string_buffer[21][7] , \string_buffer[21][6] ,
         \string_buffer[21][5] , \string_buffer[21][4] ,
         \string_buffer[21][3] , \string_buffer[21][2] ,
         \string_buffer[21][1] , \string_buffer[21][0] ,
         \string_buffer[22][7] , \string_buffer[22][6] ,
         \string_buffer[22][5] , \string_buffer[22][4] ,
         \string_buffer[22][3] , \string_buffer[22][2] ,
         \string_buffer[22][1] , \string_buffer[22][0] ,
         \string_buffer[23][7] , \string_buffer[23][6] ,
         \string_buffer[23][5] , \string_buffer[23][4] ,
         \string_buffer[23][3] , \string_buffer[23][2] ,
         \string_buffer[23][1] , \string_buffer[23][0] ,
         \string_buffer[24][7] , \string_buffer[24][6] ,
         \string_buffer[24][5] , \string_buffer[24][4] ,
         \string_buffer[24][3] , \string_buffer[24][2] ,
         \string_buffer[24][1] , \string_buffer[24][0] ,
         \string_buffer[25][7] , \string_buffer[25][6] ,
         \string_buffer[25][5] , \string_buffer[25][4] ,
         \string_buffer[25][3] , \string_buffer[25][2] ,
         \string_buffer[25][1] , \string_buffer[25][0] ,
         \string_buffer[26][7] , \string_buffer[26][6] ,
         \string_buffer[26][5] , \string_buffer[26][4] ,
         \string_buffer[26][3] , \string_buffer[26][2] ,
         \string_buffer[26][1] , \string_buffer[26][0] ,
         \string_buffer[27][7] , \string_buffer[27][6] ,
         \string_buffer[27][5] , \string_buffer[27][4] ,
         \string_buffer[27][3] , \string_buffer[27][2] ,
         \string_buffer[27][1] , \string_buffer[27][0] ,
         \string_buffer[28][7] , \string_buffer[28][6] ,
         \string_buffer[28][5] , \string_buffer[28][4] ,
         \string_buffer[28][3] , \string_buffer[28][2] ,
         \string_buffer[28][1] , \string_buffer[28][0] ,
         \string_buffer[29][7] , \string_buffer[29][6] ,
         \string_buffer[29][5] , \string_buffer[29][4] ,
         \string_buffer[29][3] , \string_buffer[29][2] ,
         \string_buffer[29][1] , \string_buffer[29][0] ,
         \string_buffer[30][7] , \string_buffer[30][6] ,
         \string_buffer[30][5] , \string_buffer[30][4] ,
         \string_buffer[30][3] , \string_buffer[30][2] ,
         \string_buffer[30][1] , \string_buffer[30][0] ,
         \string_buffer[31][7] , \string_buffer[31][6] ,
         \string_buffer[31][5] , \string_buffer[31][4] ,
         \string_buffer[31][3] , \string_buffer[31][2] ,
         \string_buffer[31][1] , \string_buffer[31][0] ,
         \pattern_buffer[0][7] , \pattern_buffer[0][6] ,
         \pattern_buffer[0][5] , \pattern_buffer[0][4] ,
         \pattern_buffer[0][3] , \pattern_buffer[0][2] ,
         \pattern_buffer[0][1] , \pattern_buffer[0][0] ,
         \pattern_buffer[1][7] , \pattern_buffer[1][6] ,
         \pattern_buffer[1][5] , \pattern_buffer[1][4] ,
         \pattern_buffer[1][3] , \pattern_buffer[1][2] ,
         \pattern_buffer[1][1] , \pattern_buffer[1][0] ,
         \pattern_buffer[2][7] , \pattern_buffer[2][6] ,
         \pattern_buffer[2][5] , \pattern_buffer[2][4] ,
         \pattern_buffer[2][3] , \pattern_buffer[2][2] ,
         \pattern_buffer[2][1] , \pattern_buffer[2][0] ,
         \pattern_buffer[3][7] , \pattern_buffer[3][6] ,
         \pattern_buffer[3][5] , \pattern_buffer[3][4] ,
         \pattern_buffer[3][3] , \pattern_buffer[3][2] ,
         \pattern_buffer[3][1] , \pattern_buffer[3][0] ,
         \pattern_buffer[4][7] , \pattern_buffer[4][6] ,
         \pattern_buffer[4][5] , \pattern_buffer[4][4] ,
         \pattern_buffer[4][3] , \pattern_buffer[4][2] ,
         \pattern_buffer[4][1] , \pattern_buffer[4][0] ,
         \pattern_buffer[5][7] , \pattern_buffer[5][6] ,
         \pattern_buffer[5][5] , \pattern_buffer[5][4] ,
         \pattern_buffer[5][3] , \pattern_buffer[5][2] ,
         \pattern_buffer[5][1] , \pattern_buffer[5][0] ,
         \pattern_buffer[6][7] , \pattern_buffer[6][6] ,
         \pattern_buffer[6][5] , \pattern_buffer[6][4] ,
         \pattern_buffer[6][3] , \pattern_buffer[6][2] ,
         \pattern_buffer[6][1] , \pattern_buffer[6][0] ,
         \pattern_buffer[7][7] , \pattern_buffer[7][6] ,
         \pattern_buffer[7][5] , \pattern_buffer[7][4] ,
         \pattern_buffer[7][3] , \pattern_buffer[7][2] ,
         \pattern_buffer[7][1] , \pattern_buffer[7][0] , match_enable;
  output match, valid;
  wire   N244, N245, N246, N247, N248, N249, N250, N251, N252, N253, N254,
         n940, N255, N256, N257, N258, N259, N260, N261, N262, star_flag_temp,
         N286, N287, N288, N289, N901, N902, N903, N904, N905, N906, N907,
         N908, N909, N910, N911, N912, N913, N914, N970, \r534/EQ_NE , N608,
         n157, n167, n168, n169, n170, n181, n182, n183, n192, n193, n195,
         n196, n197, n198, n199, n241, n242, n243, n244, n245, n246, n247,
         n248, n249, n250, n251, n252, n253, n254, n255, n256, n257, n258,
         n259, n260, n261, n262, n263, n264, n265, n266, n267, n268, n269,
         n270, n271, n272, n273, n274, n275, n276, n277, n278, n279, n280,
         n281, n282, n283, n284, n285, n286, n287, n288, n289, n290, n291,
         n292, n293, n294, n295, n296, n297, n298, n299, n300, n301, n302,
         n303, n304, n305, n306, n307, n308, n309, n310, n311, n312, n313,
         n314, n315, n316, n318, n319, n320, n321, n322, n323, n324, n325,
         n326, n327, n328, n329, n330, n331, n332, n333, n334, n335, n336,
         n337, n338, n339, n340, n341, n342, n343, n344, n345, n346, n347,
         n348, n349, n350, n351, n352, n353, n354, n355, n356, n357, n358,
         n359, n360, n361, n362, n363, n364, n365, n366, n367, n368, n369,
         n370, n371, n372, n373, n374, n375, n376, n377, n378, n379, n380,
         n381, n382, n383, n384, n385, n386, n387, n388, n389, n390, n391,
         n392, n393, n394, n395, n396, n397, n398, n399, n400, n401, n402,
         n403, n404, n405, n406, n407, n408, n409, n410, n411, n412, n413,
         n414, n415, n416, n417, n418, n419, n420, n421, n422, n423, n424,
         n425, n426, n427, n428, n429, n430, n431, n432, n433, n434, n435,
         n436, n437, n438, n439, n440, n441, n442, n443, n444, n445, n446,
         n447, n448, n449, n450, n451, n452, n453, n454, n455, n456, n457,
         n458, n459, n460, n461, n462, n463, n464, n465, n466, n467, n468,
         n469, n470, n471, n472, n473, n474, n475, n476, n477, n478, n479,
         n480, n481, n482, n483, n484, n485, n486, n487, n488, n489, n490,
         n491, n492, n493, n494, n495, n496, n497, n498, n499, n500, n501,
         n502, n503, n504, n505, n506, n507, n508, n509, n510, n511, n512,
         n513, n514, n515, n516, n517, n518, n519, n520, n521, n522, n523,
         n524, n525, n526, n527, n528, n529, n530, n531, n532, n533, n537,
         n538, n539, n540, n541, n542, n543, n544, n545, n546, n547, n548,
         n549, n550, n551, n552, n553, n554, n555, n556, n557, n558, n559,
         n560, n561, n562, n563, n564, n565, n566, n567, n568, n569, n570,
         n571, n572, n573, n574, n575, n576, n577, n578, n579, n580, n581,
         n582, n583, n584, n585, n586, n587, n588, n589, n590, n591, n592,
         n593, n594, n595, n596, n597, n598, n599, n600, n601, n602, n603,
         n604, n605, n606, n607, n608, n609, n610, n611, n612, n613, n614,
         n615, n616, n617, n618, n619, n620, n621, n622, n623, n624, n625,
         n626, n627, n628, n629, n630, n631, n632, n633, n634, n635, n636,
         n637, n638, n639, n640, n641, n642, n643, n644, n645, n646, n647,
         n648, n649, n650, n651, n652, n653, n654, n655, n656, n657, n658,
         n659, n660, n661, n662, n663, n664, n665, n666, n667, n668, n669,
         n670, n671, n672, n673, n674, n675, n676, n677, n678, n679, n680,
         n681, n682, n683, n684, n685, n686, n687, n688, n689, n690, n691,
         n692, n693, n694, n695, n696, n697, n698, n699, n700, n701, n702,
         n703, n704, n705, n706, n707, n708, n709, n710, n711, n712, n713,
         n714, n715, n716, n717, n718, n719, n720, n721, n722, n723, n724,
         n725, n726, n727, n728, n729, n730, n731, n732, n733, n734, n735,
         n736, n737, n738, n739, n740, n741, n742, n743, n744, n745, n746,
         n747, n748, n749, n750, n751, n752, n753, n754, n755, n756, n757,
         n758, n759, n760, n761, n762, \add_304/carry[4] , \add_304/carry[3] ,
         \add_304/carry[2] , n1, n2, n3, n4, n5, n6, n7, n15, n16, n17, n18,
         n19, n20, n21, n22, n23, n24, n25, n26, n27, n28, n29, n30, n31, n32,
         n33, n34, n35, n36, n37, n38, n39, n40, n41, n42, n43, n44, n45, n46,
         n47, n48, n49, n50, n51, n52, n53, n54, n55, n56, n57, n58, n59, n60,
         n61, n62, n63, n64, n65, n66, n67, n68, n69, n70, n71, n72, n73, n74,
         n75, n76, n77, n78, n79, n80, n81, n82, n83, n84, n85, n86, n87, n88,
         n89, n90, n91, n92, n93, n94, n95, n96, n97, n98, n99, n100, n101,
         n102, n103, n104, n105, n106, n107, n108, n109, n110, n111, n112,
         n113, n114, n115, n116, n117, n118, n119, n120, n121, n122, n123,
         n124, n125, n126, n127, n128, n129, n130, n131, n132, n133, n134,
         n135, n136, n137, n138, n139, n140, n141, n142, n143, n144, n145,
         n146, n147, n148, n149, n150, n151, n152, n153, n154, n155, n156,
         n158, n159, n160, n161, n162, n163, n164, n165, n166, n171, n172,
         n173, n174, n175, n176, n177, n178, n179, n180, n184, n185, n186,
         n187, n188, n189, n190, n191, n194, n200, n201, n202, n203, n204,
         n205, n206, n207, n208, n209, n210, n211, n212, n213, n214, n215,
         n216, n217, n218, n219, n220, n221, n222, n223, n224, n225, n226,
         n227, n228, n229, n230, n231, n232, n233, n234, n235, n236, n237,
         n238, n239, n240, n317, n534, n535, n536, n763, n764, n765, n766,
         n767, n768, n769, n770, n771, n772, n773, n774, n775, n776, n777,
         n778, n779, n780, n781, n782, n783, n784, n785, n786, n787, n788,
         n789, n790, n791, n792, n793, n794, n795, n796, n797, n798, n799,
         n800, n801, n802, n803, n804, n805, n806, n807, n808, n809, n810,
         n811, n812, n813, n814, n815, n816, n817, n818, n819, n820, n821,
         n822, n823, n824, n825, n826, n827, n828, n829, n830, n831, n832,
         n833, n834, n835, n836, n837, n838, n839, n840, n841, n842, n843,
         n844, n845, n846, n847, n848, n849, n850, n851, n852, n853, n854,
         n855, n856, n857, n858, n859, n860, n861, n862, n863, n864, n865,
         n866, n867, n868, n869, n870, n871, n872, n873, n874, n875, n876,
         n877, n878, n879, n880, n881, n882, n883, n884, n885, n886, n887,
         n888, n889, n890, n891, n892, n893, n894, n895, n896, n897, n898,
         n899, n900, n901, n902, n903, n904, n905, n906, n907, n908, n909,
         n910, n911, n912, n913, n914, n915, n916, n917, n918, n919, n920,
         n921, n922, n923, n924, n925, n926, n927, n928, n929, n930, n931,
         n932, n933, n934, n935, n936, n937, n938, n939;
  wire   [3:0] cur_match_state;
  assign N244 = read_pattern_count[0];
  assign N245 = read_pattern_count[1];
  assign N246 = read_pattern_count[2];

  AOI211X2 U32 ( .A0(N608), .A1(n272), .B0(n273), .C0(n274), .Y(n249) );
  NAND2X4 U90 ( .A(n331), .B(N608), .Y(n296) );
  NAND2BX4 U191 ( .AN(n454), .B(N608), .Y(n270) );
  AOI211X2 U339 ( .A0(n882), .A1(n643), .B0(n272), .C0(n307), .Y(n539) );
  DFFRX1 \star_index_reg[0]  ( .D(n762), .CK(clk), .RN(n939), .QN(n199) );
  DFFRX1 \star_index_reg[1]  ( .D(n743), .CK(clk), .RN(n939), .QN(n198) );
  DFFRX1 \star_index_reg[2]  ( .D(n742), .CK(clk), .RN(n939), .QN(n197) );
  DFFRX1 star_flag_temp_reg ( .D(n752), .CK(clk), .RN(n939), .Q(star_flag_temp) );
  DFFRX2 \match_string_count_reg[3]  ( .D(n758), .CK(clk), .RN(n939), .Q(N253), 
        .QN(n167) );
  DFFRX1 \cur_match_state_reg[2]  ( .D(n754), .CK(clk), .RN(n939), .Q(
        cur_match_state[2]), .QN(n193) );
  DFFRX1 \cur_match_state_reg[0]  ( .D(n756), .CK(clk), .RN(n939), .Q(
        cur_match_state[0]), .QN(n196) );
  DFFRX1 \cur_match_state_reg[1]  ( .D(n755), .CK(clk), .RN(n939), .Q(
        cur_match_state[1]), .QN(n195) );
  DFFRX1 \cur_match_state_reg[3]  ( .D(n753), .CK(clk), .RN(n939), .Q(
        cur_match_state[3]), .QN(n192) );
  DFFRX1 \match_index_reg[0]  ( .D(n748), .CK(clk), .RN(n939), .QN(n3) );
  DFFRX1 \match_index_reg[4]  ( .D(n747), .CK(clk), .RN(n939), .QN(n5) );
  DFFRX1 \match_index_reg[3]  ( .D(n746), .CK(clk), .RN(n939), .QN(n6) );
  DFFRX1 \match_index_reg[2]  ( .D(n745), .CK(clk), .RN(n939), .QN(n4) );
  DFFRX1 \match_index_reg[1]  ( .D(n744), .CK(clk), .RN(n939), .QN(n7) );
  DFFRX2 \match_string_count_reg[0]  ( .D(n760), .CK(clk), .RN(n939), .Q(N250), 
        .QN(n170) );
  DFFRX2 \match_pattern_count_reg[0]  ( .D(n750), .CK(clk), .RN(n939), .Q(N247), .QN(n183) );
  DFFRX2 \match_string_count_reg[4]  ( .D(n757), .CK(clk), .RN(n939), .Q(N254), 
        .QN(n157) );
  DFFRX2 \match_string_count_reg[2]  ( .D(n759), .CK(clk), .RN(n939), .Q(N252), 
        .QN(n168) );
  DFFRX2 \match_pattern_count_reg[2]  ( .D(n749), .CK(clk), .RN(n939), .Q(N249), .QN(n181) );
  DFFRX2 \match_pattern_count_reg[1]  ( .D(n751), .CK(clk), .RN(n939), .Q(N248), .QN(n182) );
  DFFRX2 \match_string_count_reg[1]  ( .D(n761), .CK(clk), .RN(n939), .Q(N251), 
        .QN(n169) );
  OA22X1 U3 ( .A0(n95), .A1(n86), .B0(n836), .B1(n85), .Y(n1) );
  OA22X1 U4 ( .A0(n94), .A1(n95), .B0(n836), .B1(n93), .Y(n2) );
  INVX12 U5 ( .A(n7), .Y(match_index[1]) );
  INVX12 U6 ( .A(n4), .Y(match_index[2]) );
  INVX12 U7 ( .A(n6), .Y(match_index[3]) );
  INVX12 U8 ( .A(n5), .Y(match_index[4]) );
  INVX12 U9 ( .A(n3), .Y(match_index[0]) );
  BUFX12 U10 ( .A(N970), .Y(match) );
  NOR2BX1 U11 ( .AN(n940), .B(cur_match_state[0]), .Y(N970) );
  OAI22X1 U12 ( .A0(n95), .A1(n70), .B0(n836), .B1(n69), .Y(N904) );
  BUFX12 U13 ( .A(n940), .Y(valid) );
  NOR3X1 U14 ( .A(n195), .B(cur_match_state[2]), .C(n192), .Y(n940) );
  CLKBUFX3 U15 ( .A(n249), .Y(n834) );
  NOR2X1 U16 ( .A(n296), .B(n299), .Y(n275) );
  OAI211XL U17 ( .A0(n867), .A1(n453), .B0(n838), .C0(n270), .Y(n395) );
  OAI21XL U18 ( .A0(n351), .A1(n326), .B0(n353), .Y(n273) );
  NAND2X1 U19 ( .A(n705), .B(n683), .Y(n351) );
  OAI22XL U20 ( .A0(n617), .A1(n576), .B0(n618), .B1(n577), .Y(n616) );
  OAI22XL U21 ( .A0(n631), .A1(n632), .B0(n633), .B1(n634), .Y(n630) );
  OAI22XL U22 ( .A0(n619), .A1(n620), .B0(n621), .B1(n574), .Y(n615) );
  OAI22XL U23 ( .A0(n635), .A1(n636), .B0(n637), .B1(n582), .Y(n629) );
  OAI22XL U24 ( .A0(n603), .A1(n595), .B0(n604), .B1(n596), .Y(n602) );
  OAI22XL U25 ( .A0(n605), .A1(n606), .B0(n607), .B1(n593), .Y(n601) );
  OAI22XL U26 ( .A0(n622), .A1(n572), .B0(n623), .B1(n573), .Y(n614) );
  OAI22XL U27 ( .A0(n638), .A1(n580), .B0(n639), .B1(n581), .Y(n628) );
  OAI22XL U28 ( .A0(n608), .A1(n591), .B0(n609), .B1(n592), .Y(n600) );
  OAI22XL U29 ( .A0(n624), .A1(n625), .B0(n626), .B1(n597), .Y(n613) );
  OAI22XL U30 ( .A0(n640), .A1(n641), .B0(n642), .B1(n578), .Y(n627) );
  OAI22XL U31 ( .A0(n610), .A1(n611), .B0(n612), .B1(n589), .Y(n599) );
  NAND3X1 U33 ( .A(n887), .B(n323), .C(\r534/EQ_NE ), .Y(n332) );
  CLKINVX1 U34 ( .A(n352), .Y(n886) );
  NOR3BXL U35 ( .AN(n341), .B(n343), .C(n342), .Y(n294) );
  OAI21XL U36 ( .A0(n455), .A1(n389), .B0(n892), .Y(n341) );
  OAI21XL U37 ( .A0(n276), .A1(n886), .B0(n386), .Y(n370) );
  OAI22XL U38 ( .A0(n617), .A1(n641), .B0(n618), .B1(n578), .Y(n711) );
  OAI22XL U39 ( .A0(n631), .A1(n676), .B0(n633), .B1(n564), .Y(n724) );
  OAI22XL U40 ( .A0(n619), .A1(n576), .B0(n621), .B1(n577), .Y(n710) );
  OAI22XL U41 ( .A0(n635), .A1(n632), .B0(n637), .B1(n634), .Y(n723) );
  OAI22XL U42 ( .A0(n622), .A1(n620), .B0(n623), .B1(n574), .Y(n709) );
  OAI22XL U43 ( .A0(n638), .A1(n636), .B0(n639), .B1(n582), .Y(n722) );
  OAI22XL U44 ( .A0(n624), .A1(n572), .B0(n626), .B1(n573), .Y(n708) );
  OAI22XL U45 ( .A0(n640), .A1(n580), .B0(n642), .B1(n581), .Y(n721) );
  OAI21XL U46 ( .A0(n351), .A1(n352), .B0(n353), .Y(n301) );
  CLKBUFX3 U47 ( .A(n250), .Y(n835) );
  NOR2X2 U48 ( .A(N253), .B(N254), .Y(n683) );
  OAI22XL U49 ( .A0(n563), .A1(n564), .B0(n565), .B1(n566), .Y(n548) );
  NOR2X2 U50 ( .A(n157), .B(N253), .Y(n712) );
  NOR3X1 U51 ( .A(N251), .B(N252), .C(N250), .Y(n705) );
  NOR3X1 U52 ( .A(N251), .B(N252), .C(n170), .Y(n692) );
  NOR3X1 U53 ( .A(n168), .B(N251), .C(n170), .Y(n687) );
  NOR2X2 U54 ( .A(n167), .B(N254), .Y(n698) );
  NOR3X1 U55 ( .A(N250), .B(N251), .C(n168), .Y(n684) );
  NOR2X2 U56 ( .A(n167), .B(n157), .Y(n725) );
  NOR3X1 U57 ( .A(n169), .B(N252), .C(n170), .Y(n682) );
  NOR3X1 U58 ( .A(n169), .B(N250), .C(n168), .Y(n688) );
  NOR3X1 U59 ( .A(N250), .B(N252), .C(n169), .Y(n685) );
  NOR3X1 U60 ( .A(n168), .B(n169), .C(n170), .Y(n689) );
  NAND3X1 U61 ( .A(n452), .B(n196), .C(cur_match_state[1]), .Y(n342) );
  NAND3X1 U62 ( .A(n883), .B(cur_match_state[2]), .C(cur_match_state[3]), .Y(
        n299) );
  OAI22XL U63 ( .A0(n666), .A1(n561), .B0(n667), .B1(n668), .Y(n656) );
  NOR3X2 U64 ( .A(n919), .B(N244), .C(n920), .Y(n489) );
  NOR3X2 U65 ( .A(n54), .B(N245), .C(n920), .Y(n488) );
  NOR3X2 U66 ( .A(N244), .B(N245), .C(n920), .Y(n483) );
  NAND3X1 U67 ( .A(n182), .B(n181), .C(n183), .Y(n513) );
  NOR3X2 U68 ( .A(N248), .B(N249), .C(n183), .Y(n418) );
  NOR3X2 U69 ( .A(n54), .B(N246), .C(n919), .Y(n482) );
  CLKINVX1 U70 ( .A(\r534/EQ_NE ), .Y(n289) );
  CLKINVX1 U71 ( .A(n347), .Y(n837) );
  CLKINVX1 U72 ( .A(n273), .Y(n869) );
  NOR2X1 U73 ( .A(n871), .B(n867), .Y(n643) );
  NAND2X1 U74 ( .A(n886), .B(n890), .Y(n326) );
  CLKINVX1 U75 ( .A(n293), .Y(n357) );
  NOR4X1 U76 ( .A(n867), .B(n357), .C(n347), .D(n374), .Y(n356) );
  NAND2X1 U77 ( .A(n297), .B(n332), .Y(n307) );
  NOR2X1 U78 ( .A(n241), .B(n242), .Y(\r534/EQ_NE ) );
  NAND4X1 U79 ( .A(n257), .B(n258), .C(n259), .D(n260), .Y(n241) );
  NAND4X1 U80 ( .A(n243), .B(n244), .C(n245), .D(n246), .Y(n242) );
  XNOR2X1 U81 ( .A(n267), .B(n268), .Y(n257) );
  NOR3X1 U82 ( .A(n871), .B(n867), .C(n326), .Y(n272) );
  NAND2BX1 U83 ( .AN(n326), .B(n327), .Y(n269) );
  NAND2X1 U84 ( .A(n288), .B(n284), .Y(n286) );
  NAND2X1 U85 ( .A(n288), .B(n286), .Y(n287) );
  CLKINVX1 U86 ( .A(N608), .Y(n374) );
  NAND4X1 U87 ( .A(n891), .B(n387), .C(n315), .D(n374), .Y(n533) );
  OAI22XL U88 ( .A0(n344), .A1(n346), .B0(n374), .B1(n332), .Y(n334) );
  NOR2X1 U89 ( .A(n387), .B(N608), .Y(n338) );
  AOI221XL U91 ( .A0(n886), .A1(n385), .B0(n889), .B1(n883), .C0(n884), .Y(
        n384) );
  OAI21XL U92 ( .A0(n867), .A1(n338), .B0(n351), .Y(n385) );
  INVX3 U93 ( .A(n351), .Y(n871) );
  NAND2X1 U94 ( .A(n885), .B(n343), .Y(n347) );
  NAND4X1 U95 ( .A(n544), .B(n545), .C(n546), .D(n547), .Y(n343) );
  NOR4X1 U96 ( .A(n627), .B(n628), .C(n629), .D(n630), .Y(n544) );
  NOR4X1 U97 ( .A(n613), .B(n614), .C(n615), .D(n616), .Y(n545) );
  NOR4X1 U98 ( .A(n599), .B(n600), .C(n601), .D(n602), .Y(n546) );
  CLKINVX1 U99 ( .A(N911), .Y(n862) );
  CLKINVX1 U100 ( .A(N912), .Y(n861) );
  CLKINVX1 U101 ( .A(N913), .Y(n860) );
  CLKINVX1 U102 ( .A(N908), .Y(n865) );
  CLKINVX1 U103 ( .A(N914), .Y(n857) );
  CLKINVX1 U104 ( .A(N909), .Y(n864) );
  CLKINVX1 U105 ( .A(N910), .Y(n863) );
  CLKINVX1 U106 ( .A(N907), .Y(n866) );
  CLKINVX1 U107 ( .A(n561), .Y(n875) );
  AOI211X1 U108 ( .A0(n366), .A1(n881), .B0(n868), .C0(n367), .Y(n305) );
  CLKINVX1 U109 ( .A(n344), .Y(n881) );
  CLKINVX1 U110 ( .A(n271), .Y(n868) );
  CLKINVX1 U111 ( .A(n632), .Y(n876) );
  CLKINVX1 U112 ( .A(n557), .Y(n844) );
  CLKINVX1 U113 ( .A(n611), .Y(n852) );
  CLKINVX1 U114 ( .A(n606), .Y(n843) );
  CLKINVX1 U115 ( .A(n634), .Y(n877) );
  CLKINVX1 U116 ( .A(n625), .Y(n851) );
  CLKINVX1 U117 ( .A(n559), .Y(n848) );
  CLKINVX1 U118 ( .A(n620), .Y(n842) );
  CLKINVX1 U119 ( .A(n641), .Y(n850) );
  CLKINVX1 U120 ( .A(n636), .Y(n841) );
  CLKINVX1 U121 ( .A(n564), .Y(n853) );
  NAND2BX1 U122 ( .AN(n379), .B(n887), .Y(n360) );
  NAND2X1 U123 ( .A(n325), .B(n269), .Y(n304) );
  NAND2X1 U124 ( .A(n882), .B(n871), .Y(n353) );
  NAND2X1 U125 ( .A(n882), .B(n327), .Y(n271) );
  OAI2BB2XL U126 ( .B0(n344), .B1(n366), .A0N(n378), .A1N(n888), .Y(n358) );
  NAND2X1 U127 ( .A(n382), .B(n335), .Y(n308) );
  CLKINVX1 U128 ( .A(n370), .Y(n884) );
  CLKINVX1 U129 ( .A(n294), .Y(n838) );
  NAND4X1 U130 ( .A(N909), .B(n866), .C(n649), .D(n650), .Y(n387) );
  NOR2X1 U131 ( .A(N910), .B(N908), .Y(n649) );
  NOR4X1 U132 ( .A(N914), .B(N913), .C(N912), .D(N911), .Y(n650) );
  NAND2X1 U133 ( .A(n375), .B(n376), .Y(n346) );
  NAND2X1 U134 ( .A(n867), .B(n308), .Y(n324) );
  NAND2X1 U135 ( .A(n351), .B(n651), .Y(n335) );
  NAND4X1 U136 ( .A(n652), .B(n653), .C(n654), .D(n655), .Y(n651) );
  NOR4X1 U137 ( .A(n721), .B(n722), .C(n723), .D(n724), .Y(n652) );
  NOR4X1 U138 ( .A(n708), .B(n709), .C(n710), .D(n711), .Y(n653) );
  CLKINVX1 U139 ( .A(n328), .Y(n918) );
  NOR2X1 U140 ( .A(n886), .B(n882), .Y(n359) );
  NOR2BX1 U141 ( .AN(n283), .B(n393), .Y(n392) );
  NAND3X1 U142 ( .A(n283), .B(n284), .C(n891), .Y(n281) );
  AND2X2 U143 ( .A(n283), .B(n281), .Y(n282) );
  NAND2X1 U144 ( .A(n283), .B(n648), .Y(n277) );
  NAND2X1 U145 ( .A(n283), .B(n277), .Y(n279) );
  OAI211X1 U146 ( .A0(n308), .A1(n310), .B0(n839), .C0(n354), .Y(n300) );
  CLKINVX1 U147 ( .A(n358), .Y(n839) );
  AOI211X1 U148 ( .A0(n355), .A1(n298), .B0(n884), .C0(n356), .Y(n354) );
  CLKINVX1 U149 ( .A(n332), .Y(n355) );
  OAI211X1 U150 ( .A0(n870), .A1(n289), .B0(n290), .C0(n291), .Y(n284) );
  CLKINVX1 U151 ( .A(n301), .Y(n870) );
  AOI211X1 U152 ( .A0(n292), .A1(n293), .B0(n294), .C0(n295), .Y(n291) );
  CLKINVX1 U153 ( .A(n300), .Y(n290) );
  OAI21X1 U154 ( .A0(n646), .A1(n647), .B0(n289), .Y(n293) );
  NAND4XL U155 ( .A(N904), .B(N905), .C(N903), .D(N901), .Y(n647) );
  NAND4X1 U156 ( .A(n2), .B(n1), .C(n897), .D(n893), .Y(n646) );
  OR3X2 U157 ( .A(n15), .B(n16), .C(n17), .Y(N608) );
  XOR2X1 U158 ( .A(n542), .B(n543), .Y(n15) );
  XOR2X1 U159 ( .A(n540), .B(n541), .Y(n16) );
  XOR2X1 U160 ( .A(n537), .B(n538), .Y(n17) );
  NAND2X1 U161 ( .A(n515), .B(n276), .Y(n297) );
  XNOR2X1 U162 ( .A(n247), .B(n248), .Y(n246) );
  OAI22XL U163 ( .A0(n834), .A1(n2), .B0(n835), .B1(n866), .Y(n247) );
  OAI22XL U164 ( .A0(n834), .A1(n866), .B0(n835), .B1(n2), .Y(n248) );
  NAND4X1 U165 ( .A(n2), .B(n1), .C(n740), .D(n741), .Y(n648) );
  NOR4X1 U166 ( .A(n898), .B(n896), .C(n894), .D(n938), .Y(n741) );
  NOR3XL U167 ( .A(N902), .B(N906), .C(N904), .Y(n740) );
  CLKINVX1 U168 ( .A(n386), .Y(n890) );
  NOR2X1 U169 ( .A(n386), .B(n357), .Y(n515) );
  XNOR2X1 U170 ( .A(n261), .B(n262), .Y(n260) );
  OAI22XL U171 ( .A0(n834), .A1(n896), .B0(n835), .B1(n862), .Y(n261) );
  OAI22XL U172 ( .A0(n834), .A1(n862), .B0(n835), .B1(n896), .Y(n262) );
  XNOR2X1 U173 ( .A(n251), .B(n252), .Y(n245) );
  OAI22XL U174 ( .A0(n834), .A1(n1), .B0(n835), .B1(n865), .Y(n251) );
  OAI22XL U175 ( .A0(n834), .A1(n865), .B0(n835), .B1(n1), .Y(n252) );
  XNOR2X1 U176 ( .A(n263), .B(n264), .Y(n259) );
  OAI22XL U177 ( .A0(n834), .A1(n895), .B0(n835), .B1(n861), .Y(n263) );
  OAI22XL U178 ( .A0(n834), .A1(n861), .B0(n835), .B1(n895), .Y(n264) );
  INVXL U179 ( .A(N904), .Y(n895) );
  XNOR2X1 U180 ( .A(n253), .B(n254), .Y(n244) );
  OAI22XL U181 ( .A0(n834), .A1(n898), .B0(n835), .B1(n864), .Y(n253) );
  OAI22XL U182 ( .A0(n834), .A1(n864), .B0(n835), .B1(n898), .Y(n254) );
  XNOR2X1 U183 ( .A(n265), .B(n266), .Y(n258) );
  OAI22XL U184 ( .A0(n834), .A1(n894), .B0(n835), .B1(n860), .Y(n265) );
  OAI22XL U185 ( .A0(n834), .A1(n860), .B0(n835), .B1(n894), .Y(n266) );
  NOR2X1 U186 ( .A(n511), .B(n512), .Y(n453) );
  OAI222XL U187 ( .A0(n513), .A1(n325), .B0(n310), .B1(n382), .C0(n374), .C1(
        n514), .Y(n512) );
  OAI211X1 U188 ( .A0(n310), .A1(n335), .B0(n533), .C0(n377), .Y(n511) );
  AOI211X1 U189 ( .A0(n515), .A1(n886), .B0(n516), .C0(n307), .Y(n514) );
  XNOR2X1 U190 ( .A(n255), .B(n256), .Y(n243) );
  OAI22XL U192 ( .A0(n834), .A1(n897), .B0(n835), .B1(n863), .Y(n255) );
  OAI22XL U193 ( .A0(n834), .A1(n863), .B0(n835), .B1(n897), .Y(n256) );
  OAI22XL U194 ( .A0(n834), .A1(n857), .B0(n835), .B1(n893), .Y(n268) );
  OAI22XL U195 ( .A0(n834), .A1(n893), .B0(n835), .B1(n857), .Y(n267) );
  CLKBUFX3 U196 ( .A(n91), .Y(n97) );
  NOR2X1 U197 ( .A(n181), .B(n182), .Y(n91) );
  INVX1 U198 ( .A(N905), .Y(n894) );
  INVX1 U199 ( .A(N903), .Y(n896) );
  INVX1 U200 ( .A(N901), .Y(n898) );
  AOI221XL U201 ( .A0(n885), .A1(n313), .B0(n314), .B1(n315), .C0(n316), .Y(
        n312) );
  OAI21XL U202 ( .A0(N608), .A1(n871), .B0(n293), .Y(n314) );
  OAI21XL U203 ( .A0(n374), .A1(n293), .B0(n298), .Y(n313) );
  CLKINVX1 U204 ( .A(n302), .Y(n288) );
  OAI222XL U205 ( .A0(n328), .A1(n329), .B0(n330), .B1(n331), .C0(N608), .C1(
        n332), .Y(n320) );
  AOI211X1 U206 ( .A0(n888), .A1(n333), .B0(n334), .C0(n837), .Y(n330) );
  NAND2X1 U207 ( .A(n858), .B(n335), .Y(n333) );
  CLKINVX1 U208 ( .A(n388), .Y(n383) );
  OAI221XL U209 ( .A0(n352), .A1(n381), .B0(n347), .B1(n389), .C0(n374), .Y(
        n388) );
  OAI31XL U210 ( .A0(n369), .A1(n871), .A2(n359), .B0(n310), .Y(n363) );
  CLKINVX1 U211 ( .A(n338), .Y(n369) );
  INVX3 U212 ( .A(n836), .Y(n95) );
  AOI21X1 U213 ( .A0(n338), .A1(n339), .B0(n340), .Y(n337) );
  OAI21XL U214 ( .A0(n871), .A1(n326), .B0(n347), .Y(n339) );
  OAI33X1 U215 ( .A0(n341), .A1(n342), .A2(n343), .B0(n344), .B1(n859), .B2(
        n345), .Y(n340) );
  CLKINVX1 U216 ( .A(n346), .Y(n859) );
  NAND2X2 U217 ( .A(n837), .B(n331), .Y(n454) );
  NOR4X1 U218 ( .A(n548), .B(n549), .C(n550), .D(n551), .Y(n547) );
  OAI22XL U219 ( .A0(n556), .A1(n557), .B0(n558), .B1(n559), .Y(n550) );
  OAI22XL U220 ( .A0(n552), .A1(n553), .B0(n554), .B1(n555), .Y(n551) );
  OAI22XL U221 ( .A0(n560), .A1(n561), .B0(n562), .B1(n351), .Y(n549) );
  CLKBUFX3 U222 ( .A(n806), .Y(n832) );
  NAND2X1 U223 ( .A(n111), .B(n110), .Y(n806) );
  CLKBUFX3 U224 ( .A(n804), .Y(n830) );
  NAND2X1 U225 ( .A(n111), .B(n108), .Y(n804) );
  CLKBUFX3 U226 ( .A(n792), .Y(n822) );
  NAND2X1 U227 ( .A(n108), .B(n101), .Y(n792) );
  CLKBUFX3 U228 ( .A(n794), .Y(n824) );
  NAND2X1 U229 ( .A(n110), .B(n101), .Y(n794) );
  CLKBUFX3 U230 ( .A(n802), .Y(n826) );
  NAND2X1 U231 ( .A(n106), .B(n107), .Y(n802) );
  CLKBUFX3 U232 ( .A(n807), .Y(n831) );
  NAND2X1 U233 ( .A(n111), .B(n109), .Y(n807) );
  CLKBUFX3 U234 ( .A(n800), .Y(n828) );
  NAND2X1 U235 ( .A(n106), .B(n110), .Y(n800) );
  CLKBUFX3 U236 ( .A(n805), .Y(n829) );
  NAND2XL U237 ( .A(n111), .B(n107), .Y(n805) );
  CLKBUFX3 U238 ( .A(n795), .Y(n823) );
  NAND2X1 U239 ( .A(n101), .B(n109), .Y(n795) );
  CLKBUFX3 U240 ( .A(n790), .Y(n820) );
  NAND2X1 U241 ( .A(n100), .B(n110), .Y(n790) );
  CLKBUFX3 U242 ( .A(n793), .Y(n821) );
  NAND2XL U243 ( .A(n107), .B(n101), .Y(n793) );
  CLKBUFX3 U244 ( .A(n808), .Y(n818) );
  NAND2X1 U245 ( .A(n100), .B(n108), .Y(n808) );
  CLKBUFX3 U246 ( .A(n801), .Y(n825) );
  NAND2XL U247 ( .A(n106), .B(n108), .Y(n801) );
  CLKBUFX3 U248 ( .A(n803), .Y(n827) );
  NAND2XL U249 ( .A(n106), .B(n109), .Y(n803) );
  CLKBUFX3 U250 ( .A(n789), .Y(n817) );
  NAND2XL U251 ( .A(n100), .B(n107), .Y(n789) );
  CLKBUFX3 U252 ( .A(n791), .Y(n819) );
  NAND2XL U253 ( .A(n100), .B(n109), .Y(n791) );
  NAND2X1 U254 ( .A(n692), .B(n683), .Y(n561) );
  NAND2X1 U255 ( .A(n698), .B(n705), .Y(n592) );
  NAND2X1 U256 ( .A(n684), .B(n683), .Y(n555) );
  NAND2X1 U257 ( .A(n698), .B(n684), .Y(n596) );
  OAI211X1 U258 ( .A0(n377), .A1(n378), .B0(n336), .C0(n360), .Y(n367) );
  OR2X1 U259 ( .A(n380), .B(n331), .Y(n336) );
  AOI33X1 U260 ( .A0(n357), .A1(n890), .A2(n276), .B0(n887), .B1(n289), .B2(
        n323), .Y(n380) );
  NAND2X1 U261 ( .A(n712), .B(n705), .Y(n573) );
  NAND2X1 U262 ( .A(n698), .B(n692), .Y(n591) );
  NAND2X1 U263 ( .A(n712), .B(n684), .Y(n577) );
  NAND2X1 U264 ( .A(n725), .B(n687), .Y(n632) );
  NAND2X1 U265 ( .A(n698), .B(n687), .Y(n595) );
  NAND2X1 U266 ( .A(n687), .B(n683), .Y(n553) );
  NAND2X1 U267 ( .A(n682), .B(n683), .Y(n557) );
  NAND2X1 U268 ( .A(n689), .B(n683), .Y(n611) );
  NAND2X1 U269 ( .A(n712), .B(n692), .Y(n572) );
  NAND2X1 U270 ( .A(n698), .B(n682), .Y(n606) );
  NAND2X1 U271 ( .A(n688), .B(n683), .Y(n589) );
  NAND2X1 U272 ( .A(n712), .B(n687), .Y(n576) );
  NAND2X1 U273 ( .A(n725), .B(n684), .Y(n634) );
  NAND2X1 U274 ( .A(n698), .B(n689), .Y(n625) );
  NAND2X1 U275 ( .A(n685), .B(n683), .Y(n559) );
  NAND2X1 U276 ( .A(n698), .B(n685), .Y(n593) );
  NAND2X1 U277 ( .A(n698), .B(n688), .Y(n597) );
  NAND2X1 U278 ( .A(n712), .B(n682), .Y(n620) );
  NAND2X1 U279 ( .A(n712), .B(n685), .Y(n574) );
  NAND2X1 U280 ( .A(n712), .B(n689), .Y(n641) );
  NAND2X1 U281 ( .A(n725), .B(n705), .Y(n581) );
  NAND2X1 U282 ( .A(n712), .B(n688), .Y(n578) );
  NAND2X1 U283 ( .A(n725), .B(n682), .Y(n636) );
  NAND2X1 U284 ( .A(n725), .B(n692), .Y(n580) );
  NAND2X1 U285 ( .A(n725), .B(n685), .Y(n582) );
  INVX1 U286 ( .A(N902), .Y(n897) );
  NAND2X1 U287 ( .A(n725), .B(n688), .Y(n564) );
  INVX1 U288 ( .A(N906), .Y(n893) );
  OAI21XL U289 ( .A0(n326), .A1(n513), .B0(n517), .Y(n516) );
  AO21X1 U290 ( .A0(n397), .A1(n357), .B0(n299), .Y(n517) );
  NAND3X1 U291 ( .A(n276), .B(n890), .C(n357), .Y(n325) );
  OAI21XL U292 ( .A0(n298), .A1(n297), .B0(n305), .Y(n365) );
  CLKINVX1 U293 ( .A(match_enable), .Y(n938) );
  NAND3X1 U294 ( .A(n331), .B(n289), .C(n323), .Y(n379) );
  OR3X2 U295 ( .A(n887), .B(n275), .C(n276), .Y(n274) );
  INVX3 U296 ( .A(n331), .Y(n867) );
  NOR2X1 U297 ( .A(n331), .B(n871), .Y(n327) );
  NOR2X1 U298 ( .A(n345), .B(n357), .Y(n381) );
  CLKINVX1 U299 ( .A(n342), .Y(n885) );
  CLKINVX1 U300 ( .A(n299), .Y(n882) );
  CLKINVX1 U301 ( .A(n309), .Y(n883) );
  CLKBUFX3 U302 ( .A(n50), .Y(n56) );
  NOR2X1 U303 ( .A(n920), .B(n919), .Y(n50) );
  CLKINVX1 U304 ( .A(n322), .Y(n887) );
  OAI32X1 U305 ( .A0(n398), .A1(n867), .A2(n858), .B0(n840), .B1(n399), .Y(
        n378) );
  CLKINVX1 U306 ( .A(n335), .Y(n840) );
  CLKINVX1 U307 ( .A(n399), .Y(n858) );
  XOR2X1 U308 ( .A(n860), .B(n405), .Y(n414) );
  OAI2BB1X1 U309 ( .A0N(n376), .A1N(n375), .B0(n345), .Y(n366) );
  NAND2X1 U310 ( .A(n410), .B(n411), .Y(n376) );
  NOR4X1 U311 ( .A(n434), .B(n435), .C(n436), .D(n437), .Y(n410) );
  NOR4X1 U312 ( .A(n412), .B(n413), .C(n414), .D(n415), .Y(n411) );
  XOR2X1 U313 ( .A(N907), .B(n407), .Y(n434) );
  XOR2X1 U314 ( .A(n861), .B(n404), .Y(n413) );
  XOR2X1 U315 ( .A(n864), .B(n402), .Y(n436) );
  NAND2X1 U316 ( .A(n399), .B(n398), .Y(n382) );
  XOR2X1 U317 ( .A(n862), .B(n403), .Y(n412) );
  XOR2X1 U318 ( .A(N914), .B(n406), .Y(n415) );
  XOR2X1 U319 ( .A(N910), .B(n409), .Y(n437) );
  NAND2X1 U320 ( .A(n299), .B(n326), .Y(n315) );
  XOR2X1 U321 ( .A(N908), .B(n408), .Y(n435) );
  XOR2X1 U322 ( .A(n857), .B(n466), .Y(n465) );
  AND2X2 U323 ( .A(n460), .B(n461), .Y(n389) );
  NOR4X1 U324 ( .A(n470), .B(n471), .C(n472), .D(n473), .Y(n460) );
  NOR4X1 U325 ( .A(n462), .B(n463), .C(n464), .D(n465), .Y(n461) );
  XOR2X1 U326 ( .A(n866), .B(n477), .Y(n470) );
  CLKINVX1 U327 ( .A(n345), .Y(n892) );
  NOR2X1 U328 ( .A(n478), .B(n479), .Y(n455) );
  NAND4X1 U329 ( .A(n467), .B(n468), .C(n469), .D(n475), .Y(n478) );
  XOR2X1 U330 ( .A(n863), .B(n474), .Y(n473) );
  XOR2X1 U331 ( .A(n865), .B(n476), .Y(n471) );
  XOR2X1 U332 ( .A(N913), .B(n467), .Y(n464) );
  XOR2X1 U333 ( .A(N912), .B(n468), .Y(n463) );
  XOR2X1 U334 ( .A(N909), .B(n475), .Y(n472) );
  XOR2X1 U335 ( .A(N911), .B(n469), .Y(n462) );
  NOR4X1 U336 ( .A(n656), .B(n657), .C(n658), .D(n659), .Y(n655) );
  OAI22XL U337 ( .A0(n560), .A1(n557), .B0(n562), .B1(n559), .Y(n657) );
  OAI22XL U338 ( .A0(n556), .A1(n553), .B0(n558), .B1(n555), .Y(n658) );
  OAI22XL U340 ( .A0(n552), .A1(n611), .B0(n554), .B1(n589), .Y(n659) );
  NOR2XL U341 ( .A(valid), .B(n890), .Y(n752) );
  OAI21X1 U342 ( .A0(n368), .A1(n323), .B0(n316), .Y(n329) );
  NOR2BX2 U343 ( .AN(n451), .B(n836), .Y(n423) );
  NAND2X1 U344 ( .A(n323), .B(n368), .Y(n328) );
  OAI22XL U345 ( .A0(n603), .A1(n625), .B0(n604), .B1(n597), .Y(n697) );
  NOR4X1 U346 ( .A(n694), .B(n695), .C(n696), .D(n697), .Y(n654) );
  OAI22XL U347 ( .A0(n610), .A1(n591), .B0(n612), .B1(n592), .Y(n694) );
  OAI22XL U348 ( .A0(n608), .A1(n606), .B0(n609), .B1(n593), .Y(n695) );
  OAI22XL U349 ( .A0(n605), .A1(n595), .B0(n607), .B1(n596), .Y(n696) );
  NOR3X2 U350 ( .A(n919), .B(n54), .C(n920), .Y(n487) );
  NAND2X1 U351 ( .A(n725), .B(n689), .Y(n676) );
  NAND2X1 U352 ( .A(n400), .B(n401), .Y(n375) );
  NOR4X1 U353 ( .A(n406), .B(n407), .C(n408), .D(n409), .Y(n400) );
  NOR4X1 U354 ( .A(n402), .B(n403), .C(n404), .D(n405), .Y(n401) );
  NAND4X1 U355 ( .A(n477), .B(n476), .C(n474), .D(n466), .Y(n479) );
  INVX3 U356 ( .A(n513), .Y(n891) );
  AO21X1 U357 ( .A0(n886), .A1(n298), .B0(n275), .Y(n292) );
  CLKINVX1 U358 ( .A(n311), .Y(n889) );
  NAND2X1 U359 ( .A(n883), .B(n452), .Y(n344) );
  CLKINVX1 U360 ( .A(n377), .Y(n888) );
  CLKINVX1 U361 ( .A(n368), .Y(n921) );
  NOR2X2 U362 ( .A(ispattern), .B(isstring), .Y(n283) );
  CLKINVX1 U363 ( .A(n394), .Y(n393) );
  OAI31XL U364 ( .A0(n395), .A1(n358), .A2(n396), .B0(n283), .Y(n394) );
  OAI31XL U365 ( .A0(n397), .A1(n322), .A2(n379), .B0(n869), .Y(n396) );
  AO22X1 U366 ( .A0(n392), .A1(N251), .B0(N286), .B1(n393), .Y(n761) );
  AO22X1 U367 ( .A0(n392), .A1(N254), .B0(N289), .B1(n393), .Y(n757) );
  AO22X1 U368 ( .A0(n392), .A1(N250), .B0(n170), .B1(n393), .Y(n760) );
  AO22X1 U369 ( .A0(n392), .A1(N252), .B0(N287), .B1(n393), .Y(n759) );
  AO22X1 U370 ( .A0(n392), .A1(N253), .B0(N288), .B1(n393), .Y(n758) );
  OAI2BB2XL U371 ( .B0(n281), .B1(n170), .A0N(match_index[0]), .A1N(n282), .Y(
        n748) );
  OAI2BB2XL U372 ( .B0(n281), .B1(n168), .A0N(match_index[2]), .A1N(n282), .Y(
        n745) );
  OAI2BB2XL U373 ( .B0(n281), .B1(n157), .A0N(match_index[4]), .A1N(n282), .Y(
        n747) );
  OAI2BB2XL U374 ( .B0(n281), .B1(n167), .A0N(match_index[3]), .A1N(n282), .Y(
        n746) );
  OAI2BB2XL U375 ( .B0(n281), .B1(n169), .A0N(match_index[1]), .A1N(n282), .Y(
        n744) );
  OAI22XL U376 ( .A0(n277), .A1(n197), .B0(n278), .B1(n279), .Y(n742) );
  OAI22XL U377 ( .A0(n277), .A1(n198), .B0(n280), .B1(n279), .Y(n743) );
  OAI22XL U378 ( .A0(n277), .A1(n199), .B0(n836), .B1(n279), .Y(n762) );
  OAI22XL U379 ( .A0(n539), .A1(n54), .B0(n454), .B1(n183), .Y(n541) );
  NAND2BX1 U380 ( .AN(star_flag_temp), .B(n648), .Y(n386) );
  CLKBUFX3 U381 ( .A(n89), .Y(n98) );
  NOR2X1 U382 ( .A(n182), .B(N249), .Y(n89) );
  OAI22XL U383 ( .A0(n539), .A1(n920), .B0(n454), .B1(n181), .Y(n538) );
  OAI22XL U384 ( .A0(n539), .A1(n919), .B0(n454), .B1(n182), .Y(n543) );
  AND3X2 U385 ( .A(n269), .B(n270), .C(n271), .Y(n250) );
  OAI222XL U386 ( .A0(n285), .A1(n199), .B0(N247), .B1(n286), .C0(n183), .C1(
        n287), .Y(n750) );
  OAI222XL U387 ( .A0(n197), .A1(n285), .B0(n278), .B1(n286), .C0(n181), .C1(
        n287), .Y(n749) );
  OAI222XL U388 ( .A0(n198), .A1(n285), .B0(n280), .B1(n286), .C0(n182), .C1(
        n287), .Y(n751) );
  OAI22XL U389 ( .A0(n539), .A1(n183), .B0(n454), .B1(n54), .Y(n540) );
  OAI22XL U390 ( .A0(n539), .A1(n181), .B0(n454), .B1(n920), .Y(n537) );
  OAI22XL U391 ( .A0(n539), .A1(n182), .B0(n454), .B1(n919), .Y(n542) );
  CLKBUFX3 U392 ( .A(n88), .Y(n99) );
  NOR2X1 U393 ( .A(N248), .B(N249), .Y(n88) );
  CLKBUFX3 U394 ( .A(n92), .Y(n96) );
  NOR2X1 U395 ( .A(n181), .B(N248), .Y(n92) );
  NAND4BBXL U396 ( .AN(n303), .BN(n304), .C(n305), .D(n306), .Y(n302) );
  AOI222XL U397 ( .A0(n296), .A1(n307), .B0(n880), .B1(n308), .C0(
        cur_match_state[3]), .C1(n309), .Y(n306) );
  OAI221XL U398 ( .A0(n309), .A1(n311), .B0(\r534/EQ_NE ), .B1(n869), .C0(n312), .Y(n303) );
  CLKINVX1 U399 ( .A(n310), .Y(n880) );
  OAI22XL U400 ( .A0(match_enable), .A1(n192), .B0(n318), .B1(n938), .Y(n753)
         );
  NOR4X1 U401 ( .A(n319), .B(n320), .C(n304), .D(n321), .Y(n318) );
  OAI22XL U402 ( .A0(n322), .A1(n323), .B0(n310), .B1(n324), .Y(n321) );
  NAND4X1 U403 ( .A(n297), .B(n336), .C(n299), .D(n337), .Y(n319) );
  AOI21X1 U404 ( .A0(N608), .A1(n296), .B0(n297), .Y(n295) );
  NAND2X1 U405 ( .A(star_flag_temp), .B(n302), .Y(n285) );
  OAI22XL U406 ( .A0(match_enable), .A1(n193), .B0(n348), .B1(n938), .Y(n754)
         );
  NOR4X1 U407 ( .A(n349), .B(n350), .C(n300), .D(n301), .Y(n348) );
  AOI21X1 U408 ( .A0(n329), .A1(n322), .B0(n323), .Y(n349) );
  OAI31XL U409 ( .A0(n359), .A1(n867), .A2(n338), .B0(n360), .Y(n350) );
  OAI22XL U410 ( .A0(match_enable), .A1(n196), .B0(n371), .B1(n938), .Y(n756)
         );
  NOR4X1 U411 ( .A(n372), .B(n373), .C(n367), .D(n334), .Y(n371) );
  OAI22XL U412 ( .A0(n310), .A1(n324), .B0(n381), .B1(n271), .Y(n373) );
  OAI221XL U413 ( .A0(n918), .A1(n329), .B0(n383), .B1(n331), .C0(n384), .Y(
        n372) );
  OAI22XL U414 ( .A0(match_enable), .A1(n195), .B0(n361), .B1(n938), .Y(n755)
         );
  NOR4X1 U415 ( .A(n362), .B(n363), .C(n364), .D(n365), .Y(n361) );
  AO22X1 U416 ( .A0(n921), .A1(n316), .B0(n886), .B1(n327), .Y(n364) );
  NAND3X1 U417 ( .A(n332), .B(n370), .C(n342), .Y(n362) );
  CLKBUFX3 U418 ( .A(N247), .Y(n836) );
  AOI221XL U419 ( .A0(\string_buffer[3][5] ), .A1(n848), .B0(
        \string_buffer[4][5] ), .B1(n844), .C0(n587), .Y(n586) );
  AO22X1 U420 ( .A0(n875), .A1(\string_buffer[2][5] ), .B0(n871), .B1(
        \string_buffer[1][5] ), .Y(n587) );
  NOR4X1 U421 ( .A(n598), .B(\string_buffer[31][0] ), .C(
        \string_buffer[31][2] ), .D(\string_buffer[31][1] ), .Y(n563) );
  NAND4X1 U422 ( .A(n567), .B(n568), .C(n569), .D(n570), .Y(n566) );
  NAND4X1 U423 ( .A(n583), .B(n584), .C(n585), .D(n586), .Y(n565) );
  AOI221XL U424 ( .A0(\string_buffer[11][5] ), .A1(n847), .B0(
        \string_buffer[12][5] ), .B1(n843), .C0(n590), .Y(n584) );
  CLKINVX1 U425 ( .A(n593), .Y(n847) );
  OAI22XL U426 ( .A0(n591), .A1(n909), .B0(n592), .B1(n899), .Y(n590) );
  CLKINVX1 U427 ( .A(\string_buffer[10][5] ), .Y(n909) );
  AOI221XL U428 ( .A0(\string_buffer[7][5] ), .A1(n856), .B0(
        \string_buffer[8][5] ), .B1(n852), .C0(n588), .Y(n585) );
  CLKINVX1 U429 ( .A(n589), .Y(n856) );
  OAI22XL U430 ( .A0(n553), .A1(n915), .B0(n555), .B1(n903), .Y(n588) );
  CLKINVX1 U431 ( .A(\string_buffer[6][5] ), .Y(n915) );
  AOI221XL U432 ( .A0(\string_buffer[15][5] ), .A1(n855), .B0(
        \string_buffer[16][5] ), .B1(n851), .C0(n594), .Y(n583) );
  CLKINVX1 U433 ( .A(n597), .Y(n855) );
  OAI22XL U434 ( .A0(n595), .A1(n916), .B0(n596), .B1(n904), .Y(n594) );
  CLKINVX1 U435 ( .A(\string_buffer[14][5] ), .Y(n916) );
  AOI221XL U436 ( .A0(\string_buffer[19][5] ), .A1(n846), .B0(
        \string_buffer[20][5] ), .B1(n842), .C0(n571), .Y(n570) );
  CLKINVX1 U437 ( .A(n574), .Y(n846) );
  OAI22XL U438 ( .A0(n572), .A1(n910), .B0(n573), .B1(n900), .Y(n571) );
  CLKINVX1 U439 ( .A(\string_buffer[18][5] ), .Y(n910) );
  AOI221XL U440 ( .A0(\string_buffer[23][5] ), .A1(n854), .B0(
        \string_buffer[24][5] ), .B1(n850), .C0(n575), .Y(n569) );
  CLKINVX1 U441 ( .A(n578), .Y(n854) );
  OAI22XL U442 ( .A0(n576), .A1(n917), .B0(n577), .B1(n905), .Y(n575) );
  CLKINVX1 U443 ( .A(\string_buffer[22][5] ), .Y(n917) );
  AOI222XL U444 ( .A0(\string_buffer[31][5] ), .A1(n853), .B0(
        \string_buffer[29][5] ), .B1(n877), .C0(\string_buffer[30][5] ), .C1(
        n876), .Y(n567) );
  AOI221XL U445 ( .A0(\string_buffer[27][5] ), .A1(n845), .B0(
        \string_buffer[28][5] ), .B1(n841), .C0(n579), .Y(n568) );
  CLKINVX1 U446 ( .A(n582), .Y(n845) );
  OAI22XL U447 ( .A0(n580), .A1(n911), .B0(n581), .B1(n901), .Y(n579) );
  CLKINVX1 U448 ( .A(\string_buffer[26][5] ), .Y(n911) );
  NOR4X1 U449 ( .A(\string_buffer[5][2] ), .B(\string_buffer[5][1] ), .C(
        \string_buffer[5][0] ), .D(n660), .Y(n554) );
  OR4X1 U450 ( .A(\string_buffer[5][4] ), .B(\string_buffer[5][3] ), .C(
        \string_buffer[5][7] ), .D(\string_buffer[5][6] ), .Y(n660) );
  NOR4X1 U451 ( .A(\string_buffer[6][2] ), .B(\string_buffer[6][1] ), .C(
        \string_buffer[6][0] ), .D(n661), .Y(n552) );
  OR4X1 U452 ( .A(\string_buffer[6][4] ), .B(\string_buffer[6][3] ), .C(
        \string_buffer[6][7] ), .D(\string_buffer[6][6] ), .Y(n661) );
  NOR4X1 U453 ( .A(\string_buffer[13][2] ), .B(\string_buffer[13][1] ), .C(
        \string_buffer[13][0] ), .D(n699), .Y(n604) );
  OR4X1 U454 ( .A(\string_buffer[13][4] ), .B(\string_buffer[13][3] ), .C(
        \string_buffer[13][7] ), .D(\string_buffer[13][6] ), .Y(n699) );
  NOR4X1 U455 ( .A(\string_buffer[14][2] ), .B(\string_buffer[14][1] ), .C(
        \string_buffer[14][0] ), .D(n700), .Y(n603) );
  OR4X1 U456 ( .A(\string_buffer[14][4] ), .B(\string_buffer[14][3] ), .C(
        \string_buffer[14][7] ), .D(\string_buffer[14][6] ), .Y(n700) );
  NOR4X1 U457 ( .A(\string_buffer[21][2] ), .B(\string_buffer[21][1] ), .C(
        \string_buffer[21][0] ), .D(n713), .Y(n618) );
  OR4X1 U458 ( .A(\string_buffer[21][4] ), .B(\string_buffer[21][3] ), .C(
        \string_buffer[21][7] ), .D(\string_buffer[21][6] ), .Y(n713) );
  NOR4X1 U459 ( .A(\string_buffer[22][2] ), .B(\string_buffer[22][1] ), .C(
        \string_buffer[22][0] ), .D(n714), .Y(n617) );
  OR4X1 U460 ( .A(\string_buffer[22][4] ), .B(\string_buffer[22][3] ), .C(
        \string_buffer[22][7] ), .D(\string_buffer[22][6] ), .Y(n714) );
  NOR4X1 U461 ( .A(\string_buffer[3][2] ), .B(\string_buffer[3][1] ), .C(
        \string_buffer[3][0] ), .D(n662), .Y(n558) );
  OR4X1 U462 ( .A(\string_buffer[3][4] ), .B(\string_buffer[3][3] ), .C(
        \string_buffer[3][7] ), .D(\string_buffer[3][6] ), .Y(n662) );
  NOR4X1 U463 ( .A(\string_buffer[4][2] ), .B(\string_buffer[4][1] ), .C(
        \string_buffer[4][0] ), .D(n663), .Y(n556) );
  OR4X1 U464 ( .A(\string_buffer[4][4] ), .B(\string_buffer[4][3] ), .C(
        \string_buffer[4][7] ), .D(\string_buffer[4][6] ), .Y(n663) );
  NOR4X1 U465 ( .A(\string_buffer[11][2] ), .B(\string_buffer[11][1] ), .C(
        \string_buffer[11][0] ), .D(n701), .Y(n607) );
  OR4X1 U466 ( .A(\string_buffer[11][4] ), .B(\string_buffer[11][3] ), .C(
        \string_buffer[11][7] ), .D(\string_buffer[11][6] ), .Y(n701) );
  NOR4X1 U467 ( .A(\string_buffer[12][2] ), .B(\string_buffer[12][1] ), .C(
        \string_buffer[12][0] ), .D(n702), .Y(n605) );
  OR4X1 U468 ( .A(\string_buffer[12][4] ), .B(\string_buffer[12][3] ), .C(
        \string_buffer[12][7] ), .D(\string_buffer[12][6] ), .Y(n702) );
  NOR4X1 U469 ( .A(\string_buffer[29][2] ), .B(\string_buffer[29][1] ), .C(
        \string_buffer[29][0] ), .D(n726), .Y(n633) );
  OR4X1 U470 ( .A(\string_buffer[29][4] ), .B(\string_buffer[29][3] ), .C(
        \string_buffer[29][7] ), .D(\string_buffer[29][6] ), .Y(n726) );
  NOR4X1 U471 ( .A(\string_buffer[30][2] ), .B(\string_buffer[30][1] ), .C(
        \string_buffer[30][0] ), .D(n727), .Y(n631) );
  OR4X1 U472 ( .A(\string_buffer[30][4] ), .B(\string_buffer[30][3] ), .C(
        \string_buffer[30][7] ), .D(\string_buffer[30][6] ), .Y(n727) );
  NOR4X1 U473 ( .A(\string_buffer[19][2] ), .B(\string_buffer[19][1] ), .C(
        \string_buffer[19][0] ), .D(n715), .Y(n621) );
  OR4X1 U474 ( .A(\string_buffer[19][4] ), .B(\string_buffer[19][3] ), .C(
        \string_buffer[19][7] ), .D(\string_buffer[19][6] ), .Y(n715) );
  NOR4X1 U475 ( .A(\string_buffer[20][2] ), .B(\string_buffer[20][1] ), .C(
        \string_buffer[20][0] ), .D(n716), .Y(n619) );
  OR4X1 U476 ( .A(\string_buffer[20][4] ), .B(\string_buffer[20][3] ), .C(
        \string_buffer[20][7] ), .D(\string_buffer[20][6] ), .Y(n716) );
  NOR4X1 U477 ( .A(\string_buffer[27][2] ), .B(\string_buffer[27][1] ), .C(
        \string_buffer[27][0] ), .D(n728), .Y(n637) );
  OR4X1 U478 ( .A(\string_buffer[27][4] ), .B(\string_buffer[27][3] ), .C(
        \string_buffer[27][7] ), .D(\string_buffer[27][6] ), .Y(n728) );
  NOR4X1 U479 ( .A(\string_buffer[28][2] ), .B(\string_buffer[28][1] ), .C(
        \string_buffer[28][0] ), .D(n729), .Y(n635) );
  OR4X1 U480 ( .A(\string_buffer[28][4] ), .B(\string_buffer[28][3] ), .C(
        \string_buffer[28][7] ), .D(\string_buffer[28][6] ), .Y(n729) );
  NOR4X1 U481 ( .A(\string_buffer[1][2] ), .B(\string_buffer[1][1] ), .C(
        \string_buffer[1][0] ), .D(n664), .Y(n562) );
  OR4X1 U482 ( .A(\string_buffer[1][4] ), .B(\string_buffer[1][3] ), .C(
        \string_buffer[1][7] ), .D(\string_buffer[1][6] ), .Y(n664) );
  NOR4X1 U483 ( .A(\string_buffer[2][2] ), .B(\string_buffer[2][1] ), .C(
        \string_buffer[2][0] ), .D(n665), .Y(n560) );
  OR4X1 U484 ( .A(\string_buffer[2][4] ), .B(\string_buffer[2][3] ), .C(
        \string_buffer[2][7] ), .D(\string_buffer[2][6] ), .Y(n665) );
  NOR4X1 U485 ( .A(\string_buffer[9][2] ), .B(\string_buffer[9][1] ), .C(
        \string_buffer[9][0] ), .D(n703), .Y(n609) );
  OR4X1 U486 ( .A(\string_buffer[9][4] ), .B(\string_buffer[9][3] ), .C(
        \string_buffer[9][7] ), .D(\string_buffer[9][6] ), .Y(n703) );
  NOR4X1 U487 ( .A(\string_buffer[10][2] ), .B(\string_buffer[10][1] ), .C(
        \string_buffer[10][0] ), .D(n704), .Y(n608) );
  OR4X1 U488 ( .A(\string_buffer[10][4] ), .B(\string_buffer[10][3] ), .C(
        \string_buffer[10][7] ), .D(\string_buffer[10][6] ), .Y(n704) );
  NOR4X1 U489 ( .A(\string_buffer[17][2] ), .B(\string_buffer[17][1] ), .C(
        \string_buffer[17][0] ), .D(n717), .Y(n623) );
  OR4X1 U490 ( .A(\string_buffer[17][4] ), .B(\string_buffer[17][3] ), .C(
        \string_buffer[17][7] ), .D(\string_buffer[17][6] ), .Y(n717) );
  NOR4X1 U491 ( .A(\string_buffer[18][2] ), .B(\string_buffer[18][1] ), .C(
        \string_buffer[18][0] ), .D(n718), .Y(n622) );
  OR4X1 U492 ( .A(\string_buffer[18][4] ), .B(\string_buffer[18][3] ), .C(
        \string_buffer[18][7] ), .D(\string_buffer[18][6] ), .Y(n718) );
  NOR4X1 U493 ( .A(\string_buffer[25][2] ), .B(\string_buffer[25][1] ), .C(
        \string_buffer[25][0] ), .D(n730), .Y(n639) );
  OR4X1 U494 ( .A(\string_buffer[25][4] ), .B(\string_buffer[25][3] ), .C(
        \string_buffer[25][7] ), .D(\string_buffer[25][6] ), .Y(n730) );
  NOR4X1 U495 ( .A(\string_buffer[26][2] ), .B(\string_buffer[26][1] ), .C(
        \string_buffer[26][0] ), .D(n731), .Y(n638) );
  OR4X1 U496 ( .A(\string_buffer[26][4] ), .B(\string_buffer[26][3] ), .C(
        \string_buffer[26][7] ), .D(\string_buffer[26][6] ), .Y(n731) );
  NOR4X1 U497 ( .A(\string_buffer[7][2] ), .B(\string_buffer[7][1] ), .C(
        \string_buffer[7][0] ), .D(n706), .Y(n612) );
  OR4X1 U498 ( .A(\string_buffer[7][4] ), .B(\string_buffer[7][3] ), .C(
        \string_buffer[7][7] ), .D(\string_buffer[7][6] ), .Y(n706) );
  NOR4X1 U499 ( .A(\string_buffer[8][2] ), .B(\string_buffer[8][1] ), .C(
        \string_buffer[8][0] ), .D(n707), .Y(n610) );
  OR4X1 U500 ( .A(\string_buffer[8][4] ), .B(\string_buffer[8][3] ), .C(
        \string_buffer[8][7] ), .D(\string_buffer[8][6] ), .Y(n707) );
  NOR4X1 U501 ( .A(\string_buffer[15][2] ), .B(\string_buffer[15][1] ), .C(
        \string_buffer[15][0] ), .D(n719), .Y(n626) );
  OR4X1 U502 ( .A(\string_buffer[15][4] ), .B(\string_buffer[15][3] ), .C(
        \string_buffer[15][7] ), .D(\string_buffer[15][6] ), .Y(n719) );
  NOR4X1 U503 ( .A(\string_buffer[16][2] ), .B(\string_buffer[16][1] ), .C(
        \string_buffer[16][0] ), .D(n720), .Y(n624) );
  OR4X1 U504 ( .A(\string_buffer[16][4] ), .B(\string_buffer[16][3] ), .C(
        \string_buffer[16][7] ), .D(\string_buffer[16][6] ), .Y(n720) );
  NOR4X1 U505 ( .A(\string_buffer[23][2] ), .B(\string_buffer[23][1] ), .C(
        \string_buffer[23][0] ), .D(n732), .Y(n642) );
  OR4X1 U506 ( .A(\string_buffer[23][4] ), .B(\string_buffer[23][3] ), .C(
        \string_buffer[23][7] ), .D(\string_buffer[23][6] ), .Y(n732) );
  NOR4X1 U507 ( .A(\string_buffer[24][2] ), .B(\string_buffer[24][1] ), .C(
        \string_buffer[24][0] ), .D(n733), .Y(n640) );
  OR4X1 U508 ( .A(\string_buffer[24][4] ), .B(\string_buffer[24][3] ), .C(
        \string_buffer[24][7] ), .D(\string_buffer[24][6] ), .Y(n733) );
  CLKINVX1 U509 ( .A(\string_buffer[17][5] ), .Y(n900) );
  CLKINVX1 U510 ( .A(\string_buffer[21][5] ), .Y(n905) );
  CLKINVX1 U511 ( .A(\string_buffer[25][5] ), .Y(n901) );
  CLKINVX1 U512 ( .A(\string_buffer[5][5] ), .Y(n903) );
  CLKINVX1 U513 ( .A(\string_buffer[9][5] ), .Y(n899) );
  CLKINVX1 U514 ( .A(\string_buffer[13][5] ), .Y(n904) );
  OR4X1 U515 ( .A(\string_buffer[31][4] ), .B(\string_buffer[31][3] ), .C(
        \string_buffer[31][7] ), .D(\string_buffer[31][6] ), .Y(n598) );
  NAND3X2 U516 ( .A(n734), .B(n735), .C(n736), .Y(n331) );
  XOR2X1 U517 ( .A(n170), .B(read_string_count[0]), .Y(n734) );
  XOR2X1 U518 ( .A(n168), .B(read_string_count[2]), .Y(n735) );
  NOR3X1 U519 ( .A(n737), .B(n738), .C(n739), .Y(n736) );
  XOR2X1 U520 ( .A(read_string_count[1]), .B(N251), .Y(n738) );
  XOR2X1 U521 ( .A(read_string_count[4]), .B(N254), .Y(n739) );
  XOR2X1 U522 ( .A(read_string_count[3]), .B(N253), .Y(n737) );
  NOR2X1 U523 ( .A(n193), .B(cur_match_state[3]), .Y(n452) );
  NAND3X1 U524 ( .A(n452), .B(n195), .C(cur_match_state[0]), .Y(n352) );
  NAND4X2 U525 ( .A(N260), .B(N257), .C(n644), .D(n645), .Y(n323) );
  NOR2X1 U526 ( .A(N256), .B(N255), .Y(n644) );
  NOR4X1 U527 ( .A(N262), .B(N261), .C(N259), .D(N258), .Y(n645) );
  CLKBUFX3 U528 ( .A(n48), .Y(n57) );
  NOR2X1 U529 ( .A(n919), .B(N246), .Y(n48) );
  NAND2X1 U530 ( .A(n195), .B(n196), .Y(n309) );
  CLKBUFX3 U531 ( .A(n47), .Y(n58) );
  NOR2X1 U532 ( .A(N245), .B(N246), .Y(n47) );
  NAND3X1 U533 ( .A(cur_match_state[1]), .B(n452), .C(cur_match_state[0]), .Y(
        n322) );
  CLKBUFX3 U534 ( .A(n51), .Y(n55) );
  NOR2X1 U535 ( .A(n920), .B(N245), .Y(n51) );
  NOR3X2 U536 ( .A(n309), .B(cur_match_state[2]), .C(n192), .Y(n276) );
  XOR2X1 U537 ( .A(\pattern_buffer[1][0] ), .B(N914), .Y(n528) );
  NAND2X1 U538 ( .A(n523), .B(n524), .Y(n399) );
  NOR4X1 U539 ( .A(n529), .B(n530), .C(n531), .D(n532), .Y(n523) );
  NOR4X1 U540 ( .A(n525), .B(n526), .C(n527), .D(n528), .Y(n524) );
  XOR2X1 U541 ( .A(\pattern_buffer[1][7] ), .B(N907), .Y(n529) );
  XOR2X1 U542 ( .A(\pattern_buffer[1][1] ), .B(N913), .Y(n527) );
  XOR2X1 U543 ( .A(\pattern_buffer[1][2] ), .B(N912), .Y(n526) );
  XOR2X1 U544 ( .A(\pattern_buffer[1][4] ), .B(N910), .Y(n532) );
  XOR2X1 U545 ( .A(\pattern_buffer[1][3] ), .B(N911), .Y(n525) );
  XOR2X1 U546 ( .A(\pattern_buffer[1][6] ), .B(N908), .Y(n530) );
  XOR2X1 U547 ( .A(\pattern_buffer[1][5] ), .B(N909), .Y(n531) );
  INVX3 U548 ( .A(N244), .Y(n54) );
  AOI221XL U549 ( .A0(\string_buffer[0][5] ), .A1(n875), .B0(n848), .B1(
        \string_buffer[1][5] ), .C0(n681), .Y(n680) );
  OAI2BB2XL U550 ( .B0(n902), .B1(n555), .A0N(\string_buffer[2][5] ), .A1N(
        n844), .Y(n681) );
  CLKINVX1 U551 ( .A(\string_buffer[3][5] ), .Y(n902) );
  NOR4X1 U552 ( .A(n693), .B(\string_buffer[0][0] ), .C(\string_buffer[0][2] ), 
        .D(\string_buffer[0][1] ), .Y(n666) );
  NAND4X1 U553 ( .A(n669), .B(n670), .C(n671), .D(n672), .Y(n668) );
  NAND4X1 U554 ( .A(n677), .B(n678), .C(n679), .D(n680), .Y(n667) );
  AOI221XL U555 ( .A0(n843), .A1(\string_buffer[10][5] ), .B0(n879), .B1(
        \string_buffer[11][5] ), .C0(n690), .Y(n678) );
  CLKINVX1 U556 ( .A(n596), .Y(n879) );
  OAI22XL U557 ( .A0(n899), .A1(n593), .B0(n906), .B1(n591), .Y(n690) );
  CLKINVX1 U558 ( .A(\string_buffer[8][5] ), .Y(n906) );
  AOI221XL U559 ( .A0(n851), .A1(\string_buffer[14][5] ), .B0(n873), .B1(
        \string_buffer[15][5] ), .C0(n691), .Y(n677) );
  CLKINVX1 U560 ( .A(n573), .Y(n873) );
  OAI22XL U561 ( .A0(n904), .A1(n597), .B0(n913), .B1(n595), .Y(n691) );
  CLKINVX1 U562 ( .A(\string_buffer[12][5] ), .Y(n913) );
  AOI221XL U563 ( .A0(n852), .A1(\string_buffer[6][5] ), .B0(n874), .B1(
        \string_buffer[7][5] ), .C0(n686), .Y(n679) );
  CLKINVX1 U564 ( .A(n592), .Y(n874) );
  OAI22XL U565 ( .A0(n903), .A1(n589), .B0(n912), .B1(n553), .Y(n686) );
  CLKINVX1 U566 ( .A(\string_buffer[4][5] ), .Y(n912) );
  AOI221XL U567 ( .A0(n842), .A1(\string_buffer[18][5] ), .B0(n878), .B1(
        \string_buffer[19][5] ), .C0(n673), .Y(n672) );
  CLKINVX1 U568 ( .A(n577), .Y(n878) );
  OAI22XL U569 ( .A0(n900), .A1(n574), .B0(n907), .B1(n572), .Y(n673) );
  CLKINVX1 U570 ( .A(\string_buffer[16][5] ), .Y(n907) );
  AOI221XL U571 ( .A0(n850), .A1(\string_buffer[22][5] ), .B0(n872), .B1(
        \string_buffer[23][5] ), .C0(n674), .Y(n671) );
  CLKINVX1 U572 ( .A(n581), .Y(n872) );
  OAI22XL U573 ( .A0(n905), .A1(n578), .B0(n914), .B1(n576), .Y(n674) );
  CLKINVX1 U574 ( .A(\string_buffer[20][5] ), .Y(n914) );
  AOI221XL U575 ( .A0(n841), .A1(\string_buffer[26][5] ), .B0(n877), .B1(
        \string_buffer[27][5] ), .C0(n675), .Y(n670) );
  OAI22XL U576 ( .A0(n901), .A1(n582), .B0(n908), .B1(n580), .Y(n675) );
  CLKINVX1 U577 ( .A(\string_buffer[24][5] ), .Y(n908) );
  AOI222XL U578 ( .A0(n849), .A1(\string_buffer[30][5] ), .B0(n876), .B1(
        \string_buffer[28][5] ), .C0(n853), .C1(\string_buffer[29][5] ), .Y(
        n669) );
  CLKINVX1 U579 ( .A(n676), .Y(n849) );
  NOR2BX2 U580 ( .AN(n451), .B(n183), .Y(n424) );
  NOR2X1 U581 ( .A(n181), .B(N248), .Y(n451) );
  NAND2X1 U582 ( .A(n438), .B(n439), .Y(n409) );
  AOI221XL U583 ( .A0(n891), .A1(\pattern_buffer[1][4] ), .B0(n418), .B1(
        \pattern_buffer[2][4] ), .C0(n440), .Y(n439) );
  AOI222XL U584 ( .A0(\pattern_buffer[7][4] ), .A1(n422), .B0(n423), .B1(
        \pattern_buffer[5][4] ), .C0(n424), .C1(\pattern_buffer[6][4] ), .Y(
        n438) );
  AO22X1 U585 ( .A0(\pattern_buffer[3][4] ), .A1(n420), .B0(
        \pattern_buffer[4][4] ), .B1(n833), .Y(n440) );
  NAND2X1 U586 ( .A(n416), .B(n417), .Y(n406) );
  AOI221XL U587 ( .A0(n891), .A1(\pattern_buffer[1][0] ), .B0(n418), .B1(
        \pattern_buffer[2][0] ), .C0(n419), .Y(n417) );
  AOI222XL U588 ( .A0(\pattern_buffer[7][0] ), .A1(n422), .B0(n423), .B1(
        \pattern_buffer[5][0] ), .C0(n424), .C1(\pattern_buffer[6][0] ), .Y(
        n416) );
  AO22X1 U589 ( .A0(\pattern_buffer[3][0] ), .A1(n420), .B0(
        \pattern_buffer[4][0] ), .B1(n833), .Y(n419) );
  NOR2BX2 U590 ( .AN(n450), .B(N249), .Y(n420) );
  NOR2X1 U591 ( .A(n182), .B(n836), .Y(n450) );
  NAND2X1 U592 ( .A(n444), .B(n445), .Y(n408) );
  AOI221XL U593 ( .A0(n891), .A1(\pattern_buffer[1][6] ), .B0(n418), .B1(
        \pattern_buffer[2][6] ), .C0(n446), .Y(n445) );
  AOI222XL U594 ( .A0(\pattern_buffer[7][6] ), .A1(n422), .B0(n423), .B1(
        \pattern_buffer[5][6] ), .C0(n424), .C1(\pattern_buffer[6][6] ), .Y(
        n444) );
  AO22X1 U595 ( .A0(\pattern_buffer[3][6] ), .A1(n420), .B0(
        \pattern_buffer[4][6] ), .B1(n833), .Y(n446) );
  NOR2BX2 U596 ( .AN(n450), .B(n181), .Y(n422) );
  AND2X2 U597 ( .A(n441), .B(n442), .Y(n402) );
  AOI222XL U598 ( .A0(\pattern_buffer[7][5] ), .A1(n422), .B0(n423), .B1(
        \pattern_buffer[5][5] ), .C0(n424), .C1(\pattern_buffer[6][5] ), .Y(
        n441) );
  AOI221XL U599 ( .A0(n891), .A1(\pattern_buffer[1][5] ), .B0(n418), .B1(
        \pattern_buffer[2][5] ), .C0(n443), .Y(n442) );
  AO22X1 U600 ( .A0(\pattern_buffer[3][5] ), .A1(n420), .B0(
        \pattern_buffer[4][5] ), .B1(n833), .Y(n443) );
  AND2X2 U601 ( .A(n425), .B(n426), .Y(n405) );
  AOI222XL U602 ( .A0(\pattern_buffer[7][1] ), .A1(n422), .B0(n423), .B1(
        \pattern_buffer[5][1] ), .C0(n424), .C1(\pattern_buffer[6][1] ), .Y(
        n425) );
  AOI221XL U603 ( .A0(n891), .A1(\pattern_buffer[1][1] ), .B0(n418), .B1(
        \pattern_buffer[2][1] ), .C0(n427), .Y(n426) );
  AO22X1 U604 ( .A0(\pattern_buffer[3][1] ), .A1(n420), .B0(
        \pattern_buffer[4][1] ), .B1(n833), .Y(n427) );
  NAND2X1 U605 ( .A(n447), .B(n448), .Y(n407) );
  AOI221XL U606 ( .A0(n891), .A1(\pattern_buffer[1][7] ), .B0(n418), .B1(
        \pattern_buffer[2][7] ), .C0(n449), .Y(n448) );
  AOI222XL U607 ( .A0(\pattern_buffer[7][7] ), .A1(n422), .B0(n423), .B1(
        \pattern_buffer[5][7] ), .C0(n424), .C1(\pattern_buffer[6][7] ), .Y(
        n447) );
  AO22X1 U608 ( .A0(\pattern_buffer[3][7] ), .A1(n420), .B0(
        \pattern_buffer[4][7] ), .B1(n833), .Y(n449) );
  NAND3X2 U609 ( .A(n54), .B(n920), .C(N245), .Y(n485) );
  AND2X2 U610 ( .A(n428), .B(n429), .Y(n404) );
  AOI222XL U611 ( .A0(\pattern_buffer[7][2] ), .A1(n422), .B0(n423), .B1(
        \pattern_buffer[5][2] ), .C0(n424), .C1(\pattern_buffer[6][2] ), .Y(
        n428) );
  AOI221XL U612 ( .A0(n891), .A1(\pattern_buffer[1][2] ), .B0(n418), .B1(
        \pattern_buffer[2][2] ), .C0(n430), .Y(n429) );
  AO22X1 U613 ( .A0(\pattern_buffer[3][2] ), .A1(n420), .B0(
        \pattern_buffer[4][2] ), .B1(n833), .Y(n430) );
  NAND2X1 U614 ( .A(n508), .B(n509), .Y(n467) );
  AOI222XL U615 ( .A0(\pattern_buffer[6][1] ), .A1(n487), .B0(
        \pattern_buffer[4][1] ), .B1(n488), .C0(\pattern_buffer[5][1] ), .C1(
        n489), .Y(n508) );
  AOI221XL U616 ( .A0(\pattern_buffer[2][1] ), .A1(n482), .B0(
        \pattern_buffer[3][1] ), .B1(n483), .C0(n510), .Y(n509) );
  OAI22XL U617 ( .A0(n485), .A1(n930), .B0(n486), .B1(n922), .Y(n510) );
  NAND2X1 U618 ( .A(n499), .B(n500), .Y(n475) );
  AOI222XL U619 ( .A0(\pattern_buffer[6][5] ), .A1(n487), .B0(
        \pattern_buffer[4][5] ), .B1(n488), .C0(\pattern_buffer[5][5] ), .C1(
        n489), .Y(n499) );
  AOI221XL U620 ( .A0(\pattern_buffer[2][5] ), .A1(n482), .B0(
        \pattern_buffer[3][5] ), .B1(n483), .C0(n501), .Y(n500) );
  OAI22XL U621 ( .A0(n485), .A1(n934), .B0(n486), .B1(n926), .Y(n501) );
  AND2X2 U622 ( .A(n480), .B(n481), .Y(n466) );
  AOI222XL U623 ( .A0(\pattern_buffer[6][0] ), .A1(n487), .B0(
        \pattern_buffer[4][0] ), .B1(n488), .C0(\pattern_buffer[5][0] ), .C1(
        n489), .Y(n480) );
  AOI221XL U624 ( .A0(\pattern_buffer[2][0] ), .A1(n482), .B0(
        \pattern_buffer[3][0] ), .B1(n483), .C0(n484), .Y(n481) );
  OAI22XL U625 ( .A0(n485), .A1(n937), .B0(n486), .B1(n929), .Y(n484) );
  AND2X2 U626 ( .A(n490), .B(n491), .Y(n474) );
  AOI222XL U627 ( .A0(\pattern_buffer[6][4] ), .A1(n487), .B0(
        \pattern_buffer[4][4] ), .B1(n488), .C0(\pattern_buffer[5][4] ), .C1(
        n489), .Y(n490) );
  AOI221XL U628 ( .A0(\pattern_buffer[2][4] ), .A1(n482), .B0(
        \pattern_buffer[3][4] ), .B1(n483), .C0(n492), .Y(n491) );
  OAI22XL U629 ( .A0(n485), .A1(n933), .B0(n486), .B1(n925), .Y(n492) );
  NAND2X1 U630 ( .A(n505), .B(n506), .Y(n468) );
  AOI222XL U631 ( .A0(\pattern_buffer[6][2] ), .A1(n487), .B0(
        \pattern_buffer[4][2] ), .B1(n488), .C0(\pattern_buffer[5][2] ), .C1(
        n489), .Y(n505) );
  AOI221XL U632 ( .A0(\pattern_buffer[2][2] ), .A1(n482), .B0(
        \pattern_buffer[3][2] ), .B1(n483), .C0(n507), .Y(n506) );
  OAI22XL U633 ( .A0(n485), .A1(n931), .B0(n486), .B1(n923), .Y(n507) );
  AND2X2 U634 ( .A(n431), .B(n432), .Y(n403) );
  AOI222XL U635 ( .A0(\pattern_buffer[7][3] ), .A1(n422), .B0(n423), .B1(
        \pattern_buffer[5][3] ), .C0(n424), .C1(\pattern_buffer[6][3] ), .Y(
        n431) );
  AOI221XL U636 ( .A0(n891), .A1(\pattern_buffer[1][3] ), .B0(n418), .B1(
        \pattern_buffer[2][3] ), .C0(n433), .Y(n432) );
  AO22X1 U637 ( .A0(\pattern_buffer[3][3] ), .A1(n420), .B0(
        \pattern_buffer[4][3] ), .B1(n833), .Y(n433) );
  NAND2X1 U638 ( .A(n502), .B(n503), .Y(n469) );
  AOI222XL U639 ( .A0(\pattern_buffer[6][3] ), .A1(n487), .B0(
        \pattern_buffer[4][3] ), .B1(n488), .C0(\pattern_buffer[5][3] ), .C1(
        n489), .Y(n502) );
  AOI221XL U640 ( .A0(\pattern_buffer[2][3] ), .A1(n482), .B0(
        \pattern_buffer[3][3] ), .B1(n483), .C0(n504), .Y(n503) );
  OAI22XL U641 ( .A0(n485), .A1(n932), .B0(n486), .B1(n924), .Y(n504) );
  AND2X2 U642 ( .A(n493), .B(n494), .Y(n476) );
  AOI222XL U643 ( .A0(\pattern_buffer[6][6] ), .A1(n487), .B0(
        \pattern_buffer[4][6] ), .B1(n488), .C0(\pattern_buffer[5][6] ), .C1(
        n489), .Y(n493) );
  AOI221XL U644 ( .A0(\pattern_buffer[2][6] ), .A1(n482), .B0(
        \pattern_buffer[3][6] ), .B1(n483), .C0(n495), .Y(n494) );
  OAI22XL U645 ( .A0(n485), .A1(n935), .B0(n486), .B1(n927), .Y(n495) );
  CLKBUFX3 U646 ( .A(n421), .Y(n833) );
  NOR3X1 U647 ( .A(n183), .B(N249), .C(n182), .Y(n421) );
  NAND3X2 U648 ( .A(n919), .B(n920), .C(N244), .Y(n486) );
  INVX3 U649 ( .A(N245), .Y(n919) );
  AND2X2 U650 ( .A(n496), .B(n497), .Y(n477) );
  AOI222XL U651 ( .A0(\pattern_buffer[6][7] ), .A1(n487), .B0(
        \pattern_buffer[4][7] ), .B1(n488), .C0(\pattern_buffer[5][7] ), .C1(
        n489), .Y(n496) );
  AOI221XL U652 ( .A0(\pattern_buffer[2][7] ), .A1(n482), .B0(
        \pattern_buffer[3][7] ), .B1(n483), .C0(n498), .Y(n497) );
  OAI22XL U653 ( .A0(n485), .A1(n936), .B0(n486), .B1(n928), .Y(n498) );
  INVX3 U654 ( .A(N246), .Y(n920) );
  AOI211X1 U655 ( .A0(n183), .A1(N249), .B0(n451), .C0(n833), .Y(n278) );
  XOR2X1 U656 ( .A(N246), .B(n278), .Y(n457) );
  NAND4X1 U657 ( .A(n456), .B(n457), .C(n458), .D(n459), .Y(n345) );
  NAND3X1 U658 ( .A(N248), .B(n836), .C(N249), .Y(n459) );
  XOR2X1 U659 ( .A(N244), .B(n836), .Y(n456) );
  XOR2X1 U660 ( .A(N245), .B(n280), .Y(n458) );
  OR4X1 U661 ( .A(\string_buffer[0][4] ), .B(\string_buffer[0][3] ), .C(
        \string_buffer[0][7] ), .D(\string_buffer[0][6] ), .Y(n693) );
  CLKINVX1 U662 ( .A(n296), .Y(n298) );
  CLKINVX1 U663 ( .A(\pattern_buffer[1][5] ), .Y(n934) );
  CLKINVX1 U664 ( .A(\pattern_buffer[1][0] ), .Y(n937) );
  CLKINVX1 U665 ( .A(\pattern_buffer[1][4] ), .Y(n933) );
  CLKINVX1 U666 ( .A(\pattern_buffer[1][1] ), .Y(n930) );
  CLKINVX1 U667 ( .A(\pattern_buffer[1][2] ), .Y(n931) );
  CLKINVX1 U668 ( .A(\pattern_buffer[0][5] ), .Y(n926) );
  CLKINVX1 U669 ( .A(\pattern_buffer[0][1] ), .Y(n922) );
  CLKINVX1 U670 ( .A(\pattern_buffer[0][0] ), .Y(n929) );
  CLKINVX1 U671 ( .A(\pattern_buffer[0][4] ), .Y(n925) );
  CLKINVX1 U672 ( .A(\pattern_buffer[1][6] ), .Y(n935) );
  CLKINVX1 U673 ( .A(\pattern_buffer[1][3] ), .Y(n932) );
  AOI21X1 U674 ( .A0(n182), .A1(n836), .B0(n450), .Y(n280) );
  CLKINVX1 U675 ( .A(\pattern_buffer[0][2] ), .Y(n923) );
  CLKINVX1 U676 ( .A(\pattern_buffer[1][7] ), .Y(n936) );
  CLKINVX1 U677 ( .A(\pattern_buffer[0][6] ), .Y(n927) );
  CLKINVX1 U678 ( .A(\pattern_buffer[0][3] ), .Y(n924) );
  CLKINVX1 U679 ( .A(\pattern_buffer[0][7] ), .Y(n928) );
  NAND3X1 U680 ( .A(n518), .B(n519), .C(n520), .Y(n397) );
  XOR2X1 U681 ( .A(n199), .B(n836), .Y(n519) );
  XOR2X1 U682 ( .A(n198), .B(N248), .Y(n518) );
  XOR2X1 U683 ( .A(n197), .B(N249), .Y(n520) );
  NAND4X1 U684 ( .A(\pattern_buffer[1][1] ), .B(\pattern_buffer[1][2] ), .C(
        n521), .D(n522), .Y(n398) );
  NOR2X1 U685 ( .A(n934), .B(n932), .Y(n521) );
  NOR4X1 U686 ( .A(\pattern_buffer[1][7] ), .B(\pattern_buffer[1][6] ), .C(
        \pattern_buffer[1][4] ), .D(\pattern_buffer[1][0] ), .Y(n522) );
  NAND2X1 U687 ( .A(n192), .B(n193), .Y(n311) );
  NAND3X1 U688 ( .A(cur_match_state[0]), .B(cur_match_state[1]), .C(n889), .Y(
        n377) );
  NAND3X2 U689 ( .A(cur_match_state[1]), .B(n196), .C(n889), .Y(n310) );
  NOR3X1 U690 ( .A(n196), .B(cur_match_state[1]), .C(n311), .Y(n316) );
  NAND2X1 U691 ( .A(n390), .B(n391), .Y(n368) );
  NOR4X1 U692 ( .A(n925), .B(n924), .C(n923), .D(n922), .Y(n390) );
  NOR4X1 U693 ( .A(\pattern_buffer[0][7] ), .B(\pattern_buffer[0][5] ), .C(
        \pattern_buffer[0][0] ), .D(n927), .Y(n391) );
  ADDHXL U694 ( .A(N251), .B(N250), .CO(\add_304/carry[2] ), .S(N286) );
  ADDHXL U695 ( .A(N252), .B(\add_304/carry[2] ), .CO(\add_304/carry[3] ), .S(
        N287) );
  ADDHXL U696 ( .A(N253), .B(\add_304/carry[3] ), .CO(\add_304/carry[4] ), .S(
        N288) );
  INVX4 U697 ( .A(reset), .Y(n939) );
  AO22X1 U698 ( .A0(\pattern_buffer[3][0] ), .A1(n57), .B0(
        \pattern_buffer[1][0] ), .B1(n58), .Y(n18) );
  AOI221XL U699 ( .A0(\pattern_buffer[5][0] ), .A1(n55), .B0(
        \pattern_buffer[7][0] ), .B1(n56), .C0(n18), .Y(n21) );
  AO22X1 U700 ( .A0(\pattern_buffer[2][0] ), .A1(n57), .B0(
        \pattern_buffer[0][0] ), .B1(n58), .Y(n19) );
  AOI221XL U701 ( .A0(\pattern_buffer[4][0] ), .A1(n55), .B0(
        \pattern_buffer[6][0] ), .B1(n56), .C0(n19), .Y(n20) );
  OAI22XL U702 ( .A0(n54), .A1(n21), .B0(N244), .B1(n20), .Y(N262) );
  AO22X1 U703 ( .A0(\pattern_buffer[3][1] ), .A1(n57), .B0(
        \pattern_buffer[1][1] ), .B1(n58), .Y(n22) );
  AOI221XL U704 ( .A0(\pattern_buffer[5][1] ), .A1(n55), .B0(
        \pattern_buffer[7][1] ), .B1(n56), .C0(n22), .Y(n25) );
  AO22X1 U705 ( .A0(\pattern_buffer[2][1] ), .A1(n57), .B0(
        \pattern_buffer[0][1] ), .B1(n58), .Y(n23) );
  AOI221XL U706 ( .A0(\pattern_buffer[4][1] ), .A1(n55), .B0(
        \pattern_buffer[6][1] ), .B1(n56), .C0(n23), .Y(n24) );
  OAI22XL U707 ( .A0(n54), .A1(n25), .B0(N244), .B1(n24), .Y(N261) );
  AO22X1 U708 ( .A0(\pattern_buffer[3][2] ), .A1(n57), .B0(
        \pattern_buffer[1][2] ), .B1(n58), .Y(n26) );
  AOI221XL U709 ( .A0(\pattern_buffer[5][2] ), .A1(n55), .B0(
        \pattern_buffer[7][2] ), .B1(n56), .C0(n26), .Y(n29) );
  AO22X1 U710 ( .A0(\pattern_buffer[2][2] ), .A1(n57), .B0(
        \pattern_buffer[0][2] ), .B1(n58), .Y(n27) );
  AOI221XL U711 ( .A0(\pattern_buffer[4][2] ), .A1(n55), .B0(
        \pattern_buffer[6][2] ), .B1(n56), .C0(n27), .Y(n28) );
  OAI22XL U712 ( .A0(n54), .A1(n29), .B0(N244), .B1(n28), .Y(N260) );
  AO22X1 U713 ( .A0(\pattern_buffer[3][3] ), .A1(n57), .B0(
        \pattern_buffer[1][3] ), .B1(n58), .Y(n30) );
  AOI221XL U714 ( .A0(\pattern_buffer[5][3] ), .A1(n55), .B0(
        \pattern_buffer[7][3] ), .B1(n56), .C0(n30), .Y(n33) );
  AO22X1 U715 ( .A0(\pattern_buffer[2][3] ), .A1(n57), .B0(
        \pattern_buffer[0][3] ), .B1(n58), .Y(n31) );
  AOI221XL U716 ( .A0(\pattern_buffer[4][3] ), .A1(n55), .B0(
        \pattern_buffer[6][3] ), .B1(n56), .C0(n31), .Y(n32) );
  OAI22XL U717 ( .A0(n54), .A1(n33), .B0(N244), .B1(n32), .Y(N259) );
  AO22X1 U718 ( .A0(\pattern_buffer[3][4] ), .A1(n57), .B0(
        \pattern_buffer[1][4] ), .B1(n58), .Y(n34) );
  AOI221XL U719 ( .A0(\pattern_buffer[5][4] ), .A1(n55), .B0(
        \pattern_buffer[7][4] ), .B1(n56), .C0(n34), .Y(n37) );
  AO22X1 U720 ( .A0(\pattern_buffer[2][4] ), .A1(n57), .B0(
        \pattern_buffer[0][4] ), .B1(n58), .Y(n35) );
  AOI221XL U721 ( .A0(\pattern_buffer[4][4] ), .A1(n55), .B0(
        \pattern_buffer[6][4] ), .B1(n56), .C0(n35), .Y(n36) );
  OAI22XL U722 ( .A0(n54), .A1(n37), .B0(N244), .B1(n36), .Y(N258) );
  AO22X1 U723 ( .A0(\pattern_buffer[3][5] ), .A1(n57), .B0(
        \pattern_buffer[1][5] ), .B1(n58), .Y(n38) );
  AOI221XL U724 ( .A0(\pattern_buffer[5][5] ), .A1(n55), .B0(
        \pattern_buffer[7][5] ), .B1(n56), .C0(n38), .Y(n41) );
  AO22X1 U725 ( .A0(\pattern_buffer[2][5] ), .A1(n57), .B0(
        \pattern_buffer[0][5] ), .B1(n58), .Y(n39) );
  AOI221XL U726 ( .A0(\pattern_buffer[4][5] ), .A1(n55), .B0(
        \pattern_buffer[6][5] ), .B1(n56), .C0(n39), .Y(n40) );
  OAI22XL U727 ( .A0(n54), .A1(n41), .B0(N244), .B1(n40), .Y(N257) );
  AO22X1 U728 ( .A0(\pattern_buffer[3][6] ), .A1(n57), .B0(
        \pattern_buffer[1][6] ), .B1(n58), .Y(n42) );
  AOI221XL U729 ( .A0(\pattern_buffer[5][6] ), .A1(n55), .B0(
        \pattern_buffer[7][6] ), .B1(n56), .C0(n42), .Y(n45) );
  AO22X1 U730 ( .A0(\pattern_buffer[2][6] ), .A1(n57), .B0(
        \pattern_buffer[0][6] ), .B1(n58), .Y(n43) );
  AOI221XL U731 ( .A0(\pattern_buffer[4][6] ), .A1(n55), .B0(
        \pattern_buffer[6][6] ), .B1(n56), .C0(n43), .Y(n44) );
  OAI22XL U732 ( .A0(n54), .A1(n45), .B0(N244), .B1(n44), .Y(N256) );
  AO22X1 U733 ( .A0(\pattern_buffer[3][7] ), .A1(n57), .B0(
        \pattern_buffer[1][7] ), .B1(n58), .Y(n46) );
  AOI221XL U734 ( .A0(\pattern_buffer[5][7] ), .A1(n55), .B0(
        \pattern_buffer[7][7] ), .B1(n56), .C0(n46), .Y(n53) );
  AO22X1 U735 ( .A0(\pattern_buffer[2][7] ), .A1(n57), .B0(
        \pattern_buffer[0][7] ), .B1(n58), .Y(n49) );
  AOI221XL U736 ( .A0(\pattern_buffer[4][7] ), .A1(n55), .B0(
        \pattern_buffer[6][7] ), .B1(n56), .C0(n49), .Y(n52) );
  OAI22XL U737 ( .A0(n53), .A1(n54), .B0(N244), .B1(n52), .Y(N255) );
  AO22X1 U738 ( .A0(\pattern_buffer[3][0] ), .A1(n98), .B0(
        \pattern_buffer[1][0] ), .B1(n99), .Y(n59) );
  AOI221XL U739 ( .A0(\pattern_buffer[5][0] ), .A1(n96), .B0(
        \pattern_buffer[7][0] ), .B1(n97), .C0(n59), .Y(n62) );
  AO22X1 U740 ( .A0(\pattern_buffer[2][0] ), .A1(n98), .B0(
        \pattern_buffer[0][0] ), .B1(n99), .Y(n60) );
  AOI221XL U741 ( .A0(\pattern_buffer[4][0] ), .A1(n96), .B0(
        \pattern_buffer[6][0] ), .B1(n97), .C0(n60), .Y(n61) );
  OAI22XL U742 ( .A0(n95), .A1(n62), .B0(n836), .B1(n61), .Y(N906) );
  AO22X1 U743 ( .A0(\pattern_buffer[3][1] ), .A1(n98), .B0(
        \pattern_buffer[1][1] ), .B1(n99), .Y(n63) );
  AOI221XL U744 ( .A0(\pattern_buffer[5][1] ), .A1(n96), .B0(
        \pattern_buffer[7][1] ), .B1(n97), .C0(n63), .Y(n66) );
  AO22X1 U745 ( .A0(\pattern_buffer[2][1] ), .A1(n98), .B0(
        \pattern_buffer[0][1] ), .B1(n99), .Y(n64) );
  AOI221XL U746 ( .A0(\pattern_buffer[4][1] ), .A1(n96), .B0(
        \pattern_buffer[6][1] ), .B1(n97), .C0(n64), .Y(n65) );
  OAI22XL U747 ( .A0(n95), .A1(n66), .B0(n836), .B1(n65), .Y(N905) );
  AO22X1 U748 ( .A0(\pattern_buffer[3][2] ), .A1(n98), .B0(
        \pattern_buffer[1][2] ), .B1(n99), .Y(n67) );
  AOI221XL U749 ( .A0(\pattern_buffer[5][2] ), .A1(n96), .B0(
        \pattern_buffer[7][2] ), .B1(n97), .C0(n67), .Y(n70) );
  AO22X1 U750 ( .A0(\pattern_buffer[2][2] ), .A1(n98), .B0(
        \pattern_buffer[0][2] ), .B1(n99), .Y(n68) );
  AOI221XL U751 ( .A0(\pattern_buffer[4][2] ), .A1(n96), .B0(
        \pattern_buffer[6][2] ), .B1(n97), .C0(n68), .Y(n69) );
  AO22X1 U752 ( .A0(\pattern_buffer[3][3] ), .A1(n98), .B0(
        \pattern_buffer[1][3] ), .B1(n99), .Y(n71) );
  AOI221XL U753 ( .A0(\pattern_buffer[5][3] ), .A1(n96), .B0(
        \pattern_buffer[7][3] ), .B1(n97), .C0(n71), .Y(n74) );
  AO22X1 U754 ( .A0(\pattern_buffer[2][3] ), .A1(n98), .B0(
        \pattern_buffer[0][3] ), .B1(n99), .Y(n72) );
  AOI221XL U755 ( .A0(\pattern_buffer[4][3] ), .A1(n96), .B0(
        \pattern_buffer[6][3] ), .B1(n97), .C0(n72), .Y(n73) );
  OAI22XL U756 ( .A0(n95), .A1(n74), .B0(n836), .B1(n73), .Y(N903) );
  AO22X1 U757 ( .A0(\pattern_buffer[3][4] ), .A1(n98), .B0(
        \pattern_buffer[1][4] ), .B1(n99), .Y(n75) );
  AOI221XL U758 ( .A0(\pattern_buffer[5][4] ), .A1(n96), .B0(
        \pattern_buffer[7][4] ), .B1(n97), .C0(n75), .Y(n78) );
  AO22X1 U759 ( .A0(\pattern_buffer[2][4] ), .A1(n98), .B0(
        \pattern_buffer[0][4] ), .B1(n99), .Y(n76) );
  AOI221XL U760 ( .A0(\pattern_buffer[4][4] ), .A1(n96), .B0(
        \pattern_buffer[6][4] ), .B1(n97), .C0(n76), .Y(n77) );
  OAI22XL U761 ( .A0(n95), .A1(n78), .B0(n836), .B1(n77), .Y(N902) );
  AO22X1 U762 ( .A0(\pattern_buffer[3][5] ), .A1(n98), .B0(
        \pattern_buffer[1][5] ), .B1(n99), .Y(n79) );
  AOI221XL U763 ( .A0(\pattern_buffer[5][5] ), .A1(n96), .B0(
        \pattern_buffer[7][5] ), .B1(n97), .C0(n79), .Y(n82) );
  AO22X1 U764 ( .A0(\pattern_buffer[2][5] ), .A1(n98), .B0(
        \pattern_buffer[0][5] ), .B1(n99), .Y(n80) );
  AOI221XL U765 ( .A0(\pattern_buffer[4][5] ), .A1(n96), .B0(
        \pattern_buffer[6][5] ), .B1(n97), .C0(n80), .Y(n81) );
  OAI22XL U766 ( .A0(n95), .A1(n82), .B0(n836), .B1(n81), .Y(N901) );
  AO22X1 U767 ( .A0(\pattern_buffer[3][6] ), .A1(n98), .B0(
        \pattern_buffer[1][6] ), .B1(n99), .Y(n83) );
  AOI221XL U768 ( .A0(\pattern_buffer[5][6] ), .A1(n96), .B0(
        \pattern_buffer[7][6] ), .B1(n97), .C0(n83), .Y(n86) );
  AO22X1 U769 ( .A0(\pattern_buffer[2][6] ), .A1(n98), .B0(
        \pattern_buffer[0][6] ), .B1(n99), .Y(n84) );
  AOI221XL U770 ( .A0(\pattern_buffer[4][6] ), .A1(n96), .B0(
        \pattern_buffer[6][6] ), .B1(n97), .C0(n84), .Y(n85) );
  AO22X1 U771 ( .A0(\pattern_buffer[3][7] ), .A1(n98), .B0(
        \pattern_buffer[1][7] ), .B1(n99), .Y(n87) );
  AOI221XL U772 ( .A0(\pattern_buffer[5][7] ), .A1(n96), .B0(
        \pattern_buffer[7][7] ), .B1(n97), .C0(n87), .Y(n94) );
  AO22X1 U773 ( .A0(\pattern_buffer[2][7] ), .A1(n98), .B0(
        \pattern_buffer[0][7] ), .B1(n99), .Y(n90) );
  AOI221XL U774 ( .A0(\pattern_buffer[4][7] ), .A1(n96), .B0(
        \pattern_buffer[6][7] ), .B1(n97), .C0(n90), .Y(n93) );
  NOR2X1 U775 ( .A(n167), .B(N252), .Y(n100) );
  NOR2X1 U776 ( .A(n170), .B(N251), .Y(n107) );
  NOR2X1 U777 ( .A(N250), .B(N251), .Y(n108) );
  OAI22XL U778 ( .A0(\string_buffer[9][0] ), .A1(n817), .B0(
        \string_buffer[8][0] ), .B1(n818), .Y(n105) );
  AND2X1 U779 ( .A(N251), .B(N250), .Y(n109) );
  AND2X1 U780 ( .A(N251), .B(n170), .Y(n110) );
  OAI22XL U781 ( .A0(\string_buffer[11][0] ), .A1(n819), .B0(
        \string_buffer[10][0] ), .B1(n820), .Y(n104) );
  NOR2X1 U782 ( .A(n167), .B(n168), .Y(n101) );
  OAI22XL U783 ( .A0(\string_buffer[13][0] ), .A1(n821), .B0(
        \string_buffer[12][0] ), .B1(n822), .Y(n103) );
  OAI22XL U784 ( .A0(\string_buffer[15][0] ), .A1(n823), .B0(
        \string_buffer[14][0] ), .B1(n824), .Y(n102) );
  NOR4X1 U785 ( .A(n105), .B(n104), .C(n103), .D(n102), .Y(n127) );
  NOR2X1 U786 ( .A(N252), .B(N253), .Y(n106) );
  OAI221XL U787 ( .A0(\string_buffer[0][0] ), .A1(n825), .B0(
        \string_buffer[1][0] ), .B1(n826), .C0(n157), .Y(n115) );
  OAI22XL U788 ( .A0(\string_buffer[3][0] ), .A1(n827), .B0(
        \string_buffer[2][0] ), .B1(n828), .Y(n114) );
  NOR2X1 U789 ( .A(n168), .B(N253), .Y(n111) );
  OAI22XL U790 ( .A0(\string_buffer[5][0] ), .A1(n829), .B0(
        \string_buffer[4][0] ), .B1(n830), .Y(n113) );
  OAI22XL U791 ( .A0(\string_buffer[7][0] ), .A1(n831), .B0(
        \string_buffer[6][0] ), .B1(n832), .Y(n112) );
  NOR4X1 U792 ( .A(n115), .B(n114), .C(n113), .D(n112), .Y(n126) );
  OAI22XL U793 ( .A0(\string_buffer[25][0] ), .A1(n817), .B0(
        \string_buffer[24][0] ), .B1(n818), .Y(n119) );
  OAI22XL U794 ( .A0(\string_buffer[27][0] ), .A1(n819), .B0(
        \string_buffer[26][0] ), .B1(n820), .Y(n118) );
  OAI22XL U795 ( .A0(\string_buffer[29][0] ), .A1(n821), .B0(
        \string_buffer[28][0] ), .B1(n822), .Y(n117) );
  OAI22XL U796 ( .A0(\string_buffer[31][0] ), .A1(n823), .B0(
        \string_buffer[30][0] ), .B1(n824), .Y(n116) );
  NOR4X1 U797 ( .A(n119), .B(n118), .C(n117), .D(n116), .Y(n125) );
  OAI221XL U798 ( .A0(\string_buffer[16][0] ), .A1(n825), .B0(
        \string_buffer[17][0] ), .B1(n826), .C0(N254), .Y(n123) );
  OAI22XL U799 ( .A0(\string_buffer[19][0] ), .A1(n827), .B0(
        \string_buffer[18][0] ), .B1(n828), .Y(n122) );
  OAI22XL U800 ( .A0(\string_buffer[21][0] ), .A1(n829), .B0(
        \string_buffer[20][0] ), .B1(n830), .Y(n121) );
  OAI22XL U801 ( .A0(\string_buffer[23][0] ), .A1(n831), .B0(
        \string_buffer[22][0] ), .B1(n832), .Y(n120) );
  NOR4X1 U802 ( .A(n123), .B(n122), .C(n121), .D(n120), .Y(n124) );
  AO22X1 U803 ( .A0(n127), .A1(n126), .B0(n125), .B1(n124), .Y(N914) );
  OAI22XL U804 ( .A0(\string_buffer[9][1] ), .A1(n817), .B0(
        \string_buffer[8][1] ), .B1(n818), .Y(n131) );
  OAI22XL U805 ( .A0(\string_buffer[11][1] ), .A1(n819), .B0(
        \string_buffer[10][1] ), .B1(n820), .Y(n130) );
  OAI22XL U806 ( .A0(\string_buffer[13][1] ), .A1(n821), .B0(
        \string_buffer[12][1] ), .B1(n822), .Y(n129) );
  OAI22XL U807 ( .A0(\string_buffer[15][1] ), .A1(n823), .B0(
        \string_buffer[14][1] ), .B1(n824), .Y(n128) );
  NOR4X1 U808 ( .A(n131), .B(n130), .C(n129), .D(n128), .Y(n147) );
  OAI221XL U809 ( .A0(\string_buffer[0][1] ), .A1(n825), .B0(
        \string_buffer[1][1] ), .B1(n826), .C0(n157), .Y(n135) );
  OAI22XL U810 ( .A0(\string_buffer[3][1] ), .A1(n827), .B0(
        \string_buffer[2][1] ), .B1(n828), .Y(n134) );
  OAI22XL U811 ( .A0(\string_buffer[5][1] ), .A1(n829), .B0(
        \string_buffer[4][1] ), .B1(n830), .Y(n133) );
  OAI22XL U812 ( .A0(\string_buffer[7][1] ), .A1(n831), .B0(
        \string_buffer[6][1] ), .B1(n832), .Y(n132) );
  NOR4X1 U813 ( .A(n135), .B(n134), .C(n133), .D(n132), .Y(n146) );
  OAI22XL U814 ( .A0(\string_buffer[25][1] ), .A1(n817), .B0(
        \string_buffer[24][1] ), .B1(n818), .Y(n139) );
  OAI22XL U815 ( .A0(\string_buffer[27][1] ), .A1(n819), .B0(
        \string_buffer[26][1] ), .B1(n820), .Y(n138) );
  OAI22XL U816 ( .A0(\string_buffer[29][1] ), .A1(n821), .B0(
        \string_buffer[28][1] ), .B1(n822), .Y(n137) );
  OAI22XL U817 ( .A0(\string_buffer[31][1] ), .A1(n823), .B0(
        \string_buffer[30][1] ), .B1(n824), .Y(n136) );
  NOR4X1 U818 ( .A(n139), .B(n138), .C(n137), .D(n136), .Y(n145) );
  OAI221XL U819 ( .A0(\string_buffer[16][1] ), .A1(n825), .B0(
        \string_buffer[17][1] ), .B1(n826), .C0(N254), .Y(n143) );
  OAI22XL U820 ( .A0(\string_buffer[19][1] ), .A1(n827), .B0(
        \string_buffer[18][1] ), .B1(n828), .Y(n142) );
  OAI22XL U821 ( .A0(\string_buffer[21][1] ), .A1(n829), .B0(
        \string_buffer[20][1] ), .B1(n830), .Y(n141) );
  OAI22XL U822 ( .A0(\string_buffer[23][1] ), .A1(n831), .B0(
        \string_buffer[22][1] ), .B1(n832), .Y(n140) );
  NOR4X1 U823 ( .A(n143), .B(n142), .C(n141), .D(n140), .Y(n144) );
  AO22X1 U824 ( .A0(n147), .A1(n146), .B0(n145), .B1(n144), .Y(N913) );
  OAI22XL U825 ( .A0(\string_buffer[9][2] ), .A1(n817), .B0(
        \string_buffer[8][2] ), .B1(n818), .Y(n151) );
  OAI22XL U826 ( .A0(\string_buffer[11][2] ), .A1(n819), .B0(
        \string_buffer[10][2] ), .B1(n820), .Y(n150) );
  OAI22XL U827 ( .A0(\string_buffer[13][2] ), .A1(n821), .B0(
        \string_buffer[12][2] ), .B1(n822), .Y(n149) );
  OAI22XL U828 ( .A0(\string_buffer[15][2] ), .A1(n823), .B0(
        \string_buffer[14][2] ), .B1(n824), .Y(n148) );
  NOR4X1 U829 ( .A(n151), .B(n150), .C(n149), .D(n148), .Y(n172) );
  OAI221XL U830 ( .A0(\string_buffer[0][2] ), .A1(n825), .B0(
        \string_buffer[1][2] ), .B1(n826), .C0(n157), .Y(n155) );
  OAI22XL U831 ( .A0(\string_buffer[3][2] ), .A1(n827), .B0(
        \string_buffer[2][2] ), .B1(n828), .Y(n154) );
  OAI22XL U832 ( .A0(\string_buffer[5][2] ), .A1(n829), .B0(
        \string_buffer[4][2] ), .B1(n830), .Y(n153) );
  OAI22XL U833 ( .A0(\string_buffer[7][2] ), .A1(n831), .B0(
        \string_buffer[6][2] ), .B1(n832), .Y(n152) );
  NOR4X1 U834 ( .A(n155), .B(n154), .C(n153), .D(n152), .Y(n171) );
  OAI22XL U835 ( .A0(\string_buffer[25][2] ), .A1(n817), .B0(
        \string_buffer[24][2] ), .B1(n818), .Y(n160) );
  OAI22XL U836 ( .A0(\string_buffer[27][2] ), .A1(n819), .B0(
        \string_buffer[26][2] ), .B1(n820), .Y(n159) );
  OAI22XL U837 ( .A0(\string_buffer[29][2] ), .A1(n821), .B0(
        \string_buffer[28][2] ), .B1(n822), .Y(n158) );
  OAI22XL U838 ( .A0(\string_buffer[31][2] ), .A1(n823), .B0(
        \string_buffer[30][2] ), .B1(n824), .Y(n156) );
  NOR4X1 U839 ( .A(n160), .B(n159), .C(n158), .D(n156), .Y(n166) );
  OAI221XL U840 ( .A0(\string_buffer[16][2] ), .A1(n825), .B0(
        \string_buffer[17][2] ), .B1(n826), .C0(N254), .Y(n164) );
  OAI22XL U841 ( .A0(\string_buffer[19][2] ), .A1(n827), .B0(
        \string_buffer[18][2] ), .B1(n828), .Y(n163) );
  OAI22XL U842 ( .A0(\string_buffer[21][2] ), .A1(n829), .B0(
        \string_buffer[20][2] ), .B1(n830), .Y(n162) );
  OAI22XL U843 ( .A0(\string_buffer[23][2] ), .A1(n831), .B0(
        \string_buffer[22][2] ), .B1(n832), .Y(n161) );
  NOR4X1 U844 ( .A(n164), .B(n163), .C(n162), .D(n161), .Y(n165) );
  AO22X1 U845 ( .A0(n172), .A1(n171), .B0(n166), .B1(n165), .Y(N912) );
  OAI22XL U846 ( .A0(\string_buffer[9][3] ), .A1(n817), .B0(
        \string_buffer[8][3] ), .B1(n818), .Y(n176) );
  OAI22XL U847 ( .A0(\string_buffer[11][3] ), .A1(n819), .B0(
        \string_buffer[10][3] ), .B1(n820), .Y(n175) );
  OAI22XL U848 ( .A0(\string_buffer[13][3] ), .A1(n821), .B0(
        \string_buffer[12][3] ), .B1(n822), .Y(n174) );
  OAI22XL U849 ( .A0(\string_buffer[15][3] ), .A1(n823), .B0(
        \string_buffer[14][3] ), .B1(n824), .Y(n173) );
  NOR4X1 U850 ( .A(n176), .B(n175), .C(n174), .D(n173), .Y(n202) );
  OAI221XL U851 ( .A0(\string_buffer[0][3] ), .A1(n825), .B0(
        \string_buffer[1][3] ), .B1(n826), .C0(n157), .Y(n180) );
  OAI22XL U852 ( .A0(\string_buffer[3][3] ), .A1(n827), .B0(
        \string_buffer[2][3] ), .B1(n828), .Y(n179) );
  OAI22XL U853 ( .A0(\string_buffer[5][3] ), .A1(n829), .B0(
        \string_buffer[4][3] ), .B1(n830), .Y(n178) );
  OAI22XL U854 ( .A0(\string_buffer[7][3] ), .A1(n831), .B0(
        \string_buffer[6][3] ), .B1(n832), .Y(n177) );
  NOR4X1 U855 ( .A(n180), .B(n179), .C(n178), .D(n177), .Y(n201) );
  OAI22XL U856 ( .A0(\string_buffer[25][3] ), .A1(n817), .B0(
        \string_buffer[24][3] ), .B1(n818), .Y(n187) );
  OAI22XL U857 ( .A0(\string_buffer[27][3] ), .A1(n819), .B0(
        \string_buffer[26][3] ), .B1(n820), .Y(n186) );
  OAI22XL U858 ( .A0(\string_buffer[29][3] ), .A1(n821), .B0(
        \string_buffer[28][3] ), .B1(n822), .Y(n185) );
  OAI22XL U859 ( .A0(\string_buffer[31][3] ), .A1(n823), .B0(
        \string_buffer[30][3] ), .B1(n824), .Y(n184) );
  NOR4X1 U860 ( .A(n187), .B(n186), .C(n185), .D(n184), .Y(n200) );
  OAI221XL U861 ( .A0(\string_buffer[16][3] ), .A1(n825), .B0(
        \string_buffer[17][3] ), .B1(n826), .C0(N254), .Y(n191) );
  OAI22XL U862 ( .A0(\string_buffer[19][3] ), .A1(n827), .B0(
        \string_buffer[18][3] ), .B1(n828), .Y(n190) );
  OAI22XL U863 ( .A0(\string_buffer[21][3] ), .A1(n829), .B0(
        \string_buffer[20][3] ), .B1(n830), .Y(n189) );
  OAI22XL U864 ( .A0(\string_buffer[23][3] ), .A1(n831), .B0(
        \string_buffer[22][3] ), .B1(n832), .Y(n188) );
  NOR4X1 U865 ( .A(n191), .B(n190), .C(n189), .D(n188), .Y(n194) );
  AO22X1 U866 ( .A0(n202), .A1(n201), .B0(n200), .B1(n194), .Y(N911) );
  OAI22XL U867 ( .A0(\string_buffer[9][4] ), .A1(n817), .B0(
        \string_buffer[8][4] ), .B1(n818), .Y(n206) );
  OAI22XL U868 ( .A0(\string_buffer[11][4] ), .A1(n819), .B0(
        \string_buffer[10][4] ), .B1(n820), .Y(n205) );
  OAI22XL U869 ( .A0(\string_buffer[13][4] ), .A1(n821), .B0(
        \string_buffer[12][4] ), .B1(n822), .Y(n204) );
  OAI22XL U870 ( .A0(\string_buffer[15][4] ), .A1(n823), .B0(
        \string_buffer[14][4] ), .B1(n824), .Y(n203) );
  NOR4X1 U871 ( .A(n206), .B(n205), .C(n204), .D(n203), .Y(n222) );
  OAI221XL U872 ( .A0(\string_buffer[0][4] ), .A1(n825), .B0(
        \string_buffer[1][4] ), .B1(n826), .C0(n157), .Y(n210) );
  OAI22XL U873 ( .A0(\string_buffer[3][4] ), .A1(n827), .B0(
        \string_buffer[2][4] ), .B1(n828), .Y(n209) );
  OAI22XL U874 ( .A0(\string_buffer[5][4] ), .A1(n829), .B0(
        \string_buffer[4][4] ), .B1(n830), .Y(n208) );
  OAI22XL U875 ( .A0(\string_buffer[7][4] ), .A1(n831), .B0(
        \string_buffer[6][4] ), .B1(n832), .Y(n207) );
  NOR4X1 U876 ( .A(n210), .B(n209), .C(n208), .D(n207), .Y(n221) );
  OAI22XL U877 ( .A0(\string_buffer[25][4] ), .A1(n817), .B0(
        \string_buffer[24][4] ), .B1(n818), .Y(n214) );
  OAI22XL U878 ( .A0(\string_buffer[27][4] ), .A1(n819), .B0(
        \string_buffer[26][4] ), .B1(n820), .Y(n213) );
  OAI22XL U879 ( .A0(\string_buffer[29][4] ), .A1(n821), .B0(
        \string_buffer[28][4] ), .B1(n822), .Y(n212) );
  OAI22XL U880 ( .A0(\string_buffer[31][4] ), .A1(n823), .B0(
        \string_buffer[30][4] ), .B1(n824), .Y(n211) );
  NOR4X1 U881 ( .A(n214), .B(n213), .C(n212), .D(n211), .Y(n220) );
  OAI221XL U882 ( .A0(\string_buffer[16][4] ), .A1(n825), .B0(
        \string_buffer[17][4] ), .B1(n826), .C0(N254), .Y(n218) );
  OAI22XL U883 ( .A0(\string_buffer[19][4] ), .A1(n827), .B0(
        \string_buffer[18][4] ), .B1(n828), .Y(n217) );
  OAI22XL U884 ( .A0(\string_buffer[21][4] ), .A1(n829), .B0(
        \string_buffer[20][4] ), .B1(n830), .Y(n216) );
  OAI22XL U885 ( .A0(\string_buffer[23][4] ), .A1(n831), .B0(
        \string_buffer[22][4] ), .B1(n832), .Y(n215) );
  NOR4X1 U886 ( .A(n218), .B(n217), .C(n216), .D(n215), .Y(n219) );
  AO22X1 U887 ( .A0(n222), .A1(n221), .B0(n220), .B1(n219), .Y(N910) );
  OAI22XL U888 ( .A0(\string_buffer[9][5] ), .A1(n817), .B0(
        \string_buffer[8][5] ), .B1(n818), .Y(n226) );
  OAI22XL U889 ( .A0(\string_buffer[11][5] ), .A1(n819), .B0(
        \string_buffer[10][5] ), .B1(n820), .Y(n225) );
  OAI22XL U890 ( .A0(\string_buffer[13][5] ), .A1(n821), .B0(
        \string_buffer[12][5] ), .B1(n822), .Y(n224) );
  OAI22XL U891 ( .A0(\string_buffer[15][5] ), .A1(n823), .B0(
        \string_buffer[14][5] ), .B1(n824), .Y(n223) );
  NOR4X1 U892 ( .A(n226), .B(n225), .C(n224), .D(n223), .Y(n534) );
  OAI221XL U893 ( .A0(\string_buffer[0][5] ), .A1(n825), .B0(
        \string_buffer[1][5] ), .B1(n826), .C0(n157), .Y(n230) );
  OAI22XL U894 ( .A0(\string_buffer[3][5] ), .A1(n827), .B0(
        \string_buffer[2][5] ), .B1(n828), .Y(n229) );
  OAI22XL U895 ( .A0(\string_buffer[5][5] ), .A1(n829), .B0(
        \string_buffer[4][5] ), .B1(n830), .Y(n228) );
  OAI22XL U896 ( .A0(\string_buffer[7][5] ), .A1(n831), .B0(
        \string_buffer[6][5] ), .B1(n832), .Y(n227) );
  NOR4X1 U897 ( .A(n230), .B(n229), .C(n228), .D(n227), .Y(n317) );
  OAI22XL U898 ( .A0(\string_buffer[25][5] ), .A1(n817), .B0(
        \string_buffer[24][5] ), .B1(n818), .Y(n234) );
  OAI22XL U899 ( .A0(\string_buffer[27][5] ), .A1(n819), .B0(
        \string_buffer[26][5] ), .B1(n820), .Y(n233) );
  OAI22XL U900 ( .A0(\string_buffer[29][5] ), .A1(n821), .B0(
        \string_buffer[28][5] ), .B1(n822), .Y(n232) );
  OAI22XL U901 ( .A0(\string_buffer[31][5] ), .A1(n823), .B0(
        \string_buffer[30][5] ), .B1(n824), .Y(n231) );
  NOR4X1 U902 ( .A(n234), .B(n233), .C(n232), .D(n231), .Y(n240) );
  OAI221XL U903 ( .A0(\string_buffer[16][5] ), .A1(n825), .B0(
        \string_buffer[17][5] ), .B1(n826), .C0(N254), .Y(n238) );
  OAI22XL U904 ( .A0(\string_buffer[19][5] ), .A1(n827), .B0(
        \string_buffer[18][5] ), .B1(n828), .Y(n237) );
  OAI22XL U905 ( .A0(\string_buffer[21][5] ), .A1(n829), .B0(
        \string_buffer[20][5] ), .B1(n830), .Y(n236) );
  OAI22XL U906 ( .A0(\string_buffer[23][5] ), .A1(n831), .B0(
        \string_buffer[22][5] ), .B1(n832), .Y(n235) );
  NOR4X1 U907 ( .A(n238), .B(n237), .C(n236), .D(n235), .Y(n239) );
  AO22X1 U908 ( .A0(n534), .A1(n317), .B0(n240), .B1(n239), .Y(N909) );
  OAI22XL U909 ( .A0(\string_buffer[9][6] ), .A1(n817), .B0(
        \string_buffer[8][6] ), .B1(n818), .Y(n764) );
  OAI22XL U910 ( .A0(\string_buffer[11][6] ), .A1(n819), .B0(
        \string_buffer[10][6] ), .B1(n820), .Y(n763) );
  OAI22XL U911 ( .A0(\string_buffer[13][6] ), .A1(n821), .B0(
        \string_buffer[12][6] ), .B1(n822), .Y(n536) );
  OAI22XL U912 ( .A0(\string_buffer[15][6] ), .A1(n823), .B0(
        \string_buffer[14][6] ), .B1(n824), .Y(n535) );
  NOR4X1 U913 ( .A(n764), .B(n763), .C(n536), .D(n535), .Y(n780) );
  OAI221XL U914 ( .A0(\string_buffer[0][6] ), .A1(n825), .B0(
        \string_buffer[1][6] ), .B1(n826), .C0(n157), .Y(n768) );
  OAI22XL U915 ( .A0(\string_buffer[3][6] ), .A1(n827), .B0(
        \string_buffer[2][6] ), .B1(n828), .Y(n767) );
  OAI22XL U916 ( .A0(\string_buffer[5][6] ), .A1(n829), .B0(
        \string_buffer[4][6] ), .B1(n830), .Y(n766) );
  OAI22XL U917 ( .A0(\string_buffer[7][6] ), .A1(n831), .B0(
        \string_buffer[6][6] ), .B1(n832), .Y(n765) );
  NOR4X1 U918 ( .A(n768), .B(n767), .C(n766), .D(n765), .Y(n779) );
  OAI22XL U919 ( .A0(\string_buffer[25][6] ), .A1(n817), .B0(
        \string_buffer[24][6] ), .B1(n818), .Y(n772) );
  OAI22XL U920 ( .A0(\string_buffer[27][6] ), .A1(n819), .B0(
        \string_buffer[26][6] ), .B1(n820), .Y(n771) );
  OAI22XL U921 ( .A0(\string_buffer[29][6] ), .A1(n821), .B0(
        \string_buffer[28][6] ), .B1(n822), .Y(n770) );
  OAI22XL U922 ( .A0(\string_buffer[31][6] ), .A1(n823), .B0(
        \string_buffer[30][6] ), .B1(n824), .Y(n769) );
  NOR4X1 U923 ( .A(n772), .B(n771), .C(n770), .D(n769), .Y(n778) );
  OAI221XL U924 ( .A0(\string_buffer[16][6] ), .A1(n825), .B0(
        \string_buffer[17][6] ), .B1(n826), .C0(N254), .Y(n776) );
  OAI22XL U925 ( .A0(\string_buffer[19][6] ), .A1(n827), .B0(
        \string_buffer[18][6] ), .B1(n828), .Y(n775) );
  OAI22XL U926 ( .A0(\string_buffer[21][6] ), .A1(n829), .B0(
        \string_buffer[20][6] ), .B1(n830), .Y(n774) );
  OAI22XL U927 ( .A0(\string_buffer[23][6] ), .A1(n831), .B0(
        \string_buffer[22][6] ), .B1(n832), .Y(n773) );
  NOR4X1 U928 ( .A(n776), .B(n775), .C(n774), .D(n773), .Y(n777) );
  AO22X1 U929 ( .A0(n780), .A1(n779), .B0(n778), .B1(n777), .Y(N908) );
  OAI22XL U930 ( .A0(\string_buffer[9][7] ), .A1(n817), .B0(
        \string_buffer[8][7] ), .B1(n818), .Y(n784) );
  OAI22XL U931 ( .A0(\string_buffer[11][7] ), .A1(n819), .B0(
        \string_buffer[10][7] ), .B1(n820), .Y(n783) );
  OAI22XL U932 ( .A0(\string_buffer[13][7] ), .A1(n821), .B0(
        \string_buffer[12][7] ), .B1(n822), .Y(n782) );
  OAI22XL U933 ( .A0(\string_buffer[15][7] ), .A1(n823), .B0(
        \string_buffer[14][7] ), .B1(n824), .Y(n781) );
  NOR4X1 U934 ( .A(n784), .B(n783), .C(n782), .D(n781), .Y(n816) );
  OAI221XL U935 ( .A0(\string_buffer[0][7] ), .A1(n825), .B0(
        \string_buffer[1][7] ), .B1(n826), .C0(n157), .Y(n788) );
  OAI22XL U936 ( .A0(\string_buffer[3][7] ), .A1(n827), .B0(
        \string_buffer[2][7] ), .B1(n828), .Y(n787) );
  OAI22XL U937 ( .A0(\string_buffer[5][7] ), .A1(n829), .B0(
        \string_buffer[4][7] ), .B1(n830), .Y(n786) );
  OAI22XL U938 ( .A0(\string_buffer[7][7] ), .A1(n831), .B0(
        \string_buffer[6][7] ), .B1(n832), .Y(n785) );
  NOR4X1 U939 ( .A(n788), .B(n787), .C(n786), .D(n785), .Y(n815) );
  OAI22XL U940 ( .A0(\string_buffer[26][7] ), .A1(n820), .B0(
        \string_buffer[25][7] ), .B1(n817), .Y(n799) );
  OAI22XL U941 ( .A0(\string_buffer[28][7] ), .A1(n822), .B0(
        \string_buffer[27][7] ), .B1(n819), .Y(n798) );
  OAI22XL U942 ( .A0(\string_buffer[30][7] ), .A1(n824), .B0(
        \string_buffer[29][7] ), .B1(n821), .Y(n797) );
  OAI21XL U943 ( .A0(\string_buffer[31][7] ), .A1(n823), .B0(N254), .Y(n796)
         );
  NOR4X1 U944 ( .A(n799), .B(n798), .C(n797), .D(n796), .Y(n814) );
  OAI222XL U945 ( .A0(\string_buffer[17][7] ), .A1(n826), .B0(
        \string_buffer[16][7] ), .B1(n825), .C0(\string_buffer[18][7] ), .C1(
        n828), .Y(n812) );
  OAI22XL U946 ( .A0(\string_buffer[20][7] ), .A1(n830), .B0(
        \string_buffer[19][7] ), .B1(n827), .Y(n811) );
  OAI22XL U947 ( .A0(\string_buffer[22][7] ), .A1(n832), .B0(
        \string_buffer[21][7] ), .B1(n829), .Y(n810) );
  OAI22XL U948 ( .A0(\string_buffer[24][7] ), .A1(n818), .B0(
        \string_buffer[23][7] ), .B1(n831), .Y(n809) );
  NOR4X1 U949 ( .A(n812), .B(n811), .C(n810), .D(n809), .Y(n813) );
  AO22X1 U950 ( .A0(n816), .A1(n815), .B0(n814), .B1(n813), .Y(N907) );
  XOR2X1 U951 ( .A(\add_304/carry[4] ), .B(N254), .Y(N289) );
endmodule


module SME ( clk, reset, chardata, isstring, ispattern, valid, match, 
        match_index );
  input [7:0] chardata;
  output [4:0] match_index;
  input clk, reset, isstring, ispattern;
  output valid, match;
  wire   match_enable, rst_read_count, \string_buffer[0][7] ,
         \string_buffer[0][6] , \string_buffer[0][5] , \string_buffer[0][4] ,
         \string_buffer[0][3] , \string_buffer[0][2] , \string_buffer[0][1] ,
         \string_buffer[0][0] , \string_buffer[1][7] , \string_buffer[1][6] ,
         \string_buffer[1][5] , \string_buffer[1][4] , \string_buffer[1][3] ,
         \string_buffer[1][2] , \string_buffer[1][1] , \string_buffer[1][0] ,
         \string_buffer[2][7] , \string_buffer[2][6] , \string_buffer[2][5] ,
         \string_buffer[2][4] , \string_buffer[2][3] , \string_buffer[2][2] ,
         \string_buffer[2][1] , \string_buffer[2][0] , \string_buffer[3][7] ,
         \string_buffer[3][6] , \string_buffer[3][5] , \string_buffer[3][4] ,
         \string_buffer[3][3] , \string_buffer[3][2] , \string_buffer[3][1] ,
         \string_buffer[3][0] , \string_buffer[4][7] , \string_buffer[4][6] ,
         \string_buffer[4][5] , \string_buffer[4][4] , \string_buffer[4][3] ,
         \string_buffer[4][2] , \string_buffer[4][1] , \string_buffer[4][0] ,
         \string_buffer[5][7] , \string_buffer[5][6] , \string_buffer[5][5] ,
         \string_buffer[5][4] , \string_buffer[5][3] , \string_buffer[5][2] ,
         \string_buffer[5][1] , \string_buffer[5][0] , \string_buffer[6][7] ,
         \string_buffer[6][6] , \string_buffer[6][5] , \string_buffer[6][4] ,
         \string_buffer[6][3] , \string_buffer[6][2] , \string_buffer[6][1] ,
         \string_buffer[6][0] , \string_buffer[7][7] , \string_buffer[7][6] ,
         \string_buffer[7][5] , \string_buffer[7][4] , \string_buffer[7][3] ,
         \string_buffer[7][2] , \string_buffer[7][1] , \string_buffer[7][0] ,
         \string_buffer[8][7] , \string_buffer[8][6] , \string_buffer[8][5] ,
         \string_buffer[8][4] , \string_buffer[8][3] , \string_buffer[8][2] ,
         \string_buffer[8][1] , \string_buffer[8][0] , \string_buffer[9][7] ,
         \string_buffer[9][6] , \string_buffer[9][5] , \string_buffer[9][4] ,
         \string_buffer[9][3] , \string_buffer[9][2] , \string_buffer[9][1] ,
         \string_buffer[9][0] , \string_buffer[10][7] , \string_buffer[10][6] ,
         \string_buffer[10][5] , \string_buffer[10][4] ,
         \string_buffer[10][3] , \string_buffer[10][2] ,
         \string_buffer[10][1] , \string_buffer[10][0] ,
         \string_buffer[11][7] , \string_buffer[11][6] ,
         \string_buffer[11][5] , \string_buffer[11][4] ,
         \string_buffer[11][3] , \string_buffer[11][2] ,
         \string_buffer[11][1] , \string_buffer[11][0] ,
         \string_buffer[12][7] , \string_buffer[12][6] ,
         \string_buffer[12][5] , \string_buffer[12][4] ,
         \string_buffer[12][3] , \string_buffer[12][2] ,
         \string_buffer[12][1] , \string_buffer[12][0] ,
         \string_buffer[13][7] , \string_buffer[13][6] ,
         \string_buffer[13][5] , \string_buffer[13][4] ,
         \string_buffer[13][3] , \string_buffer[13][2] ,
         \string_buffer[13][1] , \string_buffer[13][0] ,
         \string_buffer[14][7] , \string_buffer[14][6] ,
         \string_buffer[14][5] , \string_buffer[14][4] ,
         \string_buffer[14][3] , \string_buffer[14][2] ,
         \string_buffer[14][1] , \string_buffer[14][0] ,
         \string_buffer[15][7] , \string_buffer[15][6] ,
         \string_buffer[15][5] , \string_buffer[15][4] ,
         \string_buffer[15][3] , \string_buffer[15][2] ,
         \string_buffer[15][1] , \string_buffer[15][0] ,
         \string_buffer[16][7] , \string_buffer[16][6] ,
         \string_buffer[16][5] , \string_buffer[16][4] ,
         \string_buffer[16][3] , \string_buffer[16][2] ,
         \string_buffer[16][1] , \string_buffer[16][0] ,
         \string_buffer[17][7] , \string_buffer[17][6] ,
         \string_buffer[17][5] , \string_buffer[17][4] ,
         \string_buffer[17][3] , \string_buffer[17][2] ,
         \string_buffer[17][1] , \string_buffer[17][0] ,
         \string_buffer[18][7] , \string_buffer[18][6] ,
         \string_buffer[18][5] , \string_buffer[18][4] ,
         \string_buffer[18][3] , \string_buffer[18][2] ,
         \string_buffer[18][1] , \string_buffer[18][0] ,
         \string_buffer[19][7] , \string_buffer[19][6] ,
         \string_buffer[19][5] , \string_buffer[19][4] ,
         \string_buffer[19][3] , \string_buffer[19][2] ,
         \string_buffer[19][1] , \string_buffer[19][0] ,
         \string_buffer[20][7] , \string_buffer[20][6] ,
         \string_buffer[20][5] , \string_buffer[20][4] ,
         \string_buffer[20][3] , \string_buffer[20][2] ,
         \string_buffer[20][1] , \string_buffer[20][0] ,
         \string_buffer[21][7] , \string_buffer[21][6] ,
         \string_buffer[21][5] , \string_buffer[21][4] ,
         \string_buffer[21][3] , \string_buffer[21][2] ,
         \string_buffer[21][1] , \string_buffer[21][0] ,
         \string_buffer[22][7] , \string_buffer[22][6] ,
         \string_buffer[22][5] , \string_buffer[22][4] ,
         \string_buffer[22][3] , \string_buffer[22][2] ,
         \string_buffer[22][1] , \string_buffer[22][0] ,
         \string_buffer[23][7] , \string_buffer[23][6] ,
         \string_buffer[23][5] , \string_buffer[23][4] ,
         \string_buffer[23][3] , \string_buffer[23][2] ,
         \string_buffer[23][1] , \string_buffer[23][0] ,
         \string_buffer[24][7] , \string_buffer[24][6] ,
         \string_buffer[24][5] , \string_buffer[24][4] ,
         \string_buffer[24][3] , \string_buffer[24][2] ,
         \string_buffer[24][1] , \string_buffer[24][0] ,
         \string_buffer[25][7] , \string_buffer[25][6] ,
         \string_buffer[25][5] , \string_buffer[25][4] ,
         \string_buffer[25][3] , \string_buffer[25][2] ,
         \string_buffer[25][1] , \string_buffer[25][0] ,
         \string_buffer[26][7] , \string_buffer[26][6] ,
         \string_buffer[26][5] , \string_buffer[26][4] ,
         \string_buffer[26][3] , \string_buffer[26][2] ,
         \string_buffer[26][1] , \string_buffer[26][0] ,
         \string_buffer[27][7] , \string_buffer[27][6] ,
         \string_buffer[27][5] , \string_buffer[27][4] ,
         \string_buffer[27][3] , \string_buffer[27][2] ,
         \string_buffer[27][1] , \string_buffer[27][0] ,
         \string_buffer[28][7] , \string_buffer[28][6] ,
         \string_buffer[28][5] , \string_buffer[28][4] ,
         \string_buffer[28][3] , \string_buffer[28][2] ,
         \string_buffer[28][1] , \string_buffer[28][0] ,
         \string_buffer[29][7] , \string_buffer[29][6] ,
         \string_buffer[29][5] , \string_buffer[29][4] ,
         \string_buffer[29][3] , \string_buffer[29][2] ,
         \string_buffer[29][1] , \string_buffer[29][0] ,
         \string_buffer[30][7] , \string_buffer[30][6] ,
         \string_buffer[30][5] , \string_buffer[30][4] ,
         \string_buffer[30][3] , \string_buffer[30][2] ,
         \string_buffer[30][1] , \string_buffer[30][0] ,
         \string_buffer[31][7] , \string_buffer[31][6] ,
         \string_buffer[31][5] , \string_buffer[31][4] ,
         \string_buffer[31][3] , \string_buffer[31][2] ,
         \string_buffer[31][1] , \string_buffer[31][0] ,
         \pattern_buffer[0][7] , \pattern_buffer[0][6] ,
         \pattern_buffer[0][5] , \pattern_buffer[0][4] ,
         \pattern_buffer[0][3] , \pattern_buffer[0][2] ,
         \pattern_buffer[0][1] , \pattern_buffer[0][0] ,
         \pattern_buffer[1][7] , \pattern_buffer[1][6] ,
         \pattern_buffer[1][5] , \pattern_buffer[1][4] ,
         \pattern_buffer[1][3] , \pattern_buffer[1][2] ,
         \pattern_buffer[1][1] , \pattern_buffer[1][0] ,
         \pattern_buffer[2][7] , \pattern_buffer[2][6] ,
         \pattern_buffer[2][5] , \pattern_buffer[2][4] ,
         \pattern_buffer[2][3] , \pattern_buffer[2][2] ,
         \pattern_buffer[2][1] , \pattern_buffer[2][0] ,
         \pattern_buffer[3][7] , \pattern_buffer[3][6] ,
         \pattern_buffer[3][5] , \pattern_buffer[3][4] ,
         \pattern_buffer[3][3] , \pattern_buffer[3][2] ,
         \pattern_buffer[3][1] , \pattern_buffer[3][0] ,
         \pattern_buffer[4][7] , \pattern_buffer[4][6] ,
         \pattern_buffer[4][5] , \pattern_buffer[4][4] ,
         \pattern_buffer[4][3] , \pattern_buffer[4][2] ,
         \pattern_buffer[4][1] , \pattern_buffer[4][0] ,
         \pattern_buffer[5][7] , \pattern_buffer[5][6] ,
         \pattern_buffer[5][5] , \pattern_buffer[5][4] ,
         \pattern_buffer[5][3] , \pattern_buffer[5][2] ,
         \pattern_buffer[5][1] , \pattern_buffer[5][0] ,
         \pattern_buffer[6][7] , \pattern_buffer[6][6] ,
         \pattern_buffer[6][5] , \pattern_buffer[6][4] ,
         \pattern_buffer[6][3] , \pattern_buffer[6][2] ,
         \pattern_buffer[6][1] , \pattern_buffer[6][0] ,
         \pattern_buffer[7][7] , \pattern_buffer[7][6] ,
         \pattern_buffer[7][5] , \pattern_buffer[7][4] ,
         \pattern_buffer[7][3] , \pattern_buffer[7][2] ,
         \pattern_buffer[7][1] , \pattern_buffer[7][0] ;
  wire   [4:0] read_string_count;
  wire   [2:0] read_pattern_count;

  FSM fsm ( .clk(clk), .reset(reset), .isstring(isstring), .ispattern(
        ispattern), .match_enable(match_enable), .rst_read_count(
        rst_read_count) );
  read_chardata read_chardata ( .clk(clk), .reset(reset), .isstring(isstring), 
        .ispattern(ispattern), .chardata(chardata), .rst_read_count(
        rst_read_count), .string_buffer({\string_buffer[0][7] , 
        \string_buffer[0][6] , \string_buffer[0][5] , \string_buffer[0][4] , 
        \string_buffer[0][3] , \string_buffer[0][2] , \string_buffer[0][1] , 
        \string_buffer[0][0] , \string_buffer[1][7] , \string_buffer[1][6] , 
        \string_buffer[1][5] , \string_buffer[1][4] , \string_buffer[1][3] , 
        \string_buffer[1][2] , \string_buffer[1][1] , \string_buffer[1][0] , 
        \string_buffer[2][7] , \string_buffer[2][6] , \string_buffer[2][5] , 
        \string_buffer[2][4] , \string_buffer[2][3] , \string_buffer[2][2] , 
        \string_buffer[2][1] , \string_buffer[2][0] , \string_buffer[3][7] , 
        \string_buffer[3][6] , \string_buffer[3][5] , \string_buffer[3][4] , 
        \string_buffer[3][3] , \string_buffer[3][2] , \string_buffer[3][1] , 
        \string_buffer[3][0] , \string_buffer[4][7] , \string_buffer[4][6] , 
        \string_buffer[4][5] , \string_buffer[4][4] , \string_buffer[4][3] , 
        \string_buffer[4][2] , \string_buffer[4][1] , \string_buffer[4][0] , 
        \string_buffer[5][7] , \string_buffer[5][6] , \string_buffer[5][5] , 
        \string_buffer[5][4] , \string_buffer[5][3] , \string_buffer[5][2] , 
        \string_buffer[5][1] , \string_buffer[5][0] , \string_buffer[6][7] , 
        \string_buffer[6][6] , \string_buffer[6][5] , \string_buffer[6][4] , 
        \string_buffer[6][3] , \string_buffer[6][2] , \string_buffer[6][1] , 
        \string_buffer[6][0] , \string_buffer[7][7] , \string_buffer[7][6] , 
        \string_buffer[7][5] , \string_buffer[7][4] , \string_buffer[7][3] , 
        \string_buffer[7][2] , \string_buffer[7][1] , \string_buffer[7][0] , 
        \string_buffer[8][7] , \string_buffer[8][6] , \string_buffer[8][5] , 
        \string_buffer[8][4] , \string_buffer[8][3] , \string_buffer[8][2] , 
        \string_buffer[8][1] , \string_buffer[8][0] , \string_buffer[9][7] , 
        \string_buffer[9][6] , \string_buffer[9][5] , \string_buffer[9][4] , 
        \string_buffer[9][3] , \string_buffer[9][2] , \string_buffer[9][1] , 
        \string_buffer[9][0] , \string_buffer[10][7] , \string_buffer[10][6] , 
        \string_buffer[10][5] , \string_buffer[10][4] , \string_buffer[10][3] , 
        \string_buffer[10][2] , \string_buffer[10][1] , \string_buffer[10][0] , 
        \string_buffer[11][7] , \string_buffer[11][6] , \string_buffer[11][5] , 
        \string_buffer[11][4] , \string_buffer[11][3] , \string_buffer[11][2] , 
        \string_buffer[11][1] , \string_buffer[11][0] , \string_buffer[12][7] , 
        \string_buffer[12][6] , \string_buffer[12][5] , \string_buffer[12][4] , 
        \string_buffer[12][3] , \string_buffer[12][2] , \string_buffer[12][1] , 
        \string_buffer[12][0] , \string_buffer[13][7] , \string_buffer[13][6] , 
        \string_buffer[13][5] , \string_buffer[13][4] , \string_buffer[13][3] , 
        \string_buffer[13][2] , \string_buffer[13][1] , \string_buffer[13][0] , 
        \string_buffer[14][7] , \string_buffer[14][6] , \string_buffer[14][5] , 
        \string_buffer[14][4] , \string_buffer[14][3] , \string_buffer[14][2] , 
        \string_buffer[14][1] , \string_buffer[14][0] , \string_buffer[15][7] , 
        \string_buffer[15][6] , \string_buffer[15][5] , \string_buffer[15][4] , 
        \string_buffer[15][3] , \string_buffer[15][2] , \string_buffer[15][1] , 
        \string_buffer[15][0] , \string_buffer[16][7] , \string_buffer[16][6] , 
        \string_buffer[16][5] , \string_buffer[16][4] , \string_buffer[16][3] , 
        \string_buffer[16][2] , \string_buffer[16][1] , \string_buffer[16][0] , 
        \string_buffer[17][7] , \string_buffer[17][6] , \string_buffer[17][5] , 
        \string_buffer[17][4] , \string_buffer[17][3] , \string_buffer[17][2] , 
        \string_buffer[17][1] , \string_buffer[17][0] , \string_buffer[18][7] , 
        \string_buffer[18][6] , \string_buffer[18][5] , \string_buffer[18][4] , 
        \string_buffer[18][3] , \string_buffer[18][2] , \string_buffer[18][1] , 
        \string_buffer[18][0] , \string_buffer[19][7] , \string_buffer[19][6] , 
        \string_buffer[19][5] , \string_buffer[19][4] , \string_buffer[19][3] , 
        \string_buffer[19][2] , \string_buffer[19][1] , \string_buffer[19][0] , 
        \string_buffer[20][7] , \string_buffer[20][6] , \string_buffer[20][5] , 
        \string_buffer[20][4] , \string_buffer[20][3] , \string_buffer[20][2] , 
        \string_buffer[20][1] , \string_buffer[20][0] , \string_buffer[21][7] , 
        \string_buffer[21][6] , \string_buffer[21][5] , \string_buffer[21][4] , 
        \string_buffer[21][3] , \string_buffer[21][2] , \string_buffer[21][1] , 
        \string_buffer[21][0] , \string_buffer[22][7] , \string_buffer[22][6] , 
        \string_buffer[22][5] , \string_buffer[22][4] , \string_buffer[22][3] , 
        \string_buffer[22][2] , \string_buffer[22][1] , \string_buffer[22][0] , 
        \string_buffer[23][7] , \string_buffer[23][6] , \string_buffer[23][5] , 
        \string_buffer[23][4] , \string_buffer[23][3] , \string_buffer[23][2] , 
        \string_buffer[23][1] , \string_buffer[23][0] , \string_buffer[24][7] , 
        \string_buffer[24][6] , \string_buffer[24][5] , \string_buffer[24][4] , 
        \string_buffer[24][3] , \string_buffer[24][2] , \string_buffer[24][1] , 
        \string_buffer[24][0] , \string_buffer[25][7] , \string_buffer[25][6] , 
        \string_buffer[25][5] , \string_buffer[25][4] , \string_buffer[25][3] , 
        \string_buffer[25][2] , \string_buffer[25][1] , \string_buffer[25][0] , 
        \string_buffer[26][7] , \string_buffer[26][6] , \string_buffer[26][5] , 
        \string_buffer[26][4] , \string_buffer[26][3] , \string_buffer[26][2] , 
        \string_buffer[26][1] , \string_buffer[26][0] , \string_buffer[27][7] , 
        \string_buffer[27][6] , \string_buffer[27][5] , \string_buffer[27][4] , 
        \string_buffer[27][3] , \string_buffer[27][2] , \string_buffer[27][1] , 
        \string_buffer[27][0] , \string_buffer[28][7] , \string_buffer[28][6] , 
        \string_buffer[28][5] , \string_buffer[28][4] , \string_buffer[28][3] , 
        \string_buffer[28][2] , \string_buffer[28][1] , \string_buffer[28][0] , 
        \string_buffer[29][7] , \string_buffer[29][6] , \string_buffer[29][5] , 
        \string_buffer[29][4] , \string_buffer[29][3] , \string_buffer[29][2] , 
        \string_buffer[29][1] , \string_buffer[29][0] , \string_buffer[30][7] , 
        \string_buffer[30][6] , \string_buffer[30][5] , \string_buffer[30][4] , 
        \string_buffer[30][3] , \string_buffer[30][2] , \string_buffer[30][1] , 
        \string_buffer[30][0] , \string_buffer[31][7] , \string_buffer[31][6] , 
        \string_buffer[31][5] , \string_buffer[31][4] , \string_buffer[31][3] , 
        \string_buffer[31][2] , \string_buffer[31][1] , \string_buffer[31][0] }), .pattern_buffer({\pattern_buffer[0][7] , \pattern_buffer[0][6] , 
        \pattern_buffer[0][5] , \pattern_buffer[0][4] , \pattern_buffer[0][3] , 
        \pattern_buffer[0][2] , \pattern_buffer[0][1] , \pattern_buffer[0][0] , 
        \pattern_buffer[1][7] , \pattern_buffer[1][6] , \pattern_buffer[1][5] , 
        \pattern_buffer[1][4] , \pattern_buffer[1][3] , \pattern_buffer[1][2] , 
        \pattern_buffer[1][1] , \pattern_buffer[1][0] , \pattern_buffer[2][7] , 
        \pattern_buffer[2][6] , \pattern_buffer[2][5] , \pattern_buffer[2][4] , 
        \pattern_buffer[2][3] , \pattern_buffer[2][2] , \pattern_buffer[2][1] , 
        \pattern_buffer[2][0] , \pattern_buffer[3][7] , \pattern_buffer[3][6] , 
        \pattern_buffer[3][5] , \pattern_buffer[3][4] , \pattern_buffer[3][3] , 
        \pattern_buffer[3][2] , \pattern_buffer[3][1] , \pattern_buffer[3][0] , 
        \pattern_buffer[4][7] , \pattern_buffer[4][6] , \pattern_buffer[4][5] , 
        \pattern_buffer[4][4] , \pattern_buffer[4][3] , \pattern_buffer[4][2] , 
        \pattern_buffer[4][1] , \pattern_buffer[4][0] , \pattern_buffer[5][7] , 
        \pattern_buffer[5][6] , \pattern_buffer[5][5] , \pattern_buffer[5][4] , 
        \pattern_buffer[5][3] , \pattern_buffer[5][2] , \pattern_buffer[5][1] , 
        \pattern_buffer[5][0] , \pattern_buffer[6][7] , \pattern_buffer[6][6] , 
        \pattern_buffer[6][5] , \pattern_buffer[6][4] , \pattern_buffer[6][3] , 
        \pattern_buffer[6][2] , \pattern_buffer[6][1] , \pattern_buffer[6][0] , 
        \pattern_buffer[7][7] , \pattern_buffer[7][6] , \pattern_buffer[7][5] , 
        \pattern_buffer[7][4] , \pattern_buffer[7][3] , \pattern_buffer[7][2] , 
        \pattern_buffer[7][1] , \pattern_buffer[7][0] }), .read_string_count(
        read_string_count), .read_pattern_count(read_pattern_count) );
  match_controller match_controller ( .clk(clk), .reset(reset), .isstring(
        isstring), .ispattern(ispattern), .string_buffer({
        \string_buffer[0][7] , \string_buffer[0][6] , \string_buffer[0][5] , 
        \string_buffer[0][4] , \string_buffer[0][3] , \string_buffer[0][2] , 
        \string_buffer[0][1] , \string_buffer[0][0] , \string_buffer[1][7] , 
        \string_buffer[1][6] , \string_buffer[1][5] , \string_buffer[1][4] , 
        \string_buffer[1][3] , \string_buffer[1][2] , \string_buffer[1][1] , 
        \string_buffer[1][0] , \string_buffer[2][7] , \string_buffer[2][6] , 
        \string_buffer[2][5] , \string_buffer[2][4] , \string_buffer[2][3] , 
        \string_buffer[2][2] , \string_buffer[2][1] , \string_buffer[2][0] , 
        \string_buffer[3][7] , \string_buffer[3][6] , \string_buffer[3][5] , 
        \string_buffer[3][4] , \string_buffer[3][3] , \string_buffer[3][2] , 
        \string_buffer[3][1] , \string_buffer[3][0] , \string_buffer[4][7] , 
        \string_buffer[4][6] , \string_buffer[4][5] , \string_buffer[4][4] , 
        \string_buffer[4][3] , \string_buffer[4][2] , \string_buffer[4][1] , 
        \string_buffer[4][0] , \string_buffer[5][7] , \string_buffer[5][6] , 
        \string_buffer[5][5] , \string_buffer[5][4] , \string_buffer[5][3] , 
        \string_buffer[5][2] , \string_buffer[5][1] , \string_buffer[5][0] , 
        \string_buffer[6][7] , \string_buffer[6][6] , \string_buffer[6][5] , 
        \string_buffer[6][4] , \string_buffer[6][3] , \string_buffer[6][2] , 
        \string_buffer[6][1] , \string_buffer[6][0] , \string_buffer[7][7] , 
        \string_buffer[7][6] , \string_buffer[7][5] , \string_buffer[7][4] , 
        \string_buffer[7][3] , \string_buffer[7][2] , \string_buffer[7][1] , 
        \string_buffer[7][0] , \string_buffer[8][7] , \string_buffer[8][6] , 
        \string_buffer[8][5] , \string_buffer[8][4] , \string_buffer[8][3] , 
        \string_buffer[8][2] , \string_buffer[8][1] , \string_buffer[8][0] , 
        \string_buffer[9][7] , \string_buffer[9][6] , \string_buffer[9][5] , 
        \string_buffer[9][4] , \string_buffer[9][3] , \string_buffer[9][2] , 
        \string_buffer[9][1] , \string_buffer[9][0] , \string_buffer[10][7] , 
        \string_buffer[10][6] , \string_buffer[10][5] , \string_buffer[10][4] , 
        \string_buffer[10][3] , \string_buffer[10][2] , \string_buffer[10][1] , 
        \string_buffer[10][0] , \string_buffer[11][7] , \string_buffer[11][6] , 
        \string_buffer[11][5] , \string_buffer[11][4] , \string_buffer[11][3] , 
        \string_buffer[11][2] , \string_buffer[11][1] , \string_buffer[11][0] , 
        \string_buffer[12][7] , \string_buffer[12][6] , \string_buffer[12][5] , 
        \string_buffer[12][4] , \string_buffer[12][3] , \string_buffer[12][2] , 
        \string_buffer[12][1] , \string_buffer[12][0] , \string_buffer[13][7] , 
        \string_buffer[13][6] , \string_buffer[13][5] , \string_buffer[13][4] , 
        \string_buffer[13][3] , \string_buffer[13][2] , \string_buffer[13][1] , 
        \string_buffer[13][0] , \string_buffer[14][7] , \string_buffer[14][6] , 
        \string_buffer[14][5] , \string_buffer[14][4] , \string_buffer[14][3] , 
        \string_buffer[14][2] , \string_buffer[14][1] , \string_buffer[14][0] , 
        \string_buffer[15][7] , \string_buffer[15][6] , \string_buffer[15][5] , 
        \string_buffer[15][4] , \string_buffer[15][3] , \string_buffer[15][2] , 
        \string_buffer[15][1] , \string_buffer[15][0] , \string_buffer[16][7] , 
        \string_buffer[16][6] , \string_buffer[16][5] , \string_buffer[16][4] , 
        \string_buffer[16][3] , \string_buffer[16][2] , \string_buffer[16][1] , 
        \string_buffer[16][0] , \string_buffer[17][7] , \string_buffer[17][6] , 
        \string_buffer[17][5] , \string_buffer[17][4] , \string_buffer[17][3] , 
        \string_buffer[17][2] , \string_buffer[17][1] , \string_buffer[17][0] , 
        \string_buffer[18][7] , \string_buffer[18][6] , \string_buffer[18][5] , 
        \string_buffer[18][4] , \string_buffer[18][3] , \string_buffer[18][2] , 
        \string_buffer[18][1] , \string_buffer[18][0] , \string_buffer[19][7] , 
        \string_buffer[19][6] , \string_buffer[19][5] , \string_buffer[19][4] , 
        \string_buffer[19][3] , \string_buffer[19][2] , \string_buffer[19][1] , 
        \string_buffer[19][0] , \string_buffer[20][7] , \string_buffer[20][6] , 
        \string_buffer[20][5] , \string_buffer[20][4] , \string_buffer[20][3] , 
        \string_buffer[20][2] , \string_buffer[20][1] , \string_buffer[20][0] , 
        \string_buffer[21][7] , \string_buffer[21][6] , \string_buffer[21][5] , 
        \string_buffer[21][4] , \string_buffer[21][3] , \string_buffer[21][2] , 
        \string_buffer[21][1] , \string_buffer[21][0] , \string_buffer[22][7] , 
        \string_buffer[22][6] , \string_buffer[22][5] , \string_buffer[22][4] , 
        \string_buffer[22][3] , \string_buffer[22][2] , \string_buffer[22][1] , 
        \string_buffer[22][0] , \string_buffer[23][7] , \string_buffer[23][6] , 
        \string_buffer[23][5] , \string_buffer[23][4] , \string_buffer[23][3] , 
        \string_buffer[23][2] , \string_buffer[23][1] , \string_buffer[23][0] , 
        \string_buffer[24][7] , \string_buffer[24][6] , \string_buffer[24][5] , 
        \string_buffer[24][4] , \string_buffer[24][3] , \string_buffer[24][2] , 
        \string_buffer[24][1] , \string_buffer[24][0] , \string_buffer[25][7] , 
        \string_buffer[25][6] , \string_buffer[25][5] , \string_buffer[25][4] , 
        \string_buffer[25][3] , \string_buffer[25][2] , \string_buffer[25][1] , 
        \string_buffer[25][0] , \string_buffer[26][7] , \string_buffer[26][6] , 
        \string_buffer[26][5] , \string_buffer[26][4] , \string_buffer[26][3] , 
        \string_buffer[26][2] , \string_buffer[26][1] , \string_buffer[26][0] , 
        \string_buffer[27][7] , \string_buffer[27][6] , \string_buffer[27][5] , 
        \string_buffer[27][4] , \string_buffer[27][3] , \string_buffer[27][2] , 
        \string_buffer[27][1] , \string_buffer[27][0] , \string_buffer[28][7] , 
        \string_buffer[28][6] , \string_buffer[28][5] , \string_buffer[28][4] , 
        \string_buffer[28][3] , \string_buffer[28][2] , \string_buffer[28][1] , 
        \string_buffer[28][0] , \string_buffer[29][7] , \string_buffer[29][6] , 
        \string_buffer[29][5] , \string_buffer[29][4] , \string_buffer[29][3] , 
        \string_buffer[29][2] , \string_buffer[29][1] , \string_buffer[29][0] , 
        \string_buffer[30][7] , \string_buffer[30][6] , \string_buffer[30][5] , 
        \string_buffer[30][4] , \string_buffer[30][3] , \string_buffer[30][2] , 
        \string_buffer[30][1] , \string_buffer[30][0] , \string_buffer[31][7] , 
        \string_buffer[31][6] , \string_buffer[31][5] , \string_buffer[31][4] , 
        \string_buffer[31][3] , \string_buffer[31][2] , \string_buffer[31][1] , 
        \string_buffer[31][0] }), .pattern_buffer({\pattern_buffer[0][7] , 
        \pattern_buffer[0][6] , \pattern_buffer[0][5] , \pattern_buffer[0][4] , 
        \pattern_buffer[0][3] , \pattern_buffer[0][2] , \pattern_buffer[0][1] , 
        \pattern_buffer[0][0] , \pattern_buffer[1][7] , \pattern_buffer[1][6] , 
        \pattern_buffer[1][5] , \pattern_buffer[1][4] , \pattern_buffer[1][3] , 
        \pattern_buffer[1][2] , \pattern_buffer[1][1] , \pattern_buffer[1][0] , 
        \pattern_buffer[2][7] , \pattern_buffer[2][6] , \pattern_buffer[2][5] , 
        \pattern_buffer[2][4] , \pattern_buffer[2][3] , \pattern_buffer[2][2] , 
        \pattern_buffer[2][1] , \pattern_buffer[2][0] , \pattern_buffer[3][7] , 
        \pattern_buffer[3][6] , \pattern_buffer[3][5] , \pattern_buffer[3][4] , 
        \pattern_buffer[3][3] , \pattern_buffer[3][2] , \pattern_buffer[3][1] , 
        \pattern_buffer[3][0] , \pattern_buffer[4][7] , \pattern_buffer[4][6] , 
        \pattern_buffer[4][5] , \pattern_buffer[4][4] , \pattern_buffer[4][3] , 
        \pattern_buffer[4][2] , \pattern_buffer[4][1] , \pattern_buffer[4][0] , 
        \pattern_buffer[5][7] , \pattern_buffer[5][6] , \pattern_buffer[5][5] , 
        \pattern_buffer[5][4] , \pattern_buffer[5][3] , \pattern_buffer[5][2] , 
        \pattern_buffer[5][1] , \pattern_buffer[5][0] , \pattern_buffer[6][7] , 
        \pattern_buffer[6][6] , \pattern_buffer[6][5] , \pattern_buffer[6][4] , 
        \pattern_buffer[6][3] , \pattern_buffer[6][2] , \pattern_buffer[6][1] , 
        \pattern_buffer[6][0] , \pattern_buffer[7][7] , \pattern_buffer[7][6] , 
        \pattern_buffer[7][5] , \pattern_buffer[7][4] , \pattern_buffer[7][3] , 
        \pattern_buffer[7][2] , \pattern_buffer[7][1] , \pattern_buffer[7][0] }), .read_string_count(read_string_count), .read_pattern_count(
        read_pattern_count), .match_enable(match_enable), .match(match), 
        .match_index(match_index), .valid(valid) );
endmodule

