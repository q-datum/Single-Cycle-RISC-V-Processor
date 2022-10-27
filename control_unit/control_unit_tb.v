module control_unit_tb();

    reg[31:0] inst;
    wire b_beq, b_jal, b_jalr, reg_write, mem_to_reg, mem_write;
    wire[3:0] alu_control; 
    wire alu_src;
    wire[2:0] imm_control;

    control_unit test(inst, b_beq, b_jal, b_jalr, reg_write, mem_to_reg, mem_write, alu_control, alu_src, imm_control);
    
    initial begin
        $dumpfile("test");
        $dumpvars;

        inst <= 32'b00000000000000000000000000110011;
        #10

        inst <= 32'b00000000000000000111000000110011;
        #10

        inst <= 32'b01000000000000000000000000110011;
        #10

        inst <= 32'b00000000000000000010000000110011;
        #10
        //5
        inst <= 32'b00000010000000000100000000110011;
        #10

        inst <= 32'b00000010000000000110000000110011;
        #10

        inst <= 32'b00000000000000000001000000110011;
        #10

        inst <= 32'b00000000000000000101000000110011;
        #10

        inst <= 32'b01000000000000000101000000110011;
        #10

        inst <= 32'b00000000000000000000000000010011;
        #10

        $finish;
    end

endmodule