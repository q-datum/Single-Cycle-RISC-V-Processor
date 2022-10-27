module control_unit (input[31:0] inst, output reg b_beq, b_jal, b_jalr, reg_write, mem_to_reg, mem_write,
                output reg[3:0] alu_control, output reg alu_src, output reg[2:0] imm_control);
    
    // *****  IMM Control codes ***** //    // *****  ALU Control codes ***** //
    //            R -> 000            //    //            + -> 0000           //
    //            I -> 001            //    //            & -> 0001           //
    //            S -> 010            //    //            - -> 0010           //
    //            B -> 011            //    //            < -> 0011           //
    //            U -> 100            //    //            / -> 0100           //
    //            J -> 101            //    //            % -> 0101           //
    // ****************************** //    //           << -> 0110           //
                                            //           >> -> 0111           //
                                            //          >>> -> 1000           //
                                            // ****************************** //

    always @(inst) begin
        case(inst[6:0])
            7'b0110011: begin // R-type operations
                imm_control <= 3'b000;
                reg_write <= 1;
                imm_control <= 0;
                alu_src <= 0;
                mem_to_reg <= 0;
                mem_write <= 0;
                b_beq <= 0;
                b_jal <= 0;
                b_jalr <= 0;

                //add
                if (inst[31:25] == 7'b0 && inst[14:12] == 3'b0) 
                    alu_control <= 4'b0;

                //and
                if (inst[31:25] == 7'b0 && inst[14:12] == 3'b111) 
                    alu_control <= 4'b0001;

                //sub
                if (inst[31:25] == 7'b0100000 && inst[14:12] == 3'b0) 
                    alu_control <= 4'b0010;
                
                //slt
                if (inst[31:25] == 7'b0 && inst[14:12] == 3'b010) 
                    alu_control <= 4'b0011;

                //div
                if (inst[31:25] == 7'b0000001 && inst[14:12] == 3'b100) 
                    alu_control <= 4'b0100;

                //rem
                if (inst[31:25] == 7'b0000001 && inst[14:12] == 3'b110) 
                    alu_control <= 4'b0101;

                //sll
                if (inst[31:25] == 7'b0 && inst[14:12] == 3'b001) 
                    alu_control <= 4'b0110;
                
                //srl
                if (inst[31:25] == 7'b0 && inst[14:12] == 3'b101) 
                    alu_control <= 4'b0111;

                //sra
                if (inst[31:25] == 7'b0100000 && inst[14:12] == 3'b101) 
                    alu_control <= 4'b1000; 

            end
        endcase
    end
endmodule