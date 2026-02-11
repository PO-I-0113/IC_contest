module LCD_CTRL(clk, reset, cmd, cmd_valid, IROM_Q, IROM_rd, IROM_A, IRAM_valid, IRAM_D, IRAM_A, busy, done);
input clk;
input reset;
input [3:0] cmd;
input cmd_valid;
input [7:0] IROM_Q;
output IROM_rd;
output [5:0] IROM_A;
output IRAM_valid;
output reg [7:0] IRAM_D;
output [5:0] IRAM_A;
output reg busy;
output done;


localparam WRITE = 4'b0000;
localparam SHIFT_UP = 4'b0001;
localparam SHIFT_DOWN = 4'b0010;
localparam SHIFT_LEFT = 4'b0011;
localparam SHIFT_RIGHT = 4'b0100;
localparam MAX = 4'b0101;
localparam MIN = 4'b0110;
localparam AVERAGE = 4'b0111;
localparam COUNTERCLOCKWISE_ROTATION = 4'b1000;
localparam CLOCKWISE_ROTATION = 4'b1001;
localparam MIRROR_X = 4'b1010;
localparam MIRROR_Y = 4'b1011;

wire write_enable;
wire [2:0] next_IRAM_row_index;
wire [2:0] next_IRAM_column_index;
wire [5:0] TEMP_IRAM_A;
reg [5:0] pre_IRAM_A;
reg [2:0] IROM_row_index;
reg [2:0] IROM_column_index;
reg [2:0] IRAM_row_index;
reg [2:0] IRAM_column_index;
reg [7:0] rom_data [0:63];
reg [2:0] operation_row_index;
reg [2:0] operation_column_index;

typedef enum reg [2:0] {
    IDLE = 3'b000,
    READ_ROM = 3'b001,
    CMD_PROCESS = 3'b010,
    WRITE_STATE = 3'b011,
    FINISH = 3'b100,
    BUFFER_CYCLE = 3'b101
} state_t;

state_t cur_state;
state_t nxt_state;

wire [9:0] data_sum;
wire [8:0] data_sum_01, data_sum_23;
wire [7:0] data0, data1, data2, data3;

wire [7:0] max_01, max_23, min_01, min_23;

