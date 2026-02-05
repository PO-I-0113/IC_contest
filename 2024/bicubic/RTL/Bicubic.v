`define FIXED_POINT_BITS 20// can be adjusted, take precision into account
`define CALCULATE_WIDTH (SW+2)
`define CALCULATE_HEIGHT (SH+2)
`define CUBIC_ADDRESS_HEIGHT_OFFSET 100 //(100-3) //100-
`define CUBIC_ADDRESS_WIDTH_OFFSET 1
`define IDLE 5'd0
`define PRE_SET_ADDRESS 5'd1
`define LOAD_DATA 5'd2
`define COEFFICIENT 5'd3
`define BICUBIC 5'd4
`define BICUBIC_VERTICAL 5'd5
`define WRITE_RESULT 5'd6
`define FINISH 5'd7
`define HORIZONTAL_NODE_LOCATION 5'd8
`define BICUBIC_REG 5'd9
`define WRITE_RESULT_REG 5'd10
`define WRITE_RESULT_LAST 5'd11
`define WRITE_RESULT_REG_LAST 5'd12
`define HORIZONTAL_NODE_LOCATION_LAST 5'd13
`define HORIZONTAL_NODE_LOCATION_REG_LAST 5'd14
`define LOAD_DATA_VERTICAL 5'd15
`define CHANGE_COLUMN 5'd16
`define PRE_SET_ADDRESS_VERTICAL 5'd17
`define WAIT_CYCLE 5'd18
`define BICUBIC_LAST 5'd19
module Bicubic (
input CLK,
input RST,
input [6:0] V0,
input [6:0] H0,
input [4:0] SW,
input [4:0] SH,
input [5:0] TW,
input [5:0] TH,
output DONE
);



wire [7:0] pixel_in;
wire [7:0] pixel_sram;
wire ROM_EN;
wire SRAM_EN;
wire SRAM_READ_EN;
wire SECOND_NODE_FLAG;
wire [4:0] cur_state;
wire [4:0] row_count;
wire [4:0] column_count;
wire [13:0] start_address;
wire [13:0] address;
wire [20:0] horizontal_node;
wire [20:0] vertical_node;
wire change_row;
wire change_column;
wire horizontal_node_flag;
wire vertical_node_flag;
wire VERTICAL_FLAG;
wire signed [10:0] coefficient_a;
wire signed [10:0] coefficient_b;
wire signed [10:0] coefficient_c;
wire signed [10:0] coefficient_d;
wire [7:0] pixel;
wire [5:0] cubic_data_count;
wire [8:0] pixel_cube0;
wire [8:0] pixel_cube1;
wire [8:0] pixel_cube2;
wire [8:0] pixel_cube3;
wire [13:0] S_address;
wire [13:0] ans_address;
wire [13:0] SRAM_address;
ImgROM      u_ImgROM      (
    .Q   (pixel_in), 
    .CLK (CLK), 
    .CEN (ROM_EN),  // active low
    .A   (address)
);

ResultSRAM  u_ResultSRAM  (
    .Q    (pixel_sram), 
    .CLK  (CLK), 
    .CEN  (SRAM_EN), //active low
    .WEN  (SRAM_READ_EN),//active high
    .A    (S_address), 
    .D    (pixel)
);
SRAM_address_control u_SRAM_address_control (
    .CLK(CLK),
    .RST(RST),
    .VERTICAL_FLAG(VERTICAL_FLAG),
    .address(address),
    .cur_state(cur_state),
    .ans_address(ans_address),
    .SRAM_address(SRAM_address),
    .S_address(S_address)
);
SRAM_ans_address_generation u_SRAM_ans_address_generation (
    .CLK(CLK),
    .RST(RST),
    .cur_state(cur_state),
    .TH(TH),
    .TW(TW),
    .ans_address(ans_address),
    .VERTICAL_FLAG(VERTICAL_FLAG),
    .column_count(column_count)
);
SRAM_address_generation u_SRAM_address_generation (
    .CLK(CLK),
    .RST(RST),
    .VERTICAL_FLAG(VERTICAL_FLAG),
    .TH(TH),
    .row_count(row_count),
    .SRAM_READ_EN(SRAM_READ_EN),
    .SRAM_address(SRAM_address),
    .cur_state(cur_state)
);
cubic_data_counter u_cubic_data_counter (
    .CLK    (CLK), 
    .RST    (RST), 
    .cur_state(cur_state), 
    .SW     (SW),
    .SH     (SH),
    .VERTICAL_FLAG(VERTICAL_FLAG),
    .cubic_data_count  (cubic_data_count),
    .change_row(change_row),
    .change_column(change_column)
);

row_counter u_row_counter (
    .CLK    (CLK), 
    .RST    (RST), 
    .cur_state(cur_state), 
    .row_count(row_count),
    .change_row(change_row)
);
column_counter u_column_counter (
    .CLK    (CLK), 
    .RST    (RST), 
    .cur_state(cur_state), 
    .column_count(column_count),
    .change_column(change_column)
);

FSM u_FSM (
    .CLK    (CLK), 
    .RST    (RST), 
    .TW     (TW),
    .TH     (TH),
    .change_row(change_row),
    .change_column(change_column),
    .row_count(row_count),
    .column_count(column_count),
    .SH     (SH),
    .horizontal_node_flag(horizontal_node_flag),
    .vertical_node_flag(vertical_node_flag),
    .SECOND_NODE_FLAG(SECOND_NODE_FLAG),
    .WRITE_SRAM_FLAG(WRITE_SRAM_FLAG),
    .cubic_data_count  (cubic_data_count), 
    .cur_state(cur_state), 
    .DONE   (DONE), 
    .ROM_EN (ROM_EN), 
    .SRAM_EN(SRAM_EN),
    .SRAM_READ_EN(SRAM_READ_EN),
    .VERTICAL_FLAG(VERTICAL_FLAG)
);
squre_data_generation u_squre_data_generation (
    .CLK(CLK), 
    .RST(RST), 
    .cubic_data_count(cubic_data_count), 
    .column_count(column_count),
    .pixel_in(pixel_in), 
    .pixel_sram(pixel_sram),
    .cur_state(cur_state),
    .pixel_cube0(pixel_cube0),
    .pixel_cube1(pixel_cube1),
    .pixel_cube2(pixel_cube2),
    .pixel_cube3(pixel_cube3)
);
ROM_address_generation u_ROM_address_generation (
    .CLK         (CLK), 
    .RST         (RST), 
    .V0          (V0), 
    .H0          (H0), 
    .SW          (SW), 
    .SH          (SH),
    .VERTICAL_FLAG(VERTICAL_FLAG),
    .cur_state   (cur_state),
    .address     (address),
    .cubic_data_count(cubic_data_count),
    .change_row(change_row),
    .change_column(change_column),
    .column_count(column_count),
    .TW(TW)
);

node_calculation u_node_calculation (
    .CLK         (CLK), 
    .RST         (RST), 
    .SW          (SW), 
    .SH          (SH), 
    .TW          (TW), 
    .TH          (TH), 
    .horizontal_node (horizontal_node), 
    .vertical_node(vertical_node),
    .cur_state(cur_state),
    .horizontal_node_flag(horizontal_node_flag),
    .vertical_node_flag(vertical_node_flag),
    .SECOND_NODE_FLAG(SECOND_NODE_FLAG),
    .VERTICAL_FLAG(VERTICAL_FLAG)
);

Bicubic_coefficient u_Bicubic_coefficient (
    .CLK(CLK), 
    .RST(RST), 
    .cur_state(cur_state),
    .cubic_data_count(cubic_data_count),
    .pixel_cube0(pixel_cube0),
    .pixel_cube1(pixel_cube1),
    .pixel_cube2(pixel_cube2),
    .pixel_cube3(pixel_cube3),
    .coefficient_a(coefficient_a), 
    .coefficient_b(coefficient_b), 
    .coefficient_c(coefficient_c), 
    .coefficient_d(coefficient_d)
);
BICUBIC u_BICUBIC (
    .CLK(CLK), 
    .RST(RST), 
    .cur_state(cur_state),
    .VERTICAL_FLAG(VERTICAL_FLAG),
    .horizontal_node(horizontal_node),
    .vertical_node(vertical_node),
    .coefficient_a(coefficient_a),
    .coefficient_b(coefficient_b),
    .coefficient_c(coefficient_c),
    .coefficient_d(coefficient_d),
    .pixel(pixel)
);

endmodule

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
module SRAM_address_control (CLK, RST, cur_state, ans_address, SRAM_address, S_address, address, VERTICAL_FLAG);
input CLK;
input RST;
input [4:0] cur_state;
input [13:0] ans_address;
input VERTICAL_FLAG;
input [13:0] SRAM_address;
input [13:0] address;
output reg [13:0] S_address;
always @(*) begin
    case (cur_state)
        `WRITE_RESULT_LAST: begin
            if (VERTICAL_FLAG) begin
                S_address = ans_address;
            end
            else begin
                S_address = SRAM_address;
            end
        end
        `WRITE_RESULT_REG: begin
            S_address = ans_address;
        end
        `WRITE_RESULT_REG_LAST: begin
            S_address = ans_address;
        end
        `WAIT_CYCLE: begin
            S_address = address;
        end
        `PRE_SET_ADDRESS_VERTICAL: begin
            S_address = address;
        end
        `LOAD_DATA_VERTICAL: begin
            S_address = address;
        end
        `PRE_SET_ADDRESS: begin
            S_address = SRAM_address;
        end
        default: begin
            S_address = SRAM_address;
        end
    endcase
