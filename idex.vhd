
LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity idex is
	port (
	-- inputs
		clk		:	in std_logic; -- clock
		branch_in	:	in std_logic; -- control input
		mem_read_in	:	in std_logic; -- control input (MemRead_in)
		mem_to_reg_in	:	in std_logic; -- control input (MemtoReg_in)
		alu_op_in	:	in std_logic_vector(1 downto 0); -- control input (ALUop_in)
		mem_write_in	:	in std_logic; -- control input (MemWrite_in)
		alu_src_in	:	in std_logic; -- control input (ALUscr_in)
		reg_write_in	:	in std_logic; -- control input (RegWrite_in)
		funct7_in	:	in std_logic_vector(6 downto 0); -- control input
		funct3_in	:	in std_logic_vector(2 downto 0); -- control input
		opcode_in	:	in std_logic_vector(6 downto 0); -- control input
		pc_shift_ctrl_in:	in std_logic; -- control input (PC_shift_ctrl_in)
		jump_reg_in	:	in  std_logic; -- control input (JumpReg_in)
		pc_in		:	in std_logic_vector(31 downto 0); -- ifid input (PC_in)
		da_in		:	in std_logic_vector(31 downto 0); -- registradores input (Da_in)
		db_in		:	in std_logic_vector(31 downto 0); -- registradores input (Db_in)
		imm_in		:	in std_logic_vector(31 downto 0); -- immaginate input
		reg_addr1_in	:	in std_logic_vector(4 downto 0); -- ifid input (RegAddr1_in)
		reg_addr2_in	:	in std_logic_vector(4 downto 0); -- ifid input (RegAddr2_in)
		reg_addr_d_in	:	in std_logic_vector(4 downto 0); -- ifid input (RegAddrD_in)
		
	-- outputs
		branch		:	out std_logic; -- control input (Branch)
		mem_read	:	out std_logic; -- control input (MemRead)
		mem_to_reg	:	out std_logic; -- control input (MemtoReg)
		alu_op		:	out std_logic_vector(1 downto 0); -- control input (ALUop)
		mem_write	:	out std_logic; -- control input (MemWrite)
		alu_src		:	out std_logic; -- control input (ALUscr)
		reg_write	:	out std_logic; -- control input (RegWrite)
		funct7		:	out std_logic_vector(6 downto 0); -- control input
		funct3		:	out std_logic_vector(2 downto 0); -- control input
		opcode		:	out std_logic_vector(6 downto 0); -- control input
		pc_shift_ctrl	:	out std_logic; -- control input (PC_shift_ctrl)
		jump_reg	:	out std_logic; -- control input (JumpReg)
		pc		:	out std_logic_vector(31 downto 0); -- ifid input (PC)
		da		:	out std_logic_vector(31 downto 0); -- registradores input (Da)
		db		:	out std_logic_vector(31 downto 0); -- registradores input (Db)
		imm		:	out std_logic_vector(31 downto 0); -- immaginate input
		reg_addr1	:	out std_logic_vector(4 downto 0); -- ifid input (RegAddr1)
		reg_addr2	:	out std_logic_vector(4 downto 0); -- ifid input (RegAddr2)
		reg_addr_d	:	out
