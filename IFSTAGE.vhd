----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:16:54 04/25/2024 
-- Design Name: 
-- Module Name:    IFSTAGE - Behavioral 
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
use ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity IFSTAGE is
    Port ( PC_immed : in  STD_LOGIC_VECTOR (31 downto 0);
           PC_sel : in  STD_LOGIC;
           PC_LdEn : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           INSTR : out  STD_LOGIC_VECTOR (31 downto 0));
end IFSTAGE;

architecture Behavioral of IFSTAGE is

component IMEM is
	port( --clk		: in std_logic;
			a			: in std_logic_vector (9 downto 0);
			spo		: out std_logic_vector (31 downto 0));
end component;

component MUX2 is
    Port ( In0     : in  std_logic_vector (31 downto 0);
           In1 	 : in  std_logic_vector (31 downto 0);
           Mux_out : out  std_logic_vector (31 downto 0);
           SEL 	 : in  std_logic);
end component;

component Register_comp is
	Port(clk 	 : in  std_logic;
		  rst 	 : in  std_logic;
        DataIN  : in  std_logic_vector(31 downto 0);
        WE 		 : in  std_logic;
        DataOUT : out std_logic_vector(31 downto 0));
end component;

-- pc_out : output of pc register
-- next_instruction : pc + 4
-- jump_register : pc +4 + PC_immed
signal pc_out : std_logic_vector (31 downto 0);
signal next_instruction : std_logic_vector (31 downto 0);
signal jump_instruction : std_logic_vector (31 downto 0);

signal mux_out : std_logic_vector (31 downto 0);

begin
next_instruction <= pc_out + "00000000000000000000000000000100";
jump_instruction <= pc_out + "00000000000000000000000000000100" + PC_immed;

mux_2: MUX2 port map(In0 => next_instruction,
						  In1 => jump_instruction,
						  Mux_out => mux_out,
						  SEL => PC_sel);
						  
PC: Register_comp port map(clk => clk,
					 rst => rst,
					 DataIN => mux_out,
					 WE => PC_LdEn,
					 DataOUT => pc_out);
					 
ifmem: IMEM port map(--clk => clk,
						   a  => pc_out(11 downto 2),
						  spo => INSTR);
						  


end Behavioral;

