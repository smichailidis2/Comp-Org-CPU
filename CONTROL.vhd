library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity CONTROL is
    Port ( INSTRUCTION : in  STD_LOGIC_VECTOR (31 downto 0);
           CONTROL_OUT : out STD_LOGIC_VECTOR (15 downto 0);
           clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
			  ALU_zero : in STD_LOGIC);
end CONTROL;


architecture Behavioral of CONTROL is

signal Opcode : std_logic_vector(5 downto 0);
signal Func	  : std_logic_vector(3 downto 0);

signal  PC_sel  :  		 STD_LOGIC;
signal  PC_LdEn :  		 STD_LOGIC;
signal  RF_WrEn :  		 STD_LOGIC;
signal  RF_WrData_sel :  STD_LOGIC;
signal  RF_B_sel :  		 STD_LOGIC;
signal  ALU_Bin_sel :  	 STD_LOGIC;
signal  ALU_func :  		 STD_LOGIC_VECTOR (3 downto 0);
signal  MEM_WrEn :  		 STD_LOGIC;
signal  ByteFlag : 		 STD_LOGIC;
signal  IFreg_WrEn : 	 STD_LOGIC;
signal  DECreg_WrEn : 	 STD_LOGIC;
signal  EXECreg_WrEn :   STD_LOGIC;
signal  MEMreg_WrEn :	 STD_LOGIC;


begin

Opcode <= INSTRUCTION(31 downto 26);
Func   <= INSTRUCTION(3 downto 0);



process(clk,rst)
begin

if rst = '1' then
		PC_sel 		  <= '0';
		PC_LdEn 		  <= '0';
		RF_WrEn 		  <= '0';
		RF_WrData_sel <= '0';
		RF_B_sel		  <= '0';
		ALU_Bin_sel	  <= '0';
		ALU_func		  <= "0000";
		MEM_WrEn 	  <= '0';
		ByteFlag		  <= '0';
		IFreg_WrEn   <= '0';
		DECreg_WrEn  <= '0';
		EXECreg_WrEn <= '0';
		MEMreg_WrEn  <= '0';
		
elsif INSTRUCTION = "00000000000000000000000000000000" then -- NOP
		PC_sel 		  <= '0';
		PC_LdEn 		  <= '1';
		RF_WrEn 		  <= '0';
		RF_WrData_sel <= '0';
		RF_B_sel		  <= '0';
		ALU_Bin_sel	  <= '0';
		ALU_func		  <= "0000";
		MEM_WrEn 	  <= '0';
		ByteFlag		  <= '0';
		IFreg_WrEn   <= '1';  -- 
		DECreg_WrEn  <= '1';  -- 
		EXECreg_WrEn <= '1';  -- 
		MEMreg_WrEn  <= '1';  -- 

