
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Hazard is
	port(
		clk		:	in std_logic; -- clock
		mem_read	:	in std_logic; -- sinal que decide se a memória será lida ou não (MemRead)
		reg_addr1	:	in std_logic_vector(4 downto 0); -- endereço do registrador 1 (RegAddr1)
		reg_addr2	:	in std_logic_vector(4 downto 0); -- endereço do registrador 2 (RegAddr2)
		reg_addr_d	:	in std_logic_vector(4 downto 0); -- endereço de um registrador destino (RegAddrD)
		
		stall		:	out std_logic -- retorno que controla as operações no pipeline
	);
end Hazard;

architecture behavioral of Hazard is
	signal stall_sig : std_logic := '0'; -- sinal auxiliar para o stall (aux_stall)
	
	begin
		process(clk) -- verificando clock
		begin -- se algum endereço de leitura for igual ao de escrita retorna True para stall
			if((mem_read = '1') and ((reg_addr_d = reg_addr1) or (reg_addr_d = reg_addr2))) then 
				stall_sig <= '1';
			end if;
		end process;
	stall <= stall_sig;
end behavioral;