end
endmodule
module SRAM_ans_address_generation (CLK, RST, cur_state, TH, TW, ans_address, VERTICAL_FLAG, column_count);
input CLK;
input RST;
input [4:0] cur_state;
input [5:0] TH;
input [5:0] TW;
input VERTICAL_FLAG;
input [4:0] column_count;
output reg [13:0] ans_address;
always @(posedge CLK or posedge RST) begin
    if (RST) begin
        ans_address <= 14'd0;
    end
    else if (cur_state == `PRE_SET_ADDRESS_VERTICAL) begin
        ans_address <= column_count;
    end
    else if (cur_state == `WRITE_RESULT_REG || cur_state == `WRITE_RESULT_REG_LAST|| (cur_state == `WRITE_RESULT_LAST && VERTICAL_FLAG)) begin
        ans_address <= ans_address + TW;
    end
end
endmodule
module SRAM_address_generation (CLK, RST, VERTICAL_FLAG, row_count, TH, SRAM_READ_EN, SRAM_address, cur_state);
input CLK;
input RST;
input VERTICAL_FLAG;
input [4:0] row_count;
input [5:0] TH;
input SRAM_READ_EN;
input [4:0] cur_state;
output reg [13:0] SRAM_address;

always @(posedge CLK or posedge RST) begin
    if (RST) begin
        SRAM_address <= 14'd0;
    end
    else if (cur_state == `PRE_SET_ADDRESS && row_count == 0) begin
        SRAM_address <= 14'd10000;
    end
    else if (cur_state == `WRITE_RESULT || cur_state == `WRITE_RESULT_LAST) begin
        SRAM_address <= SRAM_address + 14'd1;
    end
    else if (cur_state == `CHANGE_COLUMN) begin
        SRAM_address <= 14'd10000;
    end
