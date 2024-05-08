----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:56:17 05/07/2024 
-- Design Name: 
-- Module Name:    ComputeUnit - Behavioral 
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

entity ComputeUnit is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC);
end ComputeUnit;

architecture Behavioral of ComputeUnit is

component CONTROL is
    Port ( INSTRUCTION : in  STD_LOGIC_VECTOR (31 downto 0);
           PC_sel : out  STD_LOGIC;
           PC_LdEn : out  STD_LOGIC;
           RF_WrEn : out  STD_LOGIC;
           RF_WrData_sel : out  STD_LOGIC;
           RF_B_sel : out  STD_LOGIC;
           ALU_Bin_sel : out  STD_LOGIC;
           ALU_func : out  STD_LOGIC_VECTOR (3 downto 0);
           MEM_WrEn : out  STD_LOGIC;
			  ByteFlag : out	STD_LOGIC;
           clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
			  ALU_zero : in STD_LOGIC);
end component;

component DATAPATH is
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
			  ByteFlag: in STD_LOGIC;
           Instruction : out  STD_LOGIC_VECTOR (31 downto 0);
			  ALU_zero : out STD_LOGIC);
end component;


-- control signals
signal PC_sel  : std_logic;
signal PC_LdEn : std_logic;
signal RF_WrEn : std_logic;
signal RF_WrData_sel : std_logic;
signal RF_B_sel : std_logic;
signal ALU_Bin_sel :std_logic;
signal ALU_func : std_logic_vector(3 downto 0);
signal MEM_WrEn : std_logic;
signal ByteFlag : std_logic;

-- instruction
signal instruction : std_logic_vector(31 downto 0);
signal zero_flag 	 : std_logic;

begin


sc_datapath: DATAPATH Port map( PC_sel => PC_sel,
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
										  Instruction => instruction,
										  ALU_zero => zero_flag);
										  
sc_control: CONTROL Port map ( INSTRUCTION => instruction,
										 PC_sel => PC_sel,
										 PC_LdEn => PC_LdEn,
										 RF_WrEn => RF_WrEn,
										 RF_WrData_sel => RF_WrData_sel,
										 RF_B_sel => RF_B_sel,
										 ALU_Bin_sel => ALU_Bin_sel,
										 ALU_func => ALU_func,
										 MEM_WrEn => MEM_WrEn,
										 ByteFlag => ByteFlag,
										 clk => clk,
										 rst => rst,
										 ALU_zero => zero_flag);


end Behavioral;

