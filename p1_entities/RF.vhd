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
use ieee.numeric_std.ALL;

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

--We have 2 outputs from 32-bit multiplexers
type array_MUX32_out is array (0 to 1) of std_logic_vector(31 downto 0);
signal s_mux32_out : array_MUX32_out;

--And 2 outputs from 2-bit multiplexers
type array_MUX2_out is array (0 to 1) of std_logic_vector (31 downto 0);
signal s_mux2_out : array_MUX2_out;


--Each registers' Write Enable pin
signal s_R_WE : std_logic_vector(31 downto 0);

--Output bus of the 2 Comparators
signal s_Comparator_out : std_logic_vector(1 downto 0);

------
-- to avoid function call in MUX2 port map:
type array_select_mux2 is array (0 to 1) of std_logic;
signal s_mux2_select : array_select_mux2;
------

--Input signals array (ard1 , ard2)
type array_of_ReadInputs is array (0 to 1) of std_logic_vector(4 downto 0);
signal s_input_rArray : array_of_ReadInputs;

--MUX2 SELECT SIGNAL BUS
signal mux2select_bus : std_logic_vector(1 downto 0);

-- zero constant for R0
signal zero_constant : std_logic_vector(31 downto 0) := (others => '0');




begin

s_R_out(0) <= zero_constant;

s_input_rArray(0) <= Ard1;
s_input_rArray(1) <= Ard2;

-- mux2 select signals
s_mux2_select(0) <= s_comparator_out(0) and WrEn;
s_mux2_select(1) <= s_comparator_out(1) and WrEn;

--Decoder port map
Dec:	Decoder port map(Dec_IN  => Awr, Dec_OUT => s_Decoder_out);


--	Write enable for all registers
--process
--begin		  
--for i in 0 to 31 loop
--s_R_WE(i) <= WrEn and s_Decoder_out(i);
--end loop;
--end process;
s_R_WE(0)  <= WrEn and s_Decoder_out(0);
s_R_WE(1)  <= WrEn and s_Decoder_out(1);
s_R_WE(2)  <= WrEn and s_Decoder_out(2);
s_R_WE(3)  <= WrEn and s_Decoder_out(3);
s_R_WE(4)  <= WrEn and s_Decoder_out(4);
s_R_WE(5)  <= WrEn and s_Decoder_out(5);
s_R_WE(6)  <= WrEn and s_Decoder_out(6);
s_R_WE(7)  <= WrEn and s_Decoder_out(7);
s_R_WE(8)  <= WrEn and s_Decoder_out(8);
s_R_WE(9)  <= WrEn and s_Decoder_out(9);
s_R_WE(10) <= WrEn and s_Decoder_out(10);
s_R_WE(11) <= WrEn and s_Decoder_out(11);
s_R_WE(12) <= WrEn and s_Decoder_out(12);
s_R_WE(13) <= WrEn and s_Decoder_out(13);
s_R_WE(14) <= WrEn and s_Decoder_out(14);
s_R_WE(15) <= WrEn and s_Decoder_out(15);
s_R_WE(16) <= WrEn and s_Decoder_out(16);
s_R_WE(17) <= WrEn and s_Decoder_out(17);
s_R_WE(18) <= WrEn and s_Decoder_out(18);
s_R_WE(19) <= WrEn and s_Decoder_out(19);
s_R_WE(20) <= WrEn and s_Decoder_out(20);
s_R_WE(21) <= WrEn and s_Decoder_out(21);
s_R_WE(22) <= WrEn and s_Decoder_out(22);
s_R_WE(23) <= WrEn and s_Decoder_out(23);
s_R_WE(24) <= WrEn and s_Decoder_out(24);
s_R_WE(25) <= WrEn and s_Decoder_out(25);
s_R_WE(26) <= WrEn and s_Decoder_out(26);
s_R_WE(27) <= WrEn and s_Decoder_out(27);
s_R_WE(28) <= WrEn and s_Decoder_out(28);
s_R_WE(29) <= WrEn and s_Decoder_out(29);
s_R_WE(30) <= WrEn and s_Decoder_out(30);
s_R_WE(31) <= WrEn and s_Decoder_out(31);


--Register port maps

-- R0 is always zero
--R0: Register_comp port map (clk => clk, 
--									 DataIN => Din,
--									 DataOUT => zero_constant,
--									 WE => s_R_WE(0),
--									 rst => rst);

-- all the rest
Register_gen: for k in 0 to 31 generate

R: Register_comp port map (clk => clk,
									DataIN => Din,
									DataOUT => s_R_out(k),
									WE => s_R_WE(k),
									rst => rst);

end generate Register_gen;

--COMPARATOR PORT MAPS

Comparator_gen: for h in 0 to 1 generate

Compar : Comparator port map(sel1 => Awr,
									  sel2 => s_input_rArray(h),
									  comp_out => s_Comparator_out(h));

end generate Comparator_gen;





--MUX port maps

-- i) 2 mux32:

MUX32_gen: for n in 0 to 1 generate

Mult32: MUX32 port map (R0  => s_R_out(0),
								R1  => s_R_out(1),
								R2  => s_R_out(2),
								R3  => s_R_out(3),
								R4  => s_R_out(4),
								R5  => s_R_out(5),
								R6  => s_R_out(6),
								R7  => s_R_out(7),
								R8  => s_R_out(8),
								R9  => s_R_out(9),
								R10 => s_R_out(10),
								R11 => s_R_out(11),
								R12 => s_R_out(12),
								R13 => s_R_out(13),
								R14 => s_R_out(14),
								R15 => s_R_out(15),
								R16 => s_R_out(16),
								R17 => s_R_out(17),
								R18 => s_R_out(18),
								R19 => s_R_out(19),
								R20 => s_R_out(20),
								R21 => s_R_out(21),
								R22 => s_R_out(22),
								R23 => s_R_out(23),
								R24 => s_R_out(24),
								R25 => s_R_out(25),
								R26 => s_R_out(26),
								R27 => s_R_out(27),
								R28 => s_R_out(28),
								R29 => s_R_out(29),
								R30 => s_R_out(30),
								R31 => s_R_out(31),
								SEL => s_input_rArray(n),
								D_OUT => s_mux32_out(n));

end generate MUX32_gen;

-- ii) 2 mux2: 

MUX2_gen: for j in 0 to 1 generate

Mult2: MUX2 port map (In0 => s_mux32_out(j),
							 In1 => Din,
							 Mux_out => s_mux2_out(j),
							 SEL => s_mux2_select(j));

end generate MUX2_gen;

Dout1 <= s_mux2_out(0);
Dout2 <= s_mux2_out(1);


end Behavioral;

