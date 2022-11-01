module alu_tb();

    reg[31:0] src_a, src_b;
    reg[3:0] alu_control;
    wire zero;
    wire[31:0] alu_out;

    alu test(src_a, src_b, alu_control, zero, alu_out);
    
    initial begin
        $dumpfile("test");
        $dumpvars;

        //0000 - +
        src_a = 0;
        src_b = 0;
        alu_control = 4'b0;
        #10

        $finish;
    end

endmodule