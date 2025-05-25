--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   11:16:12 05/08/2024
-- Design Name:   
-- Module Name:   /home/ise/Desktop/HRY_302/p1/DATAPATH_test.vhd
-- Project Name:  p1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: DATAPATH
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
 
ENTITY DATAPATH_test IS
END DATAPATH_test;
 
ARCHITECTURE behavior OF DATAPATH_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT DATAPATH
    PORT(
         PC_sel : IN  std_logic;
         PC_LdEn : IN  std_logic;
         RF_WrEn : IN  std_logic;
         RF_WrData_sel : IN  std_logic;
         RF_B_sel : IN  std_logic;
         ALU_Bin_sel : IN  std_logic;
         ALU_func : IN  std_logic_vector(3 downto 0);
         MEM_WrEn : IN  std_logic;
         clk : IN  std_logic;
         rst : IN  std_logic;
         ByteFlag : IN  std_logic;
         Instruction : OUT  std_logic_vector(31 downto 0);
         ALU_zero : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal PC_sel : std_logic := '0';
   signal PC_LdEn : std_logic := '0';
   signal RF_WrEn : std_logic := '0';
   signal RF_WrData_sel : std_logic := '0';
   signal RF_B_sel : std_logic := '0';
   signal ALU_Bin_sel : std_logic := '0';
   signal ALU_func : std_logic_vector(3 downto 0) := (others => '0');
   signal MEM_WrEn : std_logic := '0';
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';
   signal ByteFlag : std_logic := '0';

 	--Outputs
   signal Instruction : std_logic_vector(31 downto 0);
   signal ALU_zero : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: DATAPATH PORT MAP (
          PC_sel => PC_sel,
          PC_LdEn => PC_LdEn,
          RF_WrEn => RF_WrEn,
          RF_WrData_sel => RF_WrData_sel,
          RF_B_sel => RF_B_sel,
          ALU_Bin_sel => ALU_Bin_sel,
          ALU_func => ALU_func,
          MEM_WrEn => MEM_WrEn,
          clk => clk,
          rst => rst,
          ByteFlag => ByteFlag,
          Instruction => Instruction,
          ALU_zero => ALU_zero
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
		rst <= '1';
      wait for 100 ns;	
		rst <= '0';
		
		-- first instruction: li r1 , 6
		wait for 10 ns;
			PC_sel 		  <= '0'; -- +4
			PC_LdEn 		  <= '1'; -- 
			RF_WrEn 		  <= '1'; -- Write at destination register
			RF_WrData_sel <= '0'; -- ALU out
			RF_B_sel		  <= '1'; -- I-type
			ALU_Bin_sel	  <= '1'; -- Immed 
			ALU_func		  <= "0000"; -- Addition
			MEM_WrEn 	  <= '0'; -- No mem write
			ByteFlag		  <= '0';
			
		-- second instruction: li r2 , 6
		wait for 10 ns;
			PC_sel 		  <= '0'; -- +4
			PC_LdEn 		  <= '1'; -- 
			RF_WrEn 		  <= '1'; -- Write at destination register
			RF_WrData_sel <= '0'; -- ALU out
			RF_B_sel		  <= '1'; -- I-type
			ALU_Bin_sel	  <= '1'; -- Immed 
			ALU_func		  <= "0000"; -- Addition
			MEM_WrEn 	  <= '0'; -- No mem write
			ByteFlag		  <= '0';
		
		-- third instruction: add r1,r3,r2
		wait for 10 ns;
			PC_sel 		  <= '0';  
			PC_LdEn 		  <= '1'; 		
			RF_WrEn 		  <= '1'; 
			RF_WrData_sel <= '0'; 		
			RF_B_sel		  <= '0'; 	
			ALU_Bin_sel	  <= '0'; 
			ALU_func		  <= "0000";
			MEM_WrEn 	  <= '0'; 
			ByteFlag		  <= '0';
			
			
		

      wait;
   end process;

END;
