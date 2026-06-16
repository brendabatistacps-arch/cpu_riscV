LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity memwb is
	port(
		-- inputs
		clk		:	in std_logic; -- clock
		reg_write_in	:	in std_logic; -- Permite ou não a escrita no registrador (RegWrite_in)
		mem_to_reg_in	:	in std_logic; -- Indica o dado que será guardado no registrador (MemtoReg_in)
		mem_data_in	:	in std_logic_vector(31 downto 0); -- Valor lido na memória (MemData_in)
		alu_res_in	:	in std_logic_vector(31 downto 0); -- Resultado da ULA (ALUres_in)
		reg_addr_d_in	:	in std_logic_vector(4 downto 0); -- Endereço de instrução alvo (RegAddrD_in)
		
		-- outputs
		reg_write	:	out std_logic; -- Permite ou não a escrita no registrador (RegWrite)
		mem_to_reg	:	out std_logic; -- Indica o dado que será guardado no registrador (MemtoReg)
		mem_data	:	out std_logic_vector(31 downto 0); -- Valor lido na memória (MemData)
		alu_res		:	out std_logic_vector(31 downto 0); -- Resultado da ULA (ALUres)
		reg_addr_d	:	out std_logic_vector(4 downto 0) -- (RegAddrD)
	);
end memwb;

architecture behavioral of memwb is
	signal memwb_bus : std_logic_vector(70 DOWNTO 0); -- sinal auxiliar para memwb (aux_memwb)
	begin
		process(clk)
		begin
			if (rising_edge(clk)) then -- verifica subida de clock
				memwb_bus(0)           <= reg_write_in;
				memwb_bus(1)           <= mem_to_reg_in;  
				memwb_bus(33 downto 2)   <= mem_data_in;       
				memwb_bus(65 downto 34)  <= alu_res_in;   
				memwb_bus(70 downto 66)  <= reg_addr_d_in; 
			end if;
			if (falling_edge(clk)) then -- verifica descida de clock
				reg_write  <= memwb_bus(0);    
				mem_to_reg <= memwb_bus(1);
				mem_data   <= memwb_bus(33 downto 2);
				alu_res    <= memwb_bus(65 downto 34);
				reg_addr_d <= memwb_bus(70 downto 66);
			end if;
		end process;
end behavioral;
