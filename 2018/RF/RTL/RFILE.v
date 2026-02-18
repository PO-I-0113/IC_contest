//`include "/cad/synopsys/synthesis/2019.12/dw/sim_ver/DW_div.v"
//`include "/cad/synopsys/synthesis/2019.12/dw/sim_ver/DW_div_pipe.v"
`define ALPHA 59
`define FIX_FLOAT 12
`define FIX_INT 8
`define VALUE_INT 4
`define VALUE_FLOAT 12
`define NUM_STAGES 5
module RFILE(clk, rst, A_x, A_y, B_x, B_y, C_x, C_y, rssiA, rssiB, rssiC, valueA, valueB, valueC, expA, expB, expC, busy, out_valid, xt, yt);
    input           clk;
    input           rst;
    input  [`FIX_INT-1:0]    A_x;//3 type input define in tb
    input  [`FIX_INT-1:0]    A_y;//3 type input define in tb
    input  [`FIX_INT-1:0]    B_x;//3 type input define in tb
    input  [`FIX_INT-1:0]    B_y;//3 type input define in tb
    input  [`FIX_INT-1:0]    C_x;//3 type input define in tb
    input  [`FIX_INT-1:0]    C_y;//3 type input define in tb
    input  [`FIX_INT+`FIX_FLOAT-1:0]   rssiA;//3 type input define in pattern 2's
    input  [`FIX_INT+`FIX_FLOAT-1:0]   rssiB;//3 type input define in pattern 2's
    input  [`FIX_INT+`FIX_FLOAT-1:0]   rssiC;//3 type input define in pattern 2's
    input  [`VALUE_INT+`VALUE_FLOAT-1:0]   valueA;//after expABC to complete 
    input  [`VALUE_INT+`VALUE_FLOAT-1:0]   valueB;//after expABC to complete 
    input  [`VALUE_INT+`VALUE_FLOAT-1:0]   valueC;//after expABC to complete 
    output [`FIX_FLOAT-1:0]   expA;
    output [`FIX_FLOAT-1:0]   expB;
    output [`FIX_FLOAT-1:0]   expC;
    output          busy;
    output          out_valid;
    output [`FIX_INT-1:0]    xt;// location for T point
    output [`FIX_INT-1:0]    yt;// location for T point
    wire [1:0] exp_int_A, exp_int_B, exp_int_C;
    wire [`FIX_INT+`FIX_FLOAT-1:0] ab_com_rssiA, ab_com_rssiB, ab_com_rssiC;
    wire [10+`VALUE_INT+`VALUE_FLOAT-1:0]distance_square_A, distance_square_B, distance_square_C;
    wire [3:0] count;
    wire  [(`FIX_INT*2)-1:0] square_sensor_A_X;
    wire  [(`FIX_INT*2)-1:0] square_sensor_A_Y;
    wire  [(`FIX_INT*2)-1:0] square_sensor_B_X;
    wire  [(`FIX_INT*2)-1:0] square_sensor_B_Y;
    wire  [(`FIX_INT*2)-1:0] square_sensor_C_X;
    wire  [(`FIX_INT*2)-1:0] square_sensor_C_Y;
    wire  signed [`FIX_INT-1:0] x_delta_ba, x_delta_ca, y_delta_ba, y_delta_ca;
    wire  signed [`FIX_INT+`FIX_INT-1:0]denominator;


    busy_control busy_controlor(
        .clk(clk),
        .rst(rst),
        .busy(busy)
    );
    valid_control valid_controlor(
        .clk(clk), 
        .rst(rst), 
        .out_valid(out_valid),
        .count(count)
    );
    counter_test counter_tester (
        .clk(clk),
        .rst(rst),
        .count(count)
    );
    complement complementer (
        .clk (clk),
        .rst (rst),
        .rssiA(rssiA),                     
        .rssiB(rssiB), 
        .rssiC(rssiC), 
        .ab_com_rssiA(ab_com_rssiA), 
        .ab_com_rssiB(ab_com_rssiB), 
        .ab_com_rssiC(ab_com_rssiC)
        );
    cal_exp caler_exp (
        .clk(clk),
        .rst(rst),
        .ab_com_rssiA(ab_com_rssiA), 
        .ab_com_rssiB(ab_com_rssiB), 
        .ab_com_rssiC(ab_com_rssiC), 
        .exp_float_A(expA), 
        .exp_float_B(expB), 
        .exp_float_C(expC),
        .exp_int_A(exp_int_A), 
        .exp_int_B(exp_int_B), 
        .exp_int_C(exp_int_C)
        );    
    cal_distance cal_distancer  (
        .clk (clk),
        .rst (rst),
        .exp_int_A(exp_int_A), 
        .exp_int_B(exp_int_B), 
        .exp_int_C(exp_int_C), 
        .valueA(valueA), 
        .valueB(valueB), 
        .valueC(valueC), 
        .distance_square_A(distance_square_A), 
        .distance_square_B(distance_square_B), 
        .distance_square_C(distance_square_C)
        );
    location locationor (
        .clk(clk),
        .rst(rst),
        .square_sensor_A_X(square_sensor_A_X),
        .square_sensor_A_Y(square_sensor_A_Y),
        .square_sensor_B_X(square_sensor_B_X),
        .square_sensor_B_Y(square_sensor_B_Y),
        .square_sensor_C_X(square_sensor_C_X),
        .square_sensor_C_Y(square_sensor_C_Y),
        .x_delta_ba(x_delta_ba),
        .x_delta_ca(x_delta_ca),
        .y_delta_ba(y_delta_ba),
        .y_delta_ca(y_delta_ca),
        .denominator(denominator),
        .distance_square_A(distance_square_A),
        .distance_square_B(distance_square_B),
        .distance_square_C(distance_square_C),
        .xt(xt),
        .yt(yt)
        );
    constant_calculate constant_calculater(
        .clk(clk),
        .rst(rst),
        .count(count),
        .A_x(A_x),
        .A_y(A_y),
        .B_x(B_x),
        .B_y(B_y),
        .C_x(C_x),
        .C_y(C_y),
        .square_sensor_A_X(square_sensor_A_X),
        .square_sensor_A_Y(square_sensor_A_Y),
        .square_sensor_B_X(square_sensor_B_X),
        .square_sensor_B_Y(square_sensor_B_Y),
        .square_sensor_C_X(square_sensor_C_X),
        .square_sensor_C_Y(square_sensor_C_Y),
        .x_delta_ba(x_delta_ba),
        .x_delta_ca(x_delta_ca),
        .y_delta_ba(y_delta_ba),
        .y_delta_ca(y_delta_ca),
        .denominator(denominator)
    );

endmodule

module busy_control (clk, rst, busy);
    input clk;
    input rst;
    output reg busy;

    always @(posedge clk or posedge rst)
        if (rst)
            busy <= 1'b1;
        else
            busy <= 1'b0;
endmodule

module valid_control (clk, rst, out_valid, count);
    input clk;
    input rst;
    input [3:0]count;
    output reg out_valid;

    always @(posedge clk or posedge rst)
        if (rst)
            out_valid <= 1'b0;
        else if (count == 4'd9)
            out_valid <= 1'b1;

endmodule

module counter_test (clk, rst, count);
        input clk;
        input rst;
        output reg [3:0] count;
        always @(posedge clk or posedge rst)    
            if (rst)
                count <=4'b0;
            else if (count!=4'd9)
                count <= count + 1'b1;

endmodule
module complement (clk, rst, rssiA, rssiB, rssiC, ab_com_rssiA, ab_com_rssiB, ab_com_rssiC);

    input clk;
    input rst;
    input [`FIX_INT+`FIX_FLOAT-1:0] rssiA , rssiB, rssiC;
    output reg [`FIX_INT+`FIX_FLOAT-1:0] ab_com_rssiA, ab_com_rssiB, ab_com_rssiC;
    wire [`FIX_INT+`FIX_FLOAT-1:0] com_rssiA, com_rssiB, com_rssiC;
    always @(posedge clk or posedge rst)
        if (rst) begin 
            ab_com_rssiA <= {(`FIX_INT+`FIX_FLOAT){1'b0}};
            ab_com_rssiB <= {(`FIX_INT+`FIX_FLOAT){1'b0}};
            ab_com_rssiC <= {(`FIX_INT+`FIX_FLOAT){1'b0}};
        end
        else begin           
            ab_com_rssiA <= com_rssiA;
            ab_com_rssiB <= com_rssiB;
            ab_com_rssiC <= com_rssiC;
        end   

    assign com_rssiA = ~rssiA;
    assign com_rssiB = ~rssiB;
    assign com_rssiC = ~rssiC;
endmodule

module cal_exp(clk, rst, ab_com_rssiA, ab_com_rssiB, ab_com_rssiC, exp_float_A, exp_float_B, exp_float_C, exp_int_A, exp_int_B, exp_int_C);

    input clk;
    input rst;
    input[`FIX_INT+`FIX_FLOAT-1:0] ab_com_rssiA, ab_com_rssiB, ab_com_rssiC;
    output reg [`FIX_FLOAT-1:0]exp_float_A;
    output reg [`FIX_FLOAT-1:0]exp_float_B;
    output reg [`FIX_FLOAT-1:0]exp_float_C;
    output reg [1:0] exp_int_A;
    output reg [1:0] exp_int_B;
    output reg [1:0] exp_int_C;

    wire [4+`FIX_INT+`FIX_FLOAT-1:0]exp_A;    
    wire [4+`FIX_INT+`FIX_FLOAT-1:0]exp_B;
    wire [4+`FIX_INT+`FIX_FLOAT-1:0]exp_C;    
    wire [`FIX_INT-1:0] exp_int_AA;
    wire [`FIX_INT-1:0] exp_int_BB;
    wire [`FIX_INT-1:0] exp_int_CC;

    always @(posedge clk or posedge rst)
        if (rst) begin
            exp_float_A <= {`FIX_FLOAT{1'b0}};
            exp_float_B <= {`FIX_FLOAT{1'b0}};
            exp_float_C <= {`FIX_FLOAT{1'b0}};
            exp_int_A <= {2{1'b0}};
            exp_int_B <= {2{1'b0}};
            exp_int_C <= {2{1'b0}};
        end else begin
            exp_float_A <= exp_A [11:0];
            exp_float_B <= exp_B [11:0];
            exp_float_C <= exp_C [11:0]; 
            exp_int_A <= exp_A[13:12];
            exp_int_B <= exp_B[13:12];
            exp_int_C <= exp_C[13:12];
        end
    
    assign exp_int_AA = ab_com_rssiA[19:12] - `ALPHA;// to divide 20 can get real int number
    assign exp_int_BB = ab_com_rssiB[19:12] - `ALPHA;// to divide 20 can get real int number
    assign exp_int_CC = ab_com_rssiC[19:12] - `ALPHA;// to divide 20 can get real int number
    
    assign exp_A = ((({exp_int_AA,ab_com_rssiA[11:0]})*7'd102) >> 10);
    assign exp_B = ((({exp_int_BB,ab_com_rssiB[11:0]})*7'd102) >> 10);
    assign exp_C = ((({exp_int_CC,ab_com_rssiC[11:0]})*7'd102) >> 10);
endmodule

module cal_distance (clk , rst, exp_int_A, exp_int_B, exp_int_C, valueA, valueB, valueC, distance_square_A, distance_square_B, distance_square_C);

    input clk;
    input rst;
    input [1:0] exp_int_A, exp_int_B, exp_int_C;
    input [`VALUE_INT+`VALUE_FLOAT-1:0]valueA, valueB, valueC;
    output reg [10+`VALUE_INT+`VALUE_FLOAT-1:0]distance_square_A;
    output reg [10+`VALUE_INT+`VALUE_FLOAT-1:0]distance_square_B;
    output reg [10+`VALUE_INT+`VALUE_FLOAT-1:0]distance_square_C;
    wire [10+`VALUE_INT+`VALUE_FLOAT-1:0]distance_multiply_A;
    wire [10+`VALUE_INT+`VALUE_FLOAT-1:0]distance_multiply_B;
    wire [10+`VALUE_INT+`VALUE_FLOAT-1:0]distance_multiply_C;
    wire [1:0] cs_int_A;
    wire [1:0] cs_int_B;
    wire [1:0] cs_int_C;    
    reg [9:0] ten_exp_A, ten_exp_B, ten_exp_C;
    assign cs_int_A = exp_int_A;
    assign cs_int_B = exp_int_B;
    assign cs_int_C = exp_int_C;
    always @(posedge clk or posedge rst)
        if (rst)begin
            distance_square_A <= {(10+`VALUE_INT+`VALUE_FLOAT){1'b0}};
            distance_square_B <= {(10+`VALUE_INT+`VALUE_FLOAT){1'b0}};
            distance_square_C <= {(10+`VALUE_INT+`VALUE_FLOAT){1'b0}};
        end else begin
            distance_square_A <= distance_multiply_A;
            distance_square_B <= distance_multiply_B;
            distance_square_C <= distance_multiply_C;
        end
    
    always @(*)
        case (cs_int_A)
            2'd0: ten_exp_A =  10'd1;
            2'd1: ten_exp_A =  10'd10;
            2'd2: ten_exp_A =  10'd100;
            2'd3: ten_exp_A =  10'd1000;
            default:ten_exp_A =10'b0;
        endcase

    always @(*)
        case (cs_int_B)
            2'd0: ten_exp_B =  10'd1;
            2'd1: ten_exp_B =  10'd10;
            2'd2: ten_exp_B =  10'd100;
            2'd3: ten_exp_B =  10'd1000;
            default:ten_exp_B =10'b0;
        endcase

    always @(*)
        case (cs_int_C)
            2'd0: ten_exp_C =  10'd1;
            2'd1: ten_exp_C =  10'd10;
            2'd2: ten_exp_C =  10'd100;
            2'd3: ten_exp_C =  10'd1000;
            default:ten_exp_C =10'b0;
        endcase

        assign distance_multiply_A = (ten_exp_A * valueA);
        assign distance_multiply_B = (ten_exp_B * valueB);
        assign distance_multiply_C = (ten_exp_C * valueC);
endmodule


module location (clk, rst, square_sensor_A_X, square_sensor_A_Y, square_sensor_B_X, square_sensor_B_Y, square_sensor_C_X, square_sensor_C_Y, x_delta_ba, x_delta_ca, y_delta_ba, y_delta_ca, denominator, distance_square_A, distance_square_B, distance_square_C, xt, yt);
    
    input clk;
    input rst;
    input [10+`VALUE_INT+`VALUE_FLOAT-1:0] distance_square_A, distance_square_B, distance_square_C;
    input [(`FIX_INT*2)-1:0] square_sensor_A_X;
    input [(`FIX_INT*2)-1:0] square_sensor_A_Y;
    input [(`FIX_INT*2)-1:0] square_sensor_B_X;
    input [(`FIX_INT*2)-1:0] square_sensor_B_Y;
    input [(`FIX_INT*2)-1:0] square_sensor_C_X;
    input [(`FIX_INT*2)-1:0] square_sensor_C_Y;
    input signed [`FIX_INT-1:0] x_delta_ba, x_delta_ca, y_delta_ba, y_delta_ca;
    input signed [`FIX_INT+`FIX_INT-1:0] denominator;

    output reg signed [`FIX_INT-1:0] xt;
    output reg signed [`FIX_INT-1:0] yt;

    wire signed [`FIX_INT+`FIX_INT*2+`FIX_FLOAT-1:0] numerator_xt, numerator_xt_1, numerator_xt_2;
    wire signed [`FIX_INT+`FIX_INT*2+`FIX_FLOAT-1:0] numerator_yt, numerator_yt_1, numerator_yt_2;
    wire signed [`FIX_INT*2+`FIX_FLOAT-1:0] numerator_xt_1_plu, numerator_xt_1_sub, numerator_xt_2_plu, numerator_xt_2_sub;
    wire signed [`FIX_INT*2+`FIX_FLOAT-1:0] numerator_yt_1_plu, numerator_yt_1_sub, numerator_yt_2_plu, numerator_yt_2_sub;
    wire signed [23:0] quotient_xt_full, quotient_yt_full;
    // === 新增化簡常數項 ===
    // consolidated shift left of X and Y square
    wire [(`FIX_INT*2+`FIX_FLOAT)-1:0] square_sensor_A_XY_shifted, square_sensor_B_XY_shifted, square_sensor_C_XY_shifted;

    assign square_sensor_A_XY_shifted = ((square_sensor_A_X + square_sensor_A_Y) << `FIX_FLOAT);
    assign square_sensor_B_XY_shifted = ((square_sensor_B_X + square_sensor_B_Y) << `FIX_FLOAT);
    assign square_sensor_C_XY_shifted = ((square_sensor_C_X + square_sensor_C_Y) << `FIX_FLOAT);

    // ====================

    always @(posedge clk or posedge rst)
        if(rst)
            xt <= {`FIX_INT{1'b0}};
        else
            xt <= quotient_xt_full[8:1];

    always @(posedge clk or posedge rst)
        if(rst)
            yt <= {`FIX_INT{1'b0}};
        else
            yt <= quotient_yt_full[8:1];
    DW_div_pipe #(
        .a_width(24),
        .b_width(16),
        .tc_mode(1),
        .rem_mode(1),
        .num_stages(`NUM_STAGES),
        .stall_mode(0),
        .rst_mode(1),
        .op_iso_mode(0)
    ) u_div_xt (
        .clk(clk),
        .rst_n(~rst),
        .en(1'b1),
        .a(numerator_xt[35:12]),
        .b(denominator),
        .quotient(quotient_xt_full),
        .remainder(),
        .divide_by_0()
    );
    DW_div_pipe #(
        .a_width(24),
        .b_width(16),
        .tc_mode(1),
        .rem_mode(1),
        .num_stages(`NUM_STAGES),
        .stall_mode(0),
        .rst_mode(1),
        .op_iso_mode(0)
    ) u_div_yt (
        .clk(clk),
        .rst_n(~rst),
        .en(1'b1),
        .a(numerator_yt[35:12]),
        .b(denominator),
        .quotient(quotient_yt_full),
        .remainder(),
        .divide_by_0()
    );

    assign numerator_xt_1_plu = distance_square_A + square_sensor_B_XY_shifted;
    assign numerator_xt_1_sub = distance_square_B + square_sensor_A_XY_shifted;
    assign numerator_xt_1 = y_delta_ca * (numerator_xt_1_plu - numerator_xt_1_sub);

    assign numerator_xt_2_plu = distance_square_A + square_sensor_C_XY_shifted;
    assign numerator_xt_2_sub = distance_square_C + square_sensor_A_XY_shifted;
    assign numerator_xt_2 = y_delta_ba * (numerator_xt_2_plu - numerator_xt_2_sub);

    assign numerator_yt_1_plu = distance_square_A + square_sensor_C_XY_shifted;
    assign numerator_yt_1_sub = distance_square_C + square_sensor_A_XY_shifted;
    assign numerator_yt_1 = x_delta_ba * (numerator_yt_1_plu - numerator_yt_1_sub);

    assign numerator_yt_2_plu = distance_square_A + square_sensor_B_XY_shifted;
    assign numerator_yt_2_sub = distance_square_B + square_sensor_A_XY_shifted;
    assign numerator_yt_2 = x_delta_ca * (numerator_yt_2_plu - numerator_yt_2_sub);

    assign numerator_xt = numerator_xt_1 - numerator_xt_2;
    assign numerator_yt = numerator_yt_1 - numerator_yt_2;

endmodule

module constant_calculate (clk, rst, count, A_x, A_y, B_x, B_y, C_x, C_y, square_sensor_A_X, square_sensor_A_Y, square_sensor_B_X, square_sensor_B_Y, square_sensor_C_X, square_sensor_C_Y, x_delta_ba, x_delta_ca, y_delta_ba, y_delta_ca, denominator);

    input clk;
    input rst;
    input [3:0] count; 
    input [`FIX_INT-1:0] A_x, A_y, B_x, B_y, C_x, C_y;

    output reg [(`FIX_INT*2)-1:0] square_sensor_A_X;
    output reg [(`FIX_INT*2)-1:0] square_sensor_A_Y;
    output reg [(`FIX_INT*2)-1:0] square_sensor_B_X;
    output reg [(`FIX_INT*2)-1:0] square_sensor_B_Y;
    output reg [(`FIX_INT*2)-1:0] square_sensor_C_X;
    output reg [(`FIX_INT*2)-1:0] square_sensor_C_Y;

    output reg signed [`FIX_INT-1:0] x_delta_ba, x_delta_ca; 
    output reg signed [`FIX_INT-1:0] y_delta_ba, y_delta_ca;

    output signed [`FIX_INT+`FIX_INT-1:0]denominator;
    
    wire signed [`FIX_INT+`FIX_INT-1:0]half_delta_mul;
    wire [(`FIX_INT*2)-1:0] sensor_x_square;
    wire [(`FIX_INT*2)-1:0] sensor_y_square;

    reg signed [`FIX_INT+`FIX_INT-1:0] half_delta1;
    reg signed [`FIX_INT+`FIX_INT-1:0] half_delta2;
    reg signed [`FIX_INT-1:0] mul_delta1;
    reg signed [`FIX_INT-1:0] mul_delta2;
    wire  [`FIX_INT-1:0] sensor_x_sel;
    wire  [`FIX_INT-1:0] sensor_y_sel;
    wire signed [`FIX_INT-1:0] sensor_x_delta;
    wire signed [`FIX_INT-1:0] sensor_y_delta;



    always @(posedge clk or posedge rst) begin
        if (rst) begin
            square_sensor_A_X <= {(`FIX_INT*2){1'b0}}; 
            square_sensor_B_X <= {(`FIX_INT*2){1'b0}}; 
            square_sensor_C_X <= {(`FIX_INT*2){1'b0}};
            square_sensor_A_Y <= {(`FIX_INT*2){1'b0}}; 
            square_sensor_B_Y <= {(`FIX_INT*2){1'b0}}; 
            square_sensor_C_Y <= {(`FIX_INT*2){1'b0}};
        end else begin
            case (count)
                4'd0 : begin
                    square_sensor_B_X <= sensor_x_square; 
                    square_sensor_C_Y <= sensor_y_square;
                end
                4'd1 : begin
                    square_sensor_C_X <= sensor_x_square;
                    square_sensor_B_Y <= sensor_y_square;
                end
                4'd2 : begin
                    square_sensor_A_X <= sensor_x_square;
                    square_sensor_A_Y <= sensor_y_square;
                end
                default : ;
            endcase
        end
    end

    assign sensor_x_sel = (count == 4'd0) ? B_x :
                          (count == 4'd1) ? C_x :
                          (count == 4'd2) ? A_x : {`FIX_INT{1'b0}};
    
    assign sensor_y_sel = (count == 4'd0) ? C_y :
                          (count == 4'd1) ? B_y :
                          (count == 4'd2) ? A_y : {`FIX_INT{1'b0}};

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            x_delta_ba <= {`FIX_INT{1'b0}}; 
            x_delta_ca <= {`FIX_INT{1'b0}}; 
            y_delta_ba <= {`FIX_INT{1'b0}}; 
            y_delta_ca <= {`FIX_INT{1'b0}};
        end else begin
            case (count)
                4'd0 : begin
                    x_delta_ba <= sensor_x_delta; 
                    y_delta_ca <= sensor_y_delta;
                end
                4'd1 : begin
                    x_delta_ca <= sensor_x_delta;
                    y_delta_ba <= sensor_y_delta;
                end
                default : ; 
            endcase
        end
    end

    assign sensor_x_square = sensor_x_sel * sensor_x_sel;
    assign sensor_y_square = sensor_y_sel * sensor_y_sel;
    assign sensor_x_delta = sensor_x_sel - A_x;
    assign sensor_y_delta = sensor_y_sel - A_y;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            half_delta1 <= {(`FIX_INT+`FIX_INT){1'b0}}; 
            half_delta2 <= {(`FIX_INT+`FIX_INT){1'b0}}; 
        end else begin
            case (count)
                4'd1 : half_delta1 <= half_delta_mul; 
                4'd2 : half_delta2 <= half_delta_mul;
                default :;
            endcase
        end
    end
    always @(*) begin
            case (count)
                4'd1 : mul_delta1 = x_delta_ba; 
                4'd2 : mul_delta1 = x_delta_ca;
                default :mul_delta1 = {`FIX_INT{1'b0}};
            endcase
        end
    always @(*) begin
            case (count)
                4'd1 : mul_delta2 = y_delta_ca; 
                4'd2 : mul_delta2 = y_delta_ba;
                default :mul_delta2 = {`FIX_INT{1'b0}};
            endcase
        end
    assign half_delta_mul = mul_delta1 * mul_delta2;

    assign denominator = (half_delta1)-(half_delta2);

endmodule
