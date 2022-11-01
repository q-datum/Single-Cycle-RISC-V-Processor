module alu(input[31:0] src_a, src_b, input[3:0] alu_control, output reg zero, output reg[31:0] alu_out);

    always @(alu_control, src_a, src_b) begin
        case(alu_control)
            4'b0: begin
                alu_out <= src_a + src_b;
            end
            4'b0001: begin
                alu_out <= src_a & src_b;
            end
            4'b0010: begin
                alu_out <= src_a - src_b;
            end
            4'b0011: begin
                alu_out <= src_a < src_b;
            end
            4'b0100: begin
                alu_out <= src_a / src_b;
            end
            4'b0101: begin
                alu_out <= src_a % src_b;
            end
            4'b0110: begin
                alu_out <= src_a << src_b;
            end
            4'b0111: begin
                alu_out <= src_a >> src_b;
            end
            4'b1000: begin
                alu_out <= src_a >>> src_b;
            end
            4'b1001: begin
                alu_out <= src_a >= src_b;
            end
        endcase
    end

    always @(alu_out) begin
        if(alu_out == 0) zero = 1;
    end
endmodule