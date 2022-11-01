module imm_decode(input[31:7] input_op, input[2:0] imm_control, output reg[31:0] imm_op);

    always @(*) begin
        case(imm_control)
            3'b000: begin
                imm_op <= 0;
            end
            3'b001: begin
                imm_op <= {20'b0, input_op[31:20]};
            end
            3'b010: begin
                imm_op <= {20'b0, input_op[31:25], input_op[11:7]};
            end
            3'b011: begin
                imm_op <= {19'b0, input_op[31], input_op[7], input_op[30:25], input_op[11:8], 1'b0};
            end
            3'b100: begin
                imm_op <= {input_op[31:12], 12'b0};
            end
            3'b101: begin
                imm_op <= {11'b0, input_op[31], input_op[19:12], input_op[20], input_op[30:21], 1'b0};
            end
        endcase
    end
endmodule