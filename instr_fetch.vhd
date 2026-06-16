LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity ifid is
	port (
		-- inputs
		clk		:	in std_logic; -- clock
		pc_write	:	in std_logic; -- marcador para permitir ou não a escrita no PC (PC_write)
		pc_in		:	in std_logic_vector(31 downto 0); -- entrada de endereço (PC_in)
		pc_next_in	:	in std_logic_vector(31 downto 0); -- entrada de próximo endereço (PC_next_in)
		inst_in		:	in std_logic_vector(31 downto 0); -- entrada de instruções (Inst_in)
		
		-- outputs
		pc_out		:	out std_logic_vector(31 downto 0); -- saída de endereço (PC_out)
		pc_next_out	:	out std_logic_vector(31 downto 0); -- saída de próximo endereço (PC_next_out)
		inst_out	:	out std_logic_vector(31 downto 0); -- saída de instruções (Inst_out)
		reg_addr1	:	out std_logic_vector(4 downto 0); -- endereço do registrador 1 para leitura (RegAddr1)
		reg_addr2	:	out std_logic_vector(4 downto 0); -- endereço do registrador 2 para leitura (RegAddr2)
		reg_addr_w	:	out std_logic_vector(4 downto 0) -- endereço de um registrador para ser escrito (RegAddrW)
	);
end ifid;

architecture behavioral of ifid is

	signal op_code	:	std_logic_vector(6 downto 0); -- sinal de operação (opcode)
	signal rs1	:	std_logic_vector(4 downto 0); -- sinal auxiliar para reg_addr1
	signal rs2	:	std_logic_vector(4 downto 0); -- sinal auxiliar para reg_addr2
	signal rd	:	std_logic_vector(4 downto 0); -- sinal auxiliar para reg_addr_w
	signal ifid_bus	:	std_logic_vector(117 downto 0); -- sinal usado como registrador de 118 bits (idif)
	
	begin
		op_code <= inst_in(6 downto 0); -- selecionando a operação
		
		process(op_code)
			begin
			-- operações com formato R, I, U ou J possuem rd
				-- todas exceto: sw, beq, bne
			if not (op_code = "0100011" or op_code = "1100011") then
				rd <= inst_in(11 downto 7); -- carregando rs1
			end if;
			
			-- operações com formato R, I, S ou B possuem rs1
				-- todas exceto: auipc, lui e jal
			if not (op_code = "1101111" or op_code = "0110111") then
				rs1 <= inst_in(19 downto 15); -- carregando rs1
			end if;
			
			-- operações com formato R, S ou B possuem rs2
				-- add, sub, and, or, xor, sll, srl, sw, beq, bne
			if (op_code = "0110011" or op_code = "0100011" or op_code = "1100011") then
				rs2 <= inst_in(24 downto 20); -- carregando rs1
			end if;
		end process;
		
		process(clk, pc_write)
			begin
			if (rising_edge(clk)) then -- quando o clock ativar
				if (pc_write = '1') then -- se a escrita estiver permitida, os valores são guardados em ifid_bus
					ifid_bus(31 DOWNTO 0) <= inst_in;
					ifid_bus(63 DOWNTO 32) <= pc_in;
					ifid_bus(95 downto 64) <= pc_next_in;
					ifid_bus(102 downto 96) <= op_code;
					ifid_bus(107 downto 103) <= rs1;
					ifid_bus(112 downto 108) <= rs2;
					ifid_bus(117 downto 113) <= rd;
				end if;
			end if;
			if (falling_edge(clk)) then -- quando o clock desativar, retornar os valores adiante
				inst_out <= ifid_bus(31 downto 0);
				pc_out <= ifid_bus(63 downto 32);
				pc_next_out <= ifid_bus(95 downto 64);
				reg_addr1 <= ifid_bus(107 downto 103);
				reg_addr2 <= ifid_bus(112 downto 108);
				reg_addr_w <= ifid_bus(117 downto 113);
			end if;
		end process;	

end behavioral;
