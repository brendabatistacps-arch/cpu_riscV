library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ALU_control is
	port(
		funct7		:	in std_logic_vector(6 downto 0); -- entrada funct7
		funct3		:	in std_logic_vector(2 downto 0); -- entrada funct3
		opcode		:	in std_logic_vector(6 downto 0); -- entrada opcode
		alu_op		:	in std_logic_vector(1 downto 0); -- entrada operação da ULA (ALUop)
		alu_ctrl	:	out std_logic_vector(3 downto 0); -- saída controle da ULA (ALU_ctrl)
		beq_bne		:	out std_logic -- saída de verificação equal or not equal (beq_ben)
	);
end ALU_control;

architecture behavioral of ALU_control is
	begin
		process(all)
		begin
			if (alu_op = "00") then -- operação de load
				alu_ctrl <= "0010";
			elsif (alu_op = "01") then -- operação de Branch
				alu_ctrl <= "0110";
			else
				if (funct7 = "0100000" and funct3 = "000") then -- subtração
					alu_ctrl <= "0110";
				elsif (funct3 = "000") then -- soma
					alu_ctrl <= "0010";
				elsif (funct3 = "001") then -- shift left
					alu_ctrl <= "0110";
				elsif (funct3 = "100") then -- XOR
					alu_ctrl <= "0011";
				elsif (funct3 = "101") then -- shift right
					alu_ctrl <= "0101";
				elsif (funct3 = "110") then -- OR
					alu_ctrl <= "0111";
				elsif (funct3 = "111") then -- AND
					alu_ctrl <= "0001";
				end if;
			end if;
			if (opcode="1100011" and funct3="000") then -- marcando beq ou bne
				beq_bne <= '1';
			end if;
		end process;
end behavioral;
