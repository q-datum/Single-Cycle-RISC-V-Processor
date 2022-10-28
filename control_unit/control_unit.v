module control_unit (input[31:0] inst, output reg b_beq, b_jal, b_jalr, reg_write, mem_to_reg, mem_write,
                output reg[3:0] alu_control, output reg alu_src, output reg[2:0] imm_control, output reg lui_set, auipc_set);
    
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
                                            //           >= -> 1001           //
                                            // ****************************** //

    always @(inst) begin
        case(inst[6:0])
            7'b0110011: begin // R-type operations
                imm_control <= 3'b000;
                reg_write <= 1;
                alu_src <= 0;
                mem_to_reg <= 0;
                mem_write <= 0;
                b_beq <= 0;
                b_jal <= 0;
                b_jalr <= 0;
                lui_set <= 0;
                auipc_set <= 0;

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
            
            //addi
            7'b0010011: begin
                imm_control <= 3'b001;
                reg_write <= 1;
                alu_src <= 1;
                mem_to_reg <= 0;
                mem_write <= 0;
                b_beq <= 0;
                b_jal <= 0;
                b_jalr <= 0;
                lui_set <= 0;
                auipc_set <= 0;
                alu_control <= 4'b0;
            end

            //lw
            7'b0000011: begin
                imm_control <= 3'b001;
                reg_write <= 1;
                alu_src <= 1;
                mem_to_reg <= 1;
                mem_write <= 0;
                b_beq <= 0;
                b_jal <= 0;
                b_jalr <= 0;
                lui_set <= 0;
                auipc_set <= 0;
                alu_control <= 4'b0;
            end

            //jalr
            7'b1100111: begin
                imm_control <= 3'b001;
                reg_write <= 1;
                alu_src <= 1;
                mem_to_reg <= 0;
                mem_write <= 0;
                b_beq <= 0;
                b_jal <= 0;
                b_jalr <= 1;
                lui_set <= 0;
                auipc_set <= 0;
                alu_control <= 4'b0;
            end

            //sw
            7'b0100011: begin
                imm_control <= 3'b010;
                reg_write <= 0;
                alu_src <= 1;
                mem_to_reg <= 0;
                mem_write <= 1;
                b_beq <= 0;
                b_jal <= 0;
                b_jalr <= 0;
                lui_set <= 0;
                auipc_set <= 0;

                alu_control <= 4'b0;
            end

            //beq & blt
            7'b1100011: begin
                imm_control <= 3'b011;
                reg_write <= 0;
                alu_src <= 0;
                mem_to_reg <= 0;
                mem_write <= 0;
                b_beq <= 1;
                b_jal <= 0;
                b_jalr <= 0;
                lui_set <= 0;
                auipc_set <= 0;
                if (inst[14:12] == 3'b000) alu_control <= 4'b0010; //beq
                if (inst[14:12] == 3'b100) alu_control <= 4'b1001; //blt -> if r1 >= r2 return 0, equal to beq
            end

            //lui
            7'b1100011: begin
                imm_control <= 3'b100;
                reg_write <= 1;
                alu_src <= 0;
                mem_to_reg <= 0;
                mem_write <= 0;
                b_beq <= 0;
                b_jal <= 0;
                b_jalr <= 0;
                alu_control <= 4'b0;
                lui_set <= 1;
                auipc_set <= 0;
            end

            //auipc
            7'b0010111: begin
                imm_control <= 3'b100;
                reg_write <= 1;
                alu_src <= 0;
                mem_to_reg <= 0;
                mem_write <= 0;
                b_beq <= 0;
                b_jal <= 0;
                b_jalr <= 0;
                alu_control <= 4'b0;
                lui_set <= 0;
                auipc_set <= 1;
            end

            7'b0010111: begin
                imm_control <= 3'b101;
                reg_write <= 1;
                alu_src <= 0;
                mem_to_reg <= 0;
                mem_write <= 0;
                b_beq <= 0;
                b_jal <= 1;
                b_jalr <= 0;
                alu_control <= 4'b0;
                lui_set <= 0;
                auipc_set <= 0;
            end

        endcase
    end
endmodule