----------------------------------------------------------------------------------
-- Insitute: TUC
-- Engineer(s): Michailidis Stergios , Dimitrios Angelopoulos
-- 
-- Create Date:    19:11:22 03/10/2023 
-- Design Name: 	 ALU
-- Module Name:    ALUentity - AluArchitecture 
-- Project Name: 	 Phase 1 , ALU
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
use IEEE.STD_LOGIC_SIGNED.ALL;
use IEEE.std_logic_arith.all;
use IEEE.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ALUentity is
    Port ( A : in  STD_LOGIC_VECTOR(31 downto 0);
           B : in  STD_LOGIC_VECTOR(31 downto 0);
           Op : in  STD_LOGIC_VECTOR(3 downto 0);
           ALU_Out : out  STD_LOGIC_VECTOR(31 downto 0);
           Zero : out  STD_LOGIC;
           Cout : out  STD_LOGIC;
           Ovf : out  STD_LOGIC);
end ALUentity;

architecture Behavioral of ALUentity is
	
signal atemp : STD_LOGIC_VECTOR(31 downto 0);
	
begin

process(A,B,Op)
begin
	case Op is
		when "0000" =>
			ALU_Out <= A + B;
		when "0001" =>
			ALU_Out <= A + NOT(B) + 1;
		when "0010" =>
			ALU_Out <= A AND B;
		when "0011" =>
			ALU_Out <= A OR B;
		when "0100" =>
			ALU_Out <= NOT(A);
		when "1000" =>	--shift right arithmetic 
			atemp(30 downto 0) <= A(31 downto 1);
			atemp(31) <= A(31);
			ALU_Out <= atemp;
		when "1001" =>	--shift right logical
			atemp(30 downto 0) <= A(31 downto 1);
			atemp(31) <= '0';
			ALU_Out <= atemp;
		when "1010" =>	--shift left logical
			atemp(31 downto 1) <= A(30 downto 0);
			atemp(0) <= '0';
			ALU_Out <= atemp;
		when "1100" =>	--shift left rotate
			atemp(31 downto 1) <= A(30 downto 0);
			atemp(0) <= A(31);
			ALU_Out <= atemp;
		when "1101" =>	--shift right rotate
			atemp(30 downto 0) <= A(31 downto 1);
			atemp(31) <= A(0);
			ALU_Out <= atemp;
		when others =>
			ALU_out <= "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
	end case;
	
end process;

end Behavioral;

