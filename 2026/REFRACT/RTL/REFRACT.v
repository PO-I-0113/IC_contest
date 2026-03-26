//`include "/usr/cad/synopsys/synthesis/2025.06/dw/sim_ver/DW_sqrt.v"
//`include "/usr/cad/synopsys/synthesis/2025.06/dw/sim_ver/DW_sqrt_pipe.v"
//`include "/usr/cad/synopsys/synthesis/2025.06/dw/sim_ver/DW_div.v"
//`include "/usr/cad/synopsys/synthesis/2025.06/dw/sim_ver/DW_div_pipe.v"

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
    wire location_x_en;
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
    FSM fsm(
        .CLK(CLK),
        .RST(RST),
        .location_x_en(location_x_en),
        .div_pipe_done(div_pipe_done),
        .z_height_g_square_en(z_height_g_square_en),
        .k_g_square_en(k_g_square_en),
        .square_done(square_done),
        .square_en(square_en),
        .numerator_en(numerator_en),
        .denominator_en(denominator_en),
        .div_en(div_en),
        .z_location_en(z_location_en),
        .sram_sel(sram_sel),
        .SRAM_WE(SRAM_WE)
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
        .location_x_en(location_x_en),
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

module FSM (
    input        CLK,
    input        RST,
    input        square_done,
    input        div_pipe_done,
    output location_x_en,
    output z_height_g_square_en,
    output k_g_square_en,
    output square_en,
    output numerator_en,
    output denominator_en,
    output div_en,
    output z_location_en,
    output sram_sel,
    output SRAM_WE
);
    localparam IDLE               = 4'b0000;
    localparam RELOAD_LOCATION    = 4'b0001;
    localparam LOOKUP_TABLE       = 4'b0010;
    localparam Z_HEIGHT_G_SQUARE  = 4'b0011;
    localparam K_G_SQUARE         = 4'b0100;
    localparam SQUARE_ROOT_CAL    = 4'b0101;
    localparam DIVITION_PREPARE   = 4'b0110;
    localparam DIVISION_CAL       = 4'b0111;
    localparam Z_LOCATION         = 4'b1000;
    localparam WRITE_SRAM_X       = 4'b1001;
    localparam WRITE_SRAM_Y       = 4'b1010;

    reg   [3:0] cur_state;
    reg   [3:0] next_state;
    always @(posedge CLK or posedge RST) begin
        if (RST) begin
            cur_state <= IDLE;
        end else begin
            cur_state <= next_state;
        end
    end

    always @(*) begin
        case (cur_state)
            IDLE:             next_state = Z_HEIGHT_G_SQUARE;
            RELOAD_LOCATION:  next_state = Z_HEIGHT_G_SQUARE;
            Z_HEIGHT_G_SQUARE:next_state = K_G_SQUARE;
            K_G_SQUARE:       next_state = SQUARE_ROOT_CAL;
            SQUARE_ROOT_CAL:  if (square_done) next_state = DIVITION_PREPARE;
                              else next_state = SQUARE_ROOT_CAL;
            DIVITION_PREPARE: next_state = DIVISION_CAL;
            DIVISION_CAL:     if (div_pipe_done) next_state = Z_LOCATION ;
                              else next_state = DIVISION_CAL;
            Z_LOCATION:       next_state = WRITE_SRAM_X;
            WRITE_SRAM_X:     next_state = WRITE_SRAM_Y;
            WRITE_SRAM_Y:     next_state = RELOAD_LOCATION;
            default:          next_state = IDLE;
        endcase
    end

    assign location_x_en = (cur_state == RELOAD_LOCATION);
    assign z_height_g_square_en = (cur_state == Z_HEIGHT_G_SQUARE);
    assign k_g_square_en = (cur_state == K_G_SQUARE);
    assign square_en = (cur_state == SQUARE_ROOT_CAL);
    assign numerator_en = (cur_state == DIVITION_PREPARE);
    assign denominator_en = (cur_state == DIVITION_PREPARE);
    assign div_en = (cur_state == DIVISION_CAL);
    assign z_location_en = (cur_state == Z_LOCATION);
    assign sram_sel = (cur_state == WRITE_SRAM_X);
    assign SRAM_WE = (cur_state == WRITE_SRAM_X || cur_state == WRITE_SRAM_Y);
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
    
    always @(posedge CLK or posedge RST) begin
        if (RST) begin
            SRAM_A <= 9'b0;
        end else begin
            SRAM_A <= {location_y, location_x, sram_sel};
        end
    end

    assign SRAM_D = (sram_sel) ? zx : zy;
endmodule

module location_counter(
    input        CLK,
    input        RST,
    input        location_x_en,
    output reg [3:0]   location_x,
    output reg [3:0]   location_y,
    output reg         DONE
);
    wire location_y_en;
    assign location_y_en = (location_x == 4'd15 & location_x_en);


    always @(posedge CLK or posedge RST) begin
        if (RST) begin
            DONE <= 1'b0;
        end else if (location_x == 4'd15 && location_y == 4'd15 && location_x_en) begin
            DONE <= 1'b1;
        end
    end

    always @(posedge CLK or posedge RST) begin
        if (RST) begin
            location_x <= 4'b0;
        end else if (location_x_en) begin
            location_x <= location_x + 1;
        end
    end

    always @(posedge CLK or posedge RST) begin
        if (RST) begin
            location_y <= 4'b0;
        end else if (location_y_en) begin
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
        end else if (z_height_g_square_en) begin
            z_height <= {4'd6,12'd0} - p8_x_mul_2 - p8_y_mul_2;
        end
    end
endmodule

module g_square_calculate(
    input        CLK,
    input        RST,
    input  [3:0]  location_x,  
    input  [3:0]  location_y,   
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
        end else if (z_height_g_square_en) begin
            g_square <= p14_x_mul_2 + p14_y_mul_2 + {4'd1,12'd0}; 
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
            k_g_square <= 48'h0;
        end else if (k_g_square_en) begin
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

    always @(posedge CLK or posedge RST) begin
        if (RST) begin
            square_pipe_cnt <= 2'b0;
        end else if (square_en)begin
            square_pipe_cnt <= square_pipe_cnt + 1;
        end
    end

    assign square_done = (square_pipe_cnt == 2'd2);
endmodule


module numerator_calculate(
    input        CLK,
    input        RST,
    input        numerator_en,
    input  [31:0] one_minus_eta2,
    input  [15:0] z_height,
    output reg  [47:0] numerator
);
    wire [47:0] numerator_com;
    always @(posedge CLK or posedge RST) begin
        if (RST) begin
            numerator <= 48'h0;
        end else if (numerator_en) begin
            numerator <= numerator_com;
        end
    end

    assign numerator_com = z_height * one_minus_eta2;
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
        end else if (denominator_en) begin
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
    reg [2:0] div_pipe_cnt;
    assign div_pipe_done = (div_pipe_cnt == 2'd2);
    always @(posedge CLK or posedge RST) begin
        if (RST) begin
            div_pipe_cnt <= 2'b0;
        end else if (div_en) begin
            div_pipe_cnt <= div_pipe_cnt + 1;
        end else begin
            div_pipe_cnt <= div_pipe_cnt;
        end
    end
 
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
    input        z_location_en,
    input  [3:0] location_x,
    input  [3:0] location_y,
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
    always @(posedge CLK or posedge RST) begin
        if (RST) begin
            zx <= 16'h0;
        end else if (z_location_en) begin
            zx <= zx_com[27:12]; 
        end
    end
    always @(posedge CLK or posedge RST) begin
        if (RST) begin
            zy <= 16'h0;
        end else if (z_location_en) begin
            zy <= zy_com[27:12]; 
        end
    end

    assign zx_com = $signed({4'd0,location_x,24'd0}) - ($signed(t_mul_coef) * $signed(p7_x_mul_2));
    assign zy_com = $signed({4'd0,location_y,24'd0}) - ($signed(t_mul_coef) * $signed(p7_y_mul_2));
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

    wire signed [7:0] sub_8_x_square_0 = sub_8_x * sub_8_x;
    wire signed [7:0] sub_8_x_square_1 = sub_8_x * sub_8_x;

    wire signed [15:0] sub_8_x_square_2 = sub_8_x_square_0 * sub_8_x_square_1;
    wire signed [31:0] sub_8_x_square_3 = sub_8_x_square_2 * sub_8_x_square_2;

    wire signed [7:0] sub_8_y_square_0 = sub_8_y * sub_8_y;
    wire signed [7:0] sub_8_y_square_1 = sub_8_y * sub_8_y;

    wire signed [15:0] sub_8_y_square_2 = sub_8_y_square_0 * sub_8_y_square_1;
    wire signed [31:0] sub_8_y_square_3 = sub_8_y_square_2 * sub_8_y_square_2;

    wire signed [27:0] sub_8_x_pow7 = sub_8_x_square_2 * sub_8_x_square_0 * sub_8_x;
    wire signed [27:0] sub_8_y_pow7 = sub_8_y_square_2 * sub_8_y_square_0 * sub_8_y;

    wire signed [55:0] sub_8_x_pow14 = sub_8_x_pow7 * sub_8_x_pow7;
    wire signed [55:0] sub_8_y_pow14 = sub_8_y_pow7 * sub_8_y_pow7;

    assign p7_x = sub_8_x_pow7 >>> 9;
    assign p7_y = sub_8_y_pow7 >>> 9;

    assign p14_x = sub_8_x_pow14 >>> 30;
    assign p14_y = sub_8_y_pow14 >>> 30;

    assign p8_x = sub_8_x_square_3 >>> 12;
    assign p8_y = sub_8_y_square_3 >>> 12;
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