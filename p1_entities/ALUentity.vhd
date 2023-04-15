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
	
signal atemp		   : STD_LOGIC_VECTOR (31 downto 0);
signal result 			: std_logic_vector (31 downto 0);
signal carry_detect  : std_logic_vector (32 downto 0);
signal MSB_flag 		: STD_LOGIC;
	
begin

process(A,B,Op)
begin
	case Op is
		when "0000" =>
			result <= A + B;
		when "0001" =>
			result <= A + NOT(B) + 1;
		when "0010" =>
			result <= A AND B;
		when "0011" =>
			result <= A OR B;
		when "0100" =>
			result <= NOT(A);
		when "1000" =>	--shift right arithmetic 
			atemp(30 downto 0) <= A(31 downto 1);
			atemp(31) <= A(31);
			result <= atemp;
		when "1001" =>	--shift right logical
			atemp(30 downto 0) <= A(31 downto 1);
			atemp(31) <= '0';
			result <= atemp;
		when "1010" =>	--shift left logical
			atemp(31 downto 1) <= A(30 downto 0);
			atemp(0) <= '0';
			result <= atemp;
		when "1100" =>	--shift left rotate
			atemp(31 downto 1) <= A(30 downto 0);
			atemp(0) <= A(31);
			result <= atemp;
		when "1101" =>	--shift right rotate
			atemp(30 downto 0) <= A(31 downto 1);
			atemp(31) <= A(0);
			result <= atemp;
		when others =>
			result <= "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
	end case;	
end process;

ALU_Out <= result;

--if result == 0 then Zero <= 1
zero <= '1' when result="00000000000000000000000000000000" else '0';
	
MSB_flag <= A(31) XOR B(31);
--when MSB_flag = '1' signs are different, no ovf.
--when MSB_flag = '0' same signs, could have ovf:
-- if MSB(result) =/= MSB(A) we have ovf.
-- if MSB(result) ==  MSB(A) we DO NOT have ovf.
Ovf <= A(31) XOR result(31) when MSB_flag='0' else '0'; 

--	To find if we have carry out first concatenate A with a single 0 
--and B with a single 0 (from the left) to make them 33 bits,
--then add them together.If the msb of the carry_detect is high,we have carry out. 
carry_detect <= ('0' & A) + ('0' & B);	
Cout <= carry_detect(32);

end Behavioral;

