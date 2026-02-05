`timescale 1ns/10ps
`define EXTRACT_LOW  16'h6FFF
`define EXTRACT_HIGH 16'hAFFF
`define EXCLUDE_LOW  16'h7FFF
`define EXCLUDE_HIGH 16'hBFFF

`define FIND_MAX 1
`define FIND_MIN 2
`define FIND_AVE 3
`define EXTRACT 4
`define EXCLUDE 5
`define PEAKMAX 6
`define PEAKMIN 7
`define IDLE 8
`define IOT_DATA_STORAGE 9
`define OUTPUT_VALID 10
`define INITIALIZATION 11
`define CHANGE_PEAK_MIN 12
module IOTDF( clk, rst, in_en, iot_in, fn_sel, busy, valid, iot_out);
input          clk;
input          rst;
input          in_en;
input  [7:0]   iot_in;
input  [2:0]   fn_sel;
output         busy;
output         valid;
output [127:0] iot_out;

wire [3:0] data_bit_count;
wire [2:0] data_count;
wire [127:0] max_value;
wire [127:0] min_value;
wire [130:0] ave_value;
wire [127:0] extract_out;
wire [127:0] exclude_out;
wire [127:0] peak_max;
wire [127:0] peak_min;
wire peak_max_valid;
wire peak_min_valid;
wire max_valid;
wire min_valid;
wire ave_valid;
wire extract_valid;
wire exclude_valid;
wire change_peak_min_value;
wire function_flag;
wire busy;
wire valid;
wire [3:0] cur_state;
wire [3:0] nxt_state;
wire [127:0] iot_data;
FSM u_FSM(.clk(clk),
           .rst(rst),
           .in_en(in_en),
           .fn_sel(fn_sel),
           .function_flag(function_flag),
           .data_bit_count(data_bit_count),
           .data_count(data_count),
           .max_value(max_value),
           .min_value(min_value),
           .ave_value(ave_value),
           .extract_out(extract_out),
           .exclude_out(exclude_out),
           .peak_max(peak_max),
           .peak_min(peak_min),
           .max_valid(max_valid),
           .min_valid(min_valid),
           .ave_valid(ave_valid),
           .extract_valid(extract_valid),
           .exclude_valid(exclude_valid),
           .peak_max_valid(peak_max_valid),
           .peak_min_valid(peak_min_valid),
           .change_peak_min_value(change_peak_min_value),
           .iot_out(iot_out),
           .busy(busy),
           .valid(valid),
           .cur_state(cur_state),
           .nxt_state(nxt_state)
         );

IOT_DATA_STORAGE u_IOT_DATA_STORAGE(.clk(clk),
           .rst(rst),
           .iot_in(iot_in),
           .data_bit_count(data_bit_count),
           .iot_data(iot_data),
           .cur_state(cur_state)
         );
DATA_COUNT_COUNTER u_DATA_COUNT_COUNTER(.clk(clk),
           .rst(rst),
           .cur_state(cur_state),
           .data_bit_count(data_bit_count),
           .data_count(data_count)
         );
DATA_BIT_COUNTER u_DATA_BIT_COUNTER(.clk(clk),
           .rst(rst),
           .cur_state(cur_state),
           .function_flag(function_flag),
           .data_bit_count(data_bit_count)
         );
max_finder u_max_finder(.clk(clk),
           .rst(rst),
           .cur_state(cur_state),
           .data_count(data_count),
           .iot_data(iot_data),
           .max_value(max_value),
           .max_valid(max_valid),
           .change_max_value(change_max_value)
         );
min_finder u_min_finder(.clk(clk),
           .rst(rst),
           .cur_state(cur_state),
           .data_count(data_count),
           .iot_data(iot_data),
           .min_value(min_value),
           .min_valid(min_valid),
           .change_min_value(change_min_value)
         );
ave_value u_ave_value(.clk(clk),
           .rst(rst),
           .cur_state(cur_state),
           .ave_valid(ave_valid),
           .iot_data(iot_data),
           .data_count(data_count),
           .ave_value(ave_value)
         );
extract_finder u_extract_finder(.clk(clk),
           .rst(rst),
           .cur_state(cur_state),
           .iot_data(iot_data),
           .extract_out(extract_out),
           .extract_valid(extract_valid)
         );
exclude_finder u_exclude_finder(.clk(clk),
           .rst(rst),
           .cur_state(cur_state),
           .iot_data(iot_data),
           .exclude_out(exclude_out),
           .exclude_valid(exclude_valid)
         );
peakmax_finder u_peakmax_finder(.clk(clk),
           .rst(rst),
           .cur_state(cur_state),
           .max_value(max_value),
           .peak_max(peak_max),
           .data_count(data_count),
           .peak_max_valid(peak_max_valid)
         );
peakmin_finder u_peakmin_finder(.clk(clk),
           .rst(rst),
           .cur_state(cur_state),
           .iot_data(iot_data),
           .min_value(min_value),
           .peak_min(peak_min),
           .data_count(data_count),
           .peak_min_valid(peak_min_valid),
           .change_peak_min_value(change_peak_min_value)
         );
endmodule



module FSM(
    input clk,
    input rst,
    input in_en,
    input [2:0] fn_sel,
    input [3:0] data_bit_count,
    input [2:0] data_count,
    input [127:0] max_value,
    input [127:0] min_value,
    input [130:0] ave_value,
    input [127:0] extract_out,
    input [127:0] exclude_out,
    input [127:0] peak_max,
    input [127:0] peak_min,
    input max_valid,
    input min_valid,
    input ave_valid,
    input extract_valid,
    input exclude_valid,
    input peak_max_valid,
    input peak_min_valid,
    input change_peak_min_value,
    output reg [127:0] iot_out,
    output busy,
    output function_flag,
    output reg valid,
    output reg [3:0] cur_state,
    output reg [3:0] nxt_state
);

assign busy = rst|| (data_bit_count == 4'd15)|| function_flag|| cur_state == `OUTPUT_VALID || cur_state == `INITIALIZATION || cur_state == `CHANGE_PEAK_MIN ? 1'b1 : 1'b0;
assign function_flag = (cur_state == `FIND_MAX || cur_state == `FIND_MIN || cur_state == `FIND_AVE || cur_state == `EXTRACT || cur_state == `EXCLUDE || cur_state == `PEAKMAX || cur_state == `PEAKMIN) ? 1'b1 : 1'b0;

always @(posedge clk or posedge rst) begin
    if (rst) begin
        cur_state <= `IDLE;
    end else begin
        cur_state <= nxt_state;
    end
end
always @(posedge clk or posedge rst) begin
    if (rst) begin
        valid <= 1'b0;
    end else if (cur_state == `OUTPUT_VALID) begin
        valid <= 1'b1;
    end else begin
        valid <= 1'b0;
    end
end
always @(posedge clk or posedge rst) begin
    if (rst) begin
        iot_out <= 128'h0;
    end else if (cur_state == `OUTPUT_VALID) begin
    case (fn_sel)
        `FIND_MAX: begin
            iot_out <= max_value;
        end
        `FIND_MIN: begin
            iot_out <= min_value;
        end
        `FIND_AVE: begin
            iot_out <= ave_value[130:3];
        end
        `EXTRACT: begin
            iot_out <= extract_out;
        end
        `EXCLUDE: begin
            iot_out <= exclude_out;
        end
        `PEAKMAX: begin
            iot_out <= peak_max;
        end
        `PEAKMIN: begin
            iot_out <= peak_min;
        end
        default: begin
            iot_out <= 128'h0;
        end
    endcase
    end
    else begin
        iot_out <= 128'h0;
    end
end

always @(*) begin
    case (cur_state)
        `IDLE: begin
            if (busy) begin
                nxt_state = `IDLE;
            end else begin
                nxt_state = `IOT_DATA_STORAGE;
            end
        end
        `IOT_DATA_STORAGE: begin
            if (data_bit_count == 4'd15) begin
                case (fn_sel)
                    3'd1: begin
                        nxt_state = `FIND_MAX;
                    end
                    3'd2: begin
                        nxt_state = `FIND_MIN;
                    end
                    3'd3: begin
                        nxt_state = `FIND_AVE;
                    end
                    3'd4: begin
                        nxt_state = `EXTRACT;
                    end
                    3'd5: begin
                        nxt_state = `EXCLUDE;
                    end
                    3'd6: begin
                        nxt_state = `PEAKMAX;
                    end
                    3'd7: begin
                        nxt_state = `PEAKMIN;
                    end
                    default: begin
                        nxt_state = `IDLE;
                    end
                endcase
            end else begin
                nxt_state = `IOT_DATA_STORAGE;
            end
        end
        `FIND_MAX: begin
            if (max_valid) begin
                nxt_state = `OUTPUT_VALID;
            end else begin
                nxt_state = `IDLE;
            end
        end
        `FIND_MIN: begin
            if (min_valid) begin
                nxt_state = `OUTPUT_VALID;
            end else begin
                nxt_state = `IDLE;
            end
        end
        `FIND_AVE: begin 
            if (ave_valid) begin
                nxt_state = `OUTPUT_VALID;
            end else begin
                nxt_state = `IDLE;
            end
        end
        `EXTRACT: begin
            if (extract_valid) begin
                nxt_state = `OUTPUT_VALID;
            end else begin
                nxt_state = `IDLE;
            end
        end
        `EXCLUDE: begin
            if (exclude_valid) begin
                nxt_state = `OUTPUT_VALID;
            end else begin
                nxt_state = `IDLE;
            end
        end
        `PEAKMAX: begin
            if (peak_max_valid) begin
                nxt_state = `OUTPUT_VALID;
            end else begin
                nxt_state = `IDLE;
            end
        end
        `PEAKMIN: begin
            if (change_peak_min_value) begin
                nxt_state = `CHANGE_PEAK_MIN;
            end else if (peak_min_valid) begin
                nxt_state = `OUTPUT_VALID;
            end else begin
                nxt_state = `IDLE;
            end
        end
        `CHANGE_PEAK_MIN: begin
            if (peak_min_valid) 
            nxt_state = `OUTPUT_VALID;
            else begin
                nxt_state = `IDLE;
            end
        end
        `OUTPUT_VALID: begin
            nxt_state = `INITIALIZATION;
        end
        `INITIALIZATION: begin
            nxt_state = `IDLE;
        end
        default: begin
            nxt_state = `IDLE;
        end
        //`IOT_FUNCTION_CONTROL: begin
        //
        //end
    endcase
end

endmodule

module DATA_COUNT_COUNTER(
    input clk,
    input rst,
    input [3:0] cur_state,
    input [3:0] data_bit_count,
    output reg [2:0] data_count
);

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            data_count <= 3'd0;
        end else if (data_bit_count == 4'd15) begin
            data_count <= data_count + 1;
        end
    end
endmodule

module DATA_BIT_COUNTER(
    input clk,
    input rst,
    input [3:0] cur_state,
    input function_flag,
    output reg [3:0] data_bit_count
);

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            data_bit_count <= 4'd0;
        end else if (cur_state == `IOT_DATA_STORAGE) begin
            data_bit_count <= data_bit_count + 1;
        end
        else if (cur_state == `OUTPUT_VALID || function_flag || cur_state == `INITIALIZATION) begin
            data_bit_count <= 4'd0;
        end
    end
endmodule

module IOT_DATA_STORAGE(
    input clk,
    input rst,
    input [3:0] cur_state,
    input [3:0] data_bit_count,
    input [7:0] iot_in,
    output reg [127:0] iot_data
);

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            iot_data <= 128'h0;
        end else if (cur_state == `IOT_DATA_STORAGE) begin
            case (data_bit_count)
                4'd0: iot_data[127:120] <= iot_in;
                4'd1: iot_data[119:112] <= iot_in;
                4'd2: iot_data[111:104] <= iot_in;
                4'd3: iot_data[103:96] <= iot_in;
                4'd4: iot_data[95:88] <= iot_in;
                4'd5: iot_data[87:80] <= iot_in;
                4'd6: iot_data[79:72] <= iot_in;
                4'd7: iot_data[71:64] <= iot_in;
                4'd8: iot_data[63:56] <= iot_in;
                4'd9: iot_data[55:48] <= iot_in;
                4'd10: iot_data[47:40] <= iot_in;
                4'd11: iot_data[39:32] <= iot_in;
                4'd12: iot_data[31:24] <= iot_in;
                4'd13: iot_data[23:16] <= iot_in;
                4'd14: iot_data[15:8] <= iot_in;
                4'd15: iot_data[7:0] <= iot_in;
            endcase
        end
    end
endmodule

module max_finder(
    input clk,
    input rst,
    input [3:0] cur_state,
    input [2:0] data_count,
    input [127:0] iot_data,
    output reg [127:0] max_value,
    output max_valid,
    output change_max_value
);

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            max_value <= 128'd0;
        end else if ((cur_state == `FIND_MAX || cur_state == `PEAKMAX) && change_max_value) begin
            max_value <= iot_data;
        end
        else if (cur_state == `INITIALIZATION) begin
            max_value <= 128'd0;
        end
    end

    assign max_valid = (data_count == 3'd0 && cur_state == `FIND_MAX) ? 1'b1 : 1'b0;
    assign change_max_value = (iot_data[127:120] > max_value[127:120]) ? 1 : 0;
endmodule


module min_finder(
    input clk,
    input rst,
    input [3:0] cur_state,
    input [2:0] data_count,
    input [127:0] iot_data,
    output reg [127:0] min_value,
    output min_valid,
    output change_min_value
);
    wire min_flag;


    always @(posedge clk or posedge rst) begin
        if (rst) begin
            min_value <= 128'd0;
        end else if (min_flag && (cur_state == `FIND_MIN || cur_state == `PEAKMIN)) begin
            min_value <= iot_data;
        end else if ((cur_state == `FIND_MIN || cur_state == `PEAKMIN) && change_min_value) begin
            min_value <= iot_data;
        end
        else if (cur_state == `INITIALIZATION) begin
            min_value <= 128'd0;
        end
    end
    assign min_flag = (min_value == 128'd0) ? 1'b1 : 1'b0;
    assign min_valid = (data_count == 3'd0 && cur_state == `FIND_MIN) ? 1'b1 : 1'b0;
    assign change_min_value = (iot_data[127:120] < min_value[127:120]) ? 1 : 0;

endmodule

module ave_value (
    input clk,
    input rst,
    input [3:0] cur_state,
    input [2:0] data_count,
    input [127:0] iot_data,
    output reg [130:0] ave_value,
    output ave_valid
);
    
    assign ave_valid = (data_count == 3'd0 && cur_state == `FIND_AVE) ? 1'b1 : 1'b0;
    
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            ave_value <= 131'd0;
        end else if (cur_state == `FIND_AVE) begin
            ave_value <= ave_value + iot_data;
        end else if (cur_state == `INITIALIZATION) begin
            ave_value <= 131'd0;
        end
    end

endmodule

module extract_finder(
    input clk,
    input rst,
    input [3:0] cur_state,
    input [127:0] iot_data,
    output reg [127:0] extract_out,
    output extract_valid
);
    assign extract_valid = (iot_data[127:112] > `EXTRACT_LOW && iot_data[127:112] < `EXTRACT_HIGH) ? 1'b1 : 1'b0;

    always @(*) begin
            if (extract_valid) begin
                extract_out = iot_data[127:0];
            end 
            else begin
                extract_out = 128'd0;
            end
        end
endmodule

module exclude_finder(
    input clk,
    input rst,
    input [3:0] cur_state,
    input [127:0] iot_data,
    output reg [127:0] exclude_out,
    output exclude_valid
);
    assign exclude_valid = (iot_data[127:112] < `EXCLUDE_LOW || iot_data[127:112] > `EXCLUDE_HIGH) ? 1'b1 : 1'b0;

    always @(*) begin
        if (exclude_valid) begin
            exclude_out = iot_data[127:0];
        end 
        else begin
            exclude_out = 128'd0;
        end
    end
endmodule

module peakmax_finder(
    input clk,
    input rst,
    input [3:0] cur_state,
    input [127:0] max_value,
    input [2:0] data_count,
    output reg [127:0] peak_max,
    output peak_max_valid
);
    reg change_peak_max_flag;
    wire change_peak_max_value;
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            peak_max <= 128'd0;
        end else if (cur_state == `PEAKMAX && change_peak_max_value) begin
            peak_max <= max_value;
        end
    end
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            change_peak_max_flag  <= 1'b0;
        end else if (change_peak_max_value) begin
            change_peak_max_flag <= 1'b1;
        end
        else if (cur_state == `INITIALIZATION) begin
            change_peak_max_flag <= 1'b0;
        end
    end
    assign change_peak_max_value = (max_value > peak_max) ? 1'b1 : 1'b0;
    assign peak_max_valid = (data_count == 3'd0 && cur_state == `PEAKMAX && change_peak_max_flag) ? 1'b1 : 1'b0;
endmodule

module peakmin_finder(
    input clk,
    input rst,
    input [3:0] cur_state,
    input [127:0] iot_data,
    input [127:0] min_value,
    input [2:0] data_count,
    output reg [127:0] peak_min,
    output peak_min_valid,
    output change_peak_min_value
);
    reg change_peak_min_flag;
    reg first_find_min_flag;
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            peak_min <= 128'd0;
        end else if ((cur_state == `CHANGE_PEAK_MIN) && ~first_find_min_flag) begin
            peak_min <= min_value;
        end else if (cur_state == `CHANGE_PEAK_MIN && change_peak_min_value) begin
            peak_min <= min_value;
        end
    end
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            change_peak_min_flag  <= 1'b0;
        end else if (change_peak_min_value) begin
            change_peak_min_flag <= 1'b1;
        end
        else if (cur_state == `INITIALIZATION) begin
            change_peak_min_flag <= 1'b0;
        end
    end
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            first_find_min_flag <= 1'b0;
        end else if (cur_state == `CHANGE_PEAK_MIN) begin
            first_find_min_flag <= 1'b1;
        end
    end
    assign change_peak_min_value = ((~first_find_min_flag) || (iot_data < peak_min)) ? 1'b1 : 1'b0;

    assign peak_min_valid = (data_count == 3'd0 && (cur_state == `PEAKMIN|| cur_state == `CHANGE_PEAK_MIN) && change_peak_min_flag) ? 1'b1 : 1'b0;
endmodule