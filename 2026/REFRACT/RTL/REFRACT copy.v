`include "/usr/cad/synopsys/synthesis/2025.06/dw/sim_ver/DW_sqrt.v"
`include "/usr/cad/synopsys/synthesis/2025.06/dw/sim_ver/DW_sqrt_pipe.v"
`include "/usr/cad/synopsys/synthesis/2025.06/dw/sim_ver/DW_div.v"
`include "/usr/cad/synopsys/synthesis/2025.06/dw/sim_ver/DW_div_pipe.v"

module REFRACT(
    input        CLK,
    input        RST,
    input  [3:0] RI,   
    output [8:0]  SRAM_A,
    output reg  [15:0] SRAM_D,
    input  [15:0] SRAM_Q,   // unused
    output  SRAM_WE,
    output       DONE
);

    wire [3:0] cur_state;
    wire [3:0] next_state;
    wire z_height_g_square_en;
    wire k_g_square_en;
    wire square_en;
    wire square_done;
    wire numerator_en;
    wire denominator_en;
    wire div_en;
    wire div_pipe_done;
    wire z_location_en;
    wire sram_sel;
    wire [3:0] location_x;
    wire [3:0] location_y;
    wire [15:0] z_height;
    wire [15:0] g_square;
    wire signed [15:0] p7_y;
    wire [15:0] p8_x;
    wire signed [15:0] p7_x;
    wire [15:0] p14_x;
    wire [15:0] p8_y;
    wire [15:0] p14_y;
    wire [31:0] one_minus_eta2;
    wire [15:0] eta;
    wire [47:0] numerator;
    wire [31:0] denominator;
    wire [15:0] t_mul_coef;
    wire [31:0] k_g_square;
    wire [15:0] square_root;
    wire [15:0] zx;
    wire [15:0] zy;


    mul_tree mul_tree_cal(
        .CLK(CLK),
        .RST(RST),
        .location_x(location_x),
        .location_y(location_y),
        .p7_x(p7_x),
        .p7_y(p7_y),
        .p14_x(p14_x),
        .p14_y(p14_y),
        .p8_x(p8_x),
        .p8_y(p8_y)
    );
    SRAM_address_generator sram_address_generator(
        .CLK(CLK),
        .RST(RST),
        .zx(zx),
        .zy(zy),
        .location_x(location_x),
        .location_y(location_y),
        .sram_sel(sram_sel),
        .SRAM_A(SRAM_A),
        .SRAM_D(SRAM_D)
    );

    location_counter location_counter(
        .CLK(CLK),
        .RST(RST),
        .location_x(location_x),
        .location_y(location_y),
        .DONE(DONE)
    );

    z_height_calculate z_height_calculate(
        .CLK(CLK),
        .RST(RST),
        .location_x(location_x),
        .location_y(location_y),
        .z_height_g_square_en(z_height_g_square_en),
        .p8_x(p8_x),
        .p8_y(p8_y),
        .z_height(z_height)
    );

    g_square_calculate g_square_calculate(
        .CLK(CLK),
        .RST(RST),
        .location_x(location_x),
        .location_y(location_y),
        .z_height_g_square_en(z_height_g_square_en),
        .p14_x(p14_x),
        .p14_y(p14_y),
        .g_square(g_square)
    );

    k_g_square_calculate k_g_square_calculater(
        .CLK(CLK),
        .RST(RST),
        .k_g_square_en(k_g_square_en),
        .g_square(g_square),
        .one_minus_eta2(one_minus_eta2),
        .k_g_square(k_g_square)
    );

    numerator_calculate numerator_calculate(
        .CLK(CLK),
        .RST(RST),
        .numerator_en(numerator_en),
        .one_minus_eta2(one_minus_eta2),
        .z_height(z_height),
        .numerator(numerator)
    );

    denominator_calculate denominator_calculate(
        .CLK(CLK),
        .RST(RST),
        .denominator_en(denominator_en),
        .square_root(square_root),
        .eta(eta),
        .denominator(denominator)
    );

    one_minus_eta2_lut one_minus_eta2_lutable(
        .RI(RI),
        .eta(eta),
        .one_minus_eta2(one_minus_eta2)
    );

    square_root_calculate square_root_calculate(
        .CLK(CLK),
        .RST(RST),
        .k_g_square(k_g_square),
        .square_en(square_en),
        .square_root(square_root),
        .square_done(square_done)
    );

    eta_lut eta_lutable(
        .RI(RI),
        .eta(eta)
    );
    division_calculate division_calculate(
        .CLK(CLK),
        .RST(RST),
        .div_en(div_en),
        .numerator(numerator),
        .denominator(denominator),
        .t_mul_coef(t_mul_coef),
        .div_pipe_done(div_pipe_done)
    );

    z_location z_location_calculate(
        .CLK(CLK),
        .RST(RST),
        .z_location_en(z_location_en),
        .location_x(location_x),
        .location_y(location_y),
        .p7_x(p7_x),
        .p7_y(p7_y),
        .t_mul_coef(t_mul_coef),
        .zx(zx),
        .zy(zy)
    );
