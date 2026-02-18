`timescale 1ns/100ps
`include   "./table.v"


//`include "/home/SOC/M143110005/EF/B_ICC2018_grad_cell-based/SYN/pipeline_signed_final_version_div_code4/scan_chain/TSMC13_4/clk_6.6/netlist/RFILE_syn.v"
`define SDFFILE "/home/SOC/M143110005/EF/B_ICC2018_grad_cell-based/ICC/pipeline_signed_final_version_div_code5/APR/scan_chain/TSMC13_5/clk_6/netlist/RFILE_apr.sdf"
//`ifdef GATE
//   `include "/home/SOC/M143110005/EF/B_ICC2018_grad_cell-based/SYN/pipeline_general_version/ADFP16/clk_1.5/netlist/RFILE_syn.v" 
//`else 
//   `include  "/home/SOC/M143110005/EF/B_ICC2018_grad_cell-based/RTL/RFILE_pipeline_general_version.v"
//`endif 
//`include "/home/SOC/M143110005/EF/B_ICC2018_grad_cell-based/ICC/RFILE_pr.v"
//
//`define SDFFILE "/home/SOC/M143110005/EF/B_ICC2018_grad_cell-based/ICC/RFILE_apr.sdf"

`ifdef TSMC
   `include             "/home/SOC/M143110005/EF/B_ICC2018_grad_cell-based/SIM/tsmc13_neg.v"
`elsif ADFP
   `include             "/home/SOC/M143110005/EF/B_ICC2018_grad_cell-based/SIM/N16ADFP_StdCell.v"