else	
	IFreg_WrEn   <= '1';
	DECreg_WrEn  <= '1';
	EXECreg_WrEn <= '1';
	MEMreg_WrEn  <= '1';
	case Opcode is
		-- R-type instructions:
		when "100000" =>
			PC_sel 		  <= '0'; -- 		PC select is LOW 				(next instruction, not branch)
			PC_LdEn 		  <= '1'; --		PC load enable is HIGH 
			RF_WrEn 		  <= '1'; --		RF Write enable is HIGH 		(Due to R-R operation)
			RF_WrData_sel <= '0'; --		RF Write data select is LOW  (Select ALU out)
			RF_B_sel		  <= '0'; --		RF B select is LOW
			ALU_Bin_sel	  <= '0'; --		ALU Bin select is LOW 			(Select RF[B] for ALU operation)
			ALU_func		  <= Func;--		ALU func is the 4 bit bus Func
			MEM_WrEn 	  <= '0'; --		MEM Write enable is LOW 		(No memory write)
			ByteFlag		  <= '0';

		-- 		li   |   lui    | addi     : I-type instruction(s)
		when "111000" | "111001" | "110000" =>
			PC_sel 		  <= '0'; -- +4
			PC_LdEn 		  <= '1'; -- 
			RF_WrEn 		  <= '1'; -- Write at destination register
			RF_WrData_sel <= '0'; -- ALU out
			RF_B_sel		  <= '1'; -- I-type
			ALU_Bin_sel	  <= '1'; -- Immed 
			ALU_func		  <= "0000"; -- Addition
			MEM_WrEn 	  <= '0'; -- No mem write
			ByteFlag		  <= '0';

		-- 	 andi 	: I-type instruction
		when "110010"	=> 
			PC_sel 		  <= '0'; -- +4
			PC_LdEn 		  <= '1'; -- 
			RF_WrEn 		  <= '1'; -- Write at destination register
			RF_WrData_sel <= '0'; -- ALU out
			RF_B_sel		  <= '1'; -- I-type
			ALU_Bin_sel	  <= '1'; -- Immed
			ALU_func		  <= "0010"; -- Logical AND
			MEM_WrEn 	  <= '0'; -- No mem write
			ByteFlag		  <= '0';

		-- 	 ori 	   : I-type instruction
		when "110011"	=> 
			PC_sel 		  <= '0'; -- +4
			PC_LdEn 		  <= '1'; -- 
			RF_WrEn 		  <= '1'; -- Write at destination register
			RF_WrData_sel <= '0'; -- ALU out
			RF_B_sel		  <= '1'; -- I-type
			ALU_Bin_sel	  <= '1'; -- Immed
			ALU_func		  <= "0011"; -- Logical OR
			MEM_WrEn 	  <= '0'; -- No mem write
			ByteFlag		  <= '0';

		--      B     : I-type instruction
		when "111111" =>
			PC_sel 		  <= '1'; -- +4 + Immed
			PC_LdEn 		  <= '1'; -- 
			RF_WrEn 		  <= '0'; --
			RF_WrData_sel <= '0'; -- ALU out
			RF_B_sel		  <= '1'; -- I-type
			ALU_Bin_sel	  <= '1'; -- Immed
			ALU_func		  <= "0000"; -- DONT CARE
			MEM_WrEn 	  <= '0'; -- No mem write
			ByteFlag		  <= '0';

		--      beq	  : I-type instruction
		when "010000" =>
			PC_LdEn 		  <= '1'; -- 
			RF_WrEn 		  <= '0'; --
			RF_WrData_sel <= '0'; -- ALU out
			RF_B_sel		  <= '1'; -- I-type
			ALU_Bin_sel	  <= '0'; -- Compare RF[Rd],RF[Rs]
			ALU_func		  <= "0001"; -- sub
			MEM_WrEn 	  <= '0'; -- No mem write
			if ALU_zero = '1' then
				PC_sel <= '1'; -- +4 + Immed
			else
				PC_sel <= '0'; -- +4
			end if;
			ByteFlag		  <= '0';

		--      bne	  : I-type instruction
		when "010001" =>
			PC_LdEn 		  <= '1'; -- 
			RF_WrEn 		  <= '0'; --
			RF_WrData_sel <= '0'; -- ALU out
			RF_B_sel		  <= '1'; -- I-type
			ALU_Bin_sel	  <= '0'; -- Compare RF[Rd],RF[Rs]
			ALU_func		  <= "0001"; -- sub
			MEM_WrEn 	  <= '0'; -- No mem write
			if ALU_zero = '0' then
				PC_sel <= '1'; -- +4 + Immed
			else
				PC_sel <= '0'; -- +4
			end if;
			ByteFlag		  <= '0';

		--		  lw	  : I-type instruction
		when "001111" =>
			PC_sel 		  <= '0'; -- +4
			PC_LdEn 		  <= '1'; -- 
			RF_WrEn 		  <= '1'; -- load to register
			RF_WrData_sel <= '1'; -- MEM out
			RF_B_sel		  <= '1'; -- I-type
			ALU_Bin_sel	  <= '1'; -- Immed
			ALU_func		  <= "0000"; -- addition
			MEM_WrEn 	  <= '0'; -- No mem write
			ByteFlag		  <= '0';

		--		  sw	  : I-type instruction
		when "011111" =>
			PC_sel 		  <= '0'; -- +4
			PC_LdEn 		  <= '1'; -- 
			RF_WrEn 		  <= '0'; -- store to mem
			RF_WrData_sel <= '1'; -- MEM out
			RF_B_sel		  <= '1'; -- I-type
			ALU_Bin_sel	  <= '1'; -- Immed
			ALU_func		  <= "0000"; -- addition
			MEM_WrEn 	  <= '1'; -- No mem write
			ByteFlag		  <= '0';

		--		  lb	  : I-type instruction
		when "000011" =>
			PC_sel 		  <= '0'; -- +4
			PC_LdEn 		  <= '1'; -- 
			RF_WrEn 		  <= '1'; -- load to register
			RF_WrData_sel <= '1'; -- MEM out
			RF_B_sel		  <= '1'; -- I-type
			ALU_Bin_sel	  <= '1'; -- Immed
			ALU_func		  <= "0000"; -- addition
			MEM_WrEn 	  <= '0'; -- No mem write
			ByteFlag		  <= '1'; -- byte operation

		
			
		when others => null;
	end case;
end if;

CONTROL_OUT(15) <= PC_sel;
CONTROL_OUT(14) <= PC_LdEn;
CONTROL_OUT(13) <= RF_WrEn;
CONTROL_OUT(12) <= RF_WrData_sel;
CONTROL_OUT(11) <= RF_B_sel;
CONTROL_OUT(10) <= ALU_Bin_sel;
CONTROL_OUT(9 downto 6) <= ALU_func(3 downto 0);
CONTROL_OUT(5) <= MEM_WrEn;
CONTROL_OUT(4) <= ByteFlag;
CONTROL_OUT(3) <= IFreg_WrEn;
CONTROL_OUT(2) <= DECreg_WrEn;
CONTROL_OUT(1) <= EXECreg_WrEn;
CONTROL_OUT(0) <= MEMreg_WrEn;


end process;
end Behavioral;