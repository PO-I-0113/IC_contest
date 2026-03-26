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
    input  [15:0] SRAM_Q,   
    output  SRAM_WE,
    output       DONE
);

    wire [3:0] cur_state;
    wire [3:0] next_state;
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
        .SRAM_A(SRAM_A),
        .SRAM_D(SRAM_D),
        .SRAM_WE(SRAM_WE),
        .DONE(DONE)
    );

    location_counter location_counter(
        .CLK(CLK),
        .RST(RST),
        .location_x(location_x),
        .location_y(location_y)
    );

    z_height_calculate z_height_calculate(
        .CLK(CLK),
        .RST(RST),
        .location_x(location_x),
        .location_y(location_y),
        .p8_x(p8_x),
        .p8_y(p8_y),
        .z_height(z_height)
    );

    g_square_calculate g_square_calculate(
        .CLK(CLK),
        .RST(RST),
        .location_x(location_x),
        .location_y(location_y),
        .p14_x(p14_x),
        .p14_y(p14_y),
        .g_square(g_square)
    );

    k_g_square_calculate k_g_square_calculater(
        .CLK(CLK),
        .RST(RST),
        .g_square(g_square),
        .one_minus_eta2(one_minus_eta2),
        .k_g_square(k_g_square)
    );

    numerator_calculate numerator_calculate(
        .CLK(CLK),
        .RST(RST),
        .one_minus_eta2(one_minus_eta2),
        .z_height(z_height),
        .numerator(numerator)
    );

    denominator_calculate denominator_calculate(
        .CLK(CLK),
        .RST(RST),
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
        .square_root(square_root)
    );

    eta_lut eta_lutable(
        .RI(RI),
        .eta(eta)
    );
    division_calculate division_calculate(
        .CLK(CLK),
        .RST(RST),
        .numerator(numerator),
        .denominator(denominator),
        .t_mul_coef(t_mul_coef)
    );

    z_location z_location_calculate(
        .CLK(CLK),
        .RST(RST),
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
    input        [15:0] zx,
    input        [15:0] zy,
    output [8:0]   SRAM_A,
    output [15:0]   SRAM_D,
    output SRAM_WE,
    output reg DONE
);

    reg [3:0] SRAM_pipe_cnt;
    reg [3:0]sram_location_x;
    reg [3:0]sram_location_y;

    reg sram_sel;
    reg [15:0] zy_buffer;

    always @(posedge CLK or posedge RST) begin
        if (RST) begin
            DONE <= 1'b0;
        end else if (sram_location_x == 4'd15 & sram_location_y == 4'd15 & sram_sel) begin
            DONE <= 1'b1;
        end
    end

    always @(posedge CLK or posedge RST) begin
        if (RST) begin
            zy_buffer <= 16'h0;
        end else begin
            zy_buffer <= zy;
        end
    end

    always @(posedge CLK or posedge RST) begin
        if (RST) begin
            sram_sel <= 1'b0;
        end else begin
            sram_sel <= ~sram_sel;
        end
    end

    always @(posedge CLK or posedge RST) begin
        if (RST) begin
            SRAM_pipe_cnt <= 4'b0;
        end else if (SRAM_pipe_cnt != 4'hC) begin
            SRAM_pipe_cnt <= SRAM_pipe_cnt + 1;
        end
    end
    always @(posedge CLK or posedge RST) begin
        if (RST) begin
            sram_location_x <= 1'b0;
        end else if (SRAM_pipe_cnt == 4'hC & sram_sel) begin
            sram_location_x <= sram_location_x + 1;
        end
    end

    always@(posedge CLK or posedge RST) begin
        if (RST) begin
            sram_location_y <= 1'b0;
        end else if (sram_location_x == 4'd15 & sram_sel) begin
            sram_location_y <= sram_location_y + 1;
        end
    end


    assign SRAM_A = {sram_location_y, sram_location_x, sram_sel};


    assign SRAM_D = (~sram_sel) ? zx : zy_buffer;
    assign SRAM_WE = (SRAM_pipe_cnt == 4'hC);
endmodule

module location_counter(
    input        CLK,
    input        RST,
    output reg [3:0]   location_x,
    output reg [3:0]   location_y
);

    reg half_counter;
    
    always @(posedge CLK or posedge RST) begin
        if (RST) begin
            half_counter <= 1'b0;
        end else begin
            half_counter <= ~half_counter;
        end
    end

    always @(posedge CLK or posedge RST) begin
        if (RST) begin
            location_x <= 4'b0;
        end else if (half_counter) begin
            location_x <= location_x + 1;
        end
    end

    always @(posedge CLK or posedge RST) begin
        if (RST) begin
            location_y <= 4'b0;
        end else if (location_x == 4'd15 && half_counter) begin
            location_y <= location_y + 1;
        end
    end
endmodule


module z_height_calculate(
    input        CLK,
    input        RST,
    input  [3:0]  location_x,
    input  [3:0]  location_y,
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
            z_height <= {4'd6,12'd0} - p8_x_mul_2 - p8_y_mul_2;
        end
    end
endmodule

module g_square_calculate(
    input        CLK,
    input        RST,
    input  [3:0]  location_x,  
    input  [3:0]  location_y,   
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
            g_square <= p14_x_mul_2 + p14_y_mul_2 + {4'd1,12'd0}; 
        end
    end
endmodule

module k_g_square_calculate(
    input        CLK,
    input        RST,
    input  [15:0] g_square,
    input  [31:0] one_minus_eta2,
    output reg  [31:0] k_g_square
);
 
    wire [47:0] k_g_square_com;

    always @(posedge CLK or posedge RST) begin
        if (RST) begin
            k_g_square <= 48'h0;
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
    output [15:0]     square_root
);

    localparam integer SQRT_W = 32;
    localparam integer ROOT_W = 16;


    DW_sqrt_pipe #(
        .width       (SQRT_W),
        .tc_mode     (0),           
        .num_stages  (3),
        .stall_mode  (1),
        .rst_mode    (1),          
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
    input  [31:0] one_minus_eta2,
    input  [15:0] z_height,
    output reg  [47:0] numerator
);
    wire [47:0] numerator_com;


    reg [15:0] z_height_buffer_1;
    reg [15:0] z_height_buffer_2;
    reg [15:0] z_height_buffer_3;

    always @(posedge CLK or posedge RST) begin
        if (RST) begin
            z_height_buffer_1 <= 16'h0;
            z_height_buffer_2 <= 16'h0;
            z_height_buffer_3 <= 16'h0;
        end else begin
            z_height_buffer_1 <= z_height;
            z_height_buffer_2 <= z_height_buffer_1;
            z_height_buffer_3 <= z_height_buffer_2;
        end
    end
    always @(posedge CLK or posedge RST) begin
        if (RST) begin
            numerator <= 48'h0;
        end else begin
            numerator <= numerator_com;
        end
    end

    assign numerator_com = z_height_buffer_3 * one_minus_eta2;
endmodule

module denominator_calculate(
    input        CLK,
    input        RST,
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
    input  [47:0] numerator,
    input  [31:0] denominator,
    output [15:0] t_mul_coef
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

    assign t_mul_coef = div_result_com[15:0]; 
endmodule

module z_location(
    input        CLK,
    input        RST,
    input  signed [15:0] p7_x,
    input  signed [15:0] p7_y,
    input  signed [15:0] t_mul_coef,
    output reg  [15:0] zx,
    output reg  [15:0] zy
);

    wire signed [31:0] zx_com;
    wire signed [31:0] zy_com;
    wire signed [15:0] p7_x_mul_2 = (p7_x <<< 1);
    wire signed [15:0] p7_y_mul_2 = (p7_y <<< 1);
    
    reg [15:0] p7_x_mul_2_buffer_0;
    reg [15:0] p7_x_mul_2_buffer_1;
    reg [15:0] p7_x_mul_2_buffer_2;
    reg [15:0] p7_x_mul_2_buffer_3;
    reg [15:0] p7_x_mul_2_buffer_4;
    reg [15:0] p7_x_mul_2_buffer_5;
    reg [15:0] p7_x_mul_2_buffer_6;

    reg [15:0] p7_y_mul_2_buffer_0;
    reg [15:0] p7_y_mul_2_buffer_1;
    reg [15:0] p7_y_mul_2_buffer_2;
    reg [15:0] p7_y_mul_2_buffer_3;
    reg [15:0] p7_y_mul_2_buffer_4;
    reg [15:0] p7_y_mul_2_buffer_5;
    reg [15:0] p7_y_mul_2_buffer_6;

    always @(posedge CLK or posedge RST) begin
        if (RST) begin
            p7_x_mul_2_buffer_0 <= 16'h0;
            p7_x_mul_2_buffer_1 <= 16'h0;
            p7_x_mul_2_buffer_2 <= 16'h0;
            p7_x_mul_2_buffer_3 <= 16'h0;
            p7_x_mul_2_buffer_4 <= 16'h0;
            p7_x_mul_2_buffer_5 <= 16'h0;
            p7_x_mul_2_buffer_6 <= 16'h0;

            p7_y_mul_2_buffer_0 <= 16'h0;
            p7_y_mul_2_buffer_1 <= 16'h0;
            p7_y_mul_2_buffer_2 <= 16'h0;
            p7_y_mul_2_buffer_3 <= 16'h0;
            p7_y_mul_2_buffer_4 <= 16'h0;
            p7_y_mul_2_buffer_5 <= 16'h0;
            p7_y_mul_2_buffer_6 <= 16'h0;
        end else begin
            p7_x_mul_2_buffer_0 <= p7_x_mul_2;
            p7_x_mul_2_buffer_1 <= p7_x_mul_2_buffer_0;
            p7_x_mul_2_buffer_2 <= p7_x_mul_2_buffer_1;
            p7_x_mul_2_buffer_3 <= p7_x_mul_2_buffer_2;
            p7_x_mul_2_buffer_4 <= p7_x_mul_2_buffer_3;
            p7_x_mul_2_buffer_5 <= p7_x_mul_2_buffer_4;
            p7_x_mul_2_buffer_6 <= p7_x_mul_2_buffer_5;

            p7_y_mul_2_buffer_0 <= p7_y_mul_2;
            p7_y_mul_2_buffer_1 <= p7_y_mul_2_buffer_0;
            p7_y_mul_2_buffer_2 <= p7_y_mul_2_buffer_1;
            p7_y_mul_2_buffer_3 <= p7_y_mul_2_buffer_2;
            p7_y_mul_2_buffer_4 <= p7_y_mul_2_buffer_3;
            p7_y_mul_2_buffer_5 <= p7_y_mul_2_buffer_4;
            p7_y_mul_2_buffer_6 <= p7_y_mul_2_buffer_5;
        end
    end


    reg [3:0] z_location_cnt;
    reg [3:0] z_location_x;
    reg [3:0] z_location_y;
    reg z_half_counter;

    always @(posedge CLK or posedge RST) begin
        if (RST) begin
            z_half_counter <= 1'b0;
        end else begin
            z_half_counter <= ~z_half_counter;
        end
    end

    
    wire z_location_en = (z_location_cnt == 4'd11);
    always @(posedge CLK or posedge RST) begin
        if (RST) begin
            z_location_x <= 4'd0;
        end else if (z_location_en & ~z_half_counter) begin
            z_location_x <= z_location_x + 1;
        end
    end
    always @(posedge CLK or posedge RST) begin
        if (RST) begin
            z_location_y <= 4'd0;
        end else if ( z_location_x == 4'd15 & ~z_half_counter) begin
            z_location_y <= z_location_y + 1;
        end
    end

    always @(posedge CLK or posedge RST) begin
        if (RST) begin
            z_location_cnt <= 4'd0;
        end else if (z_location_cnt != 4'd11) begin
            z_location_cnt <= z_location_cnt + 1;
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

    assign zx_com = $signed({4'd0,z_location_x,24'd0}) - ($signed(t_mul_coef) * $signed(p7_x_mul_2_buffer_6));
    assign zy_com = $signed({4'd0,z_location_y,24'd0}) - ($signed(t_mul_coef) * $signed(p7_y_mul_2_buffer_6));
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

    wire signed [7:0] x_pow2_com = sub_8_x * sub_8_x;
    wire signed [7:0] y_pow2_com = sub_8_y * sub_8_y;

    reg signed [7:0] x_pow2_reg;
    reg signed [7:0] y_pow2_reg;
    reg signed [3:0] sub_8_x_reg;
    reg signed [3:0] sub_8_y_reg;

    always @(posedge CLK or posedge RST) begin
        if (RST) begin
            x_pow2_reg <= 8'h0;
            y_pow2_reg <= 8'h0;
            sub_8_x_reg <= 16'h0;
            sub_8_y_reg <= 16'h0;
        end else begin
            x_pow2_reg <= x_pow2_com;
            y_pow2_reg <= y_pow2_com;
            sub_8_x_reg <= sub_8_x;
            sub_8_y_reg <= sub_8_y;
        end
    end

    wire signed [15:0] x_pow4_com = x_pow2_reg * x_pow2_reg;
    wire signed [15:0] y_pow4_com = y_pow2_reg * y_pow2_reg;
    wire signed [31:0] x_pow3_com = x_pow2_reg * sub_8_x_reg;
    wire signed [31:0] y_pow3_com = y_pow2_reg * sub_8_y_reg;

    reg signed [15:0] x_pow4_reg;
    reg signed [15:0] y_pow4_reg;
    reg signed [31:0] x_pow3_reg;
    reg signed [31:0] y_pow3_reg;

    always @(posedge CLK or posedge RST) begin
        if (RST) begin
            x_pow4_reg <= 16'h0;
            y_pow4_reg <= 16'h0;
            x_pow3_reg <= 32'h0;
            y_pow3_reg <= 32'h0;
        end else begin
            x_pow4_reg <= x_pow4_com;
            y_pow4_reg <= y_pow4_com;
            x_pow3_reg <= x_pow3_com;
            y_pow3_reg <= y_pow3_com;
        end
    end

    wire signed [27:0] x_pow7_com = x_pow4_reg * x_pow3_reg;
    wire signed [27:0] y_pow7_com = y_pow4_reg * y_pow3_reg;
    wire signed [31:0] x_pow8_com = x_pow4_reg * x_pow4_reg;
    wire signed [31:0] y_pow8_com = y_pow4_reg * y_pow4_reg;


    reg signed [27:0] x_pow7_reg;
    reg signed [27:0] y_pow7_reg;
    reg signed [31:0] x_pow8_reg;
    reg signed [31:0] y_pow8_reg;

    always @(posedge CLK or posedge RST) begin
        if (RST) begin
            x_pow7_reg <= 28'h0;
            y_pow7_reg <= 28'h0;
            x_pow8_reg <= 32'h0;
            y_pow8_reg <= 32'h0;
        end else begin
            x_pow7_reg <= x_pow7_com;
            y_pow7_reg <= y_pow7_com;
            x_pow8_reg <= x_pow8_com;
            y_pow8_reg <= y_pow8_com;
        end
    end

    wire signed [55:0] x_pow14_com = x_pow7_reg * x_pow7_reg;
    wire signed [55:0] y_pow14_com = y_pow7_reg * y_pow7_reg;



    assign p7_x = x_pow7_reg >>> 9;
    assign p7_y = y_pow7_reg >>> 9;

    assign p14_x = x_pow14_com >>> 30;
    assign p14_y = y_pow14_com >>> 30;

    assign p8_x = x_pow8_reg >>> 12;
    assign p8_y = y_pow8_reg >>> 12;
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
    input  [15:0] eta,            
    output reg  [31:0] one_minus_eta2   
);
    wire [31:0] eta2 = eta * eta;

    always @(*) begin
        one_minus_eta2 = 32'h01000000 - eta2;
    end

endmodule