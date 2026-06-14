
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.ALL;
use IEEE.std_logic_unsigned.ALL;

entity PC is
	port (
		clk		:	in std_logic; -- clock
		reset		:	in std_logic; -- reset
		pc_in		:	in std_logic_vector(31 downto 0); -- entrada de endereço (PC_in)
		pc_write	:	in std_logic; -- marcador para permitir ou não a escrita no PC (PC_write)
		pc_out		:	out std_logic_vector(31 downto 0) -- saída de endereço (PC_out)
	);
end PC;

architecture behavioral of PC is
	begin
	process(clk, reset, pc_write)
		variable aux_var : std_logic := '0'; -- variavel auxiliar (aux0)
	begin
		if (reset = '1') then -- verificando se o reset está ativo
			pc_out <= (others => '0');
		end if;
		if (rising_edge(clk)) then -- quando o clock ativar
			if (pc_in = "UUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUU") then -- se todos os bits estiverem undefined
				pc_out <= (others => '0'); -- zerando o contador
			else
				if (pc_write = '1') then aux_var := '1'; end if; -- mudando aux_var
				pc_out <= pc_in + aux_var; -- alteração ou manutenção do endereço
			end if;
		end if;
	end process;
end behavioral;
