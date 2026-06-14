
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ImmGen is
	port(
		instruction	:	in std_logic_vector(31 downto 0); -- entrada de instrução (instr)
		imm		:	out std_logic_vector(31 downto 0) -- saída de número com valor imediato
	);
end ImmGen;

architecture behavioral of ImmGen is
	signal op_code	:	std_logic_vector(6 downto 0); -- código da operação (oc)
	signal imm_sig	:	std_logic_vector(31 downto 0) := "00000000000000000000000000000000"; -- definição do imm (imm_aux)
	
	begin 
		op_code <= instruction(6 downto 0); -- configurando operação
		process(op_code)
		begin
			if (op_code="0010011" or op_code="1100110" or op_code="0000011") then -- I-Type
				imm_sig(11 downto 0) <= instruction(31 downto 20);
				imm_sig(31 downto 12) <= (others => instruction(31));
			elsif (op_code="0100011") then -- S-Type
				imm_sig(11 downto 5) <= instruction(31 downto 25);
				imm_sig(4 downto 0) <= instruction(11 downto 7);
				imm_sig(31 downto 12) <= (others => instruction(31));
			elsif (op_code="1100111" or op_code="1100011") then -- B-Type
				imm_sig(12) <= instruction(31);
				imm_sig(11) <= instruction(7);
				imm_sig(10 downto 5) <= instruction(30 downto 25);
				imm_sig(4 downto 1) <= instruction(11 downto 8);
				imm_sig(31 downto 13) <= (others => instruction(31));
			elsif (op_code="0110111" or op_code="1110111") then -- U-Type
				imm_sig(31 downto 12) <= instruction(31 downto 12);
			elsif (op_code="1101111") then -- J-Type
				imm_sig(20) <= instruction(31);
				imm_sig(10 downto 1) <= instruction(30 downto 21);
				imm_sig(11) <= instruction(20);
				imm_sig(19 downto 12) <= instruction(19 downto 12);
				imm_sig(31 downto 21) <= (others => instruction(31));
			end if;
		end process;
	imm <= imm_sig;
end behavioral;
