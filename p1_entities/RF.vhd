----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:43:05 04/10/2023 
-- Design Name: 
-- Module Name:    RF - Behavioral 
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

entity RF is
    Port ( Ard1 	: in  STD_LOGIC_VECTOR (4 downto 0);
           Ard2 	: in  STD_LOGIC_VECTOR (4 downto 0);
           Awr 	: in  STD_LOGIC_VECTOR (4 downto 0);
           Dout1  : out  STD_LOGIC_VECTOR (31 downto 0);
           Dout2 	: out  STD_LOGIC_VECTOR (31 downto 0);
           Din 	: in  STD_LOGIC_VECTOR (31 downto 0);
           WrEn 	: in  STD_LOGIC;
           clk 	: in  STD_LOGIC;
			  rst 	: in STD_LOGIC);
end RF;

architecture Behavioral of RF is

--Decoder
component Decoder is
	Port(Dec_IN  : in  STD_LOGIC_VECTOR (4 downto 0);
		  Dec_OUT : out STD_LOGIC_VECTOR (31 downto 0));
end component;

--Register
component Register_comp is
	Port(clk 	 : IN  std_logic;
		  rst 	 : IN  std_logic;
        DataIN  : IN  std_logic_vector(31 downto 0);
        WE 		 : IN  std_logic;
        DataOUT : OUT  std_logic_vector(31 downto 0));
end component;

--	Multiplexers:

--  i) MUX32
component MUX32 is
    Port ( R0  : in  STD_LOGIC_VECTOR (31 downto 0);
           R1  : in  STD_LOGIC_VECTOR (31 downto 0);
           R2  : in  STD_LOGIC_VECTOR (31 downto 0);
           R3  : in  STD_LOGIC_VECTOR (31 downto 0);
           R4  : in  STD_LOGIC_VECTOR (31 downto 0);
           R5  : in  STD_LOGIC_VECTOR (31 downto 0);
           R6  : in  STD_LOGIC_VECTOR (31 downto 0);
           R7  : in  STD_LOGIC_VECTOR (31 downto 0);
           R8  : in  STD_LOGIC_VECTOR (31 downto 0);
           R9  : in  STD_LOGIC_VECTOR (31 downto 0);
           R10 : in  STD_LOGIC_VECTOR (31 downto 0);
           R11 : in  STD_LOGIC_VECTOR (31 downto 0);
           R12 : in  STD_LOGIC_VECTOR (31 downto 0);
           R13 : in  STD_LOGIC_VECTOR (31 downto 0);
           R14 : in  STD_LOGIC_VECTOR (31 downto 0);
           R15 : in  STD_LOGIC_VECTOR (31 downto 0);
           R16 : in  STD_LOGIC_VECTOR (31 downto 0);
           R17 : in  STD_LOGIC_VECTOR (31 downto 0);
           R18 : in  STD_LOGIC_VECTOR (31 downto 0);
           R19 : in  STD_LOGIC_VECTOR (31 downto 0);
           R20 : in  STD_LOGIC_VECTOR (31 downto 0);
           R21 : in  STD_LOGIC_VECTOR (31 downto 0);
           R22 : in  STD_LOGIC_VECTOR (31 downto 0);
           R23 : in  STD_LOGIC_VECTOR (31 downto 0);
           R24 : in  STD_LOGIC_VECTOR (31 downto 0);
           R25 : in  STD_LOGIC_VECTOR (31 downto 0);
           R26 : in  STD_LOGIC_VECTOR (31 downto 0);
           R27 : in  STD_LOGIC_VECTOR (31 downto 0);
           R28 : in  STD_LOGIC_VECTOR (31 downto 0);
           R29 : in  STD_LOGIC_VECTOR (31 downto 0);
           R30 : in  STD_LOGIC_VECTOR (31 downto 0);
           R31 : in  STD_LOGIC_VECTOR (31 downto 0);
           SEL : in  STD_LOGIC_VECTOR (4 downto 0);
           D_OUT : out  STD_LOGIC_VECTOR (31 downto 0));
end component;		  

-- ii) MUX2
component MUX2 is
    Port ( In0     : in  STD_LOGIC_VECTOR (31 downto 0);
           In1 	 : in  STD_LOGIC_VECTOR (31 downto 0);
           Mux_out : out  STD_LOGIC_VECTOR (31 downto 0);
           SEL 	 : in  STD_LOGIC);
end component;


--Comparator
component Comparator is
    Port ( sel1 : in  STD_LOGIC_VECTOR (4 downto 0);
           sel2 : in  STD_LOGIC_VECTOR (4 downto 0);
           comp_out : out  STD_LOGIC);
end component;




--Signals:

--Decoder output
signal s_Decoder_out : std_logic_vector(31 downto 0);

--Each register 32-bit bus output
type array_R_out is array (0 to 31) of std_logic_vector(31 downto 0);
signal s_R_out : array_R_out;


--Each registers' Write Enable pin
signal s_R_WE : std_logic_vector(31 downto 0);

--Outputs of the 2 MUX32:
signal s_MUX32_out1, s_MUX32_out2 : std_logic_vector(31 downto 0);

--Outputs of the 2 Comparators
signal s_Comparator_out1, s_Comparator_out2 : std_logic;

--Outputs of the 2 MUX2:
signal s_MUX2_out1, s_MUX2_out2 : std_logic;






begin

--Decoder port map
Dec:	Decoder port map(Dec_IN  => Awr, Dec_OUT => s_Decoder_out);


--Write enable for all registers
process
begin		  
for i in 0 to 31 loop
s_R_WE(i) <= WrEn and s_Decoder_out(i);
end loop;
end process;


--Register port maps

R0: Register_comp port map (clk => clk, 
									 DataIN => Din,
									 DataOUT => "00000000000000000000000000000000",
									 WE => s_R_WE(0),
									 rst => rst);
									 
Register_gen: for k in 31 downto 1 generate

R: Register_comp port map (clk => clk,
									DataIN => Din,
									DataOUT => s_R_out(k),
									WE => s_R_WE(k),
									rst => rst);

end generate Register_gen;


end Behavioral;

