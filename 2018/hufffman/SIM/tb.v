// version 0.9%2018-03-14
// version 0.91% move the section of initial $sdf_annotate
`timescale 1ns/10ps

//`include "../RTL/huffman.v"
`define CLK_period 2000  // CLK period. DO NOT modify period



`ifdef RTL
    `include "../RTL/huffman.v"
    `include "/mnt2/CBDK_UMC_180nm_Faraday_v1.1/CIC/Verilog/fsa0m_a_t33_generic_io_21.lib"
`elsif GATE
    `include "../SYN/dft_netlist/huffman_syn.v"
    `define SDFFILE "../SYN/dft_netlist/huffman_syn.sdf"
    `include "/mnt2/CBDK_UMC_180nm_Faraday_v1.1/CIC/Verilog/fsa0m_a_generic_core_21.lib"
    `include "/mnt2/CBDK_UMC_180nm_Faraday_v1.1/CIC/Verilog/fsa0m_a_t33_generic_io_21.lib"
`elsif LAYOUT
    `include "../innovus_file/apr_netlist/huffman_netlist.v"
    `define SDFFILE "../innovus_file/apr_netlist/huffman_netlist.sdf"
    `include "/mnt2/CBDK_UMC_180nm_Faraday_v1.1/CIC/Verilog/fsa0m_a_generic_core_21.lib"
    `include "/mnt2/CBDK_UMC_180nm_Faraday_v1.1/CIC/Verilog/fsa0m_a_t33_generic_io_21.lib"
`endif

`ifdef tb1
  `define PAT "/home/pit116/U18_chip/huffman/SIM/data/pattern1.dat"
  `define EXP "/home/pit116/U18_chip/huffman/SIM/data/golden1.dat"
`endif
`ifdef tb2
  `define PAT "/home/pit116/U18_chip/huffman/SIM/data/pattern2.dat"
  `define EXP "/home/pit116/U18_chip/huffman/SIM/data/golden2.dat"
`endif
`ifdef tb3
  `define PAT "/home/pit116/U18_chip/huffman/SIM/data/pattern3.dat"
  `define EXP "/home/pit116/U18_chip/huffman/SIM/data/golden3.dat"
`endif

`ifdef tb4
  `define PAT "/home/pit116/U18_chip/huffman/SIM/data/pattern4.dat"
  `define EXP "/home/pit116/U18_chip/huffman/SIM/data/golden4.dat"
`endif

`ifdef tb5
  `define PAT "/home/pit116/U18_chip/huffman/SIM/data/pattern5.dat"
  `define EXP "/home/pit116/U18_chip/huffman/SIM/data/golden5.dat"
`endif

`ifdef tb6
  `define PAT "/home/pit116/U18_chip/huffman/SIM/data/pattern6.dat"
  `define EXP "/home/pit116/U18_chip/huffman/SIM/data/golden6.dat"
`endif

`ifdef tb7
  `define PAT "/home/pit116/U18_chip/huffman/SIM/data/pattern7.dat"
  `define EXP "/home/pit116/U18_chip/huffman/SIM/data/golden7.dat"
`endif

`ifdef tb8
  `define PAT "/home/pit116/U18_chip/huffman/SIM/data/pattern8.dat"
  `define EXP "/home/pit116/U18_chip/huffman/SIM/data/golden8.dat"
`endif

`ifdef tb9
  `define PAT "/home/pit116/U18_chip/huffman/SIM/data/pattern9.dat"
  `define EXP "/home/pit116/U18_chip/huffman/SIM/data/golden9.dat"
`endif

`ifdef tb10
  `define PAT "/home/pit116/U18_chip/huffman/SIM/data/pattern10.dat"
  `define EXP "/home/pit116/U18_chip/huffman/SIM/data/golden10.dat"
