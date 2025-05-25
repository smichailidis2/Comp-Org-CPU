----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:20:32 06/21/2024 
-- Design Name: 
-- Module Name:    FWD_Unit - Behavioral 
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

entity FWD_Unit is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           INSTR : in  STD_LOGIC_VECTOR (31 downto 0);
           selectOperand1 : out  STD_LOGIC;
           selectOperand2 : out  STD_LOGIC;
           selectDelayTarget : out  STD_LOGIC;
			  selectDelaySource : out  STD_LOGIC);
end FWD_Unit;

architecture Behavioral of FWD_Unit is

component Register_comp is
	Port ( clk : in  STD_LOGIC;
			 DataIN : in  STD_LOGIC_VECTOR (31 downto 0);
			 DataOUT : out  STD_LOGIC_VECTOR (31 downto 0);
			 WE : in  STD_LOGIC;
			 rst : in  STD_LOGIC);
end component;

component Register_comp1 is
	Port ( clk : in  STD_LOGIC;
			 DataIN : in  STD_LOGIC;
			 DataOUT : out  STD_LOGIC;
			 WE : in  STD_LOGIC;
			 rst : in  STD_LOGIC);
end component;

signal prev_instr1: std_logic_vector(31 downto 0) := (others => '0') ;
signal prev_instr2: std_logic_vector(31 downto 0) := (others => '0') ;

signal OPCODE: std_logic_vector(5 downto 0);
signal Rs	 : std_logic_vector(4 downto 0);
signal Rt	 : std_logic_vector(4 downto 0);
signal Rd	 : std_logic_vector(4 downto 0);

signal OPCODE1: std_logic_vector(5 downto 0);
signal Rs1	  : std_logic_vector(4 downto 0);
signal Rt1	  : std_logic_vector(4 downto 0);
signal Rd1	  : std_logic_vector(4 downto 0);

signal OPCODE2: std_logic_vector(5 downto 0);
signal Rs2	  : std_logic_vector(4 downto 0);
signal Rt2	  : std_logic_vector(4 downto 0);
signal Rd2	  : std_logic_vector(4 downto 0);

signal branch_flag: std_logic := '0';


signal output_delayed: std_logic_vector(3 downto 0);

begin



INSTRreg1: Register_comp port map (clk => clk,
											  DataIN => INSTR,
											  DataOUT => prev_instr1,
											  WE => '1',
											  rst => rst);
											 
INSTRreg2: Register_comp port map (clk => clk,
											  DataIN => prev_instr1,
											  DataOUT => prev_instr2,
											  WE => '1',
											  rst => rst);
			
			
OPCODE <= INSTR(31 downto 26);
Rs	    <= INSTR(25 downto 21);
Rd	 	 <= INSTR(20 downto 16);
Rt	    <= INSTR(15 downto 11);

OPCODE1 <= prev_instr1(31 downto 26);
Rs1	  <= prev_instr1(25 downto 21);
Rd1	  <= prev_instr1(20 downto 16);
Rt1	  <= prev_instr1(15 downto 11);

OPCODE2 <= prev_instr2(31 downto 26);
Rs2     <= prev_instr2(25 downto 21);
Rd2     <= prev_instr2(20 downto 16);
Rt2     <= prev_instr2(15 downto 11);
											 
-- INSTR: instruction at time k (in T sec)
process

begin

wait until clk'EVENT AND clk='1';

if rst = '1' then
	selectOperand1 <= '0';
	selectOperand2 <= '0';
	selectDelaySource <= '0';
	selectDelayTarget <= '0';

else
	if INSTR = "00000000000000000000000000000000" then
		selectOperand1 <= '0';
		selectOperand2 <= '0';
		selectDelaySource <= '0';
		selectDelayTarget <= '0';
	else
		if OPCODE = "111111" or OPCODE = "010000" or OPCODE = "010001" then
			branch_flag <= '1';
		end if;
		-- R-type instructions TODO exclude Rs Rt = "00000"
		if OPCODE = "100000" then
			-- k-1, k RAW hazard
			if Rd1 = Rt then
				selectDelaySource <= '0';
				selectDelayTarget <= '0';
				selectOperand1 <= '0';
				selectOperand2 <= '1';
			end if;
			if Rd1 = Rs then
				selectDelaySource <= '0';
				selectDelayTarget <= '0';
				selectOperand1 <= '1';
				selectOperand2 <= '0';
			end if;
			-- k-2, k RAW hazard
			if Rd2 = Rt then
				selectDelaySource <= '0';
				selectDelayTarget <= '1';
				selectOperand1 <= '0';
				selectOperand2 <= '1';
			end if;
			if Rd2 = Rs then
				selectDelaySource <= '1';
				selectDelayTarget <= '0';
				selectOperand1 <= '1';
				selectOperand2 <= '0';
			end if;			
			
			-- both k-1,k and k-2,k RAW HAZARD
			if Rs = Rd1 and Rt = Rd2 then
				selectOperand1 <= '1';
				selectOperand2 <= '1';
				selectDelaySource <= '0';
				selectDelayTarget <= '1';
			end if;
			
			if Rs = Rd2 and Rt = Rd1 then
				selectOperand1 <= '1';
				selectOperand2 <= '1';
				selectDelaySource <= '1';
				selectDelayTarget <= '0';
			end if;			
			
		end if;
		
		-- I-type no brnach no li
		if OPCODE /= "100000" and OPCODE /= "111000" and branch_flag = '0' then
			-- k-1, k RAW hazard
			if Rd1 = Rs then
				selectOperand1 <= '1';
				selectOperand2 <= '0';
				selectDelaySource <= '0';
				selectDelayTarget <= '0';
			end if;	
			
			-- k-2, k RAW hazard
			if Rd2 = Rs then
				selectOperand1 <= '1';
				selectOperand2 <= '0';
				selectDelaySource <= '1';
				selectDelayTarget <= '0';
			end if;	
				
		end if;
		
		
	end if;
	
	
	
end if;
end process;

end Behavioral;

