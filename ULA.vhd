library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.ALL;
use IEEE.std_logic_unsigned.ALL;

entity ALU is
	port(
		entry1		:	in std_logic_vector(31 downto 0); -- entrada 1 da ULA (Entry1)
		entry2		:	in std_logic_vector(31 downto 0); -- entrada 2 da ULA (Entry2)
		control		:	in  std_logic_vector(3 downto 0); -- controle da ULA
		result		:	out std_logic_vector(31 downto 0); -- saída da ULA
		zero_flag	:	out std_logic -- flag se o resultado for zero
	);
end ALU;

architecture behavioral of ALU is
	signal res_sig :  std_logic_vector(31 downto 0); -- sinal auxiliar para o resultado (res)
	
	begin
		process(control)
		begin
			if (control = "0010") then -- soma
				res_sig <= (entry1 + entry2);
			elsif (control = "0110") then -- subtração
				res_sig <= (entry1 - entry2);
			elsif (control = "0101") then -- XOR
				res_sig <= (entry1 XOR entry2);
			elsif (control = "0001") then -- OR
				res_sig <= (entry1 OR entry2);
			elsif (control = "0000") then -- AND
				res_sig <= (entry1 AND entry2);
			elsif (control = "0011") then -- shift left
				res_sig <= (std_logic_vector(shift_left(unsigned(entry1), to_integer(unsigned(entry2)))));
			elsif (control = "0111") then -- shift right
				res_sig <= (std_logic_vector(shift_right(unsigned(entry1), to_integer(unsigned(entry2)))));
			end if;
		end process;
	result <= res_sig;
	zero_flag <= '1' when res_sig = "00000000000000000000000000000000" else '0'; -- marcando a flag se o valor for zero

end behavioral;
