`timescale 1ns/1ps
// ------------------------------------------------------------
// 簡易 testbench 模板
// ------------------------------------------------------------
module tb_DESIGN_TOP;
    reg        clk;
    reg        rst;
    reg        in_valid;
    reg  [7:0] in_data;
    wire       out_valid;
    wire [7:0] out_data;

    DESIGN_TOP u_dut (
        .clk      (clk),
        .rst      (rst),
        .in_valid (in_valid),
        .in_data  (in_data),
        .out_valid(out_valid),
        .out_data (out_data)
    );

    // 時脈
    initial clk = 1'b0;
    always #5 clk = ~clk;

    initial begin
        rst      = 1'b1;
        in_valid = 1'b0;
        in_data  = 8'd0;
        repeat (4) @(posedge clk);
        rst = 1'b0;

        // 簡單刺激
        @(posedge clk);
        in_valid = 1'b1;
        in_data  = 8'hA5;
        @(posedge clk);
        in_valid = 1'b0;

        repeat (10) @(posedge clk);
        $display("[TB] smoke done, out_data=%h out_valid=%b", out_data, out_valid);
        $finish;
    end
endmodule
