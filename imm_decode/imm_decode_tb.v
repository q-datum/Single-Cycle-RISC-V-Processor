module imm_decode_tb();

    reg[31:0] inst;
    wire[24:0] input_op;
    assign input_op = inst[31:7];
    reg[2:0] imm_control;
    wire[31:0] imm_op;

    imm_decode test(input_op, imm_control, imm_op);
    
    initial begin
        $dumpfile("test");
        $dumpvars;
        //here instructions of all encoding types are being tested

        //addi - type I
        inst <= 32'b00000111101100000000000000010011;
        imm_control <= 3'b001;
        #10

        //sw - type S
        inst <= 32'b00010100000000000010000010100011;
        imm_control <= 3'b010;
        #10

        //beq - type B
        inst <= 32'b00000000000000000000001001100011;
        imm_control <= 3'b011;
        #10

        //lui - type U
        inst <= 32'b00001010010001010101000000110111;
        imm_control <= 3'b100;
        #10

        //jal - type J
        inst <= 32'b11111110100111111111000011101111;
        imm_control <= 3'b101;
        #10

        $finish;
    end

endmodule