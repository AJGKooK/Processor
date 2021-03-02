-------------------------------------------------------------------------
-- Mason Korkowksi
-- Thane Storley
--
--
-- CPRE 381
-- Iowa State University
-------------------------------------------------------------------------
-- FullProcessor.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation a single Cycle Mips Processor.
--				This Processor Supports the following Commands. Any command not specified will be ignored.
--				add addu sub subu and or nor xor slt sltu sll srl sra sllv srlv jr j jal beq bne addi addiu lw slti sltiu andi ori xori lui sw
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity allTheseCyclesAndNickIsStillSingle is
	
	--Add any Generics Here--
	
	--N is the width of the register--
	--A is the width of addresses--
	--C is the width of the ALU selector--
	--P is the width of the Program Counter Address--
	generic(N : integer := 32;
			A : integer := 5;
			P : integer := 10;
			C : integer := 4;
	
	
	
	
	
	--Change the ports here--
	port(
		--Inputs from the simulator--
		iRST 	:in std_logic;
		
		--Outputs to the simulator--
		oOF		:out std_logic;
	)

end allTheseCyclesAndNickIsStillSingle;




architecture \I<3Nick\ of allTheseCyclesAndNickIsStillSingle is

	--Create any 2D arrays Here--
	
	--Generate Signals Here--
	



	--Link External Components Here--
	component controlLogic
		port(
			--Inputs for the controlLogic--
			i_D_OpCode	: in std_logic_vector(A-1 downto 0);
			i_D_Function	: in std_logic_vector(A-1 downto 0);
			i_D_Overflow	: in std_logic;
			
			--Outputs for the controlLogic--
			o_RD		: out std_logic;
			o_RW		: out std_logic;
			o_MW		: out std_logic;
			o_MR		: out std_logic;
			o_AS		: out std_logic;
			o_AC		: out std_logic_vector(3 downto 0);
			o_ML		: out std_logic;
			o_B			: out std_logic;
			o_BS		: out std_logic;
			o_J			: out std_logic;
			o_RPC		: out std_logic;
			o_PCR		: out std_logic;
			o_RA		: out std_logic;
			o_O			: out std_logic;
			
		);
	end component;


	component mux2t1_32
		port(
			--Inputs for the MUX--
			i_C_S	: in std_logic;
			i_D_D0	: in std_logic_vector(N-1 downto 0);
			i_D_D1	: in std_logic_vector(N-1 downto 0);
			
			--Outputs from the MUX--
			o_D_O	: out std_logic_vector(N-1 downto 0)
		);
	end component;


	component registerFile
		port(
			--Input Vectors to the Register File--
			i_D_D	:in std_logic_vector (N-1 downto 0);
			i_A_Rd	:in std_logic_vector (A-1 downto 0);
			i_A_Rt	:in std_logic_vector (A-1 downto 0);
			i_A_Rs	:in std_logic_vector (A-1 downto 0);
		
			--Single Bit Inputs to the Register File--
			i_D_CLK	:in std_logic;
			i_D_RST	:in std_logic;
			i_D_WE	:in std_logic;
		
			--Outputs from the Register File--
			o_D_Rt	:out std_logic_vector (N-1 downto 0);
			o_D_Rs	:out std_logic_vector (N-1 downto 0)
		);
	end component;


	component instructionMemory
		port(
			--Inputs to the Instruction Memory
			i_C_CLK	: in std_logic;
			i_A_A	: in std_logic_vector((P-1) downto 0);
			i_D_D	: in std_logic_vector((N-1) downto 0);
			i_C_WE	: in std_logic;
			--Outputs from the Instruction Memory
			o_D_D	: out std_logic_vector((N-1) downto 0)
		);
	end component;


	component dataMemory
		port(
			--Inputs to the Instruction Memory
			i_C_CLK	: in std_logic;
			i_A_A	: in std_logic_vector((P-1) downto 0);
			i_D_D	: in std_logic_vector((N-1) downto 0);
			i_C_WE	: in std_logic;
			--Outputs from the Instruction Memory
			o_D_D	: out std_logic_vector((N-1) downto 0)
		);
	end component;


	component programCountRegister
		port(
			--Inputs to the program counter--
			i_D_D	:in std_logic_vector (N-1 downto 0);
			i_D_RST	:in std_logic;
			i_D_CLK	:in std_logic;
			i_D_WE	:in std_logic;
			--Outputs from the program counter--
			o_D_Q	:out std_logic_vector (N-1 downto 0)
		);
	end component;


	component signExtender
		port(
			--Inputs to the signExtender--
			i_D_D0 : in std_logic_vector(15 downto 0);
			--Outputs from the signExtender--
			o_D_D0 : out std_logic_vector(31 downto 0)
		);
	end component;


	component adder32bit
		port(
			--Inputs to the NbitAdder--
			i_D_X	:in std_logic_vector (N-1 downto 0);
			i_D_Y	:in std_logic_vector (N-1 downto 0);
			i_D_C	:in std_logic;
		
			--Outputs from the Adder--
			o_D_S	:out std_logic_vector (N-1 downto 0);
			o_D_C	:out std_logic
		);
	end component;


	component shift32_left
		port(
			--Inputs to the Shifter--
			i_D_D	:in std_logic_vector (N-1 downto 0);
			i_D_S	:in std_logic_vector (A-1 downto 0);
			
			--Outputs from the Shifter--
			o_D_D	:out std_logic_vector (N-1 downto 0)
			
		);
	end component;


	component ALU
		port(
		
		);
	end component;


	component singleAnd
		port(
			--Inputs to the And Gate--
			i_D_A	: in std_logic;
			i_D_B	: in std_logic;
			--Output from the And Gate--
			o_D_F	: out std_logic
		);
	end component;


	component singleNot
		port(
			--Input to the Not Gate--
			i_D_A	: in std_logic;
			--Output from the Not Gate--
			o_D_F : out std_logic
		);
	end component;	



end \I<3Nick\;



















































