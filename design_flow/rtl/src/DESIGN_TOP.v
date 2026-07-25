`timescale 1ns/1ps
// ------------------------------------------------------------
// Module: DESIGN_TOP
// 說明  : 頂層空殼模板，請替換成實際設計
// Reset : 非同步、高電位有效 (rst)
// ------------------------------------------------------------
module DESIGN_TOP (
    input  wire clk,
    input  wire rst,
    input  wire in_valid,
    input  wire [7:0] in_data,
    output reg  out_valid,
    output reg  [7:0] out_data
);

    // TODO: 實作資料路徑與控制邏輯
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            out_valid <= 1'b0;
            out_data  <= 8'd0;
        end else begin
            out_valid <= in_valid;
            out_data  <= in_data;
        end
    end

endmodule
