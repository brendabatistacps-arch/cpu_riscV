library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity splitter is
	port(
		data_in		:	in std_logic_vector(31 downto 0); -- entrada de dados
		data_out1	:	out std_logic_vector(15 downto 0); -- saída de dados 1 (data_out1)
		data_out2	:	out std_logic_vector(15 downto 0) -- saída de dados 2 (data_out2)
	);
end splitter;

architecture behavioral of splitter is
	begin
		data_out1 <= data_in(31 downto 16);
		data_out2 <= data_in(15 downto 0);
end behavioral;
