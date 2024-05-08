----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:21:16 04/28/2024 
-- Design Name: 
-- Module Name:    EXECSTAGE - Behavioral 
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

entity EXECSTAGE is
    Port ( RF_A : in  STD_LOGIC_VECTOR (31 downto 0);
           RF_B : in  STD_LOGIC_VECTOR (31 downto 0);
           Immed : in  STD_LOGIC_VECTOR (31 downto 0);
           ALU_Bin_sel : in  STD_LOGIC;
           ALU_func : in  STD_LOGIC_VECTOR (3 downto 0);
           ALU_out : out  STD_LOGIC_VECTOR (31 downto 0);
			  ALU_zero : out STD_LOGIC);
end EXECSTAGE;

architecture Behavioral of EXECSTAGE is

component ALUentity is
    Port ( A : in  STD_LOGIC_VECTOR(31 downto 0);
           B : in  STD_LOGIC_VECTOR(31 downto 0);
           Op : in  STD_LOGIC_VECTOR(3 downto 0);
           ALU_Out : out  STD_LOGIC_VECTOR(31 downto 0);
           Zero : out  STD_LOGIC;
           Cout : out  STD_LOGIC;
           Ovf : out  STD_LOGIC);
end component;


component MUX2 is
    Port ( In0 : in  STD_LOGIC_VECTOR (31 downto 0);
           In1 : in  STD_LOGIC_VECTOR (31 downto 0);
           Mux_out : out  STD_LOGIC_VECTOR (31 downto 0);
           SEL : in  STD_LOGIC);
end component;

-- second input for ALU selection 
signal mux_out: std_logic_vector(31 downto 0);

-- signals used in datapath
signal instr:	std_logic_vector (3 downto 0);


begin


mux_2: MUX2 port map(In0 => RF_B,
						  In1 => Immed,
						  Mux_out => mux_out,
						  SEL => ALU_Bin_sel);
						  
ALU: ALUentity port map(A => RF_A,
								B => mux_out,
								Op => ALU_func,
								ALU_Out => ALU_out,
								Zero => ALU_zero);


end Behavioral;

