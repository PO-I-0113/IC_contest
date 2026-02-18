`define PREPARE 0
`define CALCULATE 1
`define WAIT_CNT 2
`define CNT_OUT 3
`define SORT 4
`define GROUP 5
`define MASK 6
`define CODING 7
`define MASK_OUT 8
`define WAIT_HC_M 9
`define OUTPUT_CHECK 10
module huffman(clk, reset, gray_valid, gray_data, CNT_valid, CNT, code_valid, HC, M
, test_se, test_si, test_so
);

	input clk;	
	input reset;
	input gray_valid;
	input [2:0] gray_data;
	
	input  test_se,test_si;
	output test_so;

	output CNT_valid;
	output code_valid;
	output [6:0] CNT;
	output [4:0] HC;
	output [4:0] M;


	// total 28pins
	wire [3:0] cur_state , next_state;
	wire [2:0] sort_count;
	wire [2:0] serial_count;
	wire [2:0] sorted_index1,sorted_index2,sorted_index3,sorted_index4,sorted_index5,sorted_index6;
	wire [1:0] sum_pointer;
	wire [4:0] code_1, code_2, code_3, code_4, code_5, code_6;
	wire [2:0] stage_counter;
	wire [6:0] CNT1, CNT2, CNT3, CNT4, CNT5, CNT6;
	wire [4:0] HC1, HC2, HC3, HC4, HC5, HC6;
	wire [4:0] M1, M2, M3, M4, M5, M6;

	wire i_clk, i_reset, i_gray_valid, i_test_se, i_test_si;
	wire [2:0]i_gray_data;
	wire type_change_CNT_valid;
	wire type_change_code_valid;
	reg i_CNT_valid, i_code_valid;
	reg i_test_so;
	reg [6:0] i_CNT;
	reg [4:0] i_HC, i_M;
	always @(*)begin
		i_CNT_valid = type_change_CNT_valid;
		i_code_valid = type_change_code_valid;
	end

	always @(*) begin
		case(serial_count)
			3'd0: i_CNT = CNT1;
			3'd1: i_CNT = CNT2;
			3'd2: i_CNT = CNT3;
			3'd3: i_CNT = CNT4;
			3'd4: i_CNT = CNT5;
			3'd5: i_CNT = CNT6;
			default: i_CNT = 7'd0;
		endcase
	end
	always @(*) begin
		case(serial_count)
			3'd0: i_HC = HC1;
			3'd1: i_HC = HC2;
			3'd2: i_HC = HC3;
			3'd3: i_HC = HC4;
			3'd4: i_HC = HC5;
			3'd5: i_HC = HC6;
			default: i_HC = 5'd0;
		endcase
	end
	always @(*) begin
		case(serial_count)
			3'd0: i_M = M1;
			3'd1: i_M = M2;
			3'd2: i_M = M3;
			3'd3: i_M = M4;
			3'd4: i_M = M5;
			3'd5: i_M = M6;
			default: i_M = 5'd0;
		endcase
	end

	XMD ipad_CLK				(.I(clk), .O(i_clk));
	XMD ipad_RESET				(.I(reset), .O(i_reset));
	XMD ipad_GRAY_VALID			(.I(gray_valid), .O(i_gray_valid));
	XMD ipad_GRAY_DATA0			(.I(gray_data[0]), .O(i_gray_data[0]));
	XMD ipad_GRAY_DATA1			(.I(gray_data[1]), .O(i_gray_data[1]));
	XMD ipad_GRAY_DATA2			(.I(gray_data[2]), .O(i_gray_data[2]));
	XMD ipad_TEST_SE			(.I(test_se), .O(i_test_se));
	XMD ipad_TEST_SI			(.I(test_si), .O(i_test_si));
	YA2GSD	opad_TEST_SO		(.I(i_test_so), .O(test_so), .E(1'b1));
	
	YA2GSD	opad_CNT_VALID		(.I(i_CNT_valid), .O(CNT_valid), .E(1'b1));
	YA2GSD	opad_CODE_VALID		(.I(i_code_valid), .O(code_valid), .E(1'b1));
	YA2GSD	opad_CNT0			(.I(i_CNT[0]), .O(CNT[0]), .E(1'b1));
	YA2GSD	opad_CNT1			(.I(i_CNT[1]), .O(CNT[1]), .E(1'b1));
	YA2GSD	opad_CNT2			(.I(i_CNT[2]), .O(CNT[2]), .E(1'b1));
	YA2GSD	opad_CNT3			(.I(i_CNT[3]), .O(CNT[3]), .E(1'b1));
	YA2GSD	opad_CNT4			(.I(i_CNT[4]), .O(CNT[4]), .E(1'b1));
	YA2GSD	opad_CNT5			(.I(i_CNT[5]), .O(CNT[5]), .E(1'b1));
	YA2GSD	opad_CNT6			(.I(i_CNT[6]), .O(CNT[6]), .E(1'b1));
	YA2GSD	opad_HC0			(.I(i_HC[0]), .O(HC[0]), .E(1'b1));
	YA2GSD	opad_HC1			(.I(i_HC[1]), .O(HC[1]), .E(1'b1));
	YA2GSD	opad_HC2			(.I(i_HC[2]), .O(HC[2]), .E(1'b1));
	YA2GSD	opad_HC3			(.I(i_HC[3]), .O(HC[3]), .E(1'b1));
	YA2GSD	opad_HC4			(.I(i_HC[4]), .O(HC[4]), .E(1'b1));
	YA2GSD	opad_M0				(.I(i_M[0]), .O(M[0]), .E(1'b1));
	YA2GSD	opad_M1				(.I(i_M[1]), .O(M[1]), .E(1'b1));
	YA2GSD	opad_M2				(.I(i_M[2]), .O(M[2]), .E(1'b1));
	YA2GSD	opad_M3				(.I(i_M[3]), .O(M[3]), .E(1'b1));
	YA2GSD	opad_M4				(.I(i_M[4]), .O(M[4]), .E(1'b1));

	serial_counter serial_counter(
		.clk(i_clk),
		.reset(i_reset),
		.cur_state(cur_state),
		.next_state(next_state),
		.serial_count(serial_count));
 	FSM_control FSM1 (
		.clk(i_clk), 
		.reset(i_reset), 
		.gray_valid(i_gray_valid),
		.sort_count(sort_count), 
		.CNT_valid(type_change_CNT_valid),
		.code_valid(type_change_code_valid), 
		.cur_state(cur_state), 
		.next_state(next_state),
		.stage_counter(stage_counter),
		.serial_count(serial_count));
		
	calculate cnt(
		.clk(i_clk),
		.reset(i_reset),
		.gray_data(i_gray_data),
		.gray_valid(i_gray_valid),
		.C1(CNT1),
		.C2(CNT2),
		.C3(CNT3),
		.C4(CNT4),
		.C5(CNT5),
		.C6(CNT6));
					
	sort_count 	sort_counter(
		.clk(i_clk),
		.reset(i_reset),
		.cur_state(cur_state), 
		.sort_count(sort_count));
	
	point 	pointer(
		.clk(i_clk), 
		.reset(i_reset),
		.sort_count(sort_count),
		.cur_state(cur_state),
		.sum_pointer(sum_pointer));
	
	sort sorter(
		.clk(i_clk), 
		.reset(i_reset),
		.sort_count(sort_count),
		.cur_state(cur_state),
		.CNT1(CNT1),
		.CNT2(CNT2),
		.CNT3(CNT3), 
		.CNT4(CNT4), 
		.CNT5(CNT5), 
		.CNT6(CNT6), 
		.sum_pointer(sum_pointer),
		.sorted_index1(sorted_index1), 
		.sorted_index2(sorted_index2), 
		.sorted_index3(sorted_index3), 
		.sorted_index4(sorted_index4), 
		.sorted_index5(sorted_index5), 
		.sorted_index6(sorted_index6));
						
	group_devide group_devider(
		.clk(i_clk), 
		.reset(i_reset), 
		.cur_state(cur_state),
		.next_state(next_state),
		.sorted_index1(sorted_index1), 
		.sorted_index2(sorted_index2), 
		.sorted_index3(sorted_index3), 
		.sorted_index4(sorted_index4), 
		.sorted_index5(sorted_index5), 
		.sorted_index6(sorted_index6),
		.stage_counter(stage_counter),
		.mask_1(M1), 
		.mask_2(M2), 
		.mask_3(M3), 
		.mask_4(M4), 
		.mask_5(M5), 
		.mask_6(M6),
		.code_1(HC1), 
		.code_2(HC2), 
		.code_3(HC3), 
		.code_4(HC4), 
		.code_5(HC5), 
		.code_6(HC6));

endmodule
//=================================================================//
module FSM_control(clk, reset, gray_valid, sort_count, serial_count, CNT_valid, code_valid, cur_state, next_state, stage_counter);
	
	input clk;
	input reset;
	input gray_valid;
	input [2:0]sort_count;
	input [2:0]serial_count;
	output CNT_valid;
	output code_valid;	
	output reg [3:0] cur_state , next_state;
	output reg [2:0] stage_counter;
	always @(posedge clk or posedge reset)
		if (reset)
			cur_state <= `PREPARE;
		else
			cur_state <= next_state;
			
	always @(posedge clk or posedge reset)
		if (reset)
			stage_counter <=3'b0;
		else if (next_state==`MASK||next_state==`MASK_OUT)
			stage_counter <= stage_counter+1;
	
	assign CNT_valid = (cur_state ==`CNT_OUT)?1'b1:1'b0;
	assign code_valid= (cur_state ==`OUTPUT_CHECK)?1'b1:1'b0;
	
	
	always @(*) begin
		case (cur_state)
			`PREPARE  	: next_state = (gray_valid)?`CALCULATE:cur_state;
			
			`CALCULATE	: next_state = (!gray_valid)?`WAIT_CNT:cur_state;

			`WAIT_CNT	: next_state = (serial_count==3'd5)?`CNT_OUT:`WAIT_CNT;//delay CNT_Valid

			`CNT_OUT	: next_state = `SORT;
						  
			`SORT		: next_state = (sort_count==3'd6)?`MASK:cur_state;
						  
			`MASK		: next_state = `CODING;
			
			`CODING 	: next_state = (stage_counter==3'd5)?`MASK_OUT:`GROUP;
			
			`GROUP		: next_state = `SORT;
			
			`MASK_OUT   : next_state = `WAIT_HC_M;

			`WAIT_HC_M	: next_state = (serial_count==3'd5)?`OUTPUT_CHECK:`WAIT_HC_M;//delay CNT_Valid

			`OUTPUT_CHECK:next_state = `OUTPUT_CHECK;

			default		: next_state = cur_state;
				
		endcase
	end
endmodule
//=================================================================//	
module serial_counter(clk, reset, cur_state, next_state, serial_count);
	input clk;
	input reset;
	input [3:0] cur_state;
	input [3:0] next_state;
	
	output reg [2:0]serial_count;

	always @(posedge clk or posedge reset) begin
		if (reset)begin
			serial_count <= 3'd0;
		end
		else if(cur_state==`WAIT_CNT&&next_state==`WAIT_CNT)begin
			serial_count <= serial_count + 1'd1;
		end
		else if(cur_state==`WAIT_HC_M&&next_state==`WAIT_HC_M)begin
			serial_count <= serial_count + 1'd1;
		end
		else
			serial_count <= 3'd0;
	end
endmodule
//=================================================================//	
module calculate(clk, reset, gray_data, gray_valid, C1, C2, C3, C4, C5, C6); //let adder combine into 1 
	input clk;
	input reset;
	input gray_valid;
	input [2:0] gray_data;
	output reg [6:0]C1, C2, C3, C4, C5, C6; 
	always @ (posedge clk or posedge reset)begin
		if (reset)begin
			C1<= 7'b0; 
			C2<= 7'b0; 
			C3<= 7'b0; 
			C4<= 7'b0; 
			C5<= 7'b0;
			C6<= 7'b0;
		end
		else if (gray_valid)begin
			case (gray_data[2:0])
				3'b001:C1<=C1+1;
				3'b010:C2<=C2+1;
				3'b011:C3<=C3+1;
				3'b100:C4<=C4+1;
				3'b101:C5<=C5+1;
				3'b110:C6<=C6+1;
			default:;
			endcase
		end
	end
endmodule
//=================================================================//	

module sort_count (clk, reset, cur_state, sort_count);
	input clk;
	input reset;
	input [3:0] cur_state;
	
	output reg  [2:0]sort_count;

	always @(posedge clk or posedge reset)
		if (reset)
			sort_count <= 3'b0;
		else if ((cur_state == `SORT)&(sort_count!=6))
			sort_count <= sort_count + 1'b1;
		else
			sort_count <= 3'b0 ;
endmodule
//=================================================================//	
module point(clk, reset, sort_count, cur_state, sum_pointer);
		input clk;
		input reset;
		input [2:0] sort_count;
		input [3:0] cur_state;
		output reg [1:0]sum_pointer;
		always @(posedge clk or posedge reset)
			if (reset)
				sum_pointer <= 2'd0;
			else if (cur_state == `PREPARE)begin
				sum_pointer <= 2'd3;
			end
			else if (cur_state == `SORT)begin
				if(sort_count==3'd6)
					sum_pointer <= sum_pointer-1'b1;		
			end
endmodule				
//=================================================================//	

module sort(clk, reset, sort_count, cur_state, CNT1, CNT2, CNT3, CNT4, CNT5, CNT6,sum_pointer,
			sorted_index1, sorted_index2, sorted_index3, sorted_index4, sorted_index5, sorted_index6); //think when to activate and shut down
	
	input clk;
	input reset;
	input [2:0]	sort_count;
	input [3:0] cur_state;
	input [6:0] CNT1, CNT2, CNT3, CNT4, CNT5, CNT6;
	input [1:0] sum_pointer;
	wire[7:0] sorted_data1, sorted_data2, sorted_data3, sorted_data4, sorted_data5, sorted_data6 ;
	output[2:0] sorted_index1, sorted_index2, sorted_index3, sorted_index4, sorted_index5, sorted_index6;
	reg [6:0] sorted_data [5:0];
	reg [2:0] sorted_index[5:0];
	
	always @(posedge clk or posedge reset)
		if (reset)begin
			sorted_data[0] <= 7'b0 ;
			sorted_data[1] <= 7'b0 ;
			sorted_data[2] <= 7'b0 ;
			sorted_data[3] <= 7'b0 ;
			sorted_data[4] <= 7'b0 ;
			sorted_data[5] <= 7'b0 ;
			
			sorted_index[0] <= 3'd0 ;
			sorted_index[1] <= 3'd0 ;
			sorted_index[2] <= 3'd0 ;
			sorted_index[3] <= 3'd0 ;
			sorted_index[4] <= 3'd0 ;
			sorted_index[5] <= 3'd0 ;
		end
		else begin
			case (cur_state)
			`PREPARE:begin
				sorted_index[0] <= 3'd1 ;
				sorted_index[1] <= 3'd2 ;
				sorted_index[2] <= 3'd3 ;
				sorted_index[3] <= 3'd4 ;
				sorted_index[4] <= 3'd5 ;
				sorted_index[5] <= 3'd6 ;
			end
			`CNT_OUT:begin
				sorted_data[0] <= CNT1[6:0];
				sorted_data[1] <= CNT2[6:0];
				sorted_data[2] <= CNT3[6:0];
				sorted_data[3] <= CNT4[6:0];
				sorted_data[4] <= CNT5[6:0];
				sorted_data[5] <= CNT6[6:0];
			end
			`SORT:begin
				if (sort_count==3'd0 || sort_count==3'd2 || sort_count==3'd4)begin
					if(sorted_data[1]>sorted_data[0])begin
						sorted_data[1] <= sorted_data[0]; 
						sorted_data[0] <= sorted_data[1];
						sorted_index[1]<= sorted_index[0];
						sorted_index[0]<= sorted_index[1];
					end
					if(sorted_data[3]>sorted_data[2])begin
						sorted_data[3] <= sorted_data[2]; 
						sorted_data[2] <= sorted_data[3];
						sorted_index[3]<= sorted_index[2];
						sorted_index[2]<= sorted_index[3];
					end
					if(sorted_data[5]>sorted_data[4])begin
						sorted_data[5] <= sorted_data[4]; 
						sorted_data[4] <= sorted_data[5];
						sorted_index[5]<= sorted_index[4];
						sorted_index[4]<= sorted_index[5];
					end
				end
				else if (sort_count==3'd1 || sort_count==3'd3 || sort_count == 3'd5)begin
					if(sorted_data[2]>sorted_data[1])begin
						sorted_data[2] <= sorted_data[1]; 
						sorted_data[1] <= sorted_data[2];
						sorted_index[2]<= sorted_index[1];
						sorted_index[1]<= sorted_index[2];
					end
					if(sorted_data[4]>sorted_data[3])begin
						sorted_data[4] <= sorted_data[3]; 
						sorted_data[3] <= sorted_data[4];
						sorted_index[4]<= sorted_index[3];
						sorted_index[3]<= sorted_index[4];
					end
				end
				else if (sort_count==3'd6)
					sorted_data[sum_pointer+1] <= sorted_data[sum_pointer+2]+sorted_data[sum_pointer+1];
			end
			endcase
		end
			assign sorted_data1 = sorted_data[0];
			assign sorted_data2 = sorted_data[1];
			assign sorted_data3 = sorted_data[2];
			assign sorted_data4 = sorted_data[3];
			assign sorted_data5 = sorted_data[4];
			assign sorted_data6 = sorted_data[5];
			assign sorted_index1= sorted_index[0];
			assign sorted_index2= sorted_index[1];
			assign sorted_index3= sorted_index[2];
			assign sorted_index4= sorted_index[3];
			assign sorted_index5= sorted_index[4];
			assign sorted_index6= sorted_index[5];
endmodule
//////////////////////////////////////////////////////////////////////
module group_devide (clk ,reset, cur_state, next_state, sorted_index1, sorted_index2, sorted_index3, sorted_index4, sorted_index5, sorted_index6, stage_counter,
					mask_1, mask_2, mask_3, mask_4, mask_5, mask_6,
					code_1, code_2, code_3, code_4, code_5, code_6);

	input clk;
	input reset;
	input [3:0]cur_state;
	input [3:0]next_state;
	input [2:0]sorted_index1;
	input [2:0]sorted_index2;
	input [2:0]sorted_index3;
	input [2:0]sorted_index4;
	input [2:0]sorted_index5;
	input [2:0]sorted_index6;
	input [2:0]stage_counter;

	output  reg [4:0] mask_1, mask_2, mask_3, mask_4, mask_5, mask_6;
	output  [4:0] code_1, code_2, code_3, code_4, code_5, code_6;
	
	reg [2:0] grouping_a, grouping_b;
	reg [5:1] code[6:1];
	reg [2:0] code_len[6:1];
	reg [2:0] group_id[6:1];
	integer i;

	assign code_1 = code[1];
	assign code_2 = code[2];
	assign code_3 = code[3];
	assign code_4 = code[4];
	assign code_5 = code[5];
	assign code_6 = code[6]; 

	
	always @(*) //grouping_a 
	begin
		case (stage_counter)
			3'd1: grouping_a = group_id[sorted_index5];
			3'd2: grouping_a = group_id[sorted_index4];
			3'd3: grouping_a = group_id[sorted_index3];
			3'd4: grouping_a = group_id[sorted_index2];
			3'd5: grouping_a = group_id[sorted_index1];
			default:grouping_a = 3'b0;
		endcase
	end
	always @(*)
	begin
		case (stage_counter)
			3'd1: grouping_b = group_id[sorted_index6];
			3'd2: grouping_b = group_id[sorted_index5];
			3'd3: grouping_b = group_id[sorted_index4];
			3'd4: grouping_b = group_id[sorted_index3];
			3'd5: grouping_b = group_id[sorted_index2];
			default: grouping_b = 3'b0;
		endcase
	end
	
	always @(posedge clk or posedge reset)
		if (reset)begin
			mask_1 = 5'b0;
		end
		else if(cur_state == `MASK_OUT)begin
			case(code_len[1])
				3'd1: mask_1 = 5'b00001;
				3'd2: mask_1 = 5'b00011;
				3'd3: mask_1 = 5'b00111;
				3'd4: mask_1 = 5'b01111;
				3'd5: mask_1 = 5'b11111;
				3'd6: mask_1 = 5'b11111;
				3'd7: mask_1 = 5'b11111;
				default:mask_1 =5'b0;
			endcase
		end
		else if (next_state == `OUTPUT_CHECK)begin
			mask_1 =5'b0;
		end
	always @(posedge clk or posedge reset)
		if (reset)begin
			mask_2 = 5'b0;
		end
		else if(cur_state == `MASK_OUT)begin
			case(code_len[2])
				3'd1: mask_2 = 5'b00001;
				3'd2: mask_2 = 5'b00011;
				3'd3: mask_2 = 5'b00111;
				3'd4: mask_2 = 5'b01111;
				3'd5: mask_2 = 5'b11111;
				3'd6: mask_2 = 5'b11111;
				3'd7: mask_2 = 5'b11111;
				default:mask_2 =5'b0;
			endcase
		end
		else if (next_state == `OUTPUT_CHECK)begin
			mask_2 =5'b0;
		end
	always @(posedge clk or posedge reset)
		if (reset)begin
			mask_3 = 5'b0;
		end
		else if(cur_state == `MASK_OUT)begin
			case(code_len[3])
				3'd1: mask_3 = 5'b00001;
				3'd2: mask_3 = 5'b00011;
				3'd3: mask_3 = 5'b00111;
				3'd4: mask_3 = 5'b01111;
				3'd5: mask_3 = 5'b11111;
				3'd6: mask_3 = 5'b11111;
				3'd7: mask_3 = 5'b11111;
				default:mask_3 =5'b0;
			endcase
		end
		else if (next_state == `OUTPUT_CHECK)begin
			mask_3 =5'b0;
		end
	always @(posedge clk or posedge reset)
		if (reset)begin
			mask_4 = 5'b0;
		end
		else if(cur_state == `MASK_OUT)begin
			case(code_len[4])
				3'd1: mask_4 = 5'b00001;
				3'd2: mask_4 = 5'b00011;
				3'd3: mask_4 = 5'b00111;
				3'd4: mask_4 = 5'b01111;
				3'd5: mask_4 = 5'b11111;
				3'd6: mask_4 = 5'b11111;
				3'd7: mask_4 = 5'b11111;
				default:mask_4 =5'b0;
			endcase
		end
		else if (next_state == `OUTPUT_CHECK)begin
			mask_4 =5'b0;
		end
	always @(posedge clk or posedge reset)
		if (reset)begin
			mask_5 = 5'b0;
		end
		else if(cur_state == `MASK_OUT)begin
			case(code_len[5])
				3'd1: mask_5 = 5'b00001;
				3'd2: mask_5 = 5'b00011;
				3'd3: mask_5 = 5'b00111;
				3'd4: mask_5 = 5'b01111;
				3'd5: mask_5 = 5'b11111;
				3'd6: mask_5 = 5'b11111;
				3'd7: mask_5 = 5'b11111;
				default:mask_5 =5'b0;
			endcase
		end
		else if (next_state == `OUTPUT_CHECK)begin
			mask_5 =5'b0;
		end
	always @(posedge clk or posedge reset)
		if (reset)begin
			mask_6 = 5'b0;
		end
		else if(cur_state == `MASK_OUT)begin
			case(code_len[6])
				3'd1: mask_6 = 5'b00001;
				3'd2: mask_6 = 5'b00011;
				3'd3: mask_6 = 5'b00111;
				3'd4: mask_6 = 5'b01111;
				3'd5: mask_6 = 5'b11111;
				3'd6: mask_6 = 5'b11111;
				3'd7: mask_6 = 5'b11111;
				default:mask_6 =5'b0;
			endcase
		end
		else if (next_state == `OUTPUT_CHECK)begin
			mask_6 = 5'b0;
		end
		
	always @(posedge clk or posedge reset)//6400
		if (reset)begin
			for (i = 1; i <= 6; i = i + 1) begin
				code_len[i] <= 0;
			end
		end
		else begin
			case (cur_state)
				`MASK:begin
					for (i = 1; i <= 6; i = i + 1) begin
						if (group_id[i] == grouping_a || group_id[i] == grouping_b) begin
							code_len[i] <= code_len[i] + 1;
						end
					end
				end
			endcase
		end		
		
	always @(posedge clk or posedge reset)//2200
		if (reset)begin
			for (i = 1; i <= 6; i = i + 1) begin
				code[i] <= 5'b0;
			end
		end
		else begin
			case(cur_state)
				`CODING:begin
					for (i = 1; i <= 6; i = i + 1) begin
						if (group_id[i] == grouping_b)
							code[i][code_len[i]] <= 1'b1;
						else if (group_id[i] == grouping_a)
							code[i][code_len[i]] <= 1'b0;
					end
				end
				`WAIT_HC_M:begin
					if (next_state == `OUTPUT_CHECK)
						for (i = 1; i <= 6; i = i + 1)
							code[i] <= 5'b0;
					else
						for (i = 1; i <= 6; i = i + 1)
							code[i] <= code[i];
				end
				default:for (i = 1; i <= 6; i = i + 1) code[i]<= code[i] ;
			endcase
		end
	always @(posedge clk or posedge reset)//group_id_change//2000
		if (reset)begin
			for (i = 1 ; i <= 6 ; i = i + 1)begin
				group_id[i]<=0;
			end
		end
		else begin
			case(cur_state)//area same with un_floded if else
				`PREPARE:begin
					for (i = 1 ; i <= 6 ; i = i + 1)begin
						group_id[i]<=i;
					end
				end
				`GROUP:begin
					for (i = 1; i <= 6; i = i + 1) begin
						if (group_id[i] == grouping_a || group_id[i] == grouping_b)
							group_id[i] <= grouping_b;
					end
				end
				default:;
			endcase
		end
endmodule