`endif


module tb;
reg CLK;
reg reset;
reg [2:0] pat_mem [0:99];
reg [7:0] exp_mem [0:17];
reg gray_valid;
reg [2:0] gray_data;
integer i;
integer k;
reg [10:0] clk_count;
reg test_se;
reg test_si;
wire test_so;
wire CNT_valid;
wire [6:0] CNT;
wire code_valid;
wire [4:0] HC;
wire [4:0] M; 

reg flag1; // CNT PASS or not
reg flag2; // HC PASS or not
reg flag3; // M PASS or not
reg done1;

reg  [47:0] CNT_G;
wire [47:0] CNT_EXP;
reg [47:0] HC_G;
wire[47:0] HC_EXP;
reg [47:0] M_G;
wire[47:0] M_EXP;


`ifdef GATE
  initial $sdf_annotate(`SDFFILE, u_huffman);
`elsif LAYOUT
  initial $sdf_annotate(`SDFFILE, u_huffman);
`endif

`ifdef RTL
  initial begin
    $fsdbDumpfile("/home/pit116/U18_chip/huffman/SIM/huffman_RTL_.fsdb");
    $fsdbDumpvars;
  end
  //initial begin
  //  $dumpfile("/home/pit116/U18_chip/huffman/SIM/huffman_RTL.vcd");
  //  $dumpvars;
  //end
`elsif GATE
  initial begin
    $fsdbDumpfile("/home/pit116/U18_chip/huffman/SIM/huffman_GATE.fsdb");
    $fsdbDumpvars;
  end
  initial begin
    $dumpfile("/home/pit116/U18_chip/huffman/SIM/huffman_GATE.vcd");
    $dumpvars;
  end
`elsif LAYOUT
  initial begin
    $fsdbDumpfile("/home/pit116/U18_chip/huffman/SIM/huffman_LAYOUT.fsdb");
    $fsdbDumpvars;
  end
  initial begin
    $dumpfile("/home/pit116/U18_chip/huffman/SIM/huffman_LAYOUT.vcd");
    $dumpvars;
  end
`endif

`ifdef RTL
huffman u_huffman(
    .clk(CLK),
    .reset(reset), 
    .gray_valid(gray_valid), 
    .gray_data(gray_data),
    .CNT_valid(CNT_valid), 
    .CNT(CNT),
    .code_valid(code_valid), 
    .HC(HC),
    .M(M)
    );
`elsif GATE
huffman u_huffman(
    .clk(CLK),
    .reset(reset), 
    .gray_valid(gray_valid), 
    .gray_data(gray_data),
    .CNT_valid(CNT_valid), 
    .CNT(CNT),
    .code_valid(code_valid), 
    .HC(HC),
    .M(M),
    .test_se(test_se),
    .test_si(test_si),
    .test_so(test_so)
    );
`elsif LAYOUT
huffman u_huffman(
    .clk(CLK),
    .reset(reset), 
    .gray_valid(gray_valid), 
    .gray_data(gray_data),
    .CNT_valid(CNT_valid), 
    .CNT(CNT),
    .code_valid(code_valid), 
    .HC(HC),
    .M(M),
    .test_se(test_se),
    .test_si(test_si),
    .test_so(test_so)
    );
`endif 
//assign CNT_G = {CNT[1], CNT[2], CNT[3], CNT[4], CNT[5], CNT[6]};
assign CNT_EXP = {exp_mem[0], exp_mem[1], exp_mem[2], exp_mem[3], exp_mem[4], exp_mem[5]};
//assign HC_G = {3'b0, HC[1], 3'b0, HC[2], 3'b0, HC[3], 3'b0, HC[4], 3'b0, HC[5], 3'b0, HC[6]};
assign HC_EXP = {exp_mem[6], exp_mem[7], exp_mem[8], exp_mem[9], exp_mem[10], exp_mem[11]};
//assign M_G = {3'b0, M[1], 3'b0, M[2], 3'b0, M[3], 3'b0, M[4], 3'b0, M[5], 3'b0, M[6]};
assign M_EXP = {exp_mem[12], exp_mem[13], exp_mem[14], exp_mem[15], exp_mem[16], exp_mem[17]};

initial $readmemh(`PAT, pat_mem);
initial $readmemh(`EXP, exp_mem);
initial $display("%s and %s were used for this simulation.", `PAT, `EXP);   //

initial CLK = 1'b0;
initial clk_count = 11'b0;

always begin #(`CLK_period/2) CLK = ~CLK; end

always begin #(`CLK_period) clk_count = clk_count+1 ; end
initial begin
  #0 reset = 1'b0;
  #`CLK_period reset = 1'b1;
  #(`CLK_period*1) reset = 1'b0;
end

initial begin
  #0 gray_valid = 1'b0;
  #0 CNT_G = 48'b0;
  #0 HC_G = 48'b0;
  #0 M_G = 48'b0;
     i = 0;
     k = 0;
  #(`CLK_period*3);
  @(negedge CLK) gray_valid = 1'b1;
  gray_data = pat_mem[i];
  for (i=1;i<100;i=i+1)
    @(negedge CLK) gray_data = pat_mem[i];
  @(negedge CLK) gray_valid = 1'b0;
       gray_data = 3'b0;
  #(`CLK_period*1)
  for (k=0; k<6; k=k+1) begin
    @(posedge CLK)
        CNT_G[(47-(k*8)) -: 8] = {1'b0, CNT}; 
  end
  #(`CLK_period*52);
    for (k=0; k<6; k=k+1) begin
    @(posedge CLK)
        HC_G[(47-(k*8)) -: 8] = {3'b0, HC}; 
        M_G[(47-(k*8)) -: 8] = {3'b0, M}; 
  end
end
initial begin
    test_se = 1'b0;   // always normal mode
    test_si = 1'b0;   // don't care in normal mode
end
initial begin
#(`CLK_period*200);
$finish;
end

always@(posedge CLK) begin
  if (reset) begin
    done1 <= 1'b0;
    flag1 <= 1'b0;
    flag2 <= 1'b0;
    flag3 <= 1'b0;
  end else begin 

    if(CNT_valid == 1'b1) begin
      if (CNT_G == CNT_EXP) begin     // flag1 1 means PASS, 0 means ERROR
        $display("Check CNT : PASS");
        flag1 <= 1'b1;
      end else begin
        $display("Check CNT : ERROR. Please fixed it first!");
        $display("Simulation stop here.");
        //$finish;
      end
      done1 <= 1'b1;
    end

    if(code_valid == 1'b1) begin

      case ({(HC_G == HC_EXP),(M_G == M_EXP)})   // (HC_G == HC_EXP) true means HC PASS
        2'b00: begin                             // (M_G == M_EXP) true means M PASS
                 $display("Check HC : ERROR");
                 $display("Check M : ERROR");
                 $display("Simulation stop here.");
                 $finish;
               end
        2'b01: begin
                 $display("Check HC : ERROR");
                 $display("Check M : PASS");
                 $display("Simulation stop here.");
                 $finish;
               end
        2'b10: begin
                 $display("Check HC : PASS");
                 $display("Check M : ERROR");
                 $display("Simulation stop here.");
                 $finish;
               end
        2'b11: begin
                 $display("Check HC : PASS");
                 $display("Check M : PASS");
                 if(flag1 == 1'b1)
                   $display("You PASS the contest now.");
                 else
                   $display("Where are those CNT output?");

                 //$stop;
               end
		default:    $finish;	
        endcase
		$display("total use %d cycle.", clk_count);
        $finish;		
    end

  end
end


/*
initial begin
  for (i=0; i<100; i=i+1) begin
    $display("%3d %h", i, pat_mem[i]);
  end
  $display("--------------------------------------");
  for( i=0; i<18; i=i+1) begin
    $display("%3d %h", i, exp_mem[i]);
  end
end
*/

endmodule

