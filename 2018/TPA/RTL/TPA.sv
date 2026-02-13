module TPA(clk, reset_n, SCL, SDA, cfg_req, cfg_rdy, cfg_cmd, cfg_addr, cfg_wdata, cfg_rdata);
input 		clk; 
input 		reset_n;
// Two-Wire Protocol slave interface 
input 		SCL;  
inout		SDA;

// Register Protocal Master interface 
input		cfg_req;
output		cfg_rdy;
input		cfg_cmd;
input	[7:0]	cfg_addr;
input	[15:0]	cfg_wdata;
output	[15:0]  cfg_rdata;

reg	[15:0] Register_Spaces	[0:255];

// ===== Coding your RTL below here ================================= 
reg [4:0] vertor_count ;
reg [7:0] TWP_address;
reg SDA_mine;
reg SDA_flag;
reg [15:0] TWP_read_data;
reg tar2_flag;
reg [2:0]cfg_req_flag;
reg cfg_dominate_flag;
typedef enum reg [2:0] {
	IDLE             = 3'b000,
	WAIT_CMD         = 3'b001,
	WAIT_WRITE       = 3'b010,
	WRITE            = 3'b011,
	WAIT_READ        = 3'b100,
	READ             = 3'b101,
	BUFFER_STATE     = 3'b110,
	TEST             = 3'b111
} state_t_rim;

typedef enum reg [3:0] {
	TWP_IDLE         = 4'b0000,
	TWP_SDA_MODE     = 4'b0001,
	TWP_WRITE_ADDRESS= 4'b0010,
	TWP_READ_ADDRESS = 4'b0011,
	TWP_WRITE        = 4'b0100,
	TWP_READ         = 4'b0101,
	TAR              = 4'b0110,
	TAR_2            = 4'b0111,
	TWS_WRITE_BUFFER = 4'b1000,
	TWS_WRITE        = 4'b1001,
	TWP_READ_SIGNAL  = 4'b1010,
	TWP_WRITE_FROM_REG = 4'b1011,
	TWP_READ_BUFFER  = 4'b1100
} state_t_twp;

state_t_rim cur_state_rim;
state_t_rim next_state_rim;
state_t_twp cur_state_twp;
state_t_twp next_state_twp;


always @(*) 
	case (cur_state_rim)
		IDLE: next_state_rim = WAIT_CMD;
		BUFFER_STATE: next_state_rim = WAIT_CMD;
		WAIT_CMD: if (cfg_req && cfg_cmd) next_state_rim = WAIT_WRITE;
				  else if (cfg_req && !cfg_cmd) next_state_rim = WAIT_READ;
				  else next_state_rim = WAIT_CMD;
		WAIT_WRITE: next_state_rim = WRITE;
		WRITE: next_state_rim = BUFFER_STATE;
		WAIT_READ: next_state_rim = READ;
		READ: next_state_rim = BUFFER_STATE;
		default: next_state_rim = IDLE;
	endcase

