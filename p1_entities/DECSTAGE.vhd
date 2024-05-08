----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:23:28 04/28/2024 
-- Design Name: 
-- Module Name:    DECSTAGE - Behavioral 
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

entity DECSTAGE is
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
end DECSTAGE;

architecture Behavioral of DECSTAGE is

component MUX2 is
    Port ( In0 : in  STD_LOGIC_VECTOR (31 downto 0);
           In1 : in  STD_LOGIC_VECTOR (31 downto 0);
           Mux_out : out  STD_LOGIC_VECTOR (31 downto 0);
           SEL : in  STD_LOGIC);
end component;


component MUX2_5b is
    Port ( In0 : in  STD_LOGIC_VECTOR (4 downto 0);
           In1 : in  STD_LOGIC_VECTOR (4 downto 0);
           sel : in  STD_LOGIC;
           Mux_out : out  STD_LOGIC_VECTOR (4 downto 0) );
end component;

component RF is
    Port ( Ard1 	: in  STD_LOGIC_VECTOR (4 downto 0);
           Ard2 	: in  STD_LOGIC_VECTOR (4 downto 0);
           Awr 	: in  STD_LOGIC_VECTOR (4 downto 0);
           Dout1  : out  STD_LOGIC_VECTOR (31 downto 0);
           Dout2 	: out  STD_LOGIC_VECTOR (31 downto 0);
           Din 	: in  STD_LOGIC_VECTOR (31 downto 0);
           WrEn 	: in  STD_LOGIC;
           clk 	: in  STD_LOGIC;
			  rst 	: in STD_LOGIC);
end component;

component ImmedExtend is
    Port ( Immediate : in  STD_LOGIC_VECTOR (15 downto 0);
           Opcode : in  STD_LOGIC_VECTOR (5 downto 0);
           Immed_signExt : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

-- -------internal signals------- --
-- instruction decomposition
signal Opcode		: std_logic_vector(5 downto 0);
signal Rs	 		: std_logic_vector(4 downto 0);
signal Rt	 		: std_logic_vector(4 downto 0);
signal Rd	 		: std_logic_vector(4 downto 0);
signal immediate  : std_logic_vector(15 downto 0);

-- mux outs
signal mux_out_32b : std_logic_vector(31 downto 0);
signal mux_out_5b  : std_logic_vector(4 downto 0);

-- ------------------------------- --
begin

Opcode <= Instr(31 downto 26);
Rs <= Instr(25 downto 21);
Rd <= Instr(20 downto 16);
Rt <= Instr(15 downto 11);
immediate <= Instr(15 downto 0);

mux2_32: MUX2 port map(In0 => ALU_out,
							  In1 => MEM_out,
							  Mux_out => mux_out_32b,
							  SEL => RF_WrData_sel);
							  
							  
mux2_5: MUX2_5b port map(In0 => Rt,
								 In1 => Rd,
								 sel => RF_B_sel,
								 Mux_out => mux_out_5b);

R_F: RF port map(Ard1 => Rs,
					 Ard2 => mux_out_5b,
					 Awr => Rd,
					 Dout1 => RF_A,
					 Dout2 => RF_B,
					 Din => mux_out_32b,
					 WrEn => RF_WrEn,
					 clk => clk,
					 rst => rst);

ImmediateExtend: ImmedExtend port map( Immediate => immediate,
											  Opcode => Opcode,
											  Immed_signExt => Immed);

end Behavioral;

