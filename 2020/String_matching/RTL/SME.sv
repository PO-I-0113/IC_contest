`define FIND_FIRST 8'h5E
`define FIND_LAST 8'h24
`define FIND_ANY 8'h2E
`define STAR 8'h2A
`define SPACE 8'h20
module SME(clk,reset,chardata,isstring,ispattern,valid,match,match_index);
input clk;
input reset;
input [7:0] chardata;
input isstring;
input ispattern;
output match;
output [4:0] match_index;
output valid;
// reg match;
// reg [4:0] match_index;
// reg valid;
wire match_enable;
wire [7:0] string_buffer [0:31];
wire [7:0] pattern_buffer [0:7];
wire [4:0] read_string_count;
wire [2:0] read_pattern_count;
wire rst_read_count;
wire valid;
FSM fsm(.clk(clk),
        .reset(reset),
        .isstring(isstring),
        .ispattern(ispattern),
        .match_enable(match_enable),
        .rst_read_count(rst_read_count));
read_chardata read_chardata(.clk(clk),
        .reset(reset),
        .isstring(isstring),
        .ispattern(ispattern),
        .chardata(chardata),
        .string_buffer(string_buffer),
        .pattern_buffer(pattern_buffer),
        .read_string_count(read_string_count),
        .read_pattern_count(read_pattern_count),
        .rst_read_count(rst_read_count));
match_controller match_controller(.clk(clk),
        .reset(reset),
        .isstring(isstring),
        .ispattern(ispattern),
        .string_buffer(string_buffer),
        .pattern_buffer(pattern_buffer),
        .read_string_count(read_string_count),
        .read_pattern_count(read_pattern_count),
        .match_enable(match_enable),
        .match(match),
        .match_index(match_index),
        .valid(valid));
endmodule

module FSM(
    input clk,
    input reset,
    input isstring,
    input ispattern,
    output match_enable,
    output rst_read_count
);

typedef enum reg [2:0] {
    IDLE = 0,
    READ_STRING = 1,
    READ_PATTERN = 2,
    MATCH = 3,
    FINISH = 4
} state_t;

    state_t cur_state;
    state_t next_state;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            cur_state <= IDLE;
        end
        else begin
            cur_state <= next_state;
        end
    end
    always @(*) begin
        case (cur_state)
            IDLE: begin
                if (isstring) begin
                    next_state = READ_STRING;
                end
                else begin
                    next_state = IDLE;
                end
            end
            READ_STRING: begin
                if (ispattern) begin
                    next_state = READ_PATTERN;
                end
                else begin
                    next_state = READ_STRING;
                end
            end
            READ_PATTERN: begin
                if (~ispattern) begin
                    next_state = MATCH;
                end
                else begin
                    next_state = READ_PATTERN;
                end
            end
            MATCH: begin
                if (isstring) begin
                    next_state = READ_STRING;
                end
                else if (ispattern) begin
                    next_state = READ_PATTERN;
                end
                else begin
                    next_state = MATCH;
                end
            end
            default: begin
                next_state = IDLE;
            end
        endcase
    end
    assign rst_read_count = cur_state == MATCH;
    assign match_enable = cur_state == MATCH;
endmodule

module read_chardata(
    input clk,
    input reset,
    input isstring,
    input ispattern,
    input [7:0] chardata,
    input rst_read_count,
    output reg [7:0] string_buffer [0:31],
    output reg [7:0] pattern_buffer [0:7],
    output reg [4:0] read_string_count,
    output reg [2:0] read_pattern_count // add one more bit for safety
);


    reg [4:0] temp_read_string_count;
    reg [2:0] temp_read_pattern_count;


    always @(posedge clk or posedge reset) begin
        if (reset) begin
            read_string_count <= 0;
        end
        else if (isstring) begin
            read_string_count <= temp_read_string_count;
        end
    end
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            read_pattern_count <= 0;
        end
        else if (ispattern) begin
            read_pattern_count <= temp_read_pattern_count;
        end
    end

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            for (int i = 0; i < 32; i++) begin
                string_buffer[i] <= 0;
            end
        end
        else if (isstring) begin
            string_buffer [temp_read_string_count] <= chardata;
        end
    end
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            for (int i = 0; i < 8; i++) begin
                pattern_buffer[i] <= 0;
            end
        end
        else if (ispattern) begin
            pattern_buffer [temp_read_pattern_count] <= chardata;
        end
    end
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            temp_read_string_count <= 0;
        end
        else if (isstring) begin
            temp_read_string_count <= temp_read_string_count + 1;
        end
        else if (rst_read_count) begin
            temp_read_string_count <= 0;
        end
    end
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            temp_read_pattern_count <= 0;
        end
        else if (ispattern) begin
            temp_read_pattern_count <= temp_read_pattern_count + 1;
        end
        else if (rst_read_count) begin
            temp_read_pattern_count <= 0;
        end
    end
endmodule

module match_controller(
    input clk,
    input reset,
    input isstring,
    input ispattern,
    input [7:0] string_buffer [0:31],
    input [7:0] pattern_buffer [0:7],
    input [4:0] read_string_count,
    input [2:0] read_pattern_count,
    input match_enable,
    output match,
    output reg [4:0] match_index,
    output valid
);

typedef enum reg [3:0] {
    WAIT_READ = 0,
    MATCH_SPECIAL = 1,
    SPECIAL_MATCH_FIRST_LAST = 2,
    SPECIAL_MATCH_FIRST = 3,
    MATCH_PATTERN_FIRST = 4,
    SPECIAL_MATCH_LAST = 5,
    SEARCH_SPACE = 6,
    MATCH_STAR = 7,
    MATCH_PATTERN = 8,
    MATCH_END = 9,
    OUTPUT_MATCH_VALID = 10,
    OUTPUT_VALID = 11,
    DEBUG = 12
} match_state_t;

    match_state_t cur_match_state;
    match_state_t next_match_state;

    reg [4:0]match_string_count;
    reg [2:0]match_pattern_count;//add one more bit for safety
    reg string_count_enable;
    reg pattern_count_enable;
    reg rst_match_pattern_count;
    reg [2:0] star_index;
    reg [4:0] string_count_temp;
    reg star_flag_temp;
    wire star_flag;
    wire match_flag;
    wire finish_match = match_string_count == read_string_count;
    
    wire special_first_char = (pattern_buffer[0] == `FIND_FIRST);
    wire special_last_char = pattern_buffer[read_pattern_count] == `FIND_LAST;
    wire special_first_last_char = special_first_char && special_last_char;
    wire special_any_char = pattern_buffer[match_pattern_count] == `FIND_ANY;
    
    assign match_flag = pattern_count_enable && (match_pattern_count == 0);
    assign star_flag = match_enable && pattern_buffer[match_pattern_count] == `STAR;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            star_flag_temp <= 0;
        end else if (valid) begin
            star_flag_temp <= 0;
        end else if (star_flag) begin
            star_flag_temp <= star_flag;
        end

    end

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            match_index <= 0;
        end else if (isstring || ispattern) begin
            match_index <= 0;
        end
        else if (match_flag) begin
            match_index <= match_string_count;
        end
    end
    //always @(posedge clk or posedge reset) begin
    //    if (reset) begin
    //        string_count_temp <= 0;
    //    end else if (isstring || ispattern) begin
    //        string_count_temp <= 0;
    //    end
    //    else if (pattern_count_enable && match_pattern_count == 0) begin
    //        string_count_temp <= match_string_count;
    //    end
    //end
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            match_string_count <= 0;
        end else if (isstring || ispattern) begin
            match_string_count <= 0;
        end
        else if (string_count_enable) begin
            match_string_count <= match_string_count + 1;
        end
    end
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            match_pattern_count <= 0;
        end else if (star_flag_temp & rst_match_pattern_count) begin
            match_pattern_count <= star_index;
        end else if (rst_match_pattern_count) begin
            match_pattern_count <= 0;
        end else if (pattern_count_enable) begin
            match_pattern_count <= match_pattern_count + 1;
        end
    end

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            cur_match_state <= WAIT_READ;
        end
        else if (match_enable) begin
            cur_match_state <= next_match_state;
        end
    end
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            star_index <= 0;
        end
        else if (isstring || ispattern) begin
            star_index <= 0;
        end
        else if (star_flag) begin
            star_index <= match_pattern_count+1;
        end
    end
    
    always @(*) begin
        case (cur_match_state)
            WAIT_READ: begin
                if (match_enable) begin
                    next_match_state = MATCH_SPECIAL;
                end
                else begin
                    next_match_state = WAIT_READ;
                end
                string_count_enable = 0;
                pattern_count_enable = 0;
                rst_match_pattern_count = 1;
            end
            MATCH_SPECIAL: begin
                if (special_first_last_char) begin
                    next_match_state = SPECIAL_MATCH_FIRST_LAST;
                end
                else if (special_first_char) begin
                    next_match_state = SPECIAL_MATCH_FIRST;
                end
                else if (special_last_char) begin
                    next_match_state = SPECIAL_MATCH_LAST;
                end
                else begin
                    next_match_state = MATCH_PATTERN;
                end
                string_count_enable = 0;
                pattern_count_enable = 0;
                rst_match_pattern_count = 1;
            end
            SPECIAL_MATCH_FIRST_LAST: begin
                if (string_buffer[match_string_count] == pattern_buffer[1] || pattern_buffer[1] == `FIND_ANY) begin
                    if (match_string_count == 0) begin
                        next_match_state = SEARCH_SPACE;
                        string_count_enable = 0;
                        pattern_count_enable = 1;
                        rst_match_pattern_count = 0;
                    end
                    else if (string_buffer[match_string_count-1] == `SPACE) begin
                        next_match_state = SEARCH_SPACE;
                        string_count_enable = 0;
                        pattern_count_enable = 1;
                        rst_match_pattern_count = 0;
                    end
                    else if (finish_match) begin
                        next_match_state = OUTPUT_VALID;
                        string_count_enable = 0;
                        pattern_count_enable = 0;
                        rst_match_pattern_count = 1;
                    end
                    else begin
                        next_match_state = SPECIAL_MATCH_FIRST_LAST;
                        string_count_enable = 1;
                        pattern_count_enable = 0;
                        rst_match_pattern_count = 1;
                    end
                end
                else begin
                    if (finish_match) begin
                        next_match_state = OUTPUT_VALID;
                        string_count_enable = 0;
                        pattern_count_enable = 0;
                        rst_match_pattern_count = 1;
                    end
                    else begin
                        next_match_state = SPECIAL_MATCH_FIRST_LAST;
                        string_count_enable = 1;
                        pattern_count_enable = 0;
                        rst_match_pattern_count = 1;
                    end
                end
            end
            SEARCH_SPACE: begin
                if (string_buffer[match_string_count+1] == `SPACE) begin
                    if ((string_buffer[match_string_count] == pattern_buffer[read_pattern_count-1] || pattern_buffer[read_pattern_count-1] == `FIND_ANY) && (match_pattern_count+1 == read_pattern_count)) begin
                        next_match_state = OUTPUT_MATCH_VALID;
                        string_count_enable = 0;
                        pattern_count_enable = 0;
                        rst_match_pattern_count = 1;
                    end
                    else begin
                        next_match_state = SPECIAL_MATCH_FIRST_LAST;
                        string_count_enable = 1;
                        pattern_count_enable = 1;
                        rst_match_pattern_count = 1;
                    end
                end else if (match_string_count == read_string_count) begin
                    if (string_buffer[match_string_count] == pattern_buffer[read_pattern_count-1]) begin
                        next_match_state = OUTPUT_MATCH_VALID;
                        string_count_enable = 0;
                        pattern_count_enable = 0;
                        rst_match_pattern_count = 1;
                    end
                    else begin
                        next_match_state = OUTPUT_VALID;
                        string_count_enable = 0;
                        pattern_count_enable = 0;
                        rst_match_pattern_count = 1;
                    end
                end else if (read_pattern_count == match_pattern_count) begin
                    if (string_buffer[match_string_count] == `SPACE) begin
                        next_match_state = OUTPUT_MATCH_VALID;
                        string_count_enable = 0;
                        pattern_count_enable = 0;
                        rst_match_pattern_count = 1;
                    end else begin
                        next_match_state = SPECIAL_MATCH_FIRST_LAST;
                        string_count_enable = 0;
                        pattern_count_enable = 0;
                        rst_match_pattern_count = 1;
                    end
                end else if (special_any_char || (string_buffer[match_string_count] == pattern_buffer[match_pattern_count])) begin
                    next_match_state = SEARCH_SPACE;
                    string_count_enable = 1;
                    pattern_count_enable = 1;
                    rst_match_pattern_count = 0;
                end else begin
                    next_match_state = SPECIAL_MATCH_FIRST_LAST;
                    string_count_enable = 1;
                    pattern_count_enable = 0;
                    rst_match_pattern_count = 1;
                end
            end
            SPECIAL_MATCH_FIRST: begin
                if (string_buffer[match_string_count] == pattern_buffer[1]) begin
                    if (match_string_count == 0) begin
                        next_match_state = MATCH_PATTERN_FIRST;
                        string_count_enable = 1;
                        pattern_count_enable = 1;
                        rst_match_pattern_count = 0;
                    end
                    else if (string_buffer[match_string_count-1] == `SPACE) begin
                        next_match_state = MATCH_PATTERN_FIRST;
                        string_count_enable = 1;
                        pattern_count_enable = 1;
                        rst_match_pattern_count = 0;
                    end
                    else if (finish_match) begin
                        next_match_state = OUTPUT_VALID;
                        string_count_enable = 0;
                        pattern_count_enable = 0;
                        rst_match_pattern_count = 1;
                    end
                    else begin
                        next_match_state = SPECIAL_MATCH_FIRST;
                        string_count_enable = 1;
                        pattern_count_enable = 0;
                        rst_match_pattern_count = 1;
                    end
                end
                else begin
                    if (finish_match) begin
                        next_match_state = OUTPUT_VALID;
                        string_count_enable = 0;
                        pattern_count_enable = 0;
                        rst_match_pattern_count = 1;
                    end else if (pattern_buffer[1] == `FIND_ANY) begin
                        next_match_state = MATCH_PATTERN_FIRST;
                        string_count_enable = 1;
                        pattern_count_enable = 1;
                        rst_match_pattern_count = 0;
                    end else begin
                        next_match_state = SPECIAL_MATCH_FIRST;
                        string_count_enable = 1;
                        pattern_count_enable = 0;
                        rst_match_pattern_count = 1;
                    end
                end
            end
            MATCH_PATTERN_FIRST: begin
                if (pattern_buffer[match_pattern_count+1] == string_buffer[match_string_count]) begin
                    if (match_pattern_count+1 == read_pattern_count) begin
                        next_match_state = OUTPUT_MATCH_VALID;
                        string_count_enable = 0;
                        pattern_count_enable = 0;
                        rst_match_pattern_count = 1;
                    end else begin
                        next_match_state = MATCH_PATTERN_FIRST;
                        string_count_enable = 1;
                        pattern_count_enable = 1;
                        rst_match_pattern_count = 0;
                    end
                end
                else if (pattern_buffer[match_pattern_count+1] == `FIND_ANY) begin
                     if (match_pattern_count+1 == read_pattern_count) begin
                        next_match_state = OUTPUT_MATCH_VALID;
                        string_count_enable = 0;
                        pattern_count_enable = 0;
                        rst_match_pattern_count = 1;
                    end else begin
                        next_match_state = MATCH_PATTERN_FIRST;
                        string_count_enable = 1;
                        pattern_count_enable = 1;
                        rst_match_pattern_count = 0;
                    end
                end
                else begin
                    if (finish_match) begin
                        next_match_state = OUTPUT_VALID;
                        string_count_enable = 0;
                        pattern_count_enable = 0;
                        rst_match_pattern_count = 1;
                    end else begin
                        next_match_state = SPECIAL_MATCH_FIRST;
                        string_count_enable = 0;
                        pattern_count_enable = 0;
                        rst_match_pattern_count = 1;
                    end
                end
            end
            SPECIAL_MATCH_LAST: begin
                if (star_flag_temp || star_flag) begin
                    next_match_state = MATCH_STAR;
                    string_count_enable = 0;
                    pattern_count_enable = 1;
                    rst_match_pattern_count = 0;
                end else if (match_string_count == 0) begin
                    if (pattern_buffer[match_pattern_count] == string_buffer[match_string_count])begin
                        next_match_state = SPECIAL_MATCH_LAST;
                        string_count_enable = 1;
                        pattern_count_enable = 1;
                        rst_match_pattern_count = 0;
                    end else begin
                        next_match_state = SPECIAL_MATCH_LAST;
                        string_count_enable = 1;
                        pattern_count_enable = 0;
                        rst_match_pattern_count = 1;
                    end
                end else if (match_string_count == read_string_count) begin
                    if ((match_pattern_count+1 == read_pattern_count) && ((string_buffer[match_string_count] == pattern_buffer[match_pattern_count])||(pattern_buffer[match_pattern_count] == `FIND_ANY))) begin
                        next_match_state = OUTPUT_MATCH_VALID;
                        string_count_enable = 0;
                        pattern_count_enable = 0;
                        rst_match_pattern_count = 1;
                    end else begin
                        next_match_state = OUTPUT_VALID;
                        string_count_enable = 0;
                        pattern_count_enable = 0;
                        rst_match_pattern_count = 1;
                    end
                end else if (match_pattern_count == read_pattern_count) begin
                    if (string_buffer[match_string_count] == `SPACE) begin
                        next_match_state = OUTPUT_MATCH_VALID;
                        string_count_enable = 0;
                        pattern_count_enable = 0;
                        rst_match_pattern_count = 1;
                    end else if (match_pattern_count == 0) begin
                        next_match_state = SPECIAL_MATCH_LAST;
                        string_count_enable = 1;
                        pattern_count_enable = 0;
                        rst_match_pattern_count = 1;
                    end else begin
                        next_match_state = SPECIAL_MATCH_LAST;
                        string_count_enable = 0;
                        pattern_count_enable = 0;
                        rst_match_pattern_count = 1;
                    end
                end else begin
                    if (special_any_char || (pattern_buffer[match_pattern_count] == string_buffer[match_string_count]))begin
                        next_match_state = SPECIAL_MATCH_LAST;
                        string_count_enable = 1;
                        pattern_count_enable = 1;
                        rst_match_pattern_count = 0;
                    end else begin
                        if (match_pattern_count == 0) begin
                            next_match_state = SPECIAL_MATCH_LAST;
                            string_count_enable = 1;
                            pattern_count_enable = 0;
                            rst_match_pattern_count = 1;
                        end else begin
                            next_match_state = SPECIAL_MATCH_LAST;
                            string_count_enable = 0;
                            pattern_count_enable = 0;
                            rst_match_pattern_count = 1;
                        end
                    end
                end
            end
            MATCH_PATTERN: begin
                if (star_flag_temp || star_flag) begin
                    next_match_state = MATCH_STAR;
                    string_count_enable = 0;
                    pattern_count_enable = 1;
                    rst_match_pattern_count = 0;
                end else if (pattern_buffer[match_pattern_count] == string_buffer[match_string_count] ||special_any_char) begin
                    if (match_pattern_count == read_pattern_count) begin
                        next_match_state = OUTPUT_MATCH_VALID;
                        string_count_enable = 0;
                        pattern_count_enable = 1;
                        rst_match_pattern_count = 1;
                    end
                    else if (finish_match) begin
                        next_match_state = OUTPUT_VALID;
                        string_count_enable = 0;
                        pattern_count_enable = 0;   
                        rst_match_pattern_count = 1;
                    end
                    else begin
                        next_match_state = MATCH_PATTERN;
                        string_count_enable = 1;
                        pattern_count_enable = 1;
                        rst_match_pattern_count = 0;
                    end
                end else begin
                    if (finish_match) begin
                        next_match_state = OUTPUT_VALID;
                        string_count_enable = 0;
                        pattern_count_enable = 0;
                        rst_match_pattern_count = 1;
                    end else if (match_pattern_count == 0) begin
                        next_match_state = MATCH_PATTERN;
                        string_count_enable = 1;
                        pattern_count_enable = 0;
                        rst_match_pattern_count = 0;
                    end else begin
                        next_match_state = MATCH_PATTERN;
                        string_count_enable = 0;
                        pattern_count_enable = 0;
                        rst_match_pattern_count = 1;
                    end
                end
            end
            DEBUG: begin
                if (match_string_count == 0) begin
                    if (pattern_buffer[match_pattern_count] == string_buffer[match_string_count])begin
                        next_match_state = DEBUG;
                        string_count_enable = 1;
                        pattern_count_enable = 1;
                        rst_match_pattern_count = 0;
                    end else begin
                        next_match_state = DEBUG;
                        string_count_enable = 1;
                        pattern_count_enable = 0;
                        rst_match_pattern_count = 1;
                    end
                end else if (match_string_count == read_string_count) begin
                    if ((match_pattern_count+1 == read_pattern_count) && ((string_buffer[match_string_count] == pattern_buffer[match_pattern_count])||(pattern_buffer[match_pattern_count] == `FIND_ANY))) begin
                        next_match_state = OUTPUT_MATCH_VALID;
                        string_count_enable = 0;
                        pattern_count_enable = 0;
                        rst_match_pattern_count = 1;
                    end else begin
                        next_match_state = OUTPUT_VALID;
                        string_count_enable = 0;
                        pattern_count_enable = 0;
                        rst_match_pattern_count = 1;
                    end
                end else if (match_pattern_count == read_pattern_count) begin
                    if (string_buffer[match_string_count] == `SPACE) begin
                        next_match_state = OUTPUT_MATCH_VALID;
                        string_count_enable = 0;
                        pattern_count_enable = 0;
                        rst_match_pattern_count = 1;
                    end else if (match_pattern_count == 0) begin
                        next_match_state = DEBUG;
                        string_count_enable = 1;
                        pattern_count_enable = 0;
                        rst_match_pattern_count = 1;
                    end else begin
                        next_match_state = DEBUG;
                        string_count_enable = 0;
                        pattern_count_enable = 0;
                        rst_match_pattern_count = 1;
                    end
                end else begin
                    if (special_any_char || (pattern_buffer[match_pattern_count] == string_buffer[match_string_count]))begin
                        next_match_state = DEBUG;
                        string_count_enable = 1;
                        pattern_count_enable = 1;
                        rst_match_pattern_count = 0;
                    end else begin
                        if (match_pattern_count == star_index) begin
                            next_match_state = DEBUG;
                            string_count_enable = 1;
                            pattern_count_enable = 0;
                            rst_match_pattern_count = 1;
                        end else begin
                            next_match_state = DEBUG;
                            string_count_enable = 0;
                            pattern_count_enable = 0;
                            rst_match_pattern_count = 1;
                        end
                    end
                end
            end
            MATCH_STAR: begin
                if (special_last_char) begin
                    next_match_state = DEBUG;
                    string_count_enable = 0;
                    pattern_count_enable = 0;
                    rst_match_pattern_count = 0;
                end else if (pattern_buffer[match_pattern_count] == string_buffer[match_string_count]) begin
                    if (match_pattern_count == read_pattern_count) begin
                        next_match_state = OUTPUT_MATCH_VALID;
                        string_count_enable = 0;
                        pattern_count_enable = 0;
                        rst_match_pattern_count = 1;
                    end else if (finish_match) begin
                        next_match_state = OUTPUT_VALID;
                        string_count_enable = 0;
                        pattern_count_enable = 0;
                        rst_match_pattern_count = 1;
                    end else begin
                        next_match_state = MATCH_STAR;
                        string_count_enable = 1;
                        pattern_count_enable = 1;
                        rst_match_pattern_count = 0;
                    end
                end
                else begin
                    if (finish_match) begin
                        next_match_state = OUTPUT_VALID;
                        string_count_enable = 0;
                        pattern_count_enable = 0;
                        rst_match_pattern_count = 1;
                    end
                    else if (match_pattern_count == star_index) begin
                        next_match_state = MATCH_STAR;
                        string_count_enable = 1;
                        pattern_count_enable = 0;
                        rst_match_pattern_count = 1;
                    end else begin
                        next_match_state = MATCH_STAR;
                        string_count_enable = 0;
                        pattern_count_enable = 0;
                        rst_match_pattern_count = 1;
                    end
                end
            end
            OUTPUT_MATCH_VALID: begin
                next_match_state = WAIT_READ;
                string_count_enable = 0;
                pattern_count_enable = 0;
                rst_match_pattern_count = 1;
            end
            OUTPUT_VALID: begin
                next_match_state = WAIT_READ;
                string_count_enable = 0;
                pattern_count_enable = 0;
                rst_match_pattern_count = 1;
            end
            default: begin
                next_match_state = WAIT_READ;
                string_count_enable = 0;
                pattern_count_enable = 0;
                rst_match_pattern_count = 1;
            end
        endcase
    end

    assign match = cur_match_state == OUTPUT_MATCH_VALID;
    assign valid = cur_match_state == OUTPUT_VALID || cur_match_state == OUTPUT_MATCH_VALID;
endmodule