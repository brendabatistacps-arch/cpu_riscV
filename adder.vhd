LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE IEEE.std_logic_unsigned.ALL; 

entity adder is
	port(
		entry1	:	in std_logic_vector(31 downto 0); -- entrada 1 (32 bits) (Entry1)
		entry2	:	in std_logic_vector(31 downto 0); -- entrada 2 (32 bits) (Entry2)
		sum	:	out std_logic_vector(31 downto 0) -- resultado da soma (32 bits) (Sum)
	);
end adder;

architecture behavioral of adder is
	begin
		sum <= entry1 + entry2;
end behavioral;