endmodule

module SRAM_address_generator(
    input        CLK,
    input        RST,
    input        sram_sel,
    input        [15:0] zx,
    input        [15:0] zy,
    input        [3:0] location_x, 
    input        [3:0] location_y,
    output reg [8:0]   SRAM_A,
    output [15:0]   SRAM_D
);

    // location_x/y buffer (11-cycle) to align with zx/zy datapath timing
    reg [3:0] location_x_d0, location_x_d1, location_x_d2, location_x_d3, location_x_d4;
    reg [3:0] location_x_d5, location_x_d6, location_x_d7, location_x_d8, location_x_d9, location_x_d10;
    reg [3:0] location_y_d0, location_y_d1, location_y_d2, location_y_d3, location_y_d4;
    reg [3:0] location_y_d5, location_y_d6, location_y_d7, location_y_d8, location_y_d9, location_y_d10;

    always @(posedge CLK or posedge RST) begin
        if (RST) begin
            location_x_d0 <= 4'd0; location_x_d1 <= 4'd0; location_x_d2 <= 4'd0; location_x_d3 <= 4'd0; location_x_d4 <= 4'd0;
            location_x_d5 <= 4'd0; location_x_d6 <= 4'd0; location_x_d7 <= 4'd0; location_x_d8 <= 4'd0; location_x_d9 <= 4'd0; location_x_d10 <= 4'd0;
            location_y_d0 <= 4'd0; location_y_d1 <= 4'd0; location_y_d2 <= 4'd0; location_y_d3 <= 4'd0; location_y_d4 <= 4'd0;
            location_y_d5 <= 4'd0; location_y_d6 <= 4'd0; location_y_d7 <= 4'd0; location_y_d8 <= 4'd0; location_y_d9 <= 4'd0; location_y_d10 <= 4'd0;
            SRAM_A         <= 9'd0;
        end else begin
            // shift in current location
            location_x_d0 <= location_x;
            location_x_d1 <= location_x_d0;
            location_x_d2 <= location_x_d1;
            location_x_d3 <= location_x_d2;
            location_x_d4 <= location_x_d3;
            location_x_d5 <= location_x_d4;
            location_x_d6 <= location_x_d5;
            location_x_d7 <= location_x_d6;
            location_x_d8 <= location_x_d7;
            location_x_d9 <= location_x_d8;
            location_x_d10 <= location_x_d9;

            location_y_d0 <= location_y;
            location_y_d1 <= location_y_d0;
            location_y_d2 <= location_y_d1;
            location_y_d3 <= location_y_d2;
            location_y_d4 <= location_y_d3;
            location_y_d5 <= location_y_d4;
            location_y_d6 <= location_y_d5;
            location_y_d7 <= location_y_d6;
            location_y_d8 <= location_y_d7;
            location_y_d9 <= location_y_d8;
            location_y_d10 <= location_y_d9;

            // Use delayed location for SRAM addressing
            SRAM_A <= {location_y_d10, location_x_d10, sram_sel}; // LSB=sram_sel: 0->zx, 1->zy
        end
    end

    assign SRAM_D = (sram_sel) ? zx : zy;
endmodule