end
endmodule

module ROM_address_generation (CLK, RST, V0, H0, SW, SH, TW, VERTICAL_FLAG, address, cur_state, cubic_data_count, change_row, change_column, column_count);
input CLK;
input RST;
input [6:0] V0;
input [6:0] H0;
input [4:0] SW;
input [4:0] SH;
input [5:0] TW;
input [4:0] column_count;
input VERTICAL_FLAG;
input [4:0] cur_state;
input [5:0] cubic_data_count;
input change_column;
input change_row;
output reg [13:0] address;
wire [13:0] start;
wire pre_set_address;

always @(posedge CLK or posedge RST) begin
    if (RST) begin
        address <= 14'd0;
    end
    else if (pre_set_address) begin
        address <= start;
    end
    else if (VERTICAL_FLAG && cur_state == `CHANGE_COLUMN) begin
        address <= 14'd10000;
    end
    else if (change_column) begin
        address <= 14'd10000 + column_count +1 ;
    end
    else if (VERTICAL_FLAG && (cur_state == `PRE_SET_ADDRESS_VERTICAL || cur_state == `LOAD_DATA_VERTICAL) && (cubic_data_count==6'd3)) begin
        address <= address;
    end
    else if (VERTICAL_FLAG && (cur_state == `PRE_SET_ADDRESS_VERTICAL || cur_state == `LOAD_DATA_VERTICAL)) begin
        address <= address + TW;
    end
    else if ((~VERTICAL_FLAG) && change_row) begin//-(SW+1) = -SW-1 = (~SW)+1-1
        address <= address + `CUBIC_ADDRESS_HEIGHT_OFFSET + ~(SW+1)-1;
    end
    else if ((cur_state == `LOAD_DATA && ~VERTICAL_FLAG) || cur_state == `PRE_SET_ADDRESS) begin
        address <= address + `CUBIC_ADDRESS_WIDTH_OFFSET;
    end
end

assign pre_set_address = (address == 0) ? 1 : 0;
assign start = (V0-1)*100 + (H0-1);
endmodule

module cubic_data_counter (CLK, RST, SW, SH, cur_state, VERTICAL_FLAG, cubic_data_count, change_row, change_column);
input CLK;
input RST;
input [4:0] SW;
input [4:0] SH;
input [4:0] cur_state;
input VERTICAL_FLAG;
output reg [5:0] cubic_data_count;
output change_row;
output change_column;
always @(posedge CLK or posedge RST) begin
    if (RST) begin
        cubic_data_count <= 6'd0;
    end
    else  if (cur_state == `LOAD_DATA || cur_state == `LOAD_DATA_VERTICAL) begin
        cubic_data_count <= cubic_data_count + 1;
    end
    else if ((~VERTICAL_FLAG) && change_row) begin
        cubic_data_count <= 6'd0;
    end
    else if (change_column) begin
        cubic_data_count <= 6'd0;
    end
end

assign change_row = (cubic_data_count == (`CALCULATE_WIDTH) && (cur_state == `BICUBIC || cur_state == `BICUBIC_REG)) ? 1 : 0;
assign change_column = (VERTICAL_FLAG && (cubic_data_count == (`CALCULATE_HEIGHT) && (cur_state == `BICUBIC || cur_state == `BICUBIC_REG))) ? 1 : 0;
endmodule

module row_counter (CLK, RST, cur_state, row_count, change_row);
input CLK;
input RST;
input [4:0] cur_state;
input change_row;
output reg [4:0] row_count;

always @(posedge CLK or posedge RST) begin
    if (RST) begin
        row_count <= 6'd0;
    end
    else if (change_row) begin
        row_count <= row_count + 1;
    end
end
endmodule

module column_counter (CLK, RST, cur_state, column_count, change_column);
input CLK;
input RST;
input [4:0] cur_state;
input change_column;
output reg [4:0] column_count;

always @(posedge CLK or posedge RST) begin
    if (RST) begin
        column_count <= 6'd0;
    end
    else if (change_column) begin
        column_count <= column_count + 1;
    end
end
endmodule
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
module FSM (CLK, RST, TW, TH, cubic_data_count, column_count, cur_state, DONE, ROM_EN, SRAM_EN, SRAM_READ_EN, horizontal_node_flag, vertical_node_flag, change_row, change_column, SECOND_NODE_FLAG, WRITE_SRAM_FLAG, row_count, SH, VERTICAL_FLAG);
input CLK;
input RST;
input [5:0] cubic_data_count;
input [4:0] column_count;
input [4:0] SH;
input change_row;
input change_column;
input horizontal_node_flag;
input vertical_node_flag;
input [4:0] row_count;
input [5:0] TW;
input [5:0] TH;
reg [4:0] nxt_state;
output reg [4:0] cur_state;
output reg DONE;
output ROM_EN;
output SRAM_EN;
output SRAM_READ_EN;
output reg SECOND_NODE_FLAG;
output reg WRITE_SRAM_FLAG;
output reg VERTICAL_FLAG;
reg CHANGE_COLUMN_FLAG;
wire LINE_BUF_SET;
assign ROM_EN = (cur_state == `LOAD_DATA || cur_state == `PRE_SET_ADDRESS || cur_state == `LOAD_DATA_VERTICAL || cur_state == `PRE_SET_ADDRESS_VERTICAL) ? 0 : 1; //active low//maybe scan chain error
assign SRAM_EN = (cur_state == `WRITE_RESULT || cur_state == `WRITE_RESULT_LAST || cur_state == `PRE_SET_ADDRESS_VERTICAL || cur_state == `WRITE_RESULT_REG || cur_state == `LOAD_DATA_VERTICAL || cur_state == `WAIT_CYCLE ||cur_state == `WRITE_RESULT_REG_LAST) ? 0 : 1; //active low
assign SRAM_READ_EN = ((cur_state == `LOAD_DATA_VERTICAL||cur_state == `PRE_SET_ADDRESS_VERTICAL || cur_state == `WAIT_CYCLE)) ? 1 : 0; //active low
assign LINE_BUF_SET = (cubic_data_count[5:0] >= 6'd3) ? 1 : 0;//can use a new state to finish this


always @(posedge CLK or posedge RST) begin
    if (RST) begin
        CHANGE_COLUMN_FLAG <= 0;
    end
    else if (cur_state == `CHANGE_COLUMN) begin
        CHANGE_COLUMN_FLAG <= 1;
    end
end
always @(posedge CLK or posedge RST) begin
    if (RST) begin
        VERTICAL_FLAG <= 0;
    end
    else if ((row_count > SH+1) && (cur_state == `BICUBIC || cur_state == `BICUBIC_REG || cur_state == `BICUBIC_LAST)) begin
        VERTICAL_FLAG <= 1;
    end
end

always @(posedge CLK or posedge RST) begin
    if (RST) begin
        WRITE_SRAM_FLAG <= 0;
    end
    else if (cur_state == `CHANGE_COLUMN) begin
        WRITE_SRAM_FLAG <= 0;
    end
    else begin
        WRITE_SRAM_FLAG <= 1;
    end
end

always @(posedge CLK or posedge RST) begin
    if (RST) begin
        SECOND_NODE_FLAG <= 0;
    end
    else if (~VERTICAL_FLAG && (change_row || change_column)) begin
        SECOND_NODE_FLAG <= 0;
    end
    else if (VERTICAL_FLAG && change_column) begin
        SECOND_NODE_FLAG <= 0;
    end
    else if (cur_state == `HORIZONTAL_NODE_LOCATION)begin
        SECOND_NODE_FLAG <= 1;
    end
end

always @(posedge CLK or posedge RST) begin
    if (RST) begin
        DONE <= 0;
    end
    else begin
        DONE <= (cur_state == `FINISH) ? 1 : 0;
    end
end

always @(posedge CLK or posedge RST) begin
    if (RST) begin
        cur_state <= `IDLE;
    end
    else begin
        cur_state <= nxt_state;
    end
end


always @(*) begin
    case (cur_state)
        `IDLE: begin
            nxt_state = `PRE_SET_ADDRESS;
        end 
        `CHANGE_COLUMN: begin
            nxt_state = `PRE_SET_ADDRESS_VERTICAL;
        end
        `WAIT_CYCLE: begin
            nxt_state = `LOAD_DATA_VERTICAL;
        end
        `PRE_SET_ADDRESS_VERTICAL: begin
            nxt_state = `LOAD_DATA_VERTICAL;
        end
        `PRE_SET_ADDRESS: begin
                nxt_state = `LOAD_DATA;
            end
        `LOAD_DATA: begin
            if (LINE_BUF_SET) begin
                nxt_state = `COEFFICIENT;
            end
            else begin
                nxt_state = `LOAD_DATA;
            end
        end
        `LOAD_DATA_VERTICAL: begin
            if (LINE_BUF_SET) begin
                nxt_state = `COEFFICIENT;
            end
            else begin
                nxt_state = `LOAD_DATA_VERTICAL;
            end
        end
        `COEFFICIENT:begin
            nxt_state = `HORIZONTAL_NODE_LOCATION;
        end
        `HORIZONTAL_NODE_LOCATION:begin
            //if (LAST_NODE_FLAG) begin
            //    nxt_state = `BICUBIC_LAST;
            //end
            if(WRITE_SRAM_FLAG) begin
                nxt_state = `BICUBIC;
            end
            else begin
                nxt_state = `BICUBIC_REG;
            end
        end
        `HORIZONTAL_NODE_LOCATION_LAST:begin
            nxt_state = `BICUBIC_LAST;
        end
        `HORIZONTAL_NODE_LOCATION_REG_LAST:begin
            nxt_state = `BICUBIC_REG;
        end

        `BICUBIC_LAST:begin
            if (VERTICAL_FLAG) begin
                nxt_state = `WRITE_RESULT_REG_LAST;
            end
            else begin
                nxt_state = `WRITE_RESULT;
            end
        end
        `BICUBIC:begin
            if (change_row && ~VERTICAL_FLAG) begin
                nxt_state = `WRITE_RESULT_LAST;
            end
            else if (change_column) begin
                nxt_state = `WRITE_RESULT_LAST;
            end
            else if (VERTICAL_FLAG) begin
                nxt_state = `WRITE_RESULT_REG;
            end
            else begin
                nxt_state = `WRITE_RESULT;
            end
        end
        `BICUBIC_REG:begin
            if (change_row || change_column) begin
                nxt_state = `WRITE_RESULT_REG_LAST;
            end
            else begin
                nxt_state = `WRITE_RESULT_REG;
            end
        end

        `BICUBIC_VERTICAL:begin
            nxt_state = `FINISH;  
        end

        `WRITE_RESULT:
            if (VERTICAL_FLAG && (LINE_BUF_SET==0) && (CHANGE_COLUMN_FLAG==0)) begin
                nxt_state = `CHANGE_COLUMN;
            end
            else if (VERTICAL_FLAG && (LINE_BUF_SET==0)) begin
                nxt_state = `PRE_SET_ADDRESS_VERTICAL;
            end
            else if (LINE_BUF_SET==0) begin
                nxt_state = `PRE_SET_ADDRESS;
            end
            else if (~horizontal_node_flag) begin//沒有換點就不用LOAD DATA,直接算下一個點
                nxt_state = `HORIZONTAL_NODE_LOCATION;
            end
            else begin
                nxt_state = `LOAD_DATA;
            end
        `WRITE_RESULT_REG: begin
            if (VERTICAL_FLAG && (LINE_BUF_SET==0) && (CHANGE_COLUMN_FLAG==0)) begin
                nxt_state = `CHANGE_COLUMN;
            end
            else if (VERTICAL_FLAG && (LINE_BUF_SET==0)) begin
                nxt_state = `PRE_SET_ADDRESS_VERTICAL;
            end
            else if (LINE_BUF_SET==0) begin
                nxt_state = `PRE_SET_ADDRESS;
            end
            else if (~horizontal_node_flag) begin//沒有換點就不用LOAD DATA,直接算下一個點
                nxt_state = `HORIZONTAL_NODE_LOCATION;
            end
            else if (~vertical_node_flag) begin
                nxt_state = `HORIZONTAL_NODE_LOCATION;
            end
            else begin
                nxt_state = `WAIT_CYCLE;
            end
        end
        `WRITE_RESULT_LAST:begin
            nxt_state = `HORIZONTAL_NODE_LOCATION_LAST;
        end
        `WRITE_RESULT_REG_LAST:begin
             if(column_count == TW) begin//need check
                nxt_state = `FINISH;
            end
            else if (VERTICAL_FLAG && (LINE_BUF_SET==0) && (CHANGE_COLUMN_FLAG==0)) begin
                nxt_state = `CHANGE_COLUMN;
            end
            else if (VERTICAL_FLAG && (LINE_BUF_SET==0)) begin
                nxt_state = `PRE_SET_ADDRESS_VERTICAL;
            end
            else if (LINE_BUF_SET==0) begin
                nxt_state = `PRE_SET_ADDRESS;
            end
            else if (~horizontal_node_flag) begin//沒有換點就不用LOAD DATA,直接算下一個點
                nxt_state = `HORIZONTAL_NODE_LOCATION;
            end
            else if (~vertical_node_flag) begin
                nxt_state = `HORIZONTAL_NODE_LOCATION;
            end
            //else if () begin
            //    nxt_state = `WAIT_CYCLE;
            //end
            else begin
                nxt_state = `WAIT_CYCLE;
            end
        end
        `FINISH:
            nxt_state = `LOAD_DATA;
        default:
            nxt_state = `IDLE;
    endcase
end
endmodule
///READ MEMORY/////////////////////////////////////////////////////////////////////////////////////////////////////////////////


module squre_data_generation (CLK, RST, cubic_data_count, pixel_in, pixel_sram, cur_state, column_count, pixel_cube0, pixel_cube1, pixel_cube2, pixel_cube3);
input CLK;
input RST;
input [5:0] cubic_data_count;
input [7:0] pixel_in;
input [7:0] pixel_sram;
input [4:0] cur_state;
input [4:0] column_count;
output [8:0] pixel_cube0;
output [8:0] pixel_cube1;
output [8:0] pixel_cube2;
output [8:0] pixel_cube3;
//reg [7:0] debug_pixel_in [0:3];
reg [8:0] pixel_reg [0:3];
always @(posedge CLK or posedge RST) begin
    if (RST) begin
        pixel_reg[0] <= 9'b0;
        pixel_reg[1] <= 9'b0;
        pixel_reg[2] <= 9'b0;
        pixel_reg[3] <= 9'b0;
        //debug_pixel_in[0] <= 8'b0;
        //debug_pixel_in[1] <= 8'b0;
        //debug_pixel_in[2] <= 8'b0;
        //debug_pixel_in[3] <= 8'b0;
    end
    else if ((cur_state == `LOAD_DATA /*|| cur_state == `LOAD_DATA_VERTICAL*/) && (column_count==0)) begin
        //debug_pixel_in[cubic_data_count[1:0]] <= pixel_in;
        pixel_reg[cubic_data_count[1:0]] <= {pixel_in, 1'b0};//fix_point
    end
    else if (cur_state == `LOAD_DATA_VERTICAL) begin
        //debug_pixel_in[cubic_data_count[1:0]] <= pixel_sram;
        pixel_reg[cubic_data_count[1:0]] <= {pixel_sram, 1'b0};//fix_point
    end
end

assign pixel_cube0 = pixel_reg[0];
assign pixel_cube1 = pixel_reg[1];
assign pixel_cube2 = pixel_reg[2];
assign pixel_cube3 = pixel_reg[3];
endmodule


module node_calculation (CLK, RST, SW, SH, TW, TH, horizontal_node, vertical_node, cur_state, horizontal_node_flag, vertical_node_flag, SECOND_NODE_FLAG, VERTICAL_FLAG);
input CLK;
input RST;
input [5:0] TW;
input [5:0] TH;
input [4:0] SW;
input [4:0] SH;
input [4:0] cur_state;
input SECOND_NODE_FLAG;
input VERTICAL_FLAG;
wire [5:0] TW_space_count;
wire [5:0] TH_space_count;
wire [4:0] SW_space_count;
wire [4:0] SH_space_count;
wire [20:0] horizontal_node_com;
wire [20:0] vertical_node_com;
wire [24:0] space_width;
wire [24:0] space_height;
output reg [20:0] horizontal_node; //Q1.20 fixed point
output reg [20:0] vertical_node;//Q1.20 fixed point
output horizontal_node_flag;
output vertical_node_flag;

always @(posedge CLK or posedge RST) begin
    if (RST) begin
        horizontal_node <= 21'b0;
    end
    else if (VERTICAL_FLAG) begin
        horizontal_node <= 21'b100000000000000000000;
    end
    else if (cur_state == `PRE_SET_ADDRESS || cur_state == `PRE_SET_ADDRESS_VERTICAL) begin // reset precision
        horizontal_node <= 21'b0;
    end
    else if ((cur_state == `HORIZONTAL_NODE_LOCATION && SECOND_NODE_FLAG == 1) || (cur_state == `HORIZONTAL_NODE_LOCATION_LAST || cur_state == `HORIZONTAL_NODE_LOCATION_REG_LAST)) begin
        horizontal_node  <= {1'b0, horizontal_node_com[19:0]};
    end

end

always @(posedge CLK or posedge RST) begin
    if (RST) begin
        vertical_node <= 21'b0;
    end
    else 
    if (~VERTICAL_FLAG) begin
        vertical_node <= 21'b100000000000000000000;
    end
    else if (cur_state == `PRE_SET_ADDRESS || cur_state == `PRE_SET_ADDRESS_VERTICAL) begin // reset precision
        vertical_node <= 21'b0;
    end
    else if ((cur_state == `HORIZONTAL_NODE_LOCATION && SECOND_NODE_FLAG == 1) || (cur_state == `HORIZONTAL_NODE_LOCATION_LAST || cur_state == `HORIZONTAL_NODE_LOCATION_REG_LAST)) begin
        vertical_node <= {1'b0, vertical_node_com[19:0]};
    end
end

    assign TW_space_count = TW -1 ;
    assign TH_space_count = TH -1 ;
    assign SW_space_count = SW -1 ;
    assign SH_space_count = SH -1 ;

    assign space_width  = (SW_space_count << `FIXED_POINT_BITS) / TW_space_count;
    assign space_height = (SH_space_count << `FIXED_POINT_BITS) / TH_space_count;
    
    assign horizontal_node_com = horizontal_node + space_width ;
    assign vertical_node_com = vertical_node+ space_height;
    assign horizontal_node_flag = (horizontal_node_com[20]);
    assign vertical_node_flag = (vertical_node_com[20]);
endmodule

module Bicubic_coefficient (CLK, RST, cur_state, pixel_cube0, pixel_cube1, pixel_cube2, pixel_cube3, cubic_data_count, coefficient_a, coefficient_b, coefficient_c, coefficient_d);
input CLK;
input RST;
input [4:0] cur_state;
//input [7:0] pixel_reg;
input [8:0] pixel_cube0;
input [8:0] pixel_cube1;
input [8:0] pixel_cube2;
input [8:0] pixel_cube3;
input [5:0] cubic_data_count;
reg signed [8:0] pixel_reg [0:3];

wire signed [10:0] coefficient_a_com;
wire signed [10:0] coefficient_b_com;
wire signed [10:0] coefficient_c_com;
wire signed [10:0] coefficient_d_com;
wire [1:0] index_0;
wire [1:0] index_1;
wire [1:0] index_2;
wire [1:0] index_3;
output reg signed [10:0] coefficient_a;//need Q 10.1 
output reg signed [10:0] coefficient_b;//need Q 10.1 
output reg signed [10:0] coefficient_c;//need Q 10.1 
output reg signed [10:0] coefficient_d;//need Q 10.1 
always @(*) begin
    pixel_reg[0] = pixel_cube0;
    pixel_reg[1] = pixel_cube1;
    pixel_reg[2] = pixel_cube2;
    pixel_reg[3] = pixel_cube3;
end
always @(posedge CLK or posedge RST) begin
    if (RST) begin
        coefficient_a <= 11'b0;
        coefficient_b <= 11'b0;
        coefficient_c <= 11'b0;
        coefficient_d <= 11'b0;
    end
    else if (cur_state == `COEFFICIENT) begin
        begin
            coefficient_a <= coefficient_a_com;
            coefficient_b <= coefficient_b_com;
            coefficient_c <= coefficient_c_com;
            coefficient_d <= coefficient_d_com;
        end
    end
end
//hard debug//assign another name for the calculation
assign index_0 = cubic_data_count[1:0];
assign index_1 = cubic_data_count[1:0]+1;
assign index_2 = cubic_data_count[1:0]+2;
assign index_3 = cubic_data_count[1:0]+3;


assign coefficient_a_com = (3*({2'b0,pixel_reg[index_1]}+~({2'b0,pixel_reg[index_2]})+1)+({2'b0,pixel_reg[index_3]}+~({2'b0,pixel_reg[index_0]})+1))>>>1;
assign coefficient_b_com = {2'b0,pixel_reg[index_0]}+ ({2'b0,pixel_reg[index_2]}<<<1) +((~{2'b0,pixel_reg[index_3]}+1)>>>1)+ (5*(~{2'b0,pixel_reg[index_1]}+1)>>>1);
assign coefficient_c_com = ({2'b0,pixel_reg[index_2]}+~({2'b0,pixel_reg[index_0]})+1)>>>1;
assign coefficient_d_com = {2'b0,pixel_reg[index_1]};

endmodule

module BICUBIC (CLK, RST, cur_state, VERTICAL_FLAG, horizontal_node, vertical_node, coefficient_a, coefficient_b, coefficient_c, coefficient_d, pixel);
input CLK;
input RST;
input [4:0] cur_state;
input [20:0] horizontal_node;
input [20:0] vertical_node;
input VERTICAL_FLAG;
input signed [10:0] coefficient_a;
input signed [10:0] coefficient_b;
input signed [10:0] coefficient_c;
input signed [10:0] coefficient_d;
reg [20:0] node_bicubic;
wire [41:0] node_bicubic_square;
wire [62:0] node_bicubic_cubic;
wire signed [33:0] pixel_com;
//wire signed [34:0] horizontal_pixel_com_temp;
wire [41:0] horizontal_node_square;  // Q2.40 fixed point
reg  signed [10:0] coefficient_a_reg;
reg  signed [10:0] coefficient_b_reg;
reg  signed [10:0] coefficient_c_reg;
reg  signed [10:0] coefficient_d_reg;
output reg  [7:0] pixel;


always @(*) begin
    coefficient_a_reg = coefficient_a;
    coefficient_b_reg = coefficient_b;
    coefficient_c_reg = coefficient_c;
    coefficient_d_reg = coefficient_d;
end


always @(*) begin
    case (VERTICAL_FLAG)
        1'b0: node_bicubic = horizontal_node;
        1'b1: node_bicubic = vertical_node;
        default: node_bicubic = horizontal_node; // default to horizontal
    endcase
end

always @(posedge CLK or posedge RST) begin
    if (RST) begin
        pixel <= 8'b0;
    end
    else if (cur_state == `BICUBIC || cur_state == `BICUBIC_REG || cur_state == `BICUBIC_LAST) begin
        if (pixel_com[33]) begin
            pixel <= 8'd0;
        end
        else if (pixel_com[20] == 1'b1) begin
            pixel <= pixel_com[28:21]+1'b1;//rounding
        end
        else if (pixel_com[20] == 1'b0) begin
            pixel <= pixel_com[28:21];
        end
    end

end
//Q1.20 SPACE WIDTH
assign node_bicubic_square = node_bicubic * node_bicubic;//Q2.40
assign node_bicubic_cubic = node_bicubic_square * node_bicubic;//Q3.60

wire  signed[73:0] debug1 = $signed({node_bicubic_cubic}) * (coefficient_a_reg);//Q13.61
wire  signed[52:0] debug2 = $signed({node_bicubic_square}) * (coefficient_b_reg);//Q12.41
wire  signed[31:0] debug3 = $signed({node_bicubic})* (coefficient_c_reg);//Q11.21

assign pixel_com = debug1[73:40] + {debug2[52],debug2[52:20]} + {{2{debug3[31]}},debug3[31:0]} + {{3{coefficient_d_reg[10]}},coefficient_d_reg[10:0],3'b0,17'b0};

endmodule