wire [7:0] max_data;
wire [7:0] min_data;
assign data0 = rom_data[{operation_row_index-3'd1, operation_column_index-3'd1}];
assign data1 = rom_data[{operation_row_index-3'd1, operation_column_index}];
assign data2 = rom_data[{operation_row_index, operation_column_index-3'd1}];
assign data3 = rom_data[{operation_row_index, operation_column_index}];

assign data_sum_01 = data0 + data1;
assign data_sum_23 = data2 + data3;
assign data_sum = data_sum_01 + data_sum_23;


assign max_01 = (data0 > data1) ? data0 : data1;
assign max_23 = (data2 > data3) ? data2 : data3;
assign min_01 = (data0 < data1) ? data0 : data1;
assign min_23 = (data2 < data3) ? data2 : data3;


assign max_data = (max_01 > max_23) ? max_01 : max_23;
assign min_data = (min_01 < min_23) ? min_01 : min_23;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        operation_row_index <= 0;
    end else if (cur_state == READ_ROM) begin
        operation_row_index <= 3'd4;
    end else if (cmd == SHIFT_UP && cmd_valid && operation_row_index>3'b1) begin
        operation_row_index <= operation_row_index - 1;
    end else if (cmd == SHIFT_DOWN && cmd_valid && operation_row_index<3'd7) begin
        operation_row_index <= operation_row_index + 1;
    end
end

always @(posedge clk or posedge reset) begin
    if (reset) begin
        operation_column_index <= 0;
    end else if (cur_state == READ_ROM) begin
        operation_column_index <= 3'd4;
    end else if (cmd == SHIFT_LEFT && cmd_valid && operation_column_index>3'b1) begin
        operation_column_index <= operation_column_index - 1;
    end else if (cmd == SHIFT_RIGHT && cmd_valid && operation_column_index<3'd7) begin
        operation_column_index <= operation_column_index + 1;
    end
end

always @(posedge clk or posedge reset) begin
    if (reset) begin
        IROM_row_index <= 0;
    end else if (IROM_column_index == 7) begin
        IROM_row_index <= IROM_row_index + 1;
    end
end

always @(posedge clk or posedge reset) begin
    if (reset) begin
        IROM_column_index <= 0;
    end else if (IROM_column_index == 7) begin
        IROM_column_index <= 0;
    end else if (IROM_rd) begin
        IROM_column_index <= IROM_column_index + 1;
    end
end


assign next_IRAM_column_index = (IRAM_column_index == 7) ? 0 : IRAM_column_index + 3'd1;
assign next_IRAM_row_index = (IRAM_column_index == 7) ? IRAM_row_index + 3'd1 : IRAM_row_index;


always @(posedge clk or posedge reset) begin
    if (reset) begin
        pre_IRAM_A <= 0;
    end else if (write_enable) begin
        pre_IRAM_A <= TEMP_IRAM_A;
    end
end
always @(posedge clk or posedge reset) begin
    if (reset) begin
        IRAM_row_index <= 0;
    end else if (IRAM_column_index == 7) begin
        IRAM_row_index <= next_IRAM_row_index;
    end
end

always @(posedge clk or posedge reset) begin
    if (reset) begin
        IRAM_column_index <= 0;
    end else if (IRAM_column_index == 7) begin
        IRAM_column_index <= 0;
    end else if (write_enable) begin
        IRAM_column_index <= next_IRAM_column_index;
    end
end

always @(posedge clk or posedge reset) begin
    if (reset) begin
        IRAM_D <= 0;
    end else if (write_enable) begin
        IRAM_D <= rom_data[TEMP_IRAM_A];
    end
end

always @(posedge clk or posedge reset) begin
    if (reset) begin
        for (int i = 0; i < 64; i++) begin
            rom_data[i] <= 0;
        end
    end else if (IROM_rd) begin
        rom_data[IROM_A] <= IROM_Q;
    end else if (cmd == MAX && cmd_valid) begin
        rom_data[{operation_row_index, operation_column_index}] <= max_data;
        rom_data[{operation_row_index, operation_column_index-3'd1}] <= max_data;
        rom_data[{operation_row_index-3'd1, operation_column_index}] <= max_data;
        rom_data[{operation_row_index-3'd1, operation_column_index-3'd1}] <= max_data;
    end else if (cmd == MIN && cmd_valid) begin
        rom_data[{operation_row_index, operation_column_index}] <= min_data;
        rom_data[{operation_row_index, operation_column_index-3'd1}] <= min_data;
        rom_data[{operation_row_index-3'd1, operation_column_index}] <= min_data;
        rom_data[{operation_row_index-3'd1, operation_column_index-3'd1}] <= min_data;
    end else if (cmd == AVERAGE && cmd_valid) begin
        rom_data[{operation_row_index, operation_column_index}] <= data_sum [9:2];
        rom_data[{operation_row_index, operation_column_index-3'd1}] <= data_sum [9:2];
        rom_data[{operation_row_index-3'd1, operation_column_index}] <= data_sum [9:2];
        rom_data[{operation_row_index-3'd1, operation_column_index-3'd1}] <= data_sum [9:2];
    end else if (cmd == COUNTERCLOCKWISE_ROTATION && cmd_valid) begin
        rom_data[{operation_row_index, operation_column_index}] <= data2;
        rom_data[{operation_row_index, operation_column_index-3'd1}] <= data0;
        rom_data[{operation_row_index-3'd1, operation_column_index-3'd1}] <= data1;
        rom_data[{operation_row_index-3'd1, operation_column_index}] <= data3;
    end else if (cmd == CLOCKWISE_ROTATION && cmd_valid) begin
        rom_data[{operation_row_index, operation_column_index}] <= data1;
        rom_data[{operation_row_index-3'd1, operation_column_index}] <= data0;
        rom_data[{operation_row_index-3'd1, operation_column_index-3'd1}] <= data2;
        rom_data[{operation_row_index, operation_column_index-3'd1}] <= data3;
    end else if (cmd == MIRROR_X && cmd_valid) begin
        rom_data[{operation_row_index, operation_column_index}] <= data1;
        rom_data[{operation_row_index-3'd1, operation_column_index}] <= data3;
        rom_data[{operation_row_index, operation_column_index-3'd1}] <= data0;
        rom_data[{operation_row_index-3'd1, operation_column_index-3'd1}] <= data2;
    end else if (cmd == MIRROR_Y && cmd_valid) begin
        rom_data[{operation_row_index, operation_column_index}] <= data2;
        rom_data[{operation_row_index, operation_column_index-3'd1}] <= data3;
        rom_data[{operation_row_index-3'd1, operation_column_index}] <= data0;
        rom_data[{operation_row_index-3'd1, operation_column_index-3'd1}] <= data1;
    end
end



always @(posedge clk or posedge reset) begin
    if (reset) begin
        cur_state <= IDLE;
    end else begin
        cur_state <= nxt_state;
    end
end

always @(*) begin
    case (cur_state)
        IDLE : nxt_state = READ_ROM;
        READ_ROM: begin
            if (IROM_A == 63) begin
                nxt_state = CMD_PROCESS;
            end else begin
                nxt_state = READ_ROM;
            end
        end
        CMD_PROCESS:if (cmd == WRITE) nxt_state = BUFFER_CYCLE;
                    else nxt_state = CMD_PROCESS;
        BUFFER_CYCLE: nxt_state = WRITE_STATE;
        WRITE_STATE: begin
            if (pre_IRAM_A == 63) begin
                nxt_state = FINISH;
            end else begin
                nxt_state = WRITE_STATE;
            end
        end
        FINISH: begin
            nxt_state = FINISH;
        end
        default: nxt_state = IDLE;
    endcase
end


assign busy = (cur_state == CMD_PROCESS) ? 0 : 1;
assign write_enable = (cur_state == BUFFER_CYCLE || cur_state == WRITE_STATE);
assign IRAM_valid = (cur_state == WRITE_STATE);
assign done = (cur_state == FINISH);
assign IROM_rd = (cur_state == READ_ROM);
assign IROM_A = {IROM_row_index, IROM_column_index};

assign TEMP_IRAM_A = {IRAM_row_index, IRAM_column_index};
assign IRAM_A = pre_IRAM_A;
endmodule



