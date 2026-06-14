
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Forward is
	port(
		clk		:	in std_logic; -- clock
		wb_reg_write	:	in std_logic; -- verifica se está liberada a escrita em WB (WBregWrite)
		mem_reg_write	:	in std_logic; -- verifica se está liberada a escrita em MEM (MEMregWrite)
		reg_addr1	:	in std_logic_vector(4 downto 0); -- Registrador 1 (RegAddr1)
		reg_addr2	:	in std_logic_vector(4 downto 0); -- Registrador 2 (RegAddr2)
		wb_reg_d	:	in std_logic_vector(4 downto 0); -- Registrador alvo de WB (WBregD)
		mem_reg_d	:	in std_logic_vector(4 downto 0); -- Registrador alvo de MEM (MEMregD)
		forward1	:	out std_logic_vector(1 downto 0); -- Saída com foward para reg1 (Forward1)
		forward2	:	out std_logic_vector(1 downto 0) -- Saída com forward para reg2 (Forward2)
	);
end Forward;

architecture behavioral of Forward is
	signal fwd1_sig :	std_logic_vector(1 downto 0) := "00"; -- sinal auxiliar para forward1 (fwrd1)
	signal fwd2_sig :	std_logic_vector(1 downto 0) := "00"; -- sinal auxiliar para forward2 (fwrd2)
	
	begin
		process(clk)
		begin
			if ((mem_reg_write = '1') and (not(mem_reg_d = "0000"))) then
				if (mem_reg_d = reg_addr1) then
					fwd1_sig <= "10";
				end if;
				if (mem_reg_d = reg_addr2) then
					fwd2_sig <= "10";
				end if;
			end if;
			if ((wb_reg_write = '1') and (not(wb_reg_d = "0000"))) then
				if (wb_reg_d = reg_addr1) then
					fwd1_sig <= "01";
				end if;
				if (wb_reg_d = reg_addr2) then
					fwd2_sig <= "01";
				end if;
			end if;
		end process;
	forward1 <= fwd1_sig;
	forward2 <= fwd2_sig;
end behavioral;
