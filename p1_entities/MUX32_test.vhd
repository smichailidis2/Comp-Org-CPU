--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   12:45:22 04/11/2023
-- Design Name:   
-- Module Name:   /home/ise/Desktop/HRY_302/p1/MUX32_test.vhd
-- Project Name:  p1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: MUX32
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY MUX32_test IS
END MUX32_test;
 
ARCHITECTURE behavior OF MUX32_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT MUX32
    PORT(
         R0 : IN  std_logic_vector(31 downto 0);
         R1 : IN  std_logic_vector(31 downto 0);
         R2 : IN  std_logic_vector(31 downto 0);
         R3 : IN  std_logic_vector(31 downto 0);
         R4 : IN  std_logic_vector(31 downto 0);
         R5 : IN  std_logic_vector(31 downto 0);
         R6 : IN  std_logic_vector(31 downto 0);
         R7 : IN  std_logic_vector(31 downto 0);
         R8 : IN  std_logic_vector(31 downto 0);
         R9 : IN  std_logic_vector(31 downto 0);
         R10 : IN  std_logic_vector(31 downto 0);
         R11 : IN  std_logic_vector(31 downto 0);
         R12 : IN  std_logic_vector(31 downto 0);
         R13 : IN  std_logic_vector(31 downto 0);
         R14 : IN  std_logic_vector(31 downto 0);
         R15 : IN  std_logic_vector(31 downto 0);
         R16 : IN  std_logic_vector(31 downto 0);
         R17 : IN  std_logic_vector(31 downto 0);
         R18 : IN  std_logic_vector(31 downto 0);
         R19 : IN  std_logic_vector(31 downto 0);
         R20 : IN  std_logic_vector(31 downto 0);
         R21 : IN  std_logic_vector(31 downto 0);
         R22 : IN  std_logic_vector(31 downto 0);
         R23 : IN  std_logic_vector(31 downto 0);
         R24 : IN  std_logic_vector(31 downto 0);
         R25 : IN  std_logic_vector(31 downto 0);
         R26 : IN  std_logic_vector(31 downto 0);
         R27 : IN  std_logic_vector(31 downto 0);
         R28 : IN  std_logic_vector(31 downto 0);
         R29 : IN  std_logic_vector(31 downto 0);
         R30 : IN  std_logic_vector(31 downto 0);
         R31 : IN  std_logic_vector(31 downto 0);
         SEL : IN  std_logic_vector(4 downto 0);
         D_OUT : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal R0 : std_logic_vector(31 downto 0) := (others => '0');
   signal R1 : std_logic_vector(31 downto 0) := (others => '0');
   signal R2 : std_logic_vector(31 downto 0) := (others => '0');
   signal R3 : std_logic_vector(31 downto 0) := (others => '0');
   signal R4 : std_logic_vector(31 downto 0) := (others => '0');
   signal R5 : std_logic_vector(31 downto 0) := (others => '0');
   signal R6 : std_logic_vector(31 downto 0) := (others => '0');
   signal R7 : std_logic_vector(31 downto 0) := (others => '0');
   signal R8 : std_logic_vector(31 downto 0) := (others => '0');
   signal R9 : std_logic_vector(31 downto 0) := (others => '0');
   signal R10 : std_logic_vector(31 downto 0) := (others => '0');
   signal R11 : std_logic_vector(31 downto 0) := (others => '0');
   signal R12 : std_logic_vector(31 downto 0) := (others => '0');
   signal R13 : std_logic_vector(31 downto 0) := (others => '0');
   signal R14 : std_logic_vector(31 downto 0) := (others => '0');
   signal R15 : std_logic_vector(31 downto 0) := (others => '0');
   signal R16 : std_logic_vector(31 downto 0) := (others => '0');
   signal R17 : std_logic_vector(31 downto 0) := (others => '0');
   signal R18 : std_logic_vector(31 downto 0) := (others => '0');
   signal R19 : std_logic_vector(31 downto 0) := (others => '0');
   signal R20 : std_logic_vector(31 downto 0) := (others => '0');
   signal R21 : std_logic_vector(31 downto 0) := (others => '0');
   signal R22 : std_logic_vector(31 downto 0) := (others => '0');
   signal R23 : std_logic_vector(31 downto 0) := (others => '0');
   signal R24 : std_logic_vector(31 downto 0) := (others => '0');
   signal R25 : std_logic_vector(31 downto 0) := (others => '0');
   signal R26 : std_logic_vector(31 downto 0) := (others => '0');
   signal R27 : std_logic_vector(31 downto 0) := (others => '0');
   signal R28 : std_logic_vector(31 downto 0) := (others => '0');
   signal R29 : std_logic_vector(31 downto 0) := (others => '0');
   signal R30 : std_logic_vector(31 downto 0) := (others => '0');
   signal R31 : std_logic_vector(31 downto 0) := (others => '0');
   signal SEL : std_logic_vector(4 downto 0) := (others => '0');

 	--Outputs
   signal D_OUT : std_logic_vector(31 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: MUX32 PORT MAP (
          R0 => R0,
          R1 => R1,
          R2 => R2,
          R3 => R3,
          R4 => R4,
          R5 => R5,
          R6 => R6,
          R7 => R7,
          R8 => R8,
          R9 => R9,
          R10 => R10,
          R11 => R11,
          R12 => R12,
          R13 => R13,
          R14 => R14,
          R15 => R15,
          R16 => R16,
          R17 => R17,
          R18 => R18,
          R19 => R19,
          R20 => R20,
          R21 => R21,
          R22 => R22,
          R23 => R23,
          R24 => R24,
          R25 => R25,
          R26 => R26,
          R27 => R27,
          R28 => R28,
          R29 => R29,
          R30 => R30,
          R31 => R31,
          SEL => SEL,
          D_OUT => D_OUT
        );


   -- Stimulus process
   stim_proc: process
   begin		
      
		R0 <= "00000000000000000000000000000001";
		R1 <= "00000000000000000000000000000010";
		R2 <= "00000000000000000000000000000011";
		R3 <= "00000000000000000000000000000100";
		R4 <= "00000000000000000000000000000101";

		SEL <= "00000";
		
      wait for 100 ns;	
		
		
		R0 <= "00000000000000000000000000000001";
		R1 <= "00000000000000000000000000000010";
		R2 <= "00000000000000000000000000000011";
		R3 <= "00000000000000000000000000000100";
		R4 <= "00000000000000000000000000000101";

		SEL <= "00001";
		
		wait for 100 ns;


		R0 <= "00000000000000000000000000000001";
		R1 <= "00000000000000000000000000000010";
		R2 <= "00000000000000000000000000000011";
		R3 <= "00000000000000000000000000000100";
		R4 <= "00000000000000000000000000000101";

		SEL <= "00010";
		
		wait for 100 ns;



		R0 <= "00000000000000000000000000000001";
		R1 <= "00000000000000000000000000000010";
		R2 <= "00000000000000000000000000000011";
		R3 <= "00000000000000000000000000000100";
		R4 <= "00000000000000000000000000000101";

		SEL <= "00011";
		
		wait for 100 ns;



		R0 <= "00000000000000000000000000000001";
		R1 <= "00000000000000000000000000000010";
		R2 <= "00000000000000000000000000000011";
		R3 <= "00000000000000000000000000000100";
		R4 <= "00000000000000000000000000000101";
		
		SEL <= "00100";
		
		wait for 100 ns;

      -- insert stimulus here 

      wait;
   end process;

END;