always @(*) 
	case (cur_state_twp)
		TWP_IDLE: if (~SDA) next_state_twp = TWP_SDA_MODE; else next_state_twp = TWP_IDLE;
		TWP_SDA_MODE:  if (SDA)next_state_twp = TWP_WRITE_ADDRESS; 
					  //else if (~SDA && (cfg_req_flag == 1)) next_state_twp = TWP_IDLE;
					  else next_state_twp = TWP_READ_ADDRESS;
		TWP_READ_ADDRESS: if (vertor_count == 5'd7) next_state_twp = TAR; else next_state_twp = TWP_READ_ADDRESS;
		TAR: if (SDA) next_state_twp = TWP_READ_SIGNAL; else next_state_twp = TWS_WRITE_BUFFER;
		TAR_2: next_state_twp = TWP_IDLE;
		TWP_READ_SIGNAL: next_state_twp = TWP_READ;
		TWP_WRITE_ADDRESS: if (vertor_count == 5'd7) next_state_twp = TWP_WRITE; else next_state_twp = TWP_WRITE_ADDRESS;
		TWP_WRITE: if (vertor_count == 5'd23) next_state_twp = TWP_IDLE; else next_state_twp = TWP_WRITE;
		TWP_READ: if (vertor_count == 5'd23) next_state_twp = TAR_2; else next_state_twp = TWP_READ;
		TWS_WRITE_BUFFER: next_state_twp = TWS_WRITE;
		TWS_WRITE: next_state_twp = TWP_IDLE;
		default: next_state_twp = TWP_IDLE;
	endcase

always @(posedge clk or negedge reset_n) begin
	if (!reset_n) begin
		cur_state_rim <= IDLE;
	end else begin
		cur_state_rim <= next_state_rim;
    end
end

always @(posedge clk or negedge reset_n) begin
	if (!reset_n) begin
		cur_state_twp <= TWP_IDLE;
	end else begin
		cur_state_twp <= next_state_twp;
    end
end

always @(posedge clk or negedge reset_n) begin
	if (!reset_n) begin
		Register_Spaces <= '{default: 16'h0000};
	end else if (cur_state_rim == WRITE) begin
		Register_Spaces[cfg_addr] <= cfg_wdata;
	end else if (cur_state_rim == READ) begin
		Register_Spaces[cfg_addr] <= Register_Spaces[cfg_addr];
	end else if (cur_state_twp == TWP_WRITE && tar2_flag && cfg_req_flag != 1) begin
		Register_Spaces[TWP_address] <= TWP_read_data;
	end else if (cur_state_twp == TWP_WRITE && cfg_req_flag != 1 && cfg_dominate_flag == 0) begin
		Register_Spaces[TWP_address][vertor_count-8] <= SDA;
	end
end

always @(posedge clk or negedge reset_n) begin
	if (!reset_n) begin
		vertor_count <= 0;
	end else  if (cur_state_twp == TWP_WRITE || cur_state_twp == TWP_WRITE_ADDRESS || cur_state_twp == TWP_READ || cur_state_twp == TWP_READ_ADDRESS) begin
		vertor_count <= vertor_count + 5'b1;
	end else if (cur_state_twp == TWP_READ_SIGNAL) begin
		vertor_count <= vertor_count + 5'b1;
	end else  if (cur_state_twp == TAR) begin
		vertor_count <= vertor_count;
	end else begin
		vertor_count <= 0;
	end
end



always @(posedge clk or negedge reset_n) begin
	if (!reset_n) begin
		TWP_address <= 8'h00;
	end else if (cur_state_twp == TWP_WRITE_ADDRESS) begin
		TWP_address[vertor_count] <= SDA;
	end else if (cur_state_twp == TWP_READ_ADDRESS) begin
		TWP_address[vertor_count] <= SDA;
	end
end

always @(posedge clk or negedge reset_n) begin
	if (!reset_n) begin
		tar2_flag <= 1'b0;
	end else if (cur_state_twp == TWP_WRITE && vertor_count == 5'd23) begin
		tar2_flag <= 1'b0;
	end else if (cur_state_twp == TAR_2) begin
		tar2_flag <= 1'b1;
	end else if (cur_state_twp == TAR) begin
		tar2_flag <= 1'b0;
	end
end
always @(posedge clk or negedge reset_n) begin
	if (!reset_n) begin
		TWP_read_data <= 16'h0000;
	end else if (cur_state_twp == TWP_READ || cur_state_twp == TAR_2) begin
		TWP_read_data[vertor_count-9] <= SDA;
	end
end

always @(posedge clk or negedge reset_n) begin
	if (!reset_n) begin
		SDA_mine <= 1'b0;
	end else if (next_state_twp == TAR) begin
		SDA_mine <= 1'b1;
	end else if (cur_state_twp == TWP_WRITE) begin
		SDA_mine <= Register_Spaces[TWP_address][vertor_count-8];
	end else if (next_state_twp == TWP_READ_SIGNAL) begin
		SDA_mine <= 1'b0;
	end else if (next_state_twp == TWP_READ) begin
		SDA_mine <= Register_Spaces[TWP_address][vertor_count-8];
	end else if (cur_state_twp == TWP_READ) begin
		SDA_mine <= Register_Spaces[TWP_address][vertor_count-8];
	end else if (cur_state_twp == TWS_WRITE) begin
		SDA_mine <= Register_Spaces[TWP_address][vertor_count-8];
	end else if (cur_state_twp == TAR_2) begin
		SDA_mine <= 1'b1;
	end
end


always @(*) begin
	if (cur_state_twp == TAR || cur_state_twp == TWP_READ || cur_state_twp == TWP_READ_SIGNAL || cur_state_twp == TWP_READ_BUFFER || cur_state_twp == TAR_2 || (cur_state_twp == TWP_WRITE && tar2_flag)) begin
		SDA_flag = 1'b1;
	end else begin
		SDA_flag = 1'b0;
	end
end

always @(posedge clk or negedge reset_n) begin
	if (!reset_n) begin
		cfg_req_flag <= 1'b0;
	end else if (cur_state_rim == WAIT_CMD &&  cur_state_twp == TWP_IDLE && cfg_req && SDA == 0 && cfg_rdy == 0)begin
		cfg_req_flag <= 1;	
	end else if (cur_state_rim == WAIT_CMD &&  cur_state_twp == TWP_IDLE && cfg_req && SDA == 1 && cfg_rdy == 0) begin
		cfg_req_flag <= 0;
	end
end

always @(posedge clk or negedge reset_n) begin
	if (!reset_n) begin
		cfg_dominate_flag <= 1'b0;
	end else if (cur_state_rim == WAIT_WRITE &&  cur_state_twp == TWP_WRITE_ADDRESS) begin
		cfg_dominate_flag <= 1'b1;
	end
end



assign SDA = (SDA_flag) ? SDA_mine : 1'bz;

assign cfg_rdy = (cur_state_rim == WAIT_WRITE || cur_state_rim == WRITE || cur_state_rim == READ || cur_state_rim == WAIT_READ) ? 1'b1 : 1'b0;
assign cfg_rdata = (cur_state_rim == READ) ? Register_Spaces[cfg_addr] : 
				   (cur_state_twp == TWP_WRITE) ? Register_Spaces[TWP_address] : 16'h0000;
endmodule