`endif 



`define CYCLE       6.35             //Modify your CYCLE
`define DEL         `CYCLE/4
`define PAT_NUM     100

module test;
reg           clk;
reg           rst;
reg  [19:0]   rssiA;
reg  [19:0]   rssiB;
reg  [19:0]   rssiC;
reg           test_se;
reg           test_si;
wire          test_so;
wire          busy;
wire          out_valid;
wire [7:0]    xt;
wire [7:0]    yt;
wire [11:0]   expA, expB, expC;
wire [15:0]   valueA, valueB, valueC;

reg  [19:0]   pat_mem[0:`PAT_NUM*3-1];
reg  [7:0]    exp_mem[0:`PAT_NUM*2-1];
reg  [7:0]    xt_temp;
reg  [7:0]    yt_temp;
reg  [10:0]   cycle_count;
integer       i, j, pass, err, dist;
reg           over;


RFILE u_RFILE( .clk        (clk        ),
               .rst        (rst        ),
`ifdef PAT2    
               .A_x        (8'd5       ),
               .A_y        (8'd5       ),
               .B_x        (8'd100     ),
               .B_y        (8'd20      ),
               .C_x        (8'd50      ),
               .C_y        (8'd100     ),
`elsif PAT3    
               .A_x        (8'd5       ),
               .A_y        (8'd21      ),
               .B_x        (8'd80      ),
               .B_y        (8'd91      ),
               .C_x        (8'd95      ),
               .C_y        (8'd1       ),               
`else //PAT1
               .A_x        (8'd2       ),
               .A_y        (8'd2       ),
               .B_x        (8'd62      ),
               .B_y        (8'd2       ),
               .C_x        (8'd62      ),
               .C_y        (8'd62      ),               
`endif
`ifdef SCAN
               .test_se    (test_se    ),
               .test_si    (test_si    ),
               .test_so    (test_so    ),
`endif
               .rssiA      (rssiA      ), 
               .rssiB      (rssiB      ),
               .rssiC      (rssiC      ), 
               .valueA     (valueA     ),
               .valueB     (valueB     ),
               .valueC     (valueC     ),
               .expA       (expA       ),
               .expB       (expB       ),
               .expC       (expC       ),
               .busy       (busy       ), 
               .out_valid  (out_valid  ), 
               .xt         (xt         ), 
               .yt         (yt         )
             );

TABLE u_TABLEA(.exp        (expA       ),
               .value      (valueA     )
              );

TABLE u_TABLEB(.exp        (expB       ),
               .value      (valueB     )
              );

TABLE u_TABLEC(.exp        (expC       ),
               .value      (valueC     )
              );


               
`ifdef TSMC
   initial $sdf_annotate(`SDFFILE, u_RFILE );
`elsif ADFP
   initial $sdf_annotate(`SDFFILE, u_RFILE );
`endif

`ifdef PAT2
   initial	$readmemh ("./PAT/pattern2.dat", pat_mem);
   initial	$readmemh ("./PAT/golden2.dat",  exp_mem);
`elsif PAT3
   initial	$readmemh ("./PAT/pattern3.dat", pat_mem);
   initial	$readmemh ("./PAT/golden3.dat",  exp_mem);
`else //PAT1
   initial	$readmemh ("./PAT/pattern1.dat", pat_mem);
   initial	$readmemh ("./PAT/golden1.dat",  exp_mem);
`endif

initial begin
   clk           = 1'b0;   
   rst           = 1'b0;
   i             = 0;
   j             = 0;
   pass          = 0;
   err           = 0;
   over          = 0;
   cycle_count   = 1;
end

always begin #(`CYCLE/2)  clk = ~clk; end

always begin #(`CYCLE)  cycle_count = cycle_count +1; end

initial begin
   #(100000);
   $finish;
end

initial begin
   test_se = 1'b0;
   test_si = 1'b0;
end

initial begin
$dumpfile("RFILE_test_power.vcd");
$dumpvars;
//$fsdbDumpfile("RFILE_debug.fsdb");
//$fsdbDumpvars;
//$fsdbDumpMDA;
// Setup toggle region for power analysis
$set_toggle_region(test.u_RFILE);
$toggle_start();
end



initial begin
   @(posedge clk)  #(`DEL)  rst =  1'b1;
   #(`CYCLE*1)            rst =  1'b0;

    $display("-----------------------------------------------------\n");  
    $display("Start to Send RSSI & Compare ...\n\n");       

   @(posedge clk);
   while (i < `PAT_NUM*3-1) begin
      if(!busy)begin   
         #(`DEL)
         rssiA   = pat_mem[i];
         rssiB   = pat_mem[i+1];
         rssiC   = pat_mem[i+2];
         i=i+3;     
      end
      @(posedge clk); 
   end     
end


always @(posedge clk)begin
   if(out_valid)begin        
      xt_temp=exp_mem[j]; yt_temp=exp_mem[j+1];

      dist = ((xt_temp -xt)**2 + (yt_temp - yt)**2);
      if(dist > 10) begin                  
         $display("T%02d:  your xt=%02h  yt=%02h != expect xt=%02h yt=%02h   =>  difference= %5d", j/2, xt, yt, xt_temp, yt_temp, dist);
         err = err + 1 ;  
      end            
      else if(dist === 'hx)begin
         $display("T%02d:  your xt=%02h  yt=%02h != expect xt=%02h yt=%02h   =>  difference= %5d", j/2, xt, yt, xt_temp, yt_temp, dist);
         err = err + 1 ;  
      end
      else begin      
         $display("T%02d:  your xt=%02h  yt=%02h == expect xt=%02h yt=%02h   =>  difference= %5d =>  PASS", j/2, xt, yt, xt_temp, yt_temp, dist);
         pass = pass + 1 ;
      end     
      
      if(j <  `PAT_NUM*2-2)begin     j=j+2;      over=0;  end
      else                 begin     j=j;        over=1;  end
   end                                                                        
end


initial begin
      @(posedge over)      
      $display("\n\nSend RSSI & Compare Over!");
      $display("-----------------------------------------------------\n\n");  
      if(over) begin
         $display("-----------------------------------------------------\n");
         if (err == 0 && pass==`PAT_NUM)  begin
            $display("Congratulations! All data have been generated successfully!\n");
            $display("-------------------------PASS------------------------\n");
         end
         else begin
            $display("Final Simulation Result as below: \n");         
            $display("-----------------------------------------------------\n");
            $display("Pass:   %3d \n", pass);
            $display("Error:  %3d \n", err);
            $display("-----------------------------------------------------\n");
         end
      end
      `ifdef PAT3
      $display("--------------------Pattern3 Simulation has been down----------------");   
      `elsif PAT2
      $display("--------------------Pattern2 Simulation has been down----------------");         
      `else
      $display("--------------------Pattern1 Simulation has been down----------------");   
      `endif 
      
      $display("----------------------------Total Cycle = %d-------------------------", cycle_count);
      // Stop toggle collection and generate SAIF file for power analysis
      $toggle_stop();
      $toggle_report("RFILE_power.saif", 1.0e-12, "test");
      #(`CYCLE/2); $finish;
end
   

   
endmodule



