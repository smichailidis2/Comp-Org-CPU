----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:20:58 05/06/2024 
-- Design Name: 
-- Module Name:    DATAPATH - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity DATAPATH is
    Port ( PC_sel : in  STD_LOGIC;
           PC_LdEn : in  STD_LOGIC;
           RF_WrEn : in  STD_LOGIC;
           RF_WrData_sel : in  STD_LOGIC;
           RF_B_sel : in  STD_LOGIC;
           ALU_Bin_sel : in  STD_LOGIC;
           ALU_func : in  STD_LOGIC_VECTOR (3 downto 0);
           MEM_WrEn : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
			  ByteFlag : in STD_LOGIC;
           Instruction : out  STD_LOGIC_VECTOR (31 downto 0);
			  ALU_zero : out STD_LOGIC);
end DATAPATH;


architecture Behavioral of DATAPATH is

component DECSTAGE is
    Port ( Instr : in  STD_LOGIC_VECTOR (31 downto 0);
           RF_WrEn : in  STD_LOGIC;
           ALU_out : in  STD_LOGIC_VECTOR (31 downto 0);
           MEM_out : in  STD_LOGIC_VECTOR (31 downto 0);
           RF_WrData_sel : in  STD_LOGIC;
           RF_B_sel : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           Immed : out  STD_LOGIC_VECTOR (31 downto 0);
           RF_A : out  STD_LOGIC_VECTOR (31 downto 0);
           RF_B : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component IFSTAGE is
    Port ( PC_immed : in  STD_LOGIC_VECTOR (31 downto 0);
           PC_sel : in  STD_LOGIC;
           PC_LdEn : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           INSTR : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component EXECSTAGE is
    Port ( RF_A : in  STD_LOGIC_VECTOR (31 downto 0);
           RF_B : in  STD_LOGIC_VECTOR (31 downto 0);
           Immed : in  STD_LOGIC_VECTOR (31 downto 0);
           ALU_Bin_sel : in  STD_LOGIC;
           ALU_func : in  STD_LOGIC_VECTOR (3 downto 0);
           ALU_out : out  STD_LOGIC_VECTOR (31 downto 0);
			  ALU_zero : out STD_LOGIC);
end component;


component MEMORY_UNIT is
	Port (a : in std_logic_vector(9 downto 0);
			d : in std_logic_vector(31 downto 0);
			clk : in std_logic;
			we : in std_logic;
			ByteFlag : in std_logic;
			mem_data_out : out std_logic_vector(31 downto 0));
end component;

-- signals
signal DECSTAGE_out_Immed32 : std_logic_vector(31 downto 0);
signal DECSTAGE_out_RFB		 : std_logic_vector(31 downto 0);
signal DECSTAGE_out_RFA		 : std_logic_vector(31 downto 0);
signal EXECSTAGE_out_aluout : std_logic_vector(31 downto 0);
signal IFSTAGE_out_INSTR	 : std_logic_vector(31 downto 0);
signal MEMSTAGE_out_memout  : std_logic_vector(31 downto 0);

begin

Instruction_Fetch: IFSTAGE port map(PC_immed => DECSTAGE_out_Immed32,
												PC_sel => PC_sel,
												PC_LdEn => PC_LdEn,
												rst => rst,
												clk => clk,
												INSTR => IFSTAGE_out_INSTR);


Instruction_Decode: DECSTAGE port map( Instr => IFSTAGE_out_INSTR,
													RF_WrEn => RF_WrEn,
													ALU_out => EXECSTAGE_out_aluout,
													MEM_out => MEMSTAGE_out_memout,
													RF_WrData_sel => RF_WrData_Sel,
													RF_B_sel => RF_B_sel,
													clk => clk,
													rst => rst,
													Immed => DECSTAGE_out_Immed32,
													RF_A => DECSTAGE_out_RFA,
													RF_B => DECSTAGE_out_RFB );
													
Instruction_Execute: EXECSTAGE port map(RF_A => DECSTAGE_out_RFA,
													 RF_B => DECSTAGE_out_RFB,
													 Immed => DECSTAGE_out_Immed32,
													 ALU_Bin_sel => ALU_Bin_sel,
													 ALU_func => ALU_func,
													 ALU_out => EXECSTAGE_out_aluout,
													 ALU_zero => ALU_zero);
													 
Memory_Access : MEMORY_UNIT port map(a => EXECSTAGE_out_aluout(9 downto 0),
											  	 d => DECSTAGE_out_RFB,
												 we => MEM_WrEn,
												 clk => clk,
												 ByteFlag => ByteFlag,
												 mem_data_out => MEMSTAGE_out_memout);


Instruction <= IFSTAGE_out_INSTR;


end Behavioral;