module location_counter(
    input        CLK,
    input        RST,
    output reg [3:0]   location_x,
    output reg [3:0]   location_y,
    output reg         DONE
);

    always @(posedge CLK or posedge RST) begin
        if (RST) begin
            DONE <= 1'b0;
        end else if (location_x == 4'd15 && location_y == 4'd15) begin
            DONE <= 1'b1;
        end
    end

    always @(posedge CLK or posedge RST) begin
        if (RST) begin
            location_x <= 4'b0;
        end else begin
            location_x <= location_x + 1;
        end
    end

    always @(posedge CLK or posedge RST) begin
        if (RST) begin
            location_y <= 4'b0;
        end else if (location_x == 4'd15) begin
            location_y <= location_y + 1;
        end
    end
endmodule


module z_height_calculate(
    input        CLK,
    input        RST,
    input  [3:0]  location_x,
    input  [3:0]  location_y,
    input  z_height_g_square_en,
    input  [15:0] p8_x,
    input  [15:0] p8_y,
    output reg  [15:0] z_height
);
    wire [15:0] p8_x_mul_2 = {p8_x[14:0],1'b0};
    wire [15:0] p8_y_mul_2 = {p8_y[14:0],1'b0};


    always @(posedge CLK or posedge RST) begin
        if (RST) begin
            z_height <= 16'h0;
        end else begin
            z_height <= {4'd6,12'd0} - p8_x_mul_2 - p8_y_mul_2;//TODO: check how to decrease the sub
        end
    end
endmodule

module g_square_calculate(
    input        CLK,
    input        RST,
    input  [3:0]  location_x,   // 輸入 X (0~15)
    input  [3:0]  location_y,   // 輸入 Y (0~15)
    input  z_height_g_square_en,
    input  [15:0] p14_x,
    input  [15:0] p14_y,
    output reg  [15:0] g_square
);
    wire [15:0] p14_x_mul_2 = {p14_x[13:0],2'b0};
    wire [15:0] p14_y_mul_2 = {p14_y[13:0],2'b0};

    always @(posedge CLK or posedge RST) begin
        if (RST) begin
            g_square <= 16'h0;
        end else begin
            g_square <= p14_x_mul_2 + p14_y_mul_2 + {4'd1,12'd0}; //TODO: check how to decrease the adder
        end
    end
endmodule

module k_g_square_calculate(
    input        CLK,
    input        RST,
    input        k_g_square_en,
    input  [15:0] g_square,
    input  [31:0] one_minus_eta2,
    output reg  [31:0] k_g_square
);
 
    wire [47:0] k_g_square_com;

    always @(posedge CLK or posedge RST) begin
        if (RST) begin
            k_g_square <= 32'h0;
        end else begin
            k_g_square <= k_g_square_com[43:12];
        end
    end

    assign k_g_square_com = (g_square-{4'd1,12'd0}) * one_minus_eta2 + {12'd1,36'd0};
endmodule

module square_root_calculate(
    input             CLK,
    input             RST,
    input  [31:0]     k_g_square,
    input             square_en,
    output [15:0]     square_root,
    output         square_done
);

    reg [1:0] square_pipe_cnt;
    localparam integer SQRT_W = 32;
    localparam integer ROOT_W = 16;


    DW_sqrt_pipe #(
        .width       (SQRT_W),
        .tc_mode     (0),           // unsigned
        .num_stages  (2),
        .stall_mode  (1),
        .rst_mode    (1),           // async rst_n
        .op_iso_mode (0)
    ) u_dw_sqrt_pipe (
        .clk   (CLK),
        .rst_n (~RST),
        .en    (1'b1),
        .a     (k_g_square),
        .root  (square_root)
    );

endmodule


module numerator_calculate(
    input        CLK,
    input        RST,
    input        numerator_en,
    input  [31:0] one_minus_eta2,
    input  [15:0] z_height,
    output reg  [47:0] numerator
);
    
    
    reg [2:0] z_height_buffer_cnt;
    wire z_height_buffer_en = (z_height_buffer_cnt == 3'd4);
    // buffer z_height for 5-cycle delay (align datapath)
    reg [15:0] z_height_d0;
    reg [15:0] z_height_d1;
    reg [15:0] z_height_d2;
    reg [15:0] z_height_d3;
    reg [15:0] z_height_d4;

    always @(posedge CLK or posedge RST) begin
        if (RST) begin
            z_height_buffer_cnt <= 3'd0;
        end else if (z_height_buffer_cnt != 3'd4) begin
            z_height_buffer_cnt <= z_height_buffer_cnt + 1;
        end
    end

    
    always @(posedge CLK or posedge RST) begin
        if (RST) begin
            z_height_d0 <= 16'h0;
            z_height_d1 <= 16'h0;

        end else if (z_height_buffer_en) begin
            z_height_d0 <= z_height;
            z_height_d1 <= z_height_d0;

        end
    end

    wire [47:0] numerator_com;
    always @(posedge CLK or posedge RST) begin
        if (RST) begin
            numerator <= 48'h0;
        end else begin
            numerator <= numerator_com;
        end
    end

    assign numerator_com = z_height_d1 * one_minus_eta2;
endmodule

module denominator_calculate(
    input        CLK,
    input        RST,
    input        denominator_en,
    input  [15:0] square_root,
    input  [15:0] eta,
    output reg  [31:0] denominator
);

    wire [31:0] denominator_com;

    always @(posedge CLK or posedge RST) begin
        if (RST) begin
            denominator <= 32'h0;
        end else begin
            denominator <= denominator_com;
        end
    end

    assign denominator_com = {8'd1,24'd0}+ square_root * eta;
endmodule
//
module division_calculate(
    input        CLK,
    input        RST,
    input        div_en,
    input  [47:0] numerator,
    input  [31:0] denominator,
    output [15:0] t_mul_coef,
    output div_pipe_done
);

    
    wire [47:0] div_result_com;

    DW_div_pipe #(
        .a_width(48),
        .b_width(32),
        .tc_mode(1),
        .rem_mode(1),
        .num_stages(4),
        .stall_mode(0),
        .rst_mode(1),
        .op_iso_mode(0)
        ) u_div_t_coef (
        .clk(CLK),
        .rst_n(~RST),
        .en(1'b1),
        .a(numerator),
        .b(denominator),
        .quotient(div_result_com),
        .remainder(),
        .divide_by_0()
    );

    assign t_mul_coef = div_result_com[15:0]; //FIXME: check if the result bit is correct
endmodule

module z_location(
    input        CLK,
    input        RST,
    input        z_location_en,
    input  [3:0] location_x,
    input  [3:0] location_y,
    input  signed [15:0] p7_x,
    input  signed [15:0] p7_y,
    input  signed [15:0] t_mul_coef,
    output reg  [15:0] zx,
    output reg  [15:0] zy
);
    reg [2:0] p7_buffer_cnt;
    wire       p7_buffer_en = (p7_buffer_cnt == 3'd4);

    // location_x/y 同步 pipeline（共 10 層：d0~d9）
    reg [3:0] location_x_d0, location_x_d1, location_x_d2, location_x_d3, location_x_d4;
    reg [3:0] location_x_d5, location_x_d6, location_x_d7, location_x_d8, location_x_d9, location_x_d10;
    reg [3:0] location_y_d0, location_y_d1, location_y_d2, location_y_d3, location_y_d4;
    reg [3:0] location_y_d5, location_y_d6, location_y_d7, location_y_d8, location_y_d9, location_y_d10;

    reg signed [15:0] p7_x_d0;
    reg signed [15:0] p7_x_d1;
    reg signed [15:0] p7_x_d2;
    reg signed [15:0] p7_x_d3;
    reg signed [15:0] p7_x_d4;
    reg signed [15:0] p7_x_d5;
    reg signed [15:0] p7_x_d6;
    reg signed [15:0] p7_x_d7;

    reg signed [15:0] p7_y_d0;
    reg signed [15:0] p7_y_d1;
    reg signed [15:0] p7_y_d2;
    reg signed [15:0] p7_y_d3;
    reg signed [15:0] p7_y_d4;
    reg signed [15:0] p7_y_d5;
    reg signed [15:0] p7_y_d6;
    reg signed [15:0] p7_y_d7;

    wire signed [31:0] zx_com;
    wire signed [31:0] zy_com;

    wire signed [15:0] p7_x_mul_2 = (p7_x_d5 <<< 1);
    wire signed [15:0] p7_y_mul_2 = (p7_y_d5 <<< 1);

    always @(posedge CLK or posedge RST) begin
        if (RST) begin
            p7_buffer_cnt <= 3'd0;
        end else if (p7_buffer_cnt != 3'd4) begin
            p7_buffer_cnt <= p7_buffer_cnt + 1'b1;
        end
    end

    always @(posedge CLK or posedge RST) begin
        if (RST) begin
            location_x_d0 <= 4'd0; location_x_d1 <= 4'd0; location_x_d2 <= 4'd0; location_x_d3 <= 4'd0; location_x_d4 <= 4'd0;
            location_x_d5 <= 4'd0; location_x_d6 <= 4'd0; location_x_d7 <= 4'd0; location_x_d8 <= 4'd0; location_x_d9 <= 4'd0; location_x_d10 <= 4'd0;
            location_y_d0 <= 4'd0; location_y_d1 <= 4'd0; location_y_d2 <= 4'd0; location_y_d3 <= 4'd0; location_y_d4 <= 4'd0;
            location_y_d5 <= 4'd0; location_y_d6 <= 4'd0; location_y_d7 <= 4'd0; location_y_d8 <= 4'd0; location_y_d9 <= 4'd0; location_y_d10 <= 4'd0;
        end else if (p7_buffer_en) begin
            location_x_d0 <= location_x;
            location_x_d1 <= location_x_d0;
            location_x_d2 <= location_x_d1;
            location_x_d3 <= location_x_d2;
            location_x_d4 <= location_x_d3;
            location_x_d5 <= location_x_d4;
            location_x_d6 <= location_x_d5;
            location_x_d7 <= location_x_d6;
            location_x_d8 <= location_x_d7;
            location_x_d9 <= location_x_d8;
            location_x_d10 <= location_x_d9;
            location_y_d0 <= location_y;
            location_y_d1 <= location_y_d0;
            location_y_d2 <= location_y_d1;
            location_y_d3 <= location_y_d2;
            location_y_d4 <= location_y_d3;
            location_y_d5 <= location_y_d4;
            location_y_d6 <= location_y_d5;
            location_y_d7 <= location_y_d6;
            location_y_d8 <= location_y_d7;
            location_y_d9 <= location_y_d8;
            location_y_d10 <= location_y_d9;
        end
    end

    always @(posedge CLK or posedge RST) begin
        if (RST) begin
            p7_x_d0 <= 16'sd0;
            p7_x_d1 <= 16'sd0;
            p7_x_d2 <= 16'sd0;
            p7_x_d3 <= 16'sd0;
            p7_x_d4 <= 16'sd0;
            p7_x_d5 <= 16'sd0;
            p7_x_d6 <= 16'sd0;
            p7_x_d7 <= 16'sd0;
            p7_y_d0 <= 16'sd0;
            p7_y_d1 <= 16'sd0;
            p7_y_d2 <= 16'sd0;
            p7_y_d3 <= 16'sd0;
            p7_y_d4 <= 16'sd0;
            p7_y_d5 <= 16'sd0;
            p7_y_d6 <= 16'sd0;
            p7_y_d7 <= 16'sd0;
        end else if (p7_buffer_en) begin
            p7_x_d0 <= p7_x;
            p7_x_d1 <= p7_x_d0;
            p7_x_d2 <= p7_x_d1;
            p7_x_d3 <= p7_x_d2;
            p7_x_d4 <= p7_x_d3;
            p7_x_d5 <= p7_x_d4;
            p7_x_d6 <= p7_x_d5;
            p7_x_d7 <= p7_x_d6;

            p7_y_d0 <= p7_y;
            p7_y_d1 <= p7_y_d0;
            p7_y_d2 <= p7_y_d1;
            p7_y_d3 <= p7_y_d2;
            p7_y_d4 <= p7_y_d3;
            p7_y_d5 <= p7_y_d4;
            p7_y_d6 <= p7_y_d5;
            p7_y_d7 <= p7_y_d6;
        end
    end
    always @(posedge CLK or posedge RST) begin
        if (RST) begin
            zx <= 16'h0;
        end else begin
            zx <= zx_com[27:12]; 
        end
    end
    always @(posedge CLK or posedge RST) begin
        if (RST) begin
            zy <= 16'h0;
        end else begin
            zy <= zy_com[27:12]; 
        end
    end

    assign zx_com = $signed({4'd0, location_x_d10, 24'd0})
                   - ($signed(t_mul_coef) * $signed(p7_x_mul_2));
    assign zy_com = $signed({4'd0, location_y_d10, 24'd0})
                   - ($signed(t_mul_coef) * $signed(p7_y_mul_2));
endmodule


module mul_tree(
    input        CLK,
    input        RST,
    input        [3:0]location_x,
    input        [3:0]location_y,
    output signed [15:0] p7_x,
    output signed [15:0] p7_y,
    output [15:0] p14_x,
    output [15:0] p14_y,
    output [15:0] p8_x,
    output [15:0] p8_y
);

    wire signed [3:0] sub_8_x = location_x - 4'd8;
    wire signed [3:0] sub_8_y = location_y - 4'd8;


    //stage 0: sub^2 and sub^3
    wire signed [7:0] sub_8_x_square_0_com = sub_8_x * sub_8_x;
    wire signed [7:0] sub_8_x_square_1_com = sub_8_x * sub_8_x;
    wire signed [7:0] sub_8_y_square_0_com = sub_8_y * sub_8_y;
    wire signed [7:0] sub_8_y_square_1_com = sub_8_y * sub_8_y;

    wire signed [11:0] p7_x_square_3_com = sub_8_x_square_0_com * sub_8_x;
    wire signed [11:0] p7_y_square_3_com = sub_8_y_square_0_com * sub_8_y;

    reg signed [7:0] sub_8_x_square_0_reg, sub_8_x_square_1_reg;
    reg signed [7:0] sub_8_y_square_0_reg, sub_8_y_square_1_reg;
    reg signed [11:0] p7_x_square_3_reg, p7_y_square_3_reg;


    always @(posedge CLK or posedge RST) begin
        if (RST) begin
            sub_8_x_square_0_reg <= 8'h0;
            sub_8_x_square_1_reg <= 8'h0;
            sub_8_y_square_0_reg <= 8'h0;
            sub_8_y_square_1_reg <= 8'h0;
            p7_x_square_3_reg <= 12'h0;
            p7_y_square_3_reg <= 12'h0;
        end else begin
            sub_8_x_square_0_reg <= sub_8_x_square_0_com;
            sub_8_x_square_1_reg <= sub_8_x_square_1_com;
            sub_8_y_square_0_reg <= sub_8_y_square_0_com;
            sub_8_y_square_1_reg <= sub_8_y_square_1_com;
            p7_x_square_3_reg <= p7_x_square_3_com;
            p7_y_square_3_reg <= p7_y_square_3_com;
        end
    end
    
    //stage 1: sub^4 and sub^7
    wire signed [15:0] sub_8_x_square_2_com = sub_8_x_square_0_reg * sub_8_x_square_1_reg;
    wire signed [15:0] sub_8_y_square_2_com = sub_8_y_square_0_reg * sub_8_y_square_1_reg;
    wire signed [27:0] p7_x_square_7_com = p7_x_square_3_reg * sub_8_x_square_2_com;
    wire signed [27:0] p7_y_square_7_com = p7_y_square_3_reg * sub_8_y_square_2_com;
    
    reg signed [15:0] sub_8_x_square_2_reg;
    reg signed [15:0] sub_8_y_square_2_reg;
    reg signed [27:0] p7_x_square_7_reg;
    reg signed [27:0] p7_y_square_7_reg;

    always @(posedge CLK or posedge RST) begin
        if (RST) begin
            p7_x_square_7_reg <= 28'h0;
            p7_y_square_7_reg <= 28'h0;
        end else begin
            p7_x_square_7_reg <= p7_x_square_7_com;
            p7_y_square_7_reg <= p7_y_square_7_com;
        end
    end
    always @(posedge CLK or posedge RST) begin
        if (RST) begin
            sub_8_x_square_2_reg <= 16'h0;
            sub_8_y_square_2_reg <= 15'h0;
        end else begin
            sub_8_x_square_2_reg <= sub_8_x_square_2_com;
            sub_8_y_square_2_reg <= sub_8_y_square_2_com;
        end
    end
    //stage 2: sub^8 and sub^14
    wire signed [31:0] sub_8_x_square_3_com = sub_8_x_square_2_reg * sub_8_x_square_2_reg;
    wire signed [31:0] sub_8_y_square_3_com = sub_8_y_square_2_reg * sub_8_y_square_2_reg;
    wire signed [55:0] p14_x_square_14_com = p7_x_square_7_reg * p7_x_square_7_reg;
    wire signed [55:0] p14_y_square_14_com = p7_y_square_7_reg * p7_y_square_7_reg;

    reg signed [31:0] sub_8_x_square_3_reg;
    reg signed [31:0] sub_8_y_square_3_reg;
    reg signed [55:0] p14_x_square_14_reg;
    reg signed [55:0] p14_y_square_14_reg;
    reg signed [27:0] p7_x_square_7_reg_pipe;
    reg signed [27:0] p7_y_square_7_reg_pipe;

    always @(posedge CLK or posedge RST) begin
        if (RST) begin
            p7_x_square_7_reg_pipe <= 28'h0;
            p7_y_square_7_reg_pipe <= 28'h0;
        end else begin
            p7_x_square_7_reg_pipe <= p7_x_square_7_reg;
            p7_y_square_7_reg_pipe <= p7_y_square_7_reg;
        end
    end
    always @(posedge CLK or posedge RST) begin
        if (RST) begin
            p14_x_square_14_reg <= 56'h0;
            p14_y_square_14_reg <= 56'h0;
        end else begin
            p14_x_square_14_reg <= p14_x_square_14_com;
            p14_y_square_14_reg <= p14_y_square_14_com;
        end
    end
    always @(posedge CLK or posedge RST) begin
        if (RST) begin
            sub_8_x_square_3_reg <= 32'h0;
            sub_8_y_square_3_reg <= 32'h0;
        end else begin
            sub_8_x_square_3_reg <= sub_8_x_square_3_com;
            sub_8_y_square_3_reg <= sub_8_y_square_3_com;
        end
    end

    assign p7_x = p7_x_square_7_reg_pipe >>> 9;
    assign p7_y = p7_y_square_7_reg_pipe >>> 9;

    assign p14_x = p14_x_square_14_reg >>> 30;
    assign p14_y = p14_y_square_14_reg >>> 30;

    assign p8_x = sub_8_x_square_3_reg >>> 12;
    assign p8_y = sub_8_y_square_3_reg >>> 12;
endmodule


module eta_lut(
    input  [3:0]  RI,     
    output reg [15:0] eta  
);

    integer i;
    reg [4:0]  current_rem;
    reg [11:0] current_quot;

    always @(*) begin
        current_rem = 5'd1; 
        current_quot = 12'd0;

        if (RI < 4'd2) begin
            eta = 16'h0000;
        end else begin
            for (i = 0; i < 12; i = i + 1) begin
                if ({current_rem[3:0], 1'b0} >= RI) begin
                    current_rem = {current_rem[3:0], 1'b0} - RI;
                    current_quot = {current_quot[10:0], 1'b1};
                end else begin
                    current_rem = {current_rem[3:0], 1'b0};
                    current_quot = {current_quot[10:0], 1'b0};
                end
            end
            eta = {4'b0, current_quot};
        end
    end

endmodule

module one_minus_eta2_lut(
    input  [3:0]  RI,     
    input  [15:0] eta,               // 玻璃折射率, 2 <= RI <= 15 [cite: 493]
    output reg  [31:0] one_minus_eta2     // 1 - (1/RI)^2, 無號 Q4.12
);
    wire [31:0] eta2 = eta * eta;

    always @(*) begin
        one_minus_eta2 = 32'h01000000 - eta2;
    end

endmodule