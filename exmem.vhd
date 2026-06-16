library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity exmem is
	port(
		-- inputs
		clk		:	in std_logic; -- clock
		branch_in	:	in std_logic; -- control input
		mem_read_in	:	in std_logic; -- control input (MemRead_in)
		mem_to_reg_in	:	in std_logic; -- control input (MemtoReg_in)
		mem_write_in	:	in std_logic; -- control input (MemWrite_in)
		reg_write_in	:	in std_logic; -- control input (RegWrite_in)
		pc2_in		:	in std_logic_vector(31 downto 0); -- novo valor para o PC input (PC2_in)
		db_in		:	in std_logic_vector(31 downto 0); -- registradores input (Db_in)
		reg_addr_d_in	:	in std_logic_vector(4 downto 0); -- ifid input (RegAddrD_in)
		zero_flag_in	:	in std_logic; -- Flag da ULA com resultado zero
		alu_res_in	:	in std_logic_vector(31 downto 0); -- Resultado da ULA (ALUres_in)
		jar_in		:	in std_logic; -- Entrada q indica a operação JALR ou JAL

		-- outputs
		branch		:	out std_logic; -- control output
		mem_read	:	out std_logic; -- control output (MemRead)
		mem_to_reg	:	out std_logic; -- control output (MemtoReg)
		mem_write	:	out std_logic; -- control output (MemWrite)
		reg_write	:	out std_logic; -- control output (RegWrite)
		pc2		:	out std_logic_vector(31 downto 0); -- novo valor para o PC output (PC2)
		db		:	out std_logic_vector(31 downto 0); -- registradores output (Db)
		reg_addr_d	:	out std_logic_vector(4 downto 0); -- ifid input (RegAddrD)
		zero_flag	:	out std_logic; -- Flag da ULA com resultado zero
		alu_res		:	out std_logic_vector(31 downto 0); -- Resultado da ULA (ALUres)
		jar		:	out std_logic -- Entrada q indica a operação JALR ou JAL
	);
end exmem;

architecture behavioral of exmem is
	signal exmem_bus : std_logic_vector(107 downto 0); -- vetor auxiliar (aux_exmem)
	
	begin
		process(clk)
		begin
			if (rising_edge(clk)) then
				exmem_bus(0) <= branch_in;
				exmem_bus(1) <= mem_write_in;
				exmem_bus(2) <= mem_read_in;
				exmem_bus(3) <= reg_write_in;
				exmem_bus(4) <= mem_to_reg_in;
				exmem_bus(36 downto 5) <= pc2_in;
				exmem_bus(37) <= zero_flag_in;
				exmem_bus(69 downto 38) <= alu_res_in;
				exmem_bus(101 downto 70) <= db_in;
				exmem_bus(106 downto 102) <= reg_addr_d_in;
				exmem_bus(107) <= jar_in;
			end if;
			if (falling_edge(clk)) then
				branch     <= exmem_bus(0);       
				mem_write  <= exmem_bus(1);     
				mem_read   <= exmem_bus(2);      
				reg_write  <= exmem_bus(3);    
				mem_to_reg <= exmem_bus(4);
				pc2        <= exmem_bus(36 downto 5);
				zero_flag  <= exmem_bus(37);
				alu_res    <= exmem_bus(69 downto 38);
				db         <= exmem_bus(101 downto 70);
				reg_addr_d <= exmem_bus(106 downto 102);
				jar        <= exmem_bus(107);
			end if;
		end process;
end behavioral;
